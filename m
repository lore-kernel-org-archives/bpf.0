Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439266;
	b=QhwKPnGA1c4EvCgCCBEFIjMw4HMyGJhycV0GAoEKeQQgpDtqJbnN54nmSydNDYRaIGQw
	 E+vZ03mNE4eV/bDg/NoLobiuWCmIWDlIBqK3v9EoNSbliYqOj279rt+m+JsRFjuY0Ftt2
	 agBYs5OIsoOFci6PTW57EhCokXErxcsIsILEaAdunZ9mQ2e5tSWEudNfOUfJd4clt2oXe
	 lHtTeXDAMR8sKyLzZZgRH7LNOXyAeHuSgeqa5td9MDtYCSBiY2TmseNE9QRH5qwocVcIk
	 C7UrCgsC6OimZAfmg+Sx4TrfeTgU1+WLIotbGSOxdE9CB/mIRZwG/Nv4NAtCC/RZ8xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
	b=G8/ft3uhlNaoXHfuD3wDM20QmEtOiDRS6fhNdMGSLcZ3s2zDcvU1B3DbyNwpp//Lv6WI
	 vkJNo8qnB9bUEHsYVS9AfnkZE6UB/pG+j8S8uxjAdIpKNi931iSl/BcG119M+bp9KkCib
	 Z16J4+3I3P2XyVKlAJVDUokINMoAZtZqPX5sWp62pTUwbZNMZ+LnKJLR4fujCZyaH+y+P
	 1AhAX16Wixdk7BXO9bls3ig/jJBGe7rb1hId0EoOVVpSOV/1u9HoaBvLUC6Il/tt2Gd3k
	 ddGIyw6kau5Nvg1spo7R3aClyJzCdTAb03ogNcH4urc5o1xac8QCrZIf5iKQNaRZ7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PG06NK+8;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D660A2615
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 23:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 637D660A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PG06NK+8
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36caa19b0ffso2244928eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439264; x=1795044064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
        b=PG06NK+8sjeCnFGsPkv7biN/XWVPp8cx4Zvam/TsDYmOaiYK6pe/9gJPX+5xFQMDwG
         FI7ZSXarOy2ZHCcYR5HKV+yYkrekblBvCUk1vUXz8MBnle4pAyi/GaiRzj0Y8Nfhmwvr
         OtfaG8jT6g6qhd4JuBpdh076rXDErLVCFrVlN+o2mFB/qS+lMM/hs33G70qIsK6M4TEJ
         J9VDq8+u00RPZUP2ARQzoVo6UUoByewIDiHYnMAJTB80Wztg6WOV49S5nQpMmODo77Cm
         n18RFe/aTJZ38OOYzqUaC6AVSKP3D41+hpBAIqwtbHebYSyUXCxDDrF162O6k1hWddDh
         Thdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439264; x=1795044064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KNu4FBFo+NiXU4uk2EB8iN37f7AOkMfz2eB0q/Nmt5s=;
        b=sQ4IbUcSZAOTaS9huVvUmYd2J6jYPUslC0JR60cYURof2d6DDzXYn5WybxZVyFv3Pa
         y6I9W+B/irre/5H1fZN/mAzU0i2WxRQ2tuNeD2uM2EKdtaksSGbdrubGDLRB61Q1N1Ku
         p0O6HUfdAz7DbGDluWMORAvc4q6QrBcW+5I3OlMCqkNGROZUQm0D6+tbFc/rNTFYg1Mk
         UhNQNqIwp6s0o2pWxUYaNmNk7pfB+LLOy2hpuj94U5TOXNJ/pz+Csa+4y4WdUWFzQQHd
         GRxcjh8cEk/BGC7M0VcqMWWA0GWUXTyxfodLHvO4EieswxskhCIxnIADSrgnuuK7p5/t
         r0TQ==
X-Forwarded-Encrypted: i=1; AL+hErFp52FD/k1qbfOHEfFMtFEm6CtspAbIU6NhHAqDPw/lNuClR3a9MUB7qD0+T95tsOQgDr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KZmXR6DgQJb0Hnhp0rBNgYf3OtbXwET8Oao9R0CnM7ke076EF
	4pXBs+q+r0goXDpqVGmE2UM5lszPJ47ZckMEQq8I0+QtlVs0mPbBsd+u
