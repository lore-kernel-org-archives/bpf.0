Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937268;
	b=N8Xim19j6fYuU1Exgtz+mVxWVSl1bGuChxv0sW+E2UfWUj/Ho3z/q+MTXMwEQhXWmJDn
	 iFQ5cYSJkAHmjx+UueNoAAWOyGNzwf8VvCNYSZYrEpL+tCNIeg+fd2SClOqcUuEMKeBG1
	 yY3lTyODw7PfVEBuEJP+hErA2vnHsk2nZGmgTd/3l5U2JcZFcqh+6JucXUqHx1dpA7HXQ
	 swL3NfYMT0MrqH74yocm1llFqrbg5Xi1rWcwaA1nIfF8L/68wxzvHYe3dpV5CEarTk+hC
	 e/Fh+52sw4KTZUm/HG4C1mOXcjxhmUfsQ+qz7LO0Q0QufIAsnA5Xq9CYsxfR52Vkv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=miZxgVLEaVzohTaN7akh6QIt/8LMQ8OllIrcu7R0zy8=;
	b=zDvEpoVRN0iQbAcsChMDkLXB5KJTZbQhPUrpQ5uXPp2hsESrdBf+hBIkKWSzaM04GEjz
	 GvxVfaojf1NqUXpPAFJgexFd7ijcGpGWVTIpWEBsJ7rf5++bedphAGtjPCKKDpgwQb9Cf
	 I5IruA5hlJfppx5rLAmiAzCif/lxPUmL9ALyT9ztH73im0sKkniMRbigbbJJ1Q2hqAHh4
	 EwlYKJ0kvtUzo/fxEY2DpFzmUqlta26Q40ElUMTZIRbzvQxitbTOZUF8eow6RWtpour5g
	 bqdPj5+Qgd9Hh3EGSo4Q7oBwo+DEmuPPRbYqzaIa7TE4nbwvf7aYMe/oPqFoevtJsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIevt4qR;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF1606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BF1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIevt4qR
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d1114320so1634905ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937267; x=1794542067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miZxgVLEaVzohTaN7akh6QIt/8LMQ8OllIrcu7R0zy8=;
        b=hIevt4qRQ4km0LbkzQvTiDd8mHeo97Jew6niOv28gjchjE4omtiYth6cHwVDgtyvp3
         CYWYBHfTYEIefxkYN6OPNDUOAfb1PCM8vANMf6sa0A6Q35Hpt6jXaOGB53yvTRPu9aXu
         t1DTIfIDmpjecli2jcJTNHUopObwSlu2FBRkO6zJyDZhSnI45ZGtCiL/JupC6kexx7GY
         ILLsmvCdPPNWt2djW8zc1syGipuhoFuQ1HlDejhFi4sJ7xFjQgoanlp6XmWTQIM/vav9
         W3MX4YPC1LqC9Bgtk05EVGKCZoJxHVcNtzUNpOE2HrTQ5853NuVnPKQI8XJKwP2MwvCf
         LtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937267; x=1794542067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=miZxgVLEaVzohTaN7akh6QIt/8LMQ8OllIrcu7R0zy8=;
        b=yLj1IBaXlm3/TAp83iuu862LZKE9lU6n+NSv4OcVh/4ImJzMNFTqQOWkyz6xw56tJA
         nS2SkQHVXfNiReIvTHbDQeT2Mj4brgGMn5C+TUEqeQ0f7fuMsMDoFpYMvCs3y4imAjKH
         ykjoG2xnajcxVV+pd4WHO+REQ+a0rTb+PgZqR+YJ0Q22WteJ6PoFehosWVVvhqTSpesZ
         eVGrdXj7laQACk4ThKA2ETYmT3teNhuWqaRGxaCemwUiG2i7Jo/9MG1fwbaCrqThDdVO
         pxfGclYtw+74p2bhJz7jyGdkCzRKPghawAaT7j3azI6zhacw2vhJQGAlG+nuzFkgeIcS
         qptw==
X-Gm-Message-State: APuU4Z+KZ+Uzd7K/t8bH1Dop5gVCFhxh+3+RZWBP7rqjKZDYtnElrj/b
	Vp41as5Kg9U6LcUC4W2cCoaqv2sZOnu6297dZ/Qe2YYd81p3bKhxhA8D8uZ3/g==
