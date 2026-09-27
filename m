Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C3B8D4F
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790498644; cv=none; b=nOfG2nPbVTLmd189esfgG1aaECLdhdGGGfrehAdVcSZseoBOFWf/5hoi+Yi8WvGK+y2ricqNvZsZrcl/U4qD6OjIAmhtOvTR1I5jmebIL06xSekfmA+v0SRzM9njOMs/p3+MnRGjmPFtqyGghwtekQfcZHbqs3gR6ESEoDFIsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790498644; c=relaxed/simple;
	bh=vydXxhH/QQRRubWdaFU0zJmKC09DTfBjwMt5DQFcwv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuwLFDbzpXcgyqAdPZMXTnTSllh47At7/t+uHFHVPDbJSORML0jT+O0mJ5Y9A4zlGmC8MOR/ka9eZUgUTvKainjvB9IpRS0kKyIR7QnbxgYJIZ9J97MteusDY23VBeXQlSU7zL5WO6JpMqE7KJJ3nZ6KfY887vWmx/yp0d468Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpDXkk9o; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpDXkk9o"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so987767a91.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790498642; x=1791103442; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vydXxhH/QQRRubWdaFU0zJmKC09DTfBjwMt5DQFcwv4=;
        b=RpDXkk9okzNLz+zBrNUgD9z7Ovr9D6TsY3L+TbuHVJmmR/Wn/CHoE/C45c0T5r3JzH
         z96heBey/lQEQfVOXu2VTBF7MIwneMos/AwGX/aDNtqg4JF7GD1SdJDEylMGBiAxEr7U
         p0KK2Eu2LLbZe6SDxF9r/OIpUsUbT9wI7RFUg+WY78ArjF1Qh7zdsfgAj2oNG5TdYTIe
         sWxUSAxZnWGIsC8x8RwpwiSp+bMrgVsMMcP4c1fGTHrrGypWVekg3f+NDyu7SdAAz8Ed
         25p9c1ULL1FmGfWHIViwzxxzathT9jAajom8IZ4wVSVhWcQuRjRKn/ffEjyCvRMT3tm6
         Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790498642; x=1791103442;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vydXxhH/QQRRubWdaFU0zJmKC09DTfBjwMt5DQFcwv4=;
        b=neJmoYHJxL1g3A/W3TTNrZRrKnyL80VLUKOfU81pC83X4C7ZABfpu109cZ5ymTs4Fo
         4Hhb0aBo2BIL08auXtcdppep2JNy6MP9sLz1QxRIrb9VCA1eImosRx5XfHlD5XlRrf2k
         Mo1VeMwSFAuHxEMEVhQ9GYI++Ta0uUvG2U6sMgNHrCl32yXf1+26YqJgbxJhe7GyqjKr
         Sq4nYqhLFACUI9DzVcPDtlaMiP3NH0lkZkLj0CaJwxEIRmNyeNmQ2yf0otuF0ju74p3Y
         z582KSOFlmMMVFPLNAE3j0DkTRyOKrfxP2B2bA8SM38keIPa+PjkhpjcoexOT8OMdWgy
         8uZg==
X-Forwarded-Encrypted: i=1; AKwUvBzCMm1724ibGs8rk0gEQXXiJ5ykZTMJ9nk6QgHTQB2Eu5LFWGyPnTsBLSP2L9dCwBrr7AM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTa7zTfMeSEnjdHnDzYLcEVF9W5DhS+nr0RWB1Pk3zC33XXdWB
	zTUWhewfxfBh89LmIrUd2Q8Cyo2NNOEHLMV+IIOqzKtONdUxGmwQwsfR
X-Gm-Gg: AYBFou2YScWrsWQioCi5wVyToI6pfp8hAq4sI/r5IvqR3VycNAFrntKonX25KgMpTpd
	cg5GMhloqgHpCmTy87uRPF36mSgQjhRcJCVaN7H6vKONSoBAOb1hd8b+i2ljGQKRCHzbcfcND5M
	+TQOjNyTCUS7xscfVl3PbJeD8j5V4Tk3srAZhXxyYz4YjFE3FFYTV1nwDk91OAgsAi3vNcke5Qa
	mBoxyrpyy1JYEOQgm/ahpXqx2bBmA2f2Y7mWUDR6yitqjZZI53lJu5DDbXaiMf41yB82Eo6Goja
	LzF1NNyDxQhBY+7ZLa1WLju1OuHBhTmtoXCaSST2FOHCPCbJJWHj/W1tYsPT8dqW6viKD5yXsNO
	qxJBpZY8QBY3EQIbVs66kXRa0KwGqI1yuq4wUpF+twFfKelD/d8ymFR03pakWjfAU9wdWuVXkAn
	/09bYnBL6MOTJSiJ4fBX4gpqQeLp9jKOFsP+oQuPaKF5cMJmrLC5N3OR+ebjTQ8E1GkHE2mHAfw
	0Q0Wlatksw5o4RB678h6MxKgjKpMCIvsSmt
X-Received: by 2002:a17:90b:5627:b0:3a0:79e6:b45d with SMTP id 98e67ed59e1d1-3a09896f0d4mr8562673a91.54.1790498641714;
        Sun, 27 Sep 2026 01:44:01 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm20308731a91.17.2026.09.27.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 01:44:01 -0700 (PDT)
Message-ID: <0b62d64c669ef14c527758291ad2bdff43b20196.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/36] bpf: track may_write flags in liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Date: Sun, 27 Sep 2026 01:43:58 -0700
In-Reply-To: <DLPD9DRXXOGK.1QIUC9VKTZU08@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
	 <20260926-scev-minimal-rebase-v1-1-c8e5ab5ba79f@gmail.com>
	 <DLPD9DRXXOGK.1QIUC9VKTZU08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 15:51 +0000, Alexei Starovoitov wrote:
> On Sat, Sep 26, 2026 at 07:19 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> > Compared to must_write, may_write includes any possibly modified slot,
> > including partial writes, and does not kill liveness.
>=20
> It doesn't include the writes done by helpers and kfuncs.
> bpf_helper_stack_access_bytes() returns -size only for MEM_UNINIT args.
> bpf_fib_lookup() has ARG_PTR_TO_MEM | MEM_WRITE for params, so
> record_arg_access() gets +size and the call has 'use' and no 'may_def',
> though the helper writes into params.
> Same for raw uninit mem when !allow_uninit_stack and for every
> kfunc mem arg that is not __uninit.
>=20
> > -__msg(" 6: (85) call bpf_iter_num_new{{.*}}=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; def: fp0-24{{$}}")
> > +__msg(" 6: (85) call bpf_iter_num_new{{.*}}=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; def: fp0-24 may_def: fp0-24{{$}}")
> > =C2=A0__msg(" 9: (85) call bpf_iter_num_next{{.*}}=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; use: fp0-24{{$}}")
>=20
> bpf_iter_num_next() is 'use' only too.
>=20
> Returning a write as a read was the safe direction for liveness.
> For may_write it's the opposite.
> What does SCEV do with a slot that has no may_def inside the loop?

Missing may_write means that SCEV for the slot won't be invalidated on
indirect write that touches it. Which would lead to incorrect SCEV
expression.

This is a good point, I need to fix this bug and collect updated stats.
I think it's the main take-away from the reviews so far.
