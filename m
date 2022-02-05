Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C32DC433EF
	for <bpf@archiver.kernel.org>; Sat,  5 Feb 2022 01:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbiBEBdl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Feb 2022 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349644AbiBEBdl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 20:33:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF5C061346
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 17:33:39 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e8so6296469ilm.13
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 17:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyxoKzP9KlpeQJR5nBCOpj0MCSrCxZWuSRgXUDWulbw=;
        b=oWCni61hkMZy/w7qP9OE1SXcoY7UNOnRLKoqWerX0eFBDg5nxptrTcWEUP8bt0mf/+
         +EDtQykdDCttaTrStO0bYZpymMclH085GW+mGgzmDQEGQbSj8Y8bry2fhGbEy9Fztzcq
         SFZHc9n7iz059JmqK+XkefqJI/C5M2JdNCYHTYLDyu1IolDbA7bGQxpgBn35sQ7xkN5m
         mp1N5GevdPxDenykUDezvHlXk9CpMWPHJhcAu343umGTWwFbAv91f7JGn7PrUMW/ZK41
         xsXzz4virq7r8R+DgdJijvE/WmMacfvmfLrYsyepIHhDj3HqsJzYOashKnJMGoxCdCcZ
         vNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyxoKzP9KlpeQJR5nBCOpj0MCSrCxZWuSRgXUDWulbw=;
        b=PZVdKt15TQOjGyBxtq9VhMWaRKE3kduczDf0Av1LDndHPz5InApJR01geuOtaJHKsq
         EsKpn12NNm6MGtVDkZc9WHLx8a6+vjLhA3te7at3l2Ucp/NlaiyEnixuwHtE7MfTPd4f
         PX/AqCJnCGuE+sxvpn5usIZigXtLEt9PdR1JPG83VCj9cSKpx90IlatHq8lPwLRMI6px
         ktHfC3VaYJcWsHKpKpYpYVVobcR0YkiPDiFKM/atdt8GQ9UE2uSj8D75/XEw1z9pGmlJ
         Ag8WIR6idzwx3RPvh51ULYZ19PsKwmDmsvOnoLpSl4HmaHZPrmzCG94iUwrLjoKfF6YL
         HIug==
X-Gm-Message-State: AOAM532UvYi7dLnxoV7q5GjU9mU5xS/IKhM8shlRSbKG83Kgk7V+BzOz
        j9K/zsPp7+AkzeV5nSD4HtSlQqpL4CmTZGnmAYo=
X-Google-Smtp-Source: ABdhPJzxJVLDkuArukuQ6a+iuIYNwK3ED7SarxGLuvy7GF4C1aKXd2twkuMg6sqBAfWoiz1qxUF/RfVL5V2Quc/i2zE=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr876872ilv.305.1644024818791;
 Fri, 04 Feb 2022 17:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-3-andrii@kernel.org>
In-Reply-To: <20220205012705.1077708-3-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Feb 2022 17:33:27 -0800
Message-ID: <CAEf4BzYCTaQnnKGc83VU6i=qrrAu=b2zoqWRm0J3rtn+oxde0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: add custom SEC() handling selftest
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 5:27 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add a selftest validating various aspects of libbpf's handling of custom
> SEC() handlers. It also demonstrates how libraries can ensure very early
> callbacks registration and unregistration using
> __attribute__((constructor))/__attribute__((destructor)) functions.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

I screwed up submission and sent selftest as 1/1 and 1/3 patch. This
confuses CI, I'll resubmit entire series as v2, sorry for the noise.

>  .../bpf/prog_tests/custom_sec_handlers.c      | 136 ++++++++++++++++++
>  .../bpf/progs/test_custom_sec_handlers.c      |  51 +++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
>

[...]
