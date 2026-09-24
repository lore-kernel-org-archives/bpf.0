Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666C43F8D9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272199; cv=none; b=P9mw5BmVvguIfWgRRmJmmgH41gczsxkVzTzXj/FmaqFUqIUdzTKThNfxkCZRDpZVoHLhcetxhCL6KoeEsIVG2Dh+890nol3MMBWDBPS9YkQYenMpvlH33/Ep8RPj4rzu8kxctpI4ql2QI8DWnKmmXJWB7cKpeGir2ctbIF1uoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272199; c=relaxed/simple;
	bh=RXy7Ou1QOWH8eM/PoNMBdCMAjt0T9ASDa5ZCQDCjObU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QUQA3u0Sw4VPYppBi0ETfEwgBZdO/Wef/JLwluiZWZBqsBgSXI+hMUes7/YirdmXR8biXDAcV6dcJquSIje/g8pvYcopaxV5PBDHaIJ4A1SEQ7drgtaRdOJbTiNUZfwSONu2WRcOP/DZXkbZGgThc3kf31GzBQhTcPMhoitZrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/MvyOmn; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/MvyOmn"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91071ba92a8so1079346d6.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790272197; x=1790876997; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jhMxAV05it6pd2NHiFs1D8r78fRLUTSgrzLPRna3ABY=;
        b=H/MvyOmnhBqDd3ZuLmLt2IlqlsCyMPrD1m8XtT3RzIwzGR9vaA63gnC4neJoutU5JK
         umFWsBVlnBqF3pKt0R7B+Pl+NY8R+RtUEmTpblmZoti6qihutF3ObWJHwHzVegEj2OtY
         olShFTZcn7VtriSbMBf5rnDkFNFKdPENQRroydjQFBcRttyJT3G0upAZgJc4nvqvCj4a
         RqEqo7bYWI0T3Bw9bkbiS0+Mso0ZrVfi6jVjRhq/nJqrNCrM/9joZcmIIBsI1I7y9inD
         hp3ptlDoVGpGN0k8/hfXfejNhdJOLnJYzm2fP7sY2hZFtl+zOY6PJJJJV04qm+fVpbV0
         LoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272197; x=1790876997;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhMxAV05it6pd2NHiFs1D8r78fRLUTSgrzLPRna3ABY=;
        b=oBjDjlqMzpeZXRoOr+EuzVK3Gg/roCI7Q616MfLGki2ql4kDpQcEPGuCm3lDxD4u47
         CqARftHI0V6ac4VAhELrNyYMOWhQ+vt/vkIBUsI1xwL+8/0DG+CLWDvJImF0QCJVX3IU
         ydL6LCMNTEilt2icLm7SqiVSe2SxiEMAfKflIf4AhCnnlLYpLMpOobaeHLhno3an3ITi
         5pHa2t+mJfT6075BDxQDdn2cK26vg49A12QugnmVtKG3sa0w4xoEYcFrdnll/28O9MDG
         /fg3OGhmwQeGWPsalP0aFVZ2tumxJCh7ICQYIcog1bW492a7BRg9+jkNaNaIW9UqfFel
         SXpg==
X-Forwarded-Encrypted: i=1; AKwUvBwGisEBTxg7UZuUfCFBCHQgjqmmxKKN5869WqieXnXihCzzHKKhocZGkGIGAbzpvNqhCHc=@vger.kernel.org
X-Gm-Message-State: AFuF++lYpThUlkrG1mvRGVwkdX1js4IOnlT3gYdzkZTiLSWtjo1Kf1x0
	mGKUAxgfB6Z2MFvbUgRiDShb5Mnt/GresItpXmhXdyBusJuK7ASPaUVP
X-Gm-Gg: AYBFou0rjcsrzGDEjgyMrbK1nhapDOA7XNFjlRQxyI72rP2aGSTbHN/XVhcL4MIpsqP
	N3bfHciNryhE4gB6/j1Cah8gMTCqV1aCxvnErWVULf/LRkGPeagNTGMbGA/rQQK4+HSNykTmzgP
	VLbktN9t/vH3iaUbr35z96r7IwOVIa1A+Ny9zBSwGH455J/t7T+BTrypelj745MwrxwwCvCVwnd
	wzDljgyihjPrMiIEuPncPSpXOXKx6wNXosCWjqBkjf7cS9vNqA2T/33AptuzTZ0S7XJ9COZrooI
	9fXs2Lj3IYHZWrHR7nLg9+ERx04miuBAS1WWxaRu+VZzWE2mWIDqR6cKAIp/su88yhWDKs/yIbe
	K1/zBpNFexeQvZ0zCw2tzlrluaGb3svqDViKM5/+gzLSStPIDg9/YiGYTmuVg/CXRpc1OY5aWuc
	HlwwxkFzqDn6d0SIhGqSyCsBHYwOL8szAcoq+K06h1GzsjQH1BFhAqn38mfiPVjFh38qtjexIhr
	KULD9MPtqS9VA==
X-Received: by 2002:a05:6214:4a05:b0:912:517b:7be0 with SMTP id 6a1803df08f44-91421f1b16dmr42393266d6.43.1790272196522;
        Thu, 24 Sep 2026 10:49:56 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914271c4aa4sm10042626d6.44.2026.09.24.10.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 10:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 13:49:55 -0400
Message-Id: <DLNQJ0HDQBGV.2CDQAQ64FV1NR@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 5/8] eth: mpnic: start and stop the Tx HW
 queues
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
 <179021553598.2160803.16775147198934716952@kernel.org>
