Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD107C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7869D2084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaakD9np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfCZUHT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:07:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfCZUHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 16:07:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so8585039pfd.0;
        Tue, 26 Mar 2019 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYLMIcdeEkCKS2Aovx/djIxhRe40NLkk9mEtYKlbJ5o=;
        b=kaakD9npah3h/rWgxq0rpUtmeq/bSc2cBAiOKMk0VDZv7J2WHVwAwfq/3E17KqfvEe
         +HTr/mdfdfSYVhQcxWJKXWn77WMfV8HsUXLyZ9r9fffvAhHv9Up2iWK1dsXAZDcfLh+D
         Hhtlr4alXELDUe4iGpCOblSfICzbulGuP4sjXa+8KBRAfc7TOVRv1w+hcJu1XM4bGQqp
         s3wME8c30XmxDMMMLgvbWl3O2+P+v4rqSalKA7CGmz+klRQ5qJJQNgLj3H6+z2t3wZ0Q
         iGqYaJcmJUrPD8aX1rZ9QMSSMuj9QbHbA9JuYqOVBapcjun2z1UEjffv0ZJ6Q5sHPpDP
         hPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYLMIcdeEkCKS2Aovx/djIxhRe40NLkk9mEtYKlbJ5o=;
        b=teYFUHeAJJKWGb3DUnMe0zOlx3vC7qhjfkTII8cj2mC6NmGF/GkFTvNQp5jiJz3aDt
         9UWQRXjJW/cnRToLULkSzd0VnoT9DfPFx85+GPCJLWqBAJThPf1EwqGUxXblmdpIuXjQ
         vG9xq/PARXd7JXdMpb1g78/t4uXGL9wYr3VkoHRVS5lEIWHo//1ftHBwp8GgyEIzcXaO
         tqtwnQt1EhsxH93rsEW37/noS5j6i6/juwX4BN1pLJsp6BTFG9FCnS860DQq8rWmBn8x
         01eciOn/B6yAjvAOThBOWT2hcI9PqI1JXE3/jDMbA4XP8lLBz2vsboieps0zxECeP6xu
         2Pdg==
X-Gm-Message-State: APjAAAXA3+11NCZaDniGztFvxpKTtnJ5dNqJFiFlv5Foh+Cv9pp/JFoS
        MEXUGnlKT6DcYr4NcV8HogU=
X-Google-Smtp-Source: APXvYqz6zXqfKbE2IRiUkawg7BvI/taf9fmdaW81wp/MpXwLKfPBxf/uYTl0+PW0ninFPChOtIMTZw==
X-Received: by 2002:a63:2ad4:: with SMTP id q203mr31389574pgq.43.1553630837668;
        Tue, 26 Mar 2019 13:07:17 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id g188sm34989228pfc.24.2019.03.26.13.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 13:07:16 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:07:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Paul Chaignon <paul.chaignon@orange.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Jakub Kicinski <jakub.kicinski@netronome.com>,
        xiao.han@orange.com, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: remove incorrect 'verifier bug' warning
Message-ID: <20190326200713.jl4vqtidjckyaypm@ast-mbp>
References: <cover.1553085539.git.paul.chaignon@orange.com>
 <e84ec4b3-ea21-a2ed-d6fb-1c899ef748d0@fb.com>
 <20190321093304.GA1001@Nover>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321093304.GA1001@Nover>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 10:33:06AM +0100, Paul Chaignon wrote:
> On Wed, Mar 20, 2019 at 11:31PM, Yonghong Song wrote:
> > On 3/20/19 5:57 AM, Paul Chaignon wrote:
> > > The BPF verifier checks the maximum number of call stack frames twice,
> > > first in the main CFG traversal (do_check) and then in a subsequent
> > > traversal (check_max_stack_depth).  If the second check fails, it logs a
> > > 'verifier bug' warning and errors out, as the number of call stack frames
> > > should have been verified already.
> > > 
> > > However, the second check may fail without indicating a verifier bug: if
> > > the excessive function calls reside in dead code, the main CFG traversal
> > > may not visit them; the subsequent traversal visits all instructions,
> > > including dead code.
> > > 
> > > This case raises the question of how invalid dead code should be treated.
> > 
> > Maybe we should do this check after dead code elimination to be 
> > consistent with do_check? There could some other kinds of illegal stuff
> 
> To be clear, are you suggesting we run check_max_stack_depth after the
> dead code elimination?  That would indeed solve this issue, but Jakub made
> the exact reverse change not so long ago, in 9b38c40 ("bpf: verifier:
> reorder stack size check with dead code sanitization").  I think the idea
> was to avoid having code modifications in between code checks.

I think it's fine fix as it is.
I've applied it to bpf tree, since the verifier shouldn't be warning like this.

As far as changing the order back I think it's good to keep 'too many frames'
check before dead code elimination.
'too many frames' is similar to 'too many instructions'.
The verifier rejects large programs before removing dead code.
So in that sense it's similar.

