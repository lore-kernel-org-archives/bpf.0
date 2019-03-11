Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E36C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06872087C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552330502;
	bh=gg47sPOJepgKpND65VoOqiBrqfQIRRNsr71tYH8Way8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GvdF8Kbu73qkPWA52utrD1hDm4c5uMJQmpDPIJpBBvXnr/iWS2RVy0EY0st7hQpfa
	 JNilbk6reC2Z5F//W7CTMkRp7zLL7wA8RMsDsas/gxU624NenisbOP+RYmoor6s9uZ
	 bEfbc0gcencPe5oYVsAhrKM0dZUsFHlBN56JV1VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCKSy7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfCKSy7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 14:54:59 -0400
Received: from localhost (unknown [104.132.1.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F5920643;
        Mon, 11 Mar 2019 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552330498;
        bh=gg47sPOJepgKpND65VoOqiBrqfQIRRNsr71tYH8Way8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+xZ/ETkffnx0hxXDm0hV+tskkJKr+P7DxTrtIkX8Q2Vq2L6IDL8XNlXJvHP43vqv
         9tLCMuorVf62jUWcfkmQhdZ2gjiL0ht5Lj1a757EqF/XDB8uUE1z7eWxfqhmuH/UoP
         LlTQ2dBDwJdwZIos3a8OMhWV0onfStsGYLa0kjsI=
Date:   Mon, 11 Mar 2019 11:54:58 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>, ast@kernel.org,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 bpf: prevent out of
 bounds speculation on pointer arithmetic
Message-ID: <20190311185458.GA4986@kroah.com>
References: <5d71646c-f897-2178-9d4a-fababe999f36@huawei.com>
 <494a84f2-1a29-1521-e819-6e4fbed17641@iogearbox.net>
 <c9a89285-23bd-0e4d-3bdc-ea5d5c61e7ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a89285-23bd-0e4d-3bdc-ea5d5c61e7ff@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 07:13:14PM +0800, Jason Yan wrote:
> 
> 
> On 2019/3/11 17:41, Daniel Borkmann wrote:
> > Hi Jason,
> > 
> > On 03/11/2019 10:18 AM, Jason Yan wrote:
> > > Hi, Daniel & Greg
> > > 
> > > This patch (979d63d50c0c bpf: prevent out of bounds speculation on pointer arithmetic) was assigned a CVE (CVE-2019-7308) with a high score:
> > > 
> > > CVSS v3.0 Severity and Metrics:
> > > Base Score: 9.8 CRITICAL
> > > 
> > > And this patch is not in stable-4.4, would you please backport this patch to 4.4?
> > 
> > We don't handle kernels as old as 4.4, so someone else would need to
> > do the backporting e.g. from your side. The series has been backported
> > to the last two most-recent stable kernels at that time (we usually
> > follow netdev practice here), and there have been asks about 4.14 as
> > well; I've been looking into backporting for the latter last two weeks
> > on and off, but there are conflicts all over the place in fragile core
> > areas where I didn't have enough free cycles to complete it yet. For
> > old kernels, you're probably better off doing something like this in
> > your tree instead of the huge complexity with a backport:
> > 
> 
> Thanks for you kindly reply.
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index bc34cf9..2cea2de 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -47,7 +47,7 @@ static DEFINE_SPINLOCK(prog_idr_lock);
> >   static DEFINE_IDR(map_idr);
> >   static DEFINE_SPINLOCK(map_idr_lock);
> > 
> > -int sysctl_unprivileged_bpf_disabled __read_mostly;
> > +int sysctl_unprivileged_bpf_disabled __read_mostly = 1;
> > 
> 
> Greg, is it possible to get this kind of mitigation into 4.4?

Why are you using a 4.4 kernel with untrusted userspace?  The only
reason to use 4.4.y at this point in time is if you have a huge SoC tree
patchset that is not upstream.  If you are using x86, you should be
using 4.14.y or newer right now.

That being said, no, I am not going to change the default here, that
could break people's working setups.  I would recommend you just setting
this value in your initrd/setup scripts if you want it, that's why it is
a sysctl :)

thanks,

greg k-h
