Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEF3FA5FA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421190; cv=pass; b=OAz7uVQ6syzPvCve8444ovLGf7ie4mkW54pjgPWDL7akq/z4438sBmEk2lVfyTjKw7HZm3Sfj1uWIY9SYwtC7ARKW/kddWT5leJT/Lh9HIvFhO6mlso0q4mTK/nBp4irR4PN6VHMZEqTfYaqiiNKV0w+i2AXohZwfrTJDcPdyY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421190; c=relaxed/simple;
	bh=N2zSfTpJNCY4t5qOyP0bEyizCSmSRAoY7KosRj4sPVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSAgz/WhFnfTGBwSb9j5OxCg/bRVmzCpx/0aci+fSqxTudJnFEVQwm75DQ4rX4VIkfuNserWp3f2gcxmlHbhHMnLy039wXmoZPR98pv3BhoBhX7jG2m5Y6JiqnnfUH/PpZdFjalt47o7Fbr5cDoJH4S0p1z7k00JRxN7tXWNf08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CauyokWe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CauyokWe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so5080148a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780421187; cv=none;
        d=google.com; s=arc-20240605;
        b=We3yHowKGvKl3x0/pt4ntNyLRwPYkWK0N0lzz/ggwg+/BP4690p+kP2tFF+slh750z
         TY8rRz1RHoIofGUJfK5jjwZ1q96ZDZbkGHiiUjNwY/WDLGGUfDM8inndKc4L8wWZec5o
         hDRtLaRvKldJXvbnhUOjsDu+b6orRSo5We+68sSLksmOPLmIXBl82jTmvVAzKerkvg5I
         +wvPpSBBEpvDJM93RIdCr6i6cV9IUYj5LB+l0nehaix7qHBMmby+lL3bHCTEeee6T41Q
         /8NA5RT92w9FrwzlXazKTxA6/ieB1bWHwNJj723ns0j/UhBD0my5Qiw2GmabBwg1K4zB
         0/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        fh=ZeqASTMB/bTwnEOG4xjt2A+os6KJfhTwWBeXtgbusG8=;
        b=R2rHA/a0DoUhBWqEanPFeTzSG1KLwGSQUij8ODscBVlJdauqVClx1+DrzewaJba+SQ
         Fj5ISQCZh5LNd90c83FcW3ebZgYTmqIVGXnWprD2nE3sSYozMXKXKyuz2546qNhIRSCy
         FS3A+WHkiJrAaRWWoL+hQUue5rGj1vzZQMNbMqqpBdltmvWZrfH+F/F8PRnpDERVvQIC
         ysMsPV8EZSI630YJ0qWRUProCI/zhrJ/37bGbbZXAZ8UaHkXwu1PillCVr8bEyLiv+rK
         0IFQlAUT3nvsQNLtbtVEu3E3t8zw8wGHbvu/t0evkBQ7HMFtDRc3OnW49henR7BjgX2k
         aiSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780421187; x=1781025987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        b=CauyokWezlvbzCwO9w7wAu7iXK2YIYUTDAr2NF0lnPw/x6nU4UCptjnj9xKMdyy4T+
         n31Kl3rkOfRXAxSVe31eq48vHI08eiwVEfE7eS7Z2sn35xBxdzsFdz2xoRFS5ceaMcW5
         A/TGb1Wu2thAugJ4HkXP2DEZ5NQgjreeyOu68HKWwWxqA8Ow4VAISobHmhY3h3Wv/QjZ
         ggzf1v7iMicpV+OaSNnjW1B3ZcnB+uzDEDWkCQqNBCzCpJB9Q6d/T/D853mMsaVVtQgl
         Bpos4l5cQDZ5NkPS/rKgFsTn6MXjhnd9nHU7cPk5/8tbmlvd0Hio1w5biVKDDr5RK974
         LIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421187; x=1781025987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        b=OHasziGOAF6tu0luNSJ5LA28atCUAJT32AkidQ5yzdajEhmwndVopbN72/jdjDpeal
         c6ARL5Ey5/E7YvsWC6F2+88eKfTYZZJqXnupfJ/9TlQBWq69d525shCLT0mncSSLHCkv
         6qnD7t0AEIltaKk7jAPymfYBVpngRQfRKHt9QbUCBik3B5jC7PqgKMa5eplJWQRw/I9h
         nCwpUSMeZEy2JYTjw1IlCAXtaFkQBO3mdQWqBEuLNTAVHFnsVeWI4bnSr4YMBKlRDaKC
         f4Mu78IQl+NO3g1eptxKzuoJFpegTZbGQhAFOtr3cHbQKEhUBr+m6TIv6Be+2ejvB0ce
         c0yg==
