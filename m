Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5838550F
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657827; cv=none; b=Rykgt6/tWEILMa32puycJdxFgvGdaUsFV9TX7ueGLDO+ACfn3/PBEgSQdMGVBZb/vP1m16U2cfwRc15MKuQDJyQqBR/PZHt9wD08Cx9xKOEV70DVuTWLoba7GDRqk9LZjCu0uhf+1DFqZ4mANGOYWqKA08AvU8/YJf06EFsDvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657827; c=relaxed/simple;
	bh=RxL6z+zw2hb3Ua992HMj+evwFuDxGd2pG925AkelRHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXS0CjmdlMjZrq854oIoaVQ22om60c9hGKCDN/DESry+dRtFfosR5cuw6IGmJOomQ4LY0Dw4uoKoyX7ddBauxs/kQGtG2k4JH7WUzfZMCPIU7j0EruLQpuuZSasyVE5Zv42jIjkbyuW6RL9cKRVMFhiqdCly4CORfx4RxIvcDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=nlxsExgV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="nlxsExgV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50697d6a69cso37280551cf.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 12:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772657822; x=1773262622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNKFyABXShuPhoG46GCIz5GpmBHUYu/gn8UQCtzbQzk=;
        b=nlxsExgVl9btCZmln9Wm53dA7Y7RqbGeM9XH9C6GaFp6p4Gm0G8FxZnbx+RCHCALja
         r8FIltHBUJ/jrigcPMRInBdPx17QrWUf/kKU8BMMhhiMoMyb4LMF1DX4/pkgBX3lL2XQ
         TpEC9R7Agfn9bTQBnp58uUsNB2lPy2OSRFk5JIhzDtJLs47HsLUFhmxwz0PH6a1EygUv
         HZN7vOjUomSwXcsOYAUGLxJqJd5Zu0T6em5B/4fuQ6RGTBsuV913fU4p0yUY0r2eTCr0
         HKAmuDgudex/HbR4wheWZrET4/+1jFCGphJQkYaVROl9Sa09fEDTlWvACYFHdEkgLxRA
         W0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657822; x=1773262622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNKFyABXShuPhoG46GCIz5GpmBHUYu/gn8UQCtzbQzk=;
        b=qXaMuUSCI0hJ20med17cyAc8VjAyLTjzqvlfVFSjbnpQgB5JBf4oWWtFXkeBTY6M05
         IhyDrNoozMhYImfPTgd1niUaIJfQriM58oxbSUaLMc00TbFlhuiNK05Y/12G0/yDQv2j
         KH+xOlRfz5Q3H3fpq3oJ9HNkc+M4hXe9K44+XXsDvYk/tkhDmkjzpm0qaopHzUMFNdGH
         hsHqHLB5VuXj6/ore1AHqid3sIStZyCQL3sI7EGAWV7NCSDzZ0u3HXOwOLJQHRyH35bb
         qBzVQw/f56mLvbuP1a2cZLh6h9pukPJz9ESalP1pmnlDVwTgC4fJhFscbAHXYzOKNgCv
         RvXw==
X-Gm-Message-State: AOJu0Yx5fKCw1QghBmOuP0/FwO+l12iHNxdBQBFUiStl7HWUgMPwhb1K
	XnL59DwMxpbJ/dod47DTj5AB3il7OrFWvvz8D28Gd8jPbohkwvRGjvTs/Roh5zhBB87GEQxANP3
	kQgPJBFn6Kg==
X-Gm-Gg: ATEYQzxCS4BZa6oo8oFm3iKE8mMiijnjTghbRbCRTzOMu932Rqvej8RoC+qx4uSB03Q
	niAwD3XC7fWVX13UwIqXmIwOSmgA2XFQIPyB/nBB1jJaZdEEIhBwy+XmLG7E7tUmG7I8Sok9kbX
	gcC6PE7Awheu/vfEn5nQOQbQeKdxR14TOka6LRdPylyMlS2NtQNTiDMsGfqg+VVDpy8XtjRiUOZ
	J+bhFhSscvgvRfAdTu4X0dPlw1PvShf+8kwGdKGdWPInLx55UBKSMApQEHPu/kejEWor7Di+wY8
	QUYRQVNblQjIxQE5YqO/QLbNSzJTEPpdTouuJZoYi1XeR72i+iQPnQvXSOF/8GivmUWVJLTYr84
	6OsgSwxKb0BhoqfhckN8w5YnVrfpCZWfz65J1GUs/BOUq0vHLKswxhUkTffeYKC6mRna9YerctB
	tBpW7ngurhRFVJF3+oTvK9JjnHsg==
