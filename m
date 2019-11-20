Return-Path: <SRS0=MSId=ZM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA5C432C0
	for <bpf@archiver.kernel.org>; Wed, 20 Nov 2019 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223DC222DF
	for <bpf@archiver.kernel.org>; Wed, 20 Nov 2019 00:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL1mB/dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKTAzQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:55:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41256 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTAzQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 19:55:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so18682528lfb.8;
        Tue, 19 Nov 2019 16:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OCzyzW0c0dBU2QbZzx67gNpsOjb6OP42HrUm6oVSJ8=;
        b=bL1mB/dMypypNdCDYCr6MWvVPmYSK2eNV7mDrCYpK9WR6kUaa0rgWsF232of718G7B
         G52kNEVuC0bIewwB/VOJOLm1/ERtdYTaoEkZyu9LkrobfTmifyGvVpAz8humaAKNocb9
         f7yAGRWRXhEosi+qKgGOeIxz6hz0kw1HIKTp//6ycGVGeDBpF9R/r+JdxdasevCViad/
         tZ0mYMsoqN3cr5bGsy+Bgb2ZZJy1bqQq28SeJZBSlHmxvL2jW+Dj0PCGtD34CCLwtb6P
         sgqWOZ4YjiFIlJW6SIN2NhHvRn/TPVn+wQbLV7srZDJe0AZeKM9miZGmI5WLtzxuZf0P
         rJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OCzyzW0c0dBU2QbZzx67gNpsOjb6OP42HrUm6oVSJ8=;
        b=S6+WZ3wXxxrT5f+tGB37bgYnVo5wwG2f6rUa2gtKBaLdtUCSHgQqB7da97M/2cPAUX
         delIOWSUWZtQsuZm8gbWTprasSG45weWPpidcZrBCYPJ79mVGbpRIJLy5ToVCnI+LT3P
         aIRnCdY46v8VtvsKCks2mTbt2W5gR5f9VvOiQLjoGCgKvGE3f36ybi/s3+YwoPPpUwex
         c/7hf85RjiSeejbNXemrWHD8SPP1R2umFOWrPzSFknv9RKyuoxje0N2e5mKhXLUmST6V
         gijBUIZFipGRY1fQbDcvKS5bCj388u2ONw0OAQyhJ6zUu0ohlSGH0AiSfRfCanKmUyjZ
         Mo3w==
X-Gm-Message-State: APjAAAXA7Loosbwx5+GByKMOYvk772ySAtMwXngatRSz7QjWprJcOE6G
        LeS96bYJW/tww+8ns0r5kM1MNkSCOJExBhwn8n4=
X-Google-Smtp-Source: APXvYqzONuqRVPDwDtln2hDNbUKHE6pacX5x0dy9mKpamBoiBqoHHs+ipAIflzjUOXCTFzujyMUA1boKpXL+oDRGH9U=
X-Received: by 2002:ac2:5453:: with SMTP id d19mr354789lfn.181.1574211312853;
 Tue, 19 Nov 2019 16:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20191120002510.4130605-1-andriin@fb.com> <7317c35c-d8f2-25d4-d40d-6d27b99a1c6e@fb.com>
In-Reply-To: <7317c35c-d8f2-25d4-d40d-6d27b99a1c6e@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Nov 2019 16:55:01 -0800
Message-ID: <CAADnVQ+=dvSQ-UZOuoaQc2vo-SqeM=5ymfWnZ_-0BpFmhDVNbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: enforce no-ALU32 for test_progs-no_alu32
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 19, 2019 at 4:32 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/19/19 4:25 PM, Andrii Nakryiko wrote:
> > With the most recent Clang, alu32 is enabled by default if -mcpu=probe or
> > -mcpu=v3 is specified. Use a separate build rule with -mcpu=v2 to enforce no
>
> A little bit clarification -mcpu=probe may not enable alu32 for old
> kernels. alu32 enabled with -mcpu=probe only if kernel supports jmp32,
> which is merged in January this year.
>
> > ALU32 mode.
> >
> > Suggested-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> With the above nit,
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks for the fix.
