Return-Path: <SRS0=PZ9s=5K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CBC2D0E5
	for <bpf@archiver.kernel.org>; Wed, 25 Mar 2020 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1158B2076F
	for <bpf@archiver.kernel.org>; Wed, 25 Mar 2020 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOcZnOyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYSwu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:52:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46759 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYSwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 14:52:50 -0400
Received: by mail-io1-f65.google.com with SMTP id a20so3343502ioo.13
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xT7cW2sbOZhXGpchSrzjECBEdaORAXgWdZgGp7+q6qs=;
        b=YOcZnOygFF5FPamYQ+2OHw7qBkUxp5P2Eol0xBgA47qcuk6W27ptbDbAnOIucHRENq
         V22hxUdrnCzsFS4pUQkhX2gtQ5dDet7mjt5M2N9IU/RY4Czo9pp+f/IixYoOCXl0Z5wi
         /aJ7KnS2o4EqB1/iTw2r/bnbYh2nAJ8UmhdUQ0tGZKYQJtC9EO/44nYn7qng094Mlv/o
         rG8pLjaVpHnJ0T64WuK+E3nN5YzrWCf9HVfcjpO+u5i6g91Ny5K8R4FPw4EAsnnyvfg2
         XgFqJ4RrD7Z5t+NNOybVNCdkgTcFMZ3Sywt+ZAyMUJVqgDdyu9n5SMambPxZUWhY25SZ
         oTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xT7cW2sbOZhXGpchSrzjECBEdaORAXgWdZgGp7+q6qs=;
        b=feSZVuLULrm0azOYYjUiwJ20m1yvdt8YEHhFg+o3f8+6xLTfusFFM1m1/Z4JpkrnH1
         nJTRf/Dt8pnvXFFSDuV8udV2J/thiClHL4aQ0Pikig+gbE7CcG6CfZYJgJkZC0XHwq0c
         x35Et0KcBX0QLJLgAzgUh6fYZ0T1nK+MDiOvB3y42VSfJra14rRcA9yTeqfA01Z3+4Wv
         xxmTw9T7usAsY5w/XdCI2+V4dpnHSU5V1EKywNugFk84sp/TIkhXeY/YtzWgqHkMJhD1
         Z4KgVlkUhdBWvszC6Noz8gr54Ar20q+51NwoTcPxYiG2BdwO2ISYKba4EWoz54PcCC0M
         0C1g==
X-Gm-Message-State: ANhLgQ2mv9RNLCHTJNYS3JV11bEKwZX8E+IpTxCb/3w4Sw0OIBE2FzHV
        PP3kBH+coiBb9V4fbZGjDHNpYhuLC3r/sL/EX1I=
X-Google-Smtp-Source: ADFU+vvJCFY0GElIZu4w7WimGUGBG4L9L92oAIHfkVF/SV4gCQOIm5HeeCdoGN+n0W0YjD7A4A3GBPF0N5NVEuuPpr4=
X-Received: by 2002:a02:cc4e:: with SMTP id i14mr4070791jaq.93.1585162367617;
 Wed, 25 Mar 2020 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113655.19341-1-tklauser@distanz.ch>
In-Reply-To: <20200325113655.19341-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 11:52:35 -0700
Message-ID: <CAEf4BzbD6a-btabLNF62rtt_nNZr2WP4dn6Z0K4=asQbsOQs2g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: remove unused parameter `def` to get_map_field_int
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 4:37 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Has been unused since commit ef99b02b23ef ("libbpf: capture value in BTF
> type info for BTF-defined map defs").
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Sure, why not. LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>

[...]
