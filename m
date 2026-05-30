Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DB768EA
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101810; cv=none; b=bCktZrOmCL3/CSbTzhQ1Hm6Dhgeo4TiM/rQR/2gYw9xhLT03ty5mbvwaeGEWKTE2kSkTePtcXao7I/pL1RqODCQ7XRuhLzYKRLUJvhmM0uXVkbRiwvt65w68QIeTE5lnvtjLx3Gqv4+LXYE0N3lvlfTDKxCSycE7TWVmTgaj6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101810; c=relaxed/simple;
	bh=ecnoKRkA6LDf1VxjRiBRCEIkMuj9iQy5fDE1nTi2c84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g06HZcTDKPYGaBA/+n3RsS0U7sgc5CvDH4q/0+TOozLmATClBvPih7tIeLiSr7IP7+I2BSwGVJ1sR8HPfC/g9+6WWaOYJjH+71XC0q+9sMQT3RrSIcEGvz0jXm0CPbdyCO3eoPj97QdVUSlOeWRyT8Jta6CYs9rBtr/pV6R62WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ghodUVKG; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ghodUVKG"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-134fe980658so17244844c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780101809; x=1780706609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnGzjtfskrJrpNo69pt7oe1daBhB/UXoZFgLZB77Zn4=;
        b=ghodUVKGwWMV2DTh+HXVC7uomikA3s/4nznELM118HWHrg9ew6s5uOttSigB8/BhPV
         e+S3RuiTJeaKh+nbk1AhKVfs873Et2Dxb2ptj2cPTILpxK6A4BI31DSAYiD1u6kvNM5I
         zKoDa9eimUL7q/aC516P8hxOPo9OK6xkwGL0qfjwZZe/68TQvcmjoRPjewi9FNLqCqhi
         kUAn4cljvukE2EavDWK1bl4uPWQqQ38vQVTkYsQa3AAm7FOAZA6f5OK2gK1qYM9GZ3QX
         1SztDY5zduU8bCtGoC+1DbAFFE+ZIV9Nhk7WSG+KbsQIZC1z+cMyPL9hI2iMxLYPr/yE
         ZCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101809; x=1780706609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnGzjtfskrJrpNo69pt7oe1daBhB/UXoZFgLZB77Zn4=;
        b=ob+nVoMAyZglAaEefMJIw6O9V6DjTAadwvMbJWiwLvDP00VcaOf7wCU8JZyABudXyj
         lTOtxAnVm72ICoo5K8SeGt9yl4MMy1DL921D/eLq75KVIk9f1CviaufY8SOlcec0bNcK
         9JGE9zijo9fyakphviENY1T6vueVlcgo54pXwpiH8hPSDUJ1Mxb8bgTtmSAO4j3eT8g3
         79T2hlNtDGT/t5ZoKxvgYBXi2AgbN43AxpFX/dCow6piyRqSidPmwNUI4Os7VBQS9eKN
         wP5FQ/f/U1Q7LhXGdtXCCDvT17jSjZ8PFTCKqLkulw6m/Mien3t/9Ys1bCMmOtXq+Dqa
         wEjg==
X-Forwarded-Encrypted: i=1; AFNElJ/NTKCkhs+wcuq1vc+E/lZvqLVpIQCe7jfac/YRdQLHiJNeOHIiYhKI06LTE/WZil6bvFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzozv+oRRSJCCkojjeIcuchAuNCBdE2DC8ZCdiNcW7ZC3w8akzQ
	ic8R1fvK+WZlWoieeNFUiZqFCEh9a15SngT0aoopEK7ETEslTsyIyvO6cOU6d2goMZk=
X-Gm-Gg: Acq92OHVOspYQIn139I2m9Mtuz8quDAbigGoNWMQyVV/0rMLYOfVoktP1NT2Ngw0fR/
	griRXKwiOlHATH3j7KA/F+FN9OFbvTKHdzUOUkKVAkYFv7psDuTPMiqK7mLZidxo39dfDYMCCUx
	FF6CjU2MSnFjAezP/tn5R23DYEpqvRBKAK//IJJmtDGyhuDpawtsk1bdQ2QwteC+t4W1PYj5Eb4
	4PooWxLJi4GC5kMfSq7RgQU0FAHeD/c/102X5MFk3qeJKy0bcLcaUKSrpuo3W5KNcmwUjZGDM/6
	ts6+9DIDxeiFKTuILIbJtHIPNR4mtbMAsr5NBVIhPYOn3c/fGIMhW2senQtTqOl6oCvZ5KV4zfj
	wAOOhoJ5Ujo1hp5tfIctaVbVFxZ7cBKi1Ms1dnTRR6F0G23EiLrFkaTcFtOmjcU6W1jsf6x5JMy
	BPybS2dRbxwrMOUwg=
