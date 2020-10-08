Return-Path: <SRS0=0bGE=DP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBDC433E7
	for <bpf@archiver.kernel.org>; Thu,  8 Oct 2020 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08C62223F
	for <bpf@archiver.kernel.org>; Thu,  8 Oct 2020 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602191219;
	bh=vWfF+2lSRBOoSSnPsBbag2gtsRpUEqBbB7TRbuLJOfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QzfDfqOUMhddAOccEuzBSfiqvNU/0wFQjTFQr3W5LxvLrYPTs/f5YVRoUF2PVw1bV
	 fG48ise1Xw8LoG3zgJ6NRJsPDBi6KQYgN8hyB3E+xd38Cvh4u8Uhnnubj0019zTAmE
	 ZjcU0qEmbiN7EvwMgJfSxVWk6deJO1HCVqU8Wa74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJHVG7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHVG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 17:06:59 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E94322227;
        Thu,  8 Oct 2020 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602191218;
        bh=vWfF+2lSRBOoSSnPsBbag2gtsRpUEqBbB7TRbuLJOfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vfysR9F+EDyrvXDglyQCGX1GAlCC6aVku9dV21Xqb14wlxNYXA58R4QLnp/QvLb+/
         aVtVhcqF4IpxKldIeq1sZxsn36352b6o2wTCNI/RRThK5VUhOmjZldBbllVo2OqKV3
         SG4iP9YYh7T8q65UkB5W9sldDR53qn/Pv1OjHZ+Q=
Date:   Thu, 8 Oct 2020 14:06:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-10-08
Message-ID: <20201008140656.4f89b27f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201008145154.18801-1-daniel@iogearbox.net>
References: <20201008145154.18801-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu,  8 Oct 2020 16:51:54 +0200 Daniel Borkmann wrote:
> Hi David,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 2 non-merge commits during the last 8 day(s) which contain
> a total of 2 files changed, 10 insertions(+), 4 deletions(-).
> 
> The main changes are:
> 
> 1) Fix "unresolved symbol" build error under CONFIG_NET w/o CONFIG_INET due
>    to missing tcp_timewait_sock and inet_timewait_sock BTF, from Yonghong Song.
> 
> 2) Fix 32 bit sub-register bounds tracking for OR case, from Daniel Borkmann.

Looks like the pw bot does not reply to pull requests?

Pulled, and on it's way to Linus. Thanks!
