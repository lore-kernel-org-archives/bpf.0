Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6259AC33CAF
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329202464B
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEbtygnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405539AbgAPRmX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:42:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38397 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405524AbgAPRmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 12:42:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so18012711oth.5;
        Thu, 16 Jan 2020 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZPuK3t4i2e9dpWvbhn8UOhHGpDM1jLpb9oPNgJLjmE=;
        b=VEbtygnDqgbSQ9JEHjk2G0DIK60+OAym4SfH0eVhaVHU/AjqJUqD91/1IiUQ5r1+Nh
         fPuxc0Fn9/HmrlwFBnneFNIcFVCaBFCT94dqVJxql19QN75QQuUsNlHFET6qjFhVOz/2
         OyXePgRA21rt46uU5GB3fEXnctZnyxmEe5C/SFlhREP+2Pwir10MoQsOwA/P+JzR/sf+
         1ZISZiO1PmUiFlyhOcQGzezaIX/Xx3g9XakAuUkBu+no2dMUh95bQzndZigv8DB0q9TK
         KjtVK1QVLI1mncdT/T0KAhtqBqEO6eNY9T9zeTc96jlh/UfijMSr6RBhwcgzQWOtsl15
         iBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZPuK3t4i2e9dpWvbhn8UOhHGpDM1jLpb9oPNgJLjmE=;
        b=peu0QhjoQCA0bWYWORNhYu2HRDE5abH8IXUFBqTMb3xW2vI/JYpGfepBMxiq9HYQ0P
         QXrPpTz56PTMlDhClHwgYt2fnZO4sK6npxKXucakXeovvSBB3U9YjxLsfXBAj7CYZQHA
         DnKvIeiVS2nC3tW3e6NtmXY5fdieHDKwUyPdk5qQywKUUsVHZJh8xwSeJjB87vvaCpBE
         IGdEB0jTyHh7V6KqpoiWGMP5ZGrTl7IDQRoBTr1ojXPEnbmWNXeLjUBYWKiC8kcg+U3k
         Ajrst3VKA8s1xojSNexoB8tLwTulfJhlrJnvjwKBDHHSIUGzB84wDM2b2LkvEllLmRtS
         j2sw==
X-Gm-Message-State: APjAAAUQiskTx7jUAxRqRRgsXXuDpLx+pwK7S+xxyvzGyrQeJ24sNgqI
        uZGxxRRhQ3qyF1hcXqsgdZh6k6WTOdtCsTEWlZQ=
X-Google-Smtp-Source: APXvYqxbh+HdCw186kXPYdqGa/S6yxPiRdaSBfFyxeiOXmUB3z5tVMMozHAFyOH5Yc895FenFZGItPZwWkfExUyaEUE=
X-Received: by 2002:a05:6830:4a7:: with SMTP id l7mr2848408otd.372.1579196542279;
 Thu, 16 Jan 2020 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20200116085133.392205-1-komachi.yoshiki@gmail.com> <20200116085133.392205-3-komachi.yoshiki@gmail.com>
In-Reply-To: <20200116085133.392205-3-komachi.yoshiki@gmail.com>
From:   Petar Penkov <ppenkov.kernel@gmail.com>
Date:   Thu, 16 Jan 2020 09:42:11 -0800
Message-ID: <CAGdtWsQTBQOiUanJkViz6eR4Aw=HBvzUE43UcefkbW3ngENEHA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test based on port range for
 BPF flow dissector
To:     Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 1:13 AM Yoshiki Komachi
<komachi.yoshiki@gmail.com> wrote:
>
> Add a simple test to make sure that a filter based on specified port
> range classifies packets correctly.
>
> Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>

Acked-by: Petar Penkov <ppenkov@google.com>
