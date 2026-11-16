Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794862930;
	b=vltzE9KA+Y3LrmBEc8Yu1TjrIgIR1AoKxMSqoQc72WOltoscFSU0I5AjVt+B7+hiUzbe
	 nKaJu6mnOkk5YEt3svXg8N1oL8ZhYoIzD/6GDauCXQhblITRpNihcgpFimFtBKQIAAlBO
	 F/Fd16dAyyqSwo3RF+Mn6625j6Bb6aDH1FXlzsyMF13wgP6wt0RruoKWOp9RrMzw/4Wcm
	 CA5L/bS/YywmFwc1n0QzY8em1WJh06xnTWJG9Dg39PSfO9GQ1uTjAyv5rUSM897HZKbCt
	 ga/vgtLAWxpk+8GB4NppSkJc3HANulcbLIZPb7YHuql3Op3X4S1X+N7OdYSsIrvGO7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sCS5KZMGBLoezFGXiUNPAPDsKb/lPpeScZna/DR+4wA=;
	b=h0xxGCUiW1L5tSYIZqYe2JoKU+rO+6ohemNHvA0RbcKQT7mlxLYZTSINHJDXOf9ayAel
	 TnVJ2CM5FDybox1NK/c2sgrfCRFL7fQ+ObgpB+VTW4K3kYhpgSJN4GwgpRujlBohp0ZSI
	 0+dXAOiL5J0ap+uoobPQSiuRFtEpZ13sUBClrGYW2Qf4aKfqqgllLOr0TQrAHJYdQl0Rl
	 4UrKb3wvydB27O2SxTErd0CkjzX4j4vRZLgpNYn+JTa700+Joz/TMTDKjxGqPqhU924K1
	 VqDpAqu8LZuLbRXgibfyceJ5qXvFk9kvTJHfeQychEQ8QKcQsAPzJYdOrKHoU/QxgZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldsOndDa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C694606A32F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C694606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldsOndDa
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b0739d31b9so1413c88.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794862929; cv=none;
        d=google.com; s=arc-20260327;
        b=pgEEYKJ6XA0qOHR09BZFdJtnOOuFtZ+sEQUnaoC7is1tOAEul8SxmPPrvQQYIQtBIX
         rhc5a7PIwk8joky9RiRwyH/V0NuI4fub7Fdb86QV+X7DhzxWbXvd/yffcog1fzORCbWt
         X+mI1+wbpYjfh1mmyECuGrYIpZ7rTkC9uo6UE+JAs+H2d3GwzGCqij08mahT08q5PFuW
         OgLbWjNDQi/mRXirp0GtHo76XbawvthAFYAiBYmas1+kr9FUEkoDNVuq/VbG0kd8AtZs
         rLYWSIpphnb9d0meyEFFasAiVrnil9ssuVL4ATMFtV3oAjiwsP07ddcII05bhM9smqXc
         O8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sCS5KZMGBLoezFGXiUNPAPDsKb/lPpeScZna/DR+4wA=;
        fh=+aj8PKDtYKzvQzmFRhNCnRKz4JioF0HOfYvWQDEFBYs=;
        b=dqVGw/SRbQbAn9YinVMQ9k+iT0SL4JPIN2I4bi2+f8LylMxt8ZREKv+infOtZS7SOs
         9CIJaAgWnkGESXchl5l9nx1bpSHn9X6o4fWFT4Ou3aUFtApm81NxP8Lps22KuuBKjyRm
         HXLgePrLze9hLVgfY8M1oWg0SXorzD0LB+XqqJZZsVpgEqRkMUCfjSR5zh+p+SRpf8RK
         ByIEjHCBAbgLdX+jSM8y9FYWesQNOdZe9AIhRFCAKQvhNmwZWYTKkSaj61RAnaUsTRKL
         3MtDD9USMUw5cb8GfCDljVuVHG+TP/lNAfacDWmPvA2svAFBt74/MDx/lJQo+TQ146oQ
         AhOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794862929; x=1795467729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sCS5KZMGBLoezFGXiUNPAPDsKb/lPpeScZna/DR+4wA=;
        b=ldsOndDaaU5QY18GvnbJlfwT4saZBZ91nYsgEyjkOy5ZQUNPdp8nSaBoc7WnYkfz8w
         c0anTf42usoZwliGeBFJ3aAcTr9+ZrYsrETL3LqkISh8XB298exW3fulIW0dLm3B5cnC
         u6hiyhdL/SPsxdcV9G6AY+qn0bMe77/OZWqByN7f5HxrNpc6WMa9ljAzUaNoXCN2/Nch
         1RtGcfacXw4e17gjgorciEs4jul2Z8xPgeTJtf44IxPRrf/mHzTlC0mpqjwQxQbh1p+f
         KVx4CKjjRML0wLR1dCfPJn6wa1Fb4a2X5QXpA+2Ct9UCTDi9yqsn+74PSMTr5HOT7+Mc
         37BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862929; x=1795467729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCS5KZMGBLoezFGXiUNPAPDsKb/lPpeScZna/DR+4wA=;
        b=V9XqEpDd98DY2rqBmyDz+uF9A0Gpp1tuTEqVfk8HfZoPoNV2RFILHRTicv5BvoI7VT
         SdLENn08mDaS37oyZ1b2DfkcEw/FKYks0ZPUnMAT5j0XEUSrMOxRTvLtZDqwbW2AHbsG
         m6GBGW3t4Z6l3Z4M4Ngn4ggpNy9DS3yVQTzI8Ci6zCKo53zeJCilOCAVaC1fDywaoZXO
         eN8AMIMDk0ew349sCLHuwcj6ysO9yZjiWi0EFonxmAyaWSAn39Z/KQSAn/tzsY3cWVd+
         SQAEaDc6qUlkPTGJeEs27J9LX6RDhZQFS/asvzlnjrklusCt7vXLF/EngjmplSfQpjBd
         FQ3Q==
