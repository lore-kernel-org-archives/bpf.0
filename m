Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423171;
	b=Xz4cgW+TCzX4dinan9yZfEDW7M2nrmoCZUrYypomw6gpK8H8VFqF0eapwIeZ8IQyWoxf
	 Et8zBR9lDwctlmudlsAxHmsL8ULC6neqsYygimFX0Pt2zYe/k3IkuqwkJypyyu6Hr8lBV
	 bgj6/pAEDLn1utpgDrkWKj7ihy9rdk3XlzXKh1FFl9nggvFjY7rUOjq/Q9yjC2mPvZrBo
	 TnkcNZ50UW8egbxhYgO9KlDeaDyFceMHyqdY7mny6cwpeM+dqFxqGsd6KH2Txq3QTXo+N
	 1zQKhGVYHqrpV0uOLB38CEpt3VhRCvqZq6XYGLKoAthU5uDzxLYi4PiixLDFSTHNBzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HHaK97Y7oi4ovthDsDD89B8Ei4LodhXWsPJIhwHZlN8=;
	b=FxuhySpqVH4+ApXkMHPjJLdPBeGsFCSU+znE6/26/LbB2A34LMScRrFQxENnyIG8wE/M
	 HGUp3Mp2uuPjq8Y5uUuHDldUkyfPmgy5wKzypyav/vJySWHiz54lq1Lxg+Z8cNvqe6o6l
	 jaFnOdy01/oVdYyNliXQbuRJoiRx401Wk2ihhRh6OHayawzE1pgUchSRuJyML8EelmZu8
	 VmYo36HsXoHi3NJDNF3BsLekIRrw0eXunF5Ovy+/EKwie/BSSmVmx3VrY7q1ml/U9llW7
	 he27M5icNM/hJwTa31/Fa0KpZ8lzdIHqk8UWHJ9l3WYMy3EXZrnhuacXynPnLuBsoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfMM6EL4;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C2606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B3C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfMM6EL4
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso9061995ad.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423170; x=1794027970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHaK97Y7oi4ovthDsDD89B8Ei4LodhXWsPJIhwHZlN8=;
        b=XfMM6EL4+Y83ugK1Uw/rFh4iVme9bFRdluOP/AVeC84HrEcxeub9ZtMw8Gk6jOb9kI
         BJXgg6xa/mEqwe3PTPfFYVju31Bfv4/PNF+lGFczRcvSA6A29+P4vH62bKijj79YyXz4
         TwxMhdAZveI3Z79g0IiwuAIqxz/L4nMxLkuQ5IytoHZL9WpTJltRR6cVioVKBGr1trMU
         yjGNNFOvtMSaYeJSohpo9GoR+FmLgQRkUkC4Rg56n4k6FPkBGy7QwmkWJzki30O0VkZv
         9QHHOOFnzgvez03venDpfc/0995tPClGjPj9Oktpb61WDdcYU/wn+nsDaGhu3Foqf2QA
         EeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423170; x=1794027970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHaK97Y7oi4ovthDsDD89B8Ei4LodhXWsPJIhwHZlN8=;
        b=b25xb5qQ9jf7Y9VbPiEFk88ydNktTkOasy3gI4p/u82DluSWuq0jzkpVeR+Z0EzMyP
         vuvz8RGXjGv6omnRFSvrSP5mhSoGSxKAt3q6DsqiTFfr5ydJEX3SjRF+BNHCH+ffjJF0
         d7ibpuM/iQkyjsWMIqFwsUjLqPV2c255jwzJ6eQMFIAU8+7HqjBzqwuLWtblo9Nf31IT
         /qS1UTCNqfA4/zKaawFEigPKf84xRkRK4Ubfhc5YyagvzLRNZBJtt9HFU/0PW5NkGd57
         kdNyvQ70Omb7kURO1dbmVaT10Ij0liFIk2Ygc7gqte0eO2S3RYW6/AnMhxWJadA0eCto
         dvKA==
X-Gm-Message-State: AFq9FYJMYWfYU2IvIOCynwI8v4eLuQq/mMcy+n+qmQgbiQL5cMiWotCz
	J+XkL+R49RBPvpD0MOy4koFPiwdGOVyTgWo9I2Qr0xXt9wWGkYmf3QG3bIL+4A==
