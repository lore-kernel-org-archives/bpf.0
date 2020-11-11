Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FCFC388F9
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 04:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D07221D46
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 04:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DseyhlyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKET2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Nov 2020 23:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKET2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 23:19:28 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171AAC0613D1;
        Tue, 10 Nov 2020 20:19:28 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r9so1304511lfn.11;
        Tue, 10 Nov 2020 20:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWyRroJ3RNkhusZjgAorzjaSvan2R6BHzQllFfkrQwQ=;
        b=DseyhlyBXLuC8Zp7AwcNqINWPzJdt0NYmv09nhYDra227p20ihd2UO3uyoIyT+NBma
         9LF/dNUK0NLjnVlSo8LeuwkCibKv9oODryuqJ2BkPRAlgKp0zNH1XDJUDgwApJ5ycho9
         utXkZJs2UqST2k91iVh0NqN9ymoVu5AfggksWwQwlKnm3ZsF922RAN5vpX/6uyeE+GON
         r07sqON/U4XOtTjJQFScnJqc9WTpxcRrhl6i80+WBkfX9JrZT7pILF1mGbvoLXRzh99a
         7mBz3j666Zn6papYC48YXCKx4hEsYqS0jvOpDd9cDyJBWRD+kYyhA4KLDguZ7AVJ+vFl
         hZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWyRroJ3RNkhusZjgAorzjaSvan2R6BHzQllFfkrQwQ=;
        b=nDECJyJfsgQ8f2NqboST06LC3hWXLG073ghJVdnuAquLLfEHh2qeksClLV7kyrhhEl
         1IWmIHdEMoemcAk5tDq8mw+V8sgozA9WN4dLv5vprjCGMcxGeNGI/+l5+lFh62mCuQa7
         aRP2yEINhZ7gLDUIYqopbsTIAa6EGSho6lRaA9V9dr/vR6mnqgbBRLOT9S86TlX84xmU
         gHA+CinlHJezneILQpm9QjdxC1H+DtVJFvd4Pq9+MaauIuNy8l7sdT0D9NwUi+k0FZya
         TpPY/GKucebuzSu3XZLEZi7/1AtFSwDGHOE8UxTh2wrVrxxz/KI8XcLcwqgmuCwVN8xp
         ewfA==
X-Gm-Message-State: AOAM531VDJ0tHZqQcjKwQKWu1EaFMwctJS4OZptEz/qbsWE1G1+p+TpD
        OABnseBt528TeiGUqI3L3O0LHiPCOQVJXeoKwjyE6ty0
X-Google-Smtp-Source: ABdhPJyM5etU37avOmTnkzP1pHfdT/6el78flRDKx0QMekqQ4XVduj3J4vHjU+fGpDGFT8jHXjCfVWfUncuu8Y+yaR8=
X-Received: by 2002:ac2:4645:: with SMTP id s5mr5541262lfo.196.1605068366400;
 Tue, 10 Nov 2020 20:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20201111040645.903494-1-andrii@kernel.org>
In-Reply-To: <20201111040645.903494-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 Nov 2020 20:19:14 -0800
Message-ID: <CAADnVQKSWkpOKxqKVE1qUxSY8aj_L=XKMYqwKN4V3vzC1ZF2nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: compile out btf_parse_module() if module
 BTF is not enabled
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 8:07 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Make sure btf_parse_module() is compiled out if module BTFs are not enabled.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Applied. Thanks for quick fix.
