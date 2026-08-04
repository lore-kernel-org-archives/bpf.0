Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE894418A55
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812555; cv=none; b=c4CarFmlcWrGvxziRYVPWWuBq0NdGHXjEwxDdoQv2E1hSszwYMZQH+o9A4HTwm9xdwGEEpCSsv+aBsxIGXB6tf/+EZKa2CAaVy1aqWXZ7fi/slWeh7xO3b5T+/nID5zciUYjxP3O0oBm24bjnmiqTNFMFkmeqwUyHsfHT7O0lk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812555; c=relaxed/simple;
	bh=eaoJ1IskrnVOGhuAIWVS+HVh0D4Ynb6oZ8yTdWa7+z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UgIBHWtFb/U0HQ8uzsmqWHi2gtMZyk+DLKu3vOrz30HR6uQbhE99Bosswy5ttfnX5X989zAOzF9LgHg1xbsBbaFU2+tJoq8ijCnYO1sbnvIdqvw3zWfpnbsraBnjGYgjngR3OejuPqXcdQEB2jJof3Jt+JI6a4AH0aCgwyhFidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPXQgwOH; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPXQgwOH"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d04908139bso66716355ad.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785812553; x=1786417353; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LY2ip7132St3jJZsR4G7SPhj6q5d2AehkyJW/gkz2yM=;
        b=UPXQgwOHk682AP91VLoVl+3FM+SfWj1eFgt0/JFQAmaMrsMZOAMcfIJOiMyg6uMVX1
         WkP+RUMZRFX6Kgm7ek5gq1fNvLhIH+8mdx6VZsJ/c6CxOYcTDe4ZsVRkIk+MJAnwMLt2
         UP/9ReykPVyNEqPcjkj/38B1Vu8OpHhYbAcwxYgVxtQjoV5pIy+RM7in9/G8dfIjP1VW
         v355Sxxar0PDzWB/9XVnFzBXpePJHAXvt4xiefJAfcEdkbo06izEdcAr9p2HpTPyRQDx
         tAcjCYpwtbgQUOSmq5Wh2WycBdNcmJEFsd17tJb3Cno58V296Z9DPEvOdHh/RjM0U/qp
         DesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812553; x=1786417353;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LY2ip7132St3jJZsR4G7SPhj6q5d2AehkyJW/gkz2yM=;
        b=ocEWVm8b7+eUwpGF6hlNEKXUF6p2zZMTPPCDa3l6eCzBbspaiqxJoXJyb83KsbMBi2
         saDs/YJ1AHkaNeSfzdHjCGiFD4WX0mHZjHanNwdc1RB1megOSJ+nbpPy1uLMXK7QL9e+
         RIoo+mwPOogAPZ5yD8rElhZlc/F28pfSKuNZQwNL9W8AH23wqY5pYCSTGXvNoK5Z0JxG
         CE/KWsQX9JK7rmu7rpSggPQOWazFS/0fguMlOWRRM7yX6kEl39OdOVPqWJ0ktfefc/O2
         KEugYsePgLRav23WFwkkzvJfIB0lmj20wIsF/u1TAt8YhnTz7jjrdd2q4mvOvECXCfpn
         C9cg==
X-Forwarded-Encrypted: i=1; AHgh+RqpSWGaSdhornJlpmJ48WE/4Gzw/xJlLicoHv0owhdlJNqUQ1cFO43ZdCId3fuyduyD36E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDy3NcG4WSncmehEzqNqrt7wiZ7j+wFdHNv23noIhML6H2vyiX
	ucN/5UYtp/2grTE7RiiTp7NQ1v357NGl92QJsgBbX8EaSDrEUsOEPiMsusDG46iNt+VuqbxDqMR
	mWtbETg==
X-Received: from pjbms3.prod.google.com ([2002:a17:90b:2343:b0:380:66e1:bdd5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39c5:b0:37f:e326:6557
 with SMTP id 98e67ed59e1d1-38fbc408b1cmr13754374a91.4.1785812552636; Mon, 03
 Aug 2026 20:02:32 -0700 (PDT)
Date: Tue,  4 Aug 2026 03:00:49 +0000
In-Reply-To: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804030232.2430103-1-kuniyu@google.com>
Subject: Re: [PATCH 1/1] bpf: Check sk_fullsock() in bpf_tcp_*_syncookie
From: Kuniyuki Iwashima <kuniyu@google.com>
To: enjou1224z@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, emil@etsalapatis.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org, 
	lmb@cloudflare.com, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rakukuip@gmail.com, 
	sdf@fomichev.me, song@kernel.org, vega@nebusec.ai, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ren Wei <enjou1224z@gmail.com>
Date: Sat,  1 Aug 2026 21:59:39 +0800
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
> 'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they access
> sk->sk_protocol without validating whether 'sk' represents a full socket.
> 
> When a BPF program passes a mini-socket (such as struct request_sock or
> struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
> is located beyond the memory boundary allocated for mini-sockets.
> Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
> kernel read.
> 
> Fix this issue by adding a sk_fullsock(sk) check at the start of both
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie before inspecting
> fullsock-specific fields.
> 
> Fixes: c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/core/filter.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b446aa8be5c3..afdcfdf41489 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7678,6 +7678,9 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
>  	if (unlikely(!sk || th_len < sizeof(*th)))
>  		return -EINVAL;
>  
> +	if (!sk_fullsock(sk))
> +		return -EINVAL;
> +
>  	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
>  	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)

Simply swap the order of these, TCP_LISTEN implies full sock.


>  		return -EINVAL;
> @@ -7752,6 +7755,9 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
>  	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
>  		return -EINVAL;
>  
> +	if (!sk_fullsock(sk))
> +		return -EINVAL;
> +
>  	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
>  		return -EINVAL;
>  
> -- 
> 2.43.0