In-Reply-To: <179021553598.2160803.16775147198934716952@kernel.org>

On Wed Sep 23, 2026 at 10:05 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] mpnic_wait_all_queues_idle()
>   (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:599) returns void.
> - [Medium] mpnic_non_idle_queues() (mpnic_txrx.c:569-570) counts a block
>   as idle when every idle register reads ~0ULL.
>
> --
>
> eth: mpnic: start and stop the Tx HW queues
>
> This commit programs the Tx work and completion queue base addresses and
> sizes into the hardware, and adds helpers to enable and disable the Tx
> queues. It also adds mpnic_wait_all_queues_idle(), which polls the idle
> bitmaps of the TWQ, TQS, TDE and TCQ blocks so that teardown can wait for
> the DMA engines before the rings are freed.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index fe360a26a27be..cb4d1427434c9 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> +static u32 mpnic_non_idle_queues(struct mpnic_dev *mpd,
>> +				 const struct mpnic_idle_regs *regs,
>> +				 unsigned int nregs)
>> +{
>> +	u32 non_idle_bitmap =3D 0;
>> +	unsigned int i, j;
>> +
>> +	for (i =3D 0; i < nregs; i++) {
>> +		for (j =3D 0; j < regs[i].reg_cnt; j++) {
>> +			if (mpnic_rd64(mpd, regs[i].reg_base + 2 * j) !=3D
>> +			    ~0ULL) {
>> +				non_idle_bitmap |=3D BIT(i);
>> +				break;
>> +			}
>
> [Severity: Medium]
> Could this report a device that can't be reached as idle? The idle test
> here is ~0ULL, and mpnic_rd64() returns that same value once CSR access
> has been disabled:
>
> drivers/net/ethernet/meta/mpnic/mpnic_pci.c:mpnic_rd64() {
> 	u32 __iomem *csr =3D READ_ONCE(mpd->uc_addr0);
> 	...
> 	if (!csr)
> 		return ~0ULL;
> 	...
> 	mpnic_mmio_err(mpd, reg);
>
> 	return ~0ULL;
> }
>
> mpnic_wr64() also drops writes silently in that state:
>
> 	if (csr)
> 		writeq(val, csr + reg);
>
> After mpnic_mmio_err() clears uc_addr0, the writes in mpnic_disable()
> that clear MPNIC_TWQ_CTL_ENABLE and MPNIC_TCQ_CTL never reach the device.
> On the first poll, mpnic_wait_all_queues_idle() then sees all four blocks
> as idle and returns without a timeout. The caller can't tell a confirmed
> idle state apart from an unreadable device, so it goes on to free the
> rings.
>
> mpnic_mmio_err() logs "awaiting reset", which suggests the device may be
> recoverable rather than gone. Suppose the device can still bus-master
> after two all-ones reads in a row, for example after a transient MMIO
> failure. Could its still-enabled queues then DMA into ring memory that
> has already been freed?
>

Won't fix. Our assumption is that losing the device is not a transient
failure mode, and will require a PCI reset (not implemented yet), or re
probing the device.

>
>> +void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
>> +{
>> +	static const struct mpnic_idle_regs queues[] =3D {
>> +		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
>> +		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
>> +		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
>> +		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
>> +	};
>> +	u32 non_idle_bitmap;
>> +	int err;
>> +
>> +	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
>> +				!non_idle_bitmap, 20, 500000, false, mpd,
>> +				queues, ARRAY_SIZE(queues));
>> +	if (err)
>> +		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
>> +				non_idle_bitmap, err);
>> +}
>
> [Severity: Medium]
> What happens to the rings when this poll times out? The -ETIMEDOUT in
> err is only passed to mpnic_idle_dump() for logging and then dropped.
> Because the function returns void, no caller can act on the timeout.
>
> The commit message says:
>
>   every one of the four blocks a packet passes through on its way out
>   has to report idle before the descriptors are safe to free.
>
> Later in the series, though, mpnic_stop() runs the teardown with no
> condition between the steps:
>
> 	mpnic_disable(mpn);
> 	mpnic_wait_all_queues_idle(mpn->mpd);
> 	mpnic_flush(mpn);
>
> 	mpnic_reset_netif_queues(mpn);
> 	mpnic_free_resources(mpn);
>
> After a timeout, mpnic_flush() calls mpnic_clean_twq0() with
> qt->sub0.tail. That unmaps every pending TWD and frees the in-flight
> skbs. mpnic_free_ring_resources() then calls dma_free_coherent() on the
> TWQ and TCQ descriptor rings, whose addresses mpnic_enable_twq() and
> mpnic_enable_tcq() handed to the hardware.
>
> If a block is still busy after 500 ms, can the device still read the
> freed skb data and descriptors? Can it write completions into the freed
> TCQ memory?
>
> The final version of the series (the "eth: mpnic: add basic Rx handling"
> commit) still returns void and still frees unconditionally. It also adds
> the Rx HPQ/PPQ/RCQ blocks to this wait, which would expose the Rx rings
> and page pool pages the same way.
>
> Should mpnic_wait_all_queues_idle() return the error? Teardown could then
> avoid freeing memory the device may still be using.

Won't fix. If the device is not reporting idle, I think something like
this could be possible with respect to stray DMAs, but I'm not sure what
we can do other than leaking the memory. Also, the device would be in
somewhat of an unknown state, so all bets are off anyway.
