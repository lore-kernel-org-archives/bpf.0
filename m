Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405568;
	b=Lch4dTqEE6CIGqmikXLAghNv8XC0XazthixnJeGZiXDgesG2pB1B9SEKkm3mzylN4iK5
	 8xHEti2B/oYYs9YlzAiykKbL5dLIWWE60rGDPgFQoEb04nNNCO5iRx/ZOKBAJkSIJcKdW
	 /DwlFCz/JayyTqWHbbbgx+mumVcFGovC+eKPwsxtVM7uvtpN2rnqP5ZgOEf69kwOVb3VT
	 yl0VnS4PvzfovwKz2mKArGIxugw++VLaPLHWsuN5bIXfp+Mg3X4dL8h+O/Yole+6KUXNb
	 /IOtxIwA7FHlZfgj1yf0u2JGwxt5XiXZ5l2wJMbOCLnz5Ju4yW1uePC966vuY5FtYqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EJtdn69SZ7bqnf45DCQQ7XNS7gQS1Xt7oZiZntNYPgE=;
	b=1Yo4fAO6i1kyzMHQRIbRPnrmZuY3IpBoW0xenQCxvulb6LeJirDcfSMSPBGybLyn5L09
	 b722mLONCfba8ZmJO+91E3Ki2Op6K0RvsL8OZ7lHokHLnFnc7zEe9QxTs8RdkiSb8kz/B
	 uZtje+fyYIhiGCYMXZczrzKWjvKBiEWywy6xWT9Uu21NEasl0OwMTxd8GVdajf0OZHgyB
	 5ccCevOz9B1G7CR1BNiWpkWiiWTSXtZ89ishdZqgMZ6e6ZXa0j8Akt9zlgHpno3ALVgLa
	 zwkavqV3bFeGJ39rjc7DQPfbFq0JhXsmQKZRqI2jYHwSd79POZckfu28H7Z2s1xE0mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyzY5fTy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A95606A326;
	Wed, 11 Nov 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyzY5fTy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA31F00A0B;
	Wed, 11 Nov 2026 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405567;
	bh=EJtdn69SZ7bqnf45DCQQ7XNS7gQS1Xt7oZiZntNYPgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RyzY5fTylA56A1nOM5XsNt3SQEirZ+AZk7rK02b40HRtTqpPMjRqVU07HST00hW8N
	 0cfKtJUSXDgKhr2RIxI2YpD79h/ld7bYZKF1qfUiqaPItndjphqlGNR9tbN5us/OxO
	 j45qvkuarRM0ufc3dLOSKZgaHYCjP0cNLiXhlSoRM+sTkL/2VnQWguYtJ7SHuz6XJT
	 SNRcdUx8YKnXZcLMvwDh2YgD8+en4EKH5SdLJupNOmyMXPaphXVmIMJGbjWv+HgN+a
	 xA5LE59A6kpA8TpgqJfLXbQoJGKbOnPqMu1qYv66T76xBHo1e7Q755WMUMvi5+VqKh
	 H551FnETw2lRA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through
 page_pool
In-Reply-To: <avOia/ZPWiFdfW7y@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <avOia/ZPWiFdfW7y@devvm16445.scu0.facebook.com>
Date: Wed, 11 Nov 2026 05:59:25 -0800
Message-ID: <87o6bv8o5e.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:

>> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> new file mode 100644
>> index 000000000000..fdd55265a6cd
>> --- /dev/null
>> +++ b/net/xdp/xsk_pp.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* AF_XDP UMEM as a page pool memory provider
>> + *
>> + * Each aligned UMEM chunk is a readable net_iov with one owner at a ti=
me:
>> + *
>> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page p=
ool
>> + *       ^                   |
>> + *       +-----RX ring-------+
>> + */
>> +
>> +#include <net/page_pool/helpers.h>
>> +#include <net/page_pool/memory_provider.h>
>> +#include <net/xdp_sock_drv.h>
>> +
>> +#include "xsk.h"
>> +#include "xsk_queue.h"
>> +
>> +enum xsk_pp_chunk {
>> +	XSK_PP_USER,	/* owned by userspace */
>> +	XSK_PP_POOL,	/* owned by a page pool */
>> +	XSK_PP_REUSE,	/* on the reuse stack */
>
> Can you explain more about that reuse/reuse_cnt? When is the chunk reused?
> How is it different from FILL->RX path?


            FILL             RX ring
  USER ----------> POOL ---------------> USER
                   |  ^
   release_netmem  |  |  next refill,
                   v  |  before FILL
                  REUSE

POOL is a chunk in the page pool or on a driver ring. XDP_DROP, copied
XDP_PASS and XDP_TX recycle it inside the page pool, so it stays POOL.
FILL->RX is the only way back to userspace: an XSK redirect puts the
chunk on the RX ring, and the flush (patch 7) marks it USER. Userspace
posts it to FILL again.

REUSE is a chunk the page pool lets go of without a packet: when the
pool is destroyed (queue restart, unbind), or its ring is full on a
recycle. Userspace already gave it up, and the kernel can't post to
FILL, so the next refill takes it before FILL. Same job as free_list in
xsk_buff_pool. A FILL entry for a chunk the kernel holds is dropped.

I'll put that in the comment at the top of xsk_pp.c.


Bj=C3=B6rn
