Return-Path: <SRS0=sdV5=6J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC99C2BA1A
	for <bpf@archiver.kernel.org>; Sat, 25 Apr 2020 00:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7902087E
	for <bpf@archiver.kernel.org>; Sat, 25 Apr 2020 00:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8dw0+7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYAoq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYAop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 20:44:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28927C09B049;
        Fri, 24 Apr 2020 17:44:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j3so11786434ljg.8;
        Fri, 24 Apr 2020 17:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzKKvPvTRv5jedvft3HGf7MSKwccH8TvsPU4jnF7S/g=;
        b=Q8dw0+7Mj+PiebMpguuY3GEbnEhu3A3RcnUKO9ZGAgYu6Z3FdhQveI54PP/Ji+l9Zy
         5D4Ep+XdxUNFDQx1xcJM4nsrwEIvSdJuRIXHVOtjNG8tXQVAK9cBnuHTp2Y0lKldpa5l
         QK0HzTicOF253e4gc1DLafYdcN/DSvjxuYuyMvygj8PFaPsyDk4FWGpdQyJMOaXgj/i0
         uyorSZIniih/X7+vox1VQtqnMPkRfLiMbLDn+IXXYPJdo2zGprxIiyD88RY+xanFHtOB
         SQ+FqnrntbK3WU+i69KSnpL3KmA1c4P7LA9QkfMfkLytsZJ8iq7eWH9f/6RHGcM6P+sq
         Qgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzKKvPvTRv5jedvft3HGf7MSKwccH8TvsPU4jnF7S/g=;
        b=iCHKjKDIHpLAnc0NG2ERgOsvq5SL9M7WWMPP/nSP9DBP1YGFvnPbzm/kfustslbcr5
         hQBsgpG0s4oEcsdd5JOFu5RlMNCQGi8jSeb8TUbLB2oDY7jtLT81Tj/yXRzB1EUTmwcL
         kMDPUwgmkPrmbk+OyOCJDmZc5SkJrHwDlwOZWV4MI4HBT2En5sEbdO/TfnpJi39MsB7o
         PC/TEUUp2hHHMpdSPfuLJKoNnCSXl9nHkDsWV8xCQTuYm3MI4rqouUuzUBmfO05QU0P6
         xIKSdAxbm1Ln7d21lY+HMjpINJ81TMsworL7M745E96cYenw+N8JPZQv8QxiacPqw1DC
         LevA==
X-Gm-Message-State: AGi0PuaRITJUM1dhahXw/1jy2wvrbIyBnqRXuib59fSwgX1qEqF90Jyc
        ZseDvmsdh+w1Z72HfosO0hR+TnhJXdX+dXVGPN8=
X-Google-Smtp-Source: APiQypJYVNzIHY7mZErfuL8JKO7UQTjprH2H9+55b4W0WwaynLxE57Of8Tmpz9gOZALE5GqURZRGgmtyPcLNQBRqBE8=
X-Received: by 2002:a2e:7508:: with SMTP id q8mr7378532ljc.234.1587775481719;
 Fri, 24 Apr 2020 17:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <1587609160-117806-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587609160-117806-1-git-send-email-zou_wei@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Apr 2020 17:44:30 -0700
Message-ID: <CAADnVQLzuHpW1_dsqNHsgahEWqeQYPyCeuAW3V4NTaxjamwByQ@mail.gmail.com>
Subject: Re: [PATCH -next] bpf: Make bpf_link_fops static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 22, 2020 at 7:26 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> kernel/bpf/syscall.c:2289:30: warning: symbol 'bpf_link_fops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied to bpf tree. Thanks
