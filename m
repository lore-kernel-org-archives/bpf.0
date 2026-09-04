Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DF3ABD9F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563819; cv=none; b=Zhpz6JHSVBE9QpU4UzPwPA7C4HT4Uzv0Y4iCsSPRsNdCtBfGJjUoBFE/QuvOXWT2kPqMDPbPtM2SH+YBfBe4Zp45a0O7jRvDDq5V2DXgqM/0kpMkLRpDLx+RF+BrHips6T3FrRlhDnQIodryXWoSU+CQuunI1mffnUuslelFbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563819; c=relaxed/simple;
	bh=dCGK+5CQYCXHSgBKKQcG7YPLkc0E1mAwwMS9f0mQ1qQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Eyiw8BeftTGmgmtlMgXsfoI0qPVcYTYmC4z92pjL0PCTeq9QSPDOdFEjvSW4f29ILfYxk6Ep6yOterPTd5rBXdL06XskqPBQSbNsPcQ9qrWIyY3GfFLkTxynocwfcJr+t0BAMBAAdY3+CjQti3h7Niz1pYB+Kzw3PiSBwB37ToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=awyihteA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="awyihteA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398e9698a70so1376363a91.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788563810; x=1789168610; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fe1GlyuKTc0shGJ4KGsnmbYW1CmUV72M/c0uYbs9G98=;
        b=awyihteAdZxirxvXxuKW+/Cn94PWBrwqwYAQ3iuOzzN89e9sRq/8kRtVYmjVdv69S9
         GxADGoPsKBaj+nz93O+a42FYJr7Dbch9G04ku108Lpsli6+qgnyp8mLe39ylMKx3q5T/
         c7mFbWOMbyiI7iL6WVFDgaWjgrLIqpAkMDyDFFSwuPl0vGVNHuV1mfNbwSt2JQINUTcd
         yITiSqdsYDLcE5mPDmeIq0+Gm/BcWoQSQ0FzcVBfHS9Ji67Ygx8w8TNdW0YfxzJKviyH
         6eOuA5l2z7hxOB0WhewJNvnrZ3fOirdhcRXKMm9/ZKIEB/Koujw1NxCJeB6JMajUX5p5
         hAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788563810; x=1789168610;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fe1GlyuKTc0shGJ4KGsnmbYW1CmUV72M/c0uYbs9G98=;
        b=YX9ff/qeM4a1pCNRa+hvsX4k02/mh3EXcXTkn9oUNAemPEivHzJRrGPxHItR/Y/NRV
         g+jGz6ps2UQ9g2uuDxHbs0Dq1RUjlqekZHHgPHonF+//wN09OPHlvhEgBKsnNwEXMath
         wfHkF+B9M5glu3QHPLHJGadTbFJWH5NY3cJWnKpLoQuPeRC+UjrFlqUC+UindAivCBQ/
         JSFPCkkUlJIzu5lF0vqPjzU4e4Y7bCfrQPZJh/K/iUkUitekNo9UAts6OhdDJ2B5ekPL
         pbUwbwdmjM8qC9rwOQCHGsO8si5w3jdl1rTcJYple3qfcS3nTMqdHew+9gsjx74yyRhi
         96GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJnqEJGlLY9VG+TClFE6vRrUYkoDEYQQoZFgKyPm0vq3QJf8D0bfyIVMGExCL3ZobTf4s=@vger.kernel.org
X-Gm-Message-State: AFuF++lDMs0Slk5V8vfqdmxHLoAWiT1YkJKMTulMuXRMcnqixN1w+2+i
	wmA4D6MsBAqOLcL6Jbek0C6QMQkYUZ20q+f2cUOxxA99EhCjFm3IWOFz/5yIiBHCAIU=
X-Gm-Gg: AYBFou2iFSfcWSrdnoo1Ptd+WVF9J3dwcyD2ysNS4kmpIZEnRTWGsYP9zfQHnXl6aHW
	W7SW5ZPTlW+lrjne8vZKemiBG0SLsyc4thobItReb2bqxFFgSvJW2jSJwDzcCF8CsWll0mMndaR
	D3SxCA7X+8SjtLcu0+PCOqvveTcCrQzRlrNkb6m7b2kVS71EdlshY9zZUC7/cYnt4a7CwZBgmbq
	dI4hRW2ubC0RNwiR21nVs4fL6sRT88JBemU9L2s0Rj13TD7oPblI1hIcoHG+KaPkkWOrXQD2gDJ
	agavgs/4Wo4Jn0HaWvqNXVGQxjnuFWmfucjpIyPB0OPn8t65YMVmSmt8vYRGDzAo4AtXL8K0Rqr
	ZvWQVd8I5+wpu8PYED5A+NthdDQRAmznumZsuCzZuL1vQbNh3YV32Hf5glTrvQ7IcnHUZ03mtTe
	uW/YhT3TqwN2By5wkvlpxqiUP5BZgqQ55i/t8t3T4hdTud
X-Received: by 2002:a17:90b:4c86:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-39b25f78ab8mr12763621a91.0.1788563809964;
        Fri, 04 Sep 2026 16:16:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:7c52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm9699901eec.12.2026.09.04.16.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 16:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 19:16:28 -0400
