Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5C3D9522
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365792; cv=none; b=Ba7gNggbllNmebrjLdpAtK1QpV7ASJfd6YmnmvQ2U/l2pbH8NwL1Lh9GyzE+I8c3Xcj1H72uE0og3K1opOIpeTjHEeyvsWD0cO/g21In/nPYWs3A1SwnwoydkfRMOHyyAWNNDJhYmNOgormWretZfZT3dBVWwLTB5vafq64Teyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365792; c=relaxed/simple;
	bh=g03BCGWBl/ivC1jy+dyZOnLazLt6NWWXfC4FMepz9lw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hz4K2PCzunKj3YzEtJILb87CBT9jcRiYVJ8P1iYq+iC4KRm3DaoHqQa/r2ojwwiajn3/RbDGmSC1yvM4Duhm1z3Ey/7Ixh3NKY9/mf71sE8n9cRQBGIPBIjpsUq3QnVlSSey4429QCovjm/aiWio86oaD6RorWlouSBWDRGFUoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfLbufqW; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfLbufqW"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so13120f8f.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783365789; x=1783970589; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHcNshfjJMq1olyhjjgbzPvNiWMtPMtkDsARE3cnbPY=;
        b=kfLbufqWjIMaY+xBqCotxrI3dNQAFqZAPx2pqhO0Farc7sBETu1KMe8mWtbhwzLR6l
         GXD3Du2+YxnGRBASmhcdb64Wz4hub9aC6CkfXxVVAD8pfuRvTGsXCKWHGzRNivPmkVNQ
         pdGJdMJ1zPu5qxT6hK37AGXTT4TEUQSl5/3p2ZndvBsK9tMscCpllAh4geASbb83T6yv
         OpKhJDVp6Dl57uyMfNNAvLUeoVeOWxKpFGR1ATXrIvrOf2a88r773BLq5HwCfyDQY8XN
         4MlVy8TB9UKiEpHt+oboLf7MTsLE2HaxvUpRGYuu4z2ltB+qNeGdHdyo3fRwRlcbtd5W
         yyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365789; x=1783970589;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHcNshfjJMq1olyhjjgbzPvNiWMtPMtkDsARE3cnbPY=;
        b=rE32k/LKqwQ9KbhlOf6xh4etPLdYSmDGlvHeYbCgY9IDEmnFHYUHUA6qsC2RoBOPXM
         5paUiwI/DSHDl/5mLVLZZPn1ttFr4P8iWAStpzxV/RjJ+1t7EX0KR7w2yDAXF+u5Y3P4
         CQaHcj9bk6Up+d1KuigQrRTUjROyTFw+Rehz6w0xHnRujEJJGkyWtQzzdLNU3Jh/V1Kr
         LPXgB/4Mqpbze5zYXEAQLFWdK1ud7UhV4zpB+XMidyQ2ViTq4uy+nEW9fwLHNOS8KPBO
         cP+VrY6ZQKV1iraDGs8DqphQLow9psul1yorLFBXx4mkG40jygeezmVKHXn1TNIPErUL
         vKDA==
X-Gm-Message-State: AOJu0YzYbbrZgOekbBgR3WgspOGWIb0ZKD0KUA9vpfl/7cEKUI/SN3DJ
	V4iCvqxeEBDROm0dCcV06mSnvJ8R1H/ryGIf+mHwpbwbhlNkZHsHbuYh
X-Gm-Gg: AfdE7cnAj+AnR3FX5eFkfrDs54c23ZGn/zSU+XY88nW8Xcb79FRVmMkjY5kCokkLts7
	aBsZHWFWkfahael0Mil8jR+AWUpiqkUYO17lTFBXXlITPADOr7lv25AGmPWMEEGeO3Xngi9zVYY
	l/AF13ZTGd2NlwR6xgtfBtMhfpVi4oHs4y8H5js+h3YZ93eUkmKmgPMR/HPmfXJg/ajDDxQ6sF8
	0XV4VfhYRgkScM62T3VyRHLTSCgTnIH0w1mH/ePTKHkRBOfoimmGtbDgMq+PzE4rLblVtKf7zQs
	3T1DqlZyryiMUvgQ35oK9btMlRy6g8KR9G4Wkvo7fUqj3w+Uv64UsFiSb9bsb6nh9Weks0AdP4h
	wTetM79qJHHK2Yjmwjz9wtamQZ91ee8b63/sZ0rz7LV1iTSiobKrn501ygTNzY8DMGXh590y+91
	LRum5/765q6Vtkg561gZmpI7H1XAcTMfmh17axwENXNU6scUXbfTRkREUE+ULmKmKDDRcVXfe9G
	4RKL0qCpDIoBv7XKjrq3RqnEEAMMIa6zkfuD2UjflG04wgOF9rwAoA=
