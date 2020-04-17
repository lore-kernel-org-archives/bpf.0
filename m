Return-Path: <SRS0=FAFN=6B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEEDC2BB85
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 07:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21CB2087E
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587109419;
	bh=080BsU7aUuQAAPZb/CBi81iN/+0Uhk7GZPCglc2G+Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=duiL+OPWGuq6k5JWklV/3omn2f7bijDFnN5y4jMP5jbVypnNcCixC3NelpchhvGws
	 76WHl2RQ62HxGLyydJN8vP4UIU6PFuTakLY8OBo0Bp80PlRdO2zWKW3BHW6//zmIh7
	 +9dGC2lxZ+qQhLiO6s5F8PctjgpB74+kSaGUBjwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDQHne (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDQHnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Apr 2020 03:43:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D094206D9;
        Fri, 17 Apr 2020 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587109412;
        bh=080BsU7aUuQAAPZb/CBi81iN/+0Uhk7GZPCglc2G+Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBSvHHRi5YUb8lnqfONSvXbHwa6YtZzrlkKMItTeWJ16sYnsZZdYi8oGid5bNOt7T
         qBr95bNxLXJ/xRmCHKHLJbPUaEBHoN3+9gcsKdO9ndf9AF4njCcJVmR0vtkkThwwLs
         oo/0UFMVgvAzzZBllCkLI2Ypr2j1ufnVJ7ImmF1Q=
Date:   Fri, 17 Apr 2020 09:43:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/6] firmware_loader: remove unused exports
Message-ID: <20200417074330.GB23015@kroah.com>
References: <20200417064146.1086644-1-hch@lst.de>
 <20200417064146.1086644-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417064146.1086644-3-hch@lst.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 17, 2020 at 08:41:42AM +0200, Christoph Hellwig wrote:
> Neither fw_fallback_config nor firmware_config_table are used by modules.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/firmware_loader/fallback_table.c | 2 --
>  1 file changed, 2 deletions(-)

I have no objection to this patch, and can take it in my tree, but I
don't see how it fits in with your larger patch series...

thanks,

greg k-h
