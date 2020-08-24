Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2893C433E1
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A386220738
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jqb3NZZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgHXIpJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:45:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729195AbgHXIpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598258698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amlNRwZzjLO8LRoaaNfqHXc/ssKxKn18rqfsvwULgxs=;
        b=Jqb3NZZZGUvK+GTDxTGnVDfDVmtVPRc1uhxl40yHsEG24UQ3TB0kFBlpbGzT4EhxnLgixN
        31B+elIcJJpHZ0mjsrRU04vfP5tN/mDumzA6/KAeOclfV7WhtEVXPMef/s5/x38WtYCj2P
        6XoV+iumy98gyfYsLmv42m7zrE2ypyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-q5Pr61WHOHa60e1SKBA16w-1; Mon, 24 Aug 2020 04:44:54 -0400
X-MC-Unique: q5Pr61WHOHa60e1SKBA16w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9EC01007462;
        Mon, 24 Aug 2020 08:44:52 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8161B197E5;
        Mon, 24 Aug 2020 08:44:43 +0000 (UTC)
Date:   Mon, 24 Aug 2020 10:44:42 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <davem@davemloft.net>,
        <lorenzo.bianconi@redhat.com>, <echaudro@redhat.com>,
        <sameehj@amazon.com>, <kuba@kernel.org>, brouer@redhat.com
Subject: Re: [PATCH net-next 1/6] xdp: introduce mb in xdp_buff/xdp_frame
Message-ID: <20200824104442.023bdd11@carbon>
In-Reply-To: <pj41zlft8dsbdt.fsf@u68c7b5b1d2d758.ant.amazon.com>
References: <cover.1597842004.git.lorenzo@kernel.org>
        <c2665f369ede07328bbf7456def2e2025b9b320e.1597842004.git.lorenzo@kernel.org>
        <pj41zlft8dsbdt.fsf@u68c7b5b1d2d758.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 23 Aug 2020 17:08:30 +0300
Shay Agroskin <shayagr@amazon.com> wrote:

> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 3814fb631d52..42f439f9fcda 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -72,7 +72,8 @@ struct xdp_buff {
> >  	void *data_hard_start;
> >  	struct xdp_rxq_info *rxq;
> >  	struct xdp_txq_info *txq;
> > -	u32 frame_sz; /* frame size to deduce 
> > data_hard_end/reserved tailroom*/
> > +	u32 frame_sz:31; /* frame size to deduce 
> > data_hard_end/reserved tailroom*/
> > +	u32 mb:1; /* xdp non-linear buffer */
> >  };
> >  
> >  /* Reserve memory area at end-of data area.
> > @@ -96,7 +97,8 @@ struct xdp_frame {
> >  	u16 len;
> >  	u16 headroom;
> >  	u32 metasize:8;
> > -	u32 frame_sz:24;
> > +	u32 frame_sz:23;
> > +	u32 mb:1; /* xdp non-linear frame */  
> 
> Although this issue wasn't introduced with this patch, why not 
> make frame_sz field to be the same size in xdp_buff and xdp_frame 
> ?

This is all about struct layout and saving memory size, due to
cacheline access. Please read up on this and use the tool pahole to
inspect the struct memory layout.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

