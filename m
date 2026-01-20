Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA644A700
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921289; cv=none; b=cIQ226PJw+tt6j2wwJDsrKthZ8Tu3e7f8PrFVpQ1LY8rIzCCB2oPGgXQfGCdYcC2h6dsG++n7oi8anCdk3alAKz9jP1f3rR8nGl2jgi17g7gmZRLRVinbz2Af2SB5TDXOBNtThcuMsQp2FHsMC1ERbPjhm+XmruRGLZ4foGtw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921289; c=relaxed/simple;
	bh=e3KIXA5K1BSTDXaN5S3F7j8PM7hZNZ2/owWnE24bZ/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYphNa/unEwQBhU4jZhUDgV1HFr6H1U9hsZbNpsfH55KZUzHDHGxY7PtxeA7ljxsQZwrnehTsfGrTn4leoqHK0WZH/Dh9qosrV9GDz0Ws25876tUTpnhfox2zhbRezBfwwJPHuS7RweckbdRlfLkJrhIsH5OKqToG7Dqe8wWW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fC5ypsaZ; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fC5ypsaZ"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so8260523a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768921285; x=1769526085; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYI0gLBKIqxhNhOB7IM8ExaSr/699rjlW1w6qxp7P1A=;
        b=fC5ypsaZsDFQsZ88mcEV6PqE0f66AfimA3K/Yo7OMqf4+47DIxBicb7hiZcm7dKhu1
         u0cp2SevSHnrlBejhvTBWWsaQexcocCQuO/DIpJR5JTHolXIH1V7xnl3if2zrMmqLVKn
         cfQRPEwdnH55vhoJuoRSdHgG2xxCuWLEQ9uSS+p64ICoPX/lrMRVSqShg5pcYQLSmg1p
         B+wcH47AXHTRrD7EI79vjwnK8jc+dx33QmA01cOu3Tn/uveJoCq7oLWCxamXlti/E0u2
         TMj/Hb6si8v9TAVVSfijHmZC2AMOHH6rnKa4lmKPaAMRRx+PRxfZ6nyD1dvPYT1SPFbJ
         5fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921285; x=1769526085;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYI0gLBKIqxhNhOB7IM8ExaSr/699rjlW1w6qxp7P1A=;
        b=MiLMBXWgcMXUWDRnS0UVkrgouwPeNDYVQoNn5qSE1sd42qKrc9+yU9xD69FxpcrT9v
         G4VCAbzdIDK+fhH8IPQnjpHhONc75qXyRPa7yoc+JoXoASP3xOwZE9XJDxj3blHZqJXX
         8oGgIXpXMfXroW4K87wg2chwMQWnKX4y+VCXYzb4isTQ3I0jBh3MJbKgXH2PdSbSgS3a
         sC+o8fahEYupLKGMvRYCKyeG0z1/5SCXzI8XvjEgnN/I1f4f0gYh2E5GajNBz24t1QWL
         b5mD7rqtwgqr2KbDIgKH6UVvBG8kssUmNdxrEdoE2yiS1AOZxQ79bDjBOSDW8w9VYzKZ
         43gg==
X-Gm-Message-State: AOJu0Yxn1m+u6PkhRKvGeucSQOx7YwfJliz2oS1S9HoS2LUD0W/bXqXP
	ILilA+OImX5eDniRgdNcV+0ROuRu5/ZbHEJLWMGlakwof2Pbe/aIt/Obs7Zt9fdNpyY=
X-Gm-Gg: AZuq6aI+WT5+rZne/4UI9SoTeaAovL/ga3Weng1NLcloBsDsRva+8ROaglmWsdqOCcy
	u1VS7NlKSbCEGXYXYD7ZYmwkPrlK8mANCstcxu6sF34WotiQv8ziHRh7l52sGfK0DIPnmMn6MIo
	9JLjMIig/PiGrLZshJSl0VBoRrFftpzuflcm+kzc7BCrc2WzQnoO8lMusKLY8upKrtXEZqGez4j
	4kiDkANdqYATclMTP0lEbsNzNJyIXgIellwNUoJXhlDALc1oRFCZXRWZ/kiwW4kcg4rvfFZV0dz
	VvLzN+pK1GOuE/Xw5++bE+R6hm0XB6oxPmxuW0wRfzKTzKbKT1jO53W6izYZJ/CRxz8hjIyClON
	ZjjyjW3pFZxIkWFtZH6yudhY3XSIFtUp6bp+5LxDzJFzbFRoR2iVOA46rhugznqBZi6J5DrV1iE
	LFP3Y=
