Return-Path: <SRS0=zfXS=5W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E2C2BA19
	for <bpf@archiver.kernel.org>; Mon,  6 Apr 2020 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4ED2072A
	for <bpf@archiver.kernel.org>; Mon,  6 Apr 2020 09:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUGfUZzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDFJJa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:09:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39981 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbgDFJJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Apr 2020 05:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586164168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lvKA0xUIiCsW6HoBtQirda8p4dzQ/WxqHlUFpRTwhc=;
        b=ZUGfUZznWN03UXpPqiPTPw6Ywp/Lumf6G1pcvp5ZpKDriQrNPcSEVVPnKdIhdHE/1/cQdI
        zfn33xlg0P4y/WJftYr5FUAcvussBogRCAyZLrbktBpaq6bcBdxw0Q0vcr23UEAWyIt5ho
        Rwypftk57ubG1+1WiXo9exCkRLPHG7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-QGQozKdbNny04y9Cqeg_MA-1; Mon, 06 Apr 2020 05:09:26 -0400
X-MC-Unique: QGQozKdbNny04y9Cqeg_MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C66E8024EB;
        Mon,  6 Apr 2020 09:09:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF15727062;
        Mon,  6 Apr 2020 09:09:20 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:09:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bgregg@netflix.com
Subject: Re: [RFC 0/3] bpf: Add d_path helper
Message-ID: <20200406090918.GA3035739@krava>
References: <20200401110907.2669564-1-jolsa@kernel.org>
 <20200402142106.GF23230@ZenIV.linux.org.uk>
 <20200403090828.GF2784502@krava>
 <20200406031602.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406031602.GR23230@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 06, 2020 at 04:16:02AM +0100, Al Viro wrote:
> On Fri, Apr 03, 2020 at 11:08:28AM +0200, Jiri Olsa wrote:
> 
> > if we limit it just to task context I think it would still be
> > helpful for us:
> > 
> >   if (in_task())
> > 	d_path..
> > 
> > perhaps even create a d_path version without d_dname callback
> > if that'd be still a problem, because it seems to be there mainly
> > for special filesystems..?
> 
> IDGI...
> 	1) d_path(), by definition, is dependent upon the
> process' root - the same <mount,dentry> pair will yield
> different strings if caller is chrooted.  You *can't* just
> use a random process' root
> 	2) we are *NOT* making rename_lock and mount_lock
> disable interrupts.  Not happening.
> 
> So it has to be process-synchronous anyway.  Could you describe
> where that thing is going to be callable?

it could be called as bpf helper from any place we could put
the trampoline probe on.. so most of the kernel functions
(at entry or exit) .. we can make checks, like for context
before we allow to call it

is there any way we could have d_path functionality (even
reduced and not working for all cases) that could be used
or called like that?

thanks,
jirka

