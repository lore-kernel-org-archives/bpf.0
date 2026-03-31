Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06384276041
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967302; cv=none; b=ZRx58Cf2TOq75OMqgZqUhT3qORDGKEbwxqUvGnCLjceyuemKtn4ZkSgaxkChvwHCKBMitHmEcQIEDrCeDMtxmL29SHtwuVEuBc1jbnjPuRjCy+ag95/5iw30WuCxhta1IZpIg3FTl2rUSsfjCzbSd6JAuiImHoonHyS9sN1MEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967302; c=relaxed/simple;
	bh=CyesbJU0IJb+a/XsPUaA42BL3slCUqb3WoX1PKDSSW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkzi6DeA5A5sjcxwFAk/Vt4lSs+kYMCoBOgKic+O6ZiKIEYBZx8mHS3B4YdBxQrlgOhYdWnsvI4if424olxXD7N1bgxGpkpVXNUE+B2nv/TyhghjvgVaRw0N7JBaJy8YJsd0H7GXSV5loDYW/9uIjnB3ii6A5Zy9mDueMWEv654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FZpN+UsA; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FZpN+UsA"
Message-ID: <d8129d6f3624bf6393952cfc5655701679478836.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774967298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJg8Kr3tvfd8HEmmNwY6slWzyibLikWYQ6p5SMniqxw=;
	b=FZpN+UsAM9uABv+MFz+bQTMfXsEMmfXoBPxJLTKA4raFsx/aOt1KWV9JXUom2Pf2Z9ytQe
	5twWGjQm234/R78oThzs4peY3y+G4lPXiqGGsa5FnEkNlBaVEj1P6x/dZ06uXtVdp2w3lx
	8zgpnNs7xWLy+DGmnW1oGnQIDtXCwPM=
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Paul Chaignon <paul.chaignon@gmail.com>, Eduard Zingerman
	 <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Date: Tue, 31 Mar 2026 22:28:06 +0800
In-Reply-To: <acpnHDASo5QGw7BZ@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
	 <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
	 <acpnHDASo5QGw7BZ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2026-03-30 at 14:05 +0200, Paul Chaignon wrote:
> On Mon, Mar 23, 2026 at 11:42:11AM -0700, Eduard Zingerman wrote:
> > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
>=20
> [...]
>=20
> > > @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verif=
ier_env *env,
> > > =C2=A0	 * variable offset from the compare (unless they were a pointe=
r into
> > > =C2=A0	 * the same object, but we don't bother with that).
> > > =C2=A0	 */
> > > -	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCA=
LAR_VALUE)
> > > -		return 0;
> > > -
> > > -	/* We compute branch direction for same SCALAR_VALUE registers in
> > > -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., B=
PF_JSET)
> > > -	 * on the same registers, we don't need to adjust the min/max value=
s.
> > > -	 */
> > > -	if (false_reg1 =3D=3D false_reg2)
> >=20
> > A side note:
> >=20
> > The above hunk was added as a part of [1] to mitigate some invariant
> > violation errors. Surprisingly, none of the tests added in [1] fail
> > on current master if above hunk is commented out. Probably due to
> > recent improvements in bounds deduction. Should we remove these
> > tests as a part of the series?
> >=20
> > [1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linu=
x.dev/
>=20
> Nice catch! Out of those five new tests, the three "jset on same
> register, scalar value unknown branch" never fail if you revert the
> commit they were testing, even at the time they were added. I believe

the five tests in [1] were intended to test the code:

	if (reg1 =3D=3D reg2) {
		switch (opcode) {
		case BPF_JGE:
		case BPF_JLE:
		case BPF_JSGE:
		case BPF_JSLE:
		case BPF_JEQ:
			return 1;
		case BPF_JGT:
		case BPF_JLT:
		case BPF_JSGT:
		case BPF_JSLT:
		case BPF_JNE:
			return 0;
		case BPF_JSET:
			if (tnum_is_const(t1))
				return t1.value !=3D 0;
			else
				return (smin1 <=3D 0 && smax1 >=3D 0) ? -1 : 1;
		default:
			return -1;
		}
	}

Indeed, the three "jset on same register, scalar value unknown branch" test=
s never fail.=20
We always know if the branch taken or not on BPF_JSET, and `regs_refine_con=
d_op` does not=20
adjust the min/max values on BPF_JSET as it does for BPF_JLT.

> these three tests were intended to cover the above "false_reg1 =3D=3D
> false_reg2" check and supposed to fail with an invariant violation when
> the check is missing.
>=20
> I believe this check was never actually needed. For an invariant

this check can skip the pointless work on the same registers as Alexei said=
 in [3].

[3] https://lore.kernel.org/bpf/CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbG=
i0N66h_Q@mail.gmail.com/

> violation to happen, we need regs_refine_cond_op to refine a register
> based on a incorrectly-detected branch being verified. For jset, that
> can only happen if one of the two registers is constant. In our case,
> that would mean both registers are constant. But if both registers are
> constant, then is_scalar_branch_taken is always able to precisely
> deduce the outcome of the jset. Hence, we wouldn't even reach this
> "false_reg1 =3D=3D false_reg2" check.
>=20
> I think I'll remove this check in a preparatory commit, along with the
> related selftests and an explanation why it's all not-needed. Cc'ing
> KaFai Wan in case I missed something.
>=20
> >=20
> > [...]

--=20
Thanks,
KaFai
