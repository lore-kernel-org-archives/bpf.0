Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E5C4338F
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643AD60F11
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 16:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhHQQ0u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhHQQ0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 12:26:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 986FB60F11;
        Tue, 17 Aug 2021 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629217567;
        bh=k0hboxp93Qz3WpPrRTXQkp9u+iM+tt+gVHJHQ1Yl6tE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LEqhQqlCfolMHKtbG+W2vZdRYBB0Cs0G6fUsgPgbmDAtSti1hGMbi+uvE+LtcJHgh
         GO8TpMw8jqcYvXne3o2ZLqeHzb6nxOri7if8+ftywvtraJrXP+ijhY7HB6DjEkqmVN
         rPd3YU7p8+G85QIngZOKwEbEzE32KqwszVWhRJwe72r6hSCiMZ1lOReV0USuJbeADo
         qYCaYZoW1nnaTEoZ1scLg1VPWNJRjmAiNs+lrMJf4GHm5/1r8DUYejcrz+xjRwHKtw
         9/hJoILIPO1rdpIcdqX0REe/otrK51iimGTTmf0SbYqYTHPS2xKbRZd/ouyspxbp3s
         VllUsBcymPywQ==
Received: by mail-lj1-f173.google.com with SMTP id n6so33940062ljp.9;
        Tue, 17 Aug 2021 09:26:07 -0700 (PDT)
X-Gm-Message-State: AOAM530jUBkqXikZY8s8voqUIymkNWT8aI4/hzvD/r8JMBckJgiTBaJ+
        9CFvE4LWeqMctcZV7af5EGJ1X3AA3AjtKfsThls=
X-Google-Smtp-Source: ABdhPJxVncmL4LRbW0pqO7lluxTuMwxvNEIsS4b1i48FDkYcYBgfjPeDRPx07plm2fJHPZCRNVf5Po1KZQJoPGGvgNs=
X-Received: by 2002:a2e:9953:: with SMTP id r19mr4006469ljj.270.1629217565975;
 Tue, 17 Aug 2021 09:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210817154556.92901-1-sdf@google.com> <20210817154556.92901-2-sdf@google.com>
In-Reply-To: <20210817154556.92901-2-sdf@google.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 17 Aug 2021 09:25:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6E4CYheAAicsv8ZqYqRd4C6Kn4qkb1-ckCTP_Kw=bDVg@mail.gmail.com>
Message-ID: <CAPhsuW6E4CYheAAicsv8ZqYqRd4C6Kn4qkb1-ckCTP_Kw=bDVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: use kvmalloc for map keys in syscalls
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 17, 2021 at 8:46 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> Same as previous patch but for the keys. memdup_bpfptr is renamed
> to vmemdup_bpfptr (and converted to kvmalloc).
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
