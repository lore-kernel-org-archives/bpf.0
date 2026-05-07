Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF03BFE2B
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163909; cv=none; b=qjOFnPqEY0NhuAfxgD14jI2SHzySu4eC32YA4QJ0xdr8IYfJjaGnWw4/MTwbvB2lKnWL2QsToJTTdjTRcTX7KjsaY1UG3I2WN5J2NWe7FrTGQ8+EBRkAF7ufnZbEVkWvPgeHJ8MuPTwsSWNqzAsV44cg+DXOY92B8/9Ws4Yp6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163909; c=relaxed/simple;
	bh=rpONTYyBHvb3/ty0Cn6LLhwjJ8jU8C2TLAGIYKpBTSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBPrJe925w9WsJws86zjHR7sx+GNI250nUuxomqLwAJqRADN0w+xcVYDrU2yb4970w30RSOGj6Tajb9JNHiMcm2R1WCIgVIy0ZrEjcI3QODjiX9HX1HAwJ3DwAroqDoHuEIF0G2M2QAGrqw4eXEVblo2gVM+rAbXsBIe6XEeAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCd+t8m8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oq37BxOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCd+t8m8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oq37BxOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778163906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
	b=SCd+t8m8Sd/Td4rBpvJ7O4QK2rEOcZz80cs6Gtiwo/JvqCGz8HaDQ5cw/VBqqURR6NrGSA
	rnBVt6FvnP4WFkk0c26OE+eq61EcGEOW7iEMZ0oUid3BmYEDHjzlSvqrooNuElF5xYIBN6
	1eY75qHTQVwr49N/0J/g1POSGVPFFLY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-YVof88_WP52yRhk3CZJTcA-1; Thu, 07 May 2026 10:25:05 -0400
X-MC-Unique: YVof88_WP52yRhk3CZJTcA-1
X-Mimecast-MFC-AGG-ID: YVof88_WP52yRhk3CZJTcA_1778163904
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44b186b715aso641946f8f.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778163904; x=1778768704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
        b=Oq37BxOoOHbOceTyj5i2vZVt5/WcPJG7tWmpXNCEdAOz9hT9C6oTHLBEEuSi6/G4qi
         D2Bs/T7gvtHgapM4sfsrZ4PqmIxjGLer30oNPWlYJ0X/D5ZgDEAJd0y/TMcMRPYzD9Sj
         gMv4vgGb8hMcfxyHnk6oGRjuvtkCuz0FSa6swGhWI9pYp+ezGycJnFwZdpTEMPPE7n/J
         Ns0Cj0e3TQfCMsIr1wzxhjZ1fYgGRX8vkaM9eBnHMYAgmMip0Z3mOG2DMlC2bGfIeFqy
         yobOSluxGTjeleTgJORYLaMl1Ad/wmmz+oHrlu9IWW7p61VYKYMG2+NXM7Oe+fjW0QDk
         GJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163904; x=1778768704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
        b=PfkcWuXynq8BHUn4TrG6IRHUd7pjdZzbMCUbJ5Q23GMMJfGoBKfk4P9Bm29QljxjtD
         I8jTR3uUmSXD9ly5TVKt28t9fPs7f1N214+B0df6Zxll3UQ2QNR1zyAMRsWBWEtwrq0E
         Fr1cV0IPhAbmZ8WSkI2R89QRMrqtBaJtU6UHvfjhrIr7uQmtUnqzP0ay7EenAxhyP5J4
         gGQrcBH90D0fDpNHqZkzFjMtIGtSRDe+RuN7ppneDhg9s30rNyz71lV5era+bbnMTYPU
         RXFQtXBMbqT2KJ+YBxAoqjxzfTyl/Td1+w1QJIJy456p92qgDSDGw09uIDcKmDqFxxLY
         84lA==
