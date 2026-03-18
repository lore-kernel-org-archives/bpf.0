Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263C33F384;
	Wed, 18 Mar 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853573; cv=none; b=mI2V9Ewbq7EwyyEaZS/+EGLIiITpsyLrjuny3gOkZxRXX1/LQYrosSAu2WYIKuoTdSBh5DuSPgHiP8FeskPU/H1nKpmFHXANSU4mVUzsRT+RjY1aLOOn3k4mdZpnDOKWUlloauUlrAN7mi1PLHi7vr2bjjReaMfNFEqIR4bbFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853573; c=relaxed/simple;
	bh=VbDdPt5V2iYDxuFM5o59Js8zGg623WZdAgM4YWkYbu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaRzUKJgohnE2RyyVnZt6Asv8sCsfvxLqAISg+QBv6nD2R0NjQpBTgEDZUKOdy/KEunKMa+DIYX2Fii6V3RBppdvQeov/hu2DexrDP0RjJg+K9RZ/ZQrOlfgMOQwJf2o8nfeA6PG7yp5Jf+nvwIRq/gQGVmPscKrexfjHj048+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pHVGGxZ6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pHVGGxZ6"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1w2uLC-000PR0-G1; Wed, 18 Mar 2026 18:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=9PjUi89Rq5UeOAy8wYWz7JCds8tIZvlL7cDob3xI8us=; b=pHVGGxZ6bGP58yl0P/YsBDrG4z
	wP8Z+87vN2YGOtei8ZYgbf16cLT5hBZKtTRua5ogL1iAIyGk/pPz5eW3Px2k4vDVrU3bvWHmpWwbS
	JrFVLIMJlDfRuMaIkv0Y8E0jFiCSW9RgwWKBRmYWKw+wHjMeCGS4nkoJE9ZSfyzbmvwfbR+pxGXEW
	dlGaTfyl1diOBd/7+OUDJYz9i0O2q0iRcHmxH3RqE/5ohXLK1Oy9Oww1OBKAVhnMAzFL5Kz8Hw/kM
	9ROKw1LMay1klkUjVLpeWBEsEIt6QNlEJDDNb0a4JderIMjPm8hq+9dLmIz8h7Qb/HltdF24Lch+1
	3Gu8XxuA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1w2uLB-0008NP-6n; Wed, 18 Mar 2026 18:05:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w2uL9-00D1bi-AC; Wed, 18 Mar 2026 18:05:51 +0100
Message-ID: <c7742de5-7b68-4520-95b4-7ed5ed997c0a@rbox.co>
Date: Wed, 18 Mar 2026 18:05:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/5] bpf, sockmap: Annotate af_unix sock::sk_state
 data-races
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 00:30, Michal Luczaj wrote:
> sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
> socket sk_state locklessly.
> 
> Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
> not only af_unix, but all non-TCP sockets (UDP, af_vsock).
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/sock_map.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index b0e96337a269..02a68be3002a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c

...

> @@ -543,7 +543,7 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
>  	if (sk_is_tcp(sk))
>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
>  	if (sk_is_stream_unix(sk))
> -		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
> +		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
>  	if (sk_is_vsock(sk) &&
>  	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
>  		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
> 

Another reason to (conditionally) take unix_state_lock() at
sock_map_update_elem{,_sys}(): chunk above can be dropped.

