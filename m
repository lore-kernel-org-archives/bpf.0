Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A55C433DF
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 00:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6B620781
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 00:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDvZIDfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgF3A2e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgF3A2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 20:28:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B77C061755;
        Mon, 29 Jun 2020 17:28:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so20428049ljv.5;
        Mon, 29 Jun 2020 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky/GcqGHNaQbW8UyC2DFIfTmH0DfzCBsbbNZVB1undo=;
        b=PDvZIDfPz9cUHUS1zuwWurhdqVVSONkTw+pjfhNDfAf9rNY1g3XyAwIdeMYfNLmvYs
         GaRWySHkYzcJZva7/E9UybcgDCFGd68g4RIXm0oBTy7gVi2xw768HGXOzX/iYPy+0I4o
         u/Vnh6oQUFcgkYfWuF30nRm02Eq2hR5yWzw2x/UgiEad2+qynAite+mf1ldBimPJCBHN
         rAhXfFuwqN1w9XENokTU12rqEQgLPQEP49EdKUVYWr9Q/WcygPxive53Lg5/UW/FjQ3R
         9Cwdxkmwf6IxLAzAR6D9i5ldwMSEBYrAGu/XPNGsUbT3Jvbvk5HmO+RprAQUa7ShJfUr
         5PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky/GcqGHNaQbW8UyC2DFIfTmH0DfzCBsbbNZVB1undo=;
        b=jHdpbQfHvNPaxKVfOILeh3uklnCzr7fg0iwbjA+MhU4S3Ds9jj+e3SjIgjDD1KGB2V
         FVLJ8K8OSnp1/qfNEP2dTIOB/t1JW5KLXuAzKCjK4trnA3A91GLORxNHvIIK5hTgdLL9
         0bbzAkM71sC/f6lc/1eRUwnzkNlBN4UtACMkH47SNqstv4PpMP4AJpgp+bwd+1wFExPZ
         49Y8AHUk39XTNYLPrpTZRuuhhyZURsgIvDEfr/OC7lGcw8GlzgSgGzIUUxTb9Lf2XXcn
         PW6LPJtTBpwNcr2RLoooFsOryvo4ozFBOQDoSKRoWAhAzQGZBtIkvS0IDZ64FIVjitPo
         q94g==
X-Gm-Message-State: AOAM5332YN4vUWmLfaGjzUtxryomsQPLZ2+Yx/U3wl5EAKwpfmO2eo4P
        7aJMr3eMxXv2x0cWa1zM040naJHt7U29OhnqAtc=
X-Google-Smtp-Source: ABdhPJyWxK7dXcJnSKKEK0aQfFIf5QctEzHq84IT726/g/OmBAqYj+EpptULTmpLcjsMi69G/YRtF3bFFONlkxPqIQU=
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr6705738ljc.51.1593476911358;
 Mon, 29 Jun 2020 17:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200611222340.24081-1-alexei.starovoitov@gmail.com>
 <20200611222340.24081-3-alexei.starovoitov@gmail.com> <CAEf4BzYbvuZoQb7Sz4Q7McyEA4khHm5RaQPR3bL67owLoyv1RQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYbvuZoQb7Sz4Q7McyEA4khHm5RaQPR3bL67owLoyv1RQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Jun 2020 17:28:20 -0700
Message-ID: <CAADnVQ+ubYj8yA1_cO3aw-trShTHBRMJxSvZrLW75i8fM=mpvQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 bpf-next 2/4] bpf: Add bpf_copy_from_user() helper.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 3:33 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > + *
> > + * int bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
>
> Can we also add bpf_copy_str_from_user (or bpf_copy_from_user_str,
> whichever makes more sense) as well?

Those would have to wait. I think strings need better long term design.
That would be separate patches.
