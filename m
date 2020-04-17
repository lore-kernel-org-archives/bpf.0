Return-Path: <SRS0=FAFN=6B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53BC2BB85
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A472137B
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587109567;
	bh=6WizWOPGcj4Xsk+M2kiEmA/c8eB5Uh9oJTXzQ1TCN7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xbGFFGACUaKwqe5qKKX6jDUEB0zRZjvuy03qEX4lKeoKlmPk0RjF59RzXwgPWHzwh
	 TP6CErI324N36z0AL+Q7JSbNIRbDDUVyCmlmWeIip//+8eP2UDJZZODUJ7PtmN+3N7
	 nkjoViaBbiu/AmeTLXTzQ2t1P4xTP56cH1qE6+Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgDQHqB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgDQHqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Apr 2020 03:46:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1D6208E4;
        Fri, 17 Apr 2020 07:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587109560;
        bh=6WizWOPGcj4Xsk+M2kiEmA/c8eB5Uh9oJTXzQ1TCN7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xj4JSJa6TyQgwsI+QhjTwYjgDkTFOAYDY2LEFtr+bPZqtb/4DkhBQ7bzfNN/wmD0i
         JpcgmxoAHQZS70LF/LwLOMtQBNRDJeKgtyadxtn48xiDqwffsyROHBLP6Aael3/hRu
         5cq9jrDTaWqCzzfao/lJ/OZnkPHLcWueb11rWeXI=
Date:   Fri, 17 Apr 2020 09:45:58 +0200
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
Subject: Re: [PATCH 6/6] sysctl: pass kernel pointers to ->proc_handler
Message-ID: <20200417074558.GC23015@kroah.com>
References: <20200417064146.1086644-1-hch@lst.de>
 <20200417064146.1086644-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417064146.1086644-7-hch@lst.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 17, 2020 at 08:41:46AM +0200, Christoph Hellwig wrote:
> Instead of having all the sysctl handlers deal with user pointers, which
> is rather hairy in terms of the BPF interaction, copy the input to and
> from  userspace in common code.  This also means that the strings are
> always NUL-terminated by the common code, making the API a little bit
> safer.
> 
> As most handler just pass through the data to one of the common handlers
> a lot of the changes are mechnical.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ah, nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
