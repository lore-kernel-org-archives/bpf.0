Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58A36B046
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374828; cv=none; b=ak8ACvrlK0IGYpQ88u2fXBUExZ9732RAFiXc1RCiBZKvVJT2LPtNNzn1VteCRU2gr9ktiFWe80F5Z/5qRzsk1cNyxJQ41NX3a2gx52tglT46k3ACvM0PXnUHFKE/QHNmrIMs8RWU1uk2GVesa/yzdrESefer93fyg93uHAnQ5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374828; c=relaxed/simple;
	bh=ZhbLd6/rqvOA09uRvp2qvtk5DhhEHcaeAbraOE3xdU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cd1qaNc/6LvsrygbeuqKe1kOzXOwNFK36zzMoNiVRt3nbR+IDuqDD3ysL8KG4gFxDdoJXzKYtD566ZfRWxLBm0ZSelIvt7F+kwJzVFilseKQgpQf0xowPI/P0yAcsKB2kg86QNezsLU/drKTgL3w/0+9CnkP7iZTtv8CUHrKwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmuCej8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmuCej8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EFB1F00A3B;
	Thu, 21 May 2026 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374826;
	bh=Xk7pBC1uCTobRLfx09msxxETgi4zC612dNF8PNFLZXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmuCej8ICNwuGTeEsocITF0rFjpkGkbzAFSRGMAPXfkBrCaQSyZSbmPg01Y1CYNV4
	 Ys8c8yNRKfQ8ENfkQrqFk3yxC1i6whe7fSY3fow0fKOhJwDD3lDq5yomrMLv3G9yz/
	 htwpRLpWhYJs7FlaP9n6brZNwiRiXjZaSBwfxZgWQvf4M7lMaj/UMb8lfwWHu6FLkQ
	 stzd4U0Y5IWsKtRSRfccFgW9wvzmFFbnpxKX8RRMTcTEsoOu/sHL6mfWXBkfQi5csY
	 MtYpRzlVkoIGUxH67yIUT1sicyPr92fVuOipvf+AUk7mFRRaao+mBMGX+X91R8Gvx4
	 BPhZ37OedkT9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/20] unwind_user: Stop when reaching an outermost
 frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-9-jremus@linux.ibm.com>
References: <20260521142546.3908498-9-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:47:06 +0000
Message-Id: <20260521144706.A1EFB1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `outermost` field in `struct unwind_user_frame` =
is left uninitialized in `unwind_user_next_sframe()`, causing `unwind_user_=
next_common()` to read stack garbage and potentially terminate unwinding pr=
ematurely.
--

commit 88bb99c2143c88573eb3287429d12baa8f4ccda7
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Stop when reaching an outermost frame

This commit adds an indication for an outermost frame to the unwind user
frame structure. It updates the common user unwinding code to stop when
such a frame is encountered.

[ ... ]

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 1fb2724197332..fdb1001e37505 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -32,6 +32,12 @@ static int unwind_user_next_common(struct unwind_user_=
state *state,
>  {
>  	unsigned long cfa, fp, ra;
> =20
> +	/* Stop unwinding when reaching an outermost frame. */
> +	if (frame->outermost) {

[Severity: Medium]
Could this read uninitialized stack memory during bisection?

In unwind_user_next_sframe(), struct unwind_user_frame frame is declared
on the stack without being fully zeroed. It then calls __find_fre() which
populates only some fields, leaving the new outermost field uninitialized:

unwind_user_next_sframe()
   struct unwind_user_frame frame;
  =20
   __find_fre()
      /* populates cfa_off, ra_off, fp_off, use_fp */

   unwind_user_next_common()
      if (frame->outermost) { /* reads uninitialized stack memory */

If the stack memory happens to be non-zero, this could incorrectly set
state->done =3D true and truncate the stack trace prematurely.

While this appears to be resolved in the subsequent commit
"unwind_user/sframe: Add support for outermost frame indication", does
introducing the read here before the initialization break bisectability?

> +		state->done =3D true;
> +		return 0;
> +	}
> +
>  	/* Get the Canonical Frame Address (CFA) */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D8
