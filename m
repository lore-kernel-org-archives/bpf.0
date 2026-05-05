Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB063E3155
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007303; cv=none; b=GKaWKEWzZ4zyAh5sEcRL2WrAh3shl8p0rwyqmnBImzscG94wlu1/ubvdUgfRIF2xzknCLiFcRlZpiSJg8/KxcouXSvhxehv7HuJ0qm3MkyXum/n2fKCP+J58GzEBT3a5l4E49zZuwVPRtHUi6B6l6y1SlhlynKhwGLz9ELE0zC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007303; c=relaxed/simple;
	bh=Ra9QuESiH3L7qc5vHTdAL0D4CVFlgSy+CjpgOg8oRG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I7V+S5Wzuc42DxSCA1z+imO4PTlKeTZLXgTS6VSyXaEb2zyKHd4om4cECnq6gYAFAlWodo3AbHnlvL+QPu/crmA1M6zBpGYnXWaUavQDDCHtQaHwELiro7yh9h1b1GkQc1MHA+XhmiUZWuESSHdr2eDxAC7ADsVT7cJInZSS/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSDxxuCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSDxxuCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB501C2BCB4;
	Tue,  5 May 2026 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007303;
	bh=Ra9QuESiH3L7qc5vHTdAL0D4CVFlgSy+CjpgOg8oRG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OSDxxuCA7SMT5D2gnDNovoLZaraWtVadAr+hfGHts313eUzD+lk2CC0Y8RqdV2fg1
	 WQ9J9HyjHJHa6B1X32GreU5NH8uzpT/DoYJAfKcZEW2Xm+lXJfsZBnIbU7/8XV8wUo
	 UGl+2EZ8X5NTw/yQoFN2cv6gcCzwjYQiKxMDDczbnFQ4mjcILwVNSOx/crjF5DLn6j
	 XtExFtAE7EV4l43tUqaOvifp92dyRcfjeaIkeg/IEzBpJV8dFWXfcQhjFUPfMQQirW
	 kfhieAIlqG6r1HxK5WPbDLeaeuwBgbD6GuoQjKKWvDz0GLaix2vv9y8NJTqYne/hrS
	 yiNZ4/ETA1YAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 16/19] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-17-jremus@linux.ibm.com>
References: <20260505121718.3572346-17-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:55:02 +0000
Message-Id: <20260505185502.CB501C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Valid flexible FREs ending in a single padding data word are incor=
rectly rejected.
- [High] Valid flexible FRE rules for CFA and FP/RA produce unhandled enums=
, triggering user-controlled WARN_ON_ONCE().
- [High] Outermost frame unwinding is unconditionally broken, causing unint=
ended fallback to frame pointers.
--

commit 7d3289b2e756d08c38877458400ce276ff3f5994
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Add support for SFrame V3 flexible FDEs

