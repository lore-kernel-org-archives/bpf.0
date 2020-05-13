Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D26AC433DF
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F41E2054F
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 23:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgEMXFq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 19:05:46 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:57856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731815AbgEMXFq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 19:05:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2442C181D3026;
        Wed, 13 May 2020 23:05:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed96_14d1be0aeb62e
X-Filterd-Recvd-Size: 3196
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 May 2020 23:05:42 +0000 (UTC)
Message-ID: <1b63a6b193073674b6e0f9f95c62ce2af1b977cc.camel@perches.com>
Subject: Re: [PATCH v2 bpf-next 4/7] printk: add type-printing %pT format
 specifier which uses BTF
From:   Joe Perches <joe@perches.com>
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, arnaldo.melo@gmail.com, yhs@fb.com,
        kafai@fb.com, songliubraving@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Wed, 13 May 2020 16:05:41 -0700
In-Reply-To: <1589263005-7887-5-git-send-email-alan.maguire@oracle.com>
References: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
         <1589263005-7887-5-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-05-12 at 06:56 +0100, Alan Maguire wrote:
> printk supports multiple pointer object type specifiers (printing
> netdev features etc).  Extend this support using BTF to cover
> arbitrary types.  "%pT" specifies the typed format, and the pointer
> argument is a "struct btf_ptr *" where struct btf_ptr is as follows:
> 
> struct btf_ptr {
> 	void *ptr;
> 	const char *type;
> 	u32 id;
> };
> 
> Either the "type" string ("struct sk_buff") or the BTF "id" can be
> used to identify the type to use in displaying the associated "ptr"
> value.  A convenience function to create and point at the struct
> is provided:
> 
> 	printk(KERN_INFO "%pT", BTF_PTR_TYPE(skb, struct sk_buff));
> 
> When invoked, BTF information is used to traverse the sk_buff *
> and display it.  Support is present for structs, unions, enums,
> typedefs and core types (though in the latter case there's not
> much value in using this feature of course).
> 
> Default output is indented, but compact output can be specified
> via the 'c' option.  Type names/member values can be suppressed
> using the 'N' option.  Zero values are not displayed by default
> but can be using the '0' option.  Pointer values are obfuscated
> unless the 'x' option is specified.  As an example:
> 
>   struct sk_buff *skb = alloc_skb(64, GFP_KERNEL);
>   pr_info("%pT", BTF_PTR_TYPE(skb, struct sk_buff));
> 
> ...gives us:
> 
> (struct sk_buff){
>  .transport_header = (__u16)65535,
> 	 .mac_header = (__u16)65535,
>  .end = (sk_buff_data_t)192,
>  .head = (unsigned char *)000000006b71155a,
>  .data = (unsigned char *)000000006b71155a,
>  .truesize = (unsigned int)768,
>  .users = (refcount_t){
>   .refs = (atomic_t){
>    .counter = (int)1,

Given

  #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)

Maybe

  #define BTF_INT_SIGNED  (1 << 0)
  #define BTF_INT_CHAR    (1 << 1)
  #define BTF_INT_BOOL    (1 << 2)

could be extended to include

  #define BTF_INT_HEX     (1 << 3)

So hex values can be appropriately pretty-printed.


