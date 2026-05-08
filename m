Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908913FA5CD
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257166; cv=none; b=IG+oIu35dRUcTuIvXJMNm9a38ORiHfHMFcvp8ZBYk8CGR14n7y146q2GKhVlFlmQCrzO7WsBQOFtVMyfrvYMEMAop67FyBPf3zyFIRokNrPuWo2gTD3QmsILJdu+UHExHoeGExcXqmxBB+/eHDts8EIcYEvK/3D/uD1HYnGhzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257166; c=relaxed/simple;
	bh=uc3jnip+H+oiJSYneTaQeBj5rHlfyX/72RGhkpqkc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhQ9n1UyhMAVomV9+c3cY5b7k4ibOkdpAfa4yHUIX7AoHjbxUWe5TCg1zaBokAlRbNxLjIGslCv5HrJnNfQN+UEHgFiWyMQ+qMqXNG9eufI1mrN9c3Qj0H7GfZ49accs+lI/tJcinHtVGOm6+NESqFQ/L4kGyL3rulZtXZoST4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daEkcEoH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daEkcEoH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee7ffd738dso362974985a.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257160; x=1778861960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=daEkcEoH1UhQuK+JpnN1jrE/KdqXkddeyf858Hm0b8tLuc0/CJEGBoPTjizNAgLnIA
         vhElmBKzNi8+wLbmNYYtHbu+EARdyEWCwNGFdn5GUwIA1oqD+D70Vwm+Lhnv9KMuM7qs
         27/p7UZFnH13LGY0bIcihBOBsfMmoJXDhKsETkXEEvCiT1BCgmg6HQ0bVc7cDstTDk02
         X0KCPgEpGzQs5gCSbVgBC/eI+DFTK9QDmU0K19YQDem3IPv9FR3gJJYJAh4ePtUn/d3A
         qE//px4aaoaZM55Dytc/NGh/AwIPe+6myMJSgx9S/W6O8frsgCGgKflLJMW2NzOuzJhV
         qoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257160; x=1778861960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=ocln5ge8mC4cgdgEmVmqtW/26f0ifD/o0CBbIsQuRXApQSGv5idj17+X3sy2E5kle4
         tk05gAhHHTC3CYONjlGoqscXnAePXeRy6GR4oASOP2Bv4zHQqVJYe0NqylptDcOqcb4y
         dTMUQ55U6UmnNclKl5s/8Pid3skApYHVVgXNR9XIZM3pYM3FuP0lrLM8hky4gYvEvD6z
         hnM7b0d/7UA0iRw974zXbJ0+4rh1rxer3MU+V7AVZ8t/pJJ6jkgr7oxvLaEZgcxlW4Zh
         VzGTy4wswv1Z+/xA/8EWv9qSfimVaiF8r3rBb7E4SAIOQfgroslbxGLZXzYUwS0kI83b
         jSMA==
X-Forwarded-Encrypted: i=1; AFNElJ+n8ecSykc0KuB9owIyOb+amLV3u84OcrmniW0WeOct1mx9LwzmDe6fotySqylE53b2m9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vSf0d6mDfSdtfTepcIaiGgSGkuRzmNHDTR9ts5EcxAi8TB6t
	fAyhX75iKkU3T4hroojukoE3YYWZhvMUJARBsMMUaGmqFT7gTVtsgeSr
X-Gm-Gg: AeBDiesQTBeQQLT378PZbCPm6rIpWn8/PEy57YTUTUQKO23U6/cJnV9+HAAmzVByP3Y
	R6hzOo1BB66ThvzWg7c8U6tR0bKG+7B/7tr37pl1kTB1yhAKT4VVrbLesFwYujVqB+r8peMEwEP
	WszcsfsoJ9xGfbAcGjf/1fldpiFYupx2K+xziCYliZlgTH35EiB2Hc0s6abK+vfzrqGoiyhIKKw
	yLZmckXLQbp3doWdWOlHPwxV1nQzj8VnOamGlB/ReOtWx+pu/cWUSiVS8OvR7esCb5NwQkvaEm0
	0fTsYVJNchkbPZ+4XbKW1//w+JF0PY/AqZS0ewxBzuqiTIt+b4i13+VMjpx+oJao+jvCuiRZnHU
	StSmBwkbdWfubdzoCq3xwTzkKW3xzr+iN8RwEYRapm++9QMDSqOteKfS+SaV9a9kfRfX+1Xfwz+
	QbCYqOZdjJ1V3n73gQweMvdcTTF/O2GLQ1J+9lVCHrjmu8UWp+VFrr1yw6RA==
X-Received: by 2002:a05:620a:4554:b0:8cd:94f9:1bc5 with SMTP id af79cd13be357-90650ef5401mr1076760685a.12.1778257160389;
        Fri, 08 May 2026 09:19:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:1b::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm228049085a.4.2026.05.08.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:19:19 -0700 (PDT)
Date: Fri, 8 May 2026 09:19:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af4NAebQLJbdCB6p@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>

On Fri, May 08, 2026 at 08:01:17AM -0700, Stanislav Fomichev wrote:
> On 05/07, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > When a netkit virtual device leases queues from a physical NIC, devmem
> > TX bindings created on the netkit device must still result in the dmabuf
> > being mapped for dma by the physical device. This patch accomplishes
> > this by teaching the bind handler to search for the underlying
> > DMA-capable device by looking it up via leased rx queues. The function
> > netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
> > device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
> > devices in the future if needed.
> > 
> > Additionally, this patch extends validate_xmit_unreadable_skb() to
> > support the netkit case, where the skb is validated twice: once on the
> > netkit guest device and again on the physical NIC after BPF redirect or
> > ip forwarding.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - Fix validate_xmit_unreadable_skb() bug for non-devmem
> >   unreadable niovs (should not be dropped)
> > - Major simplification of validate_xmit_unreadable_skb()
> > - Fix prematurely released lock in bind-tx handler (Jakub)
> > 
> > Changes in v2:
> > - In validate_xmit_unreadable_skb() to check netmem_tx mode before
> >   inspecting frags (Jakub)
> > - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
> >   netdev to fix lockdep (Sashiko)
> > ---
> >  net/core/dev.c         |  3 +++
> >  net/core/devmem.c      |  6 +++--
> >  net/core/devmem.h      |  9 ++++++--
> >  net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  4 files changed, 72 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index fbe4c328a367..268417c9ef22 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
> >  	if (dev->netmem_tx == NETMEM_TX_NONE)
> >  		goto out_free;
> >  
> > +	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
> > +		goto out;
> > +
> 
> Since this is a good case, maybe fold it into skb_frags_readable check above?
> 
> 	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))
> 
> Otherwise it's a bit confusing to have:
> 
> if (xxx)
> 	goto out;
> if (yyy)
> 	goto out_free;
> if (zzz)
> 	goto out;
> 
> (or, reorder to be out/out/out_free)
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Makes sense, will use the combined conditional.

Best,
Bobby
