﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18051
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Monahrq.DataSets.ViewModels.MappingSummary {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class ReportConstants {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal ReportConstants() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Monahrq.DataSets.ViewModels.MappingSummary.ReportConstants", typeof(ReportConstants).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to body {
        ///    font-family: Arial, Helvetica, sans-serif;
        ///    width: 7in;
        ///    overflow: scroll;
        ///}
        ///
        ///div.title {
        ///    font-size: 1.2em;
        ///    font-weight: bold;
        ///}
        ///
        ///div.description {
        ///    font-style: italic;
        ///    font-size: .9em;
        ///    color: blue;
        ///}
        ///
        ///table.statistics,
        ///table.variables {
        ///    position: relative;
        ///    top: 10px;
        ///}
        ///
        ///table.statistics {
        ///    margin-bottom: 10px;
        ///}
        ///
        ///    table.statistics tbody {
        ///        font-size: .9em;
        ///    }
        ///
        /// table.statistics tbody td{
        ///        padding: 1px 5px 1px [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string Css {
            get {
                return ResourceManager.GetString("Css", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to MONAHRQ data element.
        /// </summary>
        internal static string ElementHeader {
            get {
                return ResourceManager.GetString("ElementHeader", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Element position in your file.
        /// </summary>
        internal static string OrdinalHeader {
            get {
                return ResourceManager.GetString("OrdinalHeader", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to This report summarizes the Data Mapping between the input file and the MONAHRQ Dataset that you have assigned on the previous screen. Certain variables are required to continue with the data analysis. See the Host User Guide for more detailed information..
        /// </summary>
        internal static string ReportDescription {
            get {
                return ResourceManager.GetString("ReportDescription", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Mapping Summary.
        /// </summary>
        internal static string ScreenTitle {
            get {
                return ResourceManager.GetString("ScreenTitle", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Input file data element.
        /// </summary>
        internal static string SourceHeader {
            get {
                return ResourceManager.GetString("SourceHeader", resourceCulture);
            }
        }
    }
}