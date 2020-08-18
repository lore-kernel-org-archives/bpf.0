Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F359C433E3
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4191A204EA
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRKRL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:17:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38417 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRKRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 06:17:11 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7yg0-0001QO-TR; Tue, 18 Aug 2020 10:17:09 +0000
Date:   Tue, 18 Aug 2020 12:17:07 +0200
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
Subject: Re: [PATCH 16/17] file: Merge __alloc_fd into alloc_fd
Message-ID: <20200818101707.a3ikaqkpxrkcqcdr@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-16-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-16-ebiederm@xmission.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:24PM -0500, Eric W. Biederman wrote:
> The function __alloc_fd was added to support binder[1].  With binder
> fixed[2] there are no more users.  Further with get_files_struct
> removed there can be no more users of __alloc_fd that pass anything
> except current->files.
> 
> As alloc_fd just calls __alloc_fd with "files=current->files",
> merge them together by transforming the files parameter into a
> ocal variable initialized to current->files.
> 
> [1] dcfadfa4ec5a ("new helper: __alloc_fd()")
> [2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
