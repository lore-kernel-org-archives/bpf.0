Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668794;
	b=x9kbed/ZV9XsEAAeMvP0KOpUuGW4hY6qHIfI8keGXUHeJr1UMiyZB6+WAKCD9X71N8a5
	 MHsgbtHlgaKABPTfRz6xJuRGAnXFVZrplKpxwFGpy142+HKJf1GM92l0CkjBWCuGW1gJG
	 vVjtLzc+gPvLwO+PY8ih+a07oky1nIYbxmxnsPUhz6LrNWfEt6V0YC0QMuZ8hNttzaqlv
	 XoW0HwCUMo3MoCsMzUsSKV/ggsWKbAnQdAQxg58UXGE1/VL9tphjuoQnUAT6x5Ow6MMa+
	 GCvBoDOrOhvP0ow9GpyinpTuAUOGq4XNaTw/h5G6H/mBSRaeHzkj6rwuu94hrNYbPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668794;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8hoXA0ozN3gwIjzw6dYmmpeGCJhv4eVHbd/aitfqsyg=;
	b=XQ0cmXpDydHAdLATWaV+y98dVEZjP6/siIdSAD78gfW/A5BJyOTuT0ExLtfAJdvCrvSH
	 +OOv6JUndIZvnKU2CV8YyAXawOvPfcQjzLgL1q0jD8PmkmO1e5LJJ72L52y18/FM6ewAC
	 gQPQF0FWahMt7sMFRBcyjskPWo9k746RzmgplBfuE4wELgqxEdk2jUBzNBs06LJWPigE6
	 zebhlCrsQvzEJAbvcSg7H4RvJbFiJ7XeGrCOSk9Hdqg/PDKmkvyZCVd8Rqr7X4hImCuqe
	 mRm0L8mrkvfIqoRCN42r06sqKsNbQt/PKPBjAGqddGMfjnjpKta/wvkHppJ+GB7Tvng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E56rfpwl;
	arc=none smtp.remote-ip=95.215.58.200
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A9606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022A9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E56rfpwl
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m5MKL4gzWmcPp3xQ829VTnO6NwAqmpOdJ4pSoxn+PB8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668792; v=1; x=1795273592;
 b=E56rfpwlR0Ysyk1VlP1WyyRscGkECdTh5DvK046vMzumUL0+viQpBJFYNRKY1m8Zd1Y7xhmI
 H7/bEpPai+1NHykWepvCZ/ZHx/e/KcaThX9SfPS2v+NDm3y///RbJ3Zit8+uKSonPWIYJ+i1fVk
 YbHsv+axCeRPGN8+mNyi/xws=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c2156d3f847186b;
	Sat, 14 Nov 2026 15:06:31 +0000
X-Mizu-Trace-ID: 5c2156d3f847186b
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
Subject: [PATCH bpf-next v2 1/9] bpf: Add log support for tracing link_create
Date: Sat, 14 Nov 2026 23:06:02 +0800
Message-ID: <20261114150610.84507-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114150610.84507-1-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
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

Tracing BPF_LINK_CREATE returns an error without explaining why attachment
failed.

Pass the BPF_LINK_CREATE log to the tracing attach path and report invalid
attach parameters. Also pass it to bpf_check_attach_target() so freplace
attachment to a new target can report target-check failures.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 04a3b3c80c74..cf6bf3765b3d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3674,7 +3674,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
 				   u64 bpf_cookie,
-				   enum bpf_attach_type attach_type)
+				   enum bpf_attach_type attach_type,
+				   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3711,6 +3712,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (!!tgt_prog_fd != !!btf_id) {
+		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -3723,12 +3725,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * attach_tracing_prog flag is set.
 		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
+			bpf_log(log, "tgt_prog_fd is only allowed for freplace prog.\n");
 			err = -EINVAL;
 			goto out_put_prog;
 		}
 
 		tgt_prog = bpf_prog_get(tgt_prog_fd);
 		if (IS_ERR(tgt_prog)) {
+			bpf_log(log, "Invalid tgt_prog_fd.\n");
 			err = PTR_ERR(tgt_prog);
 			tgt_prog = NULL;
 			goto out_put_prog;
@@ -3783,11 +3787,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		if (prog->type != BPF_PROG_TYPE_TRACING &&
 		    prog->type != BPF_PROG_TYPE_LSM) {
+			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
 		/* We can allow re-attach only if we have valid attach_btf. */
 		if (!prog->aux->attach_btf) {
+			bpf_log(log, "Invalid attach_btf.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -3803,7 +3809,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
 					      &tgt_info);
 		if (err)
 			goto out_unlock;
@@ -3843,6 +3849,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 */
 	if (prog->type == BPF_PROG_TYPE_EXT &&
 	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
+		bpf_log(log, "Invalid kprobe_write_ctx.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -3856,6 +3863,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	     tgt_prog->type == BPF_PROG_TYPE_TRACEPOINT ||
 	     tgt_prog->type == BPF_PROG_TYPE_SYSCALL) &&
 	    prog->aux->max_ctx_offset > tgt_prog->aux->max_ctx_offset) {
+		bpf_log(log, "Freplace prog accesses more ctx than its target.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -4374,7 +4382,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type, NULL);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -5907,11 +5915,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 					      attr->link_create.target_fd,
 					      attr->link_create.target_btf_id,
 					      attr->link_create.tracing.cookie,
-					      attr->link_create.attach_type);
+					      attr->link_create.attach_type,
+					      log);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
 		if (attr->link_create.attach_type != prog->expected_attach_type) {
+			bpf_log(log, "Invalid tracing attach_type.\n");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -5929,7 +5939,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
 						      attr->link_create.tracing.cookie,
-						      attr->link_create.attach_type);
+						      attr->link_create.attach_type,
+						      log);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
-- 
2.55.0

