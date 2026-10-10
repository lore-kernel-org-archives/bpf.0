Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90543A8755
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644436; cv=none; b=R18beFzu50rko26hfPA0lml2T31V5TMbFnEOs6gVhy1/O9zBPXdVIRV/WS0bjd2bES92erLiT/Gt5cpPA+/gkiAGTCitP0RVWfiffYC9jrhsXxRDcNTJUK1PM91GSSjvE6/Bul0rnYB2drSl7mqcqAnAj1WoMEDEYhOcqINYAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644436; c=relaxed/simple;
	bh=B0puN/FDsJY5TEQ/Kuq07Nvd+eja123QVpOLIbOD4nM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=kaHzWTBLbV43xEzokiaqvuSrHUA3waQOA2v7VvVJLxUI1XW58GWjmQ7GchhelLy/exDf6Deos1P3NeNh/g/NYXEoebjaE2F8DDeRrQADW1FeZlMC/M/FNrDJCc9Lpw9efQtN8KmdwN9C5XHRd0g4iZUik2LgrfzYn17CmJVXCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ2FqTwL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ2FqTwL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab8309dcbaso435848a91.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644434; x=1792249234; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMQ+OGI/6GVu8E8/99VApxuW7P1BOocjGpZ4BHxc+9I=;
        b=gJ2FqTwLIb47u57FaVFmwLHHON8QSVPxMnXkVSdlQ0BqsnjB2/1YmF0uWDgxRzXTtk
         t7SPc/gfbEhszU87bVMiwTzmRG8EfcjSgT1qjP0sAxjRqQWwq0jdkWVD7oWPqCLx50nC
         8Pbvg/H22dpoKuNGdabtb+hQTJgJEGIIsWz/bw8x72Ms3QB6HOIeKR6+HWSaQAFON2rU
         6qHjITQ3wJm5vezLyccldQqiOe+XBnpCuBvcipKfZvG264dDCnSoiWx2YV9O8L+mZNtk
         uwSeTjWuk13EOjBiWCSmdmJ45GUeGjHAetb3kagQO4K8tjfeTgMrKK0fyUMTqKaIMcSu
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644434; x=1792249234;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMQ+OGI/6GVu8E8/99VApxuW7P1BOocjGpZ4BHxc+9I=;
        b=OXhuhe/RMBv+IkRUVMpr8IRNFtle92qhJKFWsA33H1HvfVagh3NmuzXBvlF1BVSJLI
         +G8/RHFNEy7JDLZR8E++OtVtnJAfVMXb++4NxO2bQlq7x7KWADmAaHhNOp0duZu75cNY
         Nb4gCkqBgeP0A/a98ltMsLLNvn61AQLLmbXxIY0y4u/1ZX9VNKCUAF0G/GiYDekN+cDH
         VbWIyaCEmUEFL0amiMlLed1YnrxlV4n3RQ/Fy0KlnqsMiNWX70LAVq9YF0R2eBr3vL9n
         UFQWmiYtVHpM1SgYSG/9KtGNzoYlEPiQi0DkcGMw6zKp/ee+Hw8G/IamZLyiVzHXdKDy
         sang==
X-Forwarded-Encrypted: i=1; AKwUvBzvoqpgIdBrKDwklrb7nKOSIpYYD1hs0cGBOAV7n6AyEPfZVavMw7sM3Vs6ge+R2cETFs4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLOTMyS6Xk0DPGlvuQWSSPVda5hwJ7Gvr6wLBe9vmcXzVHte0D
	ykBDkSJFX3xvsibNGECn1h2KZdd4F5F+P2O8RwFrZyclY8VBLI8TPVld
