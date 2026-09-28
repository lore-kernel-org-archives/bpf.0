Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74C4E433A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608278; cv=none; b=Fon/DVXdX4pE2R9XHbrPntW9x5/cWlyQ/BV95btUdpmmHeah4vFqbme3iCsd+R9sst0awD5edYdZ1WsfV9jdw3k/3HwoPD1hr49RrhJI5pStakH3CEwzrAPgZRWJdPF60EQUuSJc91+Fx0oIQP9FExIIRniKoGTUSNjvBuGa3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608278; c=relaxed/simple;
	bh=Btgwhx0BnnAizJrXmxZMw/SLxF62CwA2ISV8PZ03L+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JkZ8R6d1qvusckCLPKyOijrpplopANoFCzDF0GTSQhZ+J9ynSje+m/F27sGxwl+pjlCcLiJ88MICpn1YkaPCQ/UDe5zJiUST4PDMYkXdqzVgCNd1rfK6MVprp1HdxQq2Fh0mHPY1Sl9xkmmbGotgirBN11PljLXhMb3NdSPnfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hElgDlSu; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hElgDlSu"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755aad8a98so309901d50.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790608275; x=1791213075; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QHvMa8Hu6Y1I/qqNnl3MyJApBFjOdiC6iLmv+1VbGMM=;
        b=hElgDlSuokS9yZy/UsRR4dQkO3sP6LXJsluhL2CVlNltYLdF7CreDDTtQFmbrGEaGG
         c/labKYwefQrh0ZYnFs4PyRBSRbX49xpHiZE2MaX2jZSfF37hgl5u9aFL9R0WLwqt1iB
         S3wJJGkcaGGVPUlTaYw4kSYT1NBzS2mg3P5WZ4OgfA2cpohU+c2Pkt4lcVp4KtBbrPap
         EbefgauT9x89OUNiC7WxhcBXmLsZTSQpMiVrBM7S1LIoNFRblmUDhi3qDwEg77jF89ij
         u5ZxOvq5Qibk5QYYYheaPBOgez7ezQEiXOfaNpIRdu0hj/j2TqBNVEIoCh0Qx7I1FTJP
         vbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608275; x=1791213075;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHvMa8Hu6Y1I/qqNnl3MyJApBFjOdiC6iLmv+1VbGMM=;
        b=z9rhYXRTgLIQVqYU8vMDiKRUc1hzFuJOPIWE4CdAd4YLyd2WTHclHVuX8CaoJ4Z3Ej
         2bzb1MbKD0DstDzzbGeapA/NYr2smVfFYSNx+1HJs6w2LKuwldu1JkYmFqllSzw2po0G
         MMECaghI0OrFEosO2XGM9qxkF9jl3qnDQp15lt19yqorVyyIOLZkayi0ZYjCJFTHZzXc
         grY6OmeOv3QOM/Mmm0iQSeliSusaY1ugtu7Kp52CmN2cW596OaRPJqiWZ1Y8TM09sJoX
         FQPCwgMPkzU+/8+2fVKqQGAqitfHVhkA0mrmaKSjY2Ru106K9WPyfYv2/Je6Wsj8f4Dm
         67LA==
X-Forwarded-Encrypted: i=1; AKwUvBwSCe/WBhL066LAEwpz4O6Z6xrNzGzDONIBsjIvUxKIkeEOyzFTisud9wjk1bCqJFdIM4Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhCKME931SygbfCVEkMs7OAEnrWuBP+3INeEmz+U59BQDP/ILR
	wMz1fHGk9dIURcjUrQO8HqdP78lxsF864O7mYp2GXLHkKjnvcQTaGWNU
X-Gm-Gg: AYBFou0e0P48B06M8zWB0LmS/78fcwVG6tIYTze271FJn5+M9HkPpjDgPBKx6pPxc4T
	lEobaDIYtGnbskxYszgEwdtc7OED9hbvGshW7+8XEzzOB/XNEkBOQUjCvFP1lmC/rWv20khVGmv
	ftPlKB3P3FEAVZTxJBJsVihRJQ5dqUCOhJCFrmCtS1QXr1sV8luH8zAqnj0sV6JRnmAxHcVTION
	nk9FBrqQUIadMuh6xA8exB7JrXfT5kP1RsCwfUWDFqhFImxbF1HrMgflIGablCAzdK+jYfi8Sak
	ePp5wLQO8c3ljyYb0iUpYnCH8GDybtq07penCl3j0o+Nvbx8htBw2rpbBT/UiM++OpJYJ+2Awmu
	F84pUBgH6BlnBnfnaQDBo/Aa+5ZSWszFbsbZWBVOhOBr4kKPJFoEUM3LSGMSX8rdfIUQaNy7n4T
	nVOsqQ7f3dZgXXPRDhEMoXxG1mp/o+gAWUhcXZjMXp2ovpP8Gnh+3nLH1OkoSKi+vIUTSIZhJAZ
	pN6o55Re+MNYg==
