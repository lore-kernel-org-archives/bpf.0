Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB1BC433E3
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFED20789
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 10:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRKMc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:12:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38179 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgHRKMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 06:12:30 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7ybT-0000x6-I9; Tue, 18 Aug 2020 10:12:27 +0000
Date:   Tue, 18 Aug 2020 12:12:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 15/17] file: In f_dupfd read RLIMIT_NOFILE once.
Message-ID: <20200818101226.weamow3swms6xizm@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-15-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-15-ebiederm@xmission.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:23PM -0500, Eric W. Biederman wrote:
> Simplify the code, and remove the chance of races by reading
> RLIMIT_NOFILE only once in f_dupfd.
> 
> Pass the read value of RLIMIT_NOFILE into alloc_fd which is the other
> location the rlimit was read in f_dupfd.  As f_dupfd is the only
> caller of alloc_fd this changing alloc_fd is trivially safe.
> 
> Further this causes alloc_fd to take all of the same arguments as
> __alloc_fd except for the files_struct argument.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
