Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CD2DAFD7
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217683; cv=none; b=K5UBADgr307VCtJrYc4cq9Ic1ODBJlMjv4FkTsi7KzM5TJS/UaNAyteDiFAAk86hOqfTpXdFkgKBVvr7in3aVQVizC+yl+B6VGpbr9iqMNJKywDYn5QPZhwkijNSMiD1d1rJcrh7IkRdqROIdh/YF49YmVatQYPBI+9k3AiDj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217683; c=relaxed/simple;
	bh=3+kNzHFejOQOLKMulMK/JUItcTuX/0dCa0b0gn4yakM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Payqc3EYCAAhjgpX5D0BmWqI5RldALVR2LHaz7E1VMmnpQFWu2Vgd0fwvUENx+gRXDx01qTQlMJwdathQp5CrbsaZVQbDcMF8ZEmJIwIvvqX4zU5pI+69JNguQeleqLWpyalq8kDQ60jZMVAOGvicVEvEJBQrSzfqHNh5S9D24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VMw2B7OE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VMw2B7OE"
Message-ID: <0b3a3a41-f709-4414-8a5d-d2eb4959db3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776217669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWZ6Awtfs3P/gl9vFEiAqeXj5OtNuxNWZvMMh21RkVs=;
	b=VMw2B7OE+m0xis7HfvVFF4qD/6oF3WQJELxb1d67PI/yEdWIbjSSJyqJFh0NrlOmY8TbmZ
	7a+ie5p5hEJVF6PFLY2oPp0RNWIpMt7Ss8O+s2xBjt4zV3LgOh+usXWX9xyfhCcfH/GhpG
	tQjTjDJfg+w1T+duTHUGiD7s7aq2LvQ=
Date: Wed, 15 Apr 2026 09:47:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in
 BPF_SOCK_OPS_HDR_OPT_LEN_CB
To: mkf <message1887@163.com>, bpf@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
 <42c1fed84a84519c2432163aa46f587f2d624fef.camel@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <42c1fed84a84519c2432163aa46f587f2d624fef.camel@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/14/26 11:37 PM, mkf wrote:
> On Tue, 2026-04-14 at 18:57 +0800, Jiayuan Chen wrote:


[...]

> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -475,12 +475,21 @@ struct tcp_sock {
>   	u8	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
>   					 * values defined in uapi/linux/tcp.h
>   					 */
> -	u8	bpf_chg_cc_inprogress:1; /* In the middle of
> +	u8	bpf_chg_cc_inprogress:1, /* In the middle of
>   					  * bpf_setsockopt(TCP_CONGESTION),
>   					  * it is to avoid the bpf_tcp_cc->init()
>   					  * to recur itself by calling
>   					  * bpf_setsockopt(TCP_CONGESTION, "itself").
>   					  */
> +		bpf_hdr_opt_len_cb_inprogress:1; /* It is set before invoking the
> +						  * callback so that a nested
> +						  * bpf_setsockopt(TCP_NODELAY) or
> +						  * bpf_setsockopt(TCP_CORK) cannot
> +						  * trigger tcp_push_pending_frames(),
> +						  * which would call tcp_current_mss()
> +						  * -> bpf_skops_hdr_opt_len(), causing
> +						  * infinite recursion.
> +						  */
>   #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
>   #else
>   #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..518699429a7a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5483,6 +5483,10 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   	if (sk->sk_protocol != IPPROTO_TCP)
>   		return -EINVAL;
>   
> +	if ((optname == TCP_NODELAY || optname == TCP_CORK) &&
> +	    tcp_sk(sk)->bpf_hdr_opt_len_cb_inprogress)
> +		return -EBUSY;
> +
> TCP_CORK is not support in sol_tcp_sockopt(), return -EINVAL by default. and put the check here
> could also prevent us from calling getsockopt(TCP_NODELAY) below.
>
>>   	switch (optname) {
>>   	case TCP_NODELAY:
>>   	case TCP_MAXSEG:
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index dafb63b923d0..fb06c464ac16 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -663,6 +663,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>>   	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
>>   
>>   	newtp->bpf_chg_cc_inprogress = 0;
>> +	newtp->bpf_hdr_opt_len_cb_inprogress = 0;
>>   	tcp_bpf_clone(sk, newsk);
>>   
>>   	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 326b58ff1118..c9654e690e1a 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -475,6 +475,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>>   				  unsigned int *remaining)
>>   {
>>   	struct bpf_sock_ops_kern sock_ops;
>> +	struct tcp_sock *tp = tcp_sk(sk);
>>   	int err;
>>   
>>   	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
>> @@ -519,7 +520,9 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>>   	if (skb)
>>   		bpf_skops_init_skb(&sock_ops, skb, 0);
>>   
>> +	tp->bpf_hdr_opt_len_cb_inprogress = 1;
> we check the BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG before calling BPF_CGROUP_RUN_PROG_SOCK_OPS_SK,
> could this flag use for the same purpose? so we don't need to add an extra field.
>
> 	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> 					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
> 	    !*remaining)
> 		return;


Hi Martin, I saw your patch. Your solution is better, please ignore mine :)



