Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4673CEB8B
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860746; cv=none; b=BqrNBS26/wo1Xy0f/cVIL/FXvk/OyoJelLOlFR0EQWx0hfs/7rZTrajl2XJzQQzWzF338+3yBQmjTGS2ZpVAIR8i0hOmH0jj6ASKc+jN+YaMlJ5K1dgVn5qp/Uw5d8f5iTDGQx/wIeI6k6XSIT/DHf82idaRbxZXz+ix5gzWjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860746; c=relaxed/simple;
	bh=oQe47HCWpQOJYGWLWLMp33kC/KkFmw5PFqBTLNfkR3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOIBArNEEo9VIddSPMnEa7TVFC8t6qLe/sV+B1u1anYkz34arrxuLylRps24QvG8ECTMw1YMrpWsVaqoZF6HEfKAeAVT5qwvP6fXUyktAOclta4+pQY3KSaY1KbK1q0ttkWUVimzb5B08z7OFUuIe7Bh5xbJfVnhssWJKwXh6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY4Ovz1Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY4Ovz1Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so22740125ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786860744; x=1787465544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ULRfCjguHTONt3gLG0FhqPCFedzK2xvW73l7r2p25bM=;
        b=kY4Ovz1ZB0DtzMaxTsctN4iL/5ED4cRhRsiSLCPeDIvjTvzVnY1zTZmZCAb547yNTr
         E93L/VT28LEUPnvG6hCN2kAyEy4NnUacPa5P9c87MIS7uhgbMDpEhCCB8BpZUw+QlFjR
         Rto+SvtWwO2JwBICW802MU/DWG+lwr1emNHiXuoaHnBD3DGHdftJs+HoMMJ0NZzTP7g2
         pCVDaaIZSRQGHpCcTPzemBYOwZvL2wALYpYThGRJOwLLn8iZ+1inbIoe63lw6d1LeqNl
         62Td65sRqgJPIX+UPcOv9At7kPpj4LGws1+/a5x77xd/IwGqmI1PLSHVLNS9J6YvhVxj
         zvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786860744; x=1787465544;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULRfCjguHTONt3gLG0FhqPCFedzK2xvW73l7r2p25bM=;
        b=EKe0fg2r2ZYl0a4apx6ezE0t21ULnz0ZDgjaWlOLZ4Ae0CXpo1SfCr3yLekicgTn0/
         YLM3wKx/Mn0x9nhgh0C5BhU3UKeArts795cXyqktOeumzuFukCs7NUtAEwo6r4wH+Gfw
         +TydyW45EibdEGhzOtqbStLwqINDYtpcNp/Ag6InDag0/hFtaOub5pRHDM+auMgcG+SS
         ONpTEMVsZXYFq5xOwX3D3aBSnDgTSkZhwuUpWXo7jKXy34omuRzo+rNg0MWk/Gue1UzV
         pXjPHiK2kz26jYN2x59thz7vrtsI2LGtuG7rB+OxUSEnHSOgUNcKAyVSqysHnTC8AtHm
         JLpg==
X-Forwarded-Encrypted: i=1; AHgh+RrOUQ6/qwrJU42exNXTxddg9V7V8w6bQ0CJI8jmx+MdT3dScOFr2m848TMooBzZjtcMGjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHt07OpM4ilyoUu+Ee7YQVdwHdIM1piK9cKEsZkkU361RUPBs
	/cBDiQs1yu3Cw9IvefkT9SgfA1UnOTmXVl17NJ3kYzM/e6yY/3ifvuJY
X-Gm-Gg: AR+sD10cuWncndB4NhKTLh6v6qyWCmrS7526TiC/brItLsA85zA+VrubCZNaTiY9Vff
	QdEHIOIDNEgJ3YG7QjQdZKHy0beNN3IvUhTPBYZW9TkHuvVpqDWsOd9Bbuos14xD98afT7vvg6t
	5zJoPrRNZp115ny8wd4FADtFkKBjUKmCeVTJMXEPl+w/SNsKmblWTyl4oxY2Wl3DcuM2wKBghkC
	IOA4x2Cv4fh6zzj8SErPM4qkOcVbjYtWWMLovS0Peu8FUb92548GUs05Ty4hdzVOahtg8j9XAS/
	s5ZRP1hOlQCeEEl+Jb5krdng5aCmCHlU5LZqXczxA8FrqH+GEwU4/PNYqq8fozOaTnh29naEKdC
	DvCSC9xYqy9HjJOHJxy0mXlcYLYInB/tabZLlbKIKVSE9J9Zk2rzMx85ykzDLtw2EEcPy09WMsG
	nZSS16k8e5+ZyJMot4Xpu9JkeSrWCAbc8knBeoYrXSt7/UhBe6fDadr2Or1sQJjVbxejRXtfQZL
	UslOnn4ERRpRijPlVuVIeM1BPM=
X-Received: by 2002:a17:903:3204:b0:2c0:e2ea:6b0c with SMTP id d9443c01a7336-2d3b0d88bd1mr212582545ad.21.1786860744116;
        Sat, 15 Aug 2026 23:12:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7a5bd4sm23719465ad.24.2026.08.15.23.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:12:23 -0700 (PDT)
Message-ID: <f342767e1a33839d5074ee90971d832e21845651.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/14] bpf: Preserve R0 lineage across
 helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: sashiko-bot@kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com, 	martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 23:12:20 -0700
In-Reply-To: <4f50ce2b6d7a797d977cd80a04a3012fc7dd0c7e57a8cf043f13fe88fee89cc2@mail.kernel.org>
References: <20260816015746.2632990-4-memxor@gmail.com>
	 <4f50ce2b6d7a797d977cd80a04a3012fc7dd0c7e57a8cf043f13fe88fee89cc2@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 02:30 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5d0a2d3ef594..7ef324e384f4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11024,13 +11024,13 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> >=20
> > =C2=A0	/* reset caller saved regs */
> > =C2=A0	bpf_diag_record_caller_saved(env, regs);
> > +	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
> > =C2=A0	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> > =C2=A0		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
> > =C2=A0		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> > =C2=A0	}
> > =C2=A0	invalidate_outgoing_stack_args(env, cur_func(env));
> >=20
> > -	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
> > =C2=A0	/* update return register (already marked as written above) */
> > =C2=A0	ret_type =3D fn->ret_type;
> > =C2=A0	ret_flag =3D type_flag(ret_type);
>=20
> Does this produce the correct diagnostic message for void helpers? The
> new bpf_diag_mod_begin() is now opened unconditionally for all helpers,
> including those with RET_VOID. Because the snapshot is taken before the
> caller-saved clearing loop, a void helper now generates a history event
> with R0's real pre-call value as old and NOT_INIT as new, with reason
> BPF_DIAG_MOD_WRITE.

This is fine.
