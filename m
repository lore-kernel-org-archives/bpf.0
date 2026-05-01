Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB0233704
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597467; cv=none; b=XbyNlMNlXqDoBGWStDqK9ZHfv9AbVeWRoK9Ne5HQcFjpybomZ7/zhGKTPXCciiTg3B3Kpioc5ngnfAC+CmzNrPkSpaxZg9YWs9BQH42Iq/n8aLkATaqOZTFy/ugMSAtf0KWwLOMRsBxcR9ihiyHsBDqaJ5V4ZHcPwqvQYEEWmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597467; c=relaxed/simple;
	bh=/DJ7wZtMAXQCMxmN4svRwnpE9acNFiZmKF0ZopAdBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL9fEVfjZ+RBFLjKwOV4xcpavuIQvXCaEogJUE1EFKCFO1sR5XOet0x8Yt9D5aOhf2xL9y3+6GVICmkaR7yGGJsoZWPXUTEOPnt1+nOnVyM9JPnlLdecP/ykTN2TO3nVzrmebruULIuu5nUKq9aZl0sSPjEY9lF93HG6TZOnT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdLJnB/9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdLJnB/9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so6440616d6.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777597464; x=1778202264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgTjr8+nRWTJvq9pIAhCak7v+aRK5KkPsWEHGXUHTRE=;
        b=gdLJnB/90EiZQUrzVqnOJC0c+QuyxddLjlh8k7F1508n1zygl8hVdqtrShrPIQIQ8b
         gLqpZzB+9epM4kJE/vKuE/0633/enY7Z7wEwYE3eV1Xgps5aC3e0NO6RlKV0v85n2Dyx
         2oNNNgjc06o8vZCzvFeFvZ/Nu3gfFSvDqsCZU4bIv4k0n7p+H/OucOVw6lXQhL1wbgAY
         gGyBdHfQjpcOV7zBiG4Hc8bJY23bQulj2jNReUlvMBxY0ro/XWViglGMrDBVGzNXe6ph
         V2/TqJ5AXddlJEoYTEsUXNHc22vKL0XlaRGOSy6RccIrlU8tStcC1JfbQPjlHQm2oXZ8
         0K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777597464; x=1778202264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgTjr8+nRWTJvq9pIAhCak7v+aRK5KkPsWEHGXUHTRE=;
        b=Ohu6WNeHQNqt9w8+1m+qSD7rNc5LFmLVMLSBPkEh/MSKeZ0y802KI/qsoZX1sqNEfM
         Lsc++I/of1aaps3FOTcJWO6P5xhrcSGM04yeDl4O/HRzKSRej6HqKsM4trCF9P/ht7uQ
         S/SRqKUUp9rLcn6NhPsKy6WYwxkePHPVgutKmbwLagChYHK5DGsRnVZbZTNqG751OupD
         UmViZxyQXLjgvgDa72cjfaVRXaiuEFopSKgf0j+QJ29wgC2aTlrShyqGotjjrxgNX5mi
         /SfFyOG80AqHRxlfiBI4c0YSxQTU0cTReDTsx6J4rAozNShzlvXl4MtfDq3O0QtsxmAZ
         n16w==
X-Forwarded-Encrypted: i=1; AFNElJ/qntnjjbTjnI8XTVxGBoMK+MChQurdITw8zVDhDZQXgrq2QeTZycpzi4qf1xroqV1+mkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YgUtkYzIRYKeNqfOcBWA4NouuWqGKILOJDzabLhH6+ODMQMN
	J7LEdyEBkj676CVBxZkBWVGRUBPKCkQQWcfFbiU62/ck5fRzF6CAJi1+
X-Gm-Gg: AeBDies203AgSLD5Z+bK8xW1we9FCBgp1X5RTpAhNXO9fyF8gB2iLAoo9iT8mOMucHr
	3g22oqM1bu5+C0+43c6VuI2rahtwrUdB164vtZJZ9ALnLl4cCBVf238hZUizh4QNsVFU6/m657u
	gU15bsYWLRhffsgznpek2cgkI1Yy482Q++IKR1jp/jmnhzIq5TmnI39bprrlFoH2ePt3OjiQ9xm
	Z4YgboSNh7k0NnJPLrNxu0zrltCVZSzrcipVq8wbv/eGSiv8QG34JE1UwxMVhzNbv34onscINaQ
	fbg85WcfkCSAIMNGb6JjBL29qT0/HN3K5ZeYyc9LvIXqLSCZuqmgfxaDtI+vQ7w4KP3ICrSH6xy
	w/MjMl9P8N/oDSjKKfLG9pddQ30uqdCfnyvWx/nvrdzYTAZzco+6KBbtDA73it01DrKGvjK8sG7
	I3OzxXNdc0drMF0u70d8KBqdlC5FZoIPzYBfssdU3ekgW7G4EjsdL6jZNJ6A==
X-Received: by 2002:a05:6214:4710:b0:8b0:2dc3:319f with SMTP id 6a1803df08f44-8b544de5bdcmr13924316d6.2.1777597464476;
        Thu, 30 Apr 2026 18:04:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:31::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm7643106d6.46.2026.04.30.18.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:04:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:04:15 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <afP8D4RUPRKaOS7Y@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <20260430175945.476734ca@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430175945.476734ca@kernel.org>

On Thu, Apr 30, 2026 at 05:59:45PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 15:41:57 -0700 Bobby Eshleman wrote:
> >       net: add netmem_tx modes that indicate dma capability
> >       net: bnxt: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       gve: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       net/mlx5e: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       eth: fbnic: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       netkit: set NETMEM_TX_NO_DMA for unreadable skb passthrough
> >       net: devmem: support TX over NETMEM_TX_NO_DMA devices
> 
> I think it looks reasonable over all, but the assumption that rx lease
> implies tx queue does not seem great. Sounds like Daniel has that part
> covered tho :)

Indeed, with TX leasing this becomes much nicer.

> 
> When you post v2 - you can squash the driver patches into patch 1.

Will do!

Best,
Bobby
