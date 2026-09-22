Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344ED3403E8;
	Tue, 22 Sep 2026 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045730; cv=none; b=IuIVxt8LmXhmbwJQraLOYTWD/BD1etKQibSSjf9HSMGbQEWivPQ0ZlaNps8BMTl97LPnFB/4L6bARJ6D+mH6qvvxiAjbYcs02OendXc4D4NmFZr4mK4BlGlgrYETxx96P1NLbz8FMmSo9vVkswpfYcYwK+UUb0kus771wA4X4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045730; c=relaxed/simple;
	bh=hK7dnz1fNm88X0+jYTY2ejo9vM/95ELnAQpFUBTeMt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0zN5ZVnHtBQl9QBwrlatoBd9nprwCutJhgL6tf2dAogPUWCT/z29tGvvGxCSG90Ypq8v9u3NTJex6gs7eh6mUtZ/vZZxMeLkMimAXcaAKJexbcMCx6xtS5M5Pvhao/PXefMPhbWth/1goNrS1pWT8XLogSidf8GScEXJ4awPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J4Aphnuh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J4Aphnuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ec
	P5t7ttauiOdWWIApxVQOiSA4P1UHFyxmZ+YpcJYfc=; b=J4AphnuhfyBUSRdBLC
	ynguUWmRdK1MFqgGH5eEYYcKAFpDhh1c5gWGhSOL36uXJFHpHJjxrd+kCGsGkabf
	m4s65EGHSoIfOozGJoJia+6GPYEh3rlCFUt6aeaDY9GFtQElEoLj2qSL8uGk2RFR
	/B7SgK/EGj1MZtu1190g6k7Lg=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3DGn27bFqwKviAg--.7291S2;
	Tue, 22 Sep 2026 10:54:47 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v3 3/3] bpftool: Add support for BPF_F_PREORDER cgroup attach flag
Date: Tue, 22 Sep 2026 11:54:42 +0900
Message-ID: <20260922025442.3176057-4-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922025442.3176057-1-sh_def@163.com>
References: <20260922025442.3176057-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3DGn27bFqwKviAg--.7291S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cw4kJr4DCw4DAryfKr13CFg_yoWkGw1DpF
	4kXa4jk3W8W3sxWw48G3yYgrWrKrs7WF1UCF98Jry5uFW3Ww1vyrWSkFWrurn8XFWxAw40
	vF4Yvr15WF1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhe-H2qx7feniAAA3b

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request pre-order execution across the
cgroup hierarchy. Furthermore, attachments legitimately use combinations
such as BPF_F_ALLOW_MULTI | BPF_F_PREORDER or
BPF_F_ALLOW_OVERRIDE | BPF_F_PREORDER.

With BPF_PROG_QUERY reporting the per-program BPF_F_PREORDER attribute,
bpftool's exact-match formatter falls back to "unknown(40)" when
BPF_F_PREORDER is present alone, or "unknown(41)" / "unknown(42)" when
combined with BPF_F_ALLOW_OVERRIDE or BPF_F_ALLOW_MULTI. Additionally,
do_attach() only accepts "multi" and "override", rejecting "preorder"
with "unknown option".

Before:
  $ bpftool cgroup show <cg>
  1234  cgroup_inet_ingress  unknown(42)  test_prog
  $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
  Error: unknown option: preorder

After:
  $ bpftool cgroup show <cg>
  1234  cgroup_inet_ingress  multi,preorder  test_prog
  $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
  (attaches successfully)

Refactor the attach flags formatter into a bitmask formatter that outputs
comma-separated flag names for plain text while preserving unrecognized
bits as "unknown(...)". Render attach flags as an array of flag names in
JSON output. Accept "preorder" in do_attach(), update the cgroup
documentation and synopsis to express valid flag combinations, and teach
bash completion about them ("multi" or "override" optionally combined
with "preorder").

Signed-off-by: Hui Su <sh_def@163.com>
---

Notes (bpf-preorder-v3-20260922-check):
    Testing:
    - PASS: make -C tools/bpf/bpftool -j12 (fresh after rebase).
    - PASS: make -C tools/bpf/bpftool/Documentation -j12 (fresh after rebase).
    - PASS: bash -n tools/bpf/bpftool/bash-completion/bpftool (fresh after rebase).
    - PASS: bpftool cgroup plain-text and JSON runtime smoke (x86_64 QEMU/KVM); result reused after a content-equivalent rebase.
    - PASS: scripts/checkpatch.pl on the generated v3 patches.

 .../bpftool/Documentation/bpftool-cgroup.rst  | 25 +++--
 tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
 tools/bpf/bpftool/cgroup.c                    | 99 +++++++++++++------
 3 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index e8185596a759..d1b8193dc576 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -45,7 +45,7 @@ CGROUP COMMANDS
 |     **cgroup_unix_recvmsg** | **cgroup_sysctl** |
 |     **cgroup_getsockopt** | **cgroup_setsockopt** |
 |     **cgroup_inet_sock_release** }