X-Gm-Gg: AYBFou2pQRecVL2d2qWLO5CHCXYukFNFNDI+Q5endhDX6QsoTSZAwtSEPdSmhfsLjMa
	so6h2e2RtU+4e2BSzyvzijPCY81iZcVC940qZfIrCFX3o2A6UDo4E81c+49CqVH1lC3pFY3jUuF
	5OB6LSUW68mcq4izxzxPfe1D+oRtLKyyUJBeCVYZNqhvnBd8m1nSzx06tBKvYRqAgS8eoqeIQ4m
	JjVr4YgLK26MDqO4pMMCgxPY3qVqYwhHepijzhOm4zRJAU9gPo0KgbVDEaFjpraxFhprfIVaJ7b
	E4CaUeXJPCmZGpE/5lw1tGqdcDBQJXdYTheEwVm96dlyVmoBDgBvDgcbz6FY1vmCHy92H8ttYCo
	vN+Gl/SZ+2M+7GswPp+sRwCkIml8CzmdMPB3J9poCrBwPwRPxatC0QwTyxDr5EyQhJ2euzcfX4i
	31ZqtrUji3oooadsBpA6pIq/x3JSCMaaIk54oE5jH6ecDC24GmdyUfxHIfY32LFUb7ys7T5B8j9
	60kG0wV4te0XzwW5b41ZyJErbhrotvSvxmpA4eGZaYyP9UsoC2u0RHzVKAH2gDUrI+lOI98iLEe
	WnU=
X-Received: by 2002:a17:90b:1a8a:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3ab3a9529c8mr3001446a91.7.1791644433960;
        Sat, 10 Oct 2026 08:00:33 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39533ee7sm5089610a91.4.2026.10.10.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:00:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 15:00:31 +0000
Message-Id: <DM18Y176CAXH.ODHX8RNC3W06@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Keep the BPF calling convention for a
 trampoline on a BPF function
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261009064216.1239645-1-yonghong.song@linux.dev>
References: <20261009064206.1238047-1-yonghong.song@linux.dev> <20261009064216.1239645-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 11:42 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> Mark the model of a target program's function as bpf_tgt_prog, and have
> bpf_jit_place_args() leave every slot of such a model where the BPF
> convention put it. That is where both JITs pass it in a call from one
> BPF function to another: slot N where the kernel convention passes its
> Nth eightbyte, in a register or a stack slot. The x86-64 trampoline does
> not use bpf_jit_place_args() yet; the next patch makes it, and this
> keeps it right for a BPF target.

can we drop the flag and for tgt_prog rewrite the model in
bpf_check_attach_target() as one u64 arg per argument slot ?
Every convention places N u64 args in slot order,
so no arch has to know about BPF targets.

The flag fixes bpf_jit_place_args() only.
calc_arg_aux() on arm64 picks reg vs stack per argument by looking
at its first slot. In callee_stack() from patch 5 'h' is in slots 7 and 8.
pos_of_slot[7] is x7, so the whole 'h' is counted in args_in_regs and
save_args() emits 'str x8' for the second half. x8 is BPF R0.
ctx[8] is garbage. For fexit it does 'ldr x8' and the first outgoing
stack slot is never written, so callee_stack() runs with garbage
in the upper half of 'h'. The test should fail on arm64.
CI uses clang 21 without stack args and won't catch it.

s390 trampoline doesn't use bpf_jit_place_args().
s390 ABI passes 16 byte arg by reference, so it does:
  mvc bpf_arg_off(16,%r15),0(%arg)
For callee_odd() that is a load from address 8.
It also saves and restores nr_args == 3 registers,
while callee_odd() takes 4.

With the flat model arm64, s390 and the r9/stack split on x86
are fixed without touching arch code.

> @@ -21620,6 +21620,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
>  		if (ret < 0)
>  			return ret;
> +		tgt_info->fmodel.bpf_tgt_prog = !!tgt_prog;

There is one more issue with BPF targets. Few lines above:
	if (tgt_prog && conservative)
		t = NULL;
and the model is 5 u64.
A static function with 6+ args where one of them is a plain pointer
is 'unreliable', since btf_prepare_func_args() returns -EINVAL,
but it still takes stack args.
The trampoline saves and restores 5 registers. After fentry prog
r9 on x86 and x5-x7 on arm64 have whatever __bpf_prog_exit() left there.
With fexit the stack slots are not copied either.
The function continues with garbage in the args that the verifier
checked as pointers, I think.
Reject such attach ?

Pls tell your agent to test on arm64 too.

pw-bot: cr
