Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865848;
	b=o7tyZHfwsRSy3R5CoOje6yu/rV/xts1yG6wMa51pe/8qHDzLerama0RpLnA8aoReVv6a
	 wuAlzY93ZG69rbexcX1RARL/PeyNvzU4EAXlCWfm9lfpVHNGW2c0viCHtcXHOKpr5Exak
	 0jw+13D2797ehXd1WLp10oh/lkLHkirM2ORUPAKIH66oJ6HfWIvo9KqopfchL7sZ1ErFp
	 SVQsY6Cx8I1eCCQAZD0oOCJNA2WG6+7vTJWmhx1f7spiSzfxI8wL3wcMAShRLqP/KVZR6
	 XJzz9ELcxT2lae4c023JDkmadec89dK0UEXNJkBJhIFMpcV3eVctjf3glfD2lQ4FZVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865848;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=q/IVcg5Dvv6LOmALB64d6dD3OE6L0hYQ//UPgDGID20=;
	b=24F/S4JjPHDpCxP9neyi0nyM8fwRBMMItkXY2nKIDO7/5tX7IY8d+TpoZ+MpLSKTntTJ
	 Z15tTPoxoFySruRMo/9QhqSIbHiVyrEEDvSpgZ1u2KTpdTkZ5l4Cb6mdwWrH2j4fk7ezo
	 +2iPupNIcbGV/AebxKXJROh35DAdSlx4hjpF3kNbVeYImhSyT0Vrp2dLug81T8Mhx03Bi
	 lw4/SAjME9vtsh8dx1bBii/SmZWPbUVj31WDMofuGGJxvke2ph2NAGyNDcchCIj3qW5zs
	 7+epiEeI0lL/L5omTSMHwgB7eS69Br7v6QttBISBRZi3a2zbyHwcGCSEyC3k7/0OOOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0s9R5+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42239606A328;
	Thu,  5 Nov 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0s9R5+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4C1F000C1;
	Thu,  5 Nov 2026 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865847;
	bh=q/IVcg5Dvv6LOmALB64d6dD3OE6L0hYQ//UPgDGID20=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=i0s9R5+VoRkAyQcEkiiUSRvQre+yA4sOH9fDaHC0EOsXo37zcoE9Pu93SmqW5y6M9
	 75jwKmAN9cwZB2AEDjBioMQU9MJ5tzC5d0tYeDbV565Fjhw8S3rZYG+MkzTgeorTT+
	 4UMSo0iYWRRvbFNzsX3Vt9vWRu9PKes66PuVrqq79ybHVRb1WR8VgtrqTUM0cLNXrJ
	 MoF9QMHIooi5VprLbqzXWN7/JlqNxYcejkoO9vpHEh4nA+2OXJ0GElPA1Ko3ZzMX9m
	 JTIy/SvOw0ysGRZQyJxCgCAGeXiC1mDX545zFGFkBkHl3uzf+8CAlPBPGa/uvfengH
	 nhP60WqCq3guQ==
Content-Type: multipart/mixed; boundary="===============1261712251123050467=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
From: bot+bpf-ci@kernel.org
To: meng.ding@siemens.com,netdev@vger.kernel.org,willemdebruijn.kernel@gmail.com,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,corbet@lwn.net,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,rostedt@goodmis.org,mhiramat@kernel.org,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,richardcochran@gmail.com
Cc: florian.bezdeka@siemens.com,jan.kiszka@siemens.com,wq.wang@siemens.com,p@1g4.org,gerhard@engleder-embedded.com,meng.ding@siemens.com,kerneljasonxing@gmail.com,horms@kernel.org,skhan@linuxfoundation.org,rdunlap@infradead.org,mathieu.desnoyers@efficios.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 08:04:07 +0000 (UTC)

--===============1261712251123050467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> net: mark skb NAPI IDs independently of busy polling

TL;DR: Commit message only: it blames e68b6e50fa35 for gating skb NAPI IDs on
busy polling, but that gating predates it; 97dc7cd92ac6 introduced the
dependency. Suggests rewording.

>     net: mark skb NAPI IDs independently of busy polling
>
>     Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
>     added support for deferring RX timestamp conversion to
>     ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
>     uses the skb's NAPI ID to find the device that owns the timestamp
>     cookie and invoke its callback.
>     Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
>     gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
>     when busy polling is disabled, the skb may not carry a usable NAPI ID.
>     The device lookup then fails, so the driver callback is not invoked.
>     get_timestamp() falls back to hwtstamp, which does not contain the
>     converted timestamp, resulting in an incorrect RX hardware timestamp.
>     Record skb NAPI IDs independently of busy-poll support to support
>     drivers that use deferred timestamp conversion and future driver
>     features that need to look up a device by its NAPI ID.
>     Signed-off-by: Ding Meng <meng.ding@siemens.com>
>     Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

This isn't a bug, but is e68b6e50fa35 the right commit to name here?

Before that commit, __skb_mark_napi_id() / skb_mark_napi_id() was already
inside '#ifdef CONFIG_NET_RX_BUSY_POLL' with an empty stub in the #else
branch, and struct sk_buff already had napi_id under
'#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)'.  That gating
goes back to 8b80cda536ea ("net: rename ll methods to busy-poll").

e68b6e50fa35 only moved the socket-side sk_mark_napi_id() out of the ifdef
block and added sk_mark_napi_id_once().  Both act on sk->sk_napi_id, not on
the skb.

It is also about six years older than 97dc7cd92ac6, so the message reads as
if a later change broke the deferred-timestamp lookup.  In fact
get_timestamp() has depended on a busy-poll-only skb field (skb_napi_id()
returns 0 when CONFIG_NET_RX_BUSY_POLL=n) since 97dc7cd92ac6 added it.

Could the message say that the skb NAPI ID was always busy-poll-only and
that 97dc7cd92ac6 started depending on it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41989099174
--===============1261712251123050467==--
