Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CFC433DF
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55B9205ED
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgEMXXr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 19:23:47 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:44492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732374AbgEMXXr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 19:23:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0DD0E182CF668;
        Wed, 13 May 2020 23:23:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wool25_209212bf08451
X-Filterd-Recvd-Size: 3051
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 May 2020 23:23:43 +0000 (UTC)
Message-ID: <e09c45fac7bb688e5e248449594625eda97a2791.camel@perches.com>
Subject: Re: [PATCH v2 bpf-next 0/7] bpf, printk: add BTF-based type printing
From:   Joe Perches <joe@perches.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Date:   Wed, 13 May 2020 16:23:42 -0700
In-Reply-To: <CAADnVQLPSvRCO-xxW+Rcz4bzLM-DXjSzm8AwhyogrNTufBdoNw@mail.gmail.com>
References: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
         <20200513222424.4nfxgkequhdzn3u3@ast-mbp.dhcp.thefacebook.com>
         <dc6a17197c3406d877efd98de351e57d7bbe06a5.camel@perches.com>
         <CAADnVQLPSvRCO-xxW+Rcz4bzLM-DXjSzm8AwhyogrNTufBdoNw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-05-13 at 15:50 -0700, Alexei Starovoitov wrote:
> On Wed, May 13, 2020 at 3:48 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-05-13 at 15:24 -0700, Alexei Starovoitov wrote:
> > > On Tue, May 12, 2020 at 06:56:38AM +0100, Alan Maguire wrote:
> > > > The printk family of functions support printing specific pointer types
> > > > using %p format specifiers (MAC addresses, IP addresses, etc).  For
> > > > full details see Documentation/core-api/printk-formats.rst.
> > > > 
> > > > This patchset proposes introducing a "print typed pointer" format
> > > > specifier "%pT"; the argument associated with the specifier is of
> > > > form "struct btf_ptr *" which consists of a .ptr value and a .type
> > > > value specifying a stringified type (e.g. "struct sk_buff") or
> > > > an .id value specifying a BPF Type Format (BTF) id identifying
> > > > the appropriate type it points to.
> > > > 
> > > >   pr_info("%pT", BTF_PTR_TYPE(skb, "struct sk_buff"));
> > > > 
> > > > ...gives us:
> > > > 
> > > > (struct sk_buff){
> > > >  .transport_header = (__u16)65535,
> > > >  .mac_header = (__u16)65535,
> > > >  .end = (sk_buff_data_t)192,
> > > >  .head = (unsigned char *)000000007524fd8b,
> > > >  .data = (unsigned char *)000000007524fd8b,
> > > 
> > > could you add "0x" prefix here to make it even more C like
> > > and unambiguous ?
> > 
> > linux pointers are not emitted with an 0x prefix
> 
> So? This is not at all comparable to %p

Then why is x used to obfuscate?


