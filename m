Received: from mail-ua2-f15.google.com (mail-ua2-f15.google.com [74.125.226.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4E580389
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.207
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176956; cv=pass; b=nOQ6z4iYQeMyr4HtvwVR9c2DOgYPvqzJS1R9/n6AWaTmDunoJodFu8n/GEsUy3JWqiNfOyZrFZVXuYsEu4OlJc1uzPlmO2Ev+VJgRJhuV/8zWmXSnYDMHreY0JxBYOuB7W707wwZy3Cobvx5/01Act/GjkvDOjpYafHnDix5yxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176956; c=relaxed/simple;
	bh=k52FAz1VeVA/rpXiXnrdLNg/c0mGxAcxoMRWsw09e38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwZKULBD6eiI+Dpd+NrGxxMRz+Kzf9fyiKhBQ0lEZ3j1Kgun9KenWBDlIYS3+nRQvT170ybmYxhgcMy6OBPexPytJKl/6l37yf/xTYOFEaVm2ynaTQoGCmow6r7C5Z2uSOFzj/0hXfInRF/mYo8Ep5lCJmSYToBfB9aLFzmhk0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=yfU6/ylX; arc=pass smtp.client-ip=74.125.226.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="yfU6/ylX"
Received: by mail-ua2-f15.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed2so644388241.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790176954; cv=none;
        d=google.com; s=arc-20260327;
        b=Wech2f6ZvEwIsyHRmTjKXTdMRgLHDYa/Fz/u/tJGgOJWc4NgDWh4P9Q8mdZltkiwOQ
         lYMNXPjI80kHxGzHjefMNoF9q/AmoB+4VIyvKS0OEhfxp5V0+zjOQMWZHXJ6Ej+Gsp1G
         aZmJO/iHyf/QDOFp5vOnN87+ADq7TQCQ0mDmz0/vO3+N7jsIP9ShaOdaWcxLy8t2OHA2
         yK/H/LjhB4WZgCMZzzkfOge6Rl1NACO/FxB8z7GHk3kKPSmvZNcQ5ljL4PkL1c1ByDA6
         SFxNJQTGxwW5MN50ZrnEAAC6Djiam1o7TCZk/hZ39lEvJokcdsAYj8Hkge6gpXBVHkXl
         5zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iZ8RpPQpWuomiLvwjk3uovF6+uc5LQwN2VY4ctUFEBc=;
        fh=MxkgcynidP9gCG9cLSGDFlrbV5bZsQr94wfAKHprh8E=;
        b=TX0mbJB4SIL/Y7vUDBn921KU4nOatbQJSZ2p3kTiyerJxrJLhmvUB0CoPtzkNp8hqZ
         NXs6X59PmfOxu4MH7MNxkwRHSPvfb+xaSWoKg0NcO3SWW7yERwzgYDuNeiLambeBO+nX
         qTerIDVcfW7fhzgW2KAiBytukKTVcQerhWIMaXZwrK9o6ahfgVDj29uV3Y4619e3hDvd
         88qZkqX+IezouIkQi8G1TY41QazEbwawr+qgcQx7RaUEKWdk3Ctf+gGFLaVbnTLChd+0
         i3vRuETocBkpAV6pZTQosnFmB9o0ye3YdRlfyZxfb1hBkvfTOX7houCgw3Nl1E6X04rI
         WYTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1790176954; x=1790781754; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ8RpPQpWuomiLvwjk3uovF6+uc5LQwN2VY4ctUFEBc=;
        b=yfU6/ylXO3OdTM0k+QgkBxEUvb/719Dq7FSFJCATdd9ylvzQK6MF+5QiYAjSf87ez+
         Pu0it2eiPmz9yWhxZ+/XBYeiydwciL+5NkOzKk554o7gTaM8d9m8OLZ5IWtKQD8g0Hl9
         9u+l+S/NcgC/gbvRgg430bI4WZHwTLGtJqi7j3iuhUuECnWRPcgbGxEa6auMhZxvgfsT
         BXOvlmjNQKI3cHfTnU0DOPtTPyWc0mrix5zIjCqNy4NBhepMJmfNvCNasEqGh9uOFmXw
         1x6V4OVHwnMpknOPg3AMg0FMSpEKorVpKinmfl2O+fzWNx3Ai1XbiIgEVFABPJhzXDlT
         PpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176954; x=1790781754;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iZ8RpPQpWuomiLvwjk3uovF6+uc5LQwN2VY4ctUFEBc=;
        b=iGIY7ERcNRC/SEXVPPTpb9uL3xBhqnek5WyZm0xNsRwcfLmxRfkAlB/7HiwJmA5Z+C
         Z1vqj8zMEUzvRtr9XfQk60l1r7DGDQpebBIaoDU8m7mhtenRoj9lHulgm9iBQOUg5N1d
         eMLWlyTqFvuba4W8pxhHapCeVaMSe6e2oNk0HEWfJu3Qx5ubP6Jh+nz5oyVAlzbUvGHW
         dGeqMVGNuAMzkUp2IifSa3oBGNEhUWagCCyCUL+SIwd1gUTYapJaiSPJsyFaxf2asdP5
         hlfUwzJts1Fb7YaOA+8tnsf78Nz/2paz9LMoXCAdUGxrnvuPHOOzY3PouOnPfNi4IUgH
         lwKg==
X-Forwarded-Encrypted: i=1; AKwUvBxK1uh1K9ECLO0JH0/I9lI7mC2tCsc0T16BOXDb5VLjrfUT+Gql2MrSGttXbBZdDraaaF4=@vger.kernel.org
X-Gm-Message-State: AFuF++k40dAKNrdMv7hSoNW03paE9zgZTQe/cXrFWfXEiapW8VJWAcyz
	9NC1yyLjAt+hL8XV4Rk3enJM5yeBqeiFBKDcHjfLv+jEguesufTMlIH6Op1j9H155xWl6Ml2aPx
	g752/JGljuFWCCkqYtbIQbOf5bKbUBcDKXHBHrNIOtA==
X-Gm-Gg: AYBFou0LskldrRNydWu+Um97rgJmfc4H/kshN3lic72k7Ap3aq7Wbq78mipyNkWMOl1
	Q1qBwGD/FKbXn6XA+WBpqEGu//OofGf/FzTrgVVPHbRJtQ7yUhWfjbTXLO7d7ocnkkHUzkVx1cj
	QmsiyCvOMTAqrMqETGtiCjfhmKVKedA/kD3CDA/t8Ml0KywCmrGwAcUnARJoi+5WT1306uS8RtR
	XrRSj0FcOTBh4TGif4COk57hI1p6b6PO5Zo/TKVhWjczVYSduyyIUW/vrIqMxwa8cHh3jvHBWSw
	aDDhLXBPnKl9zIPkvUWFUvR90mqlFPnk1V1jl5aJhcLDdDVl2kN186w=
X-Received: by 2002:a05:6102:14a1:b0:7a7:7d3c:248c with SMTP id
 ada2fe7eead31-7ac1b9284c2mr2783278137.11.1790176953250; Wed, 23 Sep 2026
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912041220.444715-1-main.kalliope@gmail.com> <20260912041220.444715-3-main.kalliope@gmail.com>
In-Reply-To: <20260912041220.444715-3-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Wed, 23 Sep 2026 17:22:22 +0200
X-Gm-Features: AclHuK9RzOpNJXNF7_8ky-O5PRlAZRO1N6Z9BojyMo80dP_J3h_DY_FPoZ03fvM
Message-ID: <CAM1=_QTjcyMtMLawSFnCt2c5wJJ-if40GSfo+o-CoZqcgx5wYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, mips: Add support for BPF_MOVSX in
 the JITs
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, paulburton@kernel.org, tsbogend@alpha.franken.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

Thanks for the v3 series. Looks good, with one minor comment below.

I have applied all three of your patch series together, along with the
two fixes I just submitted, on top of the base commit 15972a29ac91.

Nicholas Dudar (6):
  bpf, mips: Factor out div/mod emission helpers
  MIPS: uasm: Add signed div/mod and sign-extension emitters
  bpf, mips: Add support for BPF_SDIV and BPF_SMOD
  bpf, mips: Factor register moves into helpers
  bpf, mips: Add support for BPF_MOVSX in the JITs
  bpf, mips: Add BPF_MEMSX support to the JITs

Johan Almbladh (2):
  bpf, mips: Fix immediate JMP JEQ/JNE on MIPS32
  bpf, mips: Fix BSWAP 32 and 16 on MIPS64

I ran test_bpf on QEMU targets, with the following results. All tests
pass on all 12 targets tested.

MIPS32r1/r2/r6, big and little endian:
test_bpf: Summary: 1062 PASSED, 0 FAILED, [1041/1050 JIT'ed]

MIPS64r1/r2/r6, big and little endian:
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1040/1049 JIT'ed]

> +/* Register move operation (32-bit), optionally with sign extension */
>  static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
> -                        const u8 src[])
> +                        const u8 src[], s16 off)
>  {
> -       emit_mov_r(ctx, lo(dst), lo(src));
> +       switch (off) {
> +       case 8:
> +       case 16:
> +               emit_movsx_r(ctx, lo(dst), lo(src), off);
> +               break;
> +       default:
> +               /* off == 0 is MOV; the verifier rejects other offsets. */
> +               emit_mov_r(ctx, lo(dst), lo(src));
> +               break;
> +       }
> +       clobber_reg(ctx, lo(dst));
>         emit_zext_ver(ctx, dst);
>  }

The naming is a bit confusing. The name "mov" means two different
things here: 1) an instruction with opcode BPF_MOV, 2) a MOV
instruction (as opposed to MOVSX). I would suggest the following name
changes, applied to both 32-bit and 64-bit JIT variants. This would
make it consistent with the rest of the JIT and solve the MOV naming
ambiguity.

emit_mov_r32 -> emit_mov_movsx_r
emit_mov_r64 -> emit_mov_movsx_r64

I would also put the clobber_reg call last, after all emitter calls.

For the series:
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

Thanks,
Johan