X-Received: by 2002:a05:690e:11cd:b0:671:70d1:d6e5 with SMTP id 956f58d0204a3-672ed9737dcmr6316635d50.87.1790608274762;
        Mon, 28 Sep 2026 08:11:14 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914399d5002sm74202116d6.48.2026.09.28.08.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 11:11:13 -0400
Message-Id: <DLR1NOR9UY43.3PNHOY085ZSU6@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 7/8] eth: mpnic: implement Rx queue
 allocation and cleanup
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-7-4badc9b58b9e@gmail.com>
 <179055370676.3145.8533599239834787365@kernel.org>
In-Reply-To: <179055370676.3145.8533599239834787365@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In `mpnic_stop()`
>   (drivers/net/ethernet/meta/mpnic/mpnic_netdev.c), Rx teardown frees=E2=
=80=A6
>
> --
>
> eth: mpnic: implement Rx queue allocation and cleanup
>
> This commit adds the Rx side of the mpnic queue triad: a header buffer
> queue, a payload buffer queue and a completion queue. All three share
> one page pool per triad. It also adds the enable/disable, fill and
> flush paths, and adds the HPQ, PPQ and RCQ blocks to the idle wait done
> on teardown.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index b1fb0d3902a7a..389a9e5476c6e 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -767,6 +1084,9 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *m=
pd)
>>  		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
>>  		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
>>  		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
>> +		{ MPNIC_HPQ_IDLE(0), MPNIC_HPQ_IDLE_CNT, "HPQ" },
>> +		{ MPNIC_PPQ_IDLE(0), MPNIC_PPQ_IDLE_CNT, "PPQ" },
>> +		{ MPNIC_RCQ_IDLE(0), MPNIC_RCQ_IDLE_CNT, "RCQ" },
>>  	};
>>  	u32 non_idle_bitmap;
>>  	int err;
>> @@ -779,15 +1099,31 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev =
*mpd)
>>  				non_idle_bitmap, err);
>>  }
>> =20
>> +static void mpnic_clean_bdq(struct mpnic_ring *bdq)
>> +{
>> +	unsigned int head =3D bdq->head;
>> +
>> +	while (head !=3D bdq->tail) {
>> +		struct page *page =3D bdq->rx_buf[head];
>> +
>> +		page_pool_put_full_page(page->pp, page, false);
>
> [Severity: Medium]
> What happens to these Rx buffers if the idle poll times out?
> mpnic_wait_all_queues_idle() returns void. On timeout it only logs:
>
> 	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
> 				!non_idle_bitmap, 20, 500000, false, mpd,
> 				queues, ARRAY_SIZE(queues));
> 	if (err)
> 		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
> 				non_idle_bitmap, err);
>
> mpnic_stop() then carries on with teardown either way:
>
> 	mpnic_disable(mpn);
> 	mpnic_wait_all_queues_idle(mpn->mpd);
> 	mpnic_flush(mpn);
>
> 	mpnic_reset_netif_queues(mpn);
> 	mpnic_free_resources(mpn);
>
> Two things happen after that:
>
>   - mpnic_flush()->mpnic_clean_bdq() gives every page still posted in
>     [head, tail) back to the page pool.
>   - mpnic_free_resources()->mpnic_free_rx_qt_resources() frees the HPQ,
>     PPQ and RCQ descriptor rings with dma_free_coherent(), then calls
>     page_pool_destroy().
>
> Before this patch, the same timeout-and-continue path only covered Tx,
> where the device reads host memory. Now there are DMA_FROM_DEVICE page
> pool buffers and an RCQ that the device writes to.
>
> If the device has not quiesced when the poll gives up, could it write
> frame data into freed or reused pages, or write completions into the
> freed RCQ ring?
>
> Separately, the earlier commit "eth: mpnic: start and stop the Tx HW
> queues" says every block a packet passes through must report idle
> before memory is safe to free. The Rx idle table here covers HPQ, PPQ
> and RCQ, but it has no Rx DMA engine entry to match TDE on the Tx side.
> The only RDE registers defined are CFG, CTL and the MEM_INIT ones.
>
> Does RCQ reporting idle guarantee that the RDE has no writes in flight?
> If not, should an RDE idle entry be polled here as well?
>
> This code is still the same at the end of the series, in "eth: mpnic:
> add basic Rx handling".
>
>> +
>> +		head++;
>> +		head &=3D bdq->size_mask;
>> +	}
>> +
>> +	bdq->head =3D head;
>> +}
>
> [ ... ]

Same feedback addressed in v1 series.