-| *ATTACH_FLAGS* := { **multi** | **override** }
+| *ATTACH_FLAGS* := { [ **multi** | **override** ] [ **preorder** ] }
 
 DESCRIPTION
 ===========
@@ -75,20 +75,27 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
     Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
     and optional *ATTACH_FLAGS*.
 
-    *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs some
+    *ATTACH_FLAGS* can include: **override** if a sub-cgroup installs some
     bpf program, the program in this cgroup yields to sub-cgroup program;
     **multi** if a sub-cgroup installs some bpf program, that cgroup program
-    gets run in addition to the program in this cgroup.
+    gets run in addition to the program in this cgroup;
+    **preorder** requests ancestor-to-descendant execution for this program,
+    before non-preorder programs, which execute descendants-to-ancestors
+    across the cgroup hierarchy. Note that **preorder** alone does not enable
+    multi-program attachment; specify **multi** together with **preorder** to
+    attach multiple programs.
 
-    Only one program is allowed to be attached to a cgroup with no attach flags
-    or the **override** flag. Attaching another program will release old
-    program and attach the new one.
+    Only one program is allowed to be attached to a cgroup unless the
+    **multi** flag is specified. Without **multi**, attaching another program
+    replaces the existing program, provided the **override** setting matches.
 
     Multiple programs are allowed to be attached to a cgroup with **multi**.
-    They are executed in FIFO order (those that were attached first, run
-    first).
+    Programs marked with **preorder** are placed before non-preorder programs
+    in the effective program array. Within each ordering class at the same
+    cgroup level, attachment order is preserved.
 
-    Non-default *ATTACH_FLAGS* are supported by kernel version 4.14 and later.
+    **multi** and **override** are supported by kernel version 4.14 and later.
+    **preorder** was introduced upstream in Linux 6.15.
 
     *ATTACH_TYPE* can be one of:
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index c9e8761e4ef2..9d9ced270685 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1064,7 +1064,6 @@ _bpftool()
                 attach|detach)
                     local BPFTOOL_CGROUP_ATTACH_TYPES="$(bpftool feature list_builtins attach_types 2>/dev/null | \
                         grep '^cgroup_')"
-                    local ATTACH_FLAGS='multi override'
                     # Check for $prev = $command first
                     if [ $prev = $command ]; then
                         _filedir
@@ -1094,7 +1093,8 @@ _bpftool()
                                 # "id|pinned|tag|name" (we already checked for
                                 # that). This should only leave the case when
                                 # we need attach flags for "attach" commamnd.
-                                _bpftool_one_of_list "$ATTACH_FLAGS"
+                                _bpftool_one_of_list 'multi override'
+                                _bpftool_once_attr 'preorder'
                             fi
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ce69d1e5468e..fee1a260f6d1 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -56,7 +56,7 @@ static const int cgroup_attach_types[] = {
 };
 
 #define HELP_SPEC_ATTACH_FLAGS						\
-	"ATTACH_FLAGS := { multi | override }"
+	"ATTACH_FLAGS := { [ multi | override ] [ preorder ] }"
 
 #define HELP_SPEC_ATTACH_TYPES						\
 	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
@@ -138,11 +138,69 @@ static void guess_vmlinux_btf_id(__u32 attach_btf_obj_id)
 	close(fd);
 }
 
+static const struct {
+	__u32 flag;
+	const char *name;
+} attach_flag_names[] = {
+	{ BPF_F_ALLOW_MULTI, "multi" },
+	{ BPF_F_ALLOW_OVERRIDE, "override" },
+	{ BPF_F_PREORDER, "preorder" },
+};
+
+static const char *format_attach_flags(__u32 flags, char *buf, size_t sz)
+{
+	size_t len = 0;
+	size_t i;
+	int n;
+
+	buf[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(attach_flag_names); i++) {
+		if (flags & attach_flag_names[i].flag) {
+			n = snprintf(buf + len, sz - len, "%s%s",
+				     len ? "," : "", attach_flag_names[i].name);
+			if (n < 0 || (size_t)n >= sz - len)
+				return buf;
+			len += n;
+			flags &= ~attach_flag_names[i].flag;
+		}
+	}
+
+	if (flags)
+		snprintf(buf + len, sz - len, "%sunknown(%x)",
+			 len ? "," : "", flags);
+
+	return buf;
+}
+
+static void show_attach_flags_json(__u32 flags)
+{
+	char buf[32];
+	size_t i;
+
+	jsonw_name(json_wtr, "attach_flags");
+	jsonw_start_array(json_wtr);
+
+	for (i = 0; i < ARRAY_SIZE(attach_flag_names); i++) {
+		if (!(flags & attach_flag_names[i].flag))
+			continue;
+
+		jsonw_string(json_wtr, attach_flag_names[i].name);
+		flags &= ~attach_flag_names[i].flag;
+	}
+
+	if (flags) {
+		snprintf(buf, sizeof(buf), "unknown(%x)", flags);
+		jsonw_string(json_wtr, buf);
+	}
+
+	jsonw_end_array(json_wtr);
+}
+
 static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
