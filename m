Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74B283C89
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777295; cv=none; b=KOaKUmSu6utgzqNS7fgzctsGOWfUVbFpJ34YmuQfCs7qT8498/0FEeLw0bdc1i3LQvgf9oP4aa9EmUu3svgumsc9P1k71hw6kHcSgRbrnNt4aY82RzH1T48lm7PYSXFROtjcwN/RW87vyzT/TfvXV+pDOO72HXq+7cPAP3vxmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777295; c=relaxed/simple;
	bh=XR8s0NZldoZtbs0T2nT1o8Cgxclwy1t9laPhusWPcsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stxJI2hGkKumfspPyh+IlfWdAoeF0F9pXbjLrYTK1RvgfHYy20fpMkiF8eY7uAjlogj3diTTNdQi6LAJD6hhhpOWzbflYGhNkCZqle4f7AULosUSQBvfEDNQKTopfaCAdJz7rCkIU7tyJIW1LRpTCkwaYA9/WBC3imiE8QyZkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEOXkXaB; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEOXkXaB"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c15849aa2cso1779703eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775777293; x=1776382093; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XR8s0NZldoZtbs0T2nT1o8Cgxclwy1t9laPhusWPcsU=;
        b=TEOXkXaB3J38soghGWzOhCj5E1XdY5eqhpu0RSeFkn0tuugbjC7y6SlGk31r29+ouy
         lVgySurT7MSo7qr5EQeo4W1njdzs28dWPOI1cGjQehTTVhv6D4hwtsbH8XBrygCCLD04
         KpJ+S8eWKjZKVOdiw+lENbytlua9z1fgndol1x5HXIXi7GWiXMjWamXKItcGqVmj0eZv
         r4MaO4qNgmCjAyknNN5A/9+d7Hk2lc4XfkrGKbgvOQjta/SY/1tntmLDVF5JeQ7rOp1J
         Q+gr40nYMU6mbmNG32P4ym3pEweomhSdPodh/ClovvQoDTnanc6P4iypnYYrioAtVBUq
         FodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775777293; x=1776382093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR8s0NZldoZtbs0T2nT1o8Cgxclwy1t9laPhusWPcsU=;
        b=UlFhYWq5B9GgnJcXNeMkjK46AqM/D/sta6vgcwtWXtPFtRbdJxFwmV4DvjEhXd63qY
         guGU3xqI3zCoG04BcLaV2Q+JpE3osYEi4BB+Jct1QzBtMB6s4cN9hw7Elu5L72vkeq5z
         GNiGq9VeYjTECToo+B+Pp71xUtDCidm8ePpY0brtgikJlQh+T1ZJQaOxIX+hSk7DgmLy
         kyQm7m8VZC+INaH6NT2WCFBBhM276osPUMXudi7/nnOOi0DdoJ/TjK7oPvZRErHDy4e1
         5QCT0D9ah6v6Cd35q+mY0yMiLhC6rU7gHotnRRksF9Bu4tRDfgZdARxSHh7cTNjP9NnP
         I59Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRXyTLwk11KZx5g7wNxvMpULYd4RPnWqqkrXGKCFpCEGFGOlCbRl4ZnWoZ67egXCeg514=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ecbcvHr0mXOCpR1q7kkDv2HKkl0CJP2heDy9nOEyt465mCy0
	YAtspsL7AA16wNNxEmS6Y0h5Aun3iX/OJE/qDXau1Xb7BaiLhbHjN68Y
X-Gm-Gg: AeBDietmgbgf6f1c6AoHeHNqZjOsOMojtQyirY4WfUluPyF2ZsI6fOF3Wn+XN7JNVEI
	C6b7OL7tN1nA/wLgwsXGJn2BFEeB6jYc3UeZSu0f0rY4LKefUf5Qo4pKmnnWLFnel4echKf8OgK
	G5EXVXgvKnl4igTELkQgKrZvVHGg37uVvVrABrtnNZd+5xdAg3Jco9LTo+7/YMcpTcWYHLEjDeJ
	k13So1Oakga62e979vBHQIRHBhC4/e4/vtTRkzz6e5Ez5bUkCmxXPxlj6VC8hRkXuz1tN/8z4rJ
	zJVP6a+PnGyNAIajG62BOC96D5xU7XaxfLTEXWNScw+YjAXl7RA7Vr6qCMjPJ7BHx8atpdx27Le
	NEQVcV47UCVL1uAf4ETkQL4LftUsc9enIk4hACU9uid8cbKBHeDgqLK37R1iyABUmq7l6DoSTA/
	fLzIQD8z8JowYYq3wAncGNbBSPAhQrTwB2K1x5PQlo9os/X5jgWugXuLl/YjLUFUGmiVm5i2T3v
	ZbDEXc=
X-Received: by 2002:a05:7300:dc06:b0:2d3:f3fc:bb6b with SMTP id 5a478bee46e88-2d586381157mr655980eec.1.1775777293320;
        Thu, 09 Apr 2026 16:28:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faab010sm1804192eec.12.2026.04.09.16.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 16:28:12 -0700 (PDT)
Message-ID: <383d998646d9e23b8a605937edf8304178aa3184.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/14] bpf: introduce forward arg-tracking
 dataflow analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 16:28:11 -0700
In-Reply-To: <eee99abdfe26e1a150c77a8c218c621ef18cc43f2774ba9fdb5fc9e7f10b6ce6@mail.kernel.org>
References: <20260408-patch-set-v1-7-1a666e860d42@gmail.com>
	 <eee99abdfe26e1a150c77a8c218c621ef18cc43f2774ba9fdb5fc9e7f10b6ce6@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 02:26 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index a3af5972520f..4f7748720250 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +/* Track callee stack slots fp-8 through fp-64 (8 slots of 8 bytes eac=
h) */
> > +#define MAX_ARG_SPILL_SLOTS 64
>=20
> Should the comment say "fp-8 through fp-512 (64 slots of 8 bytes
> each)"?

It should.

>=20
> The define is 64, and the code consistently uses it as a slot count.
> For example, fp_off_to_slot() rejects offsets below
> -(MAX_ARG_SPILL_SLOTS * 8) =3D -512:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0if (off >=3D 0 || off < -(int)(MAX_ARG_SPILL_SLOT=
S * 8))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>=20
> So valid offsets are fp-8 through fp-512, which is 64 slots, not the
> 8 slots (fp-8 through fp-64) described in the comment.
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/241682=
98083
