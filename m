Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EF568FD9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193986; cv=none; b=FrMbkRveBWIY8xBCmlWJZ2KnbMLzn5j4adfQmSd1De7bBKXq+UmzNBi/Jv9DwiZWYZMRcwHNOIcR1zgPEU2uqq9JtqwiZ8UmGpje8vDwGGMAZ2dvBin0slns9DJwaQbAhVkVxYsSCIt/4JrQlyKT2InBjs9cxxs8///3T1WO/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193986; c=relaxed/simple;
	bh=qTGzOnCv6fzhpHCwn0UMcCBwRYMjgsjnBe7/2fuFQ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyXSNA9FOc6Rx738cxc6ODMxTUsEpYRotuvBIsJjZYpczXSL5E0m5d0XqbfHSJFpnhyFh/9Cllhoz2VyA+7fEEAueswYTuUSGWKx32oklYgpTZtKygZ49ImCPxMMWYn5Fc5oADrI81nh+ZRug+FAD0EWJDDw/qWo4EINHKeTY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rV4QUHNz; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rV4QUHNz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qTGzOnCv6fzhpHCwn0UMcCBwRYMjgsjnBe7/2fuFQ7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790193979; v=1; x=1790798779;
 b=rV4QUHNz5brRadoCiMUIFjrsVCuyztre4TdwHc2SM3a0MVyy1ylQZy5d5MBJbIX+PB/cAe/A
 4LWcltyoo4EPQCfRGD7cghM4agZwNExHJxTIwgn1yuM+c/9ZDFUEH31kz3QDrwOcD4gtjo3UENI
 7PNzTKXxfgLwzMQ34ac7mTZI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 040ac713f18715ec;
	Wed, 23 Sep 2026 20:06:19 +0000
X-Mizu-Trace-ID: 040ac713f18715ec
X-Migadu-Flow: FLOW_OUT
Message-ID: <e4761ef3-4385-4ec2-ada8-70f293c14331@linux.dev>
Date: Wed, 23 Sep 2026 14:06:15 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
To: Eduard Zingerman <eddyz87@gmail.com>,
 =?UTF-8?B?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 ihor.solodrai@linux.dev, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
 <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
 <9e055710-d607-4a4c-95c8-eb3a0b4aa1a1@linux.dev>
 <2a1875a99b173fec18d214419efbe876dcd95ad1.camel@gmail.com>
Content-Language: en-US, en-ZM
From: "Nico Pache (Red Hat)" <nico.pache@linux.dev>
In-Reply-To: <2a1875a99b173fec18d214419efbe876dcd95ad1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/26 3:42 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 15:15 -0600, Nico Pache (Red Hat) wrote:
>>
>> On 9/21/26 3:04 PM, Eduard Zingerman wrote:
>>> On Mon, 2026-09-21 at 14:40 -0600, Nico Pache (Red Hat) wrote:
>>>
>>> ...
>>>
>>>> Given your series was defferred, and there is a "rewrite" coming, what would
>>>> be the best approach to working together (between us three) to get these
>>>> fixes in that series too. 
>>>
>>> The, "rewrite", as you call it, had landed today.
>>
>> oh thats great news. I checked on Friday and didnt see it. Thanks for the update :)
>>
>>> So the series in question can be re-spun.
>>> Regarding your patch on top of it, it appears you can just post is separately.
>>> However, I am inclined to be confrontational towards changes like this one.
>>> The purpose of the selftests makefile is to run selftests as appropriate
>>> for current tip of the kernel tree using a very specific kernel configuration.
>>> Main users of this makefile are BPF developers and BPF CI.
>>
>> Yeah we are trying to reincorporate BPF as part of our CI. It has bit rotted in
>> the Fedora env, and our large amount of build variant is where things are
>> starting to go wrong. We need to build selftests for multiple variants, and be
>> able to specify which variant we are building for. Hence the out-of-tree build
>> with specific vmlinux.
> 
> Why can't you build the kernel and the selftests in the same out of tree location?
> The change you are proposing is contained, but it's a death by thousand cuts,
> the selftests makefile is quite a Frankenstein's monster already.

Due to incremental builds, and tool building in different env's

> 
>> Is there any other approach you'd suggest? I personally dont work on BPF, but am
>> trying to cleanup/fix our selftests builds for Upstream/Fedora CI.
> 
> How many Fedora-specific kernel patches do you carry already?

So far its just the series Im replying to here, and the commit I appended.

> 
>> Thanks,
>> -- Nico
>>
>>> Support for distros customizing the makefile is a non-goal.
>>> The "PERMISSIVE" change done enough damage already.
>>>
>>> ...

