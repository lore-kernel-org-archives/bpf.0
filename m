Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BF1397
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777097308; cv=none; b=rVP2ej8YuvZnYp8FGFfYvRyZf4nJzmX8zW50/H+i1fjvCxq3qTBgeJLpYLmhroIVEVUIiiDestzpnaCse7BreKG5zcbpNOgAGmbVhTXk7WchVd+PVZZfguYhZ2ir1Lg9Trm+ZsYS+2K0a4GpuWp7x/H217FIVzg6fMd5Y+OkjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777097308; c=relaxed/simple;
	bh=GQuR+LpKBZ08WUce4w9k1DekSGD2tsAcGJInv4TYGoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CaiDZOlIkkxsFylxZn7przJbXXVsZRUTUELgF3ivZSd7D369Xs3Ei6xg1v23oH4PosxtoC17SLGK/LHbxVmquAMMR+7AuKVl2+8u8i0vSrS3iUNExOV43Voh0YUToMWnW40ieOE/dz/WlXHPT882hzNvVE04txUYsU7GUNSb7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU7xViZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU7xViZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAF8C2BCB0;
	Sat, 25 Apr 2026 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777097308;
	bh=GQuR+LpKBZ08WUce4w9k1DekSGD2tsAcGJInv4TYGoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aU7xViZw2oy+WxgHjqWZ/or3yMoTJclx2jzCMBB1vbKARwdqBiziYzQNsYilELO77
	 s5pjEGfPxXKedhFxELcEpP2Cys2XI5wvG9f1bYqmtwxZcSA8vrKEfiGgH/1oJ0oYf3
	 HdYbqcSAQwFj9JlNezNTOMj5UaRZGZY2l4lIW8Jt9brWYedIDZDq18LXXgvXTTkgzE
	 dlDjCNrPCDwWYL+c1k4/2PsFgwST1NqBY1gEa1bU1xwAvrltnaK1KHtWWSE4srllDR
	 58419TmB45OTGyRnzolIWAsYV5ZgK3P9sE1OKmU1YEn5cEhylcGtupKdqsqtboPP7v
	 00GAlYote/yRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-5-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-5-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 06:08:27 +0000
Message-Id: <20260425060828.1DAF8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Missing KASAN instrumentation for immediate-based memory stores (B=
PF_ST | BPF_MEM) and incorrect write detection.
- [High] Missing KASAN instrumentation for standard atomic memory operation=
s (BPF_STX | BPF_ATOMIC).
- [High] Incorrect IP calculation in emit_kasan_check() leads to wrong jump=
 offsets and kernel crashes when IBT is enabled.
--

commit bdea14177f5d099598de93e92ea9aecf3714ba64
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks into x86 JITed programs

This commit inserts KASAN shadow memory checks before load and store
operations in JIT-compiled BPF programs. It aims to detect memory safety bu=
gs
while explicitly skipping stack accesses and faulting PROBE instructions.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b90103bd00809..111fe1d551219 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2242,6 +2244,11 @@ st:			if (is_imm8(insn->off))
>  		case BPF_STX | BPF_MEM | BPF_H:
>  		case BPF_STX | BPF_MEM | BPF_W:
>  		case BPF_STX | BPF_MEM | BPF_DW:
> +			err =3D emit_kasan_check(&prog, dst_reg, insn,
> +					       image + addrs[i - 1],
> +					       accesses_stack);
> +			if (err)
> +				return err;
>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>  			break;

Is the correct instruction pointer being passed to emit_kasan_check() here?

Earlier in do_jit(), the local ip variable is updated to account for
conditionally emitted prefixes:

    if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
        EMIT_ENDBR();

    ip =3D image + addrs[i - 1] + (prog - temp);

Passing image + addrs[i - 1] directly ignores the size of the ENDBR prefix.
Could this cause the relative jump offset in emit_call() to be off by 4
bytes, leading to a kernel crash when branching to the KASAN function?

Additionally, looking at the code surrounding this hunk:

        /* ST: *(u8*)(dst_reg + off) =3D imm */
    case BPF_ST | BPF_MEM | BPF_B:
        if (is_ereg(dst_reg))
            EMIT2(0x41, 0xC6);
        else
            EMIT1(0xC6);
        goto st;
[ ... ]
    case BPF_ST | BPF_MEM | BPF_DW:
        EMIT2(add_1mod(0x48, dst_reg), 0xC7);

st:     if (is_imm8(insn->off))
            EMIT2(add_1reg(0x40, dst_reg), insn->off);
        else
            EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);

        EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
        break;

Are immediate-based memory stores (BPF_ST | BPF_MEM) meant to be skipped?

Unlike BPF_STX, there is no emit_kasan_check() added here, which seems to
allow uninstrumented writes to kernel memory.

If instrumentation is added here, there might be a second issue. Looking at
the helper:

static int emit_kasan_check(..., struct bpf_insn *insn, ...)
{
    bool is_write =3D BPF_CLASS(insn->code) =3D=3D BPF_STX;
    ...
}

Since BPF_ST has a different class, would this evaluate to false and
incorrectly emit a read check instead of a write check?

[ ... ]
> @@ -2390,6 +2397,12 @@ st:			if (is_imm8(insn->off))
>  				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>  				start_of_ldx =3D prog;
>  				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
> +			} else {
> +				err =3D emit_kasan_check(&prog, src_reg, insn,
> +						       image + addrs[i - 1],
> +						       accesses_stack);
> +				if (err)
> +					return err;
>  			}
>  			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX ||
>  			    BPF_MODE(insn->code) =3D=3D BPF_MEMSX)

Further down in the function, atomic operations are handled:

    case BPF_STX | BPF_ATOMIC | BPF_W:
    case BPF_STX | BPF_ATOMIC | BPF_DW:
        if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
            insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
            insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
            bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;

Should standard atomic memory operations be instrumented as well?

While the commit message notes that BPF_PROBE_ATOMIC instructions are skipp=
ed
because they handle faults, standard BPF_STX | BPF_ATOMIC operations perform
memory modifications without fault-handling semantics.

Since emit_kasan_check() is omitted here, could an invalid base pointer used
in an atomic operation bypass KASAN and corrupt memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D5