X-Gm-Gg: AYBFou1jLee2eER7PA7mUhgM4RAa6j+5LR7n+hE/mQhJ2nnZlfne/yZeZmzQMVU6749
	wVg8gZaA9l+1DAvAB4+2g3NyweCn1li+9Y7dB32dhTcJJqfClQIkfCiW6IWvh1a4Dq1g8wGbNO5
	NkUw0VcBfZ36xYspwffPGXyEMklZ+bhWbD06ISnLMf/2w6YOGTyNMkeBUv/9vuT5WqVFKiln3Ib
	FPqKs1b9Jf404yGWRjkLrXTljD+h3LZgElS2ZEngowaZxqyAi9GPPpIFEy4g9G9Hq6T0iNinQA/
	8NHyjkIj29YlhvlaC4DLM+eAJexKFKskOHHLFT3RurgbSC/YYesQ7E6o28mKk99xoZaxRilm1PA
	wqHElPTwcNwPkEzFx8mfWpcrwbcfIZnWmZbAiQ9epxGrX/qaeiTXu8vbmF3hr6hv2XFFUxubkG8
	9neBYhR0QIgK8MAjZsav8F+9FU0r59Br4fF/U+5yKsVQg+2SPxaOe8vcgroE7MA7gag8vURHCQ3
	8J8dqLIh5pJuc8QRIM2/rGft4ic6rPsjZFMr2Wiqvc0Jbu9E88twN5Jy1ft4LiyHj6yJi5EYm9W
	UBh/DX5NHfU4yf9VRJiAyzWltdxNaEn65EumvgCSwtR0q0fNmfcmSEb03JnYigch6sV2yzbT90Y
	i07oOgzs3Qt3R5I1agY5LApYJMVfPW96Ct/0W5RoZuWsnspFrockVORTJECRfsJnYSpq2cVQGBG
	cFmF2NKNcRwYPiOYX6TL+h
X-Received: by 2002:a17:903:2a88:b0:2e9:5ed2:c38f with SMTP id d9443c01a7336-2eb364bfe10mr47474395ad.36.1793423170124;
        Fri, 30 Oct 2026 22:06:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927da95sm12991395ad.47.2026.10.30.22.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:06:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/2] bpf, x86: Fix bpf_throw() in a prog with a private stack
Date: Sat, 31 Oct 2026 05:05:57 +0000
Message-ID: <20261031050558.2410721-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
References: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
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

When the main prog has a private stack and the prog calls bpf_throw(), it
returns to the kernel with wrong values in r12, rbx, r13, r14 and r15. The
kernel crashes soon after that, for example:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:__bpf_prog_test_run_raw_tp+0x125/0x380

The main prog of a prog that can throw saves these five registers at its
entry. bpf_throw() walks the stack to the frame of the main prog and
gives the stack pointer of that frame to the exception callback, which
pops the registers from there. In a function with a private stack r9 is
the frame pointer, and the JIT emits 'push r9' in front of every call
and 'pop r9' after it. So the stack pointer that bpf_throw() finds is
8 bytes too low:

  r12
  rbx
  r13
  r14
  r15  <- the callback has to pop from here
  r9   <- rsp of the main prog at the call

r15 gets the address of the private stack and every other register gets
the value of its neighbour.

This happens in tracepoint, raw_tp, perf_event and tracing progs, except
iterators, and in struct_ops progs that ask for a private stack, when
the main prog has more than 48 bytes of stack. The throw can be in the
main prog or in a subprog.

aux->stack_arg_sp_adjust already moves the stack pointer from the
outgoing stack arguments up to the saved registers. Add the 8 bytes of
r9 to it when the main prog has a private stack.

A constant is enough. Calls of helpers, kfuncs and subprogs and callx
all have the push. A prog with tail calls has no private stack, and a
callback cannot throw. Only the frame of the main prog matters: the
frames of subprogs are dropped, with or without a private stack. On
x86-64 a function with stack arguments has no private stack, hence only
one of the two parts is not zero.

The JITed code does not change.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 83b0cb1f911c..70c23b48bd9c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2658,8 +2658,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
+	/*
+	 * bpf_throw() sees rsp of this frame as it is at a call. The callee-saved
+	 * regs are above the outgoing args, or above r9, which is pushed around
+	 * every call when the stack is private.
+	 */
 	if (bpf_prog->aux->exception_boundary)
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp;
+		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp + (priv_frame_ptr ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
-- 
2.55.0

