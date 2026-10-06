Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E43DDAFD
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329223; cv=pass; b=a5dvmwWAUeynsCleKT48NL38EDzpLNUGdSdpYwgfYrc5KVR6He8RQXewKZeqq05bMsJGaue3lqJy53jscsx8LRG2jGrhl8o6H6NVsfmAuHbINanLOHi3wxJSLlB/E6PDvwT2FRUZqqfU8znShZcb/xXv0MCHq7Cq1iWjOnScZGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329223; c=relaxed/simple;
	bh=WunslqB5YKhLVotec1PHOF5KiS7M7/wTxG6M6nwGcbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWPw/T1cb/VW2zo5/i9hUEyWkV09T9hZn+a2F5DezM5BLQN3q+e/lSl3n6loxZDRZrmDG4fYXTlj1Odg7eDw491V/Zc+pYaOzbvBTZgT9dR9ha67aTpy4bBwaUWeCo3UDppUl9n67obgw2Wzz0Nw+Kqn5eOJ+B91zqO/yyEtfmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxiZU+b9; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxiZU+b9"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4f55a53898cso587601b6e.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 16:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791329215; cv=none;
        d=google.com; s=arc-20260327;
        b=QeMy4XwpC1/69TbXZO47xOg60w8FpMNMdngIgq6TjlEtnu6bLoe66Tsro9fWqeuMDn
         VfFUMe5L3GrZBQE6LSiRlI3wO5ltA3WXIsGdBO3eFw0m7UjBp9CsYPHl3ypzA9ZiWEsw
         Jhq33ntJbvewxSllL183QytwY/YTQYYolPS8Jr/MQ4mn9AnmO3IxN79jGs6DSKUjwVgv
         6rWblMySqcwerKeKcMy/ZUt2ibelaiKsAUoVCjy6qQP0Y/cshVHcrX1+qRU4q6WDBijn
         Sbj9c2umShjc/inqdFc1pDjbw1ev8v0uUGX5+EB+dJdmby18fFZM4h0PLj7nWnk4rCKS
         X8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        fh=ce71Nt6WfHCtMa7BagISRmi1CnTp8UAZeYnMq11zTEE=;
        b=pjtAoE4X308imPLI1gfYNSAfH9UtTKeKyyip3R6s4zGnt7mUsN7u87CQ5DblXjQ6k7
         7klkhgCHzMfmPHvA7KlBggM2uzIajhqjUMdrEtqNtpbi/DmapFi4kcsk1TlHeviBrqUg
         GBU8lT77rOvXI5QxF7YIKR0CRHk27er4RduOVHT6j6WC3/ltKCFqU0o4HnlwLsKNqixS
         0yVe2/5rTeb5Qre4kWvLKTAHdclIxZDEBNXOVWavPm0gbv1/KU7NiyPLQe0tbyPIbe9B
         YPw/L/ZlHf+7N9h4XBUE2DvOoD7/vb0Ae4vWfOI70TtwOunCEBwHROVgEG7cDTfmFCw/
         hBQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791329215; x=1791934015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        b=cxiZU+b9XkIGt1ns2RoixoojLzs4BIVaJMFdBdjxDAVP18d+ouDvQCde9ALw9CRvvz
         ka/WwzjLP5sNRYv4aym/ifqnNHRm3qRLVOpq3is+hKvMywYzGPaRao/tmnNOw7x8wAR3
         9YuDXj8LJPge68rxI7brfRcpzyW7GM4MUN+F+99Y2ijjRyx/hP+cn/ZBEu5pT9hSz7mR
         AjAdfWq21gK8Vbj0d6fXZf0boJioQFd85Alsjv7K9VVzA5fmmBUtAFnM5/VKaeGny8jL
         JdCNH5KfglwSjVcGxuQ458HJ/+S+RVRiVLD5RZz4fEFRWKVqBqF7a0Kg14JJRDYeCf5X
         kDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329215; x=1791934015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        b=Q6KmJaOvzAfi+thXkXv6C6zbpgXc3IoGQygWLu8JDjQhAOmxYTeHcnOaMhi65x9wgf
         14DzAyzTDci1O2k/j7nE3io2kWbRWjYUbe0GbznPQc8wEXyFb1aHcfpPl6YnKy0Qf6AC
         UqJh5DfIUQ4YTbqosvumq4l7ARtcWVRd+Hweq/chqcHaRkpcGjO65Z0bMmpIm8Nv4+Ol
         TQ3VrhJBSWehmGg/UjXFbM6NJA7wPB4ANzhcSSqfs/DLiRPhpKeeGwC5dpgPtP8Z5YSJ
         rOmuOnXEUbChkB8KtWmfl2fTXAwH5qNeTZgPOyeEPDQN5PSGFPwaaHgu6usKr0ewpIzt
         C3WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkPYghJcKgjq3gxEhBI/NqpTinZYET1ZjsAxQGe1kkWkJbm6nQPygi6GDp6RABjysnnXM=@vger.kernel.org
X-Gm-Message-State: AFuF++myXVxAmlO1JLJajv2OdVSs3rROSwGz1v2TJJwkB/9uwFVj1G59
	XR8jGUBVScViS1OoE4y9fFr7MA78aa1otYrR+U+SM7UrcH3b9OFvMOsX4cNnf5wOG5ovik5Jfxw
	9n59tFcgTju12zTDigwgNJF7gglIeE2o=
X-Gm-Gg: AYBFou1QHJ36JPOV8jV0fdrbmGkb/a0UPaPDzLMrrWm2MdsnOYMrH30CV3sbUBqWwL3
	lzqUxS462urIbOaCv/FjimMrsPCsew9zTr4fsWWQdhE7W3iI8PtIFZOtx+AqPo+IvQDIeVRHuja
	qwmmquri0eZX13UZMJhf6xDQ9KRMNjTm3rEqywvtqBDA4bKNkZ/BKnkcdpI+0gWh6GA9sr2X2Rn
	dfozgsppJq5uVfQp/biHK9eyYop7fDosWBxZ+DbuPDLxigrI3SAru1oJY5QytvV7i2E8iVz/mEo
	InHZ/PWRJUEethnAmMf5qhY7RyIFH/DWmasLoqX3iCUD2xEVKBlEcJ8=
X-Received: by 2002:a05:6808:2387:b0:4e8:3e98:6f61 with SMTP id
 5614622812f47-4fc435f4952mr860001b6e.3.1791329215149; Tue, 06 Oct 2026
 16:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-7-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-7-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:26:43 -0700
X-Gm-Features: AclHuK88uPqLrKz3hOWsZn0eh4oxKR1nBrtIDVon_wLhkhepNPd35m3ItlLEBuM
Message-ID: <CAMB2axMTi71cr7_DR=E4Nqm+46-zADW-YJ346vrR0s-re1p3UQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/10] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
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

Reviewed-by: Amery Hung <ameryhung@gmail.com>
