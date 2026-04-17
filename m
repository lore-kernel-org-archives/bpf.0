Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8433BBC5
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440903; cv=none; b=a/HuCH1dMjJ1/RuAXPtia52dsXW6rYQAJUugg3T0zZGaOchaYNzwkADV+qqHPgUDyiZo8pp1s3SKeoBsAXWlXXHvB5etRmXbgL+4Ntesou7ygiAhETnTA0PDVkdeu+44Nhj6iZUb8ONEVOjbYZwR16YJvCxVJIZayiquppxFms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440903; c=relaxed/simple;
	bh=hu30ypUvEaUJyVg+bkkKp7NOXvobbOcnRQNdWtlLpmM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PuDs3my3u2JOO+Mzzix6lO6e0/Nt9Jgak+rACLzZBY8aN1g0REI3I5rpQk5MZMDx9GiWREDWHMT1+cXgfPhrHThTmFdJrZJQ0pdV52vlpXkDDtNy4Hk41JeBFSa0DEgfea0lB+RpAVVA6E9ngMGVrkJV+bWUgBsAs5ROGiHzarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nqPLDvMK; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nqPLDvMK"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c45281a06so1139225c88.1
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776440901; x=1777045701; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t14vhZSjmGxogVnlCT4l5sQln05+hcpZfQZufv0lCmU=;
        b=nqPLDvMKnNGODPWItjS8S2jm6shty7qbEh7W7zc7Si0I+Mwi00FZREjdkWRM5MfLqV
         iJDk1jdBh6FRu3SfdOBgqLAizrBJ9DRpkRcKgmvRXFcU5oOLDKzhzBjTmI576CByC9oq
         LCmhk7ZBFGRa4LwBuvSRU82jB8WQgd9+wTqAVXKVA/m/vga4MgUgTgPvhr9xIl4nmXfO
         NlJ3dQVUPc2yEYBS5CQJgX5xkAyNW+GkatnJp7P7jFk3AVTPfYAUf0LXjiT6Lx9qPGzs
         jDErrmjUamvwUnox3jjvfuy0H0k852OaY2JvASGld5/PvvWz+XzqE4dJgy016rf6t5ck
         4IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440901; x=1777045701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t14vhZSjmGxogVnlCT4l5sQln05+hcpZfQZufv0lCmU=;
        b=VewVctmQJFKnm3u4nu27pwVl1w0PlIplIF119yS+2ro/FtiO0DDodUoi/xi+BAqgDm
         iJ3tZmF9FqnhLEGalwxStOCiu9MFi8xDQ5MNFAJlHBA5NY0zLRhljzRGb25xqC0FSFnn
         lnAjMN5BgWPm8XscherOuza/8rS0MDHlvSMrZsT9VajT4pILZBUmyJxdV4fZgrDSpqMq
         +aKi4gmer2ohiUHaUAMqLPGwyyh51Uwr9wlRn0vX8W+8ZeWmIDXpR24ANWXbY9OgsdIG
         oTxIspOedAP7+5WBJxjTHaQ9K/I98BxCoRsjD/BhvN9s8WQwXy1nq5Csy5ez9hGWSn9q
         e2wQ==
X-Forwarded-Encrypted: i=1; AFNElJ95Wqn9BH+tGX/Tfi7M9nbeMLLYTlVTKcpSEUbwBQ/qFEllktvdO5/ny09MZ6vbKyC+EUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9i1CwmsEu8WfdVR0W3Pv/TGg8xIxjDgjf3RaAB4YbzwPuEET
	s7JV9SWrYQyFAhSRjx2T+aKLw2A/CFyV7faip+eW9OJ1FzqL13x/RepH/ehPqjTl47k=
X-Gm-Gg: AeBDiesXXkUGkOGTIMVhiI5iGCiNB8k6YI+vplMZ+/jIfExwieFySgVZlgyrUfxMMV0
	Oa8YVKNsxcMk/f5rYW1KVtWXDxWcDxAt/3K45sp1EUho5J93mPy+XEN7ZwV5DihScTPwG3X30yJ
	szli/S7rR9XXBt94zV5BZwDN9VWnF2cuFjmsaDmpdoyUCt6M2470KhZPzTuh/8NqJglzZLqV3Xs
	T/eoGN40vGlKmb7cuCZlfgc9DQWLz372NKs8uhQgEpTO7gnP1fVWLJ0QrC9gEOg8VzLvVPoVJQt
	nRVQiI9McqB4Uai5+Do96mzL/UtRjcZ0yZOB5+bjvks8VZSO2aVFVVYFOx0iA2GjgD+t3ipr25z
	GFis6AgIC5frc1IzB/4AlIC+lW9i3exu1K6wT6eSweViovprGGs7uj0RiQM/npCivqQFvM1avpl
	WGyYPL5XUNPmfnvto=
