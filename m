Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A742C6A9
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598592; cv=none; b=J3BSO/yZeast95K7kcBjcGuTqPaNyVJgszZXlJJt+SPZM1ZxdCDP7rTHRTEXoz5GkVw13ftdqd+soaQztt8ztRHyuQzYvcsnLqwJF8sn/i/8/OTEQUiQ6apbZzlBNmOchYtcTZeT5XWh1zfdeZA7CM3lf9Z3lg22YlhdO+xCxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598592; c=relaxed/simple;
	bh=MA0vU3W1LZn4Qn1ileNbbCmxahwffPLbnt6IdvVY1DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZdmNWaX6qmMCXk6zCFDo8fchpfRvWMdSjidA+IrHpN6Ur+YvnBtetwiGf/vUNFJQFZOYLnpgtW/MZJRDHKFSioHlytHj0jxB0ZQDYBwlfkiVvyeOZQTag8IPZVR7PEJEE3lfUEfKKb1Ep//FGe6Om+XgGU8RDbuICibnYwD7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqWwDxwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqWwDxwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711598589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
	b=NqWwDxwSYGuV5Cpq6ssZRGnCZWSLZ7qYFHuTugIF1K3svlIfpHC0xL902wfSZ7t3rvwatu
	QT6K0MZScf8F9F/MlLw/4lks20Rm+xgSgwzzgvIm8jJdRz5RSvtm4XlEyL1n7Z3IegYOHs
	X3rAUkmHn0OCPvlCMWR1MH/wrvMq7zM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-MXkoXS9VMumszjbrh9Kehg-1; Thu, 28 Mar 2024 00:03:07 -0400
X-MC-Unique: MXkoXS9VMumszjbrh9Kehg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29df71a709eso473127a91.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 21:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598586; x=1712203386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
        b=lJPa0dZMFNzrZiQyTue2UWS1QhqerKWwBpkKiamjQv3AA3FYPHT4dw7JUAXnYQVeRH
         29eTEZsZUec9mG680/omdzcXcdjG40E7AFDkMTOOtjTY1IBoao/7GzR8h3C4b2Y/Ayeo
         zNRWo+90JvWFv/sCfmIZm47rLpDRUPXu63Z6qeMH730Ason11q8vRejAnE6oWAw9+i1s
         0NG70WtUgXGrHD7ga6jRSi1qeeQI668q4gfD9tZ7Ji6OZ1qLVljl444l3A/3Y7tLlR0F
         SHC1utgaaxLJGho2/p/IA/wZA+GZS3OuLaSCClg+DbBZnn81aduZUe6if5vnAbIyeaVU
         11Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUkYRyvZxP3U8RsByJFFWWWUxlf5uR+9jeT+HiYjJfe+XvAA1wJq7oIPEqCBEwrGcmbZSyn0HnBP72KmbhH4blip7Cj
X-Gm-Message-State: AOJu0YwZqJkOU9/ZiQVdzfbTTeTIzu/f54EfXGIWAG37IUck+87uQZVn
	ubpVdL8v+C5ftLiDYSiV2LNodztoPBgHYRLNJxu+0lD03vqSlvRnYehPP2WTx/LtIwW5d3rMPb0
	YtGK6PwlsUREt5QAOVpP2dMp/GBPKiVLRf/1FR26F3NOusEpA3mclTIrJ//Eoj19OARdPMuuOhZ
	MOdgfeQ34AnRGRFbC7SVcOnqb5rV9txKoW
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id em10-20020a17090b014a00b002a07815dd25mr1734995pjb.20.1711598585819;
        Wed, 27 Mar 2024 21:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/veJ62gWCxJH+rJXD0BAZFk49zg7RYhlAQmbs4vW7XEiQGECvkaoiOerml1BopvTt9smdmlPuOr7dLI1u01k=
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id
 em10-20020a17090b014a00b002a07815dd25mr1734975pjb.20.1711598585557; Wed, 27
 Mar 2024 21:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327231826.1725488-1-andrew@daynix.com>
In-Reply-To: <20240327231826.1725488-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:02:54 +0800
Message-ID: <CACGkMEuW8jLvje0_oqCT=-ih9JEgxOrWRsvjvfwQXw=OWT_RtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:44=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
>
> Qemu options:
>   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
>
> From security point of view, wrong values on field used later
> tap's tap_get_user_xdp() and will affect skb gso and options.
> Later the header(and data in headroom) should not be used by the stack.
> Using custom socket as a backend to vhost_net can reveal some data
> in the vnet_hdr, although it would require kernel access to implement.
>
> The issue happens because the value of sock_len in virtqueue is 0.
> That value is set at vhost_net_set_features() with
> VHOST_NET_F_VIRTIO_NET_HDR, also it's set to zero at device open()
> and reset() routine.
> So, currently, to trigger the issue, we need to set up qemu with
> vhost=3Don,vnet_hdr=3Doff, or do not configure vhost in the custom progra=
m.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

It seems it has been merged by Michael.

Thanks

> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
> +       if (!sock_hlen)
> +               memset(buf, 0, pad);
> +
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> --
> 2.43.0
>

