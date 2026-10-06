Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8093859D3
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324432; cv=none; b=LUvO0P+/xZCfdKkYmpGxgwSmDKJHXnG5qgz5JM7RPHZHE/1IWnVLk9CkB0XYX3BkiHP2CRnWK7maXfNrFUUfkw/WEryC99+h8osQSpVxgTpLyEA9hlCotVpqvxEEHd5ovfMQ25IJH41hkzKtI6ijnTDiXYTI7xFrvjqAulgdJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324432; c=relaxed/simple;
	bh=Xalx/8yasBLSFZTLlr4MRNIq2gaY3OFPvriDwacOKVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLPLR5+xvGRjZM8w44BgeMTgZqWNwuVpKZ4aCMEYW4kpZgYCC3KjDZAAy4jJUh11xMdJhENQH18bTMcXshCHupLGN9zePbz8lDTyjayeLf1mHDxijIBXSfmX6pKcfYzdElZSnkikpjSFC+iweqxsnOaxjU/XwMQfEC+OSjfSiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKJ+ZOYm; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKJ+ZOYm"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3a88d5731c1so93813a91.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324429; x=1791929229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAjJWLvhetGCvW2wBklrbMhe6NLPObaMFD4Yi+27WvY=;
        b=qKJ+ZOYmmRwk0/qwctwHKa17xLdo90Xx5uVXb5TVVPUyhmeYy84hFTGsGMLzfMq2b9
         aifVMu8xD8kJ0JwvcJV1wdtLUpGl5PjTKW25E2rCvW2vWhlbFhvcMFWKiPzASi6wKHAY
         MzT2+/mBNAjN6T0kNZiV2TEz4uJ0S8VYCYYna5g25OtH9IFB+U2FSCRqm3Yiow3zYUMe
         UAXGLb9neBKWd3lhBvWeX7kIq1i19HAKirWVzzB9RU3VErnq8GYoq1wMBaIg/ROkMo1e
         MRbwXTl0wpzx+4SzgWUBF963RBTa9vlUsG0WNeBX3A8bA16NjwTxNxsMiD2RJNvdCgnf
         BZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324429; x=1791929229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAjJWLvhetGCvW2wBklrbMhe6NLPObaMFD4Yi+27WvY=;
        b=DtEIaOmWUsNFv9NkHscKZPupJFS1EHS0ZlPGYRDqzYUWs/EV2qjJpw78RLksU1BZpo
         cKEEjkTs14f3iNGNU+/rFWRVpwsyH6j0vx5ee5wXuU5UpMCZSOIS40uLg11sBzLdohJq
         z0EHGPGTj0wsLDREFnjuT2TVAyq4R1FySjZck4YKLMKLUNdsQlTaHCgkPYDUyXr6v9hq
         2cr7B9tr+MO67rlIiBDDt0CFSaaE1l1YlA5dGqW5xeHVkBtJV394MU/vyJD62jBxWCd/
         sOHRihIuO8DqPWtHirMM3NOOmloujoMHs3/jrH7ie+9/4WJrJukyrhmbKRszKEgWfW3l
         Nizg==
X-Forwarded-Encrypted: i=1; AKwUvBxTOCf0UAyKmWon+3hBQT4VjBEVfaCwB3Tk3jHFH3sHe8/vy00wS7HEgzOe0USb0fMLYdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEvAT+5yLtPkTU5+iKVqspHxY9XiVXSKmO8StZbYKWJJ1QXsdS
	TuYGwgy8NSgVAjPQsVn969oS5dUNu4AvuYGNQ5JiO69P2lPP0N1JIZYl
X-Gm-Gg: AYBFou2KWYdM0MZ7yIsZVjZ/VFvd0AipIxncLyMd6XWQdL+w8C1aOlX5WJgawoh6ZIb
	dcZqDY3ZQ7+ze1u+DPsuwtLoa4UG+1/FTp7YVgqw9iosODn5iwr5l4Go4aKsBZkwhnsHYcJ9nu7
	CZ+VPCJVkA7QkgWFhuT5fIwPTZK9ZANOHulGhpNJG0u1hp8x4bt3VcaNL9rYdmIvWg+AglzSi1x
	P9e9tM7LfhBXAXVHrKMXWxZlIyxuJ0axsnDGt+4UWzwsmO+KuaPS0kTmQSG8LWpmmTVIQZi1wVs
	jG3VlbSalXz2zSIjyhRLDO+ysmFGLYoX3+dqKiKbcXGJh1LzvgKV3GM+D9b/Sg9x8w7TEgo5Bvp
	TMcjiRQQozW3mU/g/0NxBl21bJlqs+aFFgwLAjsjrRqzfvMAGdLcQmRqlXq11Lih2h2ySr5a6sH
	NMapT0W7taFUQxoHupZxbUmtiIS46u5AAS/954E0wZGTTMG2korGX5+d5wb41qLMY9
X-Received: by 2002:a17:90b:5786:b0:3a0:bf71:eccf with SMTP id 98e67ed59e1d1-3a8a0ba2447mr227420a91.14.1791324429433;
        Tue, 06 Oct 2026 15:07:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d5e19c1sm485547a91.0.2026.10.06.15.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:09 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:06:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 06/10] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Message-ID: <asVwyEeHdtEqH5Ya@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-7-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> Waking up a thread per packet is expensive when an application
> processes variable-length frames (e.g., RPC) that span multiple
> packets.
> 
> SO_RCVLOWAT can defer wakeups, but because the frame size is
> encoded in a fixed-size descriptor at the start of each frame,
> the application has to:
> 
>   1. wake up and recv() the descriptor,
>   2. raise SO_RCVLOWAT to the payload size via setsockopt(),
>   3. wake up and recv() the payload, and
>   4. reset SO_RCVLOWAT back to the descriptor size via
>      setsockopt() for the next frame.
> 
> This requires an extra wakeup and two setsockopt() syscalls
> for every single RPC frame.
> 
> With SOCKMAP, we can parse skb and suppress wakeups in kernel,
> but SOCKMAP adds overhead and also kills zerocopy.
> 
> Let's add lighter-weight opt-in callbacks to bpf_tcp_ops to
> replace that.
> 
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
> 
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
> 
> Those callbacks can be enabled on a per-socket basis by
> bpf_tcp_ops_set_flags():
> 
>   bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
>                         BPF_TCP_OPS_FLAG_RCVQ, 0);
> 
> Later, we will add a new kfunc to adjust sk->sk_rcvlowat from
> these callbacks.
> 
> This will allow the bpf_tcp_ops prog to parse each skb and
> dynamically adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN
> wakeups until sufficient data is available in the receive queue.
> 
> The placement of bpf_tcp_ops_call() in tcp_ofo_queue() and
> tcp_fastopen_add_skb() is chosen to provide the same snapshot
> as tcp_queue_rcv().
> 
> For example, if bpf_tcp_ops_call() were called before updating
> TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> need an extra branch for the unlikely TFO case to strip SYN.
> 
> In addition, the TCP stack can queue overlapping skbs into recvq.
> Once rcv_nxt is updated with a new skb, BPF prog can no longer
> infer the previous rcv_nxt from skb->len.
> 
> Lastly, dequeue_rcvq() is placed in tcp_cleanup_rbuf() rather
> than __tcp_cleanup_rbuf() so that it is not called for sockets
> in SOCKMAP, where calling sk->sk_data_ready() from the new
> kfunc would otherwise trigger infinite recursion.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
