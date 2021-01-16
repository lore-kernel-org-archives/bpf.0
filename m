Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789EC433DB
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C3F23AC0
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbhAPEs0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbhAPEs0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 23:48:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87DEC23AA9;
        Sat, 16 Jan 2021 04:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610772466;
        bh=sQaa5GPN5Gv4P/DXXY8GUv6w6dF+8hbFXiBYPDGwgs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJVVFPw7LfSZfMAp0SK9wJUWDiVeso1Wx9UI4hlIbxR20M5bSjYmiDXPTiWrquZbv
         XFIaAh+Jcgwc7gxJhugGceyJRVZPLX2QI09QZDeLYdlrlMHtAixJLNUqKsTdj7IgSo
         6PFUdNKgyus78UiEVFQ/bxyV7oeeH4SII1Aq5lGjhYeWBjYvXL5du1IXNINqEhfE1K
         o/5yplGKyNv/p3PN7hqaMXGm51ASlthrJFUHnyzfDX/uFnTf8VcizY7m/YjzfA6O+6
         G1bNW8Mv9XKAptltavdoJ58rXNOBDT9Rn+KubFBVgVtXiZ0HjP2qYMS5Uah2XojWTu
         BOSqqkUkLRiQw==
Date:   Fri, 15 Jan 2021 20:47:44 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] virtio-net, xsk: realize the function
 of xsk packet sending
Message-ID: <20210115204744.7256a4bc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <9e1f5a4b633887ce1f66e39bc762b8497a379a43.1610765285.git.xuanzhuo@linux.alibaba.com>
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
        <cover.1610765285.git.xuanzhuo@linux.alibaba.com>
        <9e1f5a4b633887ce1f66e39bc762b8497a379a43.1610765285.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 16 Jan 2021 10:59:26 +0800 Xuan Zhuo wrote:
> +	idx = sq->xsk.hdr_con % sq->xsk.hdr_n;

The arguments here are 64 bit, this code will not build on 32 bit
machines:

ERROR: modpost: "__umoddi3" [drivers/net/virtio_net.ko] undefined!

There's also a sparse warning in this patch:

drivers/net/virtio_net.c:2704:16: warning: incorrect type in assignment (different address spaces)
drivers/net/virtio_net.c:2704:16:    expected struct virtnet_xsk_hdr *xskhdr
drivers/net/virtio_net.c:2704:16:    got struct virtnet_xsk_hdr [noderef] __rcu *
