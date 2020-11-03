Return-Path: <SRS0=gkZj=EJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65146C388F9
	for <bpf@archiver.kernel.org>; Tue,  3 Nov 2020 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE542227F
	for <bpf@archiver.kernel.org>; Tue,  3 Nov 2020 05:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcQ8Age"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKCFnG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 3 Nov 2020 00:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgKCFnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 00:43:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C65C0617A6;
        Mon,  2 Nov 2020 21:43:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k14so5385503lfg.7;
        Mon, 02 Nov 2020 21:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuNT1kBsmjFVlwCSohMVH0XAUpaiqhjCv+VgJCXYn0k=;
        b=LQcQ8Age9Axwo8J/829d2HXmpiJvQwk7ycJxrWRlT8zpJ3qF9MuzhIpBhvAhiSR+hb
         mG9XHWU7bdhknsPJxSxxMMLg2F/tuhgOGAcbS5bIbu7IeoTnEGsRaRlBTZHrssQgMhM5
         dhL4qOSKVAlKR/eigT63eGr05e8xe7fyDgp9mgTKE/F5t0ckHbU2jHiXavzhSYScwq1z
         xibrtSd4QPFO5DuMkxd0GEc55SHeO0TFYSscQuZyNrxlrlMlxMgYVMWyBguiQ7If+zgS
         dERkjRfy/0TIDpDmOZVyuv2rIHF4fV2COuff1yXN3jCbSObv098KCXOJVKUbWHf6GhOE
         7pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuNT1kBsmjFVlwCSohMVH0XAUpaiqhjCv+VgJCXYn0k=;
        b=t0Dmxj6VSIoKdX74cez0aQBqtBse5+MwmBuVpS9BZr6fzvkaFmAf8MmsqKP9vxnQ3e
         Yez1r1tpK7bfz86omtqKUjlr5ncZ7Mr4LRhtdnM5gz0rznN7lo5RF6j3kG+kfLV2/4KK
         /V39wgW/Re9PgyowolMcjzny7fog94lDGWv8VQMPn4bbohLJFGSyTb32LTBeQjVEA/i6
         FuHmB/NkVRGEvU8IxwQd6AEStvzRLa2O9sKQPzngM4YdN2vbG6xyCKt/uZ8SFbS8mgMh
         JnLRwlkJ9s0W2ruSqR0CFIpnaHfnGthADhelUlo3QKIzBG9NE8WZmOdU1sbF7k27H22O
         qmrw==
X-Gm-Message-State: AOAM531c3pGY3ZYh3NYc5YDaZkTwMV3fmjJuh2l8qd1ICozTafoD2EOf
        bxsBL/f0nGMIaHJ823MgWMPge6tbT5DeqEkwGG8=
X-Google-Smtp-Source: ABdhPJzqM9tOchv/OdQTFpb4w5KVIztjOUzx5R8fylmEUY5nbuLVIZ9e1iYxtp9SAi/9XGaS0db3wka/hT7ZlRkwOjU=
X-Received: by 2002:a19:8317:: with SMTP id f23mr6590718lfd.554.1604382183579;
 Mon, 02 Nov 2020 21:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20201007152355.2446741-1-Kenny.Ho@amd.com> <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com> <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
In-Reply-To: <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 2 Nov 2020 21:42:52 -0800
Message-ID: <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> Thanks for the reply.

pls don't top post.

> Cgroup awareness is desired because the intent
> is to use this for resource management as well (potentially along with
> other cgroup controlled resources.)  I will dig into bpf_lsm and learn
> more about it.

Also consider that bpf_lsm hooks have a way to get cgroup-id without
being explicitly scoped. So the bpf program can be made cgroup aware.
It's just not as convenient as attaching a prog to cgroup+hook at once.
For prototyping the existing bpf_lsm facility should be enough.
So please try to follow this route and please share more details about
the use case.
