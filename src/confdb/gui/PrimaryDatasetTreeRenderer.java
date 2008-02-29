package confdb.gui;

import javax.swing.*;
import javax.swing.tree.*;
import java.awt.*;

import confdb.data.*;


/**
 * PrimaryDatasetTreeRenderer
 * --------------------------
 * @author Philipp Schieferdecker
 */
class PrimaryDatasetTreeRenderer extends DefaultTreeCellRenderer
{
    //
    // member data
    //

    /** selected node */
    private Object node = null;
    
    /** reference to the tree model */
    private PrimaryDatasetTreeModel treeModel = null;
    
    /** primary dataset icon */
    private ImageIcon datasetIcon = null;
    
    /** path icon */
    private ImageIcon pathIcon = null;
    

    //
    // construction
    //
    
    /** standard constructor */
    public PrimaryDatasetTreeRenderer()
    {
	super();
	datasetIcon =
	    new ImageIcon(getClass().getResource("/PrimaryDatasetIcon.png"));
	pathIcon    = new ImageIcon(getClass().getResource("/PathIcon.png"));
    }
    
    
    //
    // member functions
    //
    
    /** prepare the appropriate icon */
    public Icon prepareIcon()
    {
	if (node==null||node.equals(treeModel.getRoot())) return null;
	else if (node instanceof PrimaryDataset) return datasetIcon;
	else if (node instanceof Path)           return pathIcon;
	return null;
    }
    
    /** prepare the appropriate text */
    public String prepareText()
    {
	String result = getText();
	if (node==treeModel.getRoot()) {
	    result = "<html><b>"+result+"</b></html>";
	}
	else if (node instanceof PrimaryDataset) {
	    PrimaryDataset dataset = (PrimaryDataset)node;
	    int    count  = dataset.pathCount();
 	    result = (count>0) ?
		"<html><b>"+dataset+"</b> ("+count+")</html>":
		"<html>"+dataset+" ("+count+")</html>";
	}
	return result;
    }
    
    /** get the leaf icon, for editing */
    public Icon getLeafIcon() { return prepareIcon(); }
    
    /** get the leaf icon, for editing */
    public Icon getOpenIcon() { return prepareIcon(); }
    
    /** get the leaf icon, for editing */
    public Icon getClosedIcon() { return prepareIcon(); }
    
    /** TreeCellRenderer interface, overwrite Default implementation */
    public Component getTreeCellRendererComponent(JTree   tree,
						  Object  value,
						  boolean sel,
						  boolean expanded,
						  boolean leaf,
						  int     row,
						  boolean hasFocus)
    {
	if (treeModel == null)
	    treeModel = (PrimaryDatasetTreeModel)tree.getModel();
	
	super.getTreeCellRendererComponent(tree,value,sel,
					   expanded,leaf,row,
					   hasFocus);
	node = value;
	setIcon(prepareIcon());
	setText(prepareText());
	return this;
    }
    
}