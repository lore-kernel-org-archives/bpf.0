Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA6C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 02:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEEC20863
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 02:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgyJHAYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfCYCwz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:52:55 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46131 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfCYCwz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Mar 2019 22:52:55 -0400
Received: by mail-lj1-f174.google.com with SMTP id z26so6357145lja.13;
        Sun, 24 Mar 2019 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Z7As2PxlqG2Qunk+/MJriqgFrWuiPRfJLyM+ViX7ks=;
        b=HgyJHAYTy5jbDuEESD9xWmuX0Ib5qgw7L9SrMHKmklDRpU2g40aWiOoAhDX/mob8lI
         l7WVdLjPk3yjltPny9OUeZqlcRBa6UcP7Lescc86nwEcd02Fr7OA6xAv4iFJwnwutrYW
         J6D9iSnWsanhvoUW8f43pSjvRSXWsXVmSKwcRETfxJt6zICvYfVNB2KxtzJsJJMFKPn6
         WeXbC/vonl9PFhN0d27rF9e0WBaLXH3odMKcXSige0dqSTnngV51073+vQtjuGnjsDvl
         qUgvluftK+C9apaOd8b+J24+iW7ez0tz/TSlA4sgxA49JWmLqJcHIwP3lIhI7OKYyKSl
         D+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Z7As2PxlqG2Qunk+/MJriqgFrWuiPRfJLyM+ViX7ks=;
        b=aV7+JRrhKOJq3YBNlowa+IbbmgeER9NNCDuL5JXrRJlm+j66IQ+Knd2hS3/Wnl2gAQ
         rBAPM0rfQoUEsX6Y8Aj8xc0C1pBFnoDGslYFKc3Z8f0D4VQq+m9LX5bpsSpMTZLUTjAC
         uXuadT4aelqUz5NKcyZOKcvGeiq2w6wVEE2jqLjVGIEOZzHOWT45S2IrlIwCC1bzAi4u
         ZHyKQfkH429oRUbAkNMHK1kMixx7bXE1vUuSsDM67J91+xIG3DawkDxw/YuaaBhkD5py
         3Q+FmYitMWOlnOVt8YTyUXFQHH63sDTuS+TIR92SGsYefTjup925DquTE+CxIFNOc9rf
         yaeg==
X-Gm-Message-State: APjAAAXXWh4m3TJWhvP8a2q4qcbzkt4/FyXlYHEHblLx5S36vsOnL/a5
        UxVnrWqZmjBGnmB4/fTKBq7VBGzDbda0ayO/HZ4=
X-Google-Smtp-Source: APXvYqzPIbzd02/3uFiIUmYzqRPV/i/VbSiOPYbj2QcKvhvzj77HnaAE00twlk35EMAcLeqNGJZendlgXbYmNI95M+E=
X-Received: by 2002:a2e:a284:: with SMTP id k4mr10499257lja.99.1553482372973;
 Sun, 24 Mar 2019 19:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190323004911.604-1-daniel@iogearbox.net>
In-Reply-To: <20190323004911.604-1-daniel@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 24 Mar 2019 19:52:41 -0700
Message-ID: <CAADnVQLjffsU_9AF0SD_9Ph518G=V+_6exxTG0pjUX1_bOtG4A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/2] libbpf fix up and clarify version info
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 5:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> First one is fixing version in Makefile and shared object and
> second one clarifies bump in version. Thanks!
>
> v1 -> v2:
>   - Fix up soname, thanks Stanislav!

Applied. Thanks!
