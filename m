Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11AD55E77
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634414; cv=none; b=m3hbQvj7qatc2WvxHIGEBwr2HXegMUPFSDInvMoKcZwIJj6jq3L4LPdzL26QejkNbE0Zz8R7ThBaTG3feTv1OK5XTJh/+njzQ9h/P4jlCl6g6CZy9fPni2ZjrayN0trUWPp9vC58+pIYarSac+NH5VJrD0MEIgtjyBEvp+KjLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634414; c=relaxed/simple;
	bh=dG6cdJeFfBfccQZtIz65oSMje0H+je6guWxUyn0tdRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYkGSk/OZxIBvADustGpQdbkedutGYGJMMAbiFCg5d2248lMvuGPH0PS1DTPETsCk6B3bnt7uQrRYOH8OOoeJFe3qFoorvwzDO5v/UtNHvMpgsZVbKjTuDbaSfjkjiZ32NuxVCGuM8pMww/wd+ldEuVYEuO+Pudjf9esLI63cD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMNjsDZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMNjsDZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709634411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=io1my3dx5VcMiNJUZUsb740tl0108EWYfuMDY6G7mng=;
	b=gMNjsDZK7bB7erXfHgS1+X2Wh/GqXv/zy4EP3Nkc6oTTnAkm8YwwjCnKYjr/pxUYn+kfFI
	twx4ak8gOTqvRv5Bmq3e5t0PfnSnZlp4TE8Vi7pU6vwUKWAYFrAVkHGc+yirCILnVQ7PVo
	XHG/l74AaYB31X2hnKs2IkiLH5dkq6g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-qsJJdQy0MsOa2KrpdJJgUA-1; Tue, 05 Mar 2024 05:26:50 -0500
X-MC-Unique: qsJJdQy0MsOa2KrpdJJgUA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412c9e3c9b9so19684755e9.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634406; x=1710239206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io1my3dx5VcMiNJUZUsb740tl0108EWYfuMDY6G7mng=;
        b=K5C7n1pw/lLfYose413AnLR7trIX3AtRwEb6h1uuhTdFTswL3ClzVsiD6kZtgGZE7n
         87IqIr6jboU7fyKEl4j8mNRUjutqmp3ze3om00BhaFWFbNrG5uKidi0b/vtEj6OR8Xb1
         yULNa6GIsJ3EChL/H3zIl96Wv9nXpC8U87N810C6YpcrAgBZ1V0xsvjXk7YJ7v59MvXi
         sJdEb/qpT1YCiazp7xvgyej+SenpyAlNARfEEmFAg3w7bepgwd3wMqyUvWYhC+wRprpB
         3wr/Vo0O4Ur+cyT4GV+koTmUxxUSGumE6yofrFdbqmWzpkqRyQz4GZ4BltHESHNrKb/G
         Uv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgTtocYA5FhVy9d9ocBZ7b4HkdDIiKi7OxcAzG4vh3ROsYRL+4SJiwvI1lJunQLcnDDSRVvms7d4/BcJKAkQGOUwLw
X-Gm-Message-State: AOJu0YwhQSFYdI5PgIMapQXgod5TFEbzHweaU9iiRym2tIUUV4fAdZzm
	qPTGBXC4wN0BY8c8SdULz8b0rwdWLgmT4EaGDpVTjV+YLbmHakvBFWze/8WkndgdbtdES+L6uKr
	bgf1BO2HrbERJq+bYM/XMnPhQYNmAzOwCRK4EiyGvyq+tf8wghg==
X-Received: by 2002:a05:600c:4ec9:b0:412:ee33:db93 with SMTP id g9-20020a05600c4ec900b00412ee33db93mr853624wmq.3.1709634406069;
        Tue, 05 Mar 2024 02:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETtaPEq/Qiw+Ak7Pg+x0crtRFqpR6UCq3Qm4vjMmZUeWkXfZK6yUWGGPZ7vt3r6znJAUy1tA==
X-Received: by 2002:a05:600c:4ec9:b0:412:ee33:db93 with SMTP id g9-20020a05600c4ec900b00412ee33db93mr853610wmq.3.1709634405718;
        Tue, 05 Mar 2024 02:26:45 -0800 (PST)
Received: from redhat.com ([2.52.130.198])
        by smtp.gmail.com with ESMTPSA id fm5-20020a05600c0c0500b00412e6513639sm4585523wmb.23.2024.03.05.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:26:45 -0800 (PST)
Date: Tue, 5 Mar 2024 05:26:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] remove page frag implementation in
 vhost_net
Message-ID: <20240305052625-mutt-send-email-mst@kernel.org>
References: <20240228093013.8263-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228093013.8263-1-linyunsheng@huawei.com>

On Wed, Feb 28, 2024 at 05:30:07PM +0800, Yunsheng Lin wrote:
> Currently there are three implementations for page frag:
> 
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
> 3. drivers/vhost/net.c: vhost seems to be using it to build
>    xdp frame, and it's implementation seems to be a mix of
>    the above two.
> 
> This patchset tries to unfiy the page frag implementation a
> little bit by unifying gfp bit for order 3 page allocation
> and replacing page frag implementation in vhost.c with the
> one in page_alloc.c.

