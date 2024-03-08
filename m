Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8423611F
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877842; cv=none; b=TVOsJSpTOObwgBskhWs2L3AGupMt1+W2NPlf1D8tdJL0pENwGzNHa97DElTjAOaGoX4H4baFTqQw/sJg0UNITo8rDohv73zhkHuWFq5ejAPGUXGQg7mSW2VRR3+uaf4YX4jNQjV7L52igZ8UEP10GwJc+HWqF3GiEPjyhqEfAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877842; c=relaxed/simple;
	bh=jgt2FmcV3Yk28s1hw88s4sNZ9AfG+QarsYVdwOdt8LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mnknn6BSrFz9RjRUTC4vaWrHctiDWOX7x32UBCp4t/SxfpZ/lKVkxKqk4/uO5kvvABy567VquD1LS9hgezI7BoKQJnC02argpgZicakE3G2rEUV+fcUiAzBwdsylr3Iu9oRN9+w5Q7/4ucu/r77JFxHI8q6RdCl66xQpbDnHS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHyDNdvc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHyDNdvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709877835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaMKbz1uGEbeDlqPaWY/PoRYwRKKFpuiuv79VQFM3t8=;
	b=SHyDNdvcBdi1IeJTzTG7WgTFlZsjiJzS5kgOrgtko5vwewLQyDep7T0pvNhP0H0xSvKwI+
	WxPCFB3iIvNasACtNohOJJN+egWp3bCNdVQzpCK4BwV18xPWQY1tTpEZLrsZTqW6xYorl/
	xXWAdD4cuTzayZWhLhIY7kucBgkxc5w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-yZupKESiM0O4P0NTQpk6eg-1; Fri, 08 Mar 2024 01:03:54 -0500
X-MC-Unique: yZupKESiM0O4P0NTQpk6eg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so1318709a12.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 22:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709877832; x=1710482632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaMKbz1uGEbeDlqPaWY/PoRYwRKKFpuiuv79VQFM3t8=;
        b=cUflHXADQkcKtoNrTvNBXW4YjCuOxL25DAyHyqzYV5swgQFkT+m9fPUBx6LpEx5RU3
         NNCGVkOQOg6eIfYFZXs7RD4OryMxA4efrYf2KPxrkNbwjMlNNBey/FN7xaPmXTSDGGqO
         XSyL0RDcBGnbCuzfEUXdpGGPR+IHV/vsGDDQoK7d8WT2wD9af7uYxquM4g31BdpNAyeC
         2/k1EkXuk9wfszBowSaC37JW1yr3Ehd5BPdHL3s60UncaSGUkcHsY3fhOwtezyg4cbP5
         l7bMI4ApGf7DwK0C5YOefb45jrDxx5OtJAaO50dEdnT/ypMZxZAdMswCpCRV0EbQb12p
         uxtA==
X-Forwarded-Encrypted: i=1; AJvYcCUg+ybMqnQhoD9IUhwrn/ycSBpmU4Ms1+G4DdxGIzVN/2gVid53UIC6rMppji4RBXxU1IEQ5j6TadGQryZsdq+ZRes1
X-Gm-Message-State: AOJu0YzxxhKLnIXWCIgBSGic+Zfkq1urVBlfV49nm3bXVYM/Eh4ZcN+z
	jeQ951EBc4Rph1OQ1CBwEEw4OtT9ANrrEaxJfrU1abTLdW2f2TVbYhAWrlDKZfliKzOLpHEil8V
	9Ttf1E8q/Oex7hMR3R+GoLxvUk4haD5INx9wdxOP/C5xl3KDhG53SwQzljUI03Hm6HY/fymT/7O
	SP3VB457+mN8Y6h6bZ+0qAAzan
X-Received: by 2002:a05:6a20:1586:b0:1a0:ebbd:9ae7 with SMTP id h6-20020a056a20158600b001a0ebbd9ae7mr11552879pzj.4.1709877832477;
        Thu, 07 Mar 2024 22:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwSy+KRC/GSn2zLsN0UNnw00pTdXTREweDEIwdkwzwwVJ8XmarEUl1eSz0tZAv2yTcVHqnwoNrrIMVt2DhM18=
