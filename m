Return-Path: <SRS0=4hUP=4H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F99C34056
	for <bpf@archiver.kernel.org>; Wed, 19 Feb 2020 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CDA24670
	for <bpf@archiver.kernel.org>; Wed, 19 Feb 2020 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582135975;
	bh=lyDZIpwTz/hh72SVkxhS4/CHZJpScdj9P3LlvLBL2Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G+8QprUl/X4lx5QSr+Eads1DBEJNw+b3e0idBkPcIBhEk34imCGV9C8G6kmm9550b
	 T6YQgeJqUnGH43MRrkRUcl5VmrTuAxajalosW77S2+3L0UqMaUtE1L3fBpZ3x0SQ2j
	 7b1LDFLjgc+UdtHQv3MyMwH6Y3mkCFupOieCKqn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSSMz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgBSSMy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 13:12:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAA724656;
        Wed, 19 Feb 2020 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582135974;
        bh=lyDZIpwTz/hh72SVkxhS4/CHZJpScdj9P3LlvLBL2Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLs02FVXZGEBFOf9YPlMuj7NbmNKa/OgozYB53xJers8w568ZU6DcMARkYpcv5vOT
         9hOPXkSGpojeVwF+oy3iXZY9FBAxIrbdkg252JNpylewoWqW0M2570fi2V5xxEgTpx
         yt/1+Qcc1AKbbJ4+VM5qsB/W4rwdwzDQEl50TIqc=
Date:   Wed, 19 Feb 2020 19:12:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: Kernel 5.5.4 build fail for BPF-selftests with latest LLVM
Message-ID: <20200219181250.GA2852230@kroah.com>
References: <20200219133012.7cb6ac9e@carbon>
 <20200219132856.GA2836367@kroah.com>
 <20200219144254.36c3921b@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219144254.36c3921b@carbon>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 02:42:54PM +0100, Jesper Dangaard Brouer wrote:
> On Wed, 19 Feb 2020 14:28:56 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Feb 19, 2020 at 01:30:12PM +0100, Jesper Dangaard Brouer wrote:
> > > Hi Andrii,
> > > 
> > > Downloaded tarball for kernel release 5.5.4, and I cannot compile
> > > tools/testing/selftests/bpf/ with latest LLVM release version 9.  
> > 
> > Is this something that recently broke?  If so, what commit caused it?
> 
> Digging through, it seems several commits.

'git bisect' is your friend here, can you please use it?

> > And has llvm 9 always worked here?
> 
> Yes, llvm-9 used to work for tools/testing/selftests/bpf/.

As of when?

thanks,

greg k-h
