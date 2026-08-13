Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305B3EEAF0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645541; cv=none; b=ledhNox2NOPHFVwIV4vRcxOYFERObw//GxLPxaaH+Ai4j67shZN+TdK+MG3bY0BGZ84wg/m03SkuWm17xeg7vix0BJ2i6J9nBcsyIra3DkKl/oQnOecl7jDpoJt9yf0qpb3bExeyjoCIOne+hpr6yR7mPiNt3tAhiOGZA8Cjp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645541; c=relaxed/simple;
	bh=UzSA+VFJYti71rZHH5gSTkBO5bcNrmYyJi4ECA8XBKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSYqd92iOHpMAvXiQH7ZXKetvj3W5LUvYiF8HMeA6Y32jePmYuLxikthkcw6kBhR+gfLL/vNymwwxvLNvGRDcr8Z6urTn9CZK5JpL/5516J4e3ew0n/yD28AW1+lx2vh/tLCzulPTupNYpQ5UTzebaZOC1Nol+SJ7L886BhQ/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wd25Yh8a; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wd25Yh8a"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UzSA+VFJYti71rZHH5gSTkBO5bcNrmYyJi4ECA8XBKo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645538; v=1; x=1787250338;
 b=Wd25Yh8aQuNz+vYDx2MzWvd27FBzj2sgQTQaH4pjCAwrkyMvJn20BOhInbsvMQnIeDarmNAt
 ADy4p8HI4lkypBZZ0lIm/sgY+PXMAxA6UkUXbMfUlOW5sTRO2E4S1IXpWGHen+BtYJXc8ANetnT
 VB/LTe6MizPyGJWHz8qGKZEk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id e68c19b4d51636cb;
	Thu, 13 Aug 2026 18:25:28 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <7526ca02-32ed-4c9f-baf6-483e062057f5@linux.dev>
Date: Thu, 13 Aug 2026 11:25:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811001008.2383983-1-yonghong.song@linux.dev>
 <47093952550af2c87bc5730d0d9cec8f1c6e622cfb0216a9b1256118d8413274@mail.kernel.org>
 <7284d446-b51e-407a-ba9c-fd42c8a8a99e@linux.dev>
 <bdbd94d09064d30e7c0d445f8f8e9f04d17b9dd4.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bdbd94d09064d30e7c0d445f8f8e9f04d17b9dd4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/26 4:29 PM, Eduard Zingerman wrote:
> On Wed, 2026-08-12 at 14:08 -0700, Yonghong Song wrote:
>
> ...
>
>>> test_progs tracks whether bpf_testmod.ko is loaded in env.has_testmod
>>> and sets it to false if load_bpf_testmod() fails. Every other
>>> testmod-dependent test in the tree checks both the architecture
>>> capability and env.has_testmod before attempting to use testmod kfuncs.
>>> Examples include bpf_cookie.c, iters.c, ksyms_module.c, btf_module.c,
>>> btf_tag.c, tp_btf_nullable.c, module_fentry_shadow.c, and
>>> core_reloc.c.
>>>
>>> Should test_run() fold env.has_testmod into its guard to match the
>>> established pattern, so that the test skips cleanly in all environments
>>> where bpf_testmod is unavailable?
>> Yes, we should add env.has_testmod.
> Note that env.has_testmod handling is inconsistent across the testsuite.
> If anything, I think this flag has to be dropped entirely.
> I'd suggest to ignore this llm suggestion.

Okay, I will ignore env.has_testmod thing. I will use RUN_TEST() for this patch as well.


