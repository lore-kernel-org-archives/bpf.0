Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49659413613;
	Wed, 10 Jun 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103111; cv=none; b=HYrhUVY/ZrSAi8poSQGKW+3UcwfJXXj9mrBjbe4OtBFu+V3XET1jBDvr9jw3qd+ZaJdXaU9tRtfzzBLkrO9roc6LQsWUtuxAON7VwA3rzvSxcnR68NxUBClO7x5Zrw9a0ySgA5qmCrwdtHSI8ZVrUejQwrwV+Mk9GEvh0NU3x9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103111; c=relaxed/simple;
	bh=Rsb6mmVZSW+LOCruXcyI3mFhLW8GcklHH+wXzBSywLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6RiRKgn0lZAKovnrzmvYXhdbtLZICgKsDF8f8ofbYGUNI8ZJpv9UXe/oONiednqc17qXN7ZdJkKiJwmljwlxzJnf+8iGQiZGfgPXJ70y9QYYmo9jyw+gM0tTmlntrJ8TyQd44EaGqBsLLMR68OYXb6KSJbFHdJHxpDw9/7DxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pZoZQMFz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pZoZQMFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e3
	Z6ajRqVRXXT17gotRjQy0QOePInsix72PsiTbBuiw=; b=pZoZQMFzwaWUphFUe8
	5BrKzh8yyD9hl946UOhaVKtDJ4+H8BHCKM3YR53tRlXgw0dLxUwh/DIJ7ySj/Jko
	2MUhNeWDJ8pgL8gQvyKgmrKenBUZi67YcLFOb1ZR0LFIM0SwFvPHLh2SwcWrJDwG
	wROtYxvKpjHW/r95m8etp+Frw=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3sr_ZeSlqaWzoBQ--.16220S4;
	Wed, 10 Jun 2026 22:51:13 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	mykyta.yatsenko5@gmail.com,
	andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v3 2/2] libbpf: fetch probeable prog type from token for feature probes
Date: Wed, 10 Jun 2026 22:50:54 +0800
Message-ID: <20260610145059.113412-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610145059.113412-1-chenyuan_fl@163.com>
References: <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260610145059.113412-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3sr_ZeSlqaWzoBQ--.16220S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr17tF4xZrWDWF45Kr1rZwb_yoWxuF13pF
	4vyr9xGw4UJF4av395Jr1ruw1FyF4DJ347GrsxW342yrsYqw4rJF1FgFWayrn3WFW5Xrs7
	Za15Z3yDCF9IvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE1xRDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgF7OWopeeHCUAAA3I

From: Yuan Chen <chenyuan@kylinos.cn>

Feature probes (FEAT_GLOBAL_DATA, FEAT_PROG_NAME, etc.) hardcode
SOCKET_FILTER or TRACEPOINT as the program type for their test
loads.  When a BPF token restricts program types, these loads
fail and the features are incorrectly reported as missing.

Fetch the first probeable program type from the token's allowed_progs
mask.  A new helper, token_probeable_prog_type(), queries the token
and returns the first match from an 18-type list of program types
known to accept trivial "return 0" programs without specific
expected_attach_type.  Types requiring expected_attach_type
(CGROUP_SOCK, CGROUP_SOCK_ADDR, LWT_*, NETFILTER, etc.) are
intentionally excluded.  Without a token, defaults to SOCKET_FILTER.

When the token has no probeable type (e.g. only STRUCT_OPS),
conservatively assume the feature is supported: token creation
proves the BPF subsystem works, and real issues will be caught
during actual program/map loading.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/lib/bpf/features.c | 97 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b7e388f99d0b..f008ee50e246 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -19,6 +19,57 @@ int probe_fd(int fd)
 	return fd >= 0;
 }
 
