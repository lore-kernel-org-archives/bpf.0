Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FEC48BD3
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90682216C8
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561594114;
	bh=q7v/gBBs8kOpVWgP05UnkOe4D6KtGteYDyNxeIqq3Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IaPnbJI0+/ueEsPL+S/zwzD2M/NU0PqFLIFbhPHiy5zvVOygXKuRU8gTxS/q+TJY/
	 wpkZLhXIkIjBJUvWVp6BX5pSkb8biIJiUik1BdAxMhb51qC0y7YWe2My9XwV1akkNk
	 RQ9NlyqH0M5iaCrfTbADkxWPzQg8dt8ea4k92nac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfF0AIe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0AIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 20:08:34 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBABB20656;
        Thu, 27 Jun 2019 00:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561594113;
        bh=q7v/gBBs8kOpVWgP05UnkOe4D6KtGteYDyNxeIqq3Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E38cVo0yKftkZyVpH9K5csvOnsYU7jUGK/tPP7/6QkGWTpBt8jH4VDHQouVRa31Vg
         CgOTGr0r7dqoKPGVpmJnOx0ADMR7gUeO29DB8gYP3ARbACBstQkys074sfgW6jCTCa
         CL7ZjuXp1NzNFTUwYt/SEjURi4Q2KoMeMRWkrB3Q=
Date:   Thu, 27 Jun 2019 08:08:30 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "jannh@google.com" <jannh@google.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
Message-ID: <20190627000830.GB527@kroah.com>
References: <20190625182303.874270-1-songliubraving@fb.com>
 <20190625182303.874270-2-songliubraving@fb.com>
 <9bc166ca-1ef0-ee1e-6306-6850d4008174@iogearbox.net>
 <5A472047-F329-43C3-9DBC-9BCFC0A19F1C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A472047-F329-43C3-9DBC-9BCFC0A19F1C@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 26, 2019 at 03:17:47PM +0000, Song Liu wrote:
> >> +static struct miscdevice bpf_dev = {
> >> +	.minor		= MISC_DYNAMIC_MINOR,
> >> +	.name		= "bpf",
> >> +	.fops		= &bpf_chardev_ops,
> >> +	.mode		= 0440,
> >> +	.nodename	= "bpf",
> > 
> > Here's what kvm does:
> > 
> > static struct miscdevice kvm_dev = {
> >        KVM_MINOR,
> >        "kvm",
> >        &kvm_chardev_ops,
> > };

Ick, I thought we converted all of these to named initializers a long
time ago :)

> > Is there an actual reason that mode is not 0 by default in bpf case? Why
> > we need to define nodename?
> 
> Based on my understanding, mode of 0440 is what we want. If we leave it 
> as 0, it will use default value of 0600. I guess we can just set it to 
> 0440, as user space can change it later anyway. 

Don't rely on userspace changing it, set it to what you want the
permissions to be in the kernel here, otherwise you have to create a new
udev rule and get it merged into all of the distros.  Just do it right
the first time and there is no need for it.

What is wrong with 0600 for this?  Why 0440?

thanks,

greg k-h