X-Received: by 2002:a05:7022:383:b0:137:8bc2:f501 with SMTP id a92af1059eb24-137d3bf3c93mr966439c88.7.1780101808630;
        Fri, 29 May 2026 17:43:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9dda])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36c6eabsm2207427c88.7.2026.05.29.17.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 17:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 20:43:21 -0400
Message-Id: <DIVLFA1NE2MR.A361BQ7NBNJK@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <zhuyifei@google.com>
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
 <1dfde1acae77ab6f20468b84a7d67412d5bbaf91.camel@gmail.com>
In-Reply-To: <1dfde1acae77ab6f20468b84a7d67412d5bbaf91.camel@gmail.com>

On Fri May 29, 2026 at 8:23 PM EDT, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 15:44 -0700, Eduard Zingerman wrote:
>> On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
>> > YiFei Zhu reported [1] the verifier regression after switch to cnum
>> > based scalars representation. When the following sequence of
>> > instructions is processed:
>> >=20
>> >     1: ... rX setup with [negative, positive] bounds ...
>> >     2: if rX =3D=3D 0 goto ...
>> >     3: if rX > C  goto ...
>> >     4: ... code relying on rX being in range [1, C] ...
>> >=20
>> > The cnum-based implementation only infers that rX range is [0, C]
>> > at instruction (4). The pre-cnum signed/unsigned ranges based
>> > representation could always deduct from 'rX !=3D 0' that
>> > umin bound is 1.
>> >=20
>> > This patch introduces a workaround forking the verifier state when a
>> > register with sign-crossing range is compared to zero.
>> >=20
>> > [1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106=
e3.camel@gmail.com/T/
>> >=20
>> > ---
>> > Eduard Zingerman (2):
>> >       bpf: fork state when comparing sign crossing ranges with zero
>> >       selftests/bpf: test fork on zero comparison with wrapping ranges
>> >=20
>> >  kernel/bpf/verifier.c                              | 71 +++++++++++++=
+++++++++
>> >  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 +++++++++++++=
++++++++
>> >  2 files changed, 139 insertions(+)
>> > ---
>> > base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
>> > change-id: 20260529-cnum-split-at-zero-3c03db9234d3
>>=20
>> I don't know why CI misses it:
>>=20
>> https://github.com/kernel-patches/bpf/pull/12235
>>=20
>> But I see two libarena tests failures with this series locally:
>>=20
>> File                 Program                    Verdict  Duration (us)  =
 Insns  States  Program size  Jited size
>> -------------------  -------------------------  -------  -------------  =
------  ------  ------------  ----------
>> ...
>> libarena_asan.bpf.o  asan_test_buddy_oob        failure         879905  =
209739    4158          3931           0
>> ...
>> libarena_asan.bpf.o  test_buddy_alloc_multiple  failure         269851  =
110341    2774          3897           0
>> ...
>> -------------------  -------------------------  -------  -------------  =
------  ------  ------------  ----------
>>=20
>> Investigating.
>
> So, the gist is: suppose there is a loop:
>
>   for (i =3D 0; i < SUFFICIENTLY_LARGE; i++) {
>     x =3D ... range [-127, +128] ...;
>     if (x !=3D 0) {
>       ...
>     }
>     ...
>   }
>
> With this patch-set the 'if (x !=3D 0)' would pile up an additional
> state on the jump stack (second half of the range), compared to
> master. Because the loop is verified till the exit the additional
> states would accumulate on the jump stack. Which means that
> SUFFICIENTLY_LARGE can always be picked such that the program verifies
> on master but fails to verify with this patch.
>
> Two test cases in libarena_asan hit this wall because they have
> large-enough bounded loops (the loops are declared with 'can_loop',
> but 'zero' is declared with 'const', hence the trick doesn't work).
>
> Remaining options are:
> - explore a simple constraints engine
> - revert cnums
> - accept the possibility of such regression
>

For libarena specifically the default for now should be 3) since is is
misusing the volatile zero pattern. Fixing it causes verification errors
but those should be either a) due to pointer arithmetic on non-arena
data, in which case we should add bounds checking, or b) due to pointer
arithmetic on arena data somehow, in which case we should adjust the
verifier. In any case, it should be fixable.

> I'll work on the constraints engine over the weekend.

