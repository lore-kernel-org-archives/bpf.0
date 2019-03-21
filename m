Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C66C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AC121873
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 09:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCUJdF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:33:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfCUJdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 05:33:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so5805919wrq.1;
        Thu, 21 Mar 2019 02:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gk/VKXqBsbEMILFxooKia4KIiWqSwI8S8szneldF/cY=;
        b=q/4YQOzWXn+Ysq4bFwmEBHw3wi37RwUUz4pgUmV6SfcakM9zW8Jb5iMrXiqUIpj0V2
         8F/MX6/adJ2q4cdZfii6V19WX7bu8AKRPzl6bAtuKVrHEtUjx58Rk470S4/EAb7D1hTn
         m0SBRzHsSqI+41ljl8l1ys32HUpDX6bpeiJbvQr1DyKuqZbrF32oSt55VKpJRWn6H94M
         ivLRNqjaYWBv+L8A+/tWuetaz+MEMV9sxqTdY3PdeDvYVHR8v1u9Tqz6vKSEWKgfsNCV
         4xKzRB869s3gew/hqkalFoIv1bvgzz3OD/Mc5s5Hmv8G7whscN4dS3P1PwejNd1jdh1I
         MzOw==
X-Gm-Message-State: APjAAAVRKlNH92Tjfy3QS6H/J/vof2n18QOlAdMQhUnwpFuBI+EqZtJM
        jP8RoIeSPJ7amNQVdHVJMZs=
X-Google-Smtp-Source: APXvYqwXFUiVh9V9SDPoKmq1CjtN3mnnu0UHhwGx5fb9okbGpVaBx5YGxUFXDlam/UM/8NiwZN/2Ew==
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr1721671wro.323.1553160783068;
        Thu, 21 Mar 2019 02:33:03 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id n11sm9806156wrt.63.2019.03.21.02.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 02:33:02 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:33:06 +0100
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>, xiao.han@orange.com,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: remove incorrect 'verifier bug' warning
Message-ID: <20190321093304.GA1001@Nover>
References: <cover.1553085539.git.paul.chaignon@orange.com>
 <e84ec4b3-ea21-a2ed-d6fb-1c899ef748d0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84ec4b3-ea21-a2ed-d6fb-1c899ef748d0@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 11:31PM, Yonghong Song wrote:
> On 3/20/19 5:57 AM, Paul Chaignon wrote:
> > The BPF verifier checks the maximum number of call stack frames twice,
> > first in the main CFG traversal (do_check) and then in a subsequent
> > traversal (check_max_stack_depth).  If the second check fails, it logs a
> > 'verifier bug' warning and errors out, as the number of call stack frames
> > should have been verified already.
> > 
> > However, the second check may fail without indicating a verifier bug: if
> > the excessive function calls reside in dead code, the main CFG traversal
> > may not visit them; the subsequent traversal visits all instructions,
> > including dead code.
> > 
> > This case raises the question of how invalid dead code should be treated.
> 
> Maybe we should do this check after dead code elimination to be 
> consistent with do_check? There could some other kinds of illegal stuff

To be clear, are you suggesting we run check_max_stack_depth after the
dead code elimination?  That would indeed solve this issue, but Jakub made
the exact reverse change not so long ago, in 9b38c40 ("bpf: verifier:
reorder stack size check with dead code sanitization").  I think the idea
was to avoid having code modifications in between code checks.

> in the dead code, e.g., illegal/unsupported helpers, etc. I suppose we 
> did not warn or reject the program, right?

As far as I know, we do not warn or reject the programs for other illegal
stuff found in dead code, no.

> 
> > The first patch implements the conservative option and rejects such code;
> > the second adds a test case.
> > 
> > Paul Chaignon (2):
> >    bpf: remove incorrect 'verifier bug' warning
> >    selftests/bpf: test case for invalid call stack in dead code
> > 
> >   kernel/bpf/verifier.c                        |  5 +--
> >   tools/testing/selftests/bpf/verifier/calls.c | 38 ++++++++++++++++++++
> >   2 files changed, 41 insertions(+), 2 deletions(-)
> > 
