Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8F37E2E2
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626134; cv=none; b=FqdbIm83YbfsH47BdoyjE8Vjd9eQPxPV3YJgaGa3fFp3ZoJvhI2I2Xgja9PftAhk/dbeSB0zTiAuQHrK7AvqPRLDClB+rtBIaf/qeRY1hsnebX+5Vq+AKbzQVTJJb0ASiCVmIy4y6WSu39VAkxXVs4qwo55y2dd0NsrnPTwMCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626134; c=relaxed/simple;
	bh=YTK2yn3+JfV92/yG4TiRuAONdxqlJXtMfBVC+8Pu3V4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMd781jU3uxbNBeqMt1DGnKbBHS8EbEch72nFVV6l87zMfs1A8uq6aXFDauNXSvf6mn7DQvTWHc3E4yjZhg90uf/VO7Lv2XiF2PIEfqEyZC6pi2HB9b6OGvWjOhrD1e3BRxUUlURffaDkQw2RBjwAp+EQjXjMCX17hzVJdSmTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5B0MT4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5B0MT4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so14449475ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780626127; x=1781230927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SbyefUHgNqxFdyMQYhLqgimeHunRN3uVdpFaTQjZxq4=;
        b=WF5B0MT4ovfXQLDM0uW2/ZZ6kVr2mh1Ei9Oyxeg645vgWc+3fYMqHd4a37urKh8kge
         65g1RYTdyZKhvQXxx2qmp0arW20Ckk9VVriJgvptwfT7xHHoJb505o/YTfAJanGSwkOw
         Gs5gvoS62mV9XgtQPlH9e+kjGoqodDiVbfQgXzFvY5XhpRlfjzL529BuhvUToipTppqm
         mqv1XpEWCE3jBqjEwm6k4xW3lKkDD/mamGc2zo819yJYRZMVokwbaS6+t/no8s/I+jS8
         aTlHdIk6WD/4irryC/kQITtYJxc9GppOVjdvKxGjjSMLVIfnhJOS5xsAySGmIioMZJQx
         OuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780626127; x=1781230927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbyefUHgNqxFdyMQYhLqgimeHunRN3uVdpFaTQjZxq4=;
        b=QdMy+4Mrz6xENyCUZfkEI2XFIAKRzJjTzsQQfC1pfTGE4UEw49FbieCEtCP+0hAuri
         jBRWOc2xTASjYqyn11mTAGHlO2aX7eYAmuAQ8qWESxS5BdM20MmbyKlJjoHoj+NldjHL
         03LzxRXlkHw6VlVrcUaYBZQV5cu46uo8wjB2rK4FW0SnCQO1jonsOJ49VhXYbkanKrgD
         j4/vQqDOCRU9AWtcFdAH5wJwraU0QwgUiP59EvQpEqdFZnb+rADfozPSTDYtHjrXVHCy
         S0PK2OKOuyZKE+zZ4dJhFKEpOq5zWT0jzVeQqie0SstFqFU9yBGKMweOXMFGiff22jPF
         KbhA==
X-Forwarded-Encrypted: i=1; AFNElJ/mahv0DBA8vaOObMri8wUHDyhsrl2SzPcSYDavL0rCPfUugn8hSuZPKozWOGia/NWKbG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ha01JyCZNT+uBVW8wbaXkjt7uY7EgQO6oIrgQUbir5btFyPu
	oFRtALYiaeRBbCz73/S2FZqjBYEueEJGlNU1v/V0yVITCl8tyqb81d66Y49OOvUK
X-Gm-Gg: Acq92OHCfTkToM7n2nrqBHL9VLgbsNrOr8o0t7r0/FzBSZwt8tFI0AWjCXTX4ChPnVY
	dV2Kres+QrYph6MCZZrndZLxIB+r0IwRn5PFZXeOugY6ZKB2LAGZskXyu4CNyHV64QTlGcc8g6S
	611uyw4c6Xd++Og4TW2DbblApVlB8oEbUgwHzHA0DHOBVerXGnwuA3eZu+ydcFIyzFQQMyPMaxb
	SK6Qn+S2x8EbK5BU1WRtKW/UMCVKd6Eik6HOHIIVEpNX++NZx2TZXIIuGCUWMWAg7tay2r8STC5
	hnDx5uZPiVxktFHwMFZl6rm+9bnWa/s0Xp4Yc+6QThzj9olllBi1dZlLs4sbyIBioiLuH35SbwV
	rv9j0qqkAlUmwcVT3D0Azjtd1fmlHpTUKK0jMPdqnOsRthmABvDHk+1zGUjCEjtW43a4Hkej+5t
	7jzqCFrSJKWm1186RCSXAOmWraIrrHvT8m4hxe3tKkEtCxwEFiIcAYCC9FeHPRzQ==
X-Received: by 2002:a17:903:1b43:b0:2c1:88a1:9839 with SMTP id d9443c01a7336-2c1ec527f50mr5664095ad.11.1780626126715;
        Thu, 04 Jun 2026 19:22:06 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm72210575ad.21.2026.06.04.19.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 19:22:06 -0700 (PDT)