X-Received: by 2002:a05:6a20:1586:b0:1a0:ebbd:9ae7 with SMTP id
 h6-20020a056a20158600b001a0ebbd9ae7mr11552863pzj.4.1709877832102; Thu, 07 Mar
 2024 22:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org> <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
 <20240229043238-mutt-send-email-mst@kernel.org> <1709718889.4420547-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu5=DKJfXsvOoXDDH7KJ-DWt83jj=vf8GoRnq-9zUeOOg@mail.gmail.com> <1709798771.2564156-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1709798771.2564156-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 14:03:41 +0800
Message-ID: <CACGkMEsHTwA=9W+3QfQGxzHcgzZZ=Bi9bb4PijUJHUQmLfEQpw@mail.gmail.com>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 7 Mar 2024 13:28:27 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Wed, Mar 6, 2024 at 6:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Thu, 29 Feb 2024 04:34:20 -0500, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Thu, Feb 29, 2024 at 05:02:37PM +0800, Xuan Zhuo wrote:
> > > > > On Thu, 29 Feb 2024 03:21:14 -0500, "Michael S. Tsirkin" <mst@red=
hat.com> wrote:
> > > > > > On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> > > > > > > As discussed:
> > > > > > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cf=
LcPaVmJ3rHYqRZxYg@mail.gmail.com
> > > > > > >
> > > > > > > If the virtio is premapped mode, the driver should manage the=
 dma info by self.
> > > > > > > So the virtio core should not store the dma info.
> > > > > > > So we can release the memory used to store the dma info.
> > > > > > >
> > > > > > > But if the desc_extra has not dma info, we face a new questio=
n,
> > > > > > > it is hard to get the dma info of the desc with indirect flag=
.
> > > > > > > For split mode, that is easy from desc, but for the packed mo=
de,
> > > > > > > it is hard to get the dma info from the desc. And for hardeni=
ng
> > > > > > > the dma unmap is saft, we should store the dma info of indire=
ct
> > > > > > > descs.
> > > > > > >
> > > > > > > So I introduce the "structure the indirect desc table" to
> > > > > > > allocate space to store dma info with the desc table.
> > > > > > >
> > > > > > > On the other side, we mix the descs with indirect flag
> > > > > > > with other descs together to share the unmap api. That
> > > > > > > is complex. I found if we we distinguish the descs with
> > > > > > > VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > > > > > >
> > > > > > > Because of the dma array is allocated in the find_vqs(),
> > > > > > > so I introduce a new parameter to find_vqs().
> > > > > > >
> > > > > > > Note:
> > > > > > >     this is on the top of
> > > > > > >         [PATCH vhost v1] virtio: packed: fix unmap leak for i=
ndirect desc table
> > > > > > >         http://lore.kernel.org/all/20240223071833.26095-1-xua=
nzhuo@linux.alibaba.com
> > > > > > >
> > > > > > > Please review.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > v3:
> > > > > > >     1. fix the conflict with the vp_modern_create_avq().
> > > > > >
> > > > > > Okay but are you going to address huge memory waste all this is=
 causing for
> > > > > > - people who never do zero copy
> > > > > > - systems where dma unmap is a nop
> > > > > >
> > > > > > ?
> > > > > >
> > > > > > You should address all comments when you post a new version, no=
t just
> > > > > > what was expedient, or alternatively tag patch as RFC and expla=
in
> > > > > > in commit log that you plan to do it later.
> > > > >
> > > > >
> > > > > Do you miss this one?
> > > > > http://lore.kernel.org/all/1708997579.5613105-1-xuanzhuo@linux.al=
ibaba.com
> > > >
> > > >
> > > > I did. The answer is that no, you don't get to regress memory usage
> > > > for lots of people then fix it up.
> > > > So the patchset is big, I guess it will take a couple of cycles to
> > > > merge gradually.
> > >
> > > Hi @Michael
> > >
> > > So, how about this patch set?
> > >
> > > I do not think they (dma maintainers) will agree the API dma_can_skip=
_unmap().
> > >
> > > If you think sq wastes too much memory using pre-mapped dma mode, how=
 about