Looks good

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> After this patchset, we are not only able to unify the page
> frag implementation a little, but also able to have about
> 0.5% performance boost testing by using the vhost_net_test
> introduced in the last patch.
> 
> Before this patchset:
> Performance counter stats for './vhost_net_test' (10 runs):
> 
>      305325.78 msec task-clock                       #    1.738 CPUs utilized               ( +-  0.12% )
>        1048668      context-switches                 #    3.435 K/sec                       ( +-  0.00% )
>             11      cpu-migrations                   #    0.036 /sec                        ( +- 17.64% )
>             33      page-faults                      #    0.108 /sec                        ( +-  0.49% )
>   244651819491      cycles                           #    0.801 GHz                         ( +-  0.43% )  (64)
>    64714638024      stalled-cycles-frontend          #   26.45% frontend cycles idle        ( +-  2.19% )  (67)
>    30774313491      stalled-cycles-backend           #   12.58% backend cycles idle         ( +-  7.68% )  (70)
>   201749748680      instructions                     #    0.82  insn per cycle
>                                               #    0.32  stalled cycles per insn     ( +-  0.41% )  (66.76%)
>    65494787909      branches                         #  214.508 M/sec                       ( +-  0.35% )  (64)
>     4284111313      branch-misses                    #    6.54% of all branches             ( +-  0.45% )  (66)
> 
>        175.699 +- 0.189 seconds time elapsed  ( +-  0.11% )
> 
> 
> After this patchset:
> Performance counter stats for './vhost_net_test' (10 runs):
> 
>      303974.38 msec task-clock                       #    1.739 CPUs utilized               ( +-  0.14% )
>        1048807      context-switches                 #    3.450 K/sec                       ( +-  0.00% )
>             14      cpu-migrations                   #    0.046 /sec                        ( +- 12.86% )
>             33      page-faults                      #    0.109 /sec                        ( +-  0.46% )
>   251289376347      cycles                           #    0.827 GHz                         ( +-  0.32% )  (60)
>    67885175415      stalled-cycles-frontend          #   27.01% frontend cycles idle        ( +-  0.48% )  (63)
>    27809282600      stalled-cycles-backend           #   11.07% backend cycles idle         ( +-  0.36% )  (71)
>   195543234672      instructions                     #    0.78  insn per cycle
>                                               #    0.35  stalled cycles per insn     ( +-  0.29% )  (69.04%)
>    62423183552      branches                         #  205.357 M/sec                       ( +-  0.48% )  (67)
>     4135666632      branch-misses                    #    6.63% of all branches             ( +-  0.63% )  (67)
> 
>        174.764 +- 0.214 seconds time elapsed  ( +-  0.12% )
> 
> Changelog:
> V6: Add timeout for poll() and simplify some logic as suggested
>     by Jason.
> 
> V5: Address the comment from jason in vhost_net_test.c and the
>     comment about leaving out the gfp change for page frag in
>     sock.c as suggested by Paolo.
> 
> V4: Resend based on latest net-next branch.
> 
> V3:
> 1. Add __page_frag_alloc_align() which is passed with the align mask
>    the original function expected as suggested by Alexander.
> 2. Drop patch 3 in v2 suggested by Alexander.
> 3. Reorder patch 4 & 5 in v2 suggested by Alexander.
> 
> Note that placing this gfp flags handing for order 3 page in an inline
> function is not considered, as we may be able to unify the page_frag
> and page_frag_cache handling.
> 
> V2: Change 'xor'd' to 'masked off', add vhost tx testing for
>     vhost_net_test.
> 
> V1: Fix some typo, drop RFC tag and rebase on latest net-next.
> 
> Yunsheng Lin (5):
>   mm/page_alloc: modify page_frag_alloc_align() to accept align as an
>     argument
>   page_frag: unify gfp bits for order 3 page allocation
>   net: introduce page_frag_cache_drain()
>   vhost/net: remove vhost_net_page_frag_refill()
>   tools: virtio: introduce vhost_net_test
> 
>  drivers/net/ethernet/google/gve/gve_main.c |  11 +-
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c |  17 +-
>  drivers/nvme/host/tcp.c                    |   7 +-
>  drivers/nvme/target/tcp.c                  |   4 +-
>  drivers/vhost/net.c                        |  91 ++--
>  include/linux/gfp.h                        |  16 +-
>  mm/page_alloc.c                            |  22 +-
>  net/core/skbuff.c                          |   9 +-
>  tools/virtio/.gitignore                    |   1 +
>  tools/virtio/Makefile                      |   8 +-
>  tools/virtio/linux/virtio_config.h         |   4 +
>  tools/virtio/vhost_net_test.c              | 532 +++++++++++++++++++++
>  12 files changed, 609 insertions(+), 113 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
> 
> -- 
> 2.33.0
> 

