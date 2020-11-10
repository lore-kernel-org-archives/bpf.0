Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2F6C388F7
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B772068D
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 15:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAPd+7NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgKJPvK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730511AbgKJPvK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Nov 2020 10:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605023469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDr/FWtrTa9HKAmwosECowEMGz8qOFd+0pwrTZUT0Ng=;
        b=RAPd+7NZxhWYw/r9Ro1wGzQfhqGEpQvEEen3+ysPurzsivX0VqTH/bBQjjkx7FehN5lRsw
        FKcciLAMmdvWjucsfCARI7mUeru2sZOxwmPsNb+HjN8koEV3bWka3kk/BrsZRjfImNaYAX
        MGF+Q6L6DDefNpJ8gVzoEHD/YNSwGSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-vaW9AOsvMkuvGkbWdbsyOA-1; Tue, 10 Nov 2020 10:51:06 -0500
X-MC-Unique: vaW9AOsvMkuvGkbWdbsyOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8ECE1019626;
        Tue, 10 Nov 2020 15:51:04 +0000 (UTC)
Received: from carbon (unknown [10.36.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA7710013C0;
        Tue, 10 Nov 2020 15:50:53 +0000 (UTC)
Date:   Tue, 10 Nov 2020 16:50:52 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, lorenzo.bianconi@redhat.com,
        ilias.apalodimas@linaro.org, brouer@redhat.com
Subject: Re: [PATCH v5 net-nex 0/5] xdp: introduce bulking for page_pool tx
 return path
Message-ID: <20201110165052.4476c52b@carbon>
In-Reply-To: <cover.1605020963.git.lorenzo@kernel.org>
References: <cover.1605020963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Nov 2020 16:37:55 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> XDP bulk APIs introduce a defer/flush mechanism to return
> pages belonging to the same xdp_mem_allocator object
> (identified via the mem.id field) in bulk to optimize
> I-cache and D-cache since xdp_return_frame is usually run
> inside the driver NAPI tx completion loop.
> Convert mvneta, mvpp2 and mlx5 drivers to xdp_return_frame_bulk APIs.

Series

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> Changes since v4:
> - fix comments
> - introduce xdp_frame_bulk_init utility routine
> - compiler annotations for I-cache code layout
> - move rcu_read_lock outside fast-path
> - mlx5 xdp bulking code optimization

I've done a lot of these changes, and benchmarked them on mlx5, details in[1].

[1] https://github.com/xdp-project/xdp-project/blob/master/areas/mem/xdp_bulk_return01.org

> Changes since v3:
> - align DEV_MAP_BULK_SIZE to XDP_BULK_QUEUE_SIZE
> - refactor page_pool_put_page_bulk to avoid code duplication
> 
> Changes since v2:
> - move mvneta changes in a dedicated patch
> 
> Changes since v1:
> - improve comments
> - rework xdp_return_frame_bulk routine logic
> - move count and xa fields at the beginning of xdp_frame_bulk struct
> - invert logic in page_pool_put_page_bulk for loop
> 
> Lorenzo Bianconi (5):
>   net: xdp: introduce bulking for xdp tx return path
>   net: page_pool: add bulk support for ptr_ring
>   net: mvneta: add xdp tx return bulking support
>   net: mvpp2: add xdp tx return bulking support
>   net: mlx5: add xdp tx return bulking support
> 
>  drivers/net/ethernet/marvell/mvneta.c         | 10 ++-
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 10 ++-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 22 ++++--
>  include/net/page_pool.h                       | 26 +++++++
>  include/net/xdp.h                             | 17 ++++-
>  net/core/page_pool.c                          | 69 ++++++++++++++++---
>  net/core/xdp.c                                | 54 +++++++++++++++
>  7 files changed, 191 insertions(+), 17 deletions(-)
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

