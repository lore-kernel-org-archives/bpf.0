Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1B3537DE
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443147; cv=none; b=L+7Et3T1w+204vmrB/yO3I8jJuMwY+v2Pe2r4r9FFMc9pLucml3wSNurZKDQc1XMZxrbz8AltwEnAr2Vbw6ffPwuEZHX2EVCg4meF2q5EltE3cV+DzejoIdas76GN+4br8ThNkwk44Yw8F8mQ51DheOiV+GYhM3cN2GVGtAEhuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443147; c=relaxed/simple;
	bh=94BI5TrieslVOrJhUQ5ubUHE2QyaLFDLVCjOfZ4bfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvhmDKeGq/XdO6o+epZaU/JTdBP1/IxnWmQBw7kpPauBWH37KMpv4EEnBaB7YlL45x28GT0YOCv8ZCLOM4q8Wx9fDr58BoPw3qY2tteO9QVbV4i1AJdtjr86KpcsRXxbkXURh1/dfmTJarZOWtPu1eaA/kL04YBJwk4Y4TcYElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJoxFBpH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJoxFBpH"
Date: Fri, 17 Apr 2026 09:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776443131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ta1OKOTzp2fmeWL9SMKYpLf/VmLUkvE6ptMi0yslJGA=;
	b=FJoxFBpHTnbZ/jhmHKqENyZa6zw03gTPCjNI4e+Rljbm6UZ0V0WcbJzWcGncFD+L6ALbLV
	8nX5koaFkHCXNKpvSsmQ+C2zD5M3LbsJZPe1iEDYdUoXVIph+0qtiW8TdIlEbci7I+jVwa
	L0+jnn+4w+7ft7HmwLNsXA8VV+7/ddA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
Message-ID: <2026417162132.9MRI.martin.lau@linux.dev>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
 <20260417092035.2299913-3-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417092035.2299913-3-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 17, 2026 at 05:20:35PM +0800, KaFai Wan wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> index 56685fc03c7e..7b9dbbb84316 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> @@ -461,7 +461,7 @@ static void misc(void)
>  	const unsigned int nr_data = 2;
>  	struct bpf_link *link;
>  	struct sk_fds sk_fds;
> -	int i, ret;
> +	int i, ret, true_val = 1;
>  
>  	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
>  
> @@ -477,6 +477,10 @@ static void misc(void)
>  		return;
>  	}
>  
> +	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));

Same comment as in v2. Why this setsockopt is needed?
The setsockopt in userspace is unnecessary. In the future,
we may need to understand why it is needed here in the first place.
