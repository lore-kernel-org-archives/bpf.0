Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808621;
	b=N7vGxqip8xudc0eLyY4vIuZhO0/dNYxoMyizlcmm9vIgm5ErrniDcmOpo0lX+PFj3g/t
	 9COvShl58pgpkUDj5MEecgiUStmGPR0PMr8DsVVi/QU1AtWtdns3aV6mMo5rWt/erA6kW
	 zpaVQROoZC+tUB47uNve7J+xndomWTM/5PYMqRlKKzRiO7NaSBSuO8oh4tpPuFpvMJbJf
	 cdm0nBsU0x7AMPIJNiFD4UoKi1eMzRrGK+NOpqBB/ZXQrj+6lYh5QZSP8MxTNV/8nm7CI
	 qNORw0Big03n4AAwn/37X3GuQksymX384e3EZU4oSwc4pg+d9yhGLzkw4HcT4jkQLRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h9lvVFj+c/48mKmUuV5OgOy985yaKNt4+jjklAY5yao=;
	b=HSy6cJuS0Jaf8wFxRwwdAmTPdLZ/Zm4/MhxV3i5/asytDfyOTLRAWz1erICon/QFjBn6
	 lP3yAZEfySmPMQnU9xO9bFSFTklyN/3/ygAnfVIMyjgQVYF4/2zg6oT93w92NKVjcU9Y3
	 hanD62Z1co74cMee/AjSpnnpXTXzesB0defV2PwTHtvjtY7/sVakzwv9/c+fUsDb7plIw
	 AhXTOsLLycVUA5h5bBXfijpOsg1JSHUKm2Z3ctW6hE39XE1oP8tBWQcp6Tr260waJA5gf
	 4+pAjJjSHdG0GNtreB5d4vtJsfvibXIha/AjBLbK88VXDvZGUspfQL4zBa5cU97UaRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MW1RP9IY;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC328606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC328606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MW1RP9IY
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2701500a91.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808620; x=1795413420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9lvVFj+c/48mKmUuV5OgOy985yaKNt4+jjklAY5yao=;
        b=MW1RP9IYiunbERR3tVH9zcz8y2FEaSoLgnSfAf4tg2DKuXhq15vxQ5IKbvYAjSWsTA
         ItFy0oMxkiGzSy5Cdwz8v8XCi45kdXmkP9M0zaS8QPNzy9YqtgkAeQsO5iml4by1nnOP
         hOkRaJrNNgnitcXlEzDocdf+ieOaFrPL7NgXofNJknN55xeDQIyzTO5ALS8C8ev+ARQO
         cq/lRz0jZn/WCctymhSUpHsnnXk1kvUWFyA/llJ1wc/0n0Vdi+9hlzqcTEQhvCvtJu/0
         m2H9WeBxAbkiY+r0PlZtw1iCw893f1zpyc7CXg50x9xlTXz8bY8+dRPbVL8kSBNqgpFq
         GZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808620; x=1795413420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9lvVFj+c/48mKmUuV5OgOy985yaKNt4+jjklAY5yao=;
        b=v4zAoN+ekTt/YiA/XXVROsr4mRKGCbzJCIPGe9m5AMN2/ZxxpuX8XLfFKWYxtkMFg0
         cq7IhK5zCQHIEVyI+xO0X+vcvm+3yh8rnObNlPm1e0oMbLqpm6UJWxE9LeXFeckOd776
         vuXQxDgvJAbk427fltIlQjvL0UVzMZONSdRTYaZA+2G24+Y0LSOcG6lRDslzjvgu7rqK
         8R4MQnf+b1E24gZxhMrNoRRdq9F27GTPGElkOg94fQz2klXYiN8pfHvjWN+eW9ZBHG0s
         x9+ZEWkiB5gdu0oilCK/DDIogx5e0BSzpbiS6Qz96XXfMMmVf8k6zZFq/VsZtbCilqOV
         9hUA==
X-Gm-Message-State: APuU4Z+3E8XkI+kSIJrKm3EqLjBkYtu1J5H6iaYBZYS55QLryB8cNqo+
	cYnSjaFDui4d6LwIh7GiwIgowQcWDZ+mvkxP5OzrUy/3RBJJwej/zufk9TJJ1g==
