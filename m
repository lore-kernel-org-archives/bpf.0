Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656530E0D5
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562919; cv=none; b=D+itutIyjJuTuU2RBDTKBDLsSTrVoZO7yFDxhWU34m+O+D2aqNe2KXupWB68fkbbams3RUe2HUaryk25rfWDh1j5fyOAFMmnY84ygm+JVfPWlBDl4Dja8JKIaUw+JSsT0i+Yr4yi4zDt4FcP4tmaoS9N25XEzjlMYoeZ1xVYXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562919; c=relaxed/simple;
	bh=uFwVacpoBKqf/34/DHwdM2PKG4cpCrot070aByBuvGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAQP8xK7ZXjEZcTVWkj6zhUCQeXfsD0DmMUedIu/ZUHE41/ISA541yBAOYUmpPYposIhr5xxkodwT44rAO5bE8JgirVvlq79XuwMiYMLiU92fusoMRY+siPBfnxyMoyDExD5RPgfZV4t39B0A74XTFDp5vQfWQVHYmJq6QFyqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf4oTGCy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf4oTGCy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf27856f9cso17677625ad.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785562917; x=1786167717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fbpEs4nLlgM9ipjn1m7Vl9bon7gR0+FPoNc51UueVOw=;
        b=Yf4oTGCyKx2pi9c3elespFVrgWLtJcRjqZDx8K6F2oLxp76rJODxgar6An3cTz5QpC
         2G+XQ1UzAiJSw5pJNENow+rms7oOS4Y5qmXJztXuRk3bnLFKdUNjRf5IvLJbNKvZyNmr
         MusdrHQmVFoM9Gyy5NFw8+0/XZvexMolIP/BbeTYxUAuTVezBaex6xBWttzm+FYz3Y8n
         ixadklmESvIkPzmJinSu4CGOCcf4AejGvqz2tLbwI6hYUVL0ONj/2Rkg89hLcJy5HI16
         v11CfNDI8PgLaX2fCmvMSxzPCFKnI4FnwAuJWgUpUTfEOkAb4HHRKCZcVQvP30Mowdb3
         Ve1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785562917; x=1786167717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbpEs4nLlgM9ipjn1m7Vl9bon7gR0+FPoNc51UueVOw=;
        b=gJXxzUuaXKDroxksCK1n25HYvqmB9XMZbKVYR10SjlaziHOM2NAQU/V1G5ZJAEOZ2B
         U2BB1Uurgac+LV8bum2PnsWAa4JamwxyRLbrbEir7NIvoDZbcNGRJDA+n3L5RP4/Ump2
         HDrPyx8bO5nKmBEA3IleNiZXTrKmfbFxYO9BQAcbke2D1fWYF/XQQp5GR5hnKQWpxHy7
         7HvEvqWwoZr0wSuWtHVDxxSFwBrYhsdP3LMp39aivMCON/hqfhu8dO6Jnrf2wYyNp0Yx
         neBzi/kBrlBlIxRIZP7LacMHVEwFsszA+JhQQwjW8RntUJyFF+zo03kQxh2MgbpTFMsE
         2qaA==
X-Gm-Message-State: AOJu0YyrV5hSNbyTiaDQBdV2ssbazU8jlrKYB5qAvjFwmDhvFwebeq+r
	2WZGgiHU/2Mdh3IAYdAaDLKJFNCi9ApRQXXkm1cDTNYpa2ZW0oaHwpIwcJXu1duk
X-Gm-Gg: AR+sD12gwXKPQFf8h5GtHEvXDITC696iNt8YGKFBHFbpXh+FgJoXUU1IWAhTyA/bN39
	7JkY21AfTL+8N8hZOBkHA+00Y1kU98BVdOCy09ybCi9MzSrRPsZCptYs7MpAzX19vexnHHwBH2g
	fGhMYzJJ/2WmS+o8oFGoAwdmLoMwqbCC/hgk57tudydP9Vt+eAYfR8usnGzLBWx6qsKcTKgCMj+
	OSIx8T/DD9naKNFz13C5kLdCzLcHJGfb1caHbxt7Hxw0E9ZavQBlENBBVGr1lNEjYc4oTh2nzYN
	UJLjzJGWtiRm5fM9z8d+NzGVMlH2NAQGaCr73uCIRQAln6C/WL0vkZ98cwciLnOwyxgaKWgj7Tf
	5dV0RRQWp0Z8YY31pzH1BTstsjLIxy80NS3pcJAxq2hrcX2zKMOFdK/4cK0k4+NJ8LoFUoNyn2K
	6rL9M7IzJ2qgVReBph88l4oXZdf3Ptq0dvyGsNGn8dr/0H3WmNtNP1+mOZvwnnTQ5RvamSdDaIY
	4n13u5Zdha/RX7S