X-Forwarded-Encrypted: i=1; AL+hErEW9MP3Le1f3JunoKkVWK5aJqbR56IKuxeI8UpQToNtffBEWz4xKOjrzLdRalEZHOCl7ZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RDrlBIKV9fQJmqfpA4GmZBZ0Uj3HdDzG7+p0v76jDXN8KvKJ9
	mRXDBzaZ7EXsQhz+TelvVgffyyPQw/wBd81kAs7mFimucjph8CWRlU6VJMOZ6Rm8DgkH/oXKio+
	eQQCLVvWkef/1bbHy1491xxURgDRRDjZ/A9NDP8Ec
X-Gm-Gg: AYBFou0IOUTdrfkN+SdZMwk4UNJmG7HqvEQUJNXJqGI7bs/VZMHeKxuGDltY0ZGusXz
	V2v2x+HpsWU9aH5YtAv1kLDokeM1+vTZnPofhtsnHVr+Ko349XVl1f0FixZ23zuzqGGKD00ZxNb
	Om+aW3TgzrGVGeQO3dBdwfFPPAmKQ85B+42xgocssIldrWGNdxG6tU7+DgOX1iA8OjZI/sPYEzD
	PPX9UcJHfpTiHlTMeh7EtKXZf2OSy/P4uCVHettFKwowN0mQZmzUqR89sNEA2r44g/pZjauUvu/
	983Qtpmb8di03a7J9kZBoGi10V2vSQ43h2zk6dESnOyWncMW7rPc0MobrhPviINkhyLTtFp99jC
	TWsI29I3Rx6aqU72KYwF4M1DWSOV+9BFigiI=
X-Received: by 2002:a05:701b:290a:b0:1b1:d8c:1ed9 with SMTP id
 a92af1059eb24-1b53b1c51a2mr13906c88.18.1794862926873; Mon, 16 Nov 2026
 13:02:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-3-bjorn@kernel.org>
 <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com> <87fqx2j5jx.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87fqx2j5jx.fsf@all.your.base.are.belong.to.us>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Nov 2026 13:01:46 -0800
X-Gm-Features: AclHuK8rxGqdW2QY8q6YZLLoufNsDrdyzNs-Y5WE5rB9qXBUxJnfIT9hDTQTu7k
Message-ID: <CAHS8izNVDU8+JzeuwDBmF24C-XqkO+ox01qnTvK665Y8pyWNLA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:47=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> The core treats every memory provider as unreadable: installing one
> >> needs header split and no XDP program, and any page pool that allows
> >> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
> >> XDP, and hands out whole buffers.
> >>
> >> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
> >> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
> >> readable provider only with the new PP_FLAG_MEM_PROVIDER:
> >
> > Why do we need this? I thought whatever creates the pool actually
> > shouldn't get to pick whether the pool picks up the memory provider. I
> > thought if core has configured the rxq for a memory provider then the
> > pool is forced to take it.
>
> Thanks for looking at series, Mina. ...this needed some thinking.
>
> It isn't forced today either: only pools with
> PP_FLAG_ALLOW_UNREADABLE_NETMEM take the queue's provider. Drivers set
> it on the pool that holds payloads, and keep headers in host memory: in
> a separate pool (fbnic, bnxt), or outside the page pool (gve, mlx5).
> That works because every provider so far backs payloads only.
>
> UMEM doesn't. The socket gets whole packets, so UMEM has to back the
> header buffers, and with multi-buffer the payloads too. The flag was my
> way to get it there, but you're right that it's the wrong knob: it lets
> the driver opt in, where it should only say what each pool holds.
>
> How about this instead. Both sides use the rx_roles bits from patch 5,
> HEAD and PAYLOAD:
>
>  - The provider says which buffers it backs, next to rx_page_size in
>    pp_memory_provider_params: devmem and io_uring zcrx PAYLOAD, AF_XDP
>    HEAD, or HEAD|PAYLOAD with multi-buffer.
>  - The driver says what each pool holds, in rx_roles. A pool without
>    roles but with PP_FLAG_ALLOW_UNREADABLE_NETMEM holds PAYLOAD, so
>    existing drivers don't change.
>  - page_pool_create() gives the provider to a pool whose roles are all
>    backed; the others get host pages. No opt-in.
>  - After ndo_queue_mem_alloc(), the core checks that the new pools that
>    took the provider cover everything it backs, or fails the restart.
>
> With fbnic's header and payload pools:
>
>   devmem:                header pool host, payload pool devmem
>   AF_XDP single-buffer:  header pool UMEM, payload pool host
>   AF_XDP multi-buffer:   one shared pool, UMEM
>
> A shared pool on a devmem queue doesn't take devmem, since devmem
> doesn't back HEAD, so the check fails and the driver has to split.
> That's the "headers in host memory" rule, without the driver asking
> which provider it is.
>
> Wdyt?
>

Hmm, I think maybe the exsiting knobs PP_FLAG_ALLOW_UNREADABLE +
CAP_READABLE covers your needs.

The pp says whether the memory it provides is readable or not via
CAP_READABLE (or !CAP_UNREADABLE).

The driver says whether it will allow unreadable memory for this pool.
For header pools, it doesn't specfiy PP_FLAG_ALLOW_UNREADABLE and for
paylaod pools it specifies ALLOW_UNREADABLE.

The change I think you need to make is: today we disallow any
providers if the caller did not specify ALLOW_UNREADABLE (because we
assume mp's are unreadable). After your series we only need to
disallow memory providers if the mp is unreadable and the caller said
it's not fine with unreadable.

--=20
Thanks,
Mina