X-Forwarded-Encrypted: i=1; AFNElJ9BN9s/faMP7tKqSKrEb/ADbEiQoZerTlUNaPmRlafrz+JgO+IRMfIRg+Eufm2rYNvmkt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygL4xDyJu6XTBT7j2KzDpZVi1xORHLGI+Qku7b4D5liGRIyAzD
	153VdR/15EMgg7UnBrWyETzd0c9b3zYxnz221endodIZk+ncAvYaL7eUxc1rQfiY7p0JYhzqQOX
	YErW+niI4Dd4Buo11dlRJrbCJwsyIs+RD3nVN1rcEmty7qSZPMX1XYw==
X-Gm-Gg: AeBDieuRhP4JuCRJV78K8EY9uctJdA4Ujyv2XIjVBP1aglvtmAWJSvMnWRIGt/ww5Am
	XFZPfNqwMHjMa09LqKU86VfEvykbgYXplF9OEPtoBC8nnVIUBngFD0lP8jSLx6Zi6FldTa6iune
	tPN7/JHHEiH3fsB3Dgb+peeobVfe7GUQVc6xtXX58SG8FvN8wSoFFTyuRoSf9LyUvKSsxLc7LKW
	P89PNCVtDp4ozstzZkbafRLi3Nv8sen0T4LphCljWbIRa05h0SZobCFi40iNFd/9GNN2Q7lrlBO
	sHgNKgy/mTsIh61gIHJRoJjrcSfGN2SttH6QnlVprmGewG2tA+pC3dpd2HWt0Sk2JLV/ylSu8n1
	Gpg3zcx1CjJoEOwQmJ1+eYIw2ZxEPo9X45z2iDzqHJge4gx4sIiNIRfSRk1t4/LxfQw==
X-Received: by 2002:a05:6000:2304:b0:44a:52d5:e4f1 with SMTP id ffacd0b85a97d-4515b057373mr13747072f8f.5.1778163903168;
        Thu, 07 May 2026 07:25:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:44a:52d5:e4f1 with SMTP id ffacd0b85a97d-4515b057373mr13746976f8f.5.1778163902357;
        Thu, 07 May 2026 07:25:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm21167533f8f.26.2026.05.07.07.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 07:25:01 -0700 (PDT)
Message-ID: <295255d8-ef21-4d0e-b651-74ec1d21f51c@redhat.com>
Date: Thu, 7 May 2026 16:25:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] veth: fix OOB txq access in veth_poll()
 with asymmetric queue counts
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Sashiko <sashiko-bot@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-2-hawk@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260505132159.241305-2-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/26 3:21 PM, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> XDP redirect into a veth device (via bpf_redirect()) calls
> veth_xdp_xmit(), which enqueues frames into the peer's ptr_ring using
>   smp_processor_id() % peer->real_num_rx_queues
> as the ring index.  With an asymmetric veth pair where the peer has
> fewer TX queues than RX queues, that index can exceed
> peer->real_num_tx_queues.
> 
> veth_poll() then resolves peer_txq for the ring via:
> 
>   peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> 
> where queue_idx = rq->xdp_rxq.queue_index.  When queue_idx exceeds
> peer_dev->real_num_tx_queues this is an out-of-bounds (OOB) access
> into the peer's netdev_queue array, triggering DEBUG_NET_WARN_ON_ONCE
> in netdev_get_tx_queue().
> 
> The normal ndo_start_xmit path is not affected: the stack clamps
> skb->queue_mapping via netdev_cap_txqueue() before invoking
> ndo_start_xmit, so rxq in veth_xmit() never exceeds real_num_tx_queues.
> 
> Fix veth_poll() by clamping: only dereference peer_txq when queue_idx is
> within bounds, otherwise set it to NULL.  The out-of-range rings are fed
> exclusively via XDP redirect (veth_xdp_xmit), never via ndo_start_xmit
> (veth_xmit), so the peer txq was never stopped and there is nothing to
> wake; NULL is the correct fallback.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260502071828.616C3C19425@smtp.kernel.org/
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

This looks fairly uncontroversial, but it's IMHO net material. Let me
apply it there.

/P

