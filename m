Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C03D171F;
	Wed,  3 Jun 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478932; cv=none; b=bkzBLoGPi20nFrbjCS/y8w1nzZSdtlubBVNaeemz7+moYMmto+ucCUz4RB2dO3KTwxam9a5NOQ3Ab+EACq4IhXGUOC+R7Nx/z3D2hgb6h5x6Rx1qo3+9EyOBOLh1H0qTvMmo1dVJPaPyKvBbE8JpRH95fDZo5h8S93BNfVbWmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478932; c=relaxed/simple;
	bh=mDlNtNaMXKE7PWLAMYFOuGbqDy36V3zemjvwQy7wGtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4vaj0Sp3ARGArtmLNLWJbl9r61ofJDRS1rVK2wsVgsyHIOuVs4ef/7LyU/yC7SRUVYvs4Pv8VZlTRL9LNWu9dgewkC3iDPVgE0GfhOV5lr1pUpx2MRPOYWMqjy4uI9X25uuE5xLGgRHxdgIK2sAg0S2SO1KGCiBv4v/K88Ig0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3dPrH7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3dPrH7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F711F00893;
	Wed,  3 Jun 2026 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478931;
	bh=a22aX8G8jWpxFSejRD1ZSpMtP0LkraJxihcB9DHAKRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d3dPrH7H6Kafj/ERtMeoB5Y+0Bygp4c3SHuuewWf4g3I9qWwZ18JDSfsmEJRW6MRV
	 WMtbAy0ldSUeaHpH/8j4ojDdp6MRs2wzv37hHEKttQqcfCZgrTwRMm+kqMGZsVgvaE
	 ibIZ5Dd9vRexNmmLUu3qY2h3BynW6hnZgF+RApj6O2F8/GZAHFgu8s0D2ZKHAK9AbY
	 TQPvNBQ8fboTNZ3XnbndmRisXpXczLNVfMmuG0Ki5C6lZvtw4vm6DCYu1bwccdkSdY
	 oqkwCpBQSLDZAT7dIeEM/zs8EzaMgFBjycpzA/xo8yVZuvPNPk8zxGIP07uNTATE7+
	 xN7fmFnkV4x+A==
Message-ID: <59cac824-6900-4e79-887f-174352126932@kernel.org>
Date: Wed, 3 Jun 2026 10:28:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpftool: Use libbpf error code for flow dissector
 query
To: Yonghong Song <yonghong.song@linux.dev>, Woojin Ji <random6.xyz@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 sdf@fomichev.me, song@kernel.org
References: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
 <20260603003339.33791-1-random6.xyz@gmail.com>
 <8e3b5ae4-a399-412f-a161-fbb0121c6904@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <8e3b5ae4-a399-412f-a161-fbb0121c6904@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-02 20:01 UTC-0700 ~ Yonghong Song <yonghong.song@linux.dev>
> 
> 
> On 6/2/26 5:33 PM, Woojin Ji wrote:
>> bpf_prog_query() returns a negative errno on failure.
>> query_flow_dissector() currently closes the namespace fd and then reads
>> errno to decide whether -EINVAL means that the running kernel does not
>> support flow dissector queries.
>>
>> That errno check controls behavior, not just diagnostics: -EINVAL is
>> handled as a non-fatal old-kernel case, while any other error makes
>> bpftool
>> net fail.
>>
>> The namespace fd is opened read-only, so close() is not expected to
>> commonly fail in normal use. Still, the BPF_PROG_QUERY error is already
>> available in err, and reading errno after an intervening close() is
>> fragile. If close() does change errno, the compatibility branch may be
>> based on close()'s error instead of the BPF_PROG_QUERY result.
>>
>> This was reproduced with an LD_PRELOAD fault injector that forced
>> BPF_PROG_QUERY for BPF_FLOW_DISSECTOR to fail with EINVAL and then
>> forced close() on the netns fd to fail with EIO. The unpatched bpftool
>> reported "can't query prog: Input/output error". With this change, the
>> same injected failure is handled as the intended non-fatal EINVAL
>> compatibility case.
>>
>> Use the libbpf-returned error code instead. Keep the existing errno reset
>> in the non-fatal path to preserve batch mode behavior. The success path
>> is unchanged.
>>
>> Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
>> Assisted-by: ChatGPT:gpt-5.5
>> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks for the fix
