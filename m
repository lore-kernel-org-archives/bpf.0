Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2323183B
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005400; cv=none; b=OBpWyHlyihif4E8ca/mNUvr1uMDH9sKyTZ9YTK7/a1zru0Ik5LcUs9lHKvCBU0PWs2ptwfTRhtqyLZ/LJAoKoKURIyfqLWu7ga8rnH7dvxGvL03Dnpl44dtxHBzlSGmIAtKMF/RctsItVXOz/s4W5MVZkj8/z0ozHBz/1VP6/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005400; c=relaxed/simple;
	bh=JOG0L6Gq172CISkGRDxZLPMMC58Hf7DbleGEwo6XYAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXISDkbx8c+nCUii22oT8I0xhJ+ga3oUJPKpdVJLL8Iy3ys+qmgYz9i8k9rKHjYJ2TZQ/rYrYGk8lttb7Oe6xXYM6nYJiQEe3im2gjHFx8ekSJTiH1hM2DC/f8PTDMczWJN8OnYLG0EiMygiSeVzvUaWxlwGsn32ki6pVhmN0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XFS2PsEK; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XFS2PsEK"
Message-ID: <d80a723b-6fe5-4dfc-8a9c-20fdb37b5341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771005397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5oj0gz0dDZJWBDOQszLpH4UWW9G8IfCRFCz6fuZZNlA=;
	b=XFS2PsEKg99Xc9zPWZe4hHvfXu012f0XjLw7naVFh3LegYZ++5yz/vXdDS9RduOrrU+uDe
	aPTtJ7nKYEGsOuOWLTwC5cSnEKAxcon0Qc/GbAJzEpQ4kxTHaOlupedqeb0CAM7wfJmYG1
	dePb6ydT2qNHp7VvRQQ9wj3DCul1R+8=
Date: Fri, 13 Feb 2026 09:56:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace ASAN
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <4150f31f020710932def63e2857ebab1e311b597.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <4150f31f020710932def63e2857ebab1e311b597.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/12/26 3:26 PM, Eduard Zingerman wrote:
> On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
>> This series includes various fixes aiming to enable test_progs run
>> with userspace address sanitizer on BPF CI.
>>
>> The first patch fixes the selftests/bpf/test_progs build with:
>>
>>     SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
>>
>> The subsequent patches fix bugs reported by the address sanitizer on
>> attempt to run the tests.
>>
>> The series is a pre-requisite for enabling "test_progs with ASAN"
>> workflow on BPF CI.
> 
> Also, do we want to have ASAN enabled by default?

I don't think so. At least not right away.

> If it would be enabled for CI, people will need to deal with local
> configuration anyway. It might make sense to put the default flags in
> to save everyone the trouble of figuring out which flags CI uses.
> Wdyt?

WIP CI changes add an *additional* test job, that builds only
test_progs default flavor with ASAN and runs it. Previous test jobs,
built with -static, are still there as usual.

There are tests that don't play well with ASAN such as BPF arena
tests, and some tests may be much slower when ASAN is enabled.
We still want to run them on CI.

I don't see why we should pick between asan everywhere or
nowhere. At the very least, CI should make sure selftests can build
successfully without the asan flags.

Additional job will catch most of bugs of the sort covered in this
series, and that is good enough I think.


> 
> [...]

