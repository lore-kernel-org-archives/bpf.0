Return-Path: <SRS0=BfNB=6Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4F5C47256
	for <bpf@archiver.kernel.org>; Sat,  2 May 2020 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3131821775
	for <bpf@archiver.kernel.org>; Sat,  2 May 2020 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgEBAZS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 May 2020 20:25:18 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:37310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgEBAZS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 May 2020 20:25:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 27FA8181D341E;
        Sat,  2 May 2020 00:25:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: unit54_10c38181e770c
X-Filterd-Recvd-Size: 2162
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 00:25:15 +0000 (UTC)
Message-ID: <7c15d0d43e0661d4b68d80c26fe73bfb6df38184.camel@perches.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf, printk: add BTF-based type
 printing
From:   Joe Perches <joe@perches.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kafai@fb.com,
        songliubraving@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Fri, 01 May 2020 17:25:13 -0700
In-Reply-To: <alpine.LRH.2.21.2004301010520.23084@localhost>
References: <1587120160-3030-1-git-send-email-alan.maguire@oracle.com>
         <20200418160536.4mrvqh2lasqbyk77@ast-mbp>
         <alpine.LRH.2.21.2004201623390.12711@localhost>
         <7d6019da19d52c851d884731b1f16328fdbe2e3d.camel@perches.com>
         <alpine.LRH.2.21.2004301010520.23084@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-04-30 at 03:03 -0700, Alan Maguire wrote:
> On Mon, 20 Apr 2020, Joe Perches wrote:

> > Here as well the individual field types don't contain
> > enough information to determine if a field should be
> > output as %x or %u.
> Right, we could add some more format modifiers for cases
> like that I guess.  Currently the display formats used are
> - numbers are represented as decimal
> - bitfields are represented in hex
> - pointers are obfuscated unless the 'x' option is used
> - char arrays are printed as chars if printable,
>   [ 'l', 'i', 'k', 'e', ' ', 't', 'h', 'i', 's' ]
> 
> I'd be happy to add more format specifiers to control
> these options, or tweak the defaults if needed. A
> "print numbers in hex" option seems worthwhile perhaps?

Or maybe add and use new typedefs like x8,x16,x32,x64 to the
bpf struct definitions where u8,u16,u32,u64 are %u and
x8,x16,x32,x64 are %x


