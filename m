Return-Path: <SRS0=jDDX=7H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F49C433DF
	for <bpf@archiver.kernel.org>; Mon, 25 May 2020 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4258A2068D
	for <bpf@archiver.kernel.org>; Mon, 25 May 2020 18:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgEYSbJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 May 2020 14:31:09 -0400
Received: from smtp8.emailarray.com ([65.39.216.67]:23526 "HELO
        smtp8.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388753AbgEYSbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 May 2020 14:31:07 -0400
Received: (qmail 21551 invoked by uid 89); 25 May 2020 18:31:03 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuMw==) (POLARISLOCAL)  
  by smtp8.emailarray.com with SMTP; 25 May 2020 18:31:03 -0000
Date:   Mon, 25 May 2020 11:30:59 -0700
From:   Jonathan Lemon <bsd@fb.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        maximmi@mellanox.com,
        Minh =?utf-8?Q?B=C3=B9i?= Quang <minhquangbui99@gmail.com>
Subject: Re: [PATCH bpf] xsk: add overflow check for u64 division, stored
 into u32
Message-ID: <20200525183059.aeaepmpa5h2nbzvc@bsd-mbp>
References: <20200525080400.13195-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525080400.13195-1-bjorn.topel@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 25, 2020 at 10:03:59AM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> The npgs member of struct xdp_umem is an u32 entity, and stores the
> number of pages the UMEM consumes. The calculation of npgs
> 
>   npgs = size / PAGE_SIZE
> 
> can overflow.
> 
> To avoid overflow scenarios, the division is now first stored in a
> u64, and the result is verified to fit into 32b.
> 
> An alternative would be storing the npgs as a u64, however, this
> wastes memory and is an unrealisticly large packet area.
> 
> Link: https://lore.kernel.org/bpf/CACtPs=GGvV-_Yj6rbpzTVnopgi5nhMoCcTkSkYrJHGQHJWFZMQ@mail.gmail.com/
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: "Minh Bùi Quang" <minhquangbui99@gmail.com>
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
