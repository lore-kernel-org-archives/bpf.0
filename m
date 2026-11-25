Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617131;
	b=jSvX7NzqOJju3fuIZ5NpoWgZsMS4m7cE9sw/jiKJg9S5GI+GMLnvyrhW1OzM0q1vkc5O
	 xXZijcF6nB7OFzspfZRj9KCnfbdoJkdMAvqhO9wDFc2hNqsYD3zqKk2RuWtqkfQzalEio
	 QZGxJY0suPykGhFNBvnfWafNfKJYlLZ9dC0ymqxZJk6gysYNy2UB39Zrmzdxcx8FQXf7a
	 dEXVX8lcHPb89UzpIP/JUcQuNQirXMD84KE4cFVVf1rPVQRkykLdNz5nCRcf1HxXAEIIO
	 jVeLhTtnPFCVx5LtULzlzbXeUTIe37hiXTpErY/aNoz1F5iSSvc2tHcnmNtnc2ueWHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617131;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yQQL3gyd8CW7DlD4k26iWlQKDEVvRToVQNJWvHpMxCY=;
	b=FFMA5prI4GqL8cdjk/3/SUOt5Dv4hEkV3e4zUjt3e8Z03qkmjity3rR3GDIvO5XxIPNU
	 wm2iKFpFg5I8aHPt5qv0JBaRMJUUQwcp8NU25TrNzF1XarpiycWnxAsQ+vtgqNlQrKDu9
	 wuplvFzuuONv705rFwVTfFhlPxkPL51H2hxzoGoHqMQWhLrRMhUKnVwRG/UK70zB77IVF
	 q2o8NCseORGJrLsktteWbGYxBvL8N1jNPJiLYW7EDyeuEBP1wbVbJNT+PVjx3ZskGL4gc
	 HDC7kuWpaRooHsYyhiFP0gAXTc7e1WLe8WMFUfWaHMim87IV7vq9HSPf+IhkAQ/s8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mq5z2mmU;
	arc=none smtp.remote-ip=91.218.175.118
Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251C606A337
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C251C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mq5z2mmU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A51LVE8ARFXdFPOnaqjHmDUaNZ9Awjjx/UE7RAnCKvM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795617127; v=1; x=1796221927;
 b=mq5z2mmUxrEwKdKxB7um5ifLoylY34l5TIRgcBdO6E3JqT3u12QDaPPasmMffj9kcVqL7Ohr
 rFXz7lgikOi9uFyIpUPTEHClot1rDMcbg27RafPPJewfC5G9CmVCaWFLvnNyAJKytvJ/qPN3cuV
 HaYnJn4q1DgRJdaNYWb1MU/o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a1f901dc2722dfb2;
	Wed, 25 Nov 2026 14:32:07 +0000
X-Mizu-Trace-ID: a1f901dc2722dfb2
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
Subject: [PATCH bpf-next v4 1/6] bpf: Add log support for tracing link_create
Date: Wed, 25 Nov 2026 22:31:33 +0800
Message-ID: <20261125143138.47174-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125143138.47174-1-leon.hwang@linux.dev>
References: <20261125143138.47174-1-leon.hwang@linux.dev>
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

Tracing BPF_LINK_CREATE returns errors for invalid attach parameters
without explaining which check failed.

Report parameter and reattachment errors through the link creation log.
Pass the log to bpf_check_attach_target() so freplace attachment to a new
target also reports target-check failures.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c  | 22 +++++++++++++++++-----
 kernel/bpf/verifier.c |  6 ++++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e78792911..b563ff5b5736 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3677,7 +3677,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
 				   u64 bpf_cookie,
-				   enum bpf_attach_type attach_type)
+				   enum bpf_attach_type attach_type,
+				   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3714,6 +3715,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (!!tgt_prog_fd != !!btf_id) {
+		bpf_log(log, "target_fd and target_btf_id must be both set or both unset.\n");
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -3726,12 +3728,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * attach_tracing_prog flag is set.
 		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
+			bpf_log(log, "target_fd is only allowed for freplace prog.\n");
 			err = -EINVAL;
 			goto out_put_prog;
 		}
 
 		tgt_prog = bpf_prog_get(tgt_prog_fd);
 		if (IS_ERR(tgt_prog)) {
+			bpf_log(log, "Invalid target_fd.\n");
 			err = PTR_ERR(tgt_prog);
 			tgt_prog = NULL;
 			goto out_put_prog;
@@ -3786,11 +3790,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		if (prog->type != BPF_PROG_TYPE_TRACING &&
 		    prog->type != BPF_PROG_TYPE_LSM) {
+			bpf_log(log,
+				"Re-attach of freplace prog needs target_fd and target_btf_id.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
 		/* We can allow re-attach only if we have valid attach_btf. */
 		if (!prog->aux->attach_btf) {
+			bpf_log(log, "Cannot re-attach a prog that was attached to a bpf prog.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -3806,7 +3813,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
 					      &tgt_info);
 		if (err)
 			goto out_unlock;
@@ -3846,6 +3853,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 */
 	if (prog->type == BPF_PROG_TYPE_EXT &&
 	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
+		bpf_log(log, "Only one of freplace prog and its target writes to pt_regs.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -3859,6 +3867,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	     tgt_prog->type == BPF_PROG_TYPE_TRACEPOINT ||
 	     tgt_prog->type == BPF_PROG_TYPE_SYSCALL) &&
 	    prog->aux->max_ctx_offset > tgt_prog->aux->max_ctx_offset) {
+		bpf_log(log, "Freplace prog accesses more ctx than its target.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -4383,7 +4392,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type, NULL);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -5927,11 +5936,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
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
+			bpf_log(log, "attach_type is not expected_attach_type of the prog.\n");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -5949,7 +5960,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
 						      attr->link_create.tracing.cookie,
-						      attr->link_create.attach_type);
+						      attr->link_create.attach_type,
+						      log);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed8cadd..67a7bffbdbd7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24346,7 +24346,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
-			bpf_log(log, "Target program bound device mismatch");
+			bpf_log(log, "Target program bound device mismatch\n");
 			return -EINVAL;
 		}
 
@@ -24606,8 +24606,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
 		    (!tgt_prog || prog->aux->saved_dst_prog_type != tgt_prog->type ||
-		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type))
+		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type)) {
+			bpf_log(log, "Target differs in type from the target at load time\n");
 			return -EINVAL;
+		}
 
 		if (tgt_prog && conservative) {
 			/*
-- 
2.55.0

