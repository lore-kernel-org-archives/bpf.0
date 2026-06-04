Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E51355F41;
	Thu,  4 Jun 2026 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539896; cv=none; b=dp+J2fj5yEGtP7FPsJ3SPAvFGtWJJjU/wkxHP/mvZJnSUYzpcTEOoSAxR4TAgLddfcAtvIXjzpIaRbPle9AV97tYSPjnWxWJc0wJl0flKmSwGk1GMR31d6x/Okp9Tler8FgrMja0Hb1fGH56kB1Kro3QMOC8uicvrIQYU3sKGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539896; c=relaxed/simple;
	bh=RyFo8FVfiw4cD67y4iwFAZgG/PJUKXkWPV92F9XCv1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko1p31SLXcjMNoBgYjWIIL2jsWrb8BYU7AjG0w7OPD626hEAnZk6AYQQVaT02e0Z/TQV2zG/2pTej5cZNDWb7B7URx+quW+kJvPeziPy1NyUakpQRqqkako4bkE2gfxURsA9uB8sPitDt3YWTVXhNVlK8TKuziz+LvvWqXHpRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csW7CxN2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csW7CxN2"
Message-ID: <9fb5840e-fb05-4c9c-b6d6-73455a30e244@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780539893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3OgiHd02I6U6/2i2gVEQh386Qg32wCGlwxwgJcoS+8=;
	b=csW7CxN2OS37uYJn4UgGEtQF0Vr6XCRDO3aKGKbBDjzA/XaBsPBFzkaJpzegLFIgaQX3BP
	Z4NUuY5i+bAtKB3kgoxHx40zLZo8FwQzzCFiST58ikNufkXqPdM9eCT9ZXRgX6zIh2zG0p
	qpdwn0H0veOwhITdfJlkB9nQgcmW9/E=
Date: Thu, 4 Jun 2026 10:24:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Check tail zero of bpf_prog_info
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, shuah@kernel.org, yuyanghuang@google.com,
 kpsingh@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260603144518.67065-3-leon.hwang@linux.dev>
 <d4a64c5dffb0ebedc7460a21a52f2d94af931fda6c21d039bd71327a4cf79fce@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <d4a64c5dffb0ebedc7460a21a52f2d94af931fda6c21d039bd71327a4cf79fce@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/6/26 23:37, bot+bpf-ci@kernel.org wrote:
>> Fix it by changing sizeof(info) to
>> offsetofend(struct bpf_prog_info, attach_btf_id).
>>
>> Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
> 
> Is this the right commit for the Fixes: tag?
> 
> The change avoids the trailing padding that exists because struct
> bpf_prog_info has 4 bytes of padding at its end, so sizeof(info) (232)
> differs from offsetofend(struct bpf_prog_info, attach_btf_id) (228).
> 
> That trailing padding first appeared when __u32 verified_insns was
> appended after the last __u64 member (recursion_misses).  Before that,
> the struct ended on an 8-byte-aligned member and had no trailing
> padding.
> 
> b79c9fc9551b only appended two further __u32 fields (attach_btf_obj_id,
> attach_btf_id), while the 4-byte trailing padding already existed and
> was unchanged.
> 
> Would this be more accurate?
> 
>   Fixes: aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and fdinfo")
> 
> 
Agreed.

Will update the Fixes tag in the next revision.

Thanks,
Leon

