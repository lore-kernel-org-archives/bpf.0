Return-Path: <SRS0=alw5=CD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37A8C433DF
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 04:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D222206BE
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 04:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE3sI9+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHYELV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgHYELU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 00:11:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D9C061574
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 21:11:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so12156092ljc.10
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwokDsIoZ7MyMVX4nKfaKe/JJKsexYPW4SZq7cgaJ5s=;
        b=HE3sI9+J0QCTMakq9KkmJSIlQT6ibge2NL1Q9YndIYAJj1qpC2x/XvUoI2c4iLnulw
         zT1QjT6mIqBS04n5euFInP6iZka6gOraRcmLXpYYns05MNZJG6P8za5t1EHfREB+roMH
         OzBM8vfMiLDPBY0+JNQinEEDVWNG0BYX3/Tyoo0W2pZh8lExSOIIJt0nD4rF/tn0m9Nk
         lBzGRZhkOqMKnoiThRhYjiScaNB6z+jYFPmTvujlKCrf6kg+MR1IS/jrO+lV5rmLBmRa
         tAizOEb4bJ89MA+4FRrxeukUHAKz1YiiSoJyLbbx47vDfWKTjxknlVmLMaBHS4opW3sc
         yrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwokDsIoZ7MyMVX4nKfaKe/JJKsexYPW4SZq7cgaJ5s=;
        b=Ah96Z9XaesmlRLNCge4EGM0Dv/a55FS8CSkQJmZL6xYQncNxyL4xgpaPgbt6PbIm7P
         /HP4B+CdT5uLVSIRD2KezyidFyyJRkSYhJmEMclg6pxCaL6N8XEm2jU/dUACvwF11aq+
         EHxB8Vb1JsRWsqypBYnRh52CSOY9l/mfZpjzbTUAoYuqQG4aQnieqEFhh7MCvy7s1+/8
         MoHPqQSICHrdUsM6UixTnNEgkYhCwjXKXfEL4x8UZmS+3jBlKqGg+QVR99oGGdNbVlpO
         9f4cK14OEmS02mCm7qKOdiuZC4jN/DgO7m3R1zAc8FSoj3BESwgGNkZF8nQJhIYq5kqd
         cU9Q==
X-Gm-Message-State: AOAM5337HIHp+IGHu2dChTUiZxCdd0zo7jKFNWSSYxiCMcNh2CXauv0W
        uXdIPanMQcZop+DcXoYyHjmBmdXkv7lRGUpfKkLfDMOS
X-Google-Smtp-Source: ABdhPJwYPA5Wwbsn5Bsl6VmK18xC/z5pn3c8d1ZtRWoDKz9MtYtQiinjDCeKz1nTDTs2Ijq9ILdsZ6wSmxaqAYY4vXw=
X-Received: by 2002:a2e:b6c3:: with SMTP id m3mr4068027ljo.450.1598328678873;
 Mon, 24 Aug 2020 21:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <159827024012.923543.7104106594870150597.stgit@firesoul>
In-Reply-To: <159827024012.923543.7104106594870150597.stgit@firesoul>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Aug 2020 21:11:07 -0700
Message-ID: <CAADnVQLd5jZaCJsAbLKautedAA298uydZNY0GH0bXCQ_K=gNgg@mail.gmail.com>
Subject: Re: [PATCH bpf V2] selftests/bpf: Fix test_progs-flavor run getting
 number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 4:57 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> Commit 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of
> tests") introduced ability to getting number of tests, which is targeted
> towards scripting.  As demonstrate in the commit the number can be use as a
> shell variable for further scripting.
>
> The test_progs program support "flavor", which is detected by the binary
> have a "-flavor" in the executable name. One example is test_progs-no_alu32,
> which load bpf-progs compiled with disabled alu32, located in dir 'no_alu32/'.
>
> The problem is that invoking a "flavor" binary prints to stdout e.g.:
>  "Switching to flavor 'no_alu32' subdirectory..."
> Thus, intermixing with the number of tests, making it unusable for scripting.
>
> Fix the issue by only printing "flavor" info when verbose -v option is used.
>
> Fixes: 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of tests")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Applied. Thanks
