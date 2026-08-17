Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72E2F8E8E;
	Mon, 17 Aug 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982431; cv=none; b=kc5hgMSHfohF1AcxXk/KheqbaAwBcWCkBdyb1kXO5OLf88HAbcf5jmgpKc8UC6HdRYS1tK1uVhrb2FY+YkAOR02YhlwauU+LSi1ZANmb73TvGf2ABJBJtezgcixEvQcTnavR+yHY3fRR6VscztV6V9t9IEQq0+HeuHZ2F4A16PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982431; c=relaxed/simple;
	bh=1Z6VV8MoP9MNwtQiQnv/FHZJXS28oduvE3PmRXg0sNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHJ7rlr6QicrvSoewYGozPpzi5UT8PxzoODyZnXjz65QaFgbYe86wH/pUKkZaZSJDr4/ElINmbcUwVvZ5JNFLOsKiMBkcD+pw67wuB5qJz1BlbAvPjtRIKWJp8mOb2PdE1tfpq3mQ41y7DnBeJIJHhOAHMpfYPeSD/NejDFGFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jff6ffeV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jff6ffeV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=ijc0uxiB94i7xwerpdn1dVx/M5em0/qkIBO+7AK47yY=; b=jff6ffeVZVh3/872G6Kfa2wUmd
	8ERjZHS0Zm4DT6vRmRcgy17WNtND0K0pXo3jFab+xN4DGYxoXDLosYdoWY00lY64HUuffEgZ+h3UT
	4DcGaDT4WUq4GXdLoHtyI6U7b3Jx/MNW2unXpLEa8LRTyIYuasj/ZIE+ZcMsM1qZesUIE2Lakvl4q
	IAWRn326Op5A1z70h+gvSnukPD5lDi6DWHt2isYdkIlHB4m3N4CjmRffijhWkhSyx/5mFCm34K1ca
	+EkMx3122n32R2oJruYqX5785tWcGtdhRIbUpDMdUHHWmt8br99QzNpupSex9nTNho4q2HafojnSx
	N3BpB/rQ==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wvzkz-004ivR-6C; Mon, 17 Aug 2026 18:00:13 +0200
Message-ID: <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
Date: Tue, 18 Aug 2026 01:00:04 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260803001807.646357-1-changwoo@igalia.com>
 <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 8/17/26 6:05 PM, Daniel Borkmann wrote:
> On 8/3/26 2:18 AM, Changwoo Min wrote:
>> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
>> every translation unit including it emits a copy. __weak makes them all
>> resolve to one instance, but bpftool gen object merges only the symbols
>> and concatenates each input's .addr_space.1 bytes, leaving the surplus
>> copies unreferenced in the linked object.
>>
>> libarena links ten such units, so nine copies were dead weight (bytes):
>>
>>    object                             before       after
>>    -----------------------------------------------------
>>    .addr_space.1 in libarena.bpf.o    676200       86376
>>    libarena.skel.h                   2100123      892371
>>    libarena_asan.skel.h              2641124     1466477
>>
>> Declare qnodes in the header and let each program define it once:
>> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
>> lock it guards.
>>
>> Tested with test_progs -t arena_spin_lock and -t libarena.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> This doesn't apply cleanly, could you respin against latest bpf-next?

Sure. I will send the v2 rebased on the HEAD of the the bpf-next tree soon.

Regards.
Changwoo Min

> 
> Thanks,
> Daniel
> 