X-Received: by 2002:a05:6000:4407:b0:475:f0c2:75b3 with SMTP id ffacd0b85a97d-47de61c3fc4mr1837045f8f.30.1783365788731;
        Mon, 06 Jul 2026 12:23:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm29623899f8f.7.2026.07.06.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 21:23:07 +0200
Message-Id: <DJRQESQZ2NYU.2OF6WV1H5CL62@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] selftests/bpf: Add arena-based
 bitmap data structure
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260706181730.21731-1-emil@etsalapatis.com>
 <20260706181730.21731-5-emil@etsalapatis.com>
 <20260706182758.21B901F000E9@smtp.kernel.org>
 <DJRQ0BBKZLBA.8Q8ACS615TZK@gmail.com>
 <DJRQAT3QPA3R.WLDNGX3Z8T45@etsalapatis.com>
In-Reply-To: <DJRQAT3QPA3R.WLDNGX3Z8T45@etsalapatis.com>

On Mon Jul 6, 2026 at 9:17 PM CEST, Emil Tsalapatis wrote:
> On Mon Jul 6, 2026 at 3:04 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> On Mon Jul 6, 2026 at 8:27 PM CEST, sashiko-bot wrote:
>>> Thank you for your contribution! Sashiko AI review found 4 potential is=
sue(s) to consider:
>>> - [High] Silent failures and falsely reported lock acquisition in bound=
ed atomic bit operations on loop abort.
>>> - [High] `bmp_empty` and `bmp_subset` return `true` on an aborted loop,=
 defaulting to an unsafe affirmative state.
>>> - [Medium] Bulk operations unconditionally apply a bitmask to the last =
word even if the processing loop aborts early.
>>> - [Medium] Missing `READ_ONCE()` or `volatile` cast in `bmp_test_bit` e=
xposes lockless polling loops to compiler hoisting.
>>> --
>>>
>>> commit 634ac04142cf736158c99f577c0f903470937bfc
>>> Author: Emil Tsalapatis <emil@etsalapatis.com>
>>> selftests/bpf: Add arena-based bitmap data structure
>>>
>>> This patch adds an arena-based word-aligned bitmap data structure. The
>>> structure is useful as a building block for components like sched-ext
>>> to represent cpumask structures.
>>>
>>>> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/t=
ools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>>>> index 0000000000000..80e814401fb9e
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>>> [ ... ]
>>>> +__weak
>>>> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
>>>> +{
>>>> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
>>>> +}
>>>
>>> [Severity: Medium]
>>> Does this memory access need a READ_ONCE() or a volatile pointer cast?
>>>
>>> If this function is used in a lockless concurrent polling loop, could t=
he
>>> compiler hoist the plain memory read out of the loop and cause an infin=
ite
>>> spin that misses updates from other CPUs?
>>>
>>
>> This one seems worth addressing; I would ignore the rest about can_loop
>> exhaustion. Please send a follow up fix.
>
> The function is __weak so AFAICT the compiler would not optimize the
> call away even if it was reasoning based on the function's body. I
> likewise don't think READ_ONCE() would affect anything (correct me
> if I'm wrong).
>

Hm, right about __weak. But as you note below, changing it to static inline
invalidates the assumption compiler won't use the body to optimize code, so
let's just add it while at it.

> That being said, this function should probably be defined straight in the
> bitmap.h header as static inline. It's dumb to require a full call for
> a bit operation just because we use __weak the convention for libarena
> external API functions.
>
> I'll send a new patch with the call moved to the header and READ/WRITE
> once for the non-atomic get/set/clear ops.
>

SGTM.

>>
>>> [...]

