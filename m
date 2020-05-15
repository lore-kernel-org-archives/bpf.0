Return-Path: <SRS0=Xcm6=65=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FECFC433DF
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E773206D8
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgEOAVe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 20:21:34 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:42922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgEOAVe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 20:21:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4B7DC182CF665;
        Fri, 15 May 2020 00:21:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jail96_d319c96b8102
X-Filterd-Recvd-Size: 2463
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 00:21:30 +0000 (UTC)
Message-ID: <0e9b255313e07b24504a5bcebf56ab5a7839eb1f.camel@perches.com>
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
Date:   Thu, 14 May 2020 17:21:29 -0700
In-Reply-To: <20200515000920.2el4jyrwqqbd6jw3@ast-mbp.dhcp.thefacebook.com>
References: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
         <1589263005-7887-5-git-send-email-alan.maguire@oracle.com>
         <1b63a6b193073674b6e0f9f95c62ce2af1b977cc.camel@perches.com>
         <CAADnVQK8osy9W8-u-K=ucqe5q-+Uik41fBw6d-SfG-m6rgVwDQ@mail.gmail.com>
         <397fb29abb20d11003a18919ee0c44918fc1a165.camel@perches.com>
         <28145b05ee792b89ab9cb560f4f9989fd3d5d93b.camel@perches.com>
         <20200515000920.2el4jyrwqqbd6jw3@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-05-14 at 17:09 -0700, Alexei Starovoitov wrote:
> On Thu, May 14, 2020 at 04:43:24PM -0700, Joe Perches wrote:
> >  The ``BTF_INT_BITS()`` specifies the number of actual bits held by this int
> >  type. For example, a 4-bit bitfield encodes ``BTF_INT_BITS()`` equals to 4.
> > diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > index 5a667107ad2c..36f309209786 100644
> > --- a/include/uapi/linux/btf.h
> > +++ b/include/uapi/linux/btf.h
> > @@ -90,6 +90,7 @@ struct btf_type {
> >  #define BTF_INT_SIGNED	(1 << 0)
> >  #define BTF_INT_CHAR	(1 << 1)
> >  #define BTF_INT_BOOL	(1 << 2)
> > +#define BTF_INT_HEX	(1 << 3)
> 
> Nack.
> Hex is not a type.

It is a pretty print output format.