X-Gm-Gg: AYBFou1dMTa5vmSfiwZ3D+4w3gUImgp2eBuJW81mbkoxjpImQE/0f2xS1ZfeOf3oKvH
	Y54OzDMvhxkDP9Bcx2EU+PazARJqsmDdJUIvT5igg2AFXF9Zmx2RYLRPyJZz4i3qrRfSczjPGwq
	JcG21k3dB+9PUhcbdl0M5rLU54tHd12QLg/8W2yoxvc+rDFMVp7i9TX6hASZ8N+/wgtVbGs86g6
	iqpdO96isJ0fip0Uc6qQTIRiogJtmfWPLb1xyD6sqVTpFnUGQj9sIe1gjVkwJRVVSNfBfjPaLNS
	NIhqB5yb2LYGa8P/wqmuYSzpZNSz6fBV8dT6QGDUYuy+Lz+Z/JYvDIDXSk1wTN4ZK0sy1fcGYKY
	rRpumnMwKeW+w8fCbZSHUygy3xUV4oAmchGXVJo2hCse256OB6DzBCvlAQ53lCCnKY6A5O1KTEM
	Z9sLN6QWq80+caCGPD0FMgKvGGicAmUtFywmQOyS0XWpZwvJ5eJopGbTLU9r4hA5/kNBEDfiNVh
	9iMJqxKsWmeNrjXyo+SU9GYde+Il/vNm5p5MU4tFgRuZ+np1p89PCWECqQY2ynBR8pke4mw1+Su
	KySEo/a1kKzJM3bKu/X9V/etmLUi4fz5Wsplnwj1PHvMjo1otWQERLfhrWdFwal+CAf2eyFkNfS
	7TH0lpLLDO0/O2YjNNLOOgg1roJldcDjkyGUscUQqMOOg3cQbjTtcI3Hcr9G+Kdop6sqYTNir8w
	==
X-Received: by 2002:a17:90b:1f86:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3b1b0b666c5mr9843898a91.19.1794808619843;
        Sun, 15 Nov 2026 21:56:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm8499923a91.0.2026.11.15.21.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:56:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 03/21] bpf: Give a syscall program the largest context when it does tail calls
Date: Mon, 16 Nov 2026 05:56:20 +0000
Message-ID: <20261116055638.4171529-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

BPF_PROG_RUN compares ctx_size_in with max_ctx_offset of the program that
it runs. The target of a tail call gets the same context:

  first:   bpf_tail_call(ctx, ...)      max_ctx_offset 0, ctx_size_in 8
  target:  r0 = *(u32 *)(ctx + 60000)   out of bounds

The target is not known before the run. Pad the copy of the context with
zeros up to U16_MAX, no program can use more. kern_sys_bpf() makes no
copy, so its caller has to pass that much. An extension cannot add tail
calls to a program that has none.

The copy is accounted now. It comes from kmalloc-cg or vmalloc, not from
the caches of memdup_user().

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c |  7 +++++++
 net/bpf/test_run.c   | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf4a9fb8e2e0..86e5c9c38026 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3859,6 +3859,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -EINVAL;
 		goto out_unlock;
 	}
+	/* The same for tail calls, see bpf_prog_test_run_syscall(). */
+	if (prog->type == BPF_PROG_TYPE_EXT && tgt_prog->type == BPF_PROG_TYPE_SYSCALL &&
+	    prog->aux->tail_call_reachable && !tgt_prog->aux->tail_call_reachable) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
@@ -6668,6 +6674,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 			return PTR_ERR(prog);
 
 		if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
+		    (prog->aux->tail_call_reachable && attr->test.ctx_size_in < U16_MAX) ||
 		    attr->test.ctx_size_in > U16_MAX) {
 			bpf_prog_put(prog);
 			return -EINVAL;
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..cc3236e3c0c4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1687,8 +1687,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 {
 	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
 	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	u32 retval, size = ctx_size_in;
 	void *ctx = NULL;
-	u32 retval;
 	int err = 0;
 
 	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
@@ -1702,10 +1702,18 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 	    ctx_size_in > U16_MAX)
 		return -EINVAL;
 
-	if (ctx_size_in) {
-		ctx = memdup_user(ctx_in, ctx_size_in);
-		if (IS_ERR(ctx))
-			return PTR_ERR(ctx);
+	/* the target of a tail call can use that much */
+	if (prog->aux->tail_call_reachable)
+		size = max_t(u32, size, U16_MAX);
+
+	if (size) {
+		ctx = kvzalloc(size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+		if (!ctx)
+			return -ENOMEM;
+		if (copy_from_user(ctx, ctx_in, ctx_size_in)) {
+			err = -EFAULT;
+			goto out;
+		}
 	}
 
 	rcu_read_lock_trace();
@@ -1720,7 +1728,7 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 		if (copy_to_user(ctx_in, ctx, ctx_size_in))
 			err = -EFAULT;
 out:
-	kfree(ctx);
+	kvfree(ctx);
 	return err;
 }
 
-- 
2.55.0