-			 const char *attach_flags_str,
-			 int level)
+			 __u32 attach_flags, int level)
 {
 	char prog_name[MAX_PROG_FULL_NAME];
+	char attach_flags_str[64];
 	const char *attach_btf_name = NULL;
 	struct bpf_prog_info info = {};
 	const char *attach_type_str;
@@ -182,7 +240,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		else
 			jsonw_uint_field(json_wtr, "attach_type", attach_type);
 		if (!(query_flags & BPF_F_QUERY_EFFECTIVE))
-			jsonw_string_field(json_wtr, "attach_flags", attach_flags_str);
+			show_attach_flags_json(attach_flags);
 		jsonw_string_field(json_wtr, "name", prog_name);
 		if (attach_btf_name)
 			jsonw_string_field(json_wtr, "attach_btf_name", attach_btf_name);
@@ -198,7 +256,9 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		if (query_flags & BPF_F_QUERY_EFFECTIVE)
 			printf(" %-15s", prog_name);
 		else
-			printf(" %-15s %-15s", attach_flags_str, prog_name);
+			printf(" %-17s %-15s",
+			       format_attach_flags(attach_flags, attach_flags_str,
+						   sizeof(attach_flags_str)), prog_name);
 		if (attach_btf_name)
 			printf(" %-15s", attach_btf_name);
 		else if (info.attach_btf_id)
@@ -264,7 +324,7 @@ static int show_effective_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 		return 0;
 
 	for (iter = 0; iter < p.prog_cnt; iter++)
-		show_bpf_prog(prog_ids[iter], type, NULL, level);
+		show_bpf_prog(prog_ids[iter], type, 0, level);
 
 	return 0;
 }
@@ -274,9 +334,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 {
 	LIBBPF_OPTS(bpf_prog_query_opts, p);
 	__u32 prog_attach_flags[1024] = {0};
-	const char *attach_flags_str;
 	__u32 prog_ids[1024] = {0};
-	char buf[32];
 	__u32 iter;
 	int ret;
 
@@ -296,24 +354,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 		__u32 attach_flags;
 
 		attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
-
-		switch (attach_flags) {
-		case BPF_F_ALLOW_MULTI:
-			attach_flags_str = "multi";
-			break;
-		case BPF_F_ALLOW_OVERRIDE:
-			attach_flags_str = "override";
-			break;
-		case 0:
-			attach_flags_str = "";
-			break;
-		default:
-			snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
-			attach_flags_str = buf;
-		}
-
-		show_bpf_prog(prog_ids[iter], type,
-			      attach_flags_str, level);
+		show_bpf_prog(prog_ids[iter], type, attach_flags, level);
 	}
 
 	return 0;
@@ -377,7 +418,7 @@ static int do_show(int argc, char **argv)
 	else if (query_flags & BPF_F_QUERY_EFFECTIVE)
 		printf("%-8s %-15s %-15s\n", "ID", "AttachType", "Name");
 	else
-		printf("%-8s %-15s %-15s %-15s\n", "ID", "AttachType",
+		printf("%-8s %-15s %-17s %-15s\n", "ID", "AttachType",
 		       "AttachFlags", "Name");
 
 	btf_vmlinux = libbpf_find_kernel_btf();
@@ -531,7 +572,7 @@ static int do_show_tree(int argc, char **argv)
 		       "ID", "AttachType", "Name");
 	else
 		printf("%s\n"
-		       "%-8s %-15s %-15s %-15s\n",
+		       "%-8s %-15s %-17s %-15s\n",
 		       "CgroupPath",
 		       "ID", "AttachType", "AttachFlags", "Name");
 
@@ -593,6 +634,8 @@ static int do_attach(int argc, char **argv)
 			attach_flags |= BPF_F_ALLOW_MULTI;
 		} else if (is_prefix(argv[i], "override")) {
 			attach_flags |= BPF_F_ALLOW_OVERRIDE;
+		} else if (is_prefix(argv[i], "preorder")) {
+			attach_flags |= BPF_F_PREORDER;
 		} else {
 			p_err("unknown option: %s", argv[i]);
 			goto exit_cgroup;
-- 
2.55.0

