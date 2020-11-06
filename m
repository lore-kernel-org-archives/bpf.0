Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E3C2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7339A2078B
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 21:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgKFVuf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 16:50:35 -0500
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:38860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728771AbgKFVuN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 16:50:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4980E1800F08D;
        Fri,  6 Nov 2020 21:50:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rod14_3b0fb74272d5
X-Filterd-Recvd-Size: 3501
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Nov 2020 21:50:09 +0000 (UTC)
Message-ID: <d1cefb17a0a915fdabe7a80d14895ff3d85970c1.camel@perches.com>
Subject: Re: [PATCH] libbpf: Remove unnecessary conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, xiakaixu1987@gmail.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Date:   Fri, 06 Nov 2020 13:50:08 -0800
In-Reply-To: <CAEf4BzZQ6=-h3g1duXFwDLr92z7nE6ajv8Rz_Zv=qx=-F3sRVA@mail.gmail.com>
References: <1604646759-785-1-git-send-email-kaixuxia@tencent.com>
         <CAEf4BzZQ6=-h3g1duXFwDLr92z7nE6ajv8Rz_Zv=qx=-F3sRVA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-11-06 at 13:32 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 5, 2020 at 11:12 PM <xiakaixu1987@gmail.com> wrote:
> > Fix following warning from coccinelle:
> > ./tools/lib/bpf/libbpf.c:1478:43-48: WARNING: conversion to bool not needed here
[]
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
[]
> > @@ -1475,7 +1475,7 @@ static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
> >                                 ext->name, value);
> >                         return -EINVAL;
> >                 }
> > -               *(bool *)ext_val = value == 'y' ? true : false;
> > +               *(bool *)ext_val = value == 'y';
> 
> I actually did this intentionally. x = y == z; pattern looked too
> obscure to my taste, tbh.

It's certainly a question of taste and obviously there is nothing
wrong with yours.

Maybe adding parentheses makes the below look less obscure to you?

	x = (y == z);

My taste would run to something like:
---
 tools/lib/bpf/libbpf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313034117070..5d9c9c8d50c9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1469,25 +1469,34 @@ static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
 			      char value)
 {
 	switch (ext->kcfg.type) {
-	case KCFG_BOOL:
+	case KCFG_BOOL: {
+		bool *p = ext_val;
+
 		if (value == 'm') {
 			pr_warn("extern (kcfg) %s=%c should be tristate or char\n",
 				ext->name, value);
 			return -EINVAL;
 		}
-		*(bool *)ext_val = value == 'y' ? true : false;
+		*p = (value == 'y');
 		break;
-	case KCFG_TRISTATE:
+	}
+	case KCFG_TRISTATE: {
+		enum libbpf_tristate *p = ext_val;
+
 		if (value == 'y')
-			*(enum libbpf_tristate *)ext_val = TRI_YES;
+			*p = TRI_YES;
 		else if (value == 'm')
-			*(enum libbpf_tristate *)ext_val = TRI_MODULE;
+			*p = TRI_MODULE;
 		else /* value == 'n' */
-			*(enum libbpf_tristate *)ext_val = TRI_NO;
+			*p = TRI_NO;
 		break;
-	case KCFG_CHAR:
-		*(char *)ext_val = value;
+	}
+	case KCFG_CHAR: {
+		char *p = ext_val;
+
+		*p = value;
 		break;
+	}
 	case KCFG_UNKNOWN:
 	case KCFG_INT:
 	case KCFG_CHAR_ARR:

