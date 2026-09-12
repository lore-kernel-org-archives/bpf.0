Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6638F949
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234225; cv=none; b=GCEoKJRNcPnvZ2WX5Xvgxa4eEHmgD6LFxC3qiOguZXdcKo3XznCDc/k40fbI3KXrAX1mgbUG1OApMktgL+1kydI2La3y9NGBHmBUsomd6XhGJxKDRH+LT92aPUWzNe6qEC0Klrcj/9j9CefmUp+Mc7swMmaJxYQFwu+3jkuO2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234225; c=relaxed/simple;
	bh=om9QR3rczhIPvl2WssZUmBkJUSSiDx0scXEWad9F7bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB279VKkO8LCysViq36Qu9ljQWEiEZJYzGWe+TwtQX4DnDvwkhwXn2nf2LR7oYOrfLO8Lt9K03TXHs2Ode4OSFo/ZPTVJHU+gan6sZy7IcScwX0FspmRC88eWsJIdBxxT2MieGgFGT0Zs5rWJX5xgP6HVJ2vwehsNRcLpF+9DPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+sLvllL; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+sLvllL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=om9QR3rczhIPvl2WssZUmBkJUSSiDx0scXEWad9F7bE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789234220; v=1; x=1789839020;
 b=n+sLvllLq/3r+JmW59mWCYck91zhNLH+9FJed0qutcmdlHYTy/07Kt6BvjTNxOZUO7r76u1Z
 GOjiEU+YEltut0AmzpHanF5pvLmseJrntMGgsAqiA5G2VThrPFvNO3ghTEuyMu40UrIcxqcDUYA
 NfFQ+tIO40abHdRogIm7/Uqg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a2066979c6eb270;
	Sat, 12 Sep 2026 17:30:10 +0000
X-Mizu-Trace-ID: 4a2066979c6eb270
X-Migadu-Flow: FLOW_OUT
Message-ID: <31fda93c-1892-42b4-a616-1bc9a35160cd@linux.dev>
Date: Sat, 12 Sep 2026 10:30:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Temporary hack to
 disable register mismatch in arm64
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
 <20260911155030.2012652-1-yonghong.song@linux.dev>
 <DLD1ASZFWOJ1.WRUC6EDWQ9CM@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLD1ASZFWOJ1.WRUC6EDWQ9CM@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 8:57 PM, Alexei Starovoitov wrote:
> On Fri Sep 11, 2026 at 8:50 AM PDT, Yonghong Song wrote:
>> There are 3 kfuncs like below:
>>     __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __ksym;
>>     __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b, __u64 c,
>>                                              __u64 d) __ksym;
>>     __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, __u64 c,
>>                                            __u64 d, __u64 e, __u64 f) __ksym;
>> which requires that '__int128 v' must be 16-byte align on arm64.
>>
>> Current pahole will reject BTF generation since pahole expects
>> '__int128 v' has start register 'x1' while arm64 abi requires 'x2'.
>> Hence, btf generation will fail.
>>
>> This patch is a hack to disable a few related tests to satisfy CI.
>> The following is the fix in pahole:
>>    https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux.dev/
>> Once pahole patch is merged, this patch can be discarded.
> You're adding them in patch 14 only to disable them in patch 15?
> sure, pahole needs to be fixed, but let's carry such selftests for pahole
> out of tree of the time being.
> Once it is fixed and we have a mechanism to detect that it is fixed
> then we will add these tests.
> I'm not sure what would be such pahole detection mechanism.
> We don't want to bump the version just for that.
> So imo just drop such tests.
>
> Also rebase to bpf-next is needed.

Okay, will remove patch 15 and remove the tests mentioned in patch 15.
Also address with other comments.

And will rebase and re-submit.

>
> pw-bot: cr

