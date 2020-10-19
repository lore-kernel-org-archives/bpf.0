Return-Path: <SRS0=px7A=D2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8C8C433E7
	for <bpf@archiver.kernel.org>; Mon, 19 Oct 2020 19:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE058223BE
	for <bpf@archiver.kernel.org>; Mon, 19 Oct 2020 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603134903;
	bh=6QniT4qXChIvKKNDNwlUnu6lz7YkQMzpyMNXjiuZXIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zdKV84CZ9TCJ3zmX86uPx6ainBdQKWDO9s6IiRkm8yJmnNY3hTP0ZdNrBVhd07zUX
	 4SN9m+iOYiXt/XQVaXpHI4byoCf8s8Gd6CDjakd2dlyfIjOX94kPeVA9mbTTpodhCL
	 VwgWhGuCrURMxvtRjpTRi4WzY8twd0637EkoLpjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgJSTPD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgJSTPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 15:15:03 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF7E2225A;
        Mon, 19 Oct 2020 19:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603134902;
        bh=6QniT4qXChIvKKNDNwlUnu6lz7YkQMzpyMNXjiuZXIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kidTgzSaXLHxw2frYOhHEq41zzvhp17vHGUeNGPIexRB4ao7oRZxvsowHpN9KRt7e
         kEL/+PlOhmVyGOrjPhD+e/qM6g0vZtrjjB2cB+mM3UTw4b//cpiE7H6OqPgLgYc3P8
         SX0oYfulUxTd5xe1scOJvW6OSrKNUhVj7VgWQOX0=
Date:   Mon, 19 Oct 2020 12:15:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net v2] Revert "virtio-net: ethtool configurable RXCSUM"
Message-ID: <20201019121500.4620e276@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201018103122.454967-1-mst@redhat.com>
References: <20201018103122.454967-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 19 Oct 2020 13:32:12 -0400 Michael S. Tsirkin wrote:
> This reverts commit 3618ad2a7c0e78e4258386394d5d5f92a3dbccf8.
> 
> When the device does not have a control vq (e.g. when using a
> version of QEMU based on upstream v0.10 or older, or when specifying
> ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_rx_extra=off,ctrl_mac_addr=off
> for the device on the QEMU command line), that commit causes a crash:

Hi Michael!

Only our very first (non-resend) version got into patchwork:

https://patchwork.ozlabs.org/project/netdev/list/?submitter=2235&state=*

Any ideas why?
