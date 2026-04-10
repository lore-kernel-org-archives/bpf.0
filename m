Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368863DB65F
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857570; cv=none; b=un0cV9d1SuVw0yyaaDG5baoL4j0foatiKd0Fnou2G6i/fqIJj3oPk+HZ/tMdUlrrpZk+aT5rUwBFvCF9AIEji4/N9A5Jgcq5taGZNkENZWANlBckYgSJW0dh53i0FBR31p+qWmbVAvxcoQ4IhFYl53RB29WtLfZ7xsfm3EtU0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857570; c=relaxed/simple;
	bh=n7oFRkk1PKJfe23pRYS+/7JNbVM4069bzBNYpCw07cM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnsKARAyIDtzzfsXDEp/gPnxQlGAUsoGX4Svg/YXiSJotyEUkk75iq+VkvEwL5QZwGVmV1BWC+jIJ5Zs3krsKeVQb25W+kER0ocGNlveqW5B2QhcZhTuJ6MSWJeM0UKvUtHtXs3TaONRBnZIq6BHAs+oqg+Ot9usz/P9VnEKzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEDLkIvt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEDLkIvt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso1632120a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775857567; x=1776462367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7IZ0mqf87x66O6Gmbth2PgvdkPvROcPAZGW0SpMp8Zs=;
        b=KEDLkIvt8/H8vGxcjULtf+c5zWCbivBxUe/DfA9OmaOj9yEnRqoYSqjLQTZ26zMKE1
         STI7/ShVEVxiAOARToIrdd6WUV03ipOJfVNFQcOBFCGuZSngnWj3hlMrs56QVCIaGXhr
         h514RASy8BqIOFIedgEq1Wap4anAOY3z+g0HTf8bzazZE3lO3NQOIod1Os5tB3EOkdMW
         2gCfwvSvCPhbGdedR8ZhJxz8kT/B9IFlYck8x2iN+4I4XAv/Fk9Abnefxoun1GrtIu9A
         FKdOTAhzvxIZROvlR/M4mrle2jnUQ2zyfgmYPeun86phx3l+JedgF9sNZA7BCPV3YUFb
         LehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857567; x=1776462367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IZ0mqf87x66O6Gmbth2PgvdkPvROcPAZGW0SpMp8Zs=;
        b=J+YUtuhvSTOhVW4t6KBvyErWZhdIw9ODNLgQ/hGQ5Xd3+tmYaRTRbGtPEoz0r/Nne/
         9HkkIaJ9m7dVJ+i85F+0nP2XAd6+mcxmjI9fKKjEBFw0cvlUyCRqTbQR1MZlBLzHD1Di
         B3Nb4QbLbG0HWTJI5IhBLJWBe4evOd498XyHXEGCLrz7yprojBSqxj5P/5JHzOfVfGJP
         nioEgcbTs9xDTEy81doMJDpN9+x1/l5P0wa/py7/H4lCNnNdljW1uLTzMQMSYSBMhi7w
         x8nlHMgtzAMGr6klrGcGh873bdZHefcazw7ILdENKwM5xgUfzAd7+X7x0SUYm42b+/J5
         XJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWATppLU35Y3wSRW32SxnFVz0/pfQinY78n3JxlsfG78COFKpFxBA+Gq6W7e2IUGSr/GdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+D8xaw69o9g6oJgfzg7grQTUYrO0wOWaWu8AtctWkNLPPbxj
	xImzxwIbYpjHru3YPgwNCJbhk2ffcZR+tVEg4kqAe8jgrEfnKXCLEJq45e1kodd2
X-Gm-Gg: AeBDietD1Yvg8hRaAE9E6Ob4bUMCm7syXt8u/QlzjKRsJpsLXZFIQCT8WmHH5/d9D7Q
	Twi1oU3JVPRqhVCiWvdc3V9ya/vkIn4xOQZWCXklk6HwqTCQpad+XnJQtZj+vzh1TTiPQQCFA6A
	tSlB0g7A0+eQfebXz4XCsO7sVWMmqcDRFV0fzZ/6KjgYPIfbBTWFGU3SAJc3MXmVMEYaKjsFatL
	znZgU2nYOYB0htTaLg5uSz5ERwWxLKn0U4KauJTGh56cdto1BbxRUCAHPpjG248h/JnS8A8fIdL
	nm7ZjtSDakOI1V2op1vVVUbmzQVVvuoVKnbSHp+b/2xYXU4w1uDLeKnjjZDTlbUn+Ap4U3bslzK
	UEUdv06+adrvETYho/BeptB3mil2LW/TftqDX3DJMLOdZ8Q3I1Cu7ippDZdyL00l4tEHIaE3mTJ
	ml8SNchR+CzDqjfHSnd61OFupr/9aARo9tI01a9nUVWyFJJ8NnH9y4
