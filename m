Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946FC433F5
	for <bpf@archiver.kernel.org>; Mon, 14 Mar 2022 17:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiCNRaU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCNRaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 13:30:19 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55979DEB6;
        Mon, 14 Mar 2022 10:29:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h11so22992523ljb.2;
        Mon, 14 Mar 2022 10:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wluxvZZRX4EKbcVvJ/eg3d1hoy/ZEcP65mxSGZfR8b8=;
        b=XbwNDwKpXgp1ZuRwvwpoko54IbbMOYB3f1jXrHsKFNnutQZZNr2zneAW2SgB6xN+qn
         dN/hzwHJFHB8afHyFrbl6J74UeRKU2KkqC3f/GBNuktY0xYCeR4+UNEToPpvnZ9YW9ut
         nMvRm/eRguVIFYH9ghX9fnnHD9GVQU8Aek6vb1TPx1aD5nsRHeczjDx+47RaQ6MBYzIo
         SlFGtgi70yQItdbHaJWwlzzaOfJDoxA5O7tPZ64YFiH9b9pUMIYvTqVgzBvwQLzzSF40
         g5VEGw3PqIabA8fMo6+FxNlf2JAQQoP+uUje1WomJBKVCFGx4rjHN2OjsCwu+XydO38h
         /5qg==
X-Gm-Message-State: AOAM532HCYcmQI0A876T+uTQh98UvI4mVZVv+I+FC7PXcKF+4aQNX6MF
        TaLgdh/H1oMxo6EP0j84dWRVE6mm3DY+H/e87M0=
X-Google-Smtp-Source: ABdhPJyDjw6SAJ1pG95ESM8cb9VMKIADALppkjSv7LXf4LGBo6GrfONjwX+IxH0EO7+FzyBugxipqjskb8vqlGjBREY=
X-Received: by 2002:a05:651c:1051:b0:247:ea0d:a57c with SMTP id
 x17-20020a05651c105100b00247ea0da57cmr14118926ljm.204.1647278947501; Mon, 14
 Mar 2022 10:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220310082202.1229345-1-namhyung@kernel.org> <20220310082202.1229345-2-namhyung@kernel.org>
 <CAEf4BzZUEvCqz-zGdKAeyg3vywEEnFWuZ4Q446BrTGOsFqNqyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZUEvCqz-zGdKAeyg3vywEEnFWuZ4Q446BrTGOsFqNqyQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Mar 2022 10:28:56 -0700
Message-ID: <CAM9d7chtq2DV28GU=_eb+MSUTPFg8oGX8NDeeLdnf=Vr+7E1Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf/selftests: Test skipping stacktrace
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eugene Loh <eugene.loh@oracle.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Fri, Mar 11, 2022 at 2:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 12:22 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > +SEC("tracepoint/sched/sched_switch")
> > +int oncpu(struct sched_switch_args *ctx)
> > +{
> > +       __u32 max_len = TEST_STACK_DEPTH * sizeof(__u64);
> > +       __u32 key = 0, val = 0, *value_p;
> > +       __u64 *stack_p;
> > +
>
> please also add filtering by PID to avoid interference from other
> selftests when run in parallel mode

Will do!

Thanks,
Namhyung

>
> > +       value_p = bpf_map_lookup_elem(&control_map, &key);
> > +       if (value_p && *value_p)
> > +               return 0; /* skip if non-zero *value_p */
> > +
> > +       /* it should allow skipping whole buffer size entries */
> > +       key = bpf_get_stackid(ctx, &stackmap, TEST_STACK_DEPTH);
> > +       if ((int)key >= 0) {
> > +               /* The size of stackmap and stack_amap should be the same */
> > +               bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
> > +               stack_p = bpf_map_lookup_elem(&stack_amap, &key);
> > +               if (stack_p) {
> > +                       bpf_get_stack(ctx, stack_p, max_len, TEST_STACK_DEPTH);
> > +                       /* it wrongly skipped all the entries and filled zero */
> > +                       if (stack_p[0] == 0)
> > +                               failed = 1;
> > +               }
> > +       } else if ((int)key == -14/*EFAULT*/) {
> > +               /* old kernel doesn't support skipping that many entries */
> > +               failed = 2;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > --
> > 2.35.1.723.g4982287a31-goog
> >