X-Gm-Gg: AYBFou32ftXlDXrnHzdhJzD6ugbI/9AxyTZ+JYZ+Ywj4Fq4wBxk+HDtr/+MhOWZAlAw
	tJP8C+7/Qd12b52YwyYCiwKm9PM74B3YmexvQsUzl1keCIJc2W6M6BB/Otb8SH5jf+7csZaVpJn
	kAGMlJLCoTT1nuDG8aMWfeLJU7yL1rpi7ibRmtUdaVCK2xf2whqR2aJx7rTN9M2+LJXTSQXkU1n
	SXRjYfT9CINHzQjMi1b5BqvpQoNC1f80obos0c1RPolPfW9SlpPB+/ELtu1xiK4sarjrp2oW721
	HZ0c2eAx6YLlViF7tbCnLofIHxPvHunQ0SQIfu0e117i/Z52/3x+bMLfRM3H1ktNuAeZvCTcj80
	JMVyX6lu9a9Dr3oay2t5f8XCW14hZOBCQH2tSfRyyLG9Lr9vklaE/oAeIn7tst6W5Z7EH0IvmvW
	ZJxmtN55LiISqukhCdIIxtK9/7kLJvPxo57oEYyanPBz6/UCHATmkLbG4eoyV7RdbnjX8WpjTGW
	F4vBh2/yFxITDDHXLJyrW9Y5r2kXKXo2l57vRI7LZMiNUnM1Ad2Pnh3eInjW9+FwvjnxpgxLzl6
	3KXlW1HwbqYNXlZU7kEQhwc=
X-Received: by 2002:a05:7300:fc13:b0:375:87f5:ccee with SMTP id 5a478bee46e88-37686a456b0mr3993699eec.29.1794439264317;
        Wed, 11 Nov 2026 15:21:04 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm39819238eec.16.2026.11.11.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:21:03 -0800 (PST)
Date: Wed, 11 Nov 2026 15:09:21 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through
 page_pool
Message-ID: <avT1lx9mdbzz8OGo@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <avOia/ZPWiFdfW7y@devvm16445.scu0.facebook.com>
 <87o6bv8o5e.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6bv8o5e.fsf@all.your.base.are.belong.to.us>

On 11/11, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/10, Björn Töpel wrote:
> 
> >> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> >> new file mode 100644
> >> index 000000000000..fdd55265a6cd
> >> --- /dev/null
> >> +++ b/net/xdp/xsk_pp.c
> >> @@ -0,0 +1,246 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* AF_XDP UMEM as a page pool memory provider
> >> + *
> >> + * Each aligned UMEM chunk is a readable net_iov with one owner at a time:
> >> + *
> >> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page pool
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
> >> +	XSK_PP_USER,	/* owned by userspace */
> >> +	XSK_PP_POOL,	/* owned by a page pool */
> >> +	XSK_PP_REUSE,	/* on the reuse stack */
> >
> > Can you explain more about that reuse/reuse_cnt? When is the chunk reused?
> > How is it different from FILL->RX path?
> 
> 
>             FILL             RX ring
>   USER ----------> POOL ---------------> USER
>                    |  ^
>    release_netmem  |  |  next refill,
>                    v  |  before FILL
>                   REUSE
> 
> POOL is a chunk in the page pool or on a driver ring. XDP_DROP, copied
> XDP_PASS and XDP_TX recycle it inside the page pool, so it stays POOL.
> FILL->RX is the only way back to userspace: an XSK redirect puts the
> chunk on the RX ring, and the flush (patch 7) marks it USER. Userspace
> posts it to FILL again.
> 
> REUSE is a chunk the page pool lets go of without a packet: when the
> pool is destroyed (queue restart, unbind), or its ring is full on a
> recycle. Userspace already gave it up, and the kernel can't post to
> FILL, so the next refill takes it before FILL. Same job as free_list in
> xsk_buff_pool. A FILL entry for a chunk the kernel holds is dropped.
> 
> I'll put that in the comment at the top of xsk_pp.c.

Yes, that helps a lot, thanks!
