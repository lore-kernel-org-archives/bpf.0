Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C13AD22
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268918; cv=none; b=DREjZ1EFL+nLeIhq5TZKLJWNrnIxi6fVt6NTDPgwrpGr022vdc4M+3WhaWCFmHf+Lv/Vlea4fQ2ZZLO0S3mVogOmP/84inWflnCxUtJLmmMOvhjmbab6LkphkupV5BAXKhM5G1Cq4vDvcO75EJSpooOFOOhyBTSSBtYO1ejb+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268918; c=relaxed/simple;
	bh=j1OE1V6ZL0SPLFqZKNScSmCLy87eL0mNLvEcwUI4AHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvBkbGIjOx1jxITYAjuHDzTQVZnE7uwWZxOzk/72gYOshx3xXhugvivqJRU+l/DXLjzJ2uGJEWfGs0QGwm6n6+ZR4HWKzedxKS3ItImzvwrmTPwPX8SyU8jrmMCifQE9TZHrG3r/sjVaRpXOQfpcuqGQzSz3DOOt/D2uo6i9D5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbX5uh20; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbX5uh20"
Message-ID: <2814f3b7-1254-4031-8c57-682963f1e6d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712268914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+i7TKxwkPX4j+zPOgvQXMrvAFSuTCkEGqAnVMfC0mg=;
	b=jbX5uh20QIyc+Ttm8wn12fMiEwu+h8CSx52iMpYvcBS3M/viHXNjL+jRRfxnzoHO7yGbsY
	lF0LQzi2VNlre+T9uMBiJ0yoYn0riplISGbCHByLJ4vFQq7Eq9GLQYBVXGdYps0nOtaUbW
	5HFMI1CxvcUC01YjNOvO2lLGIv7REVw=
Date: Thu, 4 Apr 2024 15:15:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: allow invoking bpf_for_each_map_elem
 with different maps
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
 <20240402061615.48894-3-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240402061615.48894-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 11:16 PM, Philo Lu wrote:
> Taking different maps within a single bpf_for_each_map_elem call is not
> allowed before, because from the second map,
> bpf_insn_aux_data->map_ptr_state will be marked as *poison*. In fact
> both map_ptr and state are needed to support this use case: map_ptr is
> used by set_map_elem_callback_state() while poison state is needed to
> determine whether to use direct call.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   kernel/bpf/verifier.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 515ac6165ab1..f0a33f7c2604 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9649,11 +9649,7 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
>   	struct bpf_map *map;
>   	int err;
>   
> -	if (bpf_map_ptr_poisoned(insn_aux)) {
> -		verbose(env, "tail_call abusing map_ptr\n");
> -		return -EINVAL;
> -	}
> -
> +	/* should not check poison */

Maybe change comments to below?
	/* valid map_ptr and poison value does not matter */

>   	map = insn_aux->map_ptr_state.map_ptr;
>   	if (!map->ops->map_set_for_each_callback_args ||
>   	    !map->ops->map_for_each_callback) {
