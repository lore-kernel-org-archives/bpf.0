Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1D40DFDA
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389452; cv=none; b=rKl52kqsTWCK43EN+3Y0ksTYHFrS7ubkRUvHPSX2sB4olM28thOsTfI+QJzWyJNAenyYi5m0jydoIs49xPKdC3flHBVqs2YsCrasf4JPrJ4p2DAvtDesEOBQ34XUanpWq2G/vIGehtAU6ORsZ02HWP7YsZnvzlxWJpczFCGJtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389452; c=relaxed/simple;
	bh=H4mFBjB3Ci0DYxrHowOiSdzTayooM0MtWEwZEuBa/1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLOhqYG886dOu2y9UsNAN/iqmI2vEkar6r64F5veKC03qUAlhVSaZl26yv1fD6camUL5Y4y84j9Pd7f1DAUjy4pE0ge45VsBVP3Atl/jKtROeqti6XFU9IwIyIu+mAcWbVHUSz5zJ9trR1IAS5N9e5j+eQxztTbgD+M41DXWrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gpAr9R7w; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gpAr9R7w"
Message-ID: <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776389447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8gxM5+m6ma91V7LBHTaHLcbiMBt0pZDSq4mWKEypuY=;
	b=gpAr9R7wzUc8asNm+jV0DX5EscJZ6P9W5lpLhXHbSaBdupMtL0e+AJ/rcVtGZT/Fo/4e5d
	81UA1CWbR8s8zMQF/KE8RxCzvHjAaZVxYnZIKgIxIL2267QJ7eIGM9pINj5d4n9dnpZDan
	SdutYjGRQ1Lp/96uzhkrF60ikbYO98k=
Date: Fri, 17 Apr 2026 09:30:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260414132421.63409-3-leon.hwang@linux.dev>
 <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>
 <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/4/26 10:19, Alexei Starovoitov wrote:
> On Tue, Apr 14, 2026 at 10:19:22PM +0800, Leon Hwang wrote:
>> On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:
[...]
>>> In the v3 series, bpf_map_direct_read() itself had a guard
>>> (map->map_type != BPF_MAP_TYPE_ARRAY), which protected all callers.
>>> The v4 moved this to caller-side checks but appears to have missed
>>> const_reg_xfer().
>>>
>>>
>> Correct.
>>
>> Will add a guard in bpf_map_direct_read() in the next revision:
>>
>> 	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>> 		return -EINVAL;
> 
> hold on.
>  			    map->ops->map_direct_value_addr &&
> -			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> +			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> 
> map_direct_value_addr() is set, but then immediately disallowed ?
> Where else it's used?
> 
> Even if value_addr is working, then map_direct_value_meta() looks broken.
> 

Ah, let me dive deeper.

Thanks,
Leon

