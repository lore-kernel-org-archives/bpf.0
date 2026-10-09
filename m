Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7F3CA486
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520354; cv=none; b=nmAlrF/pIK6B2/wG7m/Vuntq5a0DvfwqRCLIiXTFdDBSKM8pzF34qJtbrZPBGPKIJ0GSgRwrAcYD7iGi2c23M2tLQTeZ0nOfYGlHCD/oFZpIO4rsnLuF+wadH+ZRBrLYR5e51D83RhMrZZwYcUihTn9OUIfBVyST8FEb3GXM9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520354; c=relaxed/simple;
	bh=0ikyI4kbNVZtzXEY8lJpqZchV53ld0r1cDcLcHYM8p8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i8sCQX+FvILliGt/OUqHXRI6vzw8zydByzYYFh2euq80JfzF4CUbE1B3jz7VpkhWK8VJ4Zn1aKR0/GjjqSvG+KxfcuyKfie1r4epVFC5z9qccOra8QyRsRkHlbWGYbf+iqJX7syiZYGMoVA8QrYA7UJJVTusV7KGkHEdnOke9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba9Vu7x8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba9Vu7x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA31F00893;
	Fri,  9 Oct 2026 04:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520350;
	bh=ZZjzDZpHZQ3ass2aPo0zi4jg8cM8abHxt8xRTaEaIyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ba9Vu7x8Zhino/0d/irlIsPbCgE7rK0OXO0cebvAcuyUEUsr8KhfNNYTdy43yQ47B
	 zxEXXDEHBYLDNocBN/OaTHpn4oIK83ytBnv0OA6yOKE9KMashleUEMa1GF3ZcI+KGL
	 FwVz6AdwbosyK5GkSDnPL2brNbNTYiI8H/nU+bdmEbR3PajmpkaztjM4CqQ8GMAPDr
	 EfHwJyUAVoFqBxYAhu2YXMABLOwO6yG2m+zeRbQYH4vkm/NKuJMhTRW2vuBLIQ8SqQ
	 sICAv825FfHVwLC9wz23gqjM6XIEJqNokCgIy9hV59IWbyZYq7pN5XwKSLwiDAQ/qT
	 nD4MbVw7cVFvA==
Message-ID: <sashiko-outbox-164841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 14/24] bpf, x86: Dispatch exception cleanup
 pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041559.31116-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041559.31116-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:32:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Exception unwinder cleanup pad executes in caller's stack fra=
me context
--

commit 9d03eddc4bc6be397e72d866390a80929337af59
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Dispatch exception cleanup pads at run time

Add what bpf_unwind() relies on to send each frame of a program to its
landing pad or its epilogue on x86-64. This includes arch_bpf_stack_walk_ra=
(),
aux->epilogue_ip assignment, and bpf_exc_fill_native_ranges() call.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 083fcd6cf15b7..d434871b5a11c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -3279,6 +3280,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
>  			seen_exit =3D true;
>  			/* Update cleanup_addr */
>  			ctx->cleanup_addr =3D proglen;
> +			/* Where an unwind sends a frame with no pad. */
> +			bpf_prog->aux->epilogue_ip =3D (u64)image + proglen;
>  			if (bpf_prog_was_classic(bpf_prog) &&
>  			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>  					return -EINVAL;
>  			}
>  			/* Deallocate outgoing args 7+ area. */
>  			emit_add_rsp(&prog, outgoing_rsp);
>  			if (bpf_prog->aux->exception_boundary) {
>  				pop_callee_regs(&prog, all_callee_regs_used);
>  				pop_r12(&prog);
>  			} else {
>  				pop_callee_regs(&prog, callee_regs_used);
>  				if (arena_vm_start)
>  					pop_r12(&prog);
>  			}
>  			EMIT1(0xC9);         /* leave */
>  			bpf_prog->aux->ksym.fp_end =3D prog - temp;
> =20
>  			emit_return(&prog, image + addrs[i - 1] + (prog - temp));

[Severity: High]
Does this execute the cleanup pad in the wrong stack frame context?

During exception unwinding, arch_bpf_stack_walk_ra() walks the stack and
yields the return address pointer (ra) for the current frame N, which
points to the instruction in frame N-1.

In bpf_unwind_rewrite(), *ra is overwritten with the address of frame N's
cleanup pad or epilogue_ip:

kernel/bpf/helpers.c:bpf_unwind_rewrite() {
    ...
    rec =3D bpf_exc_pad_for_ip(prog, ip);
    *ra =3D rec ? rec->pad : prog->aux->epilogue_ip;
    ...
}

This forces frame N to jump to its cleanup pad when it returns.

However, the JIT epilogue executes "leave" before "ret". The "leave"
instruction completely tears down frame N's stack and restores frame N-1's
stack pointer and frame pointer.

The "ret" instruction then pops the modified return address and jumps
to frame N's pad. As a result, the pad executes while frame N-1's context
is active.

Can this cause any stack accesses inside the pad (using rbp, mapped to r10
in BPF) to incorrectly access frame N-1's stack variables, leading to
memory corruption, use-after-free, or garbage reads during cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D14
