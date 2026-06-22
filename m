Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24B3B813E
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144744; cv=none; b=hTvShZV3BUN06o3eXCld2StHKGN755VURAcfbH3Z4QvgKbCkJxHg1RLOlabSLvV12yMdOtT7zuqGgOakBXgkrS0JuIYgH6qj1HUPS5NjibU609qcPCvW0PMigc9qFERSMbK4upVhzQ35A1wUvL16Is0Vi0pEIbgPTKq87nqBE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144744; c=relaxed/simple;
	bh=rnpGHcRT/uDU1Bh3FfjKGETbbXNtClx+wKFf7+M0tc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCijOXOYYWwfmeKDag+nOJOM847Q0GagNNQaPBL9V3i07DCZ512FkwhryeX0ynq3QAUKiL8LWaaP/xA445GrpvuOpYU5xW0AdNeO9ZOgt2F9tYejeHY6CFxZtPgrTpvg2Ha+1p4bJRIPNJLwlclVwwqL98+3V6uW0cKwIcLqJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQz0b6Y4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQz0b6Y4"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bba9b849dso4312248a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782144742; x=1782749542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWly0L6srT0V376JtE+3+EfepszO+XEtHPredUzn5c=;
        b=LQz0b6Y4jauQRQHV+b0wdZiEX6TU/FSyjkpxr3Gu+Eag3iiv0S64dSxSYMNj8PIyw4
         u2pob4GuKCtZqEiYrqANvfOU/OPOsfyKWQSTJSMudcQAqOb4UQcd70C5Cth/mC+UZFtG
         Js5A+8dJj8j+WETfGI+ARNsAjBDKabsmB39F/8M5x0zCUwEgcb3rXorS9fUml7BanWmg
         E8dAODMBcr7rCEkBqv3MWrUOiAccsRrWizzQueTv+gV90Zsig7Bo1L/4CHDshDgLG+Qs
         NhnmuHoodvxZLATZyqLiBnf6dmjZcSKRtCcnAYy//M/rsyVMAoWtfalXzSggge7/PJ9d
         jyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144742; x=1782749542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWly0L6srT0V376JtE+3+EfepszO+XEtHPredUzn5c=;
        b=jMIKVIKSMJxKMufjhaS7ThEdxD6QFNsJrw9r0TMjCH/950BA3bqDqwPSvMOBDJDqo0
         4RkOlhp/+1/knapS4g5Nplv1IsOZgG0OrJFPQ8v8zwPY6jcyMnEv1QG/rDLFKq9jpeNT
         TnIIs0DRCYpoiXiNSMcqwmOagBIHzD3DWpI1vs/glPiSDbn+co6oUO1w6hIUgXw+8QUC
         Clsx0CHNH14HaQ/BFdsNNulGM4wBbwbCHroLrClbz9igvamo3DpXdXmukpn+dpzK8uHG
         YIJnpJ3I75K9dlXuJ7oTCRxnAZuZ+htuY5tLzVm/rYbstQ5MY/SIF+VSEupnS8KOTi4x
         js/g==
X-Forwarded-Encrypted: i=1; AHgh+RoBuyiBrR6WEpja+0I0UYRKLVjb/2MPkdOuHAiASu+LTFEe8pHBIVKU9hnXB5MI/KAgPew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0H+/4ufrVNJxWiryg5yHeaqTgpnwGJKav8/DPqLfz3ULIU4K8
	j6nuDg8K3IeMC/FKXtfyAuBHc3Byx4yGsyvQwNIbgjHkbaDXihLNqwjImGmLx/pRFDD9unyE42S
	9PYTtgQ==
X-Received: from pjbgb21.prod.google.com ([2002:a17:90b:615:b0:37d:833c:fe41])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3911:b0:37c:9bad:f6b7
 with SMTP id 98e67ed59e1d1-37d160728b7mr13874467a91.11.1782144741968; Mon, 22
 Jun 2026 09:12:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:11:40 +0000
In-Reply-To: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622161221.1742161-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jakub@cloudflare.com
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	jiayuan.chen@linux.dev, john.fastabend@gmail.com, kernel-team@cloudflare.com, 
	kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 22 Jun 2026 14:58:34 +0200
> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/unix/unix_bpf.c | 6 ++++++

AFAIU, everyhing in this file is for BPF_SYSCALL && NET_SOCK_MSG,
or am I missing something ?

I feel that it would be cleaner to add a new Kconfig that depends
on BPF_SYSCALL and NET_SOCK_MSG, change Makefile obj-$(CONFIG_XXX),
and guard .psock_update_sk_prot in af_unix.c


>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index f86ff19e9764..5289a04b4993 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -7,6 +7,7 @@
>  
>  #include "af_unix.h"
>  
> +#ifdef CONFIG_NET_SOCK_MSG
>  #define unix_sk_has_data(__sk, __psock)					\
>  		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
>  			!skb_queue_empty(&__psock->ingress_skb) ||	\
> @@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	sk_psock_put(sk, psock);
>  	return copied;
>  }
> +#endif /* CONFIG_NET_SOCK_MSG */
>  
>  static struct proto *unix_dgram_prot_saved __read_mostly;
>  static DEFINE_SPINLOCK(unix_dgram_prot_lock);
> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
>  {
>  	*prot        = *base;
>  	prot->close  = sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg = unix_bpf_recvmsg;
>  	prot->sock_is_readable = sk_msg_is_readable;
> +#endif
>  }
>  
>  static void unix_stream_bpf_rebuild_protos(struct proto *prot,
> @@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
>  {
>  	*prot        = *base;
>  	prot->close  = sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg = unix_bpf_recvmsg;
>  	prot->sock_is_readable = sk_msg_is_readable;
> +#endif
>  	prot->unhash  = sock_map_unhash;
>  }
>  
> 
