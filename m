Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBECC48BD6
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 16:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7067C2146E
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561653453;
	bh=KY/UJMcTJXGMQaBcjxINfMIIu2a6rYUw7n7Ve0Eub8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ziOzkvos/TbusU4zPl1h+OER2MdMsNexuotqvHCxqOZUi0BfYE9ESpEYqTTgNw8a/
	 H7r+/uYaLcoQPrmxXnlEA82JxfqeZZfUUY5kzsOG25gJLHS6NS2geeRtAs6jvJNqhq
	 F0lB5QgaSiHpLomCJqJncSJ1XKb7ZfpG/biulmXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0Qhd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0Qhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 12:37:33 -0400
Received: from localhost (unknown [89.205.136.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F58208E3;
        Thu, 27 Jun 2019 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561653452;
        bh=KY/UJMcTJXGMQaBcjxINfMIIu2a6rYUw7n7Ve0Eub8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqZ3xjiJ9Jyjx6YPJHod2QEUsNradGsE9ClL2z7Gx54xGTjhkkHm25lz6oTh2BcWN
         OTSPQEaef22gwB+NwdcZpNTNL4d+Nsf+Eos0Pqr/a9499DYGVkMHjvE5G6it2y7lvS
         XOAWBiYTamYzNjhy9ll+XkB8vmqK+W7gjA9NbSZU=
Date:   Fri, 28 Jun 2019 00:37:23 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "jannh@google.com" <jannh@google.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
Message-ID: <20190627163723.GA9643@kroah.com>
References: <20190625182303.874270-1-songliubraving@fb.com>
 <20190625182303.874270-2-songliubraving@fb.com>
 <9bc166ca-1ef0-ee1e-6306-6850d4008174@iogearbox.net>
 <5A472047-F329-43C3-9DBC-9BCFC0A19F1C@fb.com>
 <20190627000830.GB527@kroah.com>
 <94404006-0D7E-4226-9167-B1DFAF7FEB2A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94404006-0D7E-4226-9167-B1DFAF7FEB2A@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 27, 2019 at 01:00:03AM +0000, Song Liu wrote:
> 
> 
> > On Jun 26, 2019, at 5:08 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Jun 26, 2019 at 03:17:47PM +0000, Song Liu wrote:
> >>>> +static struct miscdevice bpf_dev = {
> >>>> +	.minor		= MISC_DYNAMIC_MINOR,
> >>>> +	.name		= "bpf",
> >>>> +	.fops		= &bpf_chardev_ops,
> >>>> +	.mode		= 0440,
> >>>> +	.nodename	= "bpf",
> >>> 
> >>> Here's what kvm does:
> >>> 
> >>> static struct miscdevice kvm_dev = {
> >>>       KVM_MINOR,
> >>>       "kvm",
> >>>       &kvm_chardev_ops,
> >>> };
> > 
> > Ick, I thought we converted all of these to named initializers a long
> > time ago :)
> > 
> >>> Is there an actual reason that mode is not 0 by default in bpf case? Why
> >>> we need to define nodename?
> >> 
> >> Based on my understanding, mode of 0440 is what we want. If we leave it 
> >> as 0, it will use default value of 0600. I guess we can just set it to 
> >> 0440, as user space can change it later anyway. 
> > 
> > Don't rely on userspace changing it, set it to what you want the
> > permissions to be in the kernel here, otherwise you have to create a new
> > udev rule and get it merged into all of the distros.  Just do it right
> > the first time and there is no need for it.
> > 
> > What is wrong with 0600 for this?  Why 0440?
> 
> We would like root to own the device, and let users in a certain group 
> to be able to open it. So 0440 is what we need. 

But you are doing a "write" ioctl here, right?  So don't you really need
0660 at the least?  And if you "know" the group id, I think you can
specify it too so udev doesn't have to do a ton of work, but that only
works for groups that all distros number the same.

And why again is this an ioctl instead of a syscall?  What is so magic
about the file descriptor here?

thanks

greg k-h
