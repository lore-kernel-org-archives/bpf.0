Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ADBC433E6
	for <bpf@archiver.kernel.org>; Thu, 24 Dec 2020 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8903B22AAC
	for <bpf@archiver.kernel.org>; Thu, 24 Dec 2020 22:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgLXWkC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:40:02 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:41052 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728851AbgLXWkC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Dec 2020 17:40:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A7570100E7B44;
        Thu, 24 Dec 2020 22:39:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rose20_22010c527474
X-Filterd-Recvd-Size: 3246
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Dec 2020 22:39:17 +0000 (UTC)
Message-ID: <18c81854639aa21e76c8b26cc3e7999b0428cc4e.camel@perches.com>
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
Date:   Thu, 24 Dec 2020 14:39:16 -0800
In-Reply-To: <bac92bab-243b-ca48-647c-dad5688fa060@redhat.com>
References: <20201223202053.131157-1-trix@redhat.com>
         <20201224202152.GA3380@netronome.com>
         <bac92bab-243b-ca48-647c-dad5688fa060@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-12-24 at 14:14 -0800, Tom Rix wrote:
> On 12/24/20 12:21 PM, Simon Horman wrote:
> > On Wed, Dec 23, 2020 at 12:20:53PM -0800, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > This change fixes the checkpatch warning described in this commit
> > > commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
> > > 
> > > Standard integer promotion is already done and %hx and %hhx is useless
> > > so do not encourage the use of %hh[xudi] or %h[xudi].
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > Hi Tom,
> > 
> > This patch looks appropriate for net-next, which is currently closed.
> > 
> > The changes look fine, but I'm curious to know if its intentionally that
> > the following was left alone in ethernet/netronome/nfp/nfp_net_ethtool.c:nfp_net_get_nspinfo()
> > 
> > 	snprintf(version, ETHTOOL_FWVERS_LEN, "%hu.%hu"
> 
> I am limiting changes to logging functions, what is roughly in checkpatch.
> 
> I can add this snprintf in if you want.

I'm a bit confused here Tom.

I thought your clang-tidy script was looking for anything marked with
__printf() that is using %h[idux] or %hh[idux].

Wouldn't snprintf qualify for this already?

include/linux/kernel.h-extern __printf(3, 4)
include/linux/kernel.h:int snprintf(char *buf, size_t size, const char *fmt, ...);

Kernel code doesn't use a signed char or short with %hx or %hu very often
but in case you didn't already know, any signed char/short emitted with
anything like %hx or %hu needs to be left alone as sign extension occurs so:

	signed char foo = -1;
	printk("%hx", foo);

emits ffff but

	printk("%x", foo);

emits ffffffff

An example:

$ gcc -x c -
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	signed short i = -1;
	printf("hx: %hx\n", i);
	printf("x:  %x\n", i);
	printf("hu: %hu\n", i);
	printf("u:  %u\n", i);
	return 0;
}

$ ./a.out
hx: ffff
x:  ffffffff
hu: 65535
u:  4294967295

$


