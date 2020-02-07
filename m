Return-Path: <SRS0=Ojkz=33=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA1C2BA83
	for <bpf@archiver.kernel.org>; Fri,  7 Feb 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7862C217BA
	for <bpf@archiver.kernel.org>; Fri,  7 Feb 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581098873;
	bh=5uzkgxGCqeELC8KYnkpBNwfjAra7+P1EQUYkHe4MGWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Co+eRnHWeJnsvCS5A5PXpIvW0ZcSDQoj/XTxZlfC6FoidhDwO03NLkUtpVfbKhI+B
	 qletLs08nUys7a472FNgigiMNNWBX7LN83HZ/tEd813PIE/CzxbVy9mjO9zhp/mu09
	 SWvpfyjYJ5JhTKs29XDfh+CEnabVVHoRnAhld+sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGSHx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:07:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36928 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGSHw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 13:07:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so267478ljg.4
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ii4YAfaJ6LUAXS+i9+EEBAEXwOhLwhmJIesgnXLnmAc=;
        b=A8seTsjAN2EA8ZSrrz51PSagLWek/hwmR0O7d+YjGOF+PvcR+fBXd3sScmJqYpxswW
         JwGl0gcNajX7CahzEl279rJ3HyLZ1EIQmQwVK8gLcrnilFUz/e/rQ8atjgrUgIUdB1mC
         efkR7Ne33pYjbDHvwwqRlu8vrqSOlqu2tnYeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii4YAfaJ6LUAXS+i9+EEBAEXwOhLwhmJIesgnXLnmAc=;
        b=JJm2Tf5+WhPwio6z4MZ+7OvQC91rGBB2i6wpmwx/RhoJEYgA8PicZ7i4SYfGRuPNFc
         Ri/1yTqsB8efSveG4QKsliHaFZfP9rrfBmY1miluGxYZ8leC0oSQj4hhPtEPMK2dk7WK
         avlL90tLVseJfrmMG76N1e9FvHN27Ikm7rQioXaYh7xlq3D4RnSDq89HSb0Ig+D/nKpL
         fdZm/+DRqArudx3C3lvGvWab8sFvzVTd0rpXj8Mrlyoc62k/TjWIG/eItEs1Q6e0Mnsx
         tewpHIwafMqJr7mZWLbfhUfKgcsfbEEnoIN3biVzCm0q9bAE6pKpJcbn7WraK1mczNnl
         icxw==
X-Gm-Message-State: APjAAAWsRnoa97/UUlooWZi4UPXVTtDfYYMA+vG46qivNb3tnve2wfem
        O0c90vmFQUIjueGP/QO/fVMSFpsJGrJUQA==
X-Google-Smtp-Source: APXvYqyJz4LY2y2KjsqYo18iwClvNPQw6IqS96x/mRbEFoO1g7/s4QVZyKF2K3r99BTDBr1Ts4CIsA==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr287054ljl.56.1581098870218;
        Fri, 07 Feb 2020 10:07:50 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s15sm1585480ljs.58.2020.02.07.10.07.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 10:07:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id d10so239715ljl.9
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 10:07:48 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr303001lja.16.1581098868657;
 Fri, 07 Feb 2020 10:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20200207081810.3918919-1-kafai@fb.com>
In-Reply-To: <20200207081810.3918919-1-kafai@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 10:07:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Message-ID: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, kernel-team@fb.com,
        Linux-Sparse <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 7, 2020 at 12:18 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> It was reported that the max_t, ilog2, and roundup_pow_of_two macros have
> exponential effects on the number of states in the sparse checker.

Patch looks good, but I'd like to point out that it's not just sparse.

You can see it with a simple

    make net/core/bpf_sk_storage.i
    grep 'smap->bucket_log = ' net/core/bpf_sk_storage.i | wc

and see the end result:

      1  365071 2686974

That's one line (the assignment line) that is 2,686,974 characters in length.

Now, sparse does happen to react particularly badly to that (I didn't
look to why, but I suspect it's just that evaluating all the types
that don't actually ever end up getting used ends up being much more
expensive than it should be), but I bet it's not good for gcc either.

I do think this is a good test-case for sparse. Luc, have you looked
at what it is that then makes sparse use *so* much memory for this one
line?

             Linus
