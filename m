Return-Path: <SRS0=POGc=ZR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9EC432C0
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 21:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52B62071E
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 21:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z88jP1L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKYVx2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:53:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32943 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVx2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 16:53:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so17747356ljk.0;
        Mon, 25 Nov 2019 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m7PwchglaL7gwC7F2/hFZk5GC3zqJv6XKyWdmpmig0=;
        b=Z88jP1L3UQbQwCYbcFuF6ra1J7XUd8jV2yB65SV7J37hInngSHbuXvjg+3cDU6V6X4
         7AvYxJNE1js4tWO+Z5hgUZJTbaZ+jqFmA0w5OnrFVaYsG9N+VR3fqW26gke5JXhIWH7i
         x358Lz6Lv9xGYkIO2Dr2c5x/qD9ad01ousFi4H3uFbZ/6qTH6ZI1TI1jxJjzMPdU2Mnx
         eoPYVXif8unimoYn0gPyJR7IB45epP16oemj9ZH8/H6CGCtSKLQ0xzx/SKu7Yvu3soid
         f/74/dXC6o2nFSLn6BoiP07CS64eSH3+oXtNu1rOkOmcIkuOFUBWJQTMVZLP0AL7cjOy
         4AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m7PwchglaL7gwC7F2/hFZk5GC3zqJv6XKyWdmpmig0=;
        b=g9Vziu11LYI/Qn/bRQTq67Umrn9zeOuxuFccD9+qgrZL6Vpwq9NpbnDqPD3+XjMKq8
         e2brscwbzH7/rzmo/M9HAP7Dp6QJ0oPVw9GlEoaoHBcHCi7+z+G0hIckwGrnbHb1ynbQ
         QPz249UB8CrC9z+SxvT7PziYCKemaEtmBnmGvWSdsJKwtGBvTy4R8//O2MGZTZKz3v60
         w6JVb8BAaSLW+AdeyQiYcgaqlXIGJoOFtG+LwgSTG8k8KuOguVEK+S+7onV+9Vhhr0zH
         8kcrFSp/BpzlZcezrdhtxxKbplP19m9ecaMqI2RvJ9v92DMwywy1mRH9njcRtDFb+mgn
         NCwA==
X-Gm-Message-State: APjAAAXPw1SJwYSnOEW03OMjXwfh+SrbOzVXhmeJnlSX8pNRnYmWsUuY
        9jl9dmBlxTSjoevfxabTlLu+ygX+mbmeIXaKPN0=
X-Google-Smtp-Source: APXvYqy2+7ipDaEazs6p5YBh/tlKTRNCj1SJ2osGyFa6B1KbRPIno2KswQfFhSzYIYiMZFPGxXgCxsdR7tC7w2fswjk=
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr24581795lju.51.1574718805768;
 Mon, 25 Nov 2019 13:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20191125212948.1163343-1-andriin@fb.com>
In-Reply-To: <20191125212948.1163343-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 25 Nov 2019 13:53:14 -0800
Message-ID: <CAADnVQJ1NKx2u0qHe+79DKcKs0=6XXjm-hOjJ6DvU753EodWMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix usage of u32 in userspace code
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 25, 2019 at 1:30 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> u32 is not defined for libbpf when compiled outside of kernel sources (e.g.,
> in Github projection). Use __u32 instead.
>
> Fixes: b8c54ea455dc ("libbpf: Add support to attach to fentry/fexit tracing progs")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