X-Received: by 2002:a05:622a:202:b0:4ee:4512:4a24 with SMTP id d75a77b69052e-508db3eb4c5mr47075691cf.72.1772657821581;
        Wed, 04 Mar 2026 12:57:01 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744aef9e0sm155296601cf.30.2026.03.04.12.57.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:57:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v6 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Wed,  4 Mar 2026 15:56:51 -0500
Message-ID: <b19c2760ffe48cec546dd3810d237f8cad20d606.1772657690.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772657690.git.josef@toxicpanda.com>
References: <cover.1772657690.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for specifying multiple file sources in 'bpftool btf dump'
to generate a single C header containing types from vmlinux plus
multiple kernel modules:

  bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 format c

This is useful for BPF programs that need to access types defined in
kernel modules. Previously this required a separate bpftool invocation
for each module, producing separate headers that could not be combined
due to overlapping vmlinux type definitions.

The implementation collects all file paths, then for the multi-file
case creates an empty split BTF on the vmlinux base and iteratively
merges each module's types into it via btf__add_btf(). The single-file
code path is preserved exactly to avoid any regression risk.

Auto-detection of vmlinux as the base BTF from sysfs paths works as
before. If vmlinux itself appears in the file list it is skipped with
a warning since its types are already provided by the base.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   6 +-
 tools/bpf/bpftool/btf.c                       | 132 ++++++++++++++++--
 3 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index d47dddc2b4ee..cf75a7fa2d6b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -27,7 +27,7 @@ BTF COMMANDS
 | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
 | **bpftool** **btf help**
 |
-| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
+| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* [**file** *FILE*]... }
 | *FORMAT* := { **raw** | **c** [**unsorted**] }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
@@ -58,9 +58,12 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     When **prog** is provided, it's expected that program has associated BTF
     object with BTF types.
 
-    When specifying *FILE*, an ELF file is expected, containing .BTF section
-    with well-defined BTF binary format data, typically produced by clang or
-    pahole.
+    When specifying *FILE*, an ELF file or a raw BTF file (e.g. from
+    ``/sys/kernel/btf/``) is expected.  Multiple **file** arguments may be
+    given to merge BTF from several kernel modules into a single output.
+    When sysfs paths are used, vmlinux BTF is loaded automatically as the
+    base; if vmlinux itself appears in the file list it is skipped.
+    A base BTF can also be specified explicitly with **-B**.
 
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported. With C-style
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28f0cc522e4..babb0d4e9753 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -961,10 +961,14 @@ _bpftool()
                         *)
                             # emit extra options
                             case ${words[3]} in
-                                id|file)
+                                id)
                                     COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                     _bpftool_once_attr 'format'
                                     ;;
+                                file)
+                                    COMPREPLY=( $( compgen -W "root_id file" -- "$cur" ) )
+                                    _bpftool_once_attr 'format'
+                                    ;;
                                 map|prog)
                                     if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                         COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..c44e86a64760 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -28,6 +28,7 @@
 #define FASTCALL_DECL_TAG	"bpf_fastcall"
 
 #define MAX_ROOT_IDS		16
+#define MAX_BTF_FILES		64
 
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
@@ -878,6 +879,49 @@ static bool btf_is_kernel_module(__u32 btf_id)
 	return btf_info.kernel_btf && strncmp(btf_name, "vmlinux", sizeof(btf_name)) != 0;
 }
 
