Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1F3C4567
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455040; cv=none; b=reEw17ljfAzt2jdBJyZtnePsE6NJ55m9RLDcyfwzzn/fICxAmmRfACa7X00mQVOQCgYX8rCK5qVTsRCrclsQSDAtqXcNpPyzPrYuo1BpUyIlmAGRCKACVd0aL/OOTrdsfOt7xinO08KY5sJUoeN+pKphSSI+2Pt/qsl+LHStkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455040; c=relaxed/simple;
	bh=/ZVUCZTuUO6JyUM1f8oeaLbyLX0NLCT9d7HVIVgYyrk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=H7W0vBLJ+YFFbMFJfa4i9SRW1KmIJJtvN15JUSm0G+cMDr3tT+VFxLKMgsDogR8mFButhHwdFD2OEn1DSkqnjjRc07xgr5hqDGf499oXEwTMbGKfcuiYcIddfJVsdgyElRm7N5/J4zz8q2T6C8+800AQFJPuvgyJF5mYk7smIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwaynF4K; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwaynF4K"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcdd1b492eso703722a34.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777455037; x=1778059837; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OAY6vDE7Cb8hHo4kVY+rLYAoTItqF2Are9/Z3tjiQ0=;
        b=JwaynF4KXM/d/tnQQMXZgnHODTdtwbes5tMYH4Hj9mSQan/SDr41cYSh0CNGbs0Y50
         avKAQ8OtSgiCCqE3q0t4TDXtba2MvzxbMlHvh1VUmEcW4PF1yf8wudqFzgP2a1KTbuw0
         QrrxPAscNkEsEI7KPOBgQHgEl5xK5wxsIphLoTJQDBfVSe0OYOdp7KM8/Xdkje5gsZto
         DDn/cGbp8gxE5BvEnyvmuSv0DXwB7vA2EfIr26aaznMFl1DUoLjIcaZTvTn1j4QPQDL0
         UplFcn7WHmIO/sNpJ7B65ksK30nE9/punIyB+1ZLKpXYyzsRRjpL4bf9dMWUELXMjdtW
         pXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455037; x=1778059837;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OAY6vDE7Cb8hHo4kVY+rLYAoTItqF2Are9/Z3tjiQ0=;
        b=LQ6/BsbP+jIk8J37+CswS4U89VvXAHVz4ltfEmF6Erux5KnLvimLfAXfZCJhud9KJH
         dTZkB1Xh6xyjtGk87LPAxwHx8VE8PKWwXbhrLVYe5C8xeWAuIFzVPYqfAEYHDqGu6tHS
         mVV3uQf8XEwIdkCjtqA7Ups6vpRTlcBaAgxGuSL+fkjzKCAt+ccq2pitPI7VbvbO2BYU
         oB9hQ77jEBdmBiD40IbnibY9dBjDQfr+IFguWGH5jIv4a28hS4J5rpUUcp6aVOnAB//B
         srja3DcDF6nNSJLcN5wNOZ/M0BN+Raj902gKDQKSWXEW8RparQXcB02mUyFMwBK1Yr6R
         fK7w==
X-Gm-Message-State: AOJu0YwnXXbm38aQgFLKlniE4Kr7KjxJH6gG0YoZS9imzuHAwMDCqmDZ
	m29XzrXlCXqp7M9NCUKDyynnilR7jgLwX+TprRbbTFfz+9jG2KeRslik
X-Gm-Gg: AeBDievbmvlXnSaneNujb0chzM3aC1YgXE+GBoDNC9Lxcxznwy/hOqvWfyt0Pjsir02
	OKX7YOJ/j30UqVXUD8ZpHk0a2igfK9lYkwUqsp3PG33JR2+k5PPimg4haP9U+irw73/UrYmN8Zn
	6MpNbfrRaaza55un4tOqtCxwxb4ervRzcJ4NMwkutIfnghdBJwa1QodfkBX+3oCxYBMPJEMeKzi
	F6R+sXKrAzpLlTHqffebYrqVATXjqdkh4MadF0M2qrrjmaTJp8LIL6ToYP0kHaR6DxPjN942rkg
	AEjYEsR7RV+ZQIP/hwxItiq0UWsNuzAU7Nzur8GlYjgnyxJn9ACQ9+FawjNEIz+WhbZkbxnhpjc
	+SIHkw3qFxW2UmNEe4v/xpRIUV8AA7B3rGcEriG6qtL7h+iLzOEJzsQB+dmF7GZLwhzX+PRGSKx
	BLbpmlccUB1+BAAoO/BkcveAb4y8eX+Ian1iryxjyy0pK7S7ty8y2XeUvtxPluSX5yLoMvfHLRN
	W7O2ZIW+svUU8Bc6kJ2jA44KrXV
X-Received: by 2002:a05:6830:6d16:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7dea9537f20mr1192393a34.6.1777455037484;
        Wed, 29 Apr 2026 02:30:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab80e9e6sm940505a34.10.2026.04.29.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 02:30:35 -0700
Message-Id: <DI5J82SMQFQL.2O53NRWH4QSH8@gmail.com>
To: <sashiko@lists.linux.dev>, "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test insns processed
 breakdown
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <24f2a5b5f8e3041d03d78305ca0e2277f684d588.1777398528.git.paul.chaignon@gmail.com> <20260429023623.73482C2BCB7@smtp.kernel.org>
In-Reply-To: <20260429023623.73482C2BCB7@smtp.kernel.org>

On Tue Apr 28, 2026 at 7:36 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Asserting exact verifier instruction counts in C-based BPF sel=
ftests causes test flakiness.
> - [Low] Unused test configuration from blindly elevating log levels to 6 =
without corresponding assertions.
> --
>
> commit c4e03a953efa7cd8cf2e1a288a0c55c4f73cace2
> Author: Paul Chaignon <paul.chaignon@gmail.com>
>
> selftests/bpf: Test insns processed breakdown
>
> This patch updates global subprog selftests to verify the new verifier
> log breakdown of instructions processed by global subprogs. It does this
> by increasing log levels and adding new message assertions.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.=
c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> index 1e08aff7532e..7092a046c018 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>
> [ ... ]
>
>> @@ -186,21 +187,24 @@ __weak int raw_tp_u64_array(u64 *ctx __arg_ctx)
>>  }
>> =20
>>  SEC("?raw_tp")
>> -__success __log_level(2)
>> +__success __log_level(6)
>> +__msg("insns processed 12+5+2+2")
>>  int arg_tag_ctx_raw_tp(void *ctx)
>
> Will hardcoding exact instruction counts cause the tests to become flaky =
across
> different LLVM/Clang versions or optimization levels?
>
> Since test_loader.c natively supports regex matching within __msg using t=
he
> {{...}} syntax, would it be more reliable to use a pattern to validate th=
e
> log format?
>
> For example, __msg("insns processed {{[0-9]+(\+[0-9]+)*}}") might prevent
> failures when the compiler generates slightly different assembly.

I have to agree with sashk here.
It's way too many tests with hard coded insn counts.
Just one test with above regex is plenty.

pw-bot: cr
