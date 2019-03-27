Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D0C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C009A206B7
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 15:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzs+IHIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfC0PEW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:04:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfC0PEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 11:04:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so14692364lja.10;
        Wed, 27 Mar 2019 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AsoKoWTsDPROJhIOHvGqS7wKNVuxFIwdIE1Q2AXR9Q=;
        b=rzs+IHIaAZBKPbsIenv8H/frFwL80H3g48/Tg1BbgI+D8AZbvs2MvAmH9Ct7o3HPCA
         NLsfLpvVtMmju1QNHX5PR0lZC2cEd9vn8dFfcqGN+p0QbUudpi0U+b2jrnqyKXcU6SLh
         mUmyDdIYvall2CATVytYLHsVdd6JxkGYFDrIxGM781jryirQY4i7RCITp7l3iJrBKog9
         zbyftfKY7O2LBdLGbYzQ7Gexq6dYipFX2airWygR3+TmeceGed34SmrMX6VdiLO51z1q
         RqfnKEW47lE1H5xC9ezzptJ0piJ7ceRCHJCiAWPYIfVB8Mf4fD0K8C9ScZ+vRVdQWaJI
         tkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AsoKoWTsDPROJhIOHvGqS7wKNVuxFIwdIE1Q2AXR9Q=;
        b=YlsWlvBF7X/MmJwbzovV3HQv5+Q04fbp8uLGoG+hQ0aWVj9dIq19MN7sopGmKVpIOT
         r666jZ3XOlLw0leIsA0X2Iso00+UpWUfjPwj+Yeg+uZ8wqYIQS6unlkmUf88YBhRW9H0
         3Cr4s4XTjseeQ6Ky7sTw8aRG88zMYXK8+iW1TQ2Ic8S2zeOQ1yO9a5kESE+G+pTTCqet
         rDwdsVU5h5Hcgx6zuYdHUNPq2rr2oxm6p+cDZjPmJyUNPGGLJMOJLajER8zaGQDEOTBm
         bkkPsKVfuoWtDb6sz/fGGgjzvB5SFNZ2z7imQk2+eIXEtZHmGgnaq6H5r3pmu3eDq+u/
         8gMg==
X-Gm-Message-State: APjAAAXhVSBZiCzMxlyYZLVAith4U/ByazqMZnmc73mg9p0juSLAdpTw
        A8N3zpb5dzsEHqS92/N/wJO4cmfxOvRTA4D64AASQQ==
X-Google-Smtp-Source: APXvYqzaNzfGytjDgTVTM7btLPp+V+lLpBsm2N68aI8hx45T9PsmMTS2packjUykJTUCSU4/Ghcg48ZJO4MTxuqEUDI=
X-Received: by 2002:a2e:a284:: with SMTP id k4mr18098817lja.99.1553699060239;
 Wed, 27 Mar 2019 08:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
In-Reply-To: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Mar 2019 08:04:08 -0700
Message-ID: <CAADnVQKbYyBLuhfWLOQgRQXHznHXCoeNLS9uBKVJhAm6YkzKJA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] fix btf_dedup()'s type graph equivalence check
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 10:00 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andriin@fb.com>
>
> This patch set fixes bug in btf_dedup_is_equiv() check mishandling equivalence
> comparison between VOID kind in candidate type graph versus anonymous non-VOID
> kind in canonical type graph.
>
> Patch #1 fixes bug, by comparing candidate and canonical kinds for equality,
> before proceeding to kind-specific checks.
> Patch #2 adds a test case testing this specific scenario.

Applied. Thanks
