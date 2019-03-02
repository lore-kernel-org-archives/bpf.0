Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3841C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FE520830
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYiej0pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfCBWCm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:02:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43126 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Mar 2019 17:02:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so1020543oib.10;
        Sat, 02 Mar 2019 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF5w1UyYeHx1Tm+QmT3F6GrYh5uyXaiJ0+PZHosS61A=;
        b=VYiej0pDXRgTMj+zh+jN2L04l45OB4XgU6gqLmHOhxJ0gg3bJxEYvXf7hhOjV7SJwl
         W726HhO2cqtPcrVwL1BqdNhlOaohazKyhr6wsx0hEUZxmkX/eak85vMItNoD/7Bcx3G+
         5hWzOlUPV8Gz8e2/GwVZCY8kiEPycQsIKlaEsyl70+bm88zz0xiGpsKKDz62CBxxefrG
         LXslHbOYDOOiaRhOyNdOiOGzIDL0LVbSLHQUN+vTIBBcIlJPI+RET0mYZbwRmAlrG7cv
         h6r2bJHlGvRZsZjAkkYJnafRdtsg80m+U+7kERCws2ob2lQafUwb7ZmJZvEORTA2yAS5
         sfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF5w1UyYeHx1Tm+QmT3F6GrYh5uyXaiJ0+PZHosS61A=;
        b=OAzGYPs7p5uzZn0yCSMGPVRay5hJy9zRRqKf4F9eQaD6vHoZ9CxxQwwV76bHUMNJE5
         o/G+IQqpp7iuqdKQi/cPw/be4R/mxowmLy1Hdj6n5sRHxq/n/dYzWWscRQgbUKTejnRa
         wwgaLloJ8sA81aWD/6RvxUopHaMjgKLM4d+olK0/BquYIKU1ULgYBEGZhf64SP0BeP/g
         OwmnJ8lJkQs+cAAEbl1cEv3QuP/tnPYS78x0dpbJDmVEZs2hpdx+jNfSdCiVedTEOPAW
         Ezvyc3J7jNNS1gHq53z4ANz3wIv3RYATku7iWndvZFrt38ELLlPpXSAq1totaOYwSorz
         Q5kg==
X-Gm-Message-State: AHQUAuZmEzPZRlwN8TRnA60iIKELeyPEUA/pgzuFOoNHrohi385j/C3d
        lHsgY/k41UMdWDjetmsvre+jBHJ+WJmyRLcO1Tk=
X-Google-Smtp-Source: AHgI3IbyK7tGqXhFL/ZZ6FiuR7JmzMl0OcOxy+MZfh6wI/m0s8JSk6W7UjWNvTmAim03d0+QPPvFaS4ksSm0GzLfhEE=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr7687862oig.27.1551564160783;
 Sat, 02 Mar 2019 14:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20190301013716.1370014-1-andriin@fb.com> <20190301013716.1370014-3-andriin@fb.com>
 <fda23d5e-6de3-ab2f-107c-8abc1abaaef8@fb.com>
In-Reply-To: <fda23d5e-6de3-ab2f-107c-8abc1abaaef8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 2 Mar 2019 14:02:28 -0800
Message-ID: <CAEf4BzZtqJbZuTbAsyoowi1LBFfKb_csxFknMwQKNFtYeLYQ3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf/verifier: fix code formatting
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 11:24 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/28/19 5:37 PM, Andrii Nakryiko wrote:
> > -#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)                   \
> > -static int realloc_##NAME##_state(struct bpf_func_state *state, int size, \
> > -                               bool copy_old)                        \
> > -{                                                                    \
> > -     u32 old_size = state->COUNT;                                    \
> > -     struct bpf_##NAME##_state *new_##FIELD;                         \
> > -     int slot = size / SIZE;                                         \
> > -                                                                     \
> > -     if (size <= old_size || !size) {                                \
> > -             if (copy_old)                                           \
> > -                     return 0;                                       \
> > -             state->COUNT = slot * SIZE;                             \
> > -             if (!size && old_size) {                                \
> > -                     kfree(state->FIELD);                            \
> > -                     state->FIELD = NULL;                            \
> > -             }                                                       \
> > -             return 0;                                               \
> > -     }                                                               \
> > +#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)                        \
> > +static int realloc_##NAME##_state(struct bpf_func_state *state, int size,    \
> > +                               bool copy_old)                             \
> > +{                                                                         \
> > +     u32 old_size = state->COUNT;                                         \
>
> what is the change here?
> extra tab at the end of every line?
> I think that adds too much noise to git history.
> I'd rather keep this bit as-is.
>
>

I feel like this whole patchset doesn't add much value and will just
pollute history. I'm just going to abandon it for now.
