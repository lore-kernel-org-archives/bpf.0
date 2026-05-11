Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5E44102F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518897; cv=none; b=je3Cfjeq2MrC/Qp+/EgUYucD1ofrXJdeaLfVmAuoNE06eSkjliNDKojme0de0c7ejgXlikOgIUFgwfMImDFTqfSuewQOBbN/WtypFvlwGEc24g6UM4IGt0zEpe9tx8r/jFP5QGpg4XdKUT/K4qWYXN3JopjKkfigp1rBCcJmLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518897; c=relaxed/simple;
	bh=PE7CfPDlkT2wusrx9oi+uBa5B29abPzYTNGdV9PEKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5dKnteaIyqiabdouHQ/lLrVE8BEIaG8NELF/Vx/zj/RK/oJr1QqhtMcpK6nF5kMl8YNM4oqJZzJ+czaXTBSvSUInsK00FWQS9r/uCEvkMN/FbAe/sPKPlFz1MR9q7NsBKm1AZUXvMJVoSKNYFdCSdsfC8F2+Hg8zhZjaUHQypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bob49sCb; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bob49sCb"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdc947aa88so36509647b3.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518894; x=1779123694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xawfXJfKqmeoHeOoXubh3qn/e0+i/yH0+NUj7NVoCTE=;
        b=Bob49sCbsvWdsGg5Bo0V+IiPmAZiZXom4ahxqCPEjCxWuTBugBnA/d7dnO89SvIAZE
         XE63XQYfKmnSaTB2jQLDvD9F2QkP1qBT4NIvddpVZ3vqoMIfuCkhyqt5rzRuAcUMQRqB
         5Eg4aBn3G2Vt4/StQffospDOP3HzyKAaBAYhvlDKRvDcZJMiuhhMDv2XnleLIYPqB2yD
         10b4bwArDx73qG5NmxFYv0SQdPrQFRlZPmucCRjlD7LNZplTqWjhlDsBfKSGspd5Auvl
         d1fjhxQUffsK1y/D0WXwSMvgUIItrRlqV9IdR8Q5jncDIFxekDh7lqchNXhK44HYuJkN
         ebWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518894; x=1779123694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xawfXJfKqmeoHeOoXubh3qn/e0+i/yH0+NUj7NVoCTE=;
        b=HU7fTDGV6cZWQiEVfnC3r0zO3MsRUOYr1AEwGz434tYinYWfBzaMM/B1TG2SP3morY
         bUxxDitfd5Dp9Wro5rHME3sO1mMfKHwJXRtpUe1a1Fi1JeXdX/sPviErEIreX8iTxOBK
         4y1/UC1OpnIHs7aSyI1bX9VSdzUv7jK8pGhOEVbKCvdVE4nkjXeA6zfMq8tUjn8LG0/S
         xR7U2gskwPSmhutvZHpU2CKZcYP/UXnzSqMX7Z8CyzOGGJJrPChKkUJrNUfUGI5l6gJt
         JWFqzD4IpV1umnTPYnLbWwXaP10/8yh0a/OfBYw/aZJV7L4lJqWTHYG7UvBTA3Q6cBCM
         cq8A==
X-Forwarded-Encrypted: i=1; AFNElJ+XotNTZ4hY9XJXdeWxLVLNSWC3YquXbiNvGAcCKtSTTmVsVBzwIqZ3ozjEurTmvYoca9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3PGONLDSOPly9JwQ4ZToxLXMlJ8/v29SWQ/dIFVRoiO+5arM
	0xdiMf96yOM9txowN22sjkmde6pFcCPGeWtrJjAK54YhUEYSxB7+75ol
X-Gm-Gg: Acq92OGUIE/q5EU10gDXDtJ1VuYfe9tqZZp92Mg0G/Iwa2OD8LmYfzv1wRClQjaIzC+
	TOY/oO865lATSzQQujF44GeQV0Kve5CcUM3+3s/A40Ec7ph5OtHyljvLrr5x3v/Yg8rOIG2QuWZ
	VFmoCeRWaSjFcreztYwTl0sIWZxv8yW+ZfOLRKRCtWyl5TZkOUqKw/4ZIlSR7lDEKDE/VCY5PP3
	lRlLfbbSSNCXYaVz4xJIzL6783ER6Y6+co2CpXgHFKrdUq97S4n1tJl+TaptsiV6UimZwcIvn9I
	qCpU8Ymn4Tih4meFX0PwCKhu7FTI/zqc85XRU3X9SF+VPMsPdB5F7XZiQYtQDxGHhysVmh5mkMc
	uf6/7skyxJsVqS+iF1Xb2e+UmUrnuzn+iYvEA1mOlKNOtQ6VmGj+jqezpOd/qB99azUptTYI0MV
	FM1G2CqsbQl1bRrOzNnDkKUKVEZwctIHP8abWIDDwbtNvHII0=
X-Received: by 2002:a05:690c:e3c8:b0:7ba:eefe:9fa1 with SMTP id 00721157ae682-7bdf5db6952mr267368157b3.6.1778518893760;
        Mon, 11 May 2026 10:01:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm151829677b3.0.2026.05.11.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:01:33 -0700 (PDT)
