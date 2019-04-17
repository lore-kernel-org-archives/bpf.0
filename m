Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C0C10F14
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D3A2075B
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEwkHpgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfDQCp0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:45:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43682 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfDQCp0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 22:45:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so6682277lfi.10;
        Tue, 16 Apr 2019 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im78dsMTHv5kUoZmU75k2O5Fthvjvg58l2mRh6G6GiQ=;
        b=jEwkHpgdwGNAbod9vBCGLeAX3M3hw/xEBQFYySadzN20bD7F/3MFf8ztn63SDkuIYH
         fZq2n2lo5XDV3mZwcL56fJs6uT3FgLdI6/EWbx085GT8EZw8uE8i9clSSz3uxKPxmAEq
         jNiHYouYrfA/yWOEnehED/KseTX1kUEQZJDIpb4N4YxkKmvtwW3LWEVA5jnULV5nsT8n
         LSOXlFLR6Jggzd/fNLGxgtS6e/ac4EVD1RpVbswlr8I4kG4NoBcYGcUD6es/M9JDSqqT
         kLiyQc0mMsDQHDGxxQZT7FiCUWv8Nub58D7UjF9tIY/PRMP9md+84ihMjSoxapJwcAf2
         cz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im78dsMTHv5kUoZmU75k2O5Fthvjvg58l2mRh6G6GiQ=;
        b=IIwGKYkR4p+nZTMBt5TwwTeUAUul4l+FAKkjeFpXtQncC58QeO8VAKXZdHPUUbwxw+
         rMV32ooLNnMcoLPUmXRt9wb97Q9OH0d7kmq3Vyq3I1n5PXXhOUomDAuJqzfphgWsP01h
         BZM3T8+OQWuv94EmGT2LbdLZaKMeqAE4jaAHNO4OA4uSFKE+jX0U8tpFpo793+8aFZBy
         IQv6uJ8NBZvAsAqf7A00mQjDbVlzCNgyuEWbCOqMgZBAYSM9c022yHc2Pg5dTqnEISWz
         fx5S8DysYVTjRjYMQ4OKLt7BuAdHF2K65ZyBXMHvjF4JqiODiy6nzMgOhyj6aMVrOPV5
         5fpQ==
X-Gm-Message-State: APjAAAXITbxi/4YLcDUlE48CO0xp/gsIM/8X0KTko2YJfUrl0i5xFlUn
        TJjnYQh5STMYO6PYQJOou+n7eFm98ONoqqkeWbc=
X-Google-Smtp-Source: APXvYqziGS6YGBM2Nlr7k/8FMTYvcaOVdlt/T/1M9LqNfE25Xw92iT5EEF8/XEhYLKpb+TLghqG7tgWq3rpKmbBAY00=
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr4290837lfk.126.1555469123867;
 Tue, 16 Apr 2019 19:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190416184717.1392147-1-andrii.nakryiko@gmail.com>
In-Reply-To: <20190416184717.1392147-1-andrii.nakryiko@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 19:45:11 -0700
Message-ID: <CAADnVQLmsp2GPTWcu3MYxMULd98s_JE+aOLjViWzfESZ+WAGNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix printf formatter for ptrdiff_t argument
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, evvers@ya.ru,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 11:47 AM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andriin@fb.com>
>
> Using %ld for printing out value of ptrdiff_t type is not portable
> between 32-bit and 64-bit archs. This is causing compilation errors for
> libbpf on 32-bit platform (discovered as part of an effort to integrate
> libbpf into systemd ([0])). Proper formatter is %td, which is used in
> this patch.
>
> v2->v1:
>   - add Reported-by
>   - provide more context on how this issue was discovered
>
> [0] https://github.com/systemd/systemd/pull/12151
>
> Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
