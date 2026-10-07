Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6F4756BA
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378698; cv=none; b=d8cxISUHk33dIqa1tntdg/38POcVpzSmbdgRN83k9uRyFQb+8cun+/HSJBAipkZQ0+E21o2YJ4B5CZXyG7/J0E+a1BTwHw9yoz4uK5qYVcmMfdnyl5dOFlvr4GMDORaz8x2la4LZq8aQd4Uv0Af+AlfVawJ0JKzzNpLaZbCpYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378698; c=relaxed/simple;
	bh=Xxs0uB5If2Ut9262mUBW3bNyhQPBrDPWuruAgxJj4Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkpBZS7AEmFEd87MYaAwPAqrU2AdLRqFtkpuePfZ00ufrnFh6sqSd24aLkB21kIkv0pPq23pcBiN6NRyhcOWmlwvc/O6xZw+tDCyjESuaz3hop+9246CKhIXxU6oWFFlHl3488iTozGeE/EcboOmxQBuoN6oqSLdSppiQszM0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CtnP0ibk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CtnP0ibk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so821835a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791378690; x=1791983490; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YUz7LBXRnF42JnciC/ACJGoLpBiYqavZK7urtzI1OeY=;
        b=CtnP0ibk0zNcB4Q1qu1YOjeAUsmRCtRBkfKdAYRplqcps/Ir6f/FnUUPUrd5E15CCO
         RBdj6HZL6zqTizWd4Ll4jqN9vOBaW34lPjJP7nSLjclPtHXGqcLcD04DWioVvhvQW7LM
         soD+j+5LnWMlR4DDv3gqKYE1bJFIbCd88NBFot4bWD9ldoc6CdjDhw5xv64NIk2ayD8h
         V7MPFLKTjiafQLCoVNoMr9/4irGGGMaS8WNJR99cc6qAlFOCEhv07BrlS9M8GAhJYtKr
         japnKhwS8jeAZm0owbghiPSYnezyDv4z9j6VGNsWyLr22TSFwJTkab7UdFWN6OkSrJVI
         94tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378690; x=1791983490;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YUz7LBXRnF42JnciC/ACJGoLpBiYqavZK7urtzI1OeY=;
        b=Pw8GRP0Yxkp2WoMxvXNmtaBhTMLPOD99EgFQRPohy/xDQlsSwY1HOQHODuMFwdiS6P
         LgC53bUz02KgougoTsj3dFuY4fNXTvZ8kpXANX9hGURZC7e30Yik7ygNubswse6pXYK8
         r/mf2Db46I0teuaOZqAfIeuMtO0/Y1wAjlQLs0WC8fQ/e8tlsP0ZfhL1f0Ck+Ipm+X/S
         RVOQCwpZ6H89rT51ryYcgXLdSiFcrfSCC7+//yADXVyDV89o50d0WQA8j5uGHOpMY8ac
         iGh75qJdBqI3AxBOJtDcmzsjFxdAJI/TDXVcg96o5e4YDhqvwefUQJbiBXeoUbtWnr8k
         FwpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxf8m5/FWsw0ivIpYAjxfIgLF/IWnKBDJzaWO4VRy+KAp5fAwrNqLWIcrHDErUPyRjlOGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfOhuicqZZz+7U/NmkGmiUY+tU1hwubmcaKG94VwdMtz0l0JGf
	2vaqGPbdiO2s92c+IHD6IfS7pgBP9ixwKiwNwBlh+XZDNv/eB4N5rA/L+k+acRGiehc=
X-Gm-Gg: AYBFou3txIBiWJH5Br2UNrs5SIoTPjOHuU+OImSK8PzXQO38mBTf4wHAC9Ls8PNd2eB
	ZpnG2xdB2+kSh03gyaGT/R+clZVkIgAtTwIRDMPiDGhw3Pfz3KK66cp3kksCD+3n5LGnTjoqHI9
	kMd9fiL76kqHFONH2lqGPLw1iCBtvhtvGZvpZYpVnzmUmBlRR+mxQztwzl8GmoPwlRpOUY/LzHS
	T00ViAfedT2yQT3BCGkIM2mXZmOdFp8iMqPmxDzpB3keG0r40VRwEysRtXDPUzivBw1f/MFjp3P
	aeZ3YfrCehZ+w9b3YzlMK6l0MYIPtBuSPBLj4y+uP4akPMbvWohcnZ7QWEWWyuEUzlHmDoTfEdS
	E9sWntP5eKYMcNizaKUbSXtTkX9/y567usF976Mjtps4Mk2K5pFmOxcbwVTouwHehQVgPl41O2Z
	/PM0CxTK6T6MtKDZ0GUQfcmKI8uiLv7MLZpXx2cQb5McJ02mUxjPfHxBQrlXy2S9Sl3BeQiaDE1
	w==
X-Received: by 2002:a17:90b:3908:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3a8a0b8b75dmr1575608a91.18.1791378690497;
        Wed, 07 Oct 2026 06:11:30 -0700 (PDT)
Received: from cloudflare.com ([104.28.174.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a4b1abbfsm1502137a91.4.2026.10.07.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:11:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Amery Hung
 <ameryhung@gmail.com>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Eric Dumazet <edumazet@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Willem de Bruijn <willemb@google.com>,  Tenzin
 Ukyab <ukyab@berkeley.edu>,  =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  bpf@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 00/10] bpf: Add bpf_tcp_ops hooks for TCP
 AutoLOWAT.
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 6 Oct 2026 19:24:26 +0000")
References: <20261006192601.1875100-1-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 07 Oct 2026 15:11:23 +0200
Message-ID: <871pa1lkp0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 06, 2026 at 07:24 PM GMT, Kuniyuki Iwashima wrote:
> This series introduces two callbacks for bpf_tcp_ops:
>
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
>
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
>
> Those callbacks can be enabled on a per-socket basis by
> a new kfunc bpf_tcp_ops_set_flags():
>
>   bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
>                         BPF_TCP_OPS_FLAG_RCVQ, 0);
>
> This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
> suppressing unnecessary EPOLLIN wakeups until sufficient data
> is available in the receive queue.
>
> This functionality, which we call "TCP AutoLOWAT", was originally
> developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
> Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
> workloads for more than 5 years.
>
> Combined with TCP RX zerocopy, this typically allows us to read an
> entire RPC frame with just a single wakeup and a single system call.

Nice! Just yesterday we saw at LPC that even with SK_SKB/SOCKMAP
overhead, you can observe an RPS gain from waking up once there is a
full L7 request to read out [1].

[1] slide 72, https://lpc.events/event/20/contributions/2428/attachments/2064/4781/Beeper.pdf

[...]
