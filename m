Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440811;
	b=xo9ZfY8Z8nP/lzKdOb5Z88B3PbyZlUxMMlqIjybT/0qw7dNf+eBCZvetHo/9sMu/JhhA
	 Pw48SqxrMdsEOoKRraR/4FR8emmixyPkT03DxhAFDnZWyz63DbcwtLqX4M5UiawtgLOw8
	 xTIYQOwwcIG8wSB2DZCb2sbuUFQcUrR1bECkdyszJd6jhtyE8T/RhasJek5wyT+e25Sdm
	 lvC4H0XfCLb082HmiHBoOscpx86whZpxtU7pnbgjjAN5Mu/S9n5n94VwDYFcwfG874u9x
	 Y2yAGecpiFNlW72paukc7jteuIlCCrlrZHuYF0oSlri81jiVZSAaHraief0PEyyUv5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
	b=ZzellPsrRR8r0D78Dl7wjt4NcG0d891EeQQiN27JDZ/WMR9uxghqx/vBej2wYYI0YZiz
	 CKflqyZX9ccFmNxU8r53uHs4i+SNr+vK/V0m6YE0ZXd7fllaQq84b5c2GbDZ9B4s9Vy4d
	 LvlZADUU4aFcYBhqAfaQIMVM7BSVFLBU2isvlplTV85MgIsHchp3SrPrNDq5KDIBH/tDY
	 /AXlFpsffLwJpc7vkRJ8s4jxGZEIehG4tD8SVLG4zBD9DAGSGzmptvL2yR2DiQFaUZItX
	 ktE0XDxU2nDnsCucFcvup/U3TEaEEQWdKcNmxh5a0lsGuHFvhhfigau2NJb9BHKjAvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NMzD0TqQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F697606A887
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 23:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F697606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NMzD0TqQ
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4adaa0f72abso285493fac.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794440810; cv=none;
        d=google.com; s=arc-20260327;
        b=UJIUcnUw31aR5zXv1qmiWSOaRKSqeSAfZj8hPyyUpXuvO5kKe2hkFTRiu02AHdl6Rn
         eB//+C26ePbdmEKfMGB7GssVy87LaqQZX1gIWGKzM9WdZSvtxroOf1F4TbA3My6qs5y+
         vrp+ES4hJrfMJQ43f17pgy6YlY93OT+0kfKjX1qoUZYKmY2Hw95nYGIOHGkQXYZufxiq
         NSZTwsj2QrMBD9oLopgDU5OtV64d4l4NnVYzczPxXSj2dBz3qUhQef5ahM7jkZp8HStd
         KjytOw/ZSYlf4y5J++KpYUnedigCR5Y69qgXDwAwRvRfweogYqpd2G5NexB+IW+Gpca9
         xRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        fh=LY7GBeBGxIWmuRDzXUpu6m08nqV43vwf6GSDhXCMvaA=;
        b=MYwtGGkgV7Hxpp8pKx+GNxJVyfMETaBBHGjQYx/Mx62Kf60jjVXSXzhWn1rRsnFDix
         gP8GzA+4Qv0W+vOts3RkFWww97feB0shVdo5uVg8Y62fKBLmqp+d5qEm3tEnJZCD4Pf1
         BC4fA79nR5BFsaAuKkMV3iOzcxFNSJEVRtVsnvucVBKogMDaDvUZKcfU6iv8LwvcTOM9
         o8gWes3zewTrXMuRFwubeTYsKtR7toWDEPGtdB9Py8iERe4pE4tnpUJrw3EibEH/FuVX
         E3sSXkEXexH+ylVk49TsQPY/sX1LoLX3PG/FSkn0n3nd1Vguftm6W+JMqzAQljfuN7xE
         kVpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794440810; x=1795045610; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        b=NMzD0TqQuwQhNFF7aHIeC3SA22YiAV6mClPOc6MrGmoClNILecdh5gv9EaYatBhdKE
         S1H4sFNblnlve+OJ5uv+CLBpCh3zyK3uPT9kEdQN0l12HoIbPqEJlOF9UoFWSkvyP+rJ
         3mNTQlsFv1mTjxeytumNxJdr4WJuHO33aTEDzdBhhksudoGOfutqWottdoB1bfhO6aSd
         y367fAjCvv3590WzqeHb+Op5WihluIRpLNtFeGoYDaTL1OBZfeAsuyTJH/7XQqQHlccp
         0Hkjf03LWm6Ft/NQ3NDaVlRkGHvuDpIkm3elkOCI9vAVjkFFQnT19iVmrD5Rtd8pjCBp
         EfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440810; x=1795045610;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        b=XpUPTe2MtTea9hMZk/yFswzxRaqICz/DUFK7ZWuq+wcaBnc7o6OfX4WpaCqA5AqcCM
         K66NoLrBppQoX/cwz+dvH9eEwjd3ew7qtDFRCQ3ftZtNUD6iDTVyOpdMvBRoI78xfiOK
         J6joNEn/Ek2XDaJl6XEGPRzC0ryBRMsBcRU9Sc8erooDMj2RjX0JTO/KSb6E4B8FwePc
         ZYMqwR/oxngQzblgUHWl/DugFHXtr14WJLWjHj2qsQ7NGgd0BgmOR3lCaKFTwrmDVHuA
         4Tueg/4jlJ9+Kc+/1v4DdH8a6n1Y7vP6fzoqSLx5wwqyyFdBPTGIf0tFASGGhO6JMTjE
         R9kA==
