Return-Path: <SRS0=uCLx=25=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE55C282DD
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8961E206DB
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/lnrI8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgAHXSs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:18:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42806 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAHXSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 18:18:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so5336090otd.9;
        Wed, 08 Jan 2020 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnh1eutVpqi321VrKyGmS6TYs/v+b41t3J1oX4U+fC8=;
        b=q/lnrI8gyvk2f8L+VJrcwBC22Uz0v0GVQrwYJ7DJ2l+1sVF2r+Ry76kBCbFQLXP0Gz
         3gzLFTOHAxl6Zsqd3kFyl2QaJDSEw6BPP5WyNdUdXasY5iQ3Bkp5ycQWTG4BgufbrmGz
         vFOOU3BzGk+h1o5wQJbVFrz2nhv5Pa3xZCFFYS+QrxzFcc7anDwN0E7rLVcYeDfcS20Z
         QSY7LypU895yqp5cDZHxbvzLPTfuGyynPY8fG4cMuurj1QZjmnYFBOfhXxoCXLV9wE06
         QIziPiesadk6koFvOxJ268AHioN255/IOPDUMiSZGNNW/63Pe8CADdZ+/wfpszeI+S/Q
         9PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnh1eutVpqi321VrKyGmS6TYs/v+b41t3J1oX4U+fC8=;
        b=Cw/j45BujwBjuYWTo1UUXHElE4n2Pw//6+m/hZpY/6sbYyNyj82Pr6zhKofQ/AjhJs
         1V7+5Qebo39BZMGUSXKWZHPn9QaWwd3xmAxq5I5PoictLXnFE2TCVyBniW31OP/NjrdQ
         8wc8xjuYl/6REc3IhXkK20fykPraPWxlyPIlULbD851nhZ1emwwtmLXnaAW5LUWMYnut
         EWweaiLZTJfcG3kd18YdJAoLFCMcSYS+vFY/oC1DYvmJM5LaYw/peLUo0pqjwsOONxiV
         7wn8UoB7XlP5YcvyM6fae6539P47wxN8ZhB5FQ5uepHX6CCaSNbeRgKvMpJaQ3Nv8Dm+
         LCCQ==
X-Gm-Message-State: APjAAAUZ49jUGy30KpO3xpdM6kfpX7wilsLU2Rk49i5+On8zb93KtGZ3
        cGl6lM6qj4UEPic6svYaCJ750ul2w+gQMdF8OsM=
X-Google-Smtp-Source: APXvYqxgn2raXNI2+TsoD/gxAH2YTffmWaZpzZ8rc14d7w+9YefVvfo7DDLC9BWYtKvxuxCwSLMeRJzI3gs+vPep7/4=
X-Received: by 2002:a9d:7851:: with SMTP id c17mr6313601otm.58.1578525527391;
 Wed, 08 Jan 2020 15:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20200108192132.189221-1-sdf@google.com>
In-Reply-To: <20200108192132.189221-1-sdf@google.com>
From:   Petar Penkov <ppenkov.kernel@gmail.com>
Date:   Wed, 8 Jan 2020 15:18:36 -0800
Message-ID: <CAGdtWsS7hBF0d8F_Nidar-c+NRsDSwbk6K=cXbAOu-0kW74F8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: restore original comm in test_overhead
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        davem@davemloft.net, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 8, 2020 at 11:49 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> test_overhead changes task comm in order to estimate BPF trampoline
> overhead but never sets the comm back to the original one.
> We have the tests (like core_reloc.c) that have 'test_progs'
> as hard-coded expected comm, so let's try to preserve the
> original comm.
>
> Currently, everything works because the order of execution is:
> first core_recloc, then test_overhead; but let's make it a bit
> future-proof.
>
> Other related changes: use 'test_overhead' as new comm instead of
> 'test' to make it easy to debug and drop '\n' at the end.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Petar Penkov <ppenkov@google.com>
