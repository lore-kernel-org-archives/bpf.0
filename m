Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600391;
	b=EOFDUZY7cg8bpGqdLUCX9b5tBLFgScdHVzz6h91mHj1RagHCt1iXq/Gf5g2ioMk2rZIv
	 4tuqIwc4cv1ch6WO7clSk/wydsMKenu4csOJSX/HcTB7pUbjatKFQtyQeXT2Ff4Oud6ma
	 Q3b+v/YQBgKf1163d/2O1V28oC7MUix02zfOv4nsQ65IRzAgZBa2ADBtMiRUhgt+vCt63
	 M9c0SMGiPGVs1zAZGsdTbdu83kfeM1B27VUXD/vqIRAU/u/kxYEF68CwAwKX9m+t0OHh1
	 EIRni//ahRqG5lEUkeEXT7uIAZQlqBAYMO+dJvCHsgZxFnsTSI42WFMYLhyAOtQqdtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k9Vlu1WKqqVGS7123Fh5ZK3C7t3HNDbPS7lduIMBT78=;
	b=SXXtZhCION1RF5UYwZ72lXM61j2p14SKeMy+SjlvbQHxVuKK3ouQrI9C1I7lbrr3gADW
	 l/cnDrES7ImRX1AVrhqLe7KQzEK+7XXFFcPOrFIIskJeFIzN4LAiv4K1EIevyUas7ZJ1X
	 +8l+zaaJVuCBGcE1RH0yjg4CrRi1NND3CLh7Mx3rxv9IZPHH59u+3QlrTT7c4qahtd18X
	 YPXhK2CvAWvqQT2v4ImryNYLdPuC5URumY0ePXFGkddTOH3r0CZsrFoJji2nb8bV2IxAD
	 4n+zBOIl/948Eb+TSA+6BoZYxWTSLdxSq5LRS+PZV3h5Boj8KQKNYmNiqRVXJq80QjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oEUa/CJJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1298606A335
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEUa/CJJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4CD1F00919;
	Mon,  2 Nov 2026 06:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793600390;
	bh=k9Vlu1WKqqVGS7123Fh5ZK3C7t3HNDbPS7lduIMBT78=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oEUa/CJJVO5nLQzl4+Co5WQjmRWrkqUA8vP7dJv0//eJZteDOezmQkWbOWKmeseUk
	 Dw0B1BqT8z6oeHEO6ZNSKO6381Nu5xGmansDUfo8gEV/YYjG238adTReZB5Izzw88U
	 uSwVAsQChJNkL4MNcK0Ww3sdiEd1APowYzvOvC4g8nCY6Rh4VBZ+QtUr6wjPqX7s+h
	 aEtX6hYXY9Vo0wWb3teMktjSWPN70aBNZKGhbopdx3mRwYRBccUFhdxb5c4iyqoovi
	 +pFGnFS2HDCb0jEw5xJPYyXCwoYDKMyMNOYFPJxvHymjhr5SldBXMsqrnW6MWX9P47
	 sP45VfOL9pccg==
Message-ID: <sashiko-outbox-192948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Invalidate a dynptr slice when its stack
 buffer is written
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261102055543.3584718-2-alexei.starovoitov@gmail.com>
References: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
 <20261102055543.3584718-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 06:19:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing slice_buf tracking for bpf_dynptr_slice() in check_kf=
unc_call()
--

commit ccd22f0a6c418f0e43056579c44af476a64ac756
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Invalidate a dynptr slice when its stack buffer is written

This commit tracks the stack buffer range of writable dynptr slices in
bpf_reg_state::buf and invalidates those slices when the underlying stack
buffer is written to, overwritten by a special stack object, or when its st=
ack
frame returns.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 217bcfa6ebfee..b34f7321eaafc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -15668,6 +15711,21 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		ref_convert_owning_non_owning(env, id);
>  	}
> =20
> +	if (is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) =
&&
> +	    dynptr_slice_may_be_buffer(meta.dynptr.type)) {
> +		struct bpf_reg_state *buf =3D &regs[BPF_REG_3];
> +
> +		if (buf->type =3D=3D PTR_TO_STACK) {
> +			meta.slice_buf.frameno =3D buf->frameno;
> +			meta.slice_buf.off =3D reg_smin(buf);
> +			meta.slice_buf.size =3D reg_smax(buf) - reg_smin(buf) +
> +					      meta.arg_constant.value;
> +		} else if (base_type(buf->type) =3D=3D PTR_TO_MEM) {
> +			/* a slice is the buffer of the next one */
> +			meta.slice_buf =3D buf->buf;
> +		}
> +	}

[Severity: High]
Should check_kfunc_call() also populate meta.slice_buf for
KF_bpf_dynptr_slice?

At runtime, bpf_dynptr_slice() copies non-contiguous skb or xdp data (or fi=
le
dynptr data) into buffer__nullable and returns that buffer as PTR_TO_MEM |
MEM_RDONLY. Because meta.slice_buf is only populated for
KF_bpf_dynptr_slice_rdwr, slices returned by bpf_dynptr_slice() have
reg->buf.size =3D=3D 0 and are skipped by invalidate_stack_slices().

Although the program cannot store through a read-only slice, leaving
reg->buf.size as 0 appears to allow two issues:

1. If a subprogram takes a dynptr from a caller frame (or a
CONST_PTR_TO_DYNPTR), calls bpf_dynptr_slice() with a buffer on the
subprogram's own stack frame, and returns the resulting PTR_TO_MEM |
MEM_RDONLY slice in R0, prepare_func_exit() allows R0 because its type is
PTR_TO_MEM rather than PTR_TO_STACK:

kernel/bpf/verifier.c:prepare_func_exit()
    err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
                                         callee->allocated_stack / BPF_REG_=
SIZE - 1);
    if (err)
        return err;
    invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);

destroy_dynptrs_in_stack_slots() only destroys dynptrs in the callee's stack
slots, and invalidate_stack_slices() skips R0 because R0->buf.size is 0,
leaving the caller with a live pointer to the popped stack frame.

2. Within the same frame, if the program calls bpf_dynptr_slice() with a st=
ack
buffer and later spills a pointer into that buffer (when
!env->allow_ptr_leaks) or initializes a dynptr, iterator, or irq flag slot =
in
that buffer, check_stack_write() -> invalidate_stack_slices() will not
invalidate the read-only slice. Subsequent loads through the PTR_TO_MEM |
MEM_RDONLY slice are treated as plain memory reads returning SCALAR_VALUE,
which can read the raw bytes of the spilled pointer or special stack slot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102055543.3584=
718-1-alexei.starovoitov@gmail.com?part=3D1
