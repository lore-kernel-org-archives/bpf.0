Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D116BC433DB
	for <bpf@archiver.kernel.org>; Mon, 21 Dec 2020 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE6322A85
	for <bpf@archiver.kernel.org>; Mon, 21 Dec 2020 10:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLUKE3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Dec 2020 05:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgLUKE3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Dec 2020 05:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608544982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mg59zUDypoykQV0yYREMjWDL4kmSg4YZvp5Vy+ylQvs=;
        b=CJXwG13HO6+u9K/wYPbCnR64hh7bDdE34ioSm8MwzzE/HcKS08Tjwr7P6osSzQhRHiLFFt
        Clv26lIG/uP2hzP0fydTSuzpfea4o+2zhcOhAqclYmqu7lWxk8MuVqhH4SAfc8LxVCgvob
        HwhDjyk24EokZ36Gv4/aYUxAfZBktck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-X-_dI3NjM0GpR1NmSif3Rw-1; Mon, 21 Dec 2020 04:02:10 -0500
X-MC-Unique: X-_dI3NjM0GpR1NmSif3Rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882BD107ACE6;
        Mon, 21 Dec 2020 09:02:08 +0000 (UTC)
Received: from carbon (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D22245C54B;
        Mon, 21 Dec 2020 09:01:53 +0000 (UTC)
Date:   Mon, 21 Dec 2020 10:01:52 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Shay Agroskin <shayagr@amazon.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, echaudro@redhat.com,
        jasowang@redhat.com, brouer@redhat.com
Subject: Re: [PATCH v5 bpf-next 03/14] xdp: add xdp_shared_info data
 structure
Message-ID: <20201221100152.58fa6bd7@carbon>
In-Reply-To: <1b0a5b59-f7e6-78b3-93bd-2ea35274e783@mojatatu.com>
References: <cover.1607349924.git.lorenzo@kernel.org>
        <21d27f233e37b66c9ad4073dd09df5c2904112a4.1607349924.git.lorenzo@kernel.org>
        <5465830698257f18ae474877648f4a9fe2e1eefe.camel@kernel.org>
        <20201208110125.GC36228@lore-desk>
        <pj41zlk0tdq22i.fsf@u68c7b5b1d2d758.ant.amazon.com>
        <1b0a5b59-f7e6-78b3-93bd-2ea35274e783@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 19 Dec 2020 10:30:57 -0500
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On 2020-12-19 9:53 a.m., Shay Agroskin wrote:
> > 
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> >   
> 
> >> for the moment I do not know if this area is used for other purposes.
> >> Do you think there are other use-cases for it?  

Yes, all the same use-cases as SKB have.  I wanted to keep this the
same as skb_shared_info, but Lorenzo choose to take John's advice and
it going in this direction (which is fine, we can always change and
adjust this later).


> Sorry to interject:
> Does it make sense to use it to store arbitrary metadata or a scratchpad
> in this space? Something equivalent to skb->cb which is lacking in
> XDP.

Well, XDP have the data_meta area.  But difficult to rely on because a
lot of driver don't implement it.  And Saeed and I plan to use this
area and populate it with driver info from RX-descriptor.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

