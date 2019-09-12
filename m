Return-Path: <SRS0=C00Q=XH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD3C4CEC7
	for <bpf@archiver.kernel.org>; Thu, 12 Sep 2019 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607320856
	for <bpf@archiver.kernel.org>; Thu, 12 Sep 2019 22:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfILWvp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:51:45 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:33884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbfILWvo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Sep 2019 18:51:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 478BE18224D66;
        Thu, 12 Sep 2019 22:51:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wash29_66372152c7216
X-Filterd-Recvd-Size: 1955
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 22:51:42 +0000 (UTC)
Message-ID: <b5cd34b624f07ed136178724f208f027644f36a5.camel@perches.com>
Subject: Re: Strange scripts/get_maintainer.pl output
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Thu, 12 Sep 2019 15:51:41 -0700
In-Reply-To: <CANiq72kQUvnVq0U-okpND8L5xueHs4o3-mKMNX8_P0n5uZw+-w@mail.gmail.com>
References: <CANiq72kQUvnVq0U-okpND8L5xueHs4o3-mKMNX8_P0n5uZw+-w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2019-09-13 at 00:25 +0200, Miguel Ojeda wrote:
> Hi Joe,

Hey Miguel.

> I was preparing the RFC for the clang-format stuff and I ran:
> 
>   scripts/get_maintainer.pl -f .clang-format
> 
> But it seems I (also) got the people from the BPF entry for some
> reason. Maybe the dot messes with some regex? (although other
> dot-files seem to work). I could try to solve it, but my Perl-fu is
> weak and you are the wizard of get_maintainer.pl anyway... :-)

It's not perl, it's the entry for
	K: bpf
in the BPF section.

BPF (Safe dynamic programs and tools)
M:	Alexei Starovoitov <ast@kernel.org>
M:	Daniel Borkmann <daniel@iogearbox.net>
[...]
K:	bpf
N:	bpf

This K: entry matches a _lot_ of files that contain bpf.

For instance, the .clang-format file has:

$ git grep bpf .clang-format
.clang-format:  - 'bpf_for_each_spilled_reg'

If you use --no-keywords, you get:

$ ./scripts/get_maintainer.pl -f --no-keywords .clang-format
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> (maintainer:CLANG-FORMAT FILE)
linux-kernel@vger.kernel.org (open list)