Message-Id: <DL6WY5J4EPB0.3KT7XUU9US5CW@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: <syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Simon Horman" <horms@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Hangbin Liu" <liuhangbin@gmail.com>,
 "Krishna Kumar" <krikku@gmail.com>, "Martin Karsten"
 <mkarsten@uwaterloo.ca>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260824030257.263179-1-jiayuan.chen@linux.dev>
 <20260824030705.266049-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260824030705.266049-1-jiayuan.chen@linux.dev>

On Sun Aug 23, 2026 at 11:06 PM EDT, Jiayuan Chen wrote:
> bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
> xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
> cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED=
,
> so the page_pool page is freed with page_frag_free() and we hit
> "Bad page state ... page_pool leak".
>
> Both generic XDP and veth are affected. A non-linear skb is cow'd into
> page_pool memory (skb_cow_data_for_xdp() -> skb_pp_cow_data() for generic
> XDP, veth_convert_skb_to_xdp_buff() for veth), so its frags become
> page_pool pages while the rxq keeps MEM_TYPE_PAGE_SHARED.
>
> We can't just fix rxq->mem.type in place:
> - generic XDP: xdp->rxq is dev->_rx[queue].xdp_rxq (see
>   bpf_prog_run_generic_xdp()), a shared rxq that other CPUs may access in
>   parallel, so we must not write to it.
> - veth: rq->xdp_rxq.mem is shared per-queue state that veth resets on XDP
>   teardown, and with GRO that reset runs without stopping in-flight NAPI,
>   so a type stashed there can be clobbered under a packet still in flight=
.
>
> Adding a check in __xdp_return() or bpf_xdp_shrink_data() itself is not a=
n
> option either: without recording it somewhere, both can only guess the
> frag's memory type, which quickly gets confusing.
>
> So record it in the xdp_buff. Add a XDP_FLAGS_FRAGS_PAGE_POOL flag; the t=
wo
> skb-cow sites set it, and bpf_xdp_shrink_data() frees the frag to the
> page_pool when it is set, otherwise it keeps falling back to
> xdp->rxq->mem.type unchanged. No other path changes behaviour.
>
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D237bbeed8dfe0699b7f5
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Hi Jiayuan,

> ---
>  drivers/net/veth.c |  5 +++++
>  include/net/xdp.h  | 14 ++++++++++++++
>  net/core/dev.c     |  5 +++++
>  net/core/filter.c  |  7 +++++++
>  4 files changed, 31 insertions(+)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153f..0afa0661ada1 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -775,6 +775,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_=
rq *rq,
>  	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/* A nonlinear skb was cow'd into rq->page_pool above, so the
> +		 * frags must be freed to that pool, not via the rxq's
> +		 * MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..b389dc527adc 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,10 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
> +	/* frags are page_pool memory even though rxq->mem.type is not: a
> +	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
> +	 */
> +	XDP_FLAGS_FRAGS_PAGE_POOL	=3D BIT(3),
>  };
> =20
>  struct xdp_buff {
> @@ -131,6 +135,16 @@ static __always_inline void xdp_buff_set_frag_unread=
able(struct xdp_buff *xdp)
>  	xdp->flags |=3D XDP_FLAGS_FRAGS_UNREADABLE;
>  }
> =20
> +static __always_inline void xdp_buff_set_frag_pp(struct xdp_buff *xdp)
> +{
> +	xdp->flags |=3D XDP_FLAGS_FRAGS_PAGE_POOL;
> +}

For veth_xdp_rcv_skb() we also need to clear the flag in XDP_TX and XDP_RED=
IRECT.
The veth_xdp_get() call takes page refs but not page pool refs, while consu=
me_skb()=20
drops the page pool reference. We should be clearing the new flag so that _=
_xdp_return()
doesn't try to free it back to the page pool, otherwise we get a similar mi=
smatch-related=20
splat to the original bug's.

pw-bot: cr



> +
> +static __always_inline bool xdp_buff_is_frag_pp(const struct xdp_buff *x=
dp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_FRAGS_PAGE_POOL);
> +}
> +
>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff =
*xdp)
>  {
>  	return xdp->flags;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 38336858c168..be36020484b6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5532,6 +5532,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  	if (skb_is_nonlinear(skb)) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/* A nonlinear skb was cow'd into page_pool memory by
> +		 * skb_cow_data_for_xdp() before we got here, so the frags must
> +		 * be freed to that pool, not via the rxq's MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..d34ba56d79d8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4378,6 +4378,13 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *x=
dp, skb_frag_t *frag,
>  	if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
>  		netmem =3D 0;
>  		zc_frag =3D bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
> +	} else if (xdp_buff_is_frag_pp(xdp)) {
> +		/*
> +		 * Skb-backed XDP (generic XDP, veth) cow's the frags into a
> +		 * page_pool while the rxq stays MEM_TYPE_PAGE_SHARED, so free
> +		 * the frag to the pool, not via page_frag_free().
> +		 */
> +		mem_type =3D MEM_TYPE_PAGE_POOL;
>  	}
> =20
>  	if (release) {

