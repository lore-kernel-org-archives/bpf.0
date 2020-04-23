Return-Path: <SRS0=ey3N=6H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810FC55191
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 02:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174EB2080D
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 02:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587609838;
	bh=jReG/6hFSabNf8SFs0tC0oc6s3RIh0vSckTOJ0ZDNDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y9QZH3dnQR7tK5L13FYbTkU2gnkzIL3IG11Q450bnQAZ3Dg9/K+VW6KCEQY1jF7FT
	 HnWbIWpT7o+Tph959jA+Tlqw9H92oM7S7ITEaaTehqnEY6Kf4X3rUDvgEh/PK2VGTj
	 SKOcgg77rYTfZ1FKEwZFDYp260gkTC7+eMMqLCHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDWCn5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDWCn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 22:43:57 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334FA20747;
        Thu, 23 Apr 2020 02:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587609837;
        bh=jReG/6hFSabNf8SFs0tC0oc6s3RIh0vSckTOJ0ZDNDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EkTmhn0baunXLdLQYbSBBbecLMjbodF5ojjkcDkAlVYvWZGqXDSh7/EmSKbqlC56i
         F9U1WTh0Hc59jaC/OWmvexAdS/sj4WT6pb2jJQJ4XvYZcQdx6rZrij0oNDxf+cQ4yq
         CGFZnNYQrFNvSwEXIfss/QPe3UcHekiCGSMKx9ss=
Date:   Wed, 22 Apr 2020 19:43:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     sameehj@amazon.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        zorik@amazon.com, akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next 18/33] nfp: add XDP frame size to netronome
 driver
Message-ID: <20200422194354.56a2db4e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <158757173250.1370371.6764469856666288155.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
        <158757173250.1370371.6764469856666288155.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Apr 2020 18:08:52 +0200 Jesper Dangaard Brouer wrote:
> The netronome nfp driver use PAGE_SIZE when xdp_prog is set, but
> xdp.data_hard_start begins at offset NFP_NET_RX_BUF_HEADROOM.
> Thus, adjust for this when setting xdp.frame_sz, as it counts
> from data_hard_start.
> 
> When doing XDP_TX this driver is smart and instead of a full DMA-map
> does a DMA-sync on with packet length. As xdp_adjust_tail can now
> grow packet length, add checks to make sure that grow size is within
> the DMA-mapped size.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
