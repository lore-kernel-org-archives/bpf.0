Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED993A6B89
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351891; cv=none; b=GFkrczxcPkVvI1RQGnnAiKhLn+Kd0w+44OBqsN1avpwgsYaEJInyISruHD6a3xoH8J7T/dcOoluAY1Fdn8KvUFvF02T9yPx1NqQl0J9pNiG1eHSSWoxfayyTJFYATa5ZyF0iiVAlHr1YOWPkMYh3aS+Nsn06FU7mzSmcV2vsbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351891; c=relaxed/simple;
	bh=9AzG3JPVWKnuycwkDK0/pbBHGjRDWyxVYQDdjKYKu8Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rwTLtGnJ1qEczB+nGBtB2jCbmfGsi4kNrcGaFISpHdFQWvFbuLp7b/vVhStVkOGug3NWe5qrp20oPx0NuMOqxGEpMXwHzin2S+BMKup1Py0rgkIFZiiCkBkNZeweUkOqlWTSC+vBKugNoIg469crAtfgkJiIa5GA7/I9m1OJBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NQAYmF9/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NQAYmF9/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca70925c25so40331845ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783351887; x=1783956687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hWHAsjGRo/XCVUPncLv7xaoRpS+dOd5JPy82dF58ENg=;
        b=NQAYmF9/vfKn3CBT8DX9n1Kaix51ZnLddUco9kKnKarSDv0/+TaEm9/vAKsnXFgIfy
         u7R0Sjg2Szkr5gphPtejqPgSS6Uh79X2S5wAd6bDbnO4/8xBIXOHe4m5ORKFFWz59QlG
         ui2p65NyHbusG0SDUmRYhNqR6rM5qI5/CfIu9RiQM1S0b8UYnvhw56CwHh0aB3PeCQ2V
         G18VnvPwGmWiY6U8f9iJGiaQfh755VGaCODjImA+gVKGS5OJZR0Au/f2V9z0pCkfg9PL
         Sh9LDY7QDsvuUUc+XFP1bp7RoDbi8NTpLTu9u5Lksasc9DJ2dTXtNP4UAW5x5tcp1dGg
         Jxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351887; x=1783956687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWHAsjGRo/XCVUPncLv7xaoRpS+dOd5JPy82dF58ENg=;
        b=kcM4K0fke6nuYeukPZZQGKu+5/tdEWK7yBQAsO5RAV6aHVD6CFt0wpi/g/fSfYTl7d
         Ph/dv7naQYMlEhkjL+TacU7i/WbXZo/eYYEmNMBKiZTrqbeB6+jHubw7t81vjvcUhKPO
         uiOQj3GtGmUZkP9yatEQbS4Sbu+MTCphOnkq1eEOTpYq8mXp0hLHWNZpusvertz2Q024
         CoUwQwfuc/Vmx6jjBzMGy6ODaXe5714WHY3MLNYm86myI4/l4MsULdieuMkWsgpCxsFO
         6k9Bwk1UxA5jvhFpzVyszf/H24lfutYRV/qJLVafkmt2gYRDUGkgUFW7DRRpGiA6od2t
         XjaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbWZT1f+QhbC4/Hy9OpuNRImsNQiaqTcm5UZo+8lrT6QPHsLOBwfGtwMWsVRdpfN6u5po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkgd3OZ9+dBAdO9DZXfTTYMO2UfmG4hWnP+O66vuzPNiK70mvP
	elskc+YEVL+VA6A+87EnN7RbOgR/UbOFCGCz+lRBdN7XKiYm/66sGPM0pXsajc8zkjs=
X-Gm-Gg: AfdE7cnfMMfkLMjFwNtHvIEnTI+XSAfmPH/eQS/E6EWy3j3DJGdbZOTuIwTOHQWBZyz
	PcPZdN2Gk5Mss5EPHCmZGhimGDHso1XrTFdezEaPPvyNRHYRd+Tbu2Yo0AchJJxNZvqARM/YjoC
	hgeF9RFD2DRuPsN6ZGhVii0IrKNYwpnH96abyIZkKEnXnjMiHzgmLdbA/rVAtj4HiLy/S+Pk8hq
	a3FWQXz10l4gPP4njtMMW28PfRyphV/L+yT1RAlEBgL5lYX9bHDLAEe4ErD/w0DcUEfvg5P8o4j
	t9Rowmn2spzAFmFVIb1aSbpKu9696dcbIGUvWHixZbUgPUU/XjcI0Ik689UtMZcfLfVfrtXzFKJ
	N+fp1ZqSeUb8uUKdeXO+u2aEECqYT3nHV0NriVr6gzLUZyQEqEwY6IKLjuwkh3tJx8tpe3cJG76
	hfQKx3bDzJPgRAag==
X-Received: by 2002:a17:902:d4c4:b0:2ca:5d9a:ecc6 with SMTP id d9443c01a7336-2ccbf051367mr10747395ad.28.1783351885149;
        Mon, 06 Jul 2026 08:31:25 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:4f71:1131:e194:34df:ee9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71328d8sm53099575ad.29.2026.07.06.08.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 11:31:23 -0400
Message-Id: <DJRLHD8JW5G3.1X9A7URRTMGIO@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <mattbobrowski@google.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: libarena: Fix can-loop
 zero variable definition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701225034.12628-1-emil@etsalapatis.com>
 <20260701225034.12628-2-emil@etsalapatis.com>
 <DJQFFKHUGET8.2D2JRDZA26OIS@gmail.com>
In-Reply-To: <DJQFFKHUGET8.2D2JRDZA26OIS@gmail.com>

On Sun Jul 5, 2026 at 2:34 AM EDT, Kumar Kartikeya Dwivedi wrote:
> On Thu Jul 2, 2026 at 12:50 AM CEST, Emil Tsalapatis wrote:
>> BPF can_loop based loops require the index variable to stay imprecise.
>> This means we must initialize them from a currently imprecise variable
>> instead of directly assigning 0 to them, like so:
>>
>> static volatile u32 zero =3D 0;
>>
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	/* loop body */
>> }
>>
>> The libarena implementation of this technique is currently faulty. For
>> the technique to work, the variable must not be in a map. This includes
>> the .rodata DATASEC map used for const variables. However, libarena
>> still defines the zero variable as constant.
>>
>> Modify the zero variable definition into a volatile variable. This
>> change adds a complication caused by the compiler optimizing array
>> derefences from
>>
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	val =3D *(ptr + i);
>> }
>>
>> into
>>
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	val =3D *ptr++;
>> }
>>
>> and causing verification failures. Use the barrier_var() clobber macro
>> to prevent this optimization from taking place. Using barrier_var() is
>> the only way to break the optimization, as annotating the index as
>> volatile does not suffice.
>>
>> After that, remove the bpf_for() invocations introduced in libarena for
>> parallel spmc testing.
>>
>> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../selftests/bpf/libarena/include/libarena/common.h     | 2 +-
>>  .../bpf/libarena/selftests/test_asan_buddy.bpf.c         | 8 ++++++-
>
> No such file exists, did you forget to send the renaming patch from
> st_asan_buddy to test_asan_buddy ordered before this one?
>
> Please respin. Looks good otherwise.

Yes patch 1 is missing from v3. Will do a resend.

>
> pw-bot: cr

