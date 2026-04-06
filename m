Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A73312826
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516656; cv=none; b=utdDP/mDl7VmSi3RCfYB1+vPF1qVBR9mkMZov8PHteapYbN0dbNB1H+GILtkzZx6LEEbKEAjDgpZlPIglVJvUvqpRCG6UHj2s4Nay9TITzUMvrfg5oWQWCvI7aABOZ7y7Yi/Pw0pexlabrZIyjcOtI1aygVeA3QVKKjPTiWoxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516656; c=relaxed/simple;
	bh=nOXZ/qAN6W7udkeDm6idzt5SGPmk+S+wX8zvfg7ThUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU4+FcnlEchS7izZI/sc6GlP1D9kV/y9fDsD/Z+qiKTuoJmYNMMyg2lxBAOqVwIKVvqkhCvA1r9FcqLBE0QakBYD3sXR0eTwM8PCnazuQCr4vyojKTeT6aobLuvqQw0Ggahw14s0yNmZLxLl1xAG7CR1UhVQ1aNm14sfhyet0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xuTJIJhj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xuTJIJhj"
Date: Mon, 6 Apr 2026 16:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775516643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qUf5YDck2DrUiN+WT+6OlM1LYCDSCEbtT+zInFZMOIU=;
	b=xuTJIJhj6Gdlc4tZh7RoJknEjqWf3RhBqwRrpkg42+IkPvOa8P35OD3W7+Yt+oVePnaJ8M
	V5vvwcdKEfRNTQtc6Cv/CN75MngNKHMMbNMc/goPdQIp8fzcBlTTfHuKzWvU3qZeLYRdom
	k/2OiQLrdCxFGt6JwW+RXM4Y//H1iVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
Message-ID: <20264623229.qO5V.martin.lau@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 06, 2026 at 11:12:50AM +0800, Jiayuan Chen wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..53ce06ed4a88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  				      si->dst_reg, si->dst_reg,		      \
>  				      offsetof(OBJ, OBJ_FIELD));	      \
>  		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>  			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
>  		}							      \
>  	} while (0)
>  
> @@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  				      si->dst_reg, si->src_reg,		      \
>  				      offsetof(struct bpf_sock_ops_kern, sk));\
>  		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>  			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
