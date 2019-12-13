Return-Path: <SRS0=VESP=2D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F5C43603
	for <bpf@archiver.kernel.org>; Fri, 13 Dec 2019 06:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C24424656
	for <bpf@archiver.kernel.org>; Fri, 13 Dec 2019 06:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyOLUFSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfLMGx1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Dec 2019 01:53:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43507 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMGx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 01:53:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so906430qke.10
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQrHK3SFjSwlbenY+QXi5vScukZqlsVDKjP4z7qTh5o=;
        b=ZyOLUFSXCb/mLfJ7LV7o0od477OF4Oq8SkYdaPOvvnXwzdKLgIBTSULtup7vN1abD8
         54ciOyL2HqZNUz4YcyxcJmb8v3GDg7pv5bmFr9k6fP8cmLd0L7z3pY1LFrI7pKLzZ+2G
         VzJ3qajlK6kqoK1tvkqbtq31QFfX2zF+lnPsiLakIiNhWc36mFejpACI47OuzCsm5b2T
         vBBLTI2DioAxAW9SnxkNf1bDro4dJby400d2C6Wfvtx+gv5NSJDm64r+5JNF1PosLwHc
         q748fh21HwRculPo/mOJx7DX+FnSCSJgsobvrRpqK1IRPDN0J1NFFEh4+7EXOvrKcG3F
         jf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQrHK3SFjSwlbenY+QXi5vScukZqlsVDKjP4z7qTh5o=;
        b=nUl9lYvm5cR0jV5lH33hUhxb/8nlpeHzCPgWfz8wxT3ErvBAyuQ9dHcRpZpx0Rsgk9
         D1anKPnltqu562EuOiCo+AUUN5XcgLbXoFqArIIX6rbwbfqHUeNrqrVm/zknielA5oVU
         EVl/o+uz3HgQhKcHAxTOtMnEbhgKab4/sXyv6kI0a1YaEgijUv39soI6uH4yn3o4FQFy
         PFEEph8j6TB/JeUlt1zWdmnQjlGIkSVXZMVQ1Jt2z5l5elspevOoxMM559EqLyf65Mk3
         sC2aTzo4ptAgK6fqOxtKDAPCMJFSCosYgjGpEzmCgUK4JExlOb8D3KTgkDT4loC9m5C2
         VHVg==
X-Gm-Message-State: APjAAAWlEiOA+PUJ6LCFi39hbxTivSdSjs8J2hslzyp3W/+ZFSzBsg9P
        JDEWuClK8HvhwcWhksSrs8s92ZgX0KVba1vbIQ82qA==
X-Google-Smtp-Source: APXvYqya/U8A5HQX0Wni2+D1ldu6d0MfsKkN73IzuIA4iYfMLNjx8drr4P2x07sX8QydLnNAi/AGkUhD7JW8uDvtwU8=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr12317990qkj.36.1576220006474;
 Thu, 12 Dec 2019 22:53:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576193131.git.rdna@fb.com> <db7f94fd1735a28b6729a7f908c1a219af046dec.1576193131.git.rdna@fb.com>
In-Reply-To: <db7f94fd1735a28b6729a7f908c1a219af046dec.1576193131.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Dec 2019 22:53:15 -0800
Message-ID: <CAEf4BzZxjPQm+oT4NdmqLEFAgecpoWuH3kAFz821nDP8sHP0Eg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] libbpf: Make DECLARE_LIBBPF_OPTS
 available in bpf.h
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 3:34 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> DECLARE_LIBBPF_OPTS is the way to use option structures in a backward
> compatible and extensible way. It's available only in libbpf.h.  Though
> public interfaces in bpf.h have the same requirement  to accept options
> in a way that can be simply extended w/o introducing new xattr-functions
> every time.
>
> libbpf.c depends on bpf.h, hence to share the macros a couple of options
> exist:
> * either a common header should be introduced;
> * or the macro can be moved to bpf.h and used by libbpf.h from there;
>
> The former seems to be an overkill, so do the latter:
> * move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h;
> * move `#include "bpf.h"` from libbpf.c to libbpf.h not to break users
>   of the macro who already include only libbpf.h.
>
> That makes the macro available to use in bpf.{h,c} and should not break
> those who already use it.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf.h    | 22 ++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c |  1 -
>  tools/lib/bpf/libbpf.h | 24 ++----------------------
>  3 files changed, 24 insertions(+), 23 deletions(-)
>

[...]
