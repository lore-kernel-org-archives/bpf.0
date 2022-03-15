Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E5C433EF
	for <bpf@archiver.kernel.org>; Tue, 15 Mar 2022 19:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbiCOTHD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351337AbiCOTG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:06:56 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [142.44.231.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D4E2E;
        Tue, 15 Mar 2022 12:04:59 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUCP3-00BlnI-Ls; Tue, 15 Mar 2022 19:00:17 +0000
Date:   Tue, 15 Mar 2022 19:00:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Message-ID: <YjDiQbam/P+KkgKE@zeniv-ca.linux.org.uk>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk>
 <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk>
 <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 10:27:39AM -0700, Hao Luo wrote:

> Option 1: We can put restrictions on the pathname passed into this
> helper. We can explicitly require the parameter dirfd to be in bpffs
> (we can verify). In addition, we check pathname to be not containing
> any dot or dotdot, so the resolved path will end up inside bpffs,
> therefore won't take ->i_rwsem that is in the callchain of
> cgroup_mkdir().

Won't be enough - mount --bind the parent under itself and there you go...
Sure, you could prohibit mountpoint crossing, etc., but at that point
I'd question the usefulness of pathname resolution in the first place.
