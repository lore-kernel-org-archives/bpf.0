Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D5DC433DB
	for <bpf@archiver.kernel.org>; Fri, 25 Dec 2020 23:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F55622286
	for <bpf@archiver.kernel.org>; Fri, 25 Dec 2020 23:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLYXBi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Dec 2020 18:01:38 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:49070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgLYXBi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Dec 2020 18:01:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D7F36100E7B43;
        Fri, 25 Dec 2020 23:00:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice07_1a0bb6b2747d
X-Filterd-Recvd-Size: 2936
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Dec 2020 23:00:54 +0000 (UTC)
Message-ID: <8401b60d35698e68bcf84e977b1b735c131d0b1e.camel@perches.com>
Subject: Re: [PATCH] nfp: remove h from printk format specifier
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Simon Horman <simon.horman@netronome.com>
Cc:     kuba@kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, gustavoars@kernel.org,
        louis.peens@netronome.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Dec 2020 15:00:52 -0800
In-Reply-To: <65755252-96c3-a808-3e01-e377dd395ee7@redhat.com>
References: <20201223202053.131157-1-trix@redhat.com>
         <20201224202152.GA3380@netronome.com>
         <bac92bab-243b-ca48-647c-dad5688fa060@redhat.com>
         <18c81854639aa21e76c8b26cc3e7999b0428cc4e.camel@perches.com>
         <7b5517e6-41a9-cc7f-f42f-8ef449f3898e@redhat.com>
         <327d6cad23720c8fe984aa75a046ff69499568c8.camel@perches.com>
         <65755252-96c3-a808-3e01-e377dd395ee7@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-12-25 at 14:13 -0800, Tom Rix wrote:
> On 12/25/20 9:06 AM, Joe Perches wrote:
> > On Fri, 2020-12-25 at 06:56 -0800, Tom Rix wrote:
> > > On 12/24/20 2:39 PM, Joe Perches wrote:
> > []
> > > > Kernel code doesn't use a signed char or short with %hx or %hu very often
> > > > but in case you didn't already know, any signed char/short emitted with
> > > > anything like %hx or %hu needs to be left alone as sign extension occurs so:
> > > Yes, this would also effect checkpatch.
> > Of course but checkpatch is stupid and doesn't know types
> > so it just assumes that the type argument is not signed.
> > 
> > In general, that's a reasonable but imperfect assumption.
> > 
> > coccinelle could probably do this properly as it's a much
> > better parser.  clang-tidy should be able to as well.
> > 
> Ok.
> 
> But types not matching the format string is a larger problem.
> 
> Has there been an effort to clean these up ?

Not really no.  __printf already does a reasonable job for that.

The biggest issue for format type mismatches is the %p<foo> extensions.

__printf can only verify that the argument is a pointer, not
necessarily the 'right' type of pointed to object.

There are overflow possibilities like '"%*ph", len, pointer'
where pointer may not have len bytes available and, for instance,
mismatched uses of %pI4 and %pI6 where %pI4 expects a pointer to
4 bytes and %pI6 expects a pointer to 16 bytes.

Anyway it's not that easy a problem to analyze.