X-Received: by 2002:a17:90b:1d50:b0:35a:10b6:1208 with SMTP id 98e67ed59e1d1-35e35464c9cmr8492343a91.14.1775857567207;
        Fri, 10 Apr 2026 14:46:07 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f996sm7816017a91.12.2026.04.10.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:46:06 -0700 (PDT)
Message-ID: <71cc59df90881090e7e74ca0cab7cb8b64e27979.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/14] bpf: introduce forward arg-tracking
 dataflow analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 14:46:03 -0700
In-Reply-To: <fb5b061479a00ba43992f755435e158bb913fb80e5ce106d20c81c42f6bb4356@mail.kernel.org>
References: <20260410-patch-set-v4-7-5d4eecb343db@gmail.com>
	 <fb5b061479a00ba43992f755435e158bb913fb80e5ce106d20c81c42f6bb4356@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 21:44 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 7b31d8024c61..49b19118c326 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>=20
> [ ... ]
>=20
> > @@ -886,6 +887,8 @@ struct bpf_verifier_env {
> > =C2=A0	} cfg;
> > =C2=A0	struct backtrack_state bt;
> > =C2=A0	struct bpf_jmp_history_entry *cur_hist_ent;
> > +	/* Per-callsite copy of parent's converged at_stack_in for cross-fram=
e fills. */
> > +	struct arg_track **callsite_at_stack;
> > =C2=A0	u32 pass_cnt; /* number of times do_check() was called */
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index a3af5972520f..c5d6760454d6 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static struct arg_track fill_from_stack(struct bpf_insn *insn,
> > +					struct arg_track *at_out, int reg,
> > +					struct arg_track *at_stack_out,
> > +					int depth)
> > +{
>=20
> [ ... ]
>=20
> > +	cnt =3D at_out[reg].off_cnt;
> > +	if (cnt =3D=3D 0)
> > +		return imp;
> > +
> > +	for (i =3D 0; i < cnt; i++) {
> > +		s16 fp_off =3D arg_add(at_out[reg].off[i], insn->off);
> > +		int slot =3D fp_off_to_slot(fp_off);
> > +
> > +		if (slot < 0)
> > +			return imp;
> > +		result =3D __arg_track_join(result, at_stack_out[slot]);
> > +	}
> > +	return result;
> > +}
>=20
> [ ... ]
>=20
> > +	} else if (class =3D=3D BPF_LDX) {
> > +		u32 sz =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> > +		bool src_is_local_fp =3D insn->src_reg =3D=3D BPF_REG_FP || src->fra=
me =3D=3D depth ||
> > +				       (src->frame =3D=3D ARG_IMPRECISE && (src->mask & BIT(depth)=
));
> > +
>=20
> [ ... ]
>=20
> > +		} else if (src->frame >=3D 0 && src->frame < depth &&
> > +			   BPF_MODE(insn->code) =3D=3D BPF_MEM && sz =3D=3D 8) {
> > +			struct arg_track *parent_stack =3D
> > +				env->callsite_at_stack[callsites[src->frame]];
> > +
> > +			*dst =3D fill_from_stack(insn, at_out, insn->src_reg,
> > +					       parent_stack, src->frame);
>=20
> Can parent_stack be NULL here? bpf_compute_subprog_arg_access()
> allocates callsite_at_stack with kvzalloc_objs (zero-filled), but
> nothing in this commit ever writes to individual callsite_at_stack[]
> entries. They all remain NULL.
>=20
> When a callee receives a parent-frame FP-derived pointer (e.g. r1 with
> frame=3D0 at depth 1) and does an 8-byte load from it, this path is
> taken. fill_from_stack() then dereferences the NULL at_stack_out:
>=20
> =C2=A0=C2=A0fill_from_stack()
> =C2=A0=C2=A0=C2=A0=C2=A0cnt =3D at_out[reg].off_cnt;   /* > 0 for precise=
 args */
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0result =3D __arg_track_join(result, at_stack_out[=
slot]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0NULL dereference
>=20
> This appears to be a bisection hazard. The next commit in the series,
> 0458daba63a9 ("bpf: record arg tracking results in bpf_liveness
> masks"), adds the code that populates these entries:
>=20
> =C2=A0=C2=A0if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0env->callsite_at_stack[idx] =3D kvmal=
loc_objs(...);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(env->callsite_at_stack[idx], a=
t_stack_in[i], ...);
> =C2=A0=C2=A0}
>=20
> Would it make sense to either defer wiring up the
> bpf_compute_subprog_arg_access() call into compute_live_registers()
> until the next patch, or move the callsite_at_stack population into
> this commit?

Yeap, should be moved.

>=20
> > +		} else if (src->frame =3D=3D ARG_IMPRECISE &&
>=20
> [ ... ]
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/242644=
07165
