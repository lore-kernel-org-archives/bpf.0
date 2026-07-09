Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778039DBE5
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615955; cv=none; b=CS9WM4R5eX5UQDhaFLlS3vVYXU5lKoKO12HuGJGjvR00qfpY9MSM1sCKYiUhtoj6y/LM1EGB3W4c+l0EJTFvjMbdUGNtDitCKn/yv6pFcMdIoHi8Wf1l99S5MjjOdYLlPXCyjD8BddzyEvoB9EP/Sf6tm0s3GNanvdFIJoOjjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615955; c=relaxed/simple;
	bh=Xj2o3ll4J+2q0IZeu9+inr1nnWcPtaB4aJ4jcH5492U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uV+P24RLWmv+mmkFT/WHCDpqEdTNqXdEg7H9NUNsN/0yTCSecGH8xDEHZdRukzCB3tIBzaEPUgTAFmv5lORiLfHX+VQrquiDghgubTMpaFd0tX4og0aYE7jcKUcI3aGlwE8EaZ44S6UM3XFXUQ56DfC6IspYukkqyIDgRDxl1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rnKpqQfp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rnKpqQfp"
Message-ID: <61150c2e-948e-4dc7-ab00-09547906bc1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783615951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IezaUPF9mWoGTRJQlStXkAdqcU1uFvpNb90rb6MnNuc=;
	b=rnKpqQfpWkkgf2K1+pdSyeMDN0upBF5D8u7V63TMwgBj0iC8HYldYcf5I+gXTuEQk0wEoy
	RcbJZUtc/1A2P3uGa0dDVnxG3pp35wkICvdqiu2R3W8b4GJFYrk7WMjx5IECax+AIUiuTK
	FI1jX+leCAVWt7qWtB9ciaSjRQYwRqM=
Date: Thu, 9 Jul 2026 09:52:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201015.2159760-1-yonghong.song@linux.dev>
 <b1e6bb7d-8729-4baf-b64a-e514118fef75@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b1e6bb7d-8729-4baf-b64a-e514118fef75@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 8:16 PM, Leon Hwang wrote:
> On 9/7/26 04:10, Yonghong Song wrote:
>> btf_distill_func_proto() builds the function model used for kfunc calls,
>> the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A following
>> patch relaxes it to accept a >8 and <=16 byte return value, which for the
>> BPF target is passed back in the R0:R2 register pair.
>
> Do you have a plan to add >8 byte return value support for them?

I tested with vmlinux BTF built from the latest bpf-next. I got (from vmlinux BTF):

    total number of functions: 67500
    return type size (> 8 && <= 16): 51
    return type size (> 16): 10

So in the initial version, I didn't support >8 byte for trampoline related
bpf programs.

But I can certainly do this, we just need to allocate another 8 byte for return value
in trampoline.

>
> Thanks,
> Leon
>
>> [...]

