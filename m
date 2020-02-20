Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16705C5ACC4
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18DD2465D
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp93ntno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBTAHu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:07:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43559 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBTAHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 19:07:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so1556257lfq.10
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQz/XwcttCL4GEzTip6199+g9bo868cN9Wau5KE7uuo=;
        b=Yp93ntnoE2q1cS0XKhdsG5QQ3L4Zt9ApYKimz+is5phzner7SaClKCgJzofsKdFVXn
         7NhG5dANOBNWMBgEYioX6w/Cp9Jy9OgNhBq2SnhkXLgYZ8So7oABu1iMug/bVelcf3ss
         2rbX5UM2y+I0Nsykj0EyeUst/E41d6dsDUBgnnZ4P9LF5tPOz9ACGLxdZCcNhNys5AzO
         tdAg84McY7b0iCgKxXKKUoZhdP8Mvo9KnxTR3hMqhlfXSsKr+xuwPfZU9rfQITpaE4Xq
         K/tQlkD76UWNAjLu+UFi++4sob7Eb3rmHUXVvkqL4a58uJcDS6zbr72iauq9Vzy/xaHL
         6ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQz/XwcttCL4GEzTip6199+g9bo868cN9Wau5KE7uuo=;
        b=LQJRaes8okt4ZmPg6slHmOq1MCiVYE28JCvkhMFzaOzlGkvrDSGpb861HX2dHeHXpb
         g1tLA6sbK+EA+XEuaW5afnq3aRuSfBg881Ys0qfdq0NQzWfysEyQjnH1N4Y0/fYsL9PP
         cuvosZrB1LZeWMnQ3tQd/vlIx3uYbzxrrkvv72msWUuYYqEcTl8CkeVio+p71qh7pLXJ
         9UEMNhkVkePwY4Yd5DLVw2sTFzJtc0Gt+aehmYpBQZw/lA0ugA8Qz8GjkcusDkoRP2AS
         QetWkEaMRrnmtuUHmVHrbSUPoqsh7lDakh3CVikPlZNt3qATqrBGE6ZzO+JquqxZY28Y
         NbpQ==
X-Gm-Message-State: APjAAAVyVrT7IKR9GCclsUyuP+7LgrDFzdPBQAoabHs1+SpturnOR39k
        vLyMgtW2/Kc2VdAPTWGYiwrsGe76ZW//HQ43mkA=
X-Google-Smtp-Source: APXvYqwNsVZJKP/NjBl1WOqbe2FEBnEKUCqO8T1A65s0hKFjEapZLxZysvFBp7kQcr2M2xOg6uHvEDA79wddZ6OlRJY=
X-Received: by 2002:ac2:4647:: with SMTP id s7mr496688lfo.73.1582157268281;
 Wed, 19 Feb 2020 16:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20200219234757.3544014-1-yhs@fb.com>
In-Reply-To: <20200219234757.3544014-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 16:07:36 -0800
Message-ID: <CAADnVQJ7rP9+8aPDaUrujq9km3UJR8ntSo9ZQXucAh+P0TM4Xw@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf: fix a potential deadlock with bpf_map_do_batch
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 3:49 PM Yonghong Song <yhs@fb.com> wrote:
>
>
> To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
> let us do bpf_lru_push_free() out of the htab bucket lock. This can
> avoid the above deadlock scenario.
>
> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
> Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Suggested-by: Martin KaFai Lau <kafai@fb.com>
> Acked-by: Brian Vazquez <brianvv@google.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
