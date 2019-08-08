Return-Path: <SRS0=og6p=WE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F09C433FF
	for <bpf@archiver.kernel.org>; Thu,  8 Aug 2019 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CA121873
	for <bpf@archiver.kernel.org>; Thu,  8 Aug 2019 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565244590;
	bh=V0IGGKZJxEdUkjdotGPslilaf3h8Z7VHCP72GlnYyqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZuKiKmTp9uxh2IlWwrdQfgiltjyw5E7nxW+NvOsLTqYn1sIfSIwYMPY/MVUP+lzn3
	 az9PvCRkmFlr5R4s3rhsoYTJZfuh7SUgGP7wDA39S1QNg9KuUqWctyIWcqZwfXg7KM
	 XtYCclTMOXsOiiC/XjY0scV97WK352p2YEDnKa9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfHHGJt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfHHGJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Aug 2019 02:09:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2D32186A;
        Thu,  8 Aug 2019 06:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565244588;
        bh=V0IGGKZJxEdUkjdotGPslilaf3h8Z7VHCP72GlnYyqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xm4dzyLKbuRe068j/bDR4e+aMlXqv085JUE0lTHgppE+6Oi7c534/KaCD4vOYPWy7
         oU0Ff9+7PZkU4dMah7zhB6qVZ4DYkTALbfydhJlVNo88nyyDthaYLPdMGKc1hEeSPi
         lUz2dYzEt5mH7jHZzolQTyAEAz4j7JX+oHZAycF0=
Date:   Thu, 8 Aug 2019 08:09:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, yhs@fb.com, andrii.nakryiko@gmail.com,
        kernel-team@fb.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] btf: expose BTF info through sysfs
Message-ID: <20190808060946.GB25150@kroah.com>
References: <20190807183821.138728-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807183821.138728-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 07, 2019 at 11:38:21AM -0700, Andrii Nakryiko wrote:
> Make .BTF section allocated and expose its contents through sysfs.

Ah, found the original of this, sorry for the noise on the previous
response...

Still need Documentation/ABI/ entries though :)

thanks,

greg k-h
