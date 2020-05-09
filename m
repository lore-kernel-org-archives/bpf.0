Return-Path: <SRS0=3byo=6X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859FC38A2A
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 02:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AD52192A
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 02:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588989722;
	bh=f/75jpsP75sjutxWnSb2ta93FS25SZJI24n5u0R/Hwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OuwS0Le0DqC4m988Wg47Kij24j7LIaJSGovVXQz+/PSkIJ3/Dz3xi4nJXowKrMqAV
	 Oi6RA60ZstdQkYpbVLsX0ScJEQBG4ib71tmJzFtjkcuq/UyS9Qp1bNPyHRmBuK+va+
	 A53Esw0EIv6j0PcPt1O/Pe0uLTg+GQxdILyZoFnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgEICCC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 May 2020 22:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEICCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 22:02:02 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB2F218AC;
        Sat,  9 May 2020 02:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588989721;
        bh=f/75jpsP75sjutxWnSb2ta93FS25SZJI24n5u0R/Hwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OxYM9s0/Sovqg/a/zGKHNblkI5aGfCETtGMRHmi8ehNWqF0wI2uJrYEAWQudc3++m
         U2l9UfC6p0ttKTzw4a+81vwBShlaQMqq21qLEbeo4oWwfVG+S5OxQ3pDABA0m42nVH
         1uEeFLdYFuBI7IK54sobpQpvgvgQiJ8h+V5NWvAo=
Date:   Fri, 8 May 2020 19:02:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-05-09
Message-ID: <20200508190200.5cec6d40@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200508230527.24382-1-daniel@iogearbox.net>
References: <20200508230527.24382-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat,  9 May 2020 01:05:27 +0200 Daniel Borkmann wrote:
> Hi David,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 9 day(s) which contain
> a total of 4 files changed, 11 insertions(+), 6 deletions(-).
> 
> The main changes are:
> 
> 1) Fix msg_pop_data() helper incorrectly setting an sge length in some
>    cases as well as fixing bpf_tcp_ingress() wrongly accounting bytes
>    in sg.size, from John Fastabend.
> 
> 2) Fix to return an -EFAULT error when copy_to_user() of the value
>    fails in map_lookup_and_delete_elem(), from Wei Yongjun.
> 
> 3) Fix sk_psock refcnt leak in tcp_bpf_recvmsg(), from Xiyu Yang.

Pulled, thank you!
