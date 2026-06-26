Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B03C0606
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510193; cv=none; b=EN004+H/9yAcPkEpfNm73IpMfslXJ/xp+uyA/UhAVpf08gA3Kyzh85vcj4Gqb9Hiz7fVMV4F4OJkTf65P1HojABdWNgzUUBJbp9ecWhPjYa9tIuBsqVhVkkTUX/4sLx04JAmjzs5PMQUgsA7ReSht5JEGBCYD23sRfiAf6E80lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510193; c=relaxed/simple;
	bh=ojAE35OYkjQ5Ta8z6j4eofFJGg/eZvKv0lvdydmDurE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnc1a5Za396gK5wBXRkguLbvG9MtD6WdDvthOQeZDsP43hhLPYtxndVao5HjBH4zRlDOFdaD6KaJqaSNfcJkwABP0inGkujVf0FI7s8u8OWQU4rGmanHRxgY9O9mCx/xm4GUc+wsXq9aTyf4te3MHyVJw/XFXofD7QPS63y0Joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcneWN+f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcneWN+f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7f11646c3so10801195ad.3
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782510191; x=1783114991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87C0TqpdzgkT/i/TbUSL1BACHUANW3mTasT2WjTMKNM=;
        b=HcneWN+fJdEfejOPPPUTcHeKO/vUZ9Guakon5GWvyWePOGM5IErTddkOzEO74lcBHx
         NMpjuWUaCLc5RT9aSkJX7V47104iURHwxtkfu47J/FoLJjdBhh2VfbiK9HHTdGvMXL6J
         tyoNc9aoYgqTe7GZoGjUrQE/Jl0LSE1Nu9WNAtOUgfoYSr0wFyhR2PSMPDzAqPl5Yk8c
         Tlyw/yE+YRcISrKvpDeO7t13k1xHJm19emABGmf3WSY4M7Q6bS7Oiz8lUgvMA9nSeXBS
         B2DODMNF8JmPnEm6z38Eyu3B3/vXIJsLlsuR2dutgKqR2XmgNK5wrxWe3y5IDR5zf8P5
         Z9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510191; x=1783114991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87C0TqpdzgkT/i/TbUSL1BACHUANW3mTasT2WjTMKNM=;
        b=PlY/L0hcZRPKzrSG+X9dHxQ/GRWrgSMMwvf7Hrp8tguPIlpuJxT5dFSC3bhXHs40kc
         QOpTNwnoYuRK1CNyKg2KHiGLVSDQJSCyoQmvYNkvzRJ5caRvrtD0YUpW0hSawvSzYif3
         QhXhRQ8UVr3rV4+nS8TwrgURu6OHrLb0XABvv/rHP0vz073Soyu/tvlixYMesUPtHeEO
         hIC65F9VmpswowH6SvPjz4/ktP6rEJpaSmn5hyeQrW4N72yHHkugBwlSyGPpXmz6DpGJ
         QBH/amWC0Ki5d4WtUv0Vz8Bgy9GehkUhUgECfLLASlgmv+a3WFz1rLXCkWQRXBc2oG2c
         mH6g==
X-Forwarded-Encrypted: i=1; AHgh+RryDP8KngAk2RsA6CFASWMFTuuvVrrr6U/9HYpEiudItwxJbW6QPeKRfCCqOu4Pt+YOGew=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQB9nOguPBYSx68oSfbEhsZt5iIkyMadXPAWNGOEK3D9+TL61
	fkNfbtQyS2dLGVSa7drmF8uwB8fPcccBBNPXx6zSASrdNFMQiP7ltPY7
X-Gm-Gg: AfdE7cl1aFvwec/mk+mrjllb7RSZ/SZG/5xkCAlvkt38Ui5Ix0iwpSXMWHXDiIQMp7Q
	vp7aBUDJUNnF0naT/6fGjlgHFwMMNl++CZNpzRAkMm5gOYCVqYrggjmFLolQI+BgxpWvZbT70zn
	2SbAeVOoofciUK66cnlLdO8hXgDT2VqadWOXaa9VChESI4nyehb/RnYm5GDiLYBfVg6TyZrBzKb
	NkUIW3KyuSxme/gyg2a3EpWmbShJGTHP5Gqhb6Xb35ff3GGzE5MjaCWarxU3gQKaeyKtOI85ttx
	P8l+J84PWrJPoe+Q+UU+3TC0Qi/z0SRvrTUKCKpM6MQgOkKNtoSwwvipExFZdRN2FUJgQ0eqSd7
	3segCcm+rf2FopSdGwxvZV+baypC2dsx3n4IymUJyVCK200hU59rBAfE+jq6n9lWQytOjPiev66
	8bX8Qt2BLGhak=
X-Received: by 2002:a17:902:e78e:b0:2c4:608:167c with SMTP id d9443c01a7336-2c7fc663951mr79432975ad.6.1782510191468;
        Fri, 26 Jun 2026 14:43:11 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae2092sm46078615ad.20.2026.06.26.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:43:10 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:43:08 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
Message-ID: <aj7ySF4F-s4oLaoY@john-p8>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com>
 <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
 <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
 <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
 <87o6gyyjxk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6gyyjxk.fsf@cloudflare.com>

On Thu, Jun 25, 2026 at 12:48:55PM +0200, Jakub Sitnicki wrote:
>On Wed, Jun 24, 2026 at 02:39 PM -07, Kuniyuki Iwashima wrote:
>> On Wed, Jun 24, 2026 at 2:33 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>
>>> On Wed, Jun 24, 2026 at 2:26 PM Michal Luczaj <mhal@rbox.co> wrote:
>>> >
>>> > On 6/24/26 22:01, Willem de Bruijn wrote:
>>> > > Jakub Sitnicki wrote:
>>> > >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
>>> > >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>>> > >>> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>>> > >>>
>>> > >>> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
>>> > >>> socket's refcount via lookup. If the socket is subsequently bound, the
>>> > >>> transition from unbound to bound causes bpf_sk_release() to skip the
>>> > >>> decrement of the refcount, causing a memory leak.
>>> > >>>
>>> > >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>>> > >>>   comm "test_progs", pid 2451, jiffies 4295320596
>>> > >>>   hex dump (first 32 bytes):
>>> > >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>>> > >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>>> > >>>   backtrace (crc bdee079d):
>>> > >>>     kmem_cache_alloc_noprof+0x557/0x660
>>> > >>>     sk_prot_alloc+0x69/0x240
>>> > >>>     sk_alloc+0x30/0x460
>>> > >>>     inet_create+0x2ce/0xf80
>>> > >>>     __sock_create+0x25b/0x5c0
>>> > >>>     __sys_socket+0x119/0x1d0
>>> > >>>     __x64_sys_socket+0x72/0xd0
>>> > >>>     do_syscall_64+0xa1/0x5f0
>>> > >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> > >>>
>>> > >>> Maintain balanced refcounts across sk lookup/release: (re-)set
>>> > >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
>>> > >>> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>>> > >>>
>>> > >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>>> > >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>

[...]

>Rejecting unhashed UDP sockets on insert to sockmap SGTM.
>It is also in line with disable-problematic-cases strategy.

Agree ACK just disallow it.
