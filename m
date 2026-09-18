Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD151A14E;
	Fri, 18 Sep 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752300; cv=none; b=ffbx0DWUStPkMvxPG/JeYIppocjWB4TMQCr7dEU+y2Qdmtw530QG/jdd9uX49yjmEglrgYsRTkNZMivM0lYYCG+93okbMM8TjF5g5VnTuk0Rdw/GbpgbkdP7QedJYth/MWfyc6jQnXuMwiELjWyOr+Deb4W4eqzhfK3Ph4lBUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752300; c=relaxed/simple;
	bh=vUh7k6/sgzYvC1EwkqVYUJP2zwwUD/OVrEJJTTCiv6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgdl27HDSZ7R3biAepuY9iOeNCBUTOfm8jyd2yVlMN/664nl+ZtOLHizUfiJJtiVsPHkr385rzQPwJCy/49Qyal0n5EFTQGSdTrTgK1m/awiVdz+iWCiMCRDZBG8WPj1nVhj+1ZoToyu22v5sXEoupnPMsT7ts1vmBt6SW/lSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CCxLPu7K; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CCxLPu7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=w5
	fWPWYIbg6KghdEbDIe/kAKt5hevm4hGcALmYK1xKI=; b=CCxLPu7KgvBIuMgU1t
	2ojYib9vk5rrQGqFSA2juOyQSQvQuTnO2SZ7d99IxSa2leH/E+QFXbV6AKBY4Fz+
	U/WHg7amkEUx9ODaHlYwWhnpqU80hebvK4g5DgB95beeWSvng9G7o35VJyuGmTpv
	QJ0Q5Xjq7XY+zLZcBC98i9cQI=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXUUq7c61qHvN9AA--.16484S2;
	Sat, 19 Sep 2026 01:24:12 +0800 (CST)
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
Subject: [PATCH bpf 3/3] bpftool: Add support for BPF_F_PREORDER cgroup attach flag
Date: Sat, 19 Sep 2026 02:24:07 +0900
Message-ID: <20260918172407.3459188-4-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918172407.3459188-1-sh_def@163.com>
References: <20260918172407.3459188-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXUUq7c61qHvN9AA--.16484S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr17Cr1DGry7XF1kCw47twb_yoWxWr4rpF
	4kXFyUK3WrW3sxXa1xC390gFWFgrs7WFWUCFy5Jw1Y9FW3Gw1vkrWfKFWF9rn8XFW3Aw40
	vrWYvr45WF1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hwScWqtc7yeHAAA3f

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request pre-order execution across the
cgroup hierarchy. Furthermore, attachments legitimately use combinations
such as BPF_F_ALLOW_MULTI | BPF_F_PREORDER.

With BPF_PROG_QUERY reporting the per-program BPF_F_PREORDER attribute,
bpftool's exact-match formatter falls back to "unknown(40)" when
BPF_F_PREORDER is present alone, or "unknown(42)" when combined with
BPF_F_ALLOW_MULTI. Additionally, do_attach() only accepts "multi" and
"override", rejecting "preorder" with "unknown option".

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

Refactor the attach flags formatter to use a bitmask formatter that outputs
comma-separated flag names while preserving unrecognized bits as
"unknown(...)". Also accept "preorder" in do_attach(), and update
bpftool-cgroup.rst, usage help, and bash completion.

Signed-off-by: Hui Su <sh_def@163.com>
---
 .../bpftool/Documentation/bpftool-cgroup.rst  |  9 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/cgroup.c                    | 55 +++++++++++++------
 3 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index e8185596a759..8ec2546c0b8e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -45,7 +45,7 @@ CGROUP COMMANDS
 |     **cgroup_unix_recvmsg** | **cgroup_sysctl** |
 |     **cgroup_getsockopt** | **cgroup_setsockopt** |
 |     **cgroup_inet_sock_release** }
-| *ATTACH_FLAGS* := { **multi** | **override** }
+| *ATTACH_FLAGS* := { **multi** | **override** | **preorder** }
 
 DESCRIPTION
 ===========
@@ -75,10 +75,13 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
     Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
     and optional *ATTACH_FLAGS*.
 
-    *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs some
+    *ATTACH_FLAGS* can include: **override** if a sub-cgroup installs some
     bpf program, the program in this cgroup yields to sub-cgroup program;
     **multi** if a sub-cgroup installs some bpf program, that cgroup program
-    gets run in addition to the program in this cgroup.
+    gets run in addition to the program in this cgroup;
+    **preorder** requests that this program executes before programs attached
+    further down the cgroup hierarchy during evaluation. **preorder** can be
+    combined with **multi**.
 
     Only one program is allowed to be attached to a cgroup with no attach flags
     or the **override** flag. Attaching another program will release old
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75cbcb512eba..819757d7a360 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1057,7 +1057,7 @@ _bpftool()
                 attach|detach)
                     local BPFTOOL_CGROUP_ATTACH_TYPES="$(bpftool feature list_builtins attach_types 2>/dev/null | \
                         grep '^cgroup_')"
-                    local ATTACH_FLAGS='multi override'
+                    local ATTACH_FLAGS='multi override preorder'
                     # Check for $prev = $command first
                     if [ $prev = $command ]; then
                         _filedir
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ce69d1e5468e..aec1281c95d8 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -56,7 +56,7 @@ static const int cgroup_attach_types[] = {
 };
 
 #define HELP_SPEC_ATTACH_FLAGS						\
-	"ATTACH_FLAGS := { multi | override }"
+	"ATTACH_FLAGS := { multi | override | preorder }"
 
 #define HELP_SPEC_ATTACH_TYPES						\
 	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
@@ -269,6 +269,39 @@ static int show_effective_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 	return 0;
 }
 
+static const char *format_attach_flags(__u32 attach_flags, char *buf, size_t sz)
+{
+	static const struct {
+		__u32 flag;
+		const char *name;
+	} flags[] = {
+		{ BPF_F_ALLOW_MULTI, "multi" },
+		{ BPF_F_ALLOW_OVERRIDE, "override" },
+		{ BPF_F_PREORDER, "preorder" },
+	};
+	size_t len = 0;
+	size_t i;
+	int n;
+
+	buf[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		if (attach_flags & flags[i].flag) {
+			n = snprintf(buf + len, sz - len, "%s%s",
+				     len ? "," : "", flags[i].name);
+			if (n < 0 || (size_t)n >= sz - len)
+				return buf;
+			len += n;
+			attach_flags &= ~flags[i].flag;
+		}
+	}
+
+	if (attach_flags)
+		snprintf(buf + len, sz - len, "%sunknown(%x)",
+			 len ? "," : "", attach_flags);
+
+	return buf;
+}
+
 static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 				   int level)
 {
@@ -276,7 +309,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 	__u32 prog_attach_flags[1024] = {0};
 	const char *attach_flags_str;
 	__u32 prog_ids[1024] = {0};
-	char buf[32];
+	char buf[64];
 	__u32 iter;
 	int ret;
 
@@ -296,21 +329,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
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
+		attach_flags_str = format_attach_flags(attach_flags, buf, sizeof(buf));
 
 		show_bpf_prog(prog_ids[iter], type,
 			      attach_flags_str, level);
@@ -593,6 +612,8 @@ static int do_attach(int argc, char **argv)
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

