Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51C346E43
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365479; cv=none; b=p+SnaQJ6qj2y1WD5R7hyzhRBFxY2oLZXmjmw22hpKhelHUanbIKcj/uTL1g4s+YuDfCJitND1aafWJkF3MlXMRmiRYcsN4r53sNDr99Yvz+g0QZSB4Ditv5ihLz2NiZ/sBsyZ4eKjr2OB2QlqSlx79Jmu+l9uqQRK9S5L77yW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365479; c=relaxed/simple;
	bh=mztsgjch6Jy3oILZHuGGNkEQrJlp0FBMRXOxe/mPF0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tY8VbKJE+GvBy/K/IZPx6lR3I4JUemj4XImJBNWeIJvpjbvmmJXlSyRrORiP+7uq9OhTXfO6iWZ9H1wpa5fHxvjdPYkUhnsBE0GrlGNIJktVPii34YMTEErvauDkvotmuYPdpCMX8q3c8ttwGSAoKSUd2bHHnpUcJYdd171BIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VRo52g3S; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VRo52g3S"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e7391839cso3092682a12.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783365477; x=1783970277; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/ha4CTRxcM82KOvmfcXlsVqX2jXy+ahUHiNb+SALlI=;
        b=VRo52g3ScA6RShFV7Iy3ftx3pGMtLnp9LyAK2h5oT6ciQo+W9CMGz6kQC/yFPk2Ypi
         btXjXEi0DRyuMGe6AazYRlhf1PXnbiTPzInsN17/PIHbpjI0jog5ATdqVbG9EcjbjGwz
         eUu7CJLDUgv96KuedOSQ1ta3hjWQce8sXAJTDHuaZKFUMg4FQOgh0wm0fqGlEJinIN+L
         FX9ZMRLlhw3hBdfabdViMu4saFhP0UUqpivsO9Ovkwi17svAwMtUfKdy6TiyyHFWWbuD
         VFucgY46osdGPuoQoxNiDC8XTOZsy7KVZxGqXy2UK66tjOSos+N/UP692tMmSjgnFDim
         4tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365477; x=1783970277;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/ha4CTRxcM82KOvmfcXlsVqX2jXy+ahUHiNb+SALlI=;
        b=ZdIOYs05Q7+5Yk5QOWMbxNeGABS9mZ/NN+0L0fMpuod04XnkfebajdcMazeDVNLXR+
         ZwYfwWftVtZzfDt0NTy9BLdFfdam5gPaX0Exu8LHtgCyhgyOSZWMSqOZQULLYo/dOR4J
         NltD/ENySn2Zr6wR/dv/XhL8UonpvzTwpHFmHF1wdG9Ngb8PKjURVB0fe/wCjk12EYfg
         Q0QZFGusDmokSkZ9FBX4bvburWjZDgHhwfqcC+Cf5dR9DZWNtIYtOXzgqqYGZTsFldT3
         fgcGnI/uSi4nMLf1kAQDo55Y3rvOSgxCb7rnhezbK0vWwmG+JhiXRLCi82sIj2ByyPRa
         yrPA==
X-Gm-Message-State: AOJu0YyWRPq6DqWaKza9UJpSgnIosh9C9rG/toGNbOcCooIgHiS07pv5
	buxfnktmGS1ljilmw3hY6GWdAV8MVp+DFKsGp3LfYPdgElgWfHsoG6nWOZmM8kFNXtg=
X-Gm-Gg: AfdE7cndAyfYlPRGB0aqvmAa4uwh69WhKCFLUspVx/Q6mYPpES2VrIY/PU3kolqFDvT
	4QCHGcV8yjCQRKSHNsmHRAm/S4eudbKXrwcr6xMhBNwCy3SCJPJ6vNyYqwoytjhKeWq0uhEihAh
	uBux1yGdO+/1GRQvzaJhREAHWHOsIbqckCSM6fIAjMguIwzW2twmBNdJaIpC+deCR6NWXOTzoJ6
	yptBcG5RmPTZJf8n+Pg2FE8hZdWv+XMwgVWTljJXSNYKRLLoXUf9bOc1EQalfoDDVK3sTUt55zq
	7PAAPoiW3bp+0pkM8ff9VgvAItUFjZRqsw2mjj90YvGcEmg+QMDh4RepAZunYIrA7+UOT+4A1dA
	i7+uA6zr6VKLd78g7G7bD5I/pPqZNiIzrASJd/cRAyfIWbPfOB+CoLp6UV17li8WFODKzINe2OD
	8f/qmaQ+DbsDQAvBKN+c6KzXLcTOH6pdjNf/AZO8dus6p3lp+E/I3Q
X-Received: by 2002:a05:6a21:3294:b0:3bf:6c08:2849 with SMTP id adf61e73a8af0-3c08ef2d446mr2356553637.56.1783365476010;
        Mon, 06 Jul 2026 12:17:56 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e921d28d9sm6425530a12.24.2026.07.06.12.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 15:17:54 -0400
Message-Id: <DJRQAT3QPA3R.WLDNGX3Z8T45@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] selftests/bpf: Add arena-based
 bitmap data structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706181730.21731-1-emil@etsalapatis.com>
 <20260706181730.21731-5-emil@etsalapatis.com>
 <20260706182758.21B901F000E9@smtp.kernel.org>
 <DJRQ0BBKZLBA.8Q8ACS615TZK@gmail.com>
In-Reply-To: <DJRQ0BBKZLBA.8Q8ACS615TZK@gmail.com>

On Mon Jul 6, 2026 at 3:04 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Mon Jul 6, 2026 at 8:27 PM CEST, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential iss=
ue(s) to consider:
>> - [High] Silent failures and falsely reported lock acquisition in bounde=
d atomic bit operations on loop abort.
>> - [High] `bmp_empty` and `bmp_subset` return `true` on an aborted loop, =
defaulting to an unsafe affirmative state.
>> - [Medium] Bulk operations unconditionally apply a bitmask to the last w=
ord even if the processing loop aborts early.
>> - [Medium] Missing `READ_ONCE()` or `volatile` cast in `bmp_test_bit` ex=
poses lockless polling loops to compiler hoisting.
>> --
>>
>> commit 634ac04142cf736158c99f577c0f903470937bfc
>> Author: Emil Tsalapatis <emil@etsalapatis.com>
>> selftests/bpf: Add arena-based bitmap data structure
>>
>> This patch adds an arena-based word-aligned bitmap data structure. The
>> structure is useful as a building block for components like sched-ext
>> to represent cpumask structures.
>>
>>> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/to=
ols/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>>> index 0000000000000..80e814401fb9e
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>> [ ... ]
>>> +__weak
>>> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
>>> +{
>>> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
>>> +}
>>
>> [Severity: Medium]
>> Does this memory access need a READ_ONCE() or a volatile pointer cast?
>>
>> If this function is used in a lockless concurrent polling loop, could th=
e
>> compiler hoist the plain memory read out of the loop and cause an infini=
te
>> spin that misses updates from other CPUs?
>>
>
> This one seems worth addressing; I would ignore the rest about can_loop
> exhaustion. Please send a follow up fix.

The function is __weak so AFAICT the compiler would not optimize the
call away even if it was reasoning based on the function's body. I
likewise don't think READ_ONCE() would affect anything (correct me
if I'm wrong).

That being said, this function should probably be defined straight in the
bitmap.h header as static inline. It's dumb to require a full call for
a bit operation just because we use __weak the convention for libarena
external API functions.=20

I'll send a new patch with the call moved to the header and READ/WRITE
once for the non-atomic get/set/clear ops.

>
>> [...]