+/* Fetch the first program type from the token that can be used for
+ * feature probes.  Only a few common types are checked that are known
+ * to accept a trivial "return 0" program.  Returns the type on success,
+ * -EINVAL if the token has no probeable type.
+ */
+static int token_probeable_prog_type(int token_fd)
+{
+	/* Types that accept a simple "return 0" probe program */
+	/* Types that accept a trivial "return 0" program without
+	 * specific expected_attach_type.  Types requiring expected_attach_type
+	 * (CGROUP_SOCK, CGROUP_SOCK_ADDR, LWT_*, NETFILTER) are excluded.
+	 */
+	static const int probeable[] = {
+		BPF_PROG_TYPE_SOCKET_FILTER,
+		BPF_PROG_TYPE_KPROBE,
+		BPF_PROG_TYPE_SCHED_CLS,
+		BPF_PROG_TYPE_SCHED_ACT,
+		BPF_PROG_TYPE_TRACEPOINT,
+		BPF_PROG_TYPE_XDP,
+		BPF_PROG_TYPE_PERF_EVENT,
+		BPF_PROG_TYPE_CGROUP_SKB,
+		BPF_PROG_TYPE_SOCK_OPS,
+		BPF_PROG_TYPE_SK_SKB,
+		BPF_PROG_TYPE_CGROUP_DEVICE,
+		BPF_PROG_TYPE_SK_MSG,
+		BPF_PROG_TYPE_RAW_TRACEPOINT,
+		BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+		BPF_PROG_TYPE_CGROUP_SOCKOPT,
+		BPF_PROG_TYPE_CGROUP_SYSCTL,
+		BPF_PROG_TYPE_FLOW_DISSECTOR,
+		BPF_PROG_TYPE_SK_LOOKUP,
+	};
+	struct bpf_token_info info = {};
+	__u32 info_len = sizeof(info);
+	int i, err;
+
+	if (!token_fd)
+		return BPF_PROG_TYPE_SOCKET_FILTER;
+
+	err = bpf_obj_get_info_by_fd(token_fd, &info, &info_len);
+	if (err)
+		return -errno;
+
+	for (i = 0; i < ARRAY_SIZE(probeable); i++) {
+		if (info.allowed_progs & (1ULL << probeable[i]))
+			return probeable[i];
+	}
+
+	return -EINVAL;
+}
+
 static int probe_kern_prog_name(int token_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
@@ -27,10 +78,14 @@ static int probe_kern_prog_name(int token_fd)
 		BPF_EXIT_INSN(),
 	};
 	union bpf_attr attr;
-	int ret;
+	int ret, prog_type;
+
+	prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0)
+		return 1;
 
 	memset(&attr, 0, attr_sz);
-	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr.prog_type = prog_type;
 	attr.license = ptr_to_u64("GPL");
 	attr.insns = ptr_to_u64(insns);
 	attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
@@ -61,6 +116,7 @@ static int probe_kern_global_data(int token_fd)
 		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
 	);
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+	int prog_type;
 
 	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
@@ -72,7 +128,12 @@ static int probe_kern_global_data(int token_fd)
 
 	insns[0].imm = map;
 
-	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0) {
+		close(map);
+		return 1;
+	}
+	ret = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &prog_opts);
 	close(map);
 	return probe_fd(ret);
 }
@@ -257,8 +318,13 @@ static int probe_kern_probe_read_kernel(int token_fd)
 		BPF_EXIT_INSN(),
 	};
 	int fd, insn_cnt = ARRAY_SIZE(insns);
+	int prog_type;
 
-	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+	prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0)
+		return 1;
+
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);
 	return probe_fd(fd);
 }
 
@@ -277,6 +343,7 @@ static int probe_prog_bind_map(int token_fd)
 		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
 	);
 	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
+	int prog_type;
 
 	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
@@ -286,7 +353,12 @@ static int probe_prog_bind_map(int token_fd)
 		return ret;
 	}
 
-	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	prog = prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0) {
+		close(map);
+		return 1;
+	}
+	prog = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &prog_opts);
 	if (prog < 0) {
 		close(map);
 		return 0;
@@ -435,8 +507,13 @@ static int probe_kern_bpf_cookie(int token_fd)
 		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
 	);
 	int ret, insn_cnt = ARRAY_SIZE(insns);
+	int prog_type;
 
-	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+	prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0)
+		return 1;
+
+	ret = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);
 	return probe_fd(ret);
 }
 
@@ -509,7 +586,7 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 static int probe_ldimm64_full_range_off(int token_fd)
 {
 	char log_buf[1024];
-	int prog_fd, map_fd;
+	int prog_fd, map_fd, prog_type;
 	int ret;
 	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
 		.token_fd = token_fd,
@@ -527,6 +604,10 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	};
 	int insn_cnt = ARRAY_SIZE(insns);
 
+	prog_type = token_probeable_prog_type(token_fd);
+	if (prog_type < 0)
+		return 1;
+
 	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
 	if (map_fd < 0) {
 		ret = -errno;
@@ -537,7 +618,7 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	insns[0].imm = map_fd;
 
 	log_buf[0] = '\0';
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+	prog_fd = bpf_prog_load(prog_type, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
 	ret = -errno;
 
 	close(map_fd);
-- 
2.54.0

