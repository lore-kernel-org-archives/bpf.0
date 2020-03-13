Return-Path: <SRS0=iznb=46=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338AC1975A
	for <bpf@archiver.kernel.org>; Fri, 13 Mar 2020 01:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B4F206EB
	for <bpf@archiver.kernel.org>; Fri, 13 Mar 2020 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNnFX82R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCMBI4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:08:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44646 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgCMBI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 21:08:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id b186so6377994lfg.11;
        Thu, 12 Mar 2020 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFZTwxtvHmbR8FGBAZEQHlHjy9eP9xsGyxbdiqw2rGg=;
        b=LNnFX82RYgXEDMompu9/c4zJOWIAlzVHb6INpXilyJDbBastB2ziUScbZI4T+IM7ko
         0cYpxyUgHgdQgJDRA6R+87+CPu6Hkx3m6O01vtDXNwKLvbBTGgkmzw51KqukLu9xwblK
         Nvb2amlzx/Tg6p++ePzzAeAMrl8OQL0ByPUMeD301IB0Ae7tpfkjeQi8oymqZKHYcP0t
         Z4Zif9TK5JZWvb4mtfmAWlUFU71cHBXfkp3uMeNVIcQu1K7ER5+t2aocfIeF9LsJGnps
         boV4cNnSfVkDvOyDiU47ghx90sAOxVTPfmbuWrbMo3nsnOJCGJvmC5KxTZ1PhgiRYif9
         DWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFZTwxtvHmbR8FGBAZEQHlHjy9eP9xsGyxbdiqw2rGg=;
        b=BHHqHwpk0JGbHfhUS8mHfVBXVDVAiKESit1NxpTK7eCp3kZkkcXHv3LJqj9HkcxhZH
         mx/EPID2ntJj2+Zd23ThNH4tmAU8cIMSAYwZieTaanYOhsfA8FpmQ6kYCIK4nHLenw4u
         Q9qw8TDH4qHzNvrUcpY7UFEuBad9J4BOuApeo2VabV5A28TH3k/SvyI5P8TeHNFcFKlv
         xaKVFGE7HwZX6hoBRTvYz7E+ZeqnMxxd489kyY/xRfe7HjsVPLehkTZ1gg+6qdM/bKER
         8JYJIq0jIZ/8MyUTttQNrGHqMh6Oph3Djk5EtMcGbGY4JWUsNEEq7E8JhqpPZ/VidbLc
         M7IQ==
X-Gm-Message-State: ANhLgQ2ppxBbtnyxiLcCCI6xtODBsjwSHj2+vGvCiLtAxxZeR6BSRbDT
        lEgFsNJ/vHVXQIyDWjQIA9QKRHSKrtOyGfUl7F08RA==
X-Google-Smtp-Source: ADFU+vtXInopGZMDeZeZx9zVUljjBPFpFJTFPdHx5ySCV4yRy4d6Er6IXK+MP69DM49KA9iBWwjPGO5n7wY60TQDRMQ=
X-Received: by 2002:ac2:418b:: with SMTP id z11mr6952361lfh.134.1584061734030;
 Thu, 12 Mar 2020 18:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200310215824.17139-1-steve@sk2.org>
In-Reply-To: <20200310215824.17139-1-steve@sk2.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Mar 2020 18:08:42 -0700
Message-ID: <CAADnVQKX=LP_6FZm7Viiimb36+9Ok5Yqa5uM=ZXX=5kc2j38qQ@mail.gmail.com>
Subject: Re: [PATCH v3] docs: sysctl/kernel: document BPF entries
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 3:21 PM Stephen Kitt <steve@sk2.org> wrote:
>
> Based on the implementation in kernel/bpf/syscall.c,
> kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> in bpftool-prog.rst.
>
> The section style doesn't match the surrounding sections; it matches
> the style of the reworked kernel.rst queued up in docs-next.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied. Thanks
