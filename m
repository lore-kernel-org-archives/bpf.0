Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F87C3F6B0
	for <bpf@archiver.kernel.org>; Wed, 27 Jul 2022 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbiG0RsW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243207AbiG0RsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 13:48:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B4BD4
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 09:54:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 1-20020a17090a190100b001f05565f004so7532080pjg.0
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2CRPI+9B3V6PxOsWHdjhEKBdLq4aHTliZQPLRtQXvnU=;
        b=F+dZ5aG2bt1j0rX9VJoHZ1sv/WepC7YncxGNF4HsW545W0YVHkZY+M4WuZOrSoVuck
         x69yEaUzQeEdzg3Mwin/F8auXg/VsXWk15iMPTcxeAd5sVx1jZkh9LVKA1OCCLZpLmRf
         gT+IKi+4mkAP3wwzeyF6CrlBx7mbLl+OPrQrOSp0fm/T8J+yo6vMvNHYA1RdAYCuzlYO
         1dcNKyrgGXrojORouocXCrCd+yjmd3PbrXMGKWMnH2Gf/rWX5tOQTWyub7y9Tw1Q0NtR
         49Mt793gtVgmR31Jx8Gmafa9XEqD8A8z6xV4X9eJWYHx4wkI6/4Cb2oMCzWyNcKBNsAK
         WoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2CRPI+9B3V6PxOsWHdjhEKBdLq4aHTliZQPLRtQXvnU=;
        b=P8jX4kxYs/kBexo98KTAmlgMjmAXDMGsTBBh5AGY0BsF+thgH33g8k+eHBBkiZrQwS
         3eUspklpKwuUzZuME8qQnlLnYls9kvIDveJD/0AIgftxjvo+IBB6pcKDcofG9akIv9/O
         vI/HYKmNQIKrDS7l5rvTohamGMSYMe7fPU0vLJZukluCqYhkwvJKXmzjfbnY1HieCwwS
         Ai3scKr3zj/BDLZOg3pCnkgv2b5Mep8ifkwMUzuJSikjxHgl4sWG2rgkrCgc6gfeRAmJ
         Hl8snRsaq0PvalQfi2e4YNuVi0C6ix8PbAK2gsjv5BQPtmF+0N0wIcZsK/ZfSlnYghZA
         w4Zg==
X-Gm-Message-State: AJIora8q3x2BhyHct+CX5uuU81WFwABTy4NYDkt9nMXaRmhRjZd0ND/c
        bAHbZxAQnoc9DWJEf1faPz9lrBE=
X-Google-Smtp-Source: AGRyM1swDkPVt7A/yr3RRBPIei63v6wBmzkZF9AcEUS3MDLZQg6wlOcyNEXP2T7bZHqRmsTiCfDHLVE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP id
 p14-20020a17090b010e00b001f1f3b09304mr574547pjz.1.1658940850393; Wed, 27 Jul
 2022 09:54:10 -0700 (PDT)
Date:   Wed, 27 Jul 2022 09:54:08 -0700
In-Reply-To: <20220727060915.2372520-1-kafai@fb.com>
Message-Id: <YuFtsIvDlxh6TwkG@google.com>
Mime-Version: 1.0
References: <20220727060856.2370358-1-kafai@fb.com> <20220727060915.2372520-1-kafai@fb.com>
Subject: Re: [PATCH bpf-next 03/14] bpf: net: Consider optval.is_bpf before
 capable check in sock_setsockopt()
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@fb.com,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/26, Martin KaFai Lau wrote:
> When bpf program calling bpf_setsockopt(SOL_SOCKET),
> it could be run in softirq and doesn't make sense to do the capable
> check.  There was a similar situation in bpf_setsockopt(TCP_CONGESTION).

Should we instead skip these capability checks based on something like
in_serving_softirq? I wonder if we might be mixing too much into that
is_bpf flag (locking assumptions, context assumptions, etc)?