X-Gm-Message-State: APuU4Z8IuTybXqdRWCZCNPKjIP5iYkLVpZUFG0EEA2NHqtstlc2avwvn
	osAecp3u0hHgo7XIBv+HFh8/vB3YAXa2Zo9QtvOl64oKDzMo9YjRxd0tJaYzzuHf5rOqWKCu5/N
	UjqCz3u+2UvC4HIFTQmE5AyzUqi+gtfGFq0PzLE1pqQ==
X-Gm-Gg: AYBFou3fmc6wcy/EuBhE0vGOUolozfMEsOSDwhYFuKkeAXh8AmqKshZDNvdRIiWg3Rb
	A12MNm3EgVc3hsOf4dVwm+LARUP3BeQN+aWC0smOJdS72cPYYzCwAFdzNRE/9zo0L539b4BSx0r
	5yAh4tVX6GCl/VNE2ThL2sX685nyRJLokUJjO/koeSW8D+OqulVMJt3Lc3IMmE0E9tJJ0c2KXY7
	8I8TzX0z7QMARmb93SZ1mW9BkQEwt15VtPbqmn+ytXRdhPDySW/+1rxitrN19Wf+PJ63z2DrdXV
	v4e8fKpTxXeFD7K+Xmysl/xzDTFkkdlqQfB9XS9zceLuLQRuUgOrHstyh8UektIBvAqP3tg3neD
	0zE9HkyJ/NzEBhnPDwSRTRiWcDCWlA0GsRCC1cCKdTDU2scA3A1tabxn6EqCzwu8uRRoreE6rDw
	nlxvcmaEsECQ==
X-Received: by 2002:a05:6820:f004:b0:719:1627:6c16 with SMTP id
 006d021491bc7-7196b62ab2dmr743911eaf.12.1794440810117; Wed, 11 Nov 2026
 15:46:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com> <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
In-Reply-To: <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 23:46:39 +0000
X-Gm-Features: AclHuK98I8l2CyqIug_hRhhYiDHFe7Xrim7_SwhM5rRiI9ms5coKAG0rV8Jl2JY
Message-ID: <CAG4wq-dw8VqiVTbi-fSJTnwj+amkfE_56ndKCYk4v31z2ppcTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

Hi Stanislav,

On 11/11, Stanislav Fomichev wrote:
> My main concern is that we are adding a lot of code and one more
> special way to plumb the metadata (and another metadata area), another
> set of kfuncs

The RX metadata can be stale on XDP_PASS and lost on XDP_REDIRECT.
There are already separate attempts to fix it:

- the RX hash and the VLAN tag [1],
- a checksum assertion [2],
- the checksum invalidation that you suggested [3].

For me, the question is not whether to plumb the metadata, but how.
It is not great to have fragmented mechanisms. The skb core extension
area aims to unify them.

That is my view. What do you think is the best way to solve these
problems?

> and slowly creeping more features into xdp making it
> more and more like skb.

I will leave this to Jesper.

> For containers in general, and for fast af_/xdp, we seem to have been
> moving into netkit with queue leasing. Maybe that's something that
> can help with your veth performance?

Thank you for the suggestion. Unfortunately, it does not fit our case.
Our XDP program decides where each packet goes, from the inner
headers after decap or even partial decryption [4]. Hardware queue
steering cannot do this.

This series also covers cases without containers: XDP_PASS on the NIC
and cpumap load balancing.

[1] https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/
[2] https://lore.kernel.org/all/20260630191510.81402-1-deliran@verdict.gg/
[3] https://lore.kernel.org/all/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/
[4] https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/

Cheers,
Tianyi
