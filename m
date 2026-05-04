Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E639D6E7
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893043; cv=none; b=nR9fM+uc2VqFB4N8C2qrVZ0bSUFQIhyEhsbhkB1m9LeVS+VlirD4FKWjsGs+tkZRSNwnv+2c0Rqn24+XqohxwI04PgIt3OoKMRsQt7+qynd/fqiB2G6vq18EgtfJ3iHJ+iHJBjD+00H1fkoad8ruPICMTGTE0KwTliQdE8nN5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893043; c=relaxed/simple;
	bh=hvIkUcGplTr0pRBj7FPS35gKKC1V+FL/vIDr6oudE3s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=vFFmCSO5iuWeWENUbD4+hajnM0j+1Sdyg6B0lUAMx1Xm6fuRt7coEVaKUlsxKmdnbRom1qdMa+kR24vcuZA9kWoQ1fWHZhVrgKel/9kEhePI0pDlQfnx8wC+Cr8Rk+fPzF/z+cEGuiH7VtfN+UOhWKxbruBmOMuWNrqWeZUAvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E09DFkDx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E09DFkDx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so41375545e9.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777893040; x=1778497840; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1neqE2LfHfnexRseyojdeVHubjDEvUEc2J6H5swOBYE=;
        b=E09DFkDxagbIYWAD8Ygu/of2O10AM3YMyUut/Jvw76i2EFXSaqZDIWcgWldX5EwYOV
         vKJ9GlB+7V/gN0o/PPb9hGxeMlKsiKxbqnAsHDBllMbC/CDrp6r+lmtO3p9Qrz3THgdl
         Wljc1e498f6h4Btp+aKnYPTNOKxPa9tx85Cf12PncPjzA+CmIjbAgI65kL/Zc3WIKEhl
         t8BF0SxEdcjAd8n0NuQfzGFJ9wrYITxj0ebFpXw5Rw7+gsf5h73PT5sBpG7dUB7lFJLS
         MW7XC5gwcbXV8igapSfaK09C1i6SzBzCZjWsj92QOoU7DqjV+JxgRAyfJcZ48M/8jun2
         4Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893040; x=1778497840;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1neqE2LfHfnexRseyojdeVHubjDEvUEc2J6H5swOBYE=;
        b=NV2Wt8n2alC2sJ1q3RW9T7BiYOpzvYQkfEP2f/azXV1pnlRObZeYLrGC5em5FjVPGm
         gTnsrhvvcDVhVb9eC8Dr1Yp2DQ/5PkbGSz9iDeYOX4/3TJ2U0NJLK8xki9Z9opo3TXLL
         sB/mFJ0tD0jkm7bwaRWWVaLP8Ehy3YrnYYS3IlGzQZQaSI5hC+VOxGuCSFc68kz7Hv+1
         ll4Fs1jk4dh3ZOQqJisdrr4TZug6XMrO6CxCME8Ma4Tdr8xTZadX0krLdNTd7da6tQ22
         28p81Ljsu7ICkYy3eBqyezSXxM6Z6ZQuPaFA/02wBY1y6uaa7BMcd9dEJ4ON50d879Ds
         g2aQ==
X-Gm-Message-State: AOJu0YyS/cViVV3v2VJQAmceLiUP4f9p0GFuXmdOBYOTsID5eIzo/CFx
	1Dc2ip37E0Z3UaCUpe35r2DUf9VmKWpCQjrXV9+amwz6W15/6zmWDydkc6C1s/6VwE+Oa5SkARZ
	ufug4
X-Gm-Gg: AeBDieugTf8yTrD2aw6KUUOsb9iLEZxADvQIYz+lOUS6iR+xW7g7LVEcHIPYpGZcKKP
	MY4LKugwIVP/mrNCgtcjWO3OFbC0DPbMH3W83a8PJYswuMKtajU4ArSAQ5cq5iH+H7dY8/lOPw+
	3cHP0OTRyh/9/0bbB5kNdBh2b66FB1NistDwO54eMZT3qEd6XZCuZKpfKEsUs5PwspFy8HYbH2M
	y9oMF68zu3Efcign14aOPKa8Wna6Q94I4o7shpExBku4un2ZpWYhkuL9V7n8rwwhIuYO+2t0w86
	OBBSYDR8ACMErQWm9nTa0X+/+oUZsm2PkRmThDBiJ0Uq2yu9WObu59oa04ZeNxG4YjDGc2/Pv9z
	lOyd1u5pVS6JhQdf7moIDE1qZWRdWftZWs9kWzjLQSa7iK+nLCZkI4u7CGBRqK8qUWU/aOxpfyM
	fZZ6mXsZ7JcLuOM9yFjxrgag==
X-Received: by 2002:a05:600c:c093:b0:488:a9c3:44a3 with SMTP id 5b1f17b1804b1-48a93d94566mr156970375e9.2.1777893039791;
        Mon, 04 May 2026 04:10:39 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:1294:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfd8b5886sm5469429137.8.2026.05.04.04.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 08:10:34 -0300
Message-Id: <DI9UHCRWR7LE.13J5GTVBCCDZ8@suse.com>
Cc: <bpf@vger.kernel.org>
To: <sashiko@lists.linux.dev>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v11 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v11-5-e11f7a8c4fdc@suse.com>
 <20260430162921.0829BC2BCB3@smtp.kernel.org>
In-Reply-To: <20260430162921.0829BC2BCB3@smtp.kernel.org>

Addressed in https://lore.kernel.org/all/DI6KY4J2N2UB.39XQW4ZLTT1VV@suse.co=
m

On Thu Apr 30, 2026 at 1:29 PM -03, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Making BPF skeletons order-only prerequisites of `.test.d` pre=
vents the generation of newly added skeletons when they are included via ex=
isting local headers, breaking the build.
> --
>
> commit c609958fbea63ac5aab9bea46f3e2a6881af6a94
> Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
>
> This commit changes the Makefile to make BPF skeleton headers order-only
> prerequisites for .test.d files to prevent unnecessary recompilation. The
> BPF object file is kept as a normal prerequisite.
>
>> Note that adding a new BPF skeleton via a modified existing local header
>> still works correctly: GNU make builds order-only prerequisites that do
>> not exist (the order-only qualifier only suppresses timestamp-driven
>> rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
>> TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date=
.
>
> Is this assumption about GNU Make accurate? According to the GNU Make man=
ual,
> order-only prerequisites are never checked when determining if the target=
 is
> out of date.
>
> If a new BPF skeleton is added and included via an existing local header,
> the normal prerequisites of .test.d remain unchanged. Make will consider
> .test.d up to date, skipping the order-only prerequisites entirely.
>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 9a4d8bea0c184..608e6dff03926 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:	=
		\
>>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>>  			    $(TRUNNER_EXTRA_HDRS)			\
>> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>>  			    $(TRUNNER_BPF_SKELS)			\
>>  			    $(TRUNNER_BPF_LSKELS)			\
>>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
>> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
>> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
>> +			    $(TRUNNER_BPF_SKELS_LINKED)
>
> Could this break incremental builds? The old .d file would still track th=
e
> dependency on the modified local header, causing .test.o to be correctly
> identified as out of date.
>
> When Make runs the compiler for .test.o, will it fail immediately with a
> missing file error because the new skeleton was never generated?
>
> Furthermore, if a subsequent patch tolerates test file compilation failur=
es,
> would this result in tests being silently skipped?

