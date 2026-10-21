Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545956;
	b=l4gu+Ceddsahrlx+dYbiVF4yBTRec1/l9U72ZbigGmH4v9UNaSusmgd/qw1R4voPqSMb
	 rVcoGn6WU55e2LaRG/fko7TTzoH3P9PCgxT7xaE4ZW96AhkqFNZMMWocRin0xC+1/zyZy
	 WksZSI0dc05Nt60JmKaUKwtFqfYEZwjlo+p6XFULgmE3HQCS1WJxbNnesXrXsCGyN9blv
	 TWjM+k4sLiBKgpXN0rGLhUhhm0vcqnHibIcp6FYuNfA/Wb+68pYkcNduE8KC8rSgajR4y
	 ddawaFClG43o1Tvkf45dpDhkpEr9u/i5yaKkowD94xg9X8cAKF1Oyw3sIuyiBQMtsIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545956;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LSKx9HPzqZclmFp5mScoD3vPAujYoTxBMOBIwcaE/Kc=;
	b=RzuGxxBy60Skrgdd84WWTxFjVXoY8x0KqCPRgadIUmBgx/+yIk/0DCdpSFCw4N4pDeof
	 a4/4jRdBhmajG+KnFheuQ26/prCWQBwntAHD3F4HlF57vsE1diWtPB8vtrfZovhM2wZu7
	 WN9zwqiIk8eBmi+dq9dhl3E1HqFvxQRB8imkWe4rLYHEQ9dnu3hVWuxJyKXT/J0lGS2Y0
	 7JOZ6FAOsFkf8Srtg/DVWhaDba6xJpTzHQVGm4moUPx0TBk60nHs4KcZtFNlq5M1MGvjR
	 z4kbdcgC6pjOoPP06k3opLoleP68cjkWEdQatfuv4Bh42AKCWInhPNFbvN4k3SI1EjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oIhj/1Ph";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DF606A319;
	Wed, 21 Oct 2026 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIhj/1Ph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830461F000C9;
	Wed, 21 Oct 2026 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545955;
	bh=LSKx9HPzqZclmFp5mScoD3vPAujYoTxBMOBIwcaE/Kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oIhj/1PhFyssGjP16AI+j08SrtuigFRA7t20hvLDtD1Fqjp0QkuqQ+aVVXFb666pU
	 4fkGTiBGLJYu9X1Bi0e3+bHoGNeEQ4jsF+N2gODHhN9TYuaJIntJ/YMzq0KfJK/Vsy
	 LRVQf5p20vEbSLTcuZojCYe3TwJ+kYA7eEu69/g4FL7ZCEcK80qvjeJmvxqWcMvzav
	 vFkToo3jX1Tapi3TAGJa2A/fXToEYm0jVIuDjzmBFlj+5Xkv8CPLFVM6Z851tkbWVV
	 OXTkgrxc42I4yswc9ovUWqH2ZquFTS1MC+C6gmQWyZ+W20hHrX/t+JF3w4EaBF2TP9
	 jptWb7xgA2trw==
Date: Tue, 20 Oct 2026 18:25:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Masashi
 Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add syscall common attrs support
 for xdp link_create
Message-ID: <20261020182553.534c8d6e@kernel.org>
In-Reply-To: <20261020152804.39863-3-leon.hwang@linux.dev>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
	<20261020152804.39863-3-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 23:28:00 +0800 Leon Hwang wrote:
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -97,6 +97,7 @@
>  #include <linux/kthread.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
> +#include <linux/bpf_verifier.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
>  #include <net/busy_poll.h>
> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
>  	.update_prog = bpf_xdp_link_update,
>  };
>  
> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
> +			struct bpf_verifier_log *log)
>  {
>  	struct net *net = current->nsproxy->net_ns;
>  	struct bpf_link_primer link_primer;
> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
>  	if (!dev) {
>  		rtnl_unlock();
> +		bpf_log(log, "Invalid target_ifindex.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -10812,6 +10815,8 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	if (err) {
>  		link->dev = NULL;
>  		bpf_link_cleanup(&link_primer);
> +		if (extack._msg)
> +			bpf_log(log, "%s\n", extack._msg);
>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>  		goto out_put_dev;
>  	}

No, this is silly. We shouldn't be spreading bpf_verifier.h includes
around, and making core networking code use bpf_log().

Add an extack to this API and for the extack -> bpf_log() conversion
in the caller or some "boundary crossing" helper.
