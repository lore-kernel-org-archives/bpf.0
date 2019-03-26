Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30336C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02865206DF
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVzvKDbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfCZS12 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:27:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41974 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfCZS12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:27:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so12393886otb.8
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rGMelTPEirxWGwov3xzPgzyYz5Zxz9vo6trPKVVF1I=;
        b=MVzvKDbpVnhsGNwCn/Kr7qzFEXNJWVGuzd8yfItIWnBjI/rxFAdOlCWcm1ENnSexRE
         Pyre+g/LrkQAdbonTMT96y3Dj3JrpkFxgetLRr7c9GGQE2kZl0Ofm8F9wQbbSeJziWS5
         DymiR9c4ZhXV2HHHTUsom1MDVkedSwZHFw5arAg/KRpzd588HApyICWcwoGiYtAot77i
         9kGXQQD4pQmLIw1Rgiken3UDRfAXF/yVtRgHHLCrnqohS2/HvNYXN+dDL+oIuYflG5xh
         /KEG2tIV+mfIASa2bLO0UkFI2kVp4HU5PBhdHz8QPnkeAG/V9RQfK1vimcJxND3nB5/5
         MI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rGMelTPEirxWGwov3xzPgzyYz5Zxz9vo6trPKVVF1I=;
        b=ogUdeE5Tf5FMKIn6R7+3c2b/xlja9KKqslO4gW6Gv0y4ZGbL+wiURicOvUiGdjGqCq
         kbG58DNawZ7Ys8vd04Iss7A50Uo9lqoNciIXuDnMwXCEmwQAgaC6CcQx2wq3P21p1OpD
         xxbrp91C3jyMcN0nwd/pEGwJ3t3kO+z8M97GOtI+G9mQtTx5YUBa/6kQgmmHM6/yRLt8
         EzKVAdyMqyXWTcZC94H/zWSjCXgXI3llLclrlX6nHiGAeAR6ZsOP6ZeuPe9lcHdUvmUE
         oJ61agOIXg2DnRqpadi3kDK2hrHQ5pPXIb5BudFZxcXS4+X5bI7mpEddA46XCUGMOXxZ
         MkOQ==
X-Gm-Message-State: APjAAAXrbP1O4CAwKN+al2YWC7dEDqSAs4Uky4lMKHfo0PDesweoGjsx
        JvtYFmLLKR1lr4NgDkGSH1T3PBnR/syPwzCeABC4XA==
X-Google-Smtp-Source: APXvYqwHR/00fakS/AGX3DhIhunfawxeXVeKzJ0kwk9n6uLiZiqkf+vrg7IMcBl+ypsI7Pat0uEH01mS0aO2tsfDNvw=
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr24539990otp.198.1553624845839;
 Tue, 26 Mar 2019 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com> <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Mar 2019 19:26:59 +0100
Message-ID: <CAG48ez0s9HC8eJhS-T2+SwrD_X7FQJmD9Br72zcnnMVFTwhVwQ@mail.gmail.com>
Subject: Re: [PATCH/RFC bpf-next 02/16] bpf: refactor propagate_live implementation
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 7:07 PM Jiong Wang <jiong.wang@netronome.com> wrote:
> Some code inside current implementation of "propagate_liveness" is a little
> bit verbose.
>
> This patch refactor them so the code looks more simple and more clear.
>
> The redundant usage of "vparent->frame[vstate->curframe]" is removed as we
> are here. It is safe to do this because "state_equal" has guaranteed that
> vstate->curframe must be equal with vparent->curframe.
[...]
> @@ -6050,6 +6050,22 @@ static bool states_equal(struct bpf_verifier_env *env,
>         return true;
>  }
>
> +static int propagate_liveness_reg(struct bpf_verifier_env *env,
> +                                 struct bpf_reg_state *reg,
> +                                 struct bpf_reg_state *parent_reg, u8 flag)

This function takes four arguments...

[...]
> @@ -6071,16 +6088,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
[...]
> +               err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);

.. but both here...

[...]
> @@ -6089,11 +6103,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
[...]
> +                       err = propagate_liveness_reg(env, reg, parent_reg);

... and here you only pass in three arguments? Does this compile?
