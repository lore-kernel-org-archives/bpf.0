Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F506AB6
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335027; cv=none; b=Q/zPfuWBUZfhDVU3pQo5TH67LT0qQLuDcB2NwFgTWu4lPbjGcspB3Dw2RFgSTJ2C2MLl49cuenaKhTF6aNHFVeWWPpRDb3aozXztC/SVIiiSBKjYO1nkYCfJQ7ZaNJ1WOKuzQykLFE+8zISFhnywLQJ2XDz9hYzIxbeCxgZ4qRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335027; c=relaxed/simple;
	bh=OW4UW7Y1JVQLQu0UT3E9lBRN78f2Buk6aCrg4my6p38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRXKrb1bIslzFg+d8BWZtLPyd53tpiLrMtU7lY7B5yx93ExWnrOq2rfrbIiwMmO9XapYBk+jXwMiIa1F2nkFl5PtAP4Kon4yzOhtTKVGwdS9kTKlwEGHxCkuz11Ys7AhTrUGep4RnUClpaeLW9Cc1aKEzATFGMMqSSW+6oLoUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SWzdg2lA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SWzdg2lA"
Message-ID: <554a923f-3f3a-42e5-825a-7a563a2dbf0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712335023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW4UW7Y1JVQLQu0UT3E9lBRN78f2Buk6aCrg4my6p38=;
	b=SWzdg2lApgFZ0q5H/tcIUI6+Uhs8+gLNZhmL6d12A8a7KxdsO3GsVVp8OHw8xLDjdDKiB4
	nUuKROq+TlbztEV3k0pX0nUtam0VuBX6HmC9e6Zap69+7nzDYM601AkfOtdnZ+3dkYp98x
	eWh0+rVISp+O1XgHnXPwktBSGTSj1Wg=
Date: Fri, 5 Apr 2024 09:36:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/3] bpf: store both map ptr and state in
 bpf_insn_aux_data
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
 <20240405025536.18113-2-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240405025536.18113-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 7:55 PM, Philo Lu wrote:
> Currently, bpf_insn_aux_data->map_ptr_state is used to store either
> map_ptr or its poison state (i.e., BPF_MAP_PTR_POISON). Thus
> BPF_MAP_PTR_POISON must be checked before reading map_ptr. In certain
> cases, we may need valid map_ptr even in case of poison state.
> This will be explained in next patch with bpf_for_each_map_elem()
> helper.
>
> This patch changes map_ptr_state into a new struct including both map
> pointer and its state (poison/unpriv). It's in the same union with
> struct bpf_loop_inline_state, so there is no extra memory overhead.
> Besides, macros BPF_MAP_PTR_UNPRIV/BPF_MAP_PTR_POISON/BPF_MAP_PTR are no
> longer needed.
>
> This patch does not change any existing functionality.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