X-Received: by 2002:a05:7022:6882:b0:11b:923d:7753 with SMTP id a92af1059eb24-12c73f6d69dmr1640615c88.3.1776440900906;
        Fri, 17 Apr 2026 08:48:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm3803928c88.10.2026.04.17.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:48:18 -0400
Message-Id: <DHVJQQK6L83L.13DDK8BJXQFXG@etsalapatis.com>
Cc: "Jonas Rebmann" <jre@pengutronix.de>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Russell King"
 <linux@armlinux.org.uk>, <kernel@pengutronix.de>
Subject: Re: [PATCH bpf-next v2] arm32, bpf: Reject BPF-to-BPF calls and
 callbacks in the JIT
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260417143353.838911-1-puranjay@kernel.org>
In-Reply-To: <20260417143353.838911-1-puranjay@kernel.org>

On Fri Apr 17, 2026 at 10:33 AM EDT, Puranjay Mohan wrote:
> The ARM32 BPF JIT does not support BPF-to-BPF function calls
> (BPF_PSEUDO_CALL) or callbacks (BPF_PSEUDO_FUNC), but it does
> not reject them either.
>
> When a program with subprograms is loaded (e.g. libxdp's XDP
> dispatcher uses __noinline__ subprograms, or any program using
> callbacks like bpf_loop or bpf_for_each_map_elem), the verifier
> invokes bpf_jit_subprogs() which calls bpf_int_jit_compile()
> for each subprogram.
>
> For BPF_PSEUDO_CALL, since ARM32 does not reject it, the JIT
> silently emits code using the wrong address computation:
>
>     func =3D __bpf_call_base + imm
>
> where imm is a pc-relative subprogram offset, producing a bogus
> function pointer.
>
> For BPF_PSEUDO_FUNC, the ldimm64 handler ignores src_reg and
> loads the immediate as a normal 64-bit value without error.
>
> In both cases, build_body() reports success and a JIT image is
> allocated. ARM32 lacks the jit_data/extra_pass mechanism needed
> for the second JIT pass in bpf_jit_subprogs(). On the second
> pass, bpf_int_jit_compile() performs a full fresh compilation,
> allocating a new JIT binary and overwriting prog->bpf_func. The
> first allocation is never freed. bpf_jit_subprogs() then detects
> the function pointer changed and aborts with -ENOTSUPP, but the
> original JIT binary has already been leaked. Each program
> load/unload cycle leaks one JIT binary allocation, as reported
> by kmemleak:
>
>     unreferenced object 0xbf0a1000 (size 4096):
>       backtrace:
>         bpf_jit_binary_alloc+0x64/0xfc
>         bpf_int_jit_compile+0x14c/0x348
>         bpf_jit_subprogs+0x4fc/0xa60
>
> Fix this by rejecting both BPF_PSEUDO_CALL in the BPF_CALL
> handler and BPF_PSEUDO_FUNC in the BPF_LD_IMM64 handler, falling
> through to the existing 'notyet' path. This causes build_body()
> to fail before any JIT binary is allocated, so
> bpf_int_jit_compile() returns the original program unjitted.
> bpf_jit_subprogs() then sees !prog->jited and cleanly falls
> back to the interpreter with no leak.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The Fixes tag is a bit unrelated since it's for x64 but the original
commit that adds the file (ddecdfcea0ae8 ?) is so far back it probably
doesn't matter.

>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function progra=
ms")
> Reported-by: Jonas Rebmann <jre@pengutronix.de>
> Closes: https://lore.kernel.org/bpf/b63e9174-7a3d-4e22-8294-16df07a4af89@=
pengutronix.de
> Tested-by: Jonas Rebmann <jre@pengutronix.de>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>
> Changelog:
> v1: https://lore.kernel.org/all/20260417103004.3552500-1-puranjay@kernel.=
org/
> Changes in v2:
> - Add Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> - Reject BPF_PSEUDO_FUNC in the BPF_LD | BPF_IMM | BPF_DW handler
> - Move code below declarations
>
> ---
>  arch/arm/net/bpf_jit_32.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454..a900aa973885 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -1852,6 +1852,9 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
>  	{
>  		u64 val =3D (u32)imm | (u64)insn[1].imm << 32;
> =20
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC)
> +			goto notyet;
> +
>  		emit_a32_mov_i64(dst, val, ctx);
> =20
>  		return 1;
> @@ -2055,6 +2058,9 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
>  		const s8 *r5 =3D bpf2a32[BPF_REG_5];
>  		const u32 func =3D (u32)__bpf_call_base + (u32)imm;
> =20
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> +			goto notyet;
> +
>  		emit_a32_mov_r64(true, r0, r1, ctx);
>  		emit_a32_mov_r64(true, r1, r2, ctx);
>  		emit_push_r64(r5, ctx);
>
> base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3

