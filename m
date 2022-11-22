Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D7C4332F
	for <bpf@archiver.kernel.org>; Tue, 22 Nov 2022 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiKVRYX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiKVRYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 12:24:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AEA7C020
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:24:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s12so21569770edd.5
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5J9yUBX7x/qSYZwJEC6rDipkmTiKFn9M0g2cw52BFuA=;
        b=qRqBuvZNr5rrUn1s2KaqmG+2rttbdOtsyZlQiF3f5J2T5cXf82cSyx4QEqxph1y3UY
         OHG+yf3vAPclPQif984HjzCVVWA1s021uYtPbO96/ek9d59Rsv9xIMGS+h7nKwSJdBk/
         Z0to+HcetrEUzNANnAioMsiUr2Ar5HytnjpOvqdA9Tzm+d7Z7X8JBMzSqyugylDnKeBi
         4jggUQzXIMrl1Zl4vPRIgiX3rFdiJZfjX5hvi+RkahyUDw32NyipAWORVDF7AQnaM71T
         qh1F6Ko7ij5cesjO0iFLXBKSwgkYXh6NETh/B7e+wLfqQNViQI+nKOJslsmmio3L/jfE
         uhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5J9yUBX7x/qSYZwJEC6rDipkmTiKFn9M0g2cw52BFuA=;
        b=JvzXMfrkXmGyAjHQeFGAnwwhKZOARQ3tpGixsEjT2tGgGOA8fk/+UOmV3AvDpOhwbt
         NQrj5GQWkFwgJySKafCWU21lnQV0faUvRDIydODC54Cat0FmRTgyMNUL4YSNbmxfd35e
         bn6N6U3UjWXbgOkXqTjmZhlBc8Db6z+5YLgwuhhOHLmTL2n8IcwC9bADnQBNV1gLivqk
         C7n3ALX7ZVG2RBruChkmrk8yD2jNhZDCI8vlsINVwcWMKRHKdxFxtiS9rMr7wQ04CQcn
         +4wO6VaExFZZXtVOSUIhBbMHy2DquVwDHscxzLWc+NEPI/8GSWLXcnBuvANJLTlYYoGS
         Zgjg==
X-Gm-Message-State: ANoB5pk71yMNMjQXlZbu3AQaa0oqK2KReIA7JhaXCul8x9GQ6OxP6HIb
        4NKPq5ALlPgp4BcZzPon33ThhKoSenXGaPHrCVQ=
X-Google-Smtp-Source: AA0mqf4en8Y3JskrZP+NIqsLVy8fw3Ix4WoCMhYAPxOTSdFu3DQsk8fVU4K8TQta0gEav+8KL2UVBAddkeggI64dmRc=
X-Received: by 2002:a05:6402:538a:b0:458:fbd9:e3b1 with SMTP id
 ew10-20020a056402538a00b00458fbd9e3b1mr13545010edb.6.1669137858913; Tue, 22
 Nov 2022 09:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-25-memxor@gmail.com>
In-Reply-To: <20221118015614.2013203-25-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Nov 2022 09:24:07 -0800
Message-ID: <CAADnVQ+RnGA8_=29rbJr8vKCTiriMmfTKVZpYtSL=rgED9o0xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 24/24] selftests/bpf: Temporarily disable
 linked list tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 5:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The latest clang nightly as of writing crashes with the given test case
> for BPF linked lists wherever global glock, ghead, glock2 are used,
> hence comment out the parts that cause the crash, and prepare this commit
> so that it can be reverted when the fix has been made. More context in [0].
>
>  [0]: https://lore.kernel.org/bpf/d56223f9-483e-fbc1-4564-44c0858a1e3e@meta.com
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Hi All,

While looking at Dave's llvm fix I realized that there is a
trivial workaround.
So I've reverted this commit and pushed a workaround:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=59b9bdd725bc39a1e1a408a6aaffce8fdfd44366
