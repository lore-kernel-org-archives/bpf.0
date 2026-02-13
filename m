Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1769285404
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007407; cv=none; b=oWScl+ghDiRiBXZzCIkXWemBpBFnSwgwgHh/dM3+9ib/61PSYjcsdkR29Fs6ooB5HEXEpD+zqrBYXBanHezG5NkL1RdVbmrmSAJjGUVWHX0xOq9srGpm3lfK2JytZNR2JaAU5UZWlDDtfH0vmC6fjWgJybz8/PE5i0ZNG3kAhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007407; c=relaxed/simple;
	bh=Iru1qCgma0zYOb2dfHKDXM7j2ROL4NwpmNy98+n3eic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkfKpgv6eiI4gNOhmCS5dbp+ECOGxJk49Z5l5odj+SwGX5TNaYXiFDuzzy4ZMReUOqAilFpvRrq8M1jhB9ovF4aNLPOjEyHWMsWjARXIXhjYsVLZ2tMB36DiiBKJ5wTxbnp7XkbvDWvisQFGlcaMWC0796b2gJvwISL3maUQNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKBARnui; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKBARnui"
Message-ID: <a629ea64-b1ba-45c9-bd56-433f09d32abc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771007393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZJUQZY0NIW3v0HbLWLTJ9sbQVj6zGkEq3qZWYhgc4Y=;
	b=pKBARnuia+ZPsMpzEKfcaAoEt7B7ElC72/0narxswi1TC5Jt20MVcBga/uuzkaBC1cOXVb
	xV5pyQA6HJZfrv5e2Ne/TZtkd8vQyNDSN6fCnmGHQ7mYlYsdYXL7C4q2Pgo5MHgI6bUB6X
	aVxjxQ23zHPnzUo0KkXiS0OaAe56usY=
Date: Fri, 13 Feb 2026 10:29:47 -0800
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
 <d80a723b-6fe5-4dfc-8a9c-20fdb37b5341@linux.dev>
 <f73c28386eedc3ad462906041a4962e3465b1a1e.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f73c28386eedc3ad462906041a4962e3465b1a1e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/26 10:09 AM, Eduard Zingerman wrote:
> On Fri, 2026-02-13 at 09:56 -0800, Ihor Solodrai wrote:
>> On 2/12/26 3:26 PM, Eduard Zingerman wrote:
>>> On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
>>>> This series includes various fixes aiming to enable test_progs run
>>>> with userspace address sanitizer on BPF CI.
>>>>
>>>> The first patch fixes the selftests/bpf/test_progs build with:
>>>>
>>>>     SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
>>>>
>>>> The subsequent patches fix bugs reported by the address sanitizer on
>>>> attempt to run the tests.
>>>>
>>>> The series is a pre-requisite for enabling "test_progs with ASAN"
>>>> workflow on BPF CI.
>>>
>>> Also, do we want to have ASAN enabled by default?
>>
>> I don't think so. At least not right away.
>>
>>> If it would be enabled for CI, people will need to deal with local
>>> configuration anyway. It might make sense to put the default flags in
>>> to save everyone the trouble of figuring out which flags CI uses.
>>> Wdyt?
>>
>> WIP CI changes add an *additional* test job, that builds only
>> test_progs default flavor with ASAN and runs it. Previous test jobs,
>> built with -static, are still there as usual.
>>
>> There are tests that don't play well with ASAN such as BPF arena
>> tests, and some tests may be much slower when ASAN is enabled.
>> We still want to run them on CI.
> 
> Fair enough.
> 
>> I don't see why we should pick between asan everywhere or
>> nowhere. At the very least, CI should make sure selftests can build
>> successfully without the asan flags.
>>
>> Additional job will catch most of bugs of the sort covered in this
>> series, and that is good enough I think.
> 
> My main concern is that when this fails on CI I will have to dig
> through CI config to recover exact SAN_CFLAGS used. If not enabled by
> default I'd still like to have a single knob like 'ASAN=t'.

I kinda have a switch like that [1]:

	if [[ -n "${SELFTESTS_BPF_ASAN:-}" ]]; then
		SELF_OPTS+=(SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer")
	[...]

Any ideas how to make this obvious in CI logs?
I could set -x in the script executing the make, but it may be noisy still.

[1] https://github.com/libbpf/ci/blob/selftests-asan/build-selftests/build_selftests.sh#L50-L51