X-Forwarded-Encrypted: i=1; AFNElJ9QKLIWkg81ofBpBms/pND7+JEaaeHo6GjF1Kz+PWLWkz0vln4A3ypYPazEjIA6ChmFiaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpVlOBod000WS6ONPfvwofkY0dxhKlZDBzC03ddLedIRidZN3
	nThgU7YbLNSSJENLAD8oKzbc5aVDFw/dSKpqT/0WGb/9ctyjt+BWkOFlWry2vpx6TN5+OcqPjQr
	IbQ+edybxnWI+/IfzpJCk2jQpjZzipUw5Y2hN60us
X-Gm-Gg: Acq92OGwzOvL7RaQUu3ed3UPEBoNPVJSRQhZR2x46LIm2XXxObj3I4AnAUIYHuFoq/C
	aZNK7Y0UZWw1MT4axZNnpe3o6HJZY/1z54lAMom8xpuJY9HeqNrTIoYebWotzmMENIsL++kBYbX
	KGqo8nT300I2c+47hccrfADtb6TvQfMwHK9LDDwTYfv/Jppg2Dhc3cQIyp+DB380vgS32dljkAU
	YTcn0/o9NHyg02gKNJVBbNkNUa1YESkhxiBgY6UgADuWwyLLKcBRpfr7kwMa8IlodyyyBHjPsf5
	2UGP89Go+w6aKy28Rw==
X-Received: by 2002:a05:6402:5417:b0:67f:99d8:868 with SMTP id
 4fb4d7f45d1cf-68e5d94b50amr370315a12.16.1780421187178; Tue, 02 Jun 2026
 10:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <f7892d83-64cb-460f-87c8-ebc7fb4476f4@iogearbox.net>
In-Reply-To: <f7892d83-64cb-460f-87c8-ebc7fb4476f4@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 13:26:12 -0400
X-Gm-Features: AVHnY4KXJdTKb86IwXDncHxbtqVCvwUqkbs2YhZ2hnshZqTYs_erOE_rsX9CAPE
Message-ID: <CAHC9VhQPc52RQpTN41NpipM6U+DBB2CWRjdwh-ykhDkfZACrLw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Brown <broonie@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:52=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 6/2/26 6:31 PM, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> >>
> >>
> >> After merging the security tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many a=
rguments to function call, expected 1, have 3
> >>    212 |                         if (map->ops->map_get_hash(map, SHA25=
6_DIGEST_SIZE, hash))
> >>        |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~=
~~~~~~~~~~~~~~~~~~~
> >> /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro=
 'SHA256_DIGEST_SIZE'
> >>     14 | #define SHA256_DIGEST_SIZE      32
> >>        |                                 ^
> >>
> >>
> >> Caused by commit
> >>
> >>    c62310df81899 (lsm: introduce the Hornet LSM)
> >>
> >> interacting with
> >>
> >>    c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash opera=
tion)
> >>
> >> from the bpf-next tree.  I have reverted the latter commit, the new LS=
M
> >> means that the assumption in the changelog that there is only one call=
er
> >> isn't true and it seems like the most straightforward approach.
> >
> > Thanks Mark, we're taking a look at it now and should have a
> > fix/answer later today.
>
> Sigh, hornet should _not_ be merged to begin with for the many reasons st=
ated.
> Messing around with BPF internals is yet another one aside from a really =
bad
> user experience of having multiple approaches to BPF signing !

Sigh, if the BPF devs had shown any interest in working with Blaise to
arrive at a solution that met the security goals we described (and not
necessarily what the BPF devs continue to mischaracterize) there would
be no need for Hornet.  You are free to be upset about Hornet's
existence, but you need to be realistic about the role the BPF dev
community played in creating Hornet.

--=20
paul-moore.com
