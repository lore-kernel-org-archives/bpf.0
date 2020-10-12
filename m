Return-Path: <SRS0=+vlE=DT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99556C433DF
	for <bpf@archiver.kernel.org>; Mon, 12 Oct 2020 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3818D20776
	for <bpf@archiver.kernel.org>; Mon, 12 Oct 2020 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602525649;
	bh=XAxiPxmBPJ4hRe6GnUZiPms8yH+eUQE6N+7JSJSbJQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SMLMR/CyywSPSSz95Y3/uMHXY3uE02fUz8l2M0muaPzOHYVVY+/VDyBcmVi/kvYCV
	 YrYSPhW/dYB2WUtbHUeOj8RjpG+3IC2zVYzDi96MCFAjggyx6KdN7xaSCj8ltGW0Dc
	 JEKVd+ehVFNJjGZc2Hp8j7QuNMEpIayHLL+UdtIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbgJLSAs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389885AbgJLSAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 14:00:48 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB6F205CA;
        Mon, 12 Oct 2020 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602525648;
        bh=XAxiPxmBPJ4hRe6GnUZiPms8yH+eUQE6N+7JSJSbJQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JUSXQphURzwRrZMjcqVTtnAUe+1mkns3rmlElTvk0nnuD5+bokrDj0PRej6shM1vg
         vAru1btF/U8tZB/94D1a0O767MHqWGNgvWrm92TBTbXcBhSGm0t2QH5VGUdgqNo8C5
         NmoPvjXL0PZxMRlsSrJFVJVw2NujXQZPwQSYGXvc=
Date:   Mon, 12 Oct 2020 11:00:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: merge window is open. bpf-next is still open.
Message-ID: <20201012110046.3b2c3c27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAADnVQ+ycd8T4nBcnAwr5FHX75_JhWmqdHzXEXwx5udBv8uwiQ@mail.gmail.com>
References: <CAADnVQ+ycd8T4nBcnAwr5FHX75_JhWmqdHzXEXwx5udBv8uwiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 11 Oct 2020 17:59:16 -0700 Alexei Starovoitov wrote:
> Hi BPF developers,
> 
> The merge window has just opened.
> Which would typically mean that bpf-next is closing,
> but things are going to be a little bit different this time.
> We're stopping to accept new features into bpf-next/master.
> The few pending patches might get applied and imminent pull-req into
> net-next will be sent.
> After that bpf-next/master will be frozen for the duration of the merge window,
> but bpf-next/next branch will be open for the new features.
> 
> So please continue the BPF development and keep sending your patches.
> They will be reviewed as usual.
> After the merge window everything that is accumulated in bpf-next/next
> will be applied to bpf-next/master.
> Due to merge/rebase sha-s in bpf-next/next will likely be unstable.
> 
> Please focus on fixing bugs that may get exposed during the merge window.
> The bpf tree is always open for bug fixes.

FWIW for CIs switching between bpf-next/next and bpf-next/master could
be somewhat fragile. Since bpf-next/master is frozen during the merge
window, why not apply the patches there?
