Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC832B981
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562619; cv=none; b=CMYjFJQexs63kIkM6KuVS/WDE95OC2QB1mMrss5whPGkvvbFrewru+qqx74QOswbI5Ikg7tsAON89hLQdtjnOwYwZhnuD87FzXu9G8zKEh8gxWhR/Cp1OmUEkmwAivatn7pLlsltwd5tl6Kuij+RfKPdFVoZ6NpKUz9eo1tMvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562619; c=relaxed/simple;
	bh=/0I5PlNTDmo42F78lIX7rXVUcj3Vn1T+pJs/PmebPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCtKRMr9j9mAxA+njbVkkOSLG5UCK2SDQxj/nrfPeDqyuUJb7pkdqPAPK9ttFIOKEGIe6954P9HTofAwllQ+gBrEO3AXMmKWOkqxi2v3Xp6oXs/CF/J0JeEoGu6vIBmT6H47dfooC5dWIuB3zbmLQYghsQpkQ/u4n3kDyUcm3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HheJeDSZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiPjsoJz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HheJeDSZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiPjsoJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774562617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
	b=HheJeDSZXc+D2HUtSd8Ne+tBU418qwkpfwGl5vY29faBCl10gqqdA3rbsG87WwS9Ef50PI
	5n3ZFahDU6x9KhqFl1x7OASUwTCYsk45NDP7nc2NmJky/1SiBTokdg+a8fxSZH+nnOpX8b
	0iWFGrTdHIXiyQi47kW6ywaQnJqIhuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-e_ex5nZGNkCSIx3YxRbtWg-1; Thu, 26 Mar 2026 18:03:34 -0400
X-MC-Unique: e_ex5nZGNkCSIx3YxRbtWg-1
X-Mimecast-MFC-AGG-ID: e_ex5nZGNkCSIx3YxRbtWg_1774562614
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso11769295e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774562613; x=1775167413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
        b=eiPjsoJz10dXgxEAcpTuDqkDtqydJOTYGojrrxbVhxYA0GcO12tv70RlsMbeWavyvs
         wE7k8Pvrq/4CJagj9Wmt+KO8n1ZGCNNM6LrqoxiweOqf9a+3yyQyw72sU95EmiEN8Oz1
         WLGHBUBUBZuJJ05cxVdYhZWM89XueTwqnbmLmqhfrlq0JfohgYb2DnlosWotj6YfUrWK
         TZsMi5I7AYxzQsVi9ug32CUIaeLakfh2U/TKBUvPi8ILfUW1ktDqnvPjTXxDQf4aJXMS
         oAptCpjHe9/YGN6sMcbKo2+MEqJHB5bhwYOzYaJF75fgffd8NU3kf1oNNYbTrnuAc8bw
         1FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562613; x=1775167413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
        b=BRJvEU/y1t/7KCBu8sEnZ+RWx3mPwgnq0vDph8iAlTPhziepQ7DdZmielz/cMwVh+C
         oMRnu/Z9GiVFfO9QynfwgIBp5G18q0niLzH6iRQcCOitA70XzqgMQT0eYfCepSBHhD0H
         nJAQTk+cgeZK03huhHu2yEj8Q5eDJw0zgv+u/u0LoApre39q4Pa5gzkVQrFC9k1AP4uu
         6DV9hpBnbTxiZbKXUdrfj0pVpj79R/nv5Vmf0CjbNzp/OBVWEAfaO83Y/NpWGywF+zcC
         QJa7PoHMc5veaaSd3ZVPPZrPq5a4vhyc8IJ1Zqt3DrZ/L7b2cbaxVd3SQJctv+MH85lw
         PKPw==
X-Forwarded-Encrypted: i=1; AJvYcCUvmR/ep88+WAuHCaghaM9QgC8lXnCtqVDjbg74V2GVI5ecnuS/tGleztt7miRwV1XtxNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0xO8tieJ1AjLFE9Kelg6vsGaXTxXR3nnw8nF/h5XyipkJpmD
	TCXM8I8TKQm2gjpdH+cgHe1HxpN6+Ev9gH6Vn9vxRByBJYx13z5BwKMK66PYAMFGXZuCMCh4hJ3
	YP9caubiv9it+U4tBngDgeLXRsDyChDkA1e6jvTRiejYaWKvSK5e4BA==
X-Gm-Gg: ATEYQzyUDVPt/GappssQZN+ucWo4qFzj95hNELxY97tRHWarpWHlti/jeCsopZISF0P
	limVfxWXwoY2ZUW0r/KFUzVi8MM2dMT5IajA9kpNZhX/SfwxcxRsD23yG5d8CaqKNGbyjYEhRAn
	N+ihY7dvPutQdY3tCGUO39dpl3ySEZVOzIGVAfF+vFQ1BpWC9s1W54IyVFK41nKcbDh5iTkKgI2
	6v02SVgr2PVhsSHWQQf81B6TTsoa63fTAp/9hxCLajgEQ7Ladeii5B4Kpm9Y2WEY3aDXLH7NVSv
	DkBpaE+fuzo+1QjQltZCr332iGbsyHM7nrKFq/1sgjf59u4rUJCcBex0R/uVxRRbu+IKqCGYdCE
	xYNN4aScYDM3y1sx+
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643865e9.1.1774562613597;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643465e9.1.1774562613107;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm90811505e9.11.2026.03.26.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:03:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
Message-ID: <20260326180313-mutt-send-email-mst@kernel.org>
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
 <20260326181736.GV111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326181736.GV111839@horms.kernel.org>

On Thu, Mar 26, 2026 at 06:17:36PM +0000, Simon Horman wrote:
> On Tue, Mar 24, 2026 at 11:15:54AM -0400, Michael S. Tsirkin wrote:
> > receive_buf() reads the virtio header through buf before
> > page_pool_dma_sync_for_cpu() runs in receive_small() or
> > receive_mergeable(). The header buffer is thus unsynchronized at the
> > point where flags and, for mergeable buffers, num_buffers are consumed.
> > 
> > Omar Elghoul reported that on s390x Secure Execution this showed up as
> > greatly reduced virtio-net performance together with "bad gso" and
> > "bad csum" messages in dmesg. This is because with SE sync actually
> > copies data, so the header is uninitialized.
> > 
> > Move the sync into receive_buf() so the
> > header is synchronized before any access through buf.
> > 
> > Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> > "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> > path to before memory is accessed through buf".
> > The result and the commit log were reviewed and edited manually.
> > 
> > Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
> 
> Hi Michael,
> 
> The hash for a patch with that subject in net-next appears to be 24fbd3967f3f.

Thanks, will fix in the next version.

> > Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Tested-by: Srikanth Aithal <sraithal@amd.com>
> > Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ...

