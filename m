Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC03655F0
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243653; cv=none; b=ED5KD0eQLBRMQzDt5T5FI7AazD2gmehNcd5xvpVcUUf1uFrSPRsfuEGmm5Waavo4WsiqflzS9xXiOsq1SPVB8VLyQ+rMkIAvybQZvhNUdZTTSBxiIYry62qIHqtUzTNy542qp285ofjet6TlkDYCKc6regntNgQ3WVu+Wu0Ywg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243653; c=relaxed/simple;
	bh=tpUUoLIM2aOLsxab7fNWMAQM6jLls8itSrAR07dXwoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpKKUSl+N3dKFCyBRWWEABE4/X1qHBZO/OnzHaN8W2zhD2kGGvq7A6uPhYLnx5IYSQQWfBpSKr+5yZH7LUieMDsS6k+xTJfVzLvbwmGjlfwcEucm4Sb+HLIvX2SnBGmcSgTkEK8QvCDuOIQrhOLLDdXSWh4xGGuIBj/yjB9SHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV35OiIb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV35OiIb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9520b9155so5196885ad.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788243652; x=1788848452; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8xO2I2T/Ef2MvjHky4J+U6USqxNuR9jyMN845Mg68AY=;
        b=LV35OiIbDAiW9j5iPaL4Mu3jSn4AbXyPxc8IZbrOjONWuXmO1kO/72mdoE3YQ8S+uY
         TTCleqpRXVlYHdKp1xU03ZWDiTo9ob6taNPa79RpzHTN8shsRfrlEv4Z/WPHK6htndNk
         px+NfCBksO6s5RulRxLtqBAUqoDR+8HxUlF7NTENqS2K/9vwctg2scoseNiXwcrIsdaT
         45rfeD1/keoqAu6rv2dfz5mSKPRL8lSLnFp7wQ6o16KuT5jtLMnG97qtE0no5w8SaZOm
         eKOAY6gFsqSEwLvDv8Al86IO+Aj1FMo5Ulqge2BEA2eQ4v0vlIWJNls9IVrFA4QH05Ab
         A3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788243652; x=1788848452;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xO2I2T/Ef2MvjHky4J+U6USqxNuR9jyMN845Mg68AY=;
        b=nJWR0Aw2IzR2Uilop9itTPrHPxVvZpX4u8AQc0uwpMDsBuU30U8HjDuY+09s1thcWi
         Mt0Jp1AunKxoT7uWYgQ4DAkOa7Sl5pRy+re+gP9YClJQ60HWgdbVtcoVkDEjSH+IzEGj
         bm2I1PJ0+RHODwsK2K48AgXYVVJuJVwuky95SN20NWxncoJoZ5v52k0RpzoimvaXigHf
         isRtmEzLJW7ZTw9kwYGWjfB5tpNBQKn8sx8dUNcXu3Ah+Z3XYQKjOW8K2b118iUcJQeY
         02YrR7nLYORj3leEVHrwsY0JGKN9qsZX7fsPfTlS0o/xFetgtKSFX+Vp/HEP26K1grKH
         nUsA==
X-Gm-Message-State: AFuF++myFVGg88w0SNLDm49xe2U0XAUfu5D+G5p8+UgEfSe60PqLhrCq
	BVXEYYfC3MOVSUEBYyXD4hgQO0Y7TEA50rRhOMjjDRpf+3Mg/WvTFpoz
X-Gm-Gg: AYBFou2sDTty0qazL9eFgLgNGvJ4dNZeSv0XpCGB2clY2m5zA48W3zX2rOYLCellgeU
	CQCzJ9aLjp3cL68iRjyXHCInHiRt7V/ZpjX210mSxJ7851ioMcf5mcWFjRCtZXAlcAK0drS8aoW
	sWR6Sq4RF4x6yLAVSRFh3l/rJ1cPIWO8wkR6vWlXSDtR6IzaIu6aEOSgzJOuuJ6mjaN6aE/oNdV
	O+uSQS5BIcr3iF0HkQRnEKRwABCBMIKsyzTRGOL+K2IGKZeBUJZOxdl14zd3q8SyL/7v3BD8OQ/
	/FKoQByH6RFAh7MDvq17lF8wc1FzUjGOfddvRnkgL4/tkb0VO1SoCyv3cnYiFyPoTYn0Rq6kOGQ
	QvMh+EI13C/qEI3gMoV7VwSUqVBCPERf7RfzWWIeS92tZdKI+akRsOLUJBxxob8Eg/YOrdM8ori
	4Q8fDY52xfk3x+0eAkmB0tLkI7W+HxYe6OMizfNNXRiBF3kBLS2xiWbu3YS3a0AuDf9zfg83ghT
	5ngBH1GI1d5fJuR
