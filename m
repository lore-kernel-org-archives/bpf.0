Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB3CA90AF
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4CB206E5
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589365598;
	bh=sTNPgdoO+x0wrjD9VkpNsMd79UhmU+VvDRd9wMbL294=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mV2wIKvxmlpkpKQf1ei7dGNfsa9vWiVb/rkeFYpy8+vpUXo/mHOvWz0pVEWKsGuHE
	 KeOxEoLeuyaQCZBCGjmpGhA7mBkJl7/PqKoemmpbRxjd/4RHfvco7kKneKXkfEXyGY
	 mLoE9+/uu83n/hmZYWyQ98sjBGSHTldJAhOKXER0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgEMK0h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 06:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgEMK0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 06:26:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF93206D6;
        Wed, 13 May 2020 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589365597;
        bh=sTNPgdoO+x0wrjD9VkpNsMd79UhmU+VvDRd9wMbL294=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWgY5pllkS0m86DFzZhCXMDGAvLQ9JrxGRZaUfS2OxuDiovRa70oGfYMAqg6tLVfA
         eWFcyD1MeQT4sNB+jnMnjhdpJ6GJOEQGhhnDynAvH/1ly9+96+U1snBOdVvR+KX1Do
         B4HNybb3rxuN7bwIqSg8ywd6Cvhumh45QFISiP4E=
Date:   Wed, 13 May 2020 12:26:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, stable@vger.kernel.org,
        lkp@lists.01.org, bpf@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [selftests/bpf] da43712a72: kernel-selftests.bpf.make_fail
Message-ID: <20200513102634.GC871114@kroah.com>
References: <20200513074418.GE17565@shao2-debian>
 <20200513095835.GD102436@dhcp-12-153.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513095835.GD102436@dhcp-12-153.nay.redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 05:58:35PM +0800, Hangbin Liu wrote:
> 
> Thanks test bot catch the issue.
> On Wed, May 13, 2020 at 03:44:18PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 77bb53cb094828a31cd3c5b402899810f63073c1 ("selftests/bpf: Fix perf_buffer test on systems w/ offline CPUs")
> > https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> 
> The author for this commit is Andrii(cc'd).
> 
> Mine is f1c3656c6d9c ("selftests/bpf: Skip perf hw events test if the setup disabled it")
> > prog_tests/stacktrace_build_id_nmi.c:55:3: error: label ‘cleanup’ used but not defined
> >    goto cleanup;
> >    ^~~~
> 
> Hi Greg, we are missing a depend commit
> dde53c1b763b ("selftests/bpf: Convert few more selftest to skeletons").
> 
> So either we need backport this patch, or if you like, we can also fix it by
> changing 'goto cleanup;' to 'goto close_prog;'. So which one do you prefer?

I don't know, I have no context here at all, sorry.

What stable kernel tree is failing, what patch needs to be changed, what
patch caused this, and so on...

confused,

greg k-h
