Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6933FE36
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095752; cv=none; b=k3NPf9P20kErGku0y6MLx+HODQEk2+B4hwFQr2hi+AeLJ1cvxfFkEYNmJkNAwzRRtvo1on1/0V2gfqYF8AbGngjNG4BMhp2lKN7IL5VdtVz+53TkMKhMMjCE0mhtu5L8DVrInLEccCPooLn9P/4KPiOlSxO3/4cmiS+YqznITrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095752; c=relaxed/simple;
	bh=LJ/sqwiQRmj2s1zgWM3ctUiE9Id7p18jzYMi57IuI6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnODWkJFGlGVHTVIBYlcefyrzW79/iostkAktehnZXnNzoRd/HkX3s9POBZ2+Pjdo2EfVM4eyb8nSW/Ewb1JbBjfTHLcauyQBPD+MrWb4ynU5JQHEAqLwzG9b8ozk8HSE17UoHVKu+OQL7GPf8MvXyydYutLYDMhkFZ88yh/a2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ag92OM27; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ag92OM27"
Message-ID: <5c8e69ea-df49-4604-8431-56e1b478402c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780095748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcY+Et1qa6/TZq9VEEZcD722TLcFj+2jg8TXVdHGtIg=;
	b=Ag92OM278yoLVS6rC/GgFrpsnLVCRv43rsTI9ZWoZ565Gw55zChONa+wEsiBKazwujMg9o
	+DJzd6iSlyn5BtyOqAJ2meZqqT+gJGEr2Vd7F2NnWiOe31UQYWOyjyvIZZrV3VcvFKfQY0
	tMbekYnOW+OudwuUUUqurfcylcjONK0=
Date: Fri, 29 May 2026 16:02:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, zhuyifei@google.com
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/29/26 3:44 PM, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
>> YiFei Zhu reported [1] the verifier regression after switch to cnum
>> based scalars representation. When the following sequence of
>> instructions is processed:
>>
>>     1: ... rX setup with [negative, positive] bounds ...
>>     2: if rX == 0 goto ...
>>     3: if rX > C  goto ...
>>     4: ... code relying on rX being in range [1, C] ...
>>
>> The cnum-based implementation only infers that rX range is [0, C]
>> at instruction (4). The pre-cnum signed/unsigned ranges based
>> representation could always deduct from 'rX != 0' that
>> umin bound is 1.
>>
>> This patch introduces a workaround forking the verifier state when a
>> register with sign-crossing range is compared to zero.
>>
>> [1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e3.camel@gmail.com/T/
>>
>> ---
>> Eduard Zingerman (2):
>>       bpf: fork state when comparing sign crossing ranges with zero
>>       selftests/bpf: test fork on zero comparison with wrapping ranges
>>
>>  kernel/bpf/verifier.c                              | 71 ++++++++++++++++++++++
>>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 +++++++++++++++++++++
>>  2 files changed, 139 insertions(+)
>> ---
>> base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
>> change-id: 20260529-cnum-split-at-zero-3c03db9234d3
> 
> I don't know why CI misses it:
> 
> https://github.com/kernel-patches/bpf/pull/12235
> 
> But I see two libarena tests failures with this series locally:
> 
> File                 Program                    Verdict  Duration (us)   Insns  States  Program size  Jited size
> -------------------  -------------------------  -------  -------------  ------  ------  ------------  ----------
> ...
> libarena_asan.bpf.o  asan_test_buddy_oob        failure         879905  209739    4158          3931           0
> ...
> libarena_asan.bpf.o  test_buddy_alloc_multiple  failure         269851  110341    2774          3897           0
> ...
> -------------------  -------------------------  -------  -------------  ------  ------  ------------  ----------
> 
> Investigating.

Hi everyone,

Apparently libarena_asan tests are currently skipped on BPF CI,
because they require clang 22 [1], which is not yet enabled there.

I'll work on adding clang 22 to CI, but in the meanwhile please make
sure to test libarena locally with clang 22 if your changes are relevant.

[1] https://lore.kernel.org/bpf/20260426190338.4615-6-emil@etsalapatis.com/

cc: Emil

