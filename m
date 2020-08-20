Return-Path: <SRS0=CWvS=B6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46FC433E1
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 13:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F1F22BF3
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 13:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj2yvMpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgHTNRS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:17:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729664AbgHTNRO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 09:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597929431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUsWgJtzCWl4vI3kssiyw/tK9ufRzzCdj6MkZUNtJZM=;
        b=Cj2yvMpgzcGzFPxOwa8ggc5LLwRgnvpuso72OSxepQvHzMzfQyKmEWoEQ34BK2iJLSinLN
        bk97dcgGZfl5NeeYv/4EzCYkqIouNuAmO8QIk8HbA5NT3pRgoF7yciA2wPslP1qGuwHfVK
        MxCflDhwsdmVkC/s40/F6jC7t7t5AQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-eb0KLz7rNeKKTKic23c18g-1; Thu, 20 Aug 2020 09:16:55 -0400
X-MC-Unique: eb0KLz7rNeKKTKic23c18g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D9FA1DE07;
        Thu, 20 Aug 2020 13:16:54 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3103016E25;
        Thu, 20 Aug 2020 13:16:45 +0000 (UTC)
Date:   Thu, 20 Aug 2020 15:16:44 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org, brouer@redhat.com
Subject: Re: [PATCH net-next 0/6] mvneta: introduce XDP multi-buffer support
Message-ID: <20200820151644.00e6c87c@carbon>
In-Reply-To: <cover.1597842004.git.lorenzo@kernel.org>
References: <cover.1597842004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


General issue (that I think must be resolved/discussed as part of this initial
patchset).

When XDP_REDIRECT'ing a multi-buffer xdp_frame out of another driver's
ndo_xdp_xmit(), what happens if the remote driver doesn't understand the
multi-buffer format?

My guess it that it will only send the first part of the packet (in the
main page). Fortunately we don't leak memory, because xdp_return_frame()
handle freeing the other segments. I assume this isn't acceptable
behavior... or maybe it is?

What are our options for handling this:

1. Add mb support in ndo_xdp_xmit in every driver?

2. Drop xdp->mb frames inside ndo_xdp_xmit (in every driver without support)?

3. Add core-code check before calling ndo_xdp_xmit()?

--Jesper

On Wed, 19 Aug 2020 15:13:45 +0200 Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Finalize XDP multi-buffer support for mvneta driver introducing the capability
> to map non-linear buffers on tx side.
> Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer to specify if
> shared_info area has been properly initialized.
> Initialize multi-buffer bit (mb) to 0 in all XDP-capable drivers.
> Add multi-buff support to xdp_return_{buff/frame} utility routines.
> 
> Changes since RFC:
> - squash multi-buffer bit initialization in a single patch
> - add mvneta non-linear XDP buff support for tx side

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

