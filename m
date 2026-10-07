Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA506386C25
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384672; cv=none; b=iKxoYRrzfXRYnTv4vWCYeeimqmX9Ti7ROCTIv3rZtlHh699hg+lAx4NxMY0/ZSzX/D6c6O0wYJaldGU+Y7SEdwAJJmABAN96/xle3EmbXl37t5G408CeS1n3Gj7Sbzw1EmgJapDWozeoUEDcpr9cxB1hoIJRv/WZONLFevmnIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384672; c=relaxed/simple;
	bh=zg/uWw1C9tuSxeBV3eFBhNDtdmOBp+EfUsAftSVbJTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=En4kGsHV8igXUdWs1BkMLmxjml84dBQqw9/hOgdid44/1DImx1CgwhDui7YlyXBAKeo4hrOgRlGxjtJbYbLSst30TtcCu/SVETWnigcOYSBDnrGuSsf3QyyFxuPFmjH8ACfs9aO+zuqzB9LhsKMvqv1J4wn5O7oIhvUFRbX0Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c61zuYBY; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c61zuYBY"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c70f69d3fso3594828d50.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384667; x=1791989467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YACwyXnL3UskMX5dK960KQ1iZfinHNnmBFhBCvvDh5k=;
        b=c61zuYBYytyJwqC2tJKeP6CGunPFCSNS5tS/mzIXaXxDHHi5/vQ9ceqV/PSyxVYZwI
         Wks4N4Pt5n/kv2/Xhbg7Bdqedo+3vITLvw+1wwnM/mKFKc774lPO7rg6SMEmbQrnrXQa
         GLEo+4AAy9AbGgnAtK8FdZy9NBJD7Xog/zqZCN2hDXdMmjJ/mcA1D8d/ZMW0zK3msV+7
         f9zMHJDp9C2m8Jng6c2DHfWj9BoeAV3QJX9C9xLjZwUQLAixt/7YTld5bP4u0q5tPfgr
         btMR/En/i/NnvvyyCV39B3FCi3GEUKe4nK+XT+YC90xvLPdgb4XH+Q5xZac6ZvCwvqjK
         KNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384667; x=1791989467;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YACwyXnL3UskMX5dK960KQ1iZfinHNnmBFhBCvvDh5k=;
        b=o76Y6ukMEcf4vw/yFvV+x4vjaNb1My/V9ubb5PO+1gtRx68ZK2jB4pvTv1V+ACoEj4
         dGyb1mMD7OLt/8kxp3XMepI6tEQtSoyNqDj5Stk9RqgvslpilHDBF3B1o16ouPbQVTYZ
         SafrUStPDUWfTHkTJ8t+PPkZThV4xndz9GOva4Lvc7ZyxBbKXbDlV+fzpUiyv9/NzYG4
         GuvMZ89Jm8XxRhtY/xAD6qPfNCc8PdEMNBg5JkaCjeUkKixuK0JahLcsURNUAhLRBDwr
         ycuhv303+mrnM6r41dxCzLEq5fFkJmjGQ3JcF8Ms2w5BM17zGybCRlJkiOreo5YShVdo
         OVsw==
X-Forwarded-Encrypted: i=1; AKwUvByw1KkB3vsru+m9YCSwSX+ili8LKAn3OCLGLaLOfLW/bHi8EjBAM4zWyfvUWaF2wDXsgG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEnYZIZuuRAnVm9knOE5UOflw0IsZV2zFapyVcx0UxQ5UAndSW
	Rj2UvoUAFkeI45ZlJIxBrAZINZLlR5o55lQgoeW0duqNT7EgdVo8dDnY
X-Gm-Gg: AYBFou2Ul+uKNbJoORj/j3B7n63oWXahSnQMMTSGu5PsUIibhZ5tNlmIVuKXDjJ6Yj5
	uFSoe9iiZKCTJgghsr4b+WDyR3DV6Er8awbCVlsRcdaVbcBIAgQjVeJz9CcLeFA1o7+jNB3FefU
	KyhAouSKCQ53AI9kR5h8YBjTElbIeczvbrknxOG1/KWEXzfV8rqbsV85SQB9Lj3Z7FYUtmaPmhH
	CnDaeXfU+goopf2+TBzfijynHh+8CYRETaUOZH+ev7WH322hVVUIYe97ojCXDNvQik9cw9tL9iC
	SaSytfaCrlTfn9n7Cr0Ag2exMYF0Sk8SagWT8PO9ZyY7P7EvW5sCrDB/1+bWvS1vE5DyyVcpwLe
	PUU1ym7oq24iiR7FTwY9lijA3xvycZXaYZd1zw8Lhf/WvC8hex2/rxhTauK+aZrgwtvu2WRbvp7
	TX68GJ6zKtrbzm8WzPVsTT4/jI87kudSKIdczsnfLx5u1A7MFRu86cNk9dbLMR5UrCQ3EBfJRWI
	Ak8H/EbLLMVnA/5cVcWn8supPTvbQMeXS+7KS6mX3mcoTi06nq8bQl4Gn+i7RzZ5SP2lQXe4I5Q
	jaDNlsIerE8HBVrLYncMKWp+m0lcH8pAWWuWD4GdL6e1QEQD
X-Received: by 2002:a05:690e:4893:20b0:66e:5e37:2ff2 with SMTP id 956f58d0204a3-6790a0d5b89mr877402d50.4.1791384667246;
        Wed, 07 Oct 2026 07:51:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791afa71ddsm163923d50.4.2026.10.07.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:51:05 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:51:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.fde28dd15d34@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-2-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-2-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 2/9] net: skbuff: don't BUG() on bad arguments to
 pskb_expand_head()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> pskb_expand_head() BUG()s if it is handed a negative nhead or a shared
> skb.  Both are bugs in the caller, and both keep getting hit: commit
> 2cbb259ec4f8 ("bpf: Reject negative head_room in __bpf_skb_change_head")
> and commit 64e6a754d33d ("llc: do not use skb_get() before
> dev_queue_xmit()") each fixed a crash here that took down the whole box.
> 
> The function already returns an error that every caller has to handle,
> and at this point it hasn't touched the skb.  Warn once and return
> -EINVAL instead of crashing.  Anybody running with panic_on_warn, which
> includes syzbot, still stops right here.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 512ff9cfa269..5d856948cef9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2303,9 +2303,11 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  	u8 *data;
>  	int i;
>  
> -	BUG_ON(nhead < 0);
> +	if (WARN_ON_ONCE(nhead < 0))
> +		return -EINVAL;

Another option besides WARN_ON_ONCE or even DEBUG_NET_WARN_ON_ONCE
when returning an error is a net_warn_ratelimited for such cases.

>  
> -	BUG_ON(skb_shared(skb));
> +	if (WARN_ON_ONCE(skb_shared(skb)))
> +		return -EINVAL;
>  
>  	skb_zcopy_downgrade_managed(skb);
>  
> 
> -- 
> 2.55.0
> 


