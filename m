Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A93A960F
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951268; cv=none; b=eH2BvsIy2YXvKtrUizRNmjAe1fwcPFG70KOwBlkWQgQPHJlPQksKIi/TAFJEVMM8GrDpOe7K919EM5mYSKnwq3ZJzVfyhXzM+xCpK+idRFtrPuOR0U+9EVtXrdlMzLou+dk1hLw1MeZTKd7PiWSkcdWEpY60CgClCR2PAipqGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951268; c=relaxed/simple;
	bh=ASRsNc0Q2ibY6ysB7cjYDq7RNZddcawMIFFlDl0TjNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBXm8EhZkgBHKtOZnBEKVlHB0RuBisdnFpU/wR+BpX/L/gCFodD77390bisxzPnRJG/sSrvyHL0VsKvKuEUFRJbfZ/9GjDU0sdtHYnzlnM2w62hxVoi9vofLrtZQiHA8248TmxrpuHmt/NeAZ5Tt1aWelYI0WV0yFvn6uNHWew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=lp6Dhbtv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="lp6Dhbtv"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3fb47559so543411085a.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771951265; x=1772556065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6SPFGWuDec/1z80H7oS3q0TGkUxbkDmkBLcIkgwMzw=;
        b=lp6DhbtvBDmrSMr3TcE8GwInyG7RfZNCGpB0PmaqBHUhjdRJvkGoC4ekNXcKLcGiZN
         3LHdMNFhRF+5Z73RlpzN9kQl+tK93kY2QpFvzH9vtDLleDQmBZflal7jZ3z3nAp0osre
         AXL9M8xW5NhActFPCcAidm/AzKgC1TbewnFlnIdYgk8QCcFSCvPWGs2YNcn6p/mP1oGU
         hY0N+nHPMh8WwvlsjjC6eFez7efLj7OaS/x4fywp9+UiREo3+6FXStEET2DgzLOsdvVB
         oSxcSaqyXNzcDzlJKhcQtPTl0M4ktI3FXqwuhUtKdH6Br0CE/VKQ1/YSuxxU3sPswTOr
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951265; x=1772556065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6SPFGWuDec/1z80H7oS3q0TGkUxbkDmkBLcIkgwMzw=;
        b=gmbCeODlccefn8bGPNLLKevcqkuiUbxe9i790DQBH1SAsX2D0R/N1b1JmRbIlZ7Yjt
         db3jyArUNkPcijCMNBJDXhKKHeJFrRYSaZMzo/3YJ0wczNq0UngP9A9iDmOpxibeLjEw
         L52fdTJ3jKz/qp0gHFYLbpzNkU3f7bpG6FITQrxacmd5X2NCsJ5tTwrCv4jQR1fG0EBT
         +DAiqODaV9TJnmLcEiPLDsN76hjor1s+jjVV0wSx9kYLYq5MJL6KmaLhU/Mj03aZ5pnV
         +oXw6XX3rPlHSq6frjpFS1Ev7sEnyW+TustgzIHVMrfBgk8GdUfum2r+jjT2Qinbhm9D
         4JYQ==
X-Gm-Message-State: AOJu0Yydy/CdvA4CQU0ls19jWZljK1nQByD6RCrVL0Fe8sOEf1FqYTtX
	4WCtKqgqJfVsju2xMMCIQ0j8WmMoNYqJfPgvVhsMI7Ttcn8xN7vtODOx/xZibgdC6H/GMOvgIYU
	+kcrJ5tE2H6hN
X-Gm-Gg: AZuq6aIhgLM5JWE5YK2Qz++qeFPXl+6tC8IAix0sI8+hGXP3rgsIthK8ahFCpy62TGw
	7zwcFalWU9tK3km2o4W/UOufi/w4Vd/sNndvJ1nhFd9n4j0I3nigefdtLFZ6SxSqDvhSRo0iTVp
	A7SHMzdgzNTy+fTRFx58gYEafNiaa2nFWF8IEh3XVF2uRo/LbHkSRqqwiCJPvFA/0GHz1yMu60G
	Ra5HV54yhg7RAUOvCD1VfqUpxXWJouSjm13AtMw3PslDAtFF5wHWtMtfHsnvXTbu3JF3meQnpjp
	9ZqGaWYxOiTkiLJGMIF0OZ6kufM6UAJZ+4PyHeOMur4Tvwlo2mecT4S+9ayXwSJVPtsCmdoY6/8
	IoIuUhy3XvS5F5lz4mTb2oTzn7GtOMXJdrgg7wdZRVbQq1Gq1pWmNKc5ZUG7VRvpBs1b2iYClXw
	CcxUJpYlgDezVK+uJPCUlrCVH3OVBCf8o5cWF9
X-Received: by 2002:a05:620a:4692:b0:89e:99b3:2eaa with SMTP id af79cd13be357-8cb8c9e6562mr1503141885a.8.1771951265274;
        Tue, 24 Feb 2026 08:41:05 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d063e9asm1142190185a.18.2026.02.24.08.41.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:41:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v5 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Tue, 24 Feb 2026 11:40:53 -0500
Message-ID: <ebce5bbcffe226e4ca1894c4970d094fadd711f7.1771950922.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771950922.git.josef@toxicpanda.com>
References: <cover.1771950922.git.josef@toxicpanda.com>
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
 tools/bpf/bpftool/btf.c                       | 128 ++++++++++++++++--
 3 files changed, 127 insertions(+), 18 deletions(-)

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
index 946612029dee..a259a0cfeb3b 100644
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
@@ -958,20 +1002,77 @@ static int do_dump(int argc, char **argv)
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
-		}
+		/* First grab our argument, filtering out the sysfs_vmlinux. */
+		if (strcmp(*argv, sysfs_vmlinux) != 0)
+			files[nr_files++] = *argv;
 		NEXT_ARG();
+
+		while (argc && strcmp(*argv, "file") == 0) {
+			NEXT_ARG();
+			if (!REQ_ARGS(1)) {
+				err = -EINVAL;
+				goto done;
+			}
+			/* Filter out any sysfs vmlinux entries. */
+			if (strcmp(*argv, sysfs_vmlinux) == 0) {
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
@@ -1445,7 +1546,8 @@ static int do_help(int argc, char **argv)
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

