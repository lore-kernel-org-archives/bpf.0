Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233328;
	b=qdJm3C7irGhaYKG0XOZgeS0SrxyaU5AZ045NoPF2L1GGtE6j7UU+H5lD/7XuiW8OJFBG
	 o9TGvVLz0z7MowxWiVR2sRzbMHQY2PTkF4X4Dm0nDDzvTG1akuQW/SHuES78YI2Ux/pXe
	 CzilJiKY1bAyWYoe0zKv/LjfRngIEwLNXdHFOUDjyH1FaiwIc+wDNgr2fl2z+5LjGxJ5R
	 vx4yko89eBT2Z4AVtIJCTTST1pxYPcFqFjj3rOASp3zylad5UDOLPmR+DTeyuo1YGjVH4
	 gfn9c4xa6tDFMZ6eq2Jh54TB8ylTAMwOQuAUzEp7fx+dqvgCtDVJBqv+2tipwFsLduw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233328;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o7iCEJLNoY/e9VNGD6lmcji1DbRrxbBTnD5nM3ZM/5o=;
	b=k4krHZoEz3QXwF+pR+y7/8DtVdFxZ3VpaJMvnOQbp31FYwdzDTMD+5Hzss4SysfIexeX
	 wwqWRaiYoPnxVgNqFYscPjxNShojai5nqCcDfG1Qv2gORDFA0gCzbqkTGEfNEGpBM2JfF
	 fR1qA0IIX3zdAMPspQyXXMRcXmGpjDoQpgDoxTSWtMp05UXecic15Sudj8GGvMjq77O1K
	 NNQjMBH6UZEwt+egqIbOiIP16KeoFyKxIR2FBCabIFws3MsPdfLORDQ3sibrdMgHIrolV
	 kTpQVRY7iqB9IYgmquog5nmklUMUQsMtiL15C2xIF6/Ra4+7pNCkeClYLwDiNfY7ldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="O54/vqz3";
	arc=none smtp.remote-ip=95.215.58.68
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1F606A332
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B1F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O54/vqz3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ShE4RLFcmEnG+TcvQM6DQKhjQ0Grr/oDCaUxrdxmtYg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233325; v=1; x=1794838125;
 b=O54/vqz3FrbuS80r30JPXFTuNs1TBB12oSnyYGPDJFnjW3uKCsUYcwkcOEA+Ock83IHUyegZ
 WnfKrUeUDYW/QRxtujAeAbd6kY3qfmJnGjCjfeD7W7nHAfImBQbxSu16f4vtomwzSIaVWC0rrSs
 hmh8SNUCp45DAWfVlA0fxwJU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0adb1fe5e9b0e113;
	Mon, 09 Nov 2026 14:08:45 +0000
X-Mizu-Trace-ID: 0adb1fe5e9b0e113
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/9] bpf: Add log support for iter link_create
Date: Mon,  9 Nov 2026 22:08:10 +0800
Message-ID: <20261109140816.5196-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109140816.5196-1-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iter BPF_LINK_CREATE returns an error without explaining invalid target
FDs, flags, or iterator information, or an unsupported program.

Pass the BPF_LINK_CREATE log to the iter attach path and report these
failures.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/bpf_iter.c | 27 +++++++++++++++++++++------
 kernel/bpf/syscall.c  |  2 +-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..7ff256a5d98b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3276,7 +3276,8 @@ void bpf_iter_unreg_target(const struct bpf_iter_reg *reg_info);
 int bpf_iter_prog_supported(struct bpf_prog *prog);
 const struct bpf_func_proto *
 bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
-int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
+int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog,
+			 struct bpf_verifier_log *log);
 int bpf_iter_new_fd(struct bpf_link *link);
 bool bpf_link_is_iter(struct bpf_link *link);
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f0b29a170935..dfefa5579e03 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/rcupdate_trace.h>
 
 struct bpf_iter_target_info {
@@ -528,7 +529,7 @@ bool bpf_link_is_iter(struct bpf_link *link)
 }
 
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
-			 struct bpf_prog *prog)
+			 struct bpf_prog *prog, struct bpf_verifier_log *log)
 {
 	struct bpf_iter_target_info *tinfo = NULL, *iter;
 	struct bpf_link_primer link_primer;
@@ -538,24 +539,36 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	bpfptr_t ulinfo;
 	int err;
 
-	if (attr->link_create.target_fd || attr->link_create.flags)
+	if (attr->link_create.target_fd) {
+		bpf_log(log, "Invalid target_fd.\n");
+		return -EINVAL;
+	}
+	if (attr->link_create.flags) {
+		bpf_log(log, "Invalid flags.\n");
 		return -EINVAL;
+	}
 
 	memset(&linfo, 0, sizeof(union bpf_iter_link_info));
 
 	ulinfo = make_bpfptr(attr->link_create.iter_info, uattr.is_kernel);
 	linfo_len = attr->link_create.iter_info_len;
-	if (bpfptr_is_null(ulinfo) ^ !linfo_len)
+	if (bpfptr_is_null(ulinfo) ^ !linfo_len) {
+		bpf_log(log, "iter_info and iter_info_len must be both set or both unset.\n");
 		return -EINVAL;
+	}
 
 	if (!bpfptr_is_null(ulinfo)) {
 		err = bpf_check_uarg_tail_zero(ulinfo, sizeof(linfo),
 					       linfo_len);
-		if (err)
+		if (err) {
+			bpf_log(log, "Invalid iter_info.\n");
 			return err;
+		}
 		linfo_len = min_t(u32, linfo_len, sizeof(linfo));
-		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len))
+		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len)) {
+			bpf_log(log, "Invalid iter_info_len.\n");
 			return -EFAULT;
+		}
 	}
 
 	prog_btf_id = prog->aux->attach_btf_id;
@@ -570,8 +583,10 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	if (!tinfo)
 		return -ENOENT;
 
-	if (!bpf_iter_target_support_prog(tinfo, prog))
+	if (!bpf_iter_target_support_prog(tinfo, prog)) {
+		bpf_log(log, "The iter target does not support the bpf prog.\n");
 		return -EINVAL;
+	}
 
 	link = kzalloc_obj(*link, GFP_USER | __GFP_NOWARN);
 	if (!link)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aed1c6a2f203..db135859a2d1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5928,7 +5928,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie,
 						     attr->link_create.attach_type);
 		else if (prog->expected_attach_type == BPF_TRACE_ITER)
-			ret = bpf_iter_link_attach(attr, uattr, prog);
+			ret = bpf_iter_link_attach(attr, uattr, prog, log);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
 		else if (is_tracing_multi(prog->expected_attach_type))
-- 
2.55.0

