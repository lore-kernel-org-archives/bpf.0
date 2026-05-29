Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8137A488
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078976; cv=none; b=sSi7ZinmQKpBHeI3vUBA02SXqCNOgA/DTbziKzgkq2s1eX67AS8NG7nMRDEUKIFrV4Uqo+cowRT/bx+0oIH1n5s7UR9gTbPHTJrOlFFxEYNJDMJsdgA6nFIqvbvQBrmjTPSBgkmeBx/51PIGJlTuclkA2fEaD1DGDuYlyee0cQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078976; c=relaxed/simple;
	bh=24iuiZ3LteIBYvkyggyQoLiZyH3FrA+n7MSWWIIDFRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4DTHpno8Pid8MkmyUIiOYlP+/pLErjEpaPeR/4FN1fcXYR8m2Gkr1E+f2u8MhUJP9q/BlnmQs5NDZYGzXMIrvo4HEIB4SuJCgZYYy9JNGaDEtXkRGBCeIzNOqAjPSMaji9UALhnvIgQZ+xcWdoF00RrSOKtA+k/2GDF7MgSkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeeGJydc; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeeGJydc"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304ffa40c5dso129459eec.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780078974; x=1780683774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vgH3lUxWVKe+oisd9xMmUdBp+V1ZNkyclEW3dwS81A=;
        b=aeeGJydcub0UJf1GnHmfy3uXtfqM1ze7QQmI0ZdMLLzXBRyqOCJlOHCuO5QMC28mS0
         DcxIxpwPHM3eljkdWVTOaibSt5ZE77sTg/ICo5QMKGCEi+HnD1KUi6ZCoWZ7LA9MLXuk
         j/5eRLLb544qbbkvf5Dde6y9aR3IG7fXTK++7itmK6bZ1ayb5VQBSytbQZKlq992exAr
         52xp9k4twLKsfqYi5zlmTJP3pm4hR6GrhWOdcnVisGNBOxPLkSEnG+X6cSuAw04fFpUv
         EEYkzlxFcmbjJ92KtHAMv4KanY/u0Gzv8UtkROew3+1OMpeT4Kwsrr+7z+M5kCymbJpF
         bwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780078974; x=1780683774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vgH3lUxWVKe+oisd9xMmUdBp+V1ZNkyclEW3dwS81A=;
        b=r2B9t6cT/SWVLSewwQ+pEl0Shpw8YLGoVwQnTReVD9xiI3AFXnfWvIEGkF3tAyI6tm
         d5Zv+iNPDO4zQLY/Qz+siMv0d8X/6w5Xwkk2EwW52ECZ0Vjqs7tCwRfvEiZ1wVJfstXM
         PZkvtGr1kEn0lyOLV7U7pM45kAzc6mKXDcmqoV1aPhNpPtSr1hMtC9X+ckFeJ+nRS4cQ
         VEWMH0zWdrv56GnY4VisGhapl01n9PSoS6LftFJ8pBKSvn/j77EzTbKBvXuHlTzVCFEe
         r2chNXfps5h7FF9a8hdVvZJBhDEdPIz+6/kAKuJoRYlfA0eOFh9yU4wbAASEL5Me9Nv/
         zbew==
X-Forwarded-Encrypted: i=1; AFNElJ+lmWgITzl5HEJ0NeOOH/enY79gpUGYmwmhrf4cwtdHnMuJq3yRJFkT4FQMyGK1xdSlovU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1Ou5oJJjZPX76Bl5AP1Jwm1Pwp6dQXWEGq+8f+eSRC4R+cNp
	2SA88AeiEYOQZaXL3zozECkNTrzEUOhm+hFE64U6tn+fnf0ETw926vd2
X-Gm-Gg: Acq92OFuuoFdL/5/bXkrKfXv/8KrE41zuWeiI8SYa20PzW5xGp36T0w5QBtG8I72eZd
	v1ksVss8hin5xKcdn/6O/M/s3SUptSDMy2GyDfQHq8xxhAehi0In2LwweUzIxbzQNX0KWwHlT5E
	8ryHVbBOZimpXp0xz4dYXQAZ4g/Y8coO+pqsSnq+1QTY+w++g11pH749ZKn3q2+OowjMf18aUu4
	YcgqgjoD5Y7an3Eo4bnmHDtHPqxUxLgr0shFuduNBexGivvrJYkRvOYTE5wm35VvOtUPEX7/kJz
	VjzGhoUZmRufZRYe+LshJPJ8gsqfb0I2dUnMKvwXx8AJiLauVAaI4vrxs1IyNHiUVyS4OIHYytI
	nioDhVPl3Nh/IdptTMxq1ui/ZPkInNE8v5G9LiH1k1n+i4TRMiwRQMT5ctkLHwIM4McPiiHwLFQ
	2Hm4ULXNI4ydU4GD3OrfzB4L5+spsbQ079gMGz/xTmgLaKnKPsrYrZgKrQ0FWreQ+B+rHx4fzvV
	6hxN96ZKNbOrqGkMdo=