+static struct btf *merge_btf_files(const char **files, int nr_files,
+				   struct btf *vmlinux_base)
+{
+	struct btf *combined, *mod;
+	int ret;
+
+	combined = btf__new_empty_split(vmlinux_base);
+	if (!combined) {
+		p_err("failed to create combined BTF: %s",
+		      strerror(errno));
+		return NULL;
+	}
+
+	for (int j = 0; j < nr_files; j++) {
+		mod = btf__parse_split(files[j], vmlinux_base);
+		if (!mod) {
+			p_err("failed to load BTF from %s: %s",
+			      files[j], strerror(errno));
+			btf__free(combined);
+			return NULL;
+		}
+
+		ret = btf__add_btf(combined, mod);
+		btf__free(mod);
+		if (ret < 0) {
+			p_err("failed to merge BTF from %s: %s",
+			      files[j], strerror(-ret));
+			btf__free(combined);
+			return NULL;
+		}
+	}
+
+	ret = btf__dedup(combined, NULL);
+	if (ret) {
+		p_err("failed to dedup combined BTF: %s",
+		      strerror(-ret));
+		btf__free(combined);
+		return NULL;
+	}
+
+	return combined;
+}
+
 static int do_dump(int argc, char **argv)
 {
 	bool dump_c = false, sort_dump_c = true;
@@ -958,20 +1002,83 @@ static int do_dump(int argc, char **argv)
 		NEXT_ARG();
 	} else if (is_prefix(src, "file")) {
 		const char sysfs_prefix[] = "/sys/kernel/btf/";
+		struct btf *vmlinux_base = base_btf;
+		const char *files[MAX_BTF_FILES];
+		int nr_files = 0;
 
-		if (!base_btf &&
-		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
-		    strcmp(*argv, sysfs_vmlinux) != 0)
-			base = get_vmlinux_btf_from_sysfs();
-
-		btf = btf__parse_split(*argv, base ?: base_btf);
-		if (!btf) {
-			err = -errno;
-			p_err("failed to load BTF from %s: %s",
-			      *argv, strerror(errno));
-			goto done;
+		/* First grab our argument, filtering out the sysfs_vmlinux. */
+		if (strcmp(*argv, sysfs_vmlinux) != 0) {
+			files[nr_files++] = *argv;
+		} else {
+			p_info("skipping %s (will be loaded as base)",
+			       *argv);
 		}
 		NEXT_ARG();
+
+		while (argc && is_prefix(*argv, "file")) {
+			NEXT_ARG();
+			if (!REQ_ARGS(1)) {
+				err = -EINVAL;
+				goto done;
+			}
+			/* Filter out any sysfs vmlinux entries. */
+			if (strcmp(*argv, sysfs_vmlinux) == 0) {
+				p_info("skipping %s (will be loaded as base)",
+				       *argv);
+				NEXT_ARG();
+				continue;
+			}
+			if (nr_files >= MAX_BTF_FILES) {
+				p_err("too many BTF files (max %d)",
+				      MAX_BTF_FILES);
+				err = -E2BIG;
+				goto done;
+			}
+			files[nr_files++] = *argv;
+			NEXT_ARG();
+		}
+
+		/* Auto-detect vmlinux base if any file is from sysfs */
+		if (!vmlinux_base) {
+			for (int j = 0; j < nr_files; j++) {
+				if (strncmp(files[j], sysfs_prefix,
+					    sizeof(sysfs_prefix) - 1) == 0) {
+					base = get_vmlinux_btf_from_sysfs();
+					vmlinux_base = base;
+					break;
+				}
+			}
+		}
+
+		/* All files were the sysfs_vmlinux, handle it like we used to */
+		if (nr_files == 0) {
+			nr_files = 1;
+			files[0] = sysfs_vmlinux;
+		}
+
+		if (nr_files == 1) {
+			btf = btf__parse_split(files[0],
+					       base ?: base_btf);
+			if (!btf) {
+				err = -errno;
+				p_err("failed to load BTF from %s: %s",
+				      files[0], strerror(errno));
+				goto done;
+			}
+		} else {
+			if (!vmlinux_base) {
+				p_err("base BTF is required when merging multiple BTF files; use -B/--base-btf or use sysfs paths");
+				err = -EINVAL;
+				goto done;
+			}
+
+			btf = merge_btf_files(files, nr_files,
+					      vmlinux_base);
+			if (!btf) {
+				err = -errno;
+				goto done;
+			}
+		}
 	} else {
 		err = -1;
 		p_err("unrecognized BTF source specifier: '%s'", src);
@@ -1445,7 +1552,8 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
 		"       %1$s %2$s help\n"
 		"\n"
-		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
+		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] |\n"
+		"                    file FILE [file FILE]... }\n"
 		"       FORMAT  := { raw | c [unsorted] }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
-- 
2.53.0

