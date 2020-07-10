Return-Path: <SRS0=293s=AV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E09C433DF
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C662078B
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 19:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJThv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:37:51 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:42658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgGJThv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 15:37:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 68277100E7B48;
        Fri, 10 Jul 2020 19:37:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: prose65_0f116ea26ed0
X-Filterd-Recvd-Size: 2625
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jul 2020 19:37:48 +0000 (UTC)
Message-ID: <28a81dfe62b1dc00ccc721ddb88669d13665252b.camel@perches.com>
Subject: Re: [PATCH v2] MAINTAINERS: XDP: restrict N: and K:
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, ast@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com,
        mchehab+huawei@kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 10 Jul 2020 12:37:47 -0700
In-Reply-To: <20200710190407.31269-1-grandmaster@al2klimov.de>
References: <87tuyfi4fm.fsf@toke.dk>
         <20200710190407.31269-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-07-10 at 21:04 +0200, Alexander A. Klimov wrote:
> Rationale:
> Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
> which has nothing to do with XDP.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Better?
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d4aa7f942de..735e2475e926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18708,8 +18708,8 @@ F:	include/trace/events/xdp.h
>  F:	kernel/bpf/cpumap.c
>  F:	kernel/bpf/devmap.c
>  F:	net/core/xdp.c
> -N:	xdp
> -K:	xdp
> +N:	(?:\b|_)xdp
> +K:	(?:\b|_)xdp

Generally, it's better to have comprehensive files lists
rather than adding name matching regexes.

Perhaps:
---
 MAINTAINERS | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16854e47e8cb..2e96cbf15b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18763,13 +18763,19 @@ M:	John Fastabend <john.fastabend@gmail.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
-F:	include/net/xdp.h
+F:	Documentation/networking/af_xdp.rst
+F:	include/net/xdp*
 F:	include/trace/events/xdp.h
+F:	include/uapi/linux/if_xdp.h
+F:	include/uapi/linux/xdp_diag.h
 F:	kernel/bpf/cpumap.c
 F:	kernel/bpf/devmap.c
 F:	net/core/xdp.c
-N:	xdp
-K:	xdp
+F:	net/xdp/
+F:	samples/bpf/xdp*
+F:	tools/testing/selftests/bfp/*xdp*
+F:	tools/testing/selftests/bfp/*/*xdp*
+K:	(?:\b|_)xdp(?:\b|_)
 
 XDP SOCKETS (AF_XDP)
 M:	Björn Töpel <bjorn.topel@intel.com>


