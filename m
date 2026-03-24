Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF035F199
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388291; cv=none; b=SBInYPCwD5iVnhu7HZqrIYZKhzsXpqQ2gZUY8mWT26dPb5WAxWBFCsv5A+2JTTT8xHQeH/i2InucQpfaQVWNU1frsoEMbq+/9rAhR7VsIxb8wyzFdQU2MsRVLNaJAyR1LpeUPRuQVHrBI0gr08p7XPGM2F+L0NGxbBvik9YqQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388291; c=relaxed/simple;
	bh=fZSRNNKfUg8R6FueMiY52/uF1W6PTwInbFVyB67OiG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs8yfeB0nNOoWBFrArvRmytZ7cw+jdno05xnBpQrf5YZrHA+fiffvzDhPJA4tNzqamagB0Qt8Bh2VhwHkU5nBfk4GZYwk9sgnxV/o0x8NpBUrBzdWpTslZ7RgOpmQjPfcy9kkfFQ9JfYdM0g8Lov9Z5Q61E5VPyuxIJgvACKVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSH+lIXu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSH+lIXu"
Message-ID: <57592605-2283-40fd-9324-fc55f46747b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774388277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C57VcUZWi6qx2uJk1wElbBhHJxEE088EH2+hB/Wy/VQ=;
	b=fSH+lIXu2p2RGaA6dclWGkiSc3Un9BcjMgMZIkZdtyn58/haThGKGXuDlxfg0D7m3+AtpL
	S7VNA8uf2QsYiS4oz4nECvdSRYUy4r58W8amIcNyjg/SsWtlMtEWgNc+/gQyHes3G2FU3B
	GMf8jeVa/i50ES1V1LcVevvUyQ43nn0=
Date: Tue, 24 Mar 2026 14:37:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260323105510.51990-1-jiayuan.chen@linux.dev>
 <20260323105510.51990-2-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260323105510.51990-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/23/26 3:54 AM, Jiayuan Chen wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..fb975bcce804 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12248,11 +12248,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>   
>   	switch (skb->protocol) {
>   	case htons(ETH_P_IP):
> +		if (ip_hdr(skb)->protocol != IPPROTO_TCP)
> +			return -EINVAL;
> +
>   		ops = &tcp_request_sock_ops;
>   		min_mss = 536;
>   		break;
>   #if IS_BUILTIN(CONFIG_IPV6)
>   	case htons(ETH_P_IPV6):
> +		if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
> +			return -EINVAL;
> +

lgtm.

Kuniyuki, please take a look and ack if it looks good to you also. Thanks.