X-Received: by 2002:a17:907:e106:b0:b87:f6fc:aea9 with SMTP id a640c23a62f3a-b87f6fcaf6amr234043466b.9.1768921283931;
        Tue, 20 Jan 2026 07:01:23 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c96f4sm1419134966b.40.2026.01.20.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:01:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260113025121.197535-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 13 Jan 2026 10:50:49 +0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-2-jiayuan.chen@linux.dev>
Date: Tue, 20 Jan 2026 16:01:21 +0100
Message-ID: <875x8wuy4e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> The issue is that when reading from ingress_msg, we update tp->copied_seq
> by default. However, if the data is not from its own protocol stack,
> tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> native socket, reading from this socket may fail because copied_seq might
> be significantly larger than rcv_nxt.
>
> This fix also addresses the syzkaller-reported bug referenced in the
> Closes tag.
>
> This patch marks the skmsg objects in ingress_msg. When reading, we update
> copied_seq only if the data is from its own protocol stack.
>
>                                                      FD1:read()
>                                                      --  FD1->copied_seq++
>                                                          |  [read data]
>                                                          |
>                                 [enqueue data]           v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h |  2 ++
>  net/core/skmsg.c      | 28 +++++++++++++++++++++++++---
>  net/ipv4/tcp_bpf.c    |  5 +++--
>  3 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c287..dfdc158ab88c 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			     struct sk_msg *msg, u32 bytes);
>  int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *copied_from_self);
>  bool sk_msg_is_readable(struct sock *sk);
>  
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2ac7731e1e0a..ca22ecdbf192 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -409,22 +409,26 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
>  
> -/* Receive sk_msg from psock->ingress_msg to @msg. */
> -int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> -		   int len, int flags)
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *copied_from_self)
>  {
>  	struct iov_iter *iter = &msg->msg_iter;
>  	int peek = flags & MSG_PEEK;
>  	struct sk_msg *msg_rx;
>  	int i, copied = 0;
> +	bool from_self;
>  
>  	msg_rx = sk_psock_peek_msg(psock);
> +	if (copied_from_self)
> +		*copied_from_self = 0;
> +
>  	while (copied != len) {
>  		struct scatterlist *sge;
>  
>  		if (unlikely(!msg_rx))
>  			break;
>  
> +		from_self = msg_rx->sk == sk;
>  		i = msg_rx->sg.start;
>  		do {
>  			struct page *page;
> @@ -443,6 +447,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			}
>  
>  			copied += copy;
> +			if (from_self && copied_from_self)
> +				*copied_from_self += copy;
> +
>  			if (likely(!peek)) {
>  				sge->offset += copy;
>  				sge->length -= copy;
> @@ -487,6 +494,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  out:
>  	return copied;
>  }
> +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);

Nit: Sorry, I haven't caught that before. tcp_bpf is a built-in. We
don't need to export this internal helper to modules.

> +
> +/* Receive sk_msg from psock->ingress_msg to @msg. */
> +int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		   int len, int flags)
> +{
> +	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
> +}
>  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
>  
>  bool sk_msg_is_readable(struct sock *sk)
> @@ -616,6 +631,12 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  	if (unlikely(!msg))
>  		return -EAGAIN;
>  	skb_set_owner_r(skb, sk);
> +
> +	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> +	 * data originates from the socket's own protocol stack. No need to
> +	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
> +	 */
> +	msg->sk = sk;
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>  	if (err < 0)
>  		kfree(msg);
> @@ -909,6 +930,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>  	sk_msg_compute_data_pointers(msg);
>  	msg->sk = sk;
>  	ret = bpf_prog_run_pin_on_cpu(prog, msg);
> +	msg->sk = NULL;
>  	ret = sk_psock_map_verd(ret, msg->sk_redir);
>  	psock->apply_bytes = msg->apply_bytes;
>  	if (ret == __SK_REDIRECT) {
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index a268e1595b22..5c698fd7fbf8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	int peek = flags & MSG_PEEK;
>  	struct sk_psock *psock;
>  	struct tcp_sock *tcp;
> +	int copied_from_self = 0;
>  	int copied = 0;
>  	u32 seq;
>  
> @@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  
>  msg_bytes_ready:
> -	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
>  	/* The typical case for EFAULT is the socket was gracefully
>  	 * shutdown with a FIN pkt. So check here the other case is
>  	 * some error on copy_page_to_iter which would be unexpected.
> @@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
>  	}
> -	seq += copied;
> +	seq += copied_from_self;
>  	if (!copied) {
>  		long timeo;
>  		int data;
