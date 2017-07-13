﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34014
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Monahrq.Sdk.Generators {
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
    public class PublishWebsiteResources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal PublishWebsiteResources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Monahrq.Sdk.Generators.PublishWebsiteResources", typeof(PublishWebsiteResources).Assembly);
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
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website &quot;{0}&quot; publish generation completed.
        /// </summary>
        public static string GenerationCompleted {
            get {
                return ResourceManager.GetString("GenerationCompleted", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to There was an error that occurred while generating website &quot;{0}&quot;. Error Message: {1}.
        /// </summary>
        public static string GenerationError {
            get {
                return ResourceManager.GetString("GenerationError", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website &quot;{0}&quot; publish generation in progress.
        /// </summary>
        public static string GenerationInProgress {
            get {
                return ResourceManager.GetString("GenerationInProgress", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website output directory &quot;{0}&quot; has been successfully created.
        /// </summary>
        public static string GenerationOutputDirectoryCreated {
            get {
                return ResourceManager.GetString("GenerationOutputDirectoryCreated", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website output directory &quot;{0}&quot; has been successfully deleted..
        /// </summary>
        public static string GenerationOutputDirectoryDeleted {
            get {
                return ResourceManager.GetString("GenerationOutputDirectoryDeleted", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website output directory &quot;{0}&quot; exists already. Getting ready to delete and recreate..
        /// </summary>
        public static string GenerationOutputDirectoryExists {
            get {
                return ResourceManager.GetString("GenerationOutputDirectoryExists", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Generation of website theme files completed.
        /// </summary>
        public static string GenerationThemeEnd {
            get {
                return ResourceManager.GetString("GenerationThemeEnd", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Initializing generation of website theme files.
        /// </summary>
        public static string GenerationThemeStart {
            get {
                return ResourceManager.GetString("GenerationThemeStart", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Website content file generation complete.
        /// </summary>
        public static string GenerationWebsiteContentEnd {
            get {
                return ResourceManager.GetString("GenerationWebsiteContentEnd", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Initializing website content file generation..
        /// </summary>
        public static string GenerationWebsiteContentStart {
            get {
                return ResourceManager.GetString("GenerationWebsiteContentStart", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The website {0} image saved to the following path &quot;{1}&quot;..
        /// </summary>
        public static string ImageGenerated {
            get {
                return ResourceManager.GetString("ImageGenerated", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Reports have been successfully completed..
        /// </summary>
        public static string ReportsGenerationCompleted {
            get {
                return ResourceManager.GetString("ReportsGenerationCompleted", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Initializing Report Generation..
        /// </summary>
        public static string ReportsGenerationStart {
            get {
                return ResourceManager.GetString("ReportsGenerationStart", resourceCulture);
            }
        }
    }
}