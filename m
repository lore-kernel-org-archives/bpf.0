Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794864092;
	b=ITDWwQzQ4bs7sU7od4NjmWUBmzhbzdRosq4XcFV44AnQpqWepskyv3a1SSY0r/8pONu+
	 /52osd8p5k6kMMhFzDtVAfyGnm3aBGON9/QYg+ZTzlrGabdvo9usO8tsAigmfg423zVKl
	 qYr5rWCBEcgbGL1l4LFWY1MRdL0FwTfjGjA7nKShpPNuVJTyLkASqduN8lt5LVgGiQDOy
	 +eDKs9Arga8ZZlTyUV1FTmRA1qukW3gA4JuR+qQNJcQYQ1nmrbFAPopgty2aWObw+A2uO
	 pt+TJQ0HcoS0mck0ynwWPx/HRxZOJDnximB2W9FXgMy4eXza722P0IcajsptpKwUtCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U2SUB1HJ1zwYZLXTcRtJPzZNMb9jj63+seYf6oj57bQ=;
	b=b3dMLStxOM+LIVggmoiB43oXdZt7mhnkitBwtLR1GjppTTRBAnS/pXjzoIxfgd+yX5NW
	 KhJqHkZ4E9l9UJ5JWuudZbluXP5P9i6MK1OyvwqD4II5Ac5w47ZKRDMb4LbSMmEhDanLK
	 besQE4btlPBb/ftqbTMEv4vHcNc+y9/XVI/7a10hTLSN8VnMjfo2LmFpU0RMQwz2c6CQz
	 KcYG/hgdlByegTP85udt3Ovh3mqxJ9oHZqjyGmk247AJopyCrhiD0/QaGECE9zWQPKWXC
	 tBDict3GvHhWWpYYIo9uHbes7kp7o1AtRfwX0QkD5UkEow0q8dWchTLvh+iPFlWAaSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mpc2ulQR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA606A32F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFFA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mpc2ulQR
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae7fc5681dso353c88.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:21:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794864091; cv=none;
        d=google.com; s=arc-20260327;
        b=htptREiHE//axG+FEvVBO4+VHQEJF3Bc6iNJwr/5tK1DyaIe0F86SKWtQne+acC393
         v426ON/D0PXFTJXIxA4Q1omZICivdxIsPns515bdKV8oRqjk7hvHNcSbH1eOZ5SgvYRi
         bmpc98XXrpX2FS3j8aNH7fNcBiHemTddGlCj3Acc8rvYpDYUojLiutwssD5dMVy/+ZHH
         FGR5GGRgEcwyG0cdfD5T+z+NuOvBxnm1EzzMkEJZTBYosgk+YcgqfCkyrdFqfsuCTyQv
         5MFjQPY4Hbwy2bqaVJmWAJ7EW8UOwODhiLDNK+XGfbBrExV+wEpGKvxnPjaz0iKtEEC7
         mmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U2SUB1HJ1zwYZLXTcRtJPzZNMb9jj63+seYf6oj57bQ=;
        fh=Beh59z8JiMQmvNr+rh4uDvPfKCeQzh/4qcougA4cnsU=;
        b=qg6D+2nlHxENAY5w6qirynjY0B54cceeOeChARDDRe7wHJxflW9qXDnaRR7ivw1eqp
         rXphYJoikWMgg7qhWa2k54RX1Zt2QSu7Lm92BTUUgIgpwuuQ7IdvvwSCdJE3dyEguqPk
         hocsj84EBxuptLoZs+0Qn0DsYjgAq9KDI74nvbnzlaHegyZptMPAW5vCiDTozOt3nctU
         Tg9lXThMlEcDa1HH5nLL/kQBf/e/+rKHCDhQ5mTq1r6Ryg68n788Wf0jDOPoEFvJANDF
         HzGNIRveKAWxJCBNjSgW+XqubXe/d/5Sc8bGMA5ezfwu7VWEsorgaAKvrNzwNG/+uTnp
         0Hzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794864091; x=1795468891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U2SUB1HJ1zwYZLXTcRtJPzZNMb9jj63+seYf6oj57bQ=;
        b=mpc2ulQRbWKCYMfXteuPNK/WkDbEvq7BHSIozp/WZ5rJ9Ay1UwuDo9j5m255aDnmpe
         GNzvlEuBwblIIy7k0K+/Ti3XB/AJamiDqQwHXrckzMaQaY+AEdBbRckqS48Xy7HcnuZk
         kfiNuOUzahvY9TS+CeaNNQgCR2zzmDklIm/T3kq7FVno6v2vlW5BQC30y+s2wEZskIMX
         odTfuVUIIX8rI6coGiXhokSkAigXX77P9TqXOf7Fs0P7rm9ubE2JCFgv4OBxJvTqo0Nk
         9zJQtMg2R2xQyiElXWglY0jJolpQLWCl1KABb5VYenc2ODepzl9b+0OdTxyyheiE1FUw
         YvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864091; x=1795468891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2SUB1HJ1zwYZLXTcRtJPzZNMb9jj63+seYf6oj57bQ=;
        b=Zuh4PTiPvaeBZPaBaKeoaEtvXvuOOfqpJRnYK2D4IMFl9C+0ZYZKCDSJ5VI0fOtib4
         q/3I3ljs8MNXjRUNeGdNW1YssnHYLLPX9TbbGXNM2oSea7zZT2YWUcQkftKfEBd6Gsnn
         EIs9BgswX2VkoiTsZgQsptgFhoVEIjG1srJdN0CPSEVENhDA7cltUOQsNjiGw9NRbRAn
         DTci0SeTogqtgBsS9GPwR1Qu1pDdi4hf3C6iIFHnaq+TrLzJCmmtZRvjCkGVPgne/c3G
         dwgQPp4KX3H3m3ig54iXAMsaCZ238FO1oSbOENcqyQUbOCvdwbj3iIuODncnEi5XD3MC
         qsDw==
X-Forwarded-Encrypted: i=1; AL+hErGJfbKV5he+4JvbXCpKtmcU6ujW5HA9deVT3Z31Lh7T8JfroNyLI3t0pqEv8aSBFkARvqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8azo2t58RUDPiZpGWbChpPGn18dCtD5ooJiQT5l9z3kqTdQaMN
	t5PURaj6PmQjuEpz6NA8UhWdpqedCHTUXMEBKwqTTXmmu9aZMYLTygmSnmhd9Q1VT3MTGy3HGiG
	N43rYVleh7Q6POmx5oGyBveStsFdkt1hLJnJ04O7z
X-Gm-Gg: AYBFou2I7hpBOZV14EIrbFSYJ03Ah0KGSENMOuIQsAF9VsGQVwCBby2F4lrjk79ukiF
	fjc/R4QYoyQzcyuv33GvwOlD6/hS5eGQIi91fNkjSIOD3ewYTy3vljFWSkCJ/oOZliDXKGGwMi/
	yOdDSpGrRc85+b0/dHx1daho0QtCKbHxshtGaoEzFyRYVKo7FCylqubJD2/kO/NhG3msyDuLu/F
	u14eNXv+S1gdaGJI/YEsQIBYmPI89NbYf9Gb52bDO6ZW7UTK2fbBQgkW9vb4gerKWqVtDtm/FYl
	sI2oCgiVVnx4Vv+1n8BtYceDGz8JLTg5u7Blq0AKnFSb1H71XOvmTDun0f+Mpd77iqJpzAj6Ihg
	uu0t3U5Kh/tG0xce0D23D0VMtQwgZWzf17NE=
X-Received: by 2002:a05:701a:8457:10b0:151:5aef:b375 with SMTP id
 a92af1059eb24-1b53b1cbb03mr26870c88.15.1794864089874; Mon, 16 Nov 2026
 13:21:29 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-5-bjorn@kernel.org>
 <CAHS8izNC9APadHg9yPtROkii1H7TPMAB7Xhxo+y9Cx-XCw9C1Q@mail.gmail.com> <87v75xj550.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87v75xj550.fsf@all.your.base.are.belong.to.us>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Nov 2026 13:21:16 -0800
X-Gm-Features: AclHuK9w3CNvroM5YXJNKwgkBqNWzGZQCQodYorHP8v1Ci-t1CG7mz-WEanoHTk
Message-ID: <CAHS8izMxaRKkSKqp3x4dLgTrzuzz5=8WMbEvq5W-oiqoL5vckg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through page_pool
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

On Sun, Nov 15, 2026 at 10:55=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
>
> >> diff --git a/include/net/xdp.h b/include/net/xdp.h
> >> index 1105bb9e3292..5ab7802ac4e1 100644
> >> --- a/include/net/xdp.h
> >> +++ b/include/net/xdp.h
> >> @@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_bu=
ff *xdp, netmem_ref netmem,
> >>
> >>         if (unlikely(netmem_is_pfmemalloc(netmem)))
> >>                 xdp_buff_set_frag_pfmemalloc(xdp);
> >> -       if (unlikely(netmem_is_net_iov(netmem)))
> >> +       if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(netm=
em)))
> >>                 xdp_buff_set_frag_unreadable(xdp);
> >>
> >
> >
> > netmem_is_net_iov() check became redundant.
>
> Hmm, not quite... netmem_address() is also NULL for a highmem page
> without a mapping, and the stack reads those through kmap, so they
> aren't unreadable. The net_iov test keeps them out. I'll add a comment.
>


Oh. I missed that. There are a bunch of docs actually that explicitly
wrongly say to use netmem_address to tell if the memory si readable.

Can you, in a separate patch, add a netmem_readable() helper and
update the docs (and if possible code places) that checked net-iov
when they were really checks for readability? Now that you're adding
readable net-iovs, all that assumption break right?

> >> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> >> new file mode 100644
> >> index 000000000000..fdd55265a6cd
> >> --- /dev/null
> >> +++ b/net/xdp/xsk_pp.c
> >> @@ -0,0 +1,246 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* AF_XDP UMEM as a page pool memory provider
> >> + *
> >> + * Each aligned UMEM chunk is a readable net_iov with one owner at a =
time:
> >> + *
> >> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page=
 pool
> >> + *       ^                   |
> >> + *       +-----RX ring-------+
> >> + */
> >> +
> >> +#include <net/page_pool/helpers.h>
> >> +#include <net/page_pool/memory_provider.h>
> >> +#include <net/xdp_sock_drv.h>
> >> +
> >> +#include "xsk.h"
> >> +#include "xsk_queue.h"
> >> +
> >> +enum xsk_pp_chunk {
> >> +       XSK_PP_USER,    /* owned by userspace */
> >> +       XSK_PP_POOL,    /* owned by a page pool */
> >> +       XSK_PP_REUSE,   /* on the reuse stack */
> >> +};
> >
> > maybe should be xsk_mp_chunk.
> >
> > But also, why is this 3? Usually the mp's track allocated and free. I
> > assume PP_REUSE is actually free, but I'm curious why it matters to
> > your mp whether the pool or the userspace holds the memory (or whether
> > the net stack holds it. Can't it hold it?)
>
> REUSE is free, yes. USER and POOL are both allocated, but userspace
> gives chunks back by writing addresses to FILL, and it can write any
> address, also one of a chunk the kernel still owns. Taking that entry
> would hand the device the same chunk twice. So the provider only takes
> FILL entries for chunks in USER, and drops the rest. io_uring zcrx
> checks the same with user_refs, and devmem with the socket's token
> xarray.
>

Sounds like devmem choose to do extra-pp-refs on netmems given to
userspace, io-uring choose to give extra user_refs for netmems given
to userspace, and you have choosen to do something new? I need to read
the patches more thoroughly to understand.

--
Thanks,
Mina
