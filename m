Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B7C64E7B
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 22:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C388221F7
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 22:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLBWoz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgLBWoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:44:54 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253CC0613D6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:44:08 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s27so7302569lfp.5
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQnvNP+vyX12oW8jO677hylzmfKm9Rnre2oTKtJCUzA=;
        b=WgC+a9QVpoWQA4b6sWtGb5d/kil3FhEXTLX8UYHs9DL4cw5v6WIKQUu3GJKvtjwEVP
         vJQ6lQWrYwB0wovtQLLsIvDHUH1wj2w4hMTpVistgydHcksMyxX1N/sJjW9IuUl5jyDi
         Dxk+zzELGHJX9Q67RcBf6J3RlLQLt1wW/43nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQnvNP+vyX12oW8jO677hylzmfKm9Rnre2oTKtJCUzA=;
        b=LTVO20GW13fBKpn6X+IMwm838g4RnIfIHicwbg5pwpeBGvAaDYrArm2r1Is+JsMqdh
         HQo+n/1a6/H6c1EKpMD0K3ZSl4A7vMIVpi1MT/lOJhyVyVwbGdxbXGHN2vxFRvAsnOFy
         JPhX3TAXVzTzqmXMI6UmqMyaSUj0n6VsVzx2pqdysDHIijhgkWzaaqPgvoaD2Rag9RFK
         1eezMZFQGMBmsO/r3SnA7zxGkdjIEACico3eLO030Sjiu/XXK5HPd3F1yrpxeV0ou+Oe
         0wR3NVYI7Tdiw17W1WHF2x6KaZNrrP8KRrp8v35/a9mc0Mcn4mTYoM7cm/U7HavNNWhI
         bm6A==
X-Gm-Message-State: AOAM530p4nLygCLP4cTuatP+EgsYqD6RREyAmcw0nHYmCUt1E4w3GB2e
        MllNf/BtNAwhdVsWRUSKZpH6ZnxaTaQA3G4U58+GX/d9PC/9o0vT
X-Google-Smtp-Source: ABdhPJzLYf8WzrZj6yLgK9M+CuwrsyNSG1D99kTJd6ah5+0Xlq4ODfF18gPw0DBjyfqYEAVyQ0S5WXOCVpDlpnhDQNU=
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr115107lfk.365.1606949046751;
 Wed, 02 Dec 2020 14:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org> <20201202223944.456903-3-kpsingh@chromium.org>
In-Reply-To: <20201202223944.456903-3-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 2 Dec 2020 23:43:55 +0100
Message-ID: <CACYkzJ6x=LAwEhqQE3BnBq_YAZKkCtMyqOWrfVJjiNWRPBXj8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add config dependency on BLK_DEV_LOOP
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 11:39 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The ima selftest restricts its scope to a test filesystem image
> mounted on a loop device and prevents permanent ima policy changes for
> the whole system.
>
> Signed-off-by: KP Singh <kpsingh@google.com>

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