Date: Mon, 11 May 2026 10:01:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 0/8] net: devmem: support devmem with netkit
 devices
Message-ID: <agILZaYTrRBlL+Dt@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <d7de2f17-af2d-4b6a-be65-f009d78e3d20@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7de2f17-af2d-4b6a-be65-f009d78e3d20@linux.dev>

On Sun, May 10, 2026 at 01:33:18PM -0700, Zhu Yanjun wrote:
> 在 2026/5/7 19:27, Bobby Eshleman 写道:
> > This series enables TCP devmem TX through netkit devices.
> > 
> > Netkit now supports queue leasing. A physical NIC's RX queue can be
> > leased to a netkit guest interface inside a container namespace. This
> > gives the container a devmem-capable data path on the RX side (bind-rx,
> > etc...). On the TX side, the container process binds to its netkit guest
> > interface and sends traffic that netkit redirects (via BPF or ip
> > forwarding) to the physical NIC for DMA.
> > 
> > Two things in the existing devmem TX path prevent this from working:
> > 
> > 1. validate_xmit_unreadable_skb() requires dev->netmem_tx before it will
> >     forward a dmabuf-backed (unreadable) skb. This protects skbs from
> >     landing on devices that don't have the IOMMU mappings for the backing
> >     dmabuf or that don't speak netmem. Netkit, however, does not support
> >     DMA, doesn't attempt to read unreadable skb pages and so doesn't
> >     break netmem (it is pure skb routing and redirection). It is
> >     functionally capable of routing unreadable skbs, but there is no way
> >     for the TX validation pathway to distinguish between a device that
> >     will actually attempt DMA-ing the skb and another device
> >     (like netkit) that does not DMA but also does not break
> >     netmem.
> > 
> > 2. bind_tx_doit uses the bound device as the DMA device.  When the user
> >     binds devmem TX to the netkit guest, the bind handler attempts to
> >     create DMA mappings against netkit, which has no DMA capability and
> >     no IOMMU mappings.
> > 
> > This series solves these problems as follows:
> > 
> > 1. Extend netmem_tx to two bits, assigned to one of three values:
> > 
> >     NETMEM_TX_NONE   - netmem not supported
> >     NETMEM_TX_DMA    - netmem supported and performs DMA
> >     NETMEM_TX_NO_DMA - netmem supported, but does not DMA
> > 
> >     With these bits, phys devices can set NETMEM_TX_DMA and devices like
> >     netkit set NETMEM_TX_NO_DMA. The validation TX path ensures that any
> >     DMA-capable netdev exactly matches the bound device, guaranteeing the
> >     correct mapping of the bound dmabuf. The validation TX path also
> >     allows devices with NETMEM_TX_NO_DMA to pass, knowing these devices
> >     will not misuse netmem or run into IOMMU faults. After redirection or
> >     routing and the skb finally makes its way through the stack to a
> >     physical device's TX path, the above NETMEM_TX_DMA check is performed
> >     again to guarantee the device has the appropriate binding/mappings.
> > 
> > 2. On TX bind, the bind handler recognizes NETMEM_TX_NO_DMA devices and
> >     finds the phys TX device and binds to that instead. For the netkit
> >     case, if it has been leased a queue from a DMA-capable device
> >     already, then the bind action is performed on the DMA-capable device
> >     instead and the dmabuf is mapped correctly.
> > 
> > ---
> > Changes in v3:
> > - Fix validate_xmit_unreadable_skb() logic for non-devmem
> >    unreadable niovs (should not be dropped) (Sashiko)
> > - Simplify lock handling in bind_tx, no premature release (Jakub)
> > - split NO_DMA changes into separate patch (Jakub)
> > - fixed some pylint issues, one required an additional patch ("selftests:
> >    drv-net: make attr _nk_guest_ifname public") to rename a variable from
> >    private to public
> > - see per-patch changelist for more detailed changes
> > - Link to v2: https://lore.kernel.org/r/20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com
> > 
> > Changes in v2:
> > - Squash driver conversion patches (2-5) into patch 1 (Jakub)
> > - In validate_xmit_unreadable_skb() to check netmem_tx mode before inspecting
> >    frags (Jakub)
> > - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev != netdev to
> >    fix lockdep (Sashiko)
> > - Move require_devmem() into individual test functions so KsftSkipEx goes up to
> >    ksft_run() (Sashiko)
> > - Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
> > - Link to v1:
> >    https://lore.kernel.org/all/20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com/
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > ---
> > Bobby Eshleman (8):
> >        net: convert netmem_tx flag to enum
> >        net: netkit: declare NETMEM_TX_NO_DMA mode
> >        net: devmem: support TX over NETMEM_TX_NO_DMA devices
> 
> I applied this patchset in my local kernel tree and built a new kernel
> image. I loaded this new kernel image in my test environment. It seems that
> all the testcases can pass.
> 
> I think that this patchset would not cause any regression problem in my test
> environment.
> 
> Zhu Yanjun

Thanks for testing!

Best,
Bobby