> > > we only enable it when xsk is bond?
> > >
> > > Could you give me some advice?
> >
> > I think we have some discussion, one possible solution is:
> >
> > when pre mapping is enabled, virtio core won't store dma metadatas.
> >
> > Then it makes virtio-net align with other NIC.
>
>
> YES.
>
> This patch set works as this.
>
> But the virtio-net must allocate too much memory to store dma and len.
>
> num =3D queue size * 19
>
> Michael thinks that waste too much memory.
>         http://lore.kernel.org/all/20240225032330-mutt-send-email-mst@ker=
nel.org
>
> So we try this:
>         http://lore.kernel.org/all/20240301071918.64631-1-xuanzhuo@linux.=
alibaba.com
>
> But I think that is difficult to be accepted by the  DMA maintainers.
>
> So I have two advices:
>
> 1. virtio-net sq works without indirect.
>         - that more like other NIC
>         - the num of the memory to store the dma info is queue_size

This requires benchmarks.

>
> 2. The default mode of virtio-net sq is no-premapped
>         - we just switch the mode when binding xsk

This could be one step.

We can hear from Michael.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > > I asked you. But I didnot recv your answer.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > > v2:
> > > > > > >     1. change the dma item of virtio-net, every item have MAX=
_SKB_FRAGS + 2
> > > > > > >         addr + len pairs.
> > > > > > >     2. introduce virtnet_sq_free_stats for __free_old_xmit
> > > > > > >
> > > > > > > v1:
> > > > > > >     1. rename transport_vq_config to vq_transport_config
> > > > > > >     2. virtio-net set dma meta number to (ring-size + 1)(MAX_=
SKB_FRGAS +2)
> > > > > > >     3. introduce virtqueue_dma_map_sg_attrs
> > > > > > >     4. separate vring_create_virtqueue to an independent comm=
it
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Xuan Zhuo (19):
> > > > > > >   virtio_ring: introduce vring_need_unmap_buffer
> > > > > > >   virtio_ring: packed: remove double check of the unmap ops
> > > > > > >   virtio_ring: packed: structure the indirect desc table
> > > > > > >   virtio_ring: split: remove double check of the unmap ops
> > > > > > >   virtio_ring: split: structure the indirect desc table
> > > > > > >   virtio_ring: no store dma info when unmap is not needed
> > > > > > >   virtio: find_vqs: pass struct instead of multi parameters
> > > > > > >   virtio: vring_create_virtqueue: pass struct instead of mult=
i
> > > > > > >     parameters
> > > > > > >   virtio: vring_new_virtqueue(): pass struct instead of multi=
 parameters
> > > > > > >   virtio_ring: simplify the parameters of the funcs related t=
o
> > > > > > >     vring_create/new_virtqueue()
> > > > > > >   virtio: find_vqs: add new parameter premapped
> > > > > > >   virtio_ring: export premapped to driver by struct virtqueue
> > > > > > >   virtio_net: set premapped mode by find_vqs()
> > > > > > >   virtio_ring: remove api of setting vq premapped
> > > > > > >   virtio_ring: introduce dma map api for page
> > > > > > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > > > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > > > >   virtio_net: sq support premapped mode
> > > > > > >
> > > > > > >  arch/um/drivers/virtio_uml.c             |  31 +-
> > > > > > >  drivers/net/virtio_net.c                 | 283 ++++++---
> > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
> > > > > > >  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
> > > > > > >  drivers/s390/virtio/virtio_ccw.c         |  33 +-
> > > > > > >  drivers/virtio/virtio_mmio.c             |  30 +-
> > > > > > >  drivers/virtio/virtio_pci_common.c       |  59 +-
> > > > > > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > > > > > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > > > > > >  drivers/virtio/virtio_pci_modern.c       |  38 +-
> > > > > > >  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-=
----------
> > > > > > >  drivers/virtio/virtio_vdpa.c             |  45 +-
> > > > > > >  include/linux/virtio.h                   |  13 +-
> > > > > > >  include/linux/virtio_config.h            |  48 +-
> > > > > > >  include/linux/virtio_ring.h              |  82 +--
> > > > > > >  tools/virtio/virtio_test.c               |   4 +-
> > > > > > >  tools/virtio/vringh_test.c               |  28 +-
> > > > > > >  17 files changed, 847 insertions(+), 625 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.32.0.3.g01195cf9f
> > > > > >
> > > >
> > >
> >
>

