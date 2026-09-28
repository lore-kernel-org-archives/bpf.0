Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F464DD3D3
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607621; cv=none; b=NyZ04ed5+Xg2QeXi5iYYxVWPnJlcjgvBVwGoD1dJMrFmFOQLvIr96m4lO/PUsLL02FBSnUgomn8b2gROSapBQ8LabZSmaCE0b6369mpQa8ahgNovX0RBJ1rjXJT7Y04Bz94dhn9frEVMwpA0N4yTeA4aFboNRD9F6tpcG2vEejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607621; c=relaxed/simple;
	bh=ofLhtOUraYrBU9vH7dVYS99Kn/ZKr6TmW9UdLaKMYnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M91qlFdaOr2lYsOEWoxPbfp2A2MqGeKESeYlbGTtvp1hCDwWMxj4NAK8L2NfX2ZJ/zWElmzs7r2fB2MZXEEYOq5SFa5RcZRz4ZpFbHuXGcwKuAGIZyaCNkfGzfpYrxuOFMTJ8ao97c2i+lmUO4NmVHxLzdB3lten7tAbUORXpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmYqnuJ+; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmYqnuJ+"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09fcso17226051cf.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790607618; x=1791212418; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l4pH9TWXZJHK102QKSQ5xfmRzXhpONAZW7fKUqg/bHg=;
        b=WmYqnuJ+46B0CyUHEK39N3jeLZJGPd6/S4xTSwn+XFdZ4I8g1xMxmiFG7BFyJvlzOz
         QYpSr4HLJh5P4EQLSewdpOQ9NnCInXWAhmdPXRry2DQG8UUokOy1iUDwf47rV5GzJQSg
         lJ7V7B0lXbcvlsOHYmYMp4yABEnp1HIRRDFp/n/c03xYApY+0As0YSoLDASMCOV7jf0O
         frblB61G/oDyoYz/Xh4Mp2F9bteHXYkGMBrPFZuOLqLEThDB4gOIxBpc2aHgLdPXTNUs
         XEA1Mp6ngJge1xuX0Ky17+/5cs4iKrc2E8dWev+VBdrLdVJZ1YQ88+SSe7meMx2LXmp+
         Y8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607618; x=1791212418;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4pH9TWXZJHK102QKSQ5xfmRzXhpONAZW7fKUqg/bHg=;
        b=f3WgPyoRJvVVLMJKiTzUU7G3ESYiovua51I7ScjRlz8727X3JhOH382cIdL/LUfMFu
         pahlB2LVo2yJly6T0DhFojjnngUQ4bfwWz10BU9dTjSlqKQbD+R4hD1j35pzDMi4JOtr
         6QNGfqChnPQyeA8ckoqWqwQMPu0BNs6u6HJfgikxb88UvbOQ5C/fzHe71TFmye1iysfb
         snwAJtG8KlLi/MUGKzpfHIvxFGWWMuwUFoyzrgd5n80qgIXcg5kakLTJFAZl0M0y0Cye
         5ReuU6XY564zwmnOI1FeZwVWafUYDpCGuLw2JrZpp+fDDPl6sYD9mXxW3LMsMWPsiwnW
         GgCA==
X-Forwarded-Encrypted: i=1; AKwUvBxyx8FRmEAkG53bz9+zkZlvTC4Y8/M++GLCEMXvG2MxJmOOmdgsv/+TjeKNNTzWEKNoAq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJE78MQQ2iNiv/RaPo0a+S6/iB4weDFU4Tab7TvhFBFJjUAwb8P
	8f9hHJSjbPkQfTYop85nHpI9HGO7N/p42yEteOzYUIuoIu8ryGrPcrGL
X-Gm-Gg: AYBFou2R6YDlPkqQwFABCBHNMz/BkogTn3pU++k8iRKzRg8ouvyK0wcQiU7V5e0tS3F
	cjKQsrowYsA2lee2eyZEOh0kC8V9BNYXrdDuHuOKzoFHWRquOILshZ7EXysfgY97Xf3twMEWUUu
	RY1HUR+dwFUijoNQ+8pM9KSrqTlnnepfNrdAhA3Ejr7HILwN6UKep3RgFITo74kwDGS8BBf6Ad7
	f4mEFtk9zskHqrVMbyFqOPOxaIf0civj5xcf9+I2dWk9ZqRzP0+vbYdXTyQm9aEEpN9q//miAKU
	S6WoVNopxBkG3OAn7DYM29Dyg6z5rudQoDlhDL3BTexTxp6UulRwtxRUizKJJ5UEekVZclZw789
	h5GQc90iqEvjqsMdMsz8h7KquCGInvVSIvYzd+Gu3t4CYdRcitBssq9/N9VZQqfXI/pDvZYz80V
	PcoCl7mO5cZWW5E8mIWABpGzwOuD3NAUc3FWd7l+QOQV/t5b/9Gjgt4dAImT8DOwSmeolUqyGNM
	wQ=
X-Received: by 2002:a05:6214:d84:b0:914:5176:a0a6 with SMTP id 6a1803df08f44-9145176a45emr123730886d6.2.1790607615421;
        Mon, 28 Sep 2026 08:00:15 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e281a8sm81970906d6.33.2026.09.28.08.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 11:00:13 -0400