Message-ID: <f0163609ba2a533407a53ab4c754c559780d26f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, verifier: fold reg->var_off into
 PTR_TO_FLOW_KEYS bounds check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 19:22:03 -0700
In-Reply-To: <20260604180730.2518088-2-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
	 <20260604180730.2518088-2-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 02:07 +0800, Nuoqi Gui wrote:
> Constant pointer arithmetic on a PTR_TO_FLOW_KEYS register lands the
> constant in reg->var_off (e.g. flow_keys(imm=3D4096)), but the
> PTR_TO_FLOW_KEYS path in check_mem_access() passes only insn->off to
> check_flow_keys_access() and never folds reg->var_off.value.=C2=A0 The
> verifier therefore accepts an access that, at runtime, dereferences past
> struct bpf_flow_keys -- a verifier/runtime divergence that yields an
> out-of-bounds read and write of kernel stack memory.
>=20
> Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
> pointers") removed the generic "off +=3D reg->off" that check_mem_access(=
)
> applied before the per-type dispatch and replaced it with per-path
> folding of reg->var_off.value (for example the ctx path now folds the
> register offset via check_ctx_access()).=C2=A0 The PTR_TO_FLOW_KEYS path =
was
> not given the equivalent fold, so a constant offset that used to be
> folded and rejected is now silently accepted:
>=20
> =C2=A0 before 022ac0750883: the offset stays in reg->off and is folded
> =C2=A0=C2=A0=C2=A0 generically, so the access is checked with off=3D4096 =
and rejected.
> =C2=A0 after=C2=A0 022ac0750883: the offset lands in reg->var_off, the fl=
ow_keys
> =C2=A0=C2=A0=C2=A0 path checks off=3D0 and accepts; at runtime the access=
 dereferences
> =C2=A0=C2=A0=C2=A0 base + 0x1000.
>=20
> For a BPF_PROG_TYPE_FLOW_DISSECTOR program the following is accepted:
>=20
> =C2=A0 r2 =3D *(u64 *)(r1 + 144)=C2=A0=C2=A0 ; R2=3Dflow_keys (PTR_TO_FLO=
W_KEYS)
> =C2=A0 r2 +=3D 0x1000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dflow_keys(imm=3D4096), accepted
> =C2=A0 r0 =3D *(u64 *)(r2 + 0)=C2=A0=C2=A0=C2=A0=C2=A0 ; accepted, var_of=
f.value=3D0x1000 ignored
>=20
> while the equivalent insn->off form
>=20
> =C2=A0 r0 =3D *(u64 *)(r2 + 0x1000)
>=20
> has the same effective offset but is correctly rejected with
> "invalid access to flow keys off=3D4096 size=3D8", which isolates the def=
ect
> to the missing var_off fold.=C2=A0 Once attached as a flow dissector, the
> accepted program reads kernel stack past struct bpf_flow_keys (a
> kernel-stack / KASLR information leak) and can likewise write past it,
> corrupting kernel memory.
>=20
> Fix it by folding reg->var_off.value into the offset before the bounds
> check and rejecting non-constant offsets, mirroring the other pointer
> types (e.g. check_ctx_access()).
>=20
> No released kernel is affected; the regression is confined to the 7.1
> development cycle (reproduced on v7.1-rc1..rc5), and v7.0.x rejects the
> program above.
>=20
> Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for point=
ers")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

This fixes a real issue, thank you for finding it.

> =C2=A0kernel/bpf/verifier.c | 19 ++++++++++++++++---
> =C2=A01 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..c04941636ef4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4728,9 +4728,22 @@ static int check_ctx_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> -static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
> -				=C2=A0 int size)
> +static int check_flow_keys_access(struct bpf_verifier_env *env, u32 regn=
o,
> +				=C2=A0 int off, int size)
> =C2=A0{
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> +
> +	/* Only a constant offset is allowed here; fold it into off. */
> +	if (!tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "R%d invalid variable offset to flow keys: off=3D%d, var_=
off=3D%s\n",
> +			regno, off, tn_buf);
> +		return -EACCES;
> +	}
> +	off +=3D reg->var_off.value;
> +
> =C2=A0	if (size < 0 || off < 0 ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 (u64)off + size > sizeof(struct bpf_flow_keys))=
 {
> =C2=A0		verbose(env, "invalid access to flow keys off=3D%d size=3D%d\n",
> @@ -6239,7 +6252,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
> =C2=A0			return -EACCES;
> =C2=A0		}
> =C2=A0
> -		err =3D check_flow_keys_access(env, off, size);
> +		err =3D check_flow_keys_access(env, regno, off, size);
                                                  ^^^^^
This variable is not defined, hence this patch leads to the compilation err=
or.

> =C2=A0		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
> =C2=A0			mark_reg_unknown(env, regs, value_regno);
> =C2=A0	} else if (type_is_sk_pointer(reg->type)) {
