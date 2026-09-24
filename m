Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2D13AF2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208601; cv=none; b=Wg7dCMQ1t/btsw7qdvLy0kxmYolKBWAwkevIsHuEXQALV3u/M1I8PFCg7+1mLkyqISnAUDwIPBW0KmIeqan5lVlgVh3uS1oLVnp3AbhX6JC5rkQuZvfGNgAF0czUl66OZlGxxu9FsU/fTVsyiFoXYQnP94fGxmT3Exwu4Dg/nDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208601; c=relaxed/simple;
	bh=xYRu8oUc40ZYb8IT0MuMe7U36Qr2dtgKwwyWZ5J3TZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpSKBfEk96TMjStpJkDXnzbHLGOpRUiM090Prqpv75Z8iUZvKE6cM/tHjtUKsIfY3zSEwFePHMb4HmetnXSRiZhJ4HlAOebrrKbp+SPcp5MfrhfuB62KxwVZG+NjVIJFJrH0kvHY0Ak8wwvJj+5NF9Z0RRMwuTYWbOUd+Yv1nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZkWnNYg; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZkWnNYg"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso667495c88.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790208599; x=1790813399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PPrEpChywJyfApGjK6wQgurfzOEo05BvmkIwghgEZr0=;
        b=NZkWnNYggm/+VIrF89tpk4M5KlGdm4UV0+jP6hOWVx4vy2cbPpFGuY/dD86f74RRk1
         CKtbVhB+vvPQNzp46bhXjmfmCtnZ8wJdOYGHPX1F1rXa6b49YaNkK6avxro72EIgAE7g
         TV1ZL9BQMsZn3DVRRmq+IEFFTtRW6/COepd1VuOgn0QOnEXXtJEtn9H5uL73bC6uX7rQ
         0Pua5xBb6tirKM+/BGHsigfpBv8Q5ZK81pU77G25F1lho/pRQPZgqRG9nAE8EMRjhK2o
         QgtdxPLpZUETheXmNWzN3g5jdMgWGtbqLe057BcTDrrgtzVVuH8ZbaFXJkZ2t1i4WsrA
         JG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790208599; x=1790813399;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPrEpChywJyfApGjK6wQgurfzOEo05BvmkIwghgEZr0=;
        b=uoGc71UInEWUtB5jAOpjL891xbO9A5CYOz4eThSG1qFqqKe6Nw6Q9M4N0GP8vEJaWz
         xifq1oWhRi9rrhYED7V5m2yfrayG2vWA6ZS4aowByhPAXmY7mWEnbkFIBg1lbnm1XTtP
         mUC0ZZlh5r3qJhEmt/QDv+FdCXSnP/2CowgmLnsr3Ldabex14U/hpj5YN7gaLd3OQ/NK
         QFuNkuECZBjAMJgRQYKC8ObOZrHlAgFApKQuyKPYnrdM683/Q8k35VmvDBHGA9J6Rlgn
         9k8ddaUp/E4ZQDh5QgWx2mAxgdU5mtXit+aqInu6514B8t4zHBPwrri/eWzHe7iF3+Iv
         ZPiA==
X-Forwarded-Encrypted: i=1; AKwUvBwAHvWypO8Qo0Fp9fvXuHShTqarhCWbIqe5BggyeEx3Vjz0/YbHRInKQUymXbezg5jvhB8=@vger.kernel.org
X-Gm-Message-State: AFuF++mKRh2hjootPSt3Yow1R9fffuglBz7dJ6ZOpqL2XhufIvdsIMCq
	dkn3K4tWc+hW99AGb2etjUCqIDf2WNGQYoASBQriRzPDwa3t9h/vEXfrkkxxbRNM