X-Gm-Gg: AYBFou2KPVlnz9dX+Rq9XjpMndJm2NH0O9hmdhNhEncLTEp08TXd7gchj48Cf3FFDus
	KiEpGwrvqb3y+fVCClk48in58f36KN/V3yWcAQKFUbWHL6G5k0nZttCq/NNE4pUjznNAMHQncfr
	cRzNOsCBq7xpE7uxpEnJW7gyjQhOxwqjgoofQNA7raFHdWJrOkqQvxBFDKIm38BTx+xsVKRjUfA
	++T83b54YRj7i97qxl5ke75B+m+0E1SwIvILT8/KL/AJR8t058cdWTdF2AyOKwFA0Jtx9FpuKSi
	Ul2BlZ+nQu+XVfTtb7JRnipst1Lz70qrZ+4iL/WckIzB1s8S4GT8XCqVr65FuXophZ39g3OW9K0
	bsuT00OOYS2xxVD370fbsNiUg5M2vMfgEqXjjYBpadaXOiYm2tvnyxKMczDM6uBzU5+ZjyCVP/G
	sqLRlVfvzmOGlKnbgjN0LM1JdgYyOkdWSYo8+tq1+5CIvGNALXSmNjDKzUKfsmlaa2Yn/s4W7ho
	MQvCeNfsJv0NJygoOjxyHnmGeZRodPMKsk38XM8Zg/WgFlhp99TadKHSiPMWrghJqDDEXZ07Pts
	amoJtxKJtfLE0yFrGpBiEw6KeQ76HEskAtfxigK5eRGvB6C48XTXjmhUnMzOEuRAHjM2eOTOMi5
	4E9Zarxga4lwLtaDvrEEWYX738xKnMjOJyuz+FnvxWSH5Wzm2FxDrZd0IuB5X443sDSo5OmUo7w
	==
X-Received: by 2002:a17:902:ce90:b0:2ed:1b02:f6f2 with SMTP id d9443c01a7336-2ed412fc84dmr18443535ad.6.1793937267131;
        Thu, 05 Nov 2026 19:54:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d88fabsm1157315ad.63.2026.11.05.19.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 33/45] bpf: Keep the frames of the caller for ctx of struct_ops with a reference
Date: Fri,  6 Nov 2026 03:50:57 +0000
Message-ID: <20261106035111.3315285-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  static __noinline int pid_of(unsigned long long *ctx)
  {
          struct task_struct *task = (void *)ctx[1];

          return task->pid;
  }

  SEC("struct_ops/test_refcounted")
  int refcounted(unsigned long long *ctx)
  {
          int pid = pid_of(ctx);

          bpf_task_release((void *)ctx[1]);
          return pid & 1;
  }

An argument with __ref, like the skb of Qdisc_ops.enqueue, is a reference
that the prog holds from the start. __check_ctx_access() looks for the id
in ctx_arg_info[] among the references of the state. A static subprog that
is verified on its own has names in place of these ids:

  invalid bpf_context access off=8. Reference may already be released

The prog loaded before static subprogs were verified on their own. Keep the
frames of the caller when the context of a struct_ops prog is passed while
a reference is held.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1fa37faa8e69..8e7875e8bebf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11586,9 +11586,13 @@ static u32 inherited_id(const struct bpf_verifier_state *state, u32 id)
 }
 
 /* What func_is_on_its_own() asks of an argument, be it in a register or on the stack */
-static bool arg_needs_caller(const struct bpf_verifier_state *state,
+static bool arg_needs_caller(struct bpf_verifier_env *env, const struct bpf_verifier_state *state,
 			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
 {
+	/* the id of a __ref argument is kept in ctx_arg_info[], see __check_ctx_access() */
+	if (reg->type == PTR_TO_CTX && state->acquired_refs &&
+	    env->prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+		return true;
 	/* only the ids of what is held have names */
 	if (reg->type != SCALAR_VALUE &&
 	    ((reg->id && !inherited_id(state, reg->id)) ||
@@ -11637,7 +11641,7 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (caller->regs[i].type == PTR_TO_STACK ||
 		    base_type(caller->regs[i].type) == CONST_PTR_TO_DYNPTR)
 			return false;
-		if (arg_needs_caller(state, sub, &caller->regs[i]))
+		if (arg_needs_caller(env, state, sub, &caller->regs[i]))
 			return false;
 	}
 	/* callx of one function of a set asks before it is checked that the arguments are there */
@@ -11645,7 +11649,7 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
 		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
 			return false;
-		if (arg_needs_caller(state, sub, &caller->stack_arg_regs[i]))
+		if (arg_needs_caller(env, state, sub, &caller->stack_arg_regs[i]))
 			return false;
 	}
 	return true;
-- 
2.55.0