Message-Id: <DLR1F9RXTT06.UETFCFM0S7X9@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/8] eth: mpnic: start and stop the Tx HW
 queues
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
 <179055370349.3145.18291043056842354620@kernel.org>
In-Reply-To: <179055370349.3145.18291043056842354620@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] mpnic_wait_all_queues_idle() returns void and drops the
>   -ETIMEDOUT from read_poll_timeout().
> - [Low] mpnic_enable_twq() writes fls(size_mask) & MPNIC_TWQ_SIZE_SIZE (a
>   4-bit field), and mpnic_enable_tcq() writes the same exponent into=E2=
=80=A6
>
> --
>
> eth: mpnic: start and stop the Tx HW queues
>
> This commit writes the Tx work queue and completion queue base addresses
> and sizes into the hardware. It adds mpnic_enable() and mpnic_disable() t=
o
> turn the Tx queues on and off. It also adds mpnic_wait_all_queues_idle(),
> which polls the TWQ, TQS, TDE and TCQ idle bitmaps, and mpnic_flush(),
> which throws away any Tx work left in the rings.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 853976e11b032..aaa3a3e99a138 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -467,6 +468,180 @@ void mpnic_reset_netif_queues(struct mpnic_net *mp=
n)
>>  	}
>>  }
>> =20
>> +static void mpnic_enable_twq(struct mpnic_dev *mpd, struct mpnic_ring *=
twq)
>> +{
>> +	u32 log_size =3D fls(twq->size_mask);
>> +	u32 i =3D twq->q_idx;
>
> [ ... ]
>
>> +	/* Store descriptor ring address and size */
>> +	mpnic_wr64(mpd, MPNIC_TWQ_BASE_ADDR(i, 0), twq->dma);
>> +	mpnic_wr64(mpd, MPNIC_TWQ_SIZE(i, 0), log_size & MPNIC_TWQ_SIZE_SIZE);
>
> [ ... ]
>
>> +static void mpnic_enable_tcq(struct mpnic_dev *mpd,
>> +			     struct mpnic_napi_vector *nv,
>> +			     struct mpnic_ring *tcq)
>> +{
>> +	u32 log_size =3D fls(tcq->size_mask);
>> +	u32 i =3D tcq->q_idx;
>
> [ ... ]
>
>> +	/* Store descriptor ring address and size */
>> +	mpnic_wr64(mpd, MPNIC_TCQ_BASE_ADDR(i), tcq->dma);
>> +	mpnic_wr64(mpd, MPNIC_TCQ_SIZE(i), log_size & MPNIC_TCQ_SIZE_SIZE);
>
> [Severity: Low]
> This isn't a bug with the current fixed 1024-entry rings, but
> mpnic_enable_twq() and mpnic_enable_tcq() mask the same exponent with
> fields of different widths in mpnic_csr.h:
>
>   #define MPNIC_TWQ_SIZE_SIZE    CSR_GENMASK(3, 0)
>   #define MPNIC_TCQ_SIZE_SIZE    CSR_GENMASK(4, 0)
>
> For a 64K-entry ring (fls() =3D=3D 16), TWQ_SIZE would get 0 and TCQ_SIZE
> would get 16. Is this the intended encoding for each register?
>

The code is correct. TWQ has a max ring size of 64k, and that has an
encoding of 0 (like fbnic). TCQ actually supports rings as large as
256k, but it does not have/need the 0 encoding for that, as there is an
extra bit in the size field.

> fbnic has a comment for the 4-bit form: "Write lower 4 bits of log size
> as 64K ring size is 0". Would a similar comment help here?
>
> [ ... ]
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
> [Severity: High]
> What happens to the Tx rings if this poll times out?
>
> The commit message says every block "has to report idle before the
> descriptors are safe to free". However, the -ETIMEDOUT from
> read_poll_timeout() is only logged. mpnic_wait_all_queues_idle() returns
> void, so a caller can't tell a timeout apart from a clean drain.
>
> mpnic_stop() is added later in the series, in "eth: mpnic: add a netdevic=
e
> and basic Tx handling". It carries on whatever the result:
>
>   mpnic_disable(mpn);
>   mpnic_wait_all_queues_idle(mpn->mpd);
>   mpnic_flush(mpn);
>
>   mpnic_reset_netif_queues(mpn);
>   mpnic_free_resources(mpn);
>
> mpnic_disable_twq() and mpnic_disable_tcq() only clear the enable bits.
> TWQ_BASE_ADDR and TCQ_BASE_ADDR still point at the rings.
>
> After a timeout, mpnic_flush()->mpnic_clean_twq0(..., true, tail) unmaps
> the in-flight Tx buffers and consumes their skbs. Then
> mpnic_free_ring_resources() calls dma_free_coherent() on the TWQ and TCQ
> descriptor memory.
>
> Could a Tx engine that is still busy then fetch descriptors or payload fr=
om
> freed memory and put it on the wire? Could the TCM write completion
> descriptors into memory that now belongs to another user?
>
> fbnic_wait_all_queues_idle() handles the same case differently. It turns
> on Tx drop through fbnic_tx_flush(), polls again, and returns an int.
> Would something similar be needed here? At minimum, could the error be
> returned so the caller can avoid freeing the rings?

This was addressed many times in the v1 sashiko review.
