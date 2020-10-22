Return-Path: <SRS0=V6te=D5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED6C388F2
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAA92224B
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603337814;
	bh=5ofYYOODjN2tZGYnYAxtWdG3yeXbJGezzR2GON0Bb3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VCpLFupJd3b7D4OpZxBBf9rQNNUtBctE2XQvbPjY5CaKyUXG/jBRQ/qwZ1pdWed3D
	 e+wxtAsSVyxKuaihPuZ489PWe2BnF7sNI1topeh9LsYDjcnnuxFfL/VytffOdPfU9b
	 uHiZfd3FibdhEo84ehedzuTpLHgUOa/8XDoiv49w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895470AbgJVDgu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895443AbgJVDgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 23:36:50 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C4A21D40;
        Thu, 22 Oct 2020 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603337809;
        bh=5ofYYOODjN2tZGYnYAxtWdG3yeXbJGezzR2GON0Bb3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/bzIrNXI9o7b3AhULeCa/nD51qv1ql15Am6BQf1CG3Fc++2UqkvltkP0bFHyXohE
         2aMrWfpvUaDnBRe3YAowhrXS2rQiBR+j0i0cPFczA/dxrhwX8YRfnMdez9u840xcpn
         14l1xCIDfOGkcABjTQDGUwyE4crCUlm4mvOIVDDw=
Date:   Wed, 21 Oct 2020 20:36:46 -0700
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
Subject: Re: [PATCH v4] Revert "virtio-net: ethtool configurable RXCSUM"
Message-ID: <20201021203646.62ad7c69@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201021142944.13615-1-mst@redhat.com>
References: <20201021142944.13615-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Oct 2020 10:30:43 -0400 Michael S. Tsirkin wrote:
> This reverts commit 3618ad2a7c0e78e4258386394d5d5f92a3dbccf8.
> 
> When control vq is not negotiated, that commit causes a crash:
> 
> [   72.229171] kernel BUG at drivers/net/virtio_net.c:1667!

Applied, thank you!