X-Received: by 2002:a05:7300:1485:b0:304:de2b:446f with SMTP id 5a478bee46e88-304fa659030mr452114eec.28.1780078974235;
        Fri, 29 May 2026 11:22:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cc2c:f0b5:a02d:c0fb? ([2620:10d:c090:500::2:a9e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm2041892eec.4.2026.05.29.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:22:53 -0700 (PDT)
Message-ID: <7b6a04a18a0ec819802756a70566c6ebc36e88bd.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, zhuyifei@google.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 11:22:52 -0700
In-Reply-To: <9a2d5c2e5819a7f4fa39521922b5320f79a61d4117a7da77fc266002e8db7df0@mail.kernel.org>
References: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
	 <9a2d5c2e5819a7f4fa39521922b5320f79a61d4117a7da77fc266002e8db7df0@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 08:58 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7fb88e1cd7c4..a2ee316f7ec0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16297,6 +16297,73 @@ static void sync_linked_regs(struct bpf_verifi=
er_env *env, struct bpf_verifier_s
>=20
> [ ... ]
>=20
> > +static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
> > +				    struct bpf_insn *insn,
> > +				    struct bpf_reg_state *src_reg,
> > +				    struct bpf_reg_state *dst_reg)
> > +{
> > +	struct bpf_verifier_state *fork, *cur =3D env->cur_state;
> > +	struct bpf_reg_state *fork_dst_reg;
>=20
> [ ... ]
>=20
> > +	fork =3D push_stack(env, env->insn_idx, env->insn_idx, cur->speculati=
ve);
> > +	if (!fork)
> > +		return -ENOMEM;
>=20
> Can this catch a push_stack() failure?  push_stack() returns an
> ERR_PTR() on every failure path rather than NULL:
>=20
> kernel/bpf/verifier.c:push_stack() {
> 	...
> 	elem =3D kzalloc_obj(elem, GFP_KERNEL);
> 	if (!elem)
> 		goto err;
> 	...
> 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
> 		...
> 		return ERR_PTR(-E2BIG);
> 	}
> 	...
> err:
> 	...
> 	return ERR_PTR(-ENOMEM);
> }
>=20
> Since an ERR_PTR is non-NULL, would 'if (!fork)' be false on failure,
> letting execution continue with an error value in fork?

Should be fixed.

> > +	fork_dst_regno =3D swapped ? insn->src_reg : insn->dst_reg;
> > +	fork_dst_reg =3D &fork->frame[fork->curframe]->regs[fork_dst_regno];
>=20
> If fork holds an ERR_PTR here, does this dereference an invalid pointer
> such as (void *)-12, for example under memory pressure or when the
> BPF_COMPLEXITY_LIMIT_JMP_SEQ limit is hit?
>=20
> The other push_stack() callers test with IS_ERR() and return
> PTR_ERR(), including the other_branch push in check_cond_jmp_op()
> itself:
>=20
> 	other_branch =3D push_stack(env, *insn_idx + insn->off + 1,
> 				  *insn_idx, false);
> 	if (IS_ERR(other_branch))
> 		return PTR_ERR(other_branch);
>=20
> Would the same IS_ERR()/PTR_ERR() pattern be more appropriate here, so
> that the -E2BIG complexity limit is also honored?
>=20
> > +	if (is_jmp32) {
> > +		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
> > +		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
> > +	} else {
> > +		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
> > +		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
> > +	}
> > +	return 0;
> > +}
> > +
> > =C2=A0static int check_cond_jmp_op(struct bpf_verifier_env *env,
> > =C2=A0			     struct bpf_insn *insn, int *insn_idx)
> > =C2=A0{
>=20
> I could not find a later commit in this range that changes this check.
>=20
> On the commit message:
>=20
> There does not appear to be a Fixes: tag.  The commit message describes
> this as a "verifier regression after switch to cnum based scalar
> representation", where cnum{32,64}_intersect() over approximates a
> [negative, positive] range when comparing with zero.
>=20
> Commit bbc631085503 ("bpf: replace min/max fields with struct
> cnum{32,64}") introduced the cnum based scalar representation and the
> cnum{32,64}_intersect() helpers, and is an ancestor of this fix.
>=20
> Should this include:
>=20
> =C2=A0=C2=A0Fixes: bbc631085503 ("bpf: replace min/max fields with struct=
 cnum{32,64}")

I don't think "fixes" tag is warranted.
