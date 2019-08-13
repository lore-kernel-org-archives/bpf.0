Return-Path: <SRS0=vYPl=WJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B38C32750
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 12:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF0B20844
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 12:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDk+RTLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfHMMSo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:18:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44908 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfHMMSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 08:18:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so4644891ljg.11;
        Tue, 13 Aug 2019 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwRADUNHlV0hzZS2IA/cFhoIZjTzHWLRtc/+sGAjaKM=;
        b=eDk+RTLYTyJMlsI9BG6oP2X7Hi94flcZoDIK+V4Q7kF9ndeHX3QBB6aV1R7lO2/WW4
         OzvrU6etE726bc4etGX6++8NGavax+jUpSx92NDtziRydVNpzo8Ltd2Vl5zfkw+8ZN/V
         nSiSDBqopWGns/uGfkd7vcCgO0VJQw6lIRVLH4cxW4qdIJO+V6sP0KMw5KnaBd7oglFq
         uPeX5m295MIyMUU41O5iWRC3q7CfmuU84K4bPAlfCQ9RUXW/6aCk47a6S360b2WK1bVC
         iMu5LMTAVlGBBjVIo7eyWOjll/TXSGaTpE+nYOllbB/fbzsZNgqmx0E+THxBgbTiIWbb
         vmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwRADUNHlV0hzZS2IA/cFhoIZjTzHWLRtc/+sGAjaKM=;
        b=SYdRUYbBqhXup88Inc6E/ZN8HdetAmhltktErqMNLomcP2kCm+R5lwCel6cL3EZKzU
         3JQotqRPBiGUaIS/Efi4pw5Gk2nvKBz3EsGIdeHQEKRUgzJNG9t8gM/xzlPHUmCee6qS
         vqKprdYpJiIWdO0nHnzRwOsinEGrIhK2bS//mPVNRE9Lmb6CiLYkztzZEZUfJLS9BtJo
         6dkQoNCsls0N2Z+4egTv8qLDCuKbKWaXkP7eVkiqBzqYb0+7aYHEHrhFnZcmeCYBZMfi
         3h2iWwQNGAW86eYRXk+7WDQXKes1KXV6shqG5XzuuaB926pf6T67Y0Z6ihSDGb5Bfm16
         a4kA==
X-Gm-Message-State: APjAAAU/QaTjeL8vfWL/mN1SaKqYlK9V0qBAhCrpjCAcCqcr5OauKPKZ
        ArsFq+0lHHZWni4BcYeul0AW+EUdKdQF6cZfMQw=
X-Google-Smtp-Source: APXvYqw/g8TAHECe0mEWinPLFKHmJ8aTwE13PdcEf5w7U2Bx3J+3lTikvc4HgNgrelET/KNasdqFnFuEyZvcqi5Q25k=
X-Received: by 2002:a05:651c:ca:: with SMTP id 10mr5387061ljr.144.1565698721734;
 Tue, 13 Aug 2019 05:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com> <20190812215052.71840-17-ndesaulniers@google.com>
In-Reply-To: <20190812215052.71840-17-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Aug 2019 14:18:30 +0200
Message-ID: <CANiq72kbFDPO0V12AQkvNJn4eX3j2TH4RiNwuB=a520aSmvfKQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] treewide: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, yhs@fb.com,
        clang-built-linux@googlegroups.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 12, 2019 at 11:53 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> GCC unescapes escaped string section names while Clang does not. Because
> __section uses the `#` stringification operator for the section name, it
> doesn't need to be escaped.

Thanks a lot Nick, this takes a weight off my mind. One __attribute__
less to go.

I guess I can take the series myself, since the changes are not that
big to other parts of the kernel as long as I get Acks; and anyway I
plan to do other attributes over time.

Cheers,
Miguel
