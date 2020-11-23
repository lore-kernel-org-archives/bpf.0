Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BDC388F9
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 21:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29A5206F1
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 21:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHs7K1/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKWVFU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgKWVFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 16:05:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C151C0613CF;
        Mon, 23 Nov 2020 13:05:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s27so5789275lfp.5;
        Mon, 23 Nov 2020 13:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LJyE9YuX2RfAEwKyIrOCwGZDsAcIyd05086Ij1YWFh0=;
        b=AHs7K1/yUwaw7ZLSmQipmdw+9/wHC8rAVQNTWJtBo0g+CHYLDoqvk/9V3a+aAqPFs6
         4oUzdpotnVHThmXDV2Z9WbCn1i76TC31ok6gCTXX+Oyl6kXmNGjfl6ya0XlWgoQxRhru
         jP8cwLFLVRlwweqJ1v3WjcJESm1KaTCi6bEqQmEpVKf+qkXgEJj0INHzCdWz+WgTAM1K
         XQIwZa/4GToexddk14VWaks329oanEa4dVk4GD4O5frHqP5s6HQUwcLQH1TtPm4GhaBU
         Ff+QsAwmFxxt2UhU9q+F2Yw942eZsRj15KCUPnqmUeOPhD3do8gARwMVYWmxHpCx/bra
         Q83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LJyE9YuX2RfAEwKyIrOCwGZDsAcIyd05086Ij1YWFh0=;
        b=cj6f1Yh+8+YTTHVZfhU5PsTEYuqxptTneDpljk+WbxavQD34/URDky8+IpaYnbHGO7
         z9kZDvxSLDtNyNCewA0cn3SbsmBjkuUmCGZs2dKwKYGpzU3SsfMfEkD3Yjw0E7JHBbZv
         7SA23siAUlXoNL7c2dZM+fPVHTWeUjY2akdYr/uk7QcFqoAfjhBwIQHbZKn/4JWNutII
         T0nfj82/uP6+gb7586mWAJiCeY5r6N5rkOX++OMK/c61eQY7T45pcGxEVnd3sat/qjlb
         xwS9eyS+1F7IPpoP2j3BarKNpBrUxZndbZNouHLDNh2wFDDuu9tjgOURioCjBrCdtsfP
         ZgMg==
X-Gm-Message-State: AOAM530SMayZSqBPOljfw6nBV/xm971WjWEOdiUKy3I9hWdaVRjas6mN
        VfpsxfICKFFGKONNFwRYtN0=
X-Google-Smtp-Source: ABdhPJyHtRXzNWUgcBH0BFG7IsPKUJzRD1eMIs1bfiK+VvpAMHbuRRCCVsyMTqUWzWSYFaRW1bYpng==
X-Received: by 2002:ac2:5092:: with SMTP id f18mr433909lfm.440.1606165516537;
        Mon, 23 Nov 2020 13:05:16 -0800 (PST)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id s62sm85080lja.102.2020.11.23.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:05:14 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id B31D51A0078; Tue, 24 Nov 2020 00:05:13 +0300 (MSK)
Date:   Tue, 24 Nov 2020 00:05:13 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 13/24] kcmp: In get_file_raw_ptr use task_lookup_fd_rcu
Message-ID: <20201123210513.GJ875895@grain>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120231441.29911-13-ebiederm@xmission.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 05:14:30PM -0600, Eric W. Biederman wrote:
> Modify get_file_raw_ptr to use task_lookup_fd_rcu.  The helper
> task_lookup_fd_rcu does the work of taking the task lock and verifying
> that task->files != NULL and then calls files_lookup_fd_rcu.  So let
> use the helper to make a simpler implementation of get_file_raw_ptr.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>

Since I wrote this kcmp code in first place. Thanks Eric!