X-Received: by 2002:a17:903:8d0:b0:2d7:4cd4:5a7f with SMTP id d9443c01a7336-2d74def6351mr536747175ad.12.1788243651842;
        Mon, 31 Aug 2026 23:20:51 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598b0455sm46798205ad.69.2026.08.31.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:20:51 -0700 (PDT)
Message-ID: <836e4262927db41e736a461c45cd74c106525d1c.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: backtracking shouldn't clear outer frame
 R1-R5 for callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Mon, 31 Aug 2026 23:20:48 -0700
In-Reply-To: <20260901020211.6F4871F000E9@smtp.kernel.org>
References: 
	<20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
	 <20260901020211.6F4871F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 02:02 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Flawed heuristic for distinguishing subprog exits from callback =
exits causes the verifier to erroneously reject safe programs that call a s=
ubprog immediately before a looping callback.
> --
>=20
> commit 09e9430ffafbb3bf72d2c301a4d20da098050142
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
>=20
> This commit fixes precision propagation for R1 during a second iteration =
of
> bpf_loop(). It removes the logic in backtrack_insn() that previously clea=
red
> R1-R5 when backtracking through a callback's BPF_EXIT, ensuring precision
> marks are not incorrectly reset.
>=20
> > diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> > index a2b18a9f1694c..4fe9065106739 100644
> > --- a/kernel/bpf/backtrack.c
> > +++ b/kernel/bpf/backtrack.c
> > @@ -520,37 +520,34 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
> [ ... ]
> > =C2=A0		} else if (opcode =3D=3D BPF_EXIT) {
> > -			bool r0_precise;
> > +			bool from_subprog_call, r0_precise;
> > +
> > +			/* BPF_EXIT in subprog or callback always returns
> > +			 * right after the call instruction, so by checking
> > +			 * whether the instruction at subseq_idx-1 is subprog
> > +			 * call or not we can distinguish actual exit from
> > +			 * *subprog* from exit from *callback*. In the former
> > +			 * case, we need to propagate r0 precision, if
> > +			 * necessary. In the former we never do that.
> > +			 */
> > +			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
> > +					=C2=A0=C2=A0=C2=A0 bpf_pseudo_call(&env->prog->insnsi[subseq_idx =
- 1]);
>=20
> [Severity: High]
> Can this heuristic misclassify a callback exit as a subprog exit?
>=20
> If a program calls a subprog immediately followed by an iterating callbac=
k
> helper (like bpf_loop()), and we backtrack from the callback's BPF_EXIT,
> subseq_idx equals the index of bpf_loop(). Checking subseq_idx - 1 evalua=
tes
> the instruction before bpf_loop(), which happens to be the subprog call.
>=20
> This makes from_subprog_call incorrectly evaluate to true for the callbac=
k.

But that can't really happen. If the code looks like this:

  foo(...);
  bpf_loop(...);

There should be r1-r4 setup for bpf_loop() call, because foo()
invalidates those.

> > +
> > +			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> > =C2=A0
> > =C2=A0			/* Backtracking to a nested function call, 'idx' is a part of
> > =C2=A0			 * the inner frame 'subseq_idx' is a part of the outer frame.
> > =C2=A0			 * In case of a regular function call, instructions giving
> > =C2=A0			 * precision to registers R1-R5 should have been found already=
.
> > -			 * In case of a callback, it is ok to have R1-R5 marked for
> > -			 * backtracking, as these registers are set by the function
> > -			 * invoking callback.
> > +			 * In case of a callback from bpf_loop(), R{1,4} in the calling
> > +			 * frame would be set as precise and that is correct.
> > =C2=A0			 */
> > -			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
> > -				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> > -					bt_clear_reg(bt, i);
> > -			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> > +			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
> > =C2=A0				verifier_bug(env, "backtracking exit unexpected regs %x",
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 bt_reg_mask(bt));
> > =C2=A0				return -EFAULT;
> > =C2=A0			}
>=20
> [Severity: High]
> Will this incorrectly trigger the verifier bug check for callbacks?
>=20
> Because bpf_loop() requests R1 precision (which falls under BPF_REGMASK_A=
RGS),
> the misclassified from_subprog_call causes this safety check to evaluate =
to
> true. Could this prematurely abort verification with -EFAULT and falsely =
reject
> perfectly safe BPF programs?

See above.
