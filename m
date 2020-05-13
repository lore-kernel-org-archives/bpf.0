Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E15C433DF
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65A72065C
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbgEMXWG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 19:22:06 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:57482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732374AbgEMXWG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 19:22:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2289E4417;
        Wed, 13 May 2020 23:22:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hill76_11e14f6e0db02
X-Filterd-Recvd-Size: 4046
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 May 2020 23:22:02 +0000 (UTC)
Message-ID: <397fb29abb20d11003a18919ee0c44918fc1a165.camel@perches.com>
Subject: Re: [PATCH v2 bpf-next 4/7] printk: add type-printing %pT format
 specifier which uses BTF
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
Date:   Wed, 13 May 2020 16:22:01 -0700
In-Reply-To: <CAADnVQK8osy9W8-u-K=ucqe5q-+Uik41fBw6d-SfG-m6rgVwDQ@mail.gmail.com>
References: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
         <1589263005-7887-5-git-send-email-alan.maguire@oracle.com>
         <1b63a6b193073674b6e0f9f95c62ce2af1b977cc.camel@perches.com>
         <CAADnVQK8osy9W8-u-K=ucqe5q-+Uik41fBw6d-SfG-m6rgVwDQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-05-13 at 16:07 -0700, Alexei Starovoitov wrote:
> On Wed, May 13, 2020 at 4:05 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2020-05-12 at 06:56 +0100, Alan Maguire wrote:
> > > printk supports multiple pointer object type specifiers (printing
> > > netdev features etc).  Extend this support using BTF to cover
> > > arbitrary types.  "%pT" specifies the typed format, and the pointer
> > > argument is a "struct btf_ptr *" where struct btf_ptr is as follows:
> > > 
> > > struct btf_ptr {
> > >       void *ptr;
> > >       const char *type;
> > >       u32 id;
> > > };
> > > 
> > > Either the "type" string ("struct sk_buff") or the BTF "id" can be
> > > used to identify the type to use in displaying the associated "ptr"
> > > value.  A convenience function to create and point at the struct
> > > is provided:
> > > 
> > >       printk(KERN_INFO "%pT", BTF_PTR_TYPE(skb, struct sk_buff));
> > > 
> > > When invoked, BTF information is used to traverse the sk_buff *
> > > and display it.  Support is present for structs, unions, enums,
> > > typedefs and core types (though in the latter case there's not
> > > much value in using this feature of course).
> > > 
> > > Default output is indented, but compact output can be specified
> > > via the 'c' option.  Type names/member values can be suppressed
> > > using the 'N' option.  Zero values are not displayed by default
> > > but can be using the '0' option.  Pointer values are obfuscated
> > > unless the 'x' option is specified.  As an example:
> > > 
> > >   struct sk_buff *skb = alloc_skb(64, GFP_KERNEL);
> > >   pr_info("%pT", BTF_PTR_TYPE(skb, struct sk_buff));
> > > 
> > > ...gives us:
> > > 
> > > (struct sk_buff){
> > >  .transport_header = (__u16)65535,
> > >        .mac_header = (__u16)65535,
> > >  .end = (sk_buff_data_t)192,
> > >  .head = (unsigned char *)000000006b71155a,
> > >  .data = (unsigned char *)000000006b71155a,
> > >  .truesize = (unsigned int)768,
> > >  .users = (refcount_t){
> > >   .refs = (atomic_t){
> > >    .counter = (int)1,
> > 
> > Given
> > 
> >   #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
> > 
> > Maybe
> > 
> >   #define BTF_INT_SIGNED  (1 << 0)
> >   #define BTF_INT_CHAR    (1 << 1)
> >   #define BTF_INT_BOOL    (1 << 2)
> > 
> > could be extended to include
> > 
> >   #define BTF_INT_HEX     (1 << 3)
> > 
> > So hex values can be appropriately pretty-printed.
> 
> Nack to that.

why?