X-Gm-Gg: AYBFou0QoiVHXj1Mx+e3jlNN/TtmIiGw2LI5sszpRiMR8UXCp7Yh/hRwfY1XmpbuWIU
	WoM/twtgLmAb4VIHAPZl+9HQtKzFit2Mv8FZHY+CeRCStUBjlYHnuhD1rFy207yGEuxR6h2scb4
	VtgcFwmuMoamgdIzBmeqElLJvKCMzGNGjjKw5mgqi0pFN+tNnmh0yN8LqDPUjLBKKosUxFQ/9Q2
	d/yoKNP5akVzxH158tJiuOuRGRlwJ0rDM8CZYAofMC90oZQjJAgOTHqj5Y+Pi8UjYA45+VFdPXc
	H+gizo7n5G0gYUX8/hhQjwbhRRPSJZLG9MLRVfYCIouJ/iXCOt6N30BXTospEtAxbSkWWl9x2Lb
	j1uoh99kx3mGwqlKavbOJq5OgjmzwWJnIFZUOpnULgi2rfwPSOUUjyqnHfKmBTcXG96uoffJBAK
	AlVXVdTW+xZuBG6AmzFyWw8TMZQfjeBd1slOx1hcPw54aBgznhE82pQvaQvRX4ZIIzNO0W5hkKh
	4ukD2WaNOZMR76uKL5YCpacyXFn/dX8aXuDpfWha8G0eTi6jBNh2XYEeg==
X-Received: by 2002:a05:701b:42c5:20b0:143:298f:33b6 with SMTP id a92af1059eb24-14503fe4a39mr589745c88.46.1790208598619;
        Wed, 23 Sep 2026 17:09:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9390183sm8077299c88.0.2026.09.23.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:09:58 -0700 (PDT)
Message-ID: <0e1bdfe95f011b5074fe9eb5306f9a5255293188.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/17] bpf: Add callx instruction to call bpf
 subprogs indirectly
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	a.s.protopopov@gmail.com
Date: Wed, 23 Sep 2026 17:09:56 -0700
In-Reply-To: <20260922011323.1298619-6-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
	 <20260922011323.1298619-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 01:13 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Introduce BPF_JMP | BPF_CALL | BPF_X (opcode 0x8d) 'callx dst_reg'
> instruction: indirect call of bpf subprog with address in dst_reg.
> That's the encoding LLVM emits for calls via function pointer.
> src_reg, off, imm are reserved and must be zero.
>=20
> dst_reg must be PTR_TO_FUNC produced by ld_imm64 BPF_PSEUDO_FUNC.
> check_ld_imm() allows it for static subprogs only, so callx cannot call
> global subprogs or the main prog. Since every callee has its address
> taken by ld_imm64, add_subprogs() and check_cfg() see all of them before
> the main pass, and might_sleep, changes_pkt_data, might_throw of
> the callee are already merged into the subprog that takes the address.
>=20
> reg->subprogno is the callee. Verify callx as a direct call of that
> static subprog: split check_func_call() into check_static_func_call()
> that is shared with new check_func_callx(). Different paths through
> the same callx may call different subprogs.
>=20
> Arithmetic on PTR_TO_FUNC is allowed, so check that the pointer wasn't
> modified. Allow callx while holding a lock like direct calls of static
> subprogs.
>=20
> The interpreter doesn't support callx. Set jit_required and add
> bpf_jit_supports_callx() for JITs to opt in. No JIT does yet, so callx
> is still rejected.
>=20
> Print it as "callx rN" in the verifier log and xlated dump.
>=20
> Adjust "invalid call insn1" test_verifier test that used opcode 0x8d as
> unknown opcode. It fails with "R0 !read_ok" now.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72ea662baea5..0d32d3921210 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -18725,7 +18806,8 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
> =20
>  		env->jmps_processed++;
>  		if (opcode =3D=3D BPF_CALL) {
> -			if (env->cur_state->active_locks) {
> +			/* similar to static subprog calls callx is allowed under a lock */
> +			if (env->cur_state->active_locks && !bpf_is_callx(insn)) {

Nit: moving !bpf_is_callx(insn) inside the nested 'if' would have been less=
 surprising.

>  				if ((insn->src_reg =3D=3D BPF_REG_0 &&
>  				     insn->imm !=3D BPF_FUNC_spin_unlock &&
>  				     insn->imm !=3D BPF_FUNC_kptr_xchg) ||

...
