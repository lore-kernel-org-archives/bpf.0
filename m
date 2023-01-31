Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED54C636D4
	for <bpf@archiver.kernel.org>; Tue, 31 Jan 2023 23:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjAaX0l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjAaX02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 18:26:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EB5926C;
        Tue, 31 Jan 2023 15:26:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so46314173ejb.9;
        Tue, 31 Jan 2023 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L60D8tnk3gz98lVqrbQD/Zw2KaZZzSugic2pEzgCCnc=;
        b=Bhqtus8d++gBlD9TgXXGtVMztP0ZiJZUXq5YDhRizbfKQgRPA2eWIkbWPmAer+nOki
         e/caNDrhjleZIHK+5vE0TNppiP8O453jXtdJSNcM2Ai9ZSLyoEloQVxcqHHaRhZ9IeSU
         f2Ds80R3SqPKxPdeSm5EVu/YJIUn8ZvgDGiJe+MN+Bpo2sRGN7lg1m1ujrToD+iVATAZ
         rzRk2QoPG4m93eD5ffxaPQCTVGb6hIsgdjQvxFAguC3tepCBvGOvahPOYIQLG+JdGI1U
         ySzARtehCuSQYL/02nRL7yGdYeylQY9g/bXdYgC/5loPferXKIdwFDJImAoobNLUqj4q
         tiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L60D8tnk3gz98lVqrbQD/Zw2KaZZzSugic2pEzgCCnc=;
        b=4gsO9kZY4VfkK9JI44Ov+Sk/cvPrxEjSLtkN4CfyE7grErZZp6gJEs2R7EBfvMwOGT
         QX3vWNSnm1D+vzzLnIDKfHqxnzZTBCiC75qX95CFRacOirPFuHX9o+R3k9+8UfBzWE0r
         jHfdk92VxIjoXjtE9SfKBTpdsBtl8TUk/IOJRLl4D1FzajiOQQm7T11pZHbn0IU01hPo
         CVdwp1aUkLE6qpHFIMu3cPJNy6Ajs7EoIj/qSIf7KkWrrittM1x1PubNxVFInJZXNrOI
         o2FYQzWPG2D3d8Xt4LCanGbeYChtGPTyqE49FpS0Qz8Hr2XGeBamSvSsAmvzz7uG44/R
         r8Og==
X-Gm-Message-State: AO0yUKVN11/eHC5/6XWhRlVRPhakJ7R7K14hp1auRku8qMIVBhCKvJO1
        GXVr9iA8W7POvqVwLWZXoZUOmXyd9NWdn4yeKG0=
X-Google-Smtp-Source: AK7set96aoggJMkQVqY9hUdO5Nb6fqGGfskzbFu0kdlInpv7/E4Gy3k/aiXAVAsG1OJ5QU/c9BiGoYhlEre6MOOnnhU=
X-Received: by 2002:a17:906:4b57:b0:878:74d0:c173 with SMTP id
 j23-20020a1709064b5700b0087874d0c173mr31824ejv.264.1675207566219; Tue, 31 Jan
 2023 15:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-4-zwisler@google.com>
 <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
 <20230130145932.37cf6b73@gandalf.local.home> <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
 <20230130183419.0626dc21@gandalf.local.home> <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
 <20230131145048.6fac87d3@gandalf.local.home>
In-Reply-To: <20230131145048.6fac87d3@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 Jan 2023 15:25:54 -0800
Message-ID: <CAADnVQKpkuBdQWWGDBh13NCrx2WMPs4fVUyVujF4L-6XnjXFpg@mail.gmail.com>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 11:50 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> As code in the Linux kernel is used as examples for future work, it should
> not be using an interface that is obsolete. That's enough rational for code
> churn.

Fair enough. Please resubmit these two patches towards bpf-next
with [PATCH bpf-next] subj, so that BPF CI can chew on it.
