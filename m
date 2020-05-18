Return-Path: <SRS0=Mla6=7A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42221C433DF
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F69207E8
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589821624;
	bh=f1/TVwPxUNrICFe1pftMVwPfApYo9l880yxmuIII0NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ijNDcKZGeims0TkXJ4wT4nX67FA6EIRud6rcqzFiLWUPj2ECl6hrXEe2/fs1ed3/5
	 ldBXvUMyDWZS8AwtP6S0pZ8yjEXswVZAGzlyD8rYo46BZUWg1npIyTL51zptPXIzyG
	 kXZlMeer6R+DxXuUkWIIuwUhEMzBGuZPt73LmhoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgERRHD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 May 2020 13:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERRHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 May 2020 13:07:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C934520709;
        Mon, 18 May 2020 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589821623;
        bh=f1/TVwPxUNrICFe1pftMVwPfApYo9l880yxmuIII0NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvqFW0CnyWAENMoivBvpFADMVMjpDLJxCKQWseNeGayFfEBT1txKSiBxKxVciUG1b
         2JPLJgUet0MYFS9RmNixgKBtKQultDf5TTlF7GsElhTQWK18v+WERJ6RHVqP8aC9kV
         yFfuYl7bMI6VZV0z06x2NOLgHy9UwfINsDq9+WqU=
Date:   Mon, 18 May 2020 19:07:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, stable@vger.kernel.org,
        andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.4 2/2] selftest/bpf: fix backported
 test_select_reuseport selftest changes
Message-ID: <20200518170700.GA2294041@kroah.com>
References: <20200516004018.3500869-1-andriin@fb.com>
 <20200516004018.3500869-2-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516004018.3500869-2-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 15, 2020 at 05:40:17PM -0700, Andrii Nakryiko wrote:
> Fix up RET_IF as CHECK macro to make selftests compile again.
> 
> Fixes: b911c5e8686a ("selftests: bpf: Reset global state between reuseport test runs")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/testing/selftests/bpf/test_select_reuseport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both now applied, thanks!

greg k-h