SFrame V3 introduces flexible FDEs in addition to the regular FDEs.
The key difference is that flexible FDEs encode the CFA, RA, and FP
tracking information using two FRE data words, a control word and an
offset, or a single padding data word of zero.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 2721f4af53fd3..2ba2c8b385f96 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -189,16 +193,147 @@ static __always_inline int __find_fde(struct sfram=
e_section *sec,
[ ... ]
> +static __always_inline int
> +__read_flex_fde_fre_datawords(struct sframe_section *sec,
> +			      struct sframe_fde_internal *fde,
> +			      unsigned long cur,
> +			      unsigned char dataword_count,
> +			      unsigned char dataword_size,
> +			      struct sframe_fre_internal *fre)
> +{
> +	u32 cfa_ctl, ra_ctl, fp_ctl;
> +	s32 cfa_off, ra_off, fp_off;
> +
> +	if (dataword_count < 2)
> +		return -EFAULT;
> +	UNSAFE_GET_USER_INC(cfa_ctl, cur, dataword_size, Efault);
> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
> +	dataword_count -=3D 2;
> +
> +	ra_off =3D sec->ra_off;
> +	ra_ctl =3D ra_off ? 2 : 0; /* regnum=3D0, deref_p=3D(ra_off !=3D 0), re=
g_p=3D0 */
> +	if (dataword_count >=3D 2) {

The commit message mentions that flexible FDEs can use a single padding
data word of zero. However, this code checks dataword_count >=3D 2 for both
the RA and FP blocks.

If an FRE ends with a single padding data word, it will bypass both of these
blocks and reach the check below:

> +		UNSAFE_GET_USER_INC(ra_ctl, cur, dataword_size, Efault);
> +		dataword_count--;
> +		if (ra_ctl) {
> +			UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
> +			dataword_count--;
> +		} else {
> +			/* Padding RA location info */
> +			ra_ctl =3D ra_off ? 2 : 0; /* re-deduce (see above) */
> +		}
> +	}
> +
> +	fp_off =3D sec->fp_off;
> +	fp_ctl =3D fp_off ? 2 : 0; /* regnum=3D0, deref_p=3D(fp_off !=3D 0), re=
g_p=3D0 */
> +	if (dataword_count >=3D 2) {
> +		UNSAFE_GET_USER_INC(fp_ctl, cur, dataword_size, Efault);
> +		dataword_count--;
> +		if (fp_ctl) {
> +			UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
> +			dataword_count--;
> +		} else {
> +			/* Padding FP location info */
> +			fp_ctl =3D fp_off ? 2 : 0; /* re-deduce (see above) */
> +		}
> +	}
> +
> +	if (dataword_count)
> +		return -EFAULT;

Could this incorrectly reject valid FREs ending in a single padding data wo=
rd
since dataword_count would be 1 here?

> +
> +	fre->cfa_ctl	=3D cfa_ctl;
> +	fre->cfa_off	=3D cfa_off;
> +	fre->ra_ctl	=3D ra_ctl;
> +	fre->ra_off	=3D ra_off;
> +	fre->fp_ctl	=3D fp_ctl;
> +	fre->fp_off	=3D fp_off;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
[ ... ]
>  static __always_inline int __read_fre(struct sframe_section *sec,
>  				      struct sframe_fde_internal *fde,
>  				      unsigned long fre_addr,
>  				      struct sframe_fre_internal *fre)
>  {
[ ... ]
>  	if (!dataword_count) {
>  		/*
>  		 * A FRE without data words indicates RA undefined /
>  		 * outermost frame.
>  		 */
> -		cfa_off	=3D 0;
> -		ra_off	=3D 0;
> -		fp_off	=3D 0;
> -		goto done;
> -	}
> +		fre->cfa_ctl	=3D 0;
> +		fre->cfa_off	=3D 0;
> +		fre->ra_ctl	=3D 0;
> +		fre->ra_off	=3D 0;
> +		fre->fp_ctl	=3D 0;
> +		fre->fp_off	=3D 0;
> =20
> -	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);

When __read_fre() processes an outermost frame, it zeroes out fre->cfa_ctl.
In __find_fre(), this is later passed to sframe_init_cfa_rule_data():

> -static __always_inline void
> +static __always_inline int
>  sframe_init_cfa_rule_data(struct unwind_user_cfa_rule_data *cfa_rule_dat=
a,
> -			  unsigned char fre_info,
> -			  s32 offset)
> +			  u32 ctlword, s32 offset)
>  {
> -	if (SFRAME_V3_FRE_CFA_BASE_REG_ID(fre_info) =3D=3D SFRAME_BASE_REG_FP)
> -		cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_FP_OFFSET;
> -	else
> -		cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_SP_OFFSET;
> +	bool deref_p =3D SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
> +	bool reg_p =3D SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
> +
> +	if (reg_p) {
> +		unsigned int regnum =3D SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
> +
> +		switch (regnum) {
> +		case SFRAME_REG_SP:
> +			cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_SP_OFFSET;
> +			break;
> +		case SFRAME_REG_FP:
> +			cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_FP_OFFSET;
> +			break;
> +		default:
> +			cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_REG_OFFSET;
> +			cfa_rule_data->regnum =3D regnum;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}

Because ctlword is 0 for an outermost frame, reg_p will evaluate to false,
and this unconditionally returns -EINVAL.

Does this unintentionally break outermost frame unwinding? Returning an
error here will cause __find_fre() to fail before it can reach the
frame->outermost check, resulting in a fallback to frame pointer unwinding
instead of stopping gracefully.

> +
> +	if (deref_p)
> +		cfa_rule_data->rule |=3D UNWIND_USER_RULE_DEREF;
> +

Also, does this append UNWIND_USER_RULE_DEREF to CFA rules in a way that is
not supported by the unwinder?

If a CFA rule uses SP/FP with deref_p=3D1, this creates a combined enum like
UNWIND_USER_CFA_RULE_SP_OFFSET | UNWIND_USER_RULE_DEREF. Because .sframe
sections are user-supplied, could an attacker use this to trigger an
unhandled enum path and hit a WARN_ON_ONCE() during unwinding?

>  	cfa_rule_data->offset =3D offset;
> +
> +	return 0;
>  }
> =20
>  static __always_inline void
>  sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
> -		      s32 offset)
> +		      u32 ctlword, s32 offset)
>  {
> -	if (offset) {
> -		rule_data->rule =3D UNWIND_USER_RULE_CFA_OFFSET_DEREF;
> -		rule_data->offset =3D offset;
> -	} else {
> +	bool deref_p =3D SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
> +	bool reg_p =3D SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
> +
> +	if (!ctlword && !offset) {
>  		rule_data->rule =3D UNWIND_USER_RULE_RETAIN;
> +		return;
> +	}
> +	if (reg_p) {
> +		unsigned int regnum =3D SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
> +
> +		rule_data->rule =3D UNWIND_USER_RULE_REG_OFFSET;
> +		rule_data->regnum =3D regnum;
> +	} else {
> +		rule_data->rule =3D UNWIND_USER_RULE_CFA_OFFSET;
>  	}
> +
> +	if (deref_p)
> +		rule_data->rule |=3D UNWIND_USER_RULE_DEREF;
> +
> +	rule_data->offset =3D offset;
>  }

Similarly, if a rule for FP/RA is set to *(CFA + offset) with reg_p=3D0
and deref_p=3D0, this assigns UNWIND_USER_RULE_CFA_OFFSET without the
UNWIND_USER_RULE_DEREF flag.

Is this combination handled by the rest of the unwinding logic, or will
it fall through to an unsupported state and abort unwinding?

> =20
>  static __always_inline int __find_fre(struct sframe_section *sec,
> @@ -344,9 +492,10 @@ static __always_inline int __find_fre(struct sframe_=
section *sec,
>  		return -EINVAL;
>  	fre =3D prev_fre;
> =20
> -	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
> -	sframe_init_rule_data(&frame->ra, fre->ra_off);
> -	sframe_init_rule_data(&frame->fp, fre->fp_off);
> +	if (sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_off))
> +		return -EINVAL;
> +	sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);
> +	sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
>  	frame->outermost =3D SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D16
