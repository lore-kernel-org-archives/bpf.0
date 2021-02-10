Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC810C433E0
	for <bpf@archiver.kernel.org>; Wed, 10 Feb 2021 04:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA9564E45
	for <bpf@archiver.kernel.org>; Wed, 10 Feb 2021 04:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBJENX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Feb 2021 23:13:23 -0500
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:33622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229979AbhBJENR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 23:13:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6351E18538497;
        Wed, 10 Feb 2021 04:12:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fruit02_2e00bfb2760d
X-Filterd-Recvd-Size: 1988
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 04:12:29 +0000 (UTC)
Message-ID: <2c5ba548a8148afa2aa03cc2d9a2d71ca85f74e7.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 20:12:28 -0800
In-Reply-To: <F5609C13-E5D7-47C2-94C2-F4C2443352C4@fb.com>
References: <20210209211954.490077-1-songliubraving@fb.com>
         <2b4805f6ca2b44f4195b6fdba4f82d5e90ab1989.camel@perches.com>
         <F5609C13-E5D7-47C2-94C2-F4C2443352C4@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-10 at 04:07 +0000, Song Liu wrote:
> > On Feb 9, 2021, at 6:10 PM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2021-02-09 at 13:19 -0800, Song Liu wrote:
> > > BPF programs explicitly initialise global variables to 0 to make sure
> > > clang (v10 or older) do not put the variables in the common section.
> > 
> > Acked-by: Joe Perches <joe@perches.com>
> > 
> > So the patch is OK now, but I have a question about the concept:
> > 
> > Do you mean that these initialized to 0 global variables
> > should go into bss or another section?
> 
> We want these variables to go to bss. 

OK, then the patch is fine.

> > Perhaps it'd be useful to somehow mark variables into specific
> > sections rather than bss when initialized to 0 and data when not
> > initialized to 0.
> 
> Currently, libbpf expects zero initialized global data in bss. This 
> convention works well so far. Is there any reason that we specify 
> section for global data? 

There's no need I know of.

cheers, Joe

