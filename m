Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0053FB7F6
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253349; cv=none; b=oPtayXtTtLwzXU+iep1CuOGAR0P5dKPm7tPNz1oP0zoOyHQzUpDVYaZ49VzNdmG1tfcjFBr+zP1PRt153A6W4Za9NbguUdKhAkiR3IiDZNrSwJEAVBLYQ5u1cV/7dCcULtzCtzXBFPBfkmZnIIv0yf18udC9oq02RbhbSez5EQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253349; c=relaxed/simple;
	bh=QTCFy54J5oT0q57ktVfbNPWs/6RQUoT+/yIYyo5bzkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTgP1ab8OjrPTHWGNtXbveeW19VkRxb3TeBHYCxMVhYk9P/F+1LdM/QrXhqhwxnUWX3gshn5uGSH60of56dADaqggKvpmAKN4MEeWPwX7tNiJwl7wvCnXrttD362TR/BeZ+ocAhQRI8wJKLwgmlhQKe51soj+LPZ5tMoWY/5D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir6HEYxu; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir6HEYxu"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ab232cc803so10481925ad.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778253346; x=1778858146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oaliql9sqskgI8tL8intOqmIn9GbCLcLJL3l5R2zxMM=;
        b=Ir6HEYxuF1jD8KFdAzUHcMEimZ1BXDVOpgBTRRLDBQirqFxoxf361jYpidJsQ9+zk6
         0uDJWJWY85YTTLH/YGn9IV9VY4EYlStRliUCAjGUoUNZoN/kQXEQmEzmNtQnOIlrsXCb
         LtGV/5HRS8STmeFefz6uu1yy/7PgnHL3j+NUs8AjFq9LzR+6AllyiO+36ADvCT/VtGVw
         bzK26DRnZvGWCWohogjVOanoEIDlqvnjmgR6SbCf2NeI38l2N2xa3J8tBFuNsj+C9HTp
         xmYjgEl5XpBBj/F+PUBsvlx1Npiq4FILa+ZpSV73OE1v3nnqIR3JOSCzWOEZypYGhlNM
         nlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778253346; x=1778858146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oaliql9sqskgI8tL8intOqmIn9GbCLcLJL3l5R2zxMM=;
        b=hO9kIFFzhsKQZhN6d0YI+UZMe2BPLCd8J3zYZIfXk2VhDQ1jNLlkojIVj+sw7W0HqV
         YA0n4PLUX4lLpkpTDrSnnWR1AYQPW6TDqVLzroA0zPRZTFDChEKpL5twMusoMVgzdFLi
         G3ZGk4arNd23kcxmtFr417/Zf6Q9H9WeFWLrFimkw5WLIKTo8aht7NihWab1jJSMHr2p
         70o8js8wAJIITGOvrxSq9xJT7evnuZe0zrEureSIdvVxGYD51LnnMksIv4zqgGqTXt0h
         mEBSsyiWoUeTTWb/cR4z13LN6qiYGWUW7aTeCemnGdv3FLnnPRkoN50C+qNogiS1EvZw
         Ay0g==
X-Forwarded-Encrypted: i=1; AFNElJ+B3S0+XiemwF33ggOX193Yh1kHIvRqg5/x91HmjlD1dDRsmKuB+TUyNR2nck707xAs7LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRGt/xXmAjo0SymO20S94afaiUhMI5QfSws9SNKh0xlLYeNcr
	QCy+D1igmyMvntGhX3Sxc1zMuRtPl6cZHgnaqwyoXTUzMrYtPGEmPbH9
X-Gm-Gg: Acq92OG6tK7dCkHvcAj8LsiZIOtN3xglgvhIvO+B0yZC7g5no10TZpbz1cRNw2j8SYM
	M3kiPCv8SFrkq7K3DXgzMfY9d2ZemYbStaeh56zd5YbAj19LoGVxQMoU0PlJcaUbkqf++m0WINb
	FyTd4AkeyQEbP8vn2OXJjRhIekRqqdM4HRW5cqlypq6khstrUbBgcN98Y/yoxO+fTG1hCD3xENx
	BmoYPTxkmd0FBOeawrardy1cEQCTw9/xyF+K3QsnXr0yK7MluXMow05w2vMcj+od6WPsWd41NAm
	0YVG6491Ai5HJTPJis3gtbU+8WMfP2wvsKgTlFC69d+oeDvRwKMETdqo4SI0LyFwPUPt29b7ZdH
	lBRFfrzMmz5WlG6WrJhkpBCXCpjdCogSZOp/do196WWZxRxwv2zMrmjEpLEfdoXIAko8HXw11Z0
	ZcypmbdSD17X8Xipd7w+BPC3AS9jU=
X-Received: by 2002:a17:902:8b84:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2ba7a343404mr94812295ad.37.1778253346416;
        Fri, 08 May 2026 08:15:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec232esm26222665ad.81.2026.05.08.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:15:45 -0700 (PDT)
Date: Fri, 8 May 2026 08:15:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-4-kuniyu@google.com>

On 05/08, Kuniyuki Iwashima wrote:
> When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> In this hook, we want to parse the RPC descriptor in the skb
> and adjust sk->sk_rcvlowat based on the RPC frame size.
> 
> However, we cannot access payload via bpf_sock_ops.data on
> modern NICs with TCP header/data split on as the payload is
> not placed in the linear area.
> 
> Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> Two notes:
> 
>   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
>       invoked from recvmsg().
> 
>   2) Access to bpf_sock_ops.data will be disabled by passing
>       0 end_offset to bpf_skops_init_skb().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772..94d07a15b2ab 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
>  	.arg3_type	= ARG_ANYTHING,
>  };
>  
> +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> +	   u32, offset, void *, to, u32, len)
> +{
> +	int err;
> +
> +	if (bpf_sock->op != BPF_SOCK_OPS_RCVLOWAT_CB) {
> +		err = -EOPNOTSUPP;
> +		goto err_clear;
> +	}
> +
> +	if (!bpf_sock->skb) {
> +		err = -EPERM;
> +		goto err_clear;
> +	}
> +
> +	return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);

nit: wondering whether it's better to use __bpf_skb_load_bytes (which
wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
magic and used already by dynptr?
