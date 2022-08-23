Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E99C32789
	for <bpf@archiver.kernel.org>; Tue, 23 Aug 2022 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiHWWpj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiHWWpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:45:36 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B57FFAB;
        Tue, 23 Aug 2022 15:45:35 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id o184so17688494oif.13;
        Tue, 23 Aug 2022 15:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oHodqhGQVJUpYZFLY/dKxJcLvNCw1wll2BgbUR8IyRA=;
        b=ur63j5doB31+aKQ7n01E5tE7nrAOum/teo2y5QRmkBIkaZaVUiI8sfPftA2VGQZf6F
         zHlrQlU8jd7TyK6neOoN0YlsOOWsXR32tuSbmhHaCpFPNk9+0kSItUsuK/NKDqCPJvND
         EAmyJ8rqx0ikle4TSHPW95/bDJzXWMHBSzmF92VO+8toqUk08vqNy2S/WNtVDcpemwyk
         pXYasoEFBEvnvd16gZH3CkL5O0lv9D8YHPf/yubXmP8ZQ+E8ruVBbZHye28aSlqCDMau
         5gtMCM/NXYdG90hagbaF0sunDOd5sXHve1idMJcM2EALMmHOCG+/UXcq9rpE6S636sdc
         Hcgw==
X-Gm-Message-State: ACgBeo1ysCiuXaxdRFmHpKjy65StvjUsvyy5iF8if1dGvm+DI1PS+niP
        QK7go8jo01XYCpiR+ALQBqfcptjg6Hp0NVtuXYQ=
X-Google-Smtp-Source: AA6agR5QGf6/wKMX1dkxJ79qzB3ojAV6RPDLxuvjeqQBBJ/Ty7vG4R/UxIh9oGZT7FjwvgGXaOFAFRvaVAbsYftkFSE=
X-Received: by 2002:aca:ba86:0:b0:33a:c6f7:3001 with SMTP id
 k128-20020acaba86000000b0033ac6f73001mr2215025oif.5.1661294735248; Tue, 23
 Aug 2022 15:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
In-Reply-To: <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 23 Aug 2022 15:45:24 -0700
Message-ID: <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

On Tue, Aug 23, 2022 at 3:19 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 23, 2022, at 2:03 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The helper is for BPF programs attached to perf_event in order to read
> > event-specific raw data.  I followed the convention of the
> > bpf_read_branch_records() helper so that it can tell the size of
> > record using BPF_F_GET_RAW_RECORD flag.
> >
> > The use case is to filter perf event samples based on the HW provided
> > data which have more detailed information about the sample.
> >
> > Note that it only reads the first fragment of the raw record.  But it
> > seems mostly ok since all the existing PMU raw data have only single
> > fragment and the multi-fragment records are only for BPF output attached
> > to sockets.  So unless it's used with such an extreme case, it'd work
> > for most of tracing use cases.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > I don't know how to test this.  As the raw data is available on some
> > hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> > rejected by the verifier.  Actually it needs a bpf_perf_event_data
> > context so that's not an option IIUC.
>
> Can we add a software event that generates raw data for testing?

Ok, now I think that I can use a bpf-output sw event.  It would need
another BPF program to write data to the event and the test program
can read it from BPF using this helper. :)

Thanks,
Namhyung
