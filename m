Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC6C433DF
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C1B2078D
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 09:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFKJFX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:05:23 -0400
Received: from sym2.noone.org ([178.63.92.236]:49376 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKJFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 05:05:23 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49jHxs3Rtfzvjc1; Thu, 11 Jun 2020 11:05:21 +0200 (CEST)
Date:   Thu, 11 Jun 2020 11:05:20 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] tools, bpftool: check return value of function
 codegen
Message-ID: <20200611090519.nweut5dzvsc6phxd@distanz.ch>
References: <20200610130807.21497-1-tklauser@distanz.ch>
 <CAEf4Bzbiz6qST5Ws4pKB4qZdqfwG_12UgFeQk96da1qipAJS9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbiz6qST5Ws4pKB4qZdqfwG_12UgFeQk96da1qipAJS9Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-10 at 20:50:06 +0200, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> On Wed, Jun 10, 2020 at 6:09 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > The codegen function might fail an return an error. Check its return
> > value in all call sites and handle it properly.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> codegen() can fail only if the system ran out of memory or the static
> template is malformed. Both are highly unlikely. I wonder if the
> better approach would be to just exit(1) on such an unlikely error
> inside codegen() and make the function itself void-returning.
> 
> We'll probably expand codegen to other languages soon, so not having
> to do those annoying error checks everywhere is a good thing.
> 
> What do you think?

Sounds good to me, thanks. I'll send a v2 implementing your suggestion.
