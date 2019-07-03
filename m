Return-Path: <SRS0=UYZo=VA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D7C5B578
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F5121881
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 23:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evI72uNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCXVA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:21:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36164 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfGCXVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 19:21:00 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so8965463ioh.3;
        Wed, 03 Jul 2019 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8q6bqS5A58K2XCq+hl4LLbzANrs7LyVuaD5MQzwDQM=;
        b=evI72uNN5MEW19Dm7OJgHrmbbQmDivt6VJSKt8cKp3hb1kBUQQwLd44ZL0cGNcvYvf
         OICuuK6PMMNPTNdFSYCREHdpMe4hu8LlpRomZzM1ACFFEIpZjtwvjFEjg2tTJEQM7wjr
         NW4bwwtzvVSQu1G98RFx5dlYtgE9gQx2WZQ5aoLH4EY808PHoAgpogsY8Nrj6CzONiHN
         dtus3KMTcK64z/qkXRJrJiO6TMJeeZhWpP4uU3SQ4vRS63UoUjYKuKwLLdYuUFPYrpEu
         Y9wz1vT4FhEVORcyXYXTvtYaa/Hh9Siy3UxqWJSZ97O8gTavlXunBVNkooWLPALhbbzM
         MKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8q6bqS5A58K2XCq+hl4LLbzANrs7LyVuaD5MQzwDQM=;
        b=L98QqxDahNOwHQIQjESHeW7IFsOoxYOuHobGMuoRSBF2Nbma3o2NXUaDna4V/biBnO
         Hdl/gxfHmO9f0l5Yi9k8PFF4PEGuwF+KLnfztpYyjNk8IapBrbosU+chQ3dAe7PmIFUC
         nxnoYifbWQPDYTIhd9LERszqf7beTFFSxZUk/a1srcEEFhbEiLzPRvPhSuRcItVWZi7Y
         Fo/aGPTIPAsYY0dtTAfA9FmJUrg3WZSlGLMMLhglbB1zmdySk8NA/Q4cyPxj6DRCCICD
         JmiAh3ZH9Qst+YLLMik58m1wT/GUaFMgbuivok40xO/1GSk8s9q2tXBYkpcc7kT5FMoq
         XvXw==
X-Gm-Message-State: APjAAAX7XYR/frOqjsFHG/4LcarS7SMkRmVg3Xx6yexpzvjYZbRAO1Az
        pLRy4m1ThEV7DBofsm1mOm1EGJSfPySdWN/3ehg=
X-Google-Smtp-Source: APXvYqy3urov3FAjJriB5cFDTjqKT1H/CNpdSe58wJmuL2kdlHm3zGsyMeioG1zKa94scdHI3ZXFhLnxRTddr/ZS0nc=
X-Received: by 2002:a5e:aa15:: with SMTP id s21mr39816353ioe.221.1562196059498;
 Wed, 03 Jul 2019 16:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190703212907.189141-1-sdf@google.com>
In-Reply-To: <20190703212907.189141-1-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 3 Jul 2019 16:20:23 -0700
Message-ID: <CAH3MdRWucO74K_tDaUvsor9Kuv-986sAZF5KrPOMTP_bmX3H+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_align liveliness expectations
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 3, 2019 at 2:31 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Commit 2589726d12a1 ("bpf: introduce bounded loops") caused a change
> in the way some registers liveliness is reported in the test_align.
> Add missing "_w" to a couple of tests. Note, there are no offset
> changes!
>
> Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