X-Received: by 2002:a17:902:f54e:b0:2cc:6329:b7ba with SMTP id d9443c01a7336-2d05224fa51mr24534955ad.16.1785562917096;
        Fri, 31 Jul 2026 22:41:57 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04aea0f8asm13919195ad.35.2026.07.31.22.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:41:56 -0700 (PDT)
Message-ID: <9a99c9f390d0caf48b3a523113ca8f71063f9c01.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: infer zext_dst based on static
 register liveness analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 31 Jul 2026 22:41:53 -0700
In-Reply-To: <20260801014230.CF9891F00AC4@smtp.kernel.org>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
	 <20260731-static-zext-v2-3-da4aa161e8c5@gmail.com>
	 <20260801014230.CF9891F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-01 at 01:42 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>=20
> New issues:
> - [High] Dynamically downgraded 64-bit arena operations and pointer casts=
 are missing explicit zero-extension on architectures requiring it.
>=20
> Pre-existing issues:
> - [High] Kfuncs bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_events=
 do not properly validate negative enum values, leading to out-of-bounds ar=
ray reads.
> --
>=20
> --- Patch [3]: [PATCH bpf-next v2 3/5] bpf: infer zext_dst based on stati=
c register liveness analysis ---
> commit 625c020066cfbb5a384d20ff5e1ad79faa898949
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: infer zext_dst based on static register liveness analysis
>=20
> This commit replaces the verifier's subreg_def based logic with computing
> zext_dst statically as part of bpf_compute_live_registers(). It tracks th=
e
> liveness of the upper and lower halves of registers separately to emit ex=
plicit
> zero extensions on architectures that need them.
>=20
> Link: https://lore.kernel.org/bpf/CAGKGUv=3DsOuqQtA1Ub-5JXfA4FPosJFYKAQE4=
B79cK+P1erxqtg@mail.gmail.com/
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index d0bd94c60fee2..77b84b367be74 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -2316,9 +2317,18 @@ int bpf_compute_live_registers(struct bpf_verifi=
er_env *env)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < insn_cnt; ++i) {
> > +		int def32 =3D bpf_insn_def32(&insns[i]);
> > +		u32 out =3D state[i].out;
> > =C2=A0		u32 in =3D state[i].in;
> > =C2=A0
> > =C2=A0		insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
> > +		/*
> > +		 * On architectures where 32-bit operations do not reset upper halve=
s
> > +		 * of the registers, the verifier needs to zero extend a destination
> > +		 * register if an instruction defines a 32-bit subregister and the
> > +		 * upper half of that register is alive after the instruction.
> > +		 */
> > +		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32))=
;
> > =C2=A0	}
>=20
> [Severity: High]
> Does this statically evaluate zext_dst before some instructions are dynam=
ically
> downgraded?
>=20
> If an ALU64 operation with a PTR_TO_ARENA operand is statically evaluated
> here, zext_dst evaluates to false because it is still a 64-bit instructio=
n.
>=20
> Later during verification, adjust_reg_min_max_vals() sets needs_zext =3D =
true.
> Then bpf_do_misc_fixups() downgrades the instruction in-place to a 32-bit=
 ALU
> operation:
>=20
> kernel/bpf/fixups.c:bpf_do_misc_fixups() {
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 if (env->insn_aux_data[i + delta].needs_zext)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Convert BPF_CLASS(insn->cod=
e) =3D=3D BPF_ALU64 to 32-bit ALU */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn->code =3D BPF_ALU | BPF_O=
P(insn->code) | BPF_SRC(insn->code);
> =C2=A0=C2=A0=C2=A0 ...
> }
>=20
> Since this bypasses bpf_patch_insn_data(), zext_dst remains false. Could =
this
> cause bpf_opt_subreg_zext_lo32_rnd_hi32() to skip injecting the required =
zero
> extension, leaving garbage in the upper 32 bits on architectures like s39=
0x
> and potentially leading to out-of-bounds accesses?

Yeap, need to figure something out.

...
