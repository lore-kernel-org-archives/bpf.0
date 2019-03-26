Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D33C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C932820823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La6iFlXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfCZTtZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:49:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37321 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZTtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 15:49:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so9562569lfd.4;
        Tue, 26 Mar 2019 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCGsixk/jbwJ5w5KNx5/1gv0grTZBs5znHdwiBJRfCY=;
        b=La6iFlXsbYmx0iBA9aKCJN5yTuclNpiYGrnQiG08zrIRxCAVFzlgARKfpruiY0Cowy
         rtnC7IC331XyYggIGhtfq+j6PDiiTSTE+XAK19NfCcE4QETr/FqdvIktDUbsKNmiAl85
         3R0Z7PfEHiX4pn6Xdfq56c/J1X4aJl1ZbIed9mGBLTnv3oC+v2Magp9gcRY9JIglfSDc
         62ccxbmP89zohsU+CD2Ki6AFLnDaLL0ZNt+HYGlcAB86N3ytzoBDTNn3HL//0G1aWDNE
         da5omq/VnYlyGSle0FPVHAwwbTDSEfTamWyzvrgjXf2ZwppROFFSWjBiyh8HRW3SBGhM
         cNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCGsixk/jbwJ5w5KNx5/1gv0grTZBs5znHdwiBJRfCY=;
        b=HyapmKXQbatvZG+bDJXp4NxLILa8cz/KVA3ertymN+NQPf9o/d8j3/NFgHiAnKp0eU
         H8Li9RAOYadgDce6HzSqW3m5ZAnVwp59aUdUjuktrV9nBh9ctCPX3OxstOx2v9/IlSyy
         9jqbzIFc/vrUte/xqKf0a4cw6CCphsw8UE0ahhcnVCdKsC8c39q5hwBHDqMNmVevH087
         8s2zW4F2RguoaJA7Yzhlq2oxcTfuFg5YpXfnlPcvrhZPHnB/XqOjr/bXPMKj+VgB8Qyx
         56xcHNwvp2BbsZrvkPdYqcTthfBcQAUAMlFj+UvaV5VGtZN4w6Suuk5uOTRaHFtFWubR
         n1Ug==
X-Gm-Message-State: APjAAAW8OssEMIvOw5U0/u5h7SD1nA46V5AHkbjDSVbjkxm6RH2yXWy0
        HpgapAUKdRpdgaAM6ScTUCDtQHonZbxBZx43Xd8=
X-Google-Smtp-Source: APXvYqwat6w/x3ljdacn2kXgwPUlpb+j7Rfhi0c5rBuiBakoTzBhQkv8rNL1jZ9UBiQdhtsGJShfQRPQmZxIOW4Q1tc=
X-Received: by 2002:a19:a908:: with SMTP id s8mr16428164lfe.160.1553629762589;
 Tue, 26 Mar 2019 12:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190319215324.37242-1-sdf@google.com> <e880b488-1afb-d15e-29e2-df7940dc8def@iogearbox.net>
 <20190325164633.GA7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190325164633.GA7431@mini-arch.hsd1.ca.comcast.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Mar 2019 12:49:10 -0700
Message-ID: <CAADnVQK6XH-es39WeBjp_2Zj4uz4oBiAoTKudtNBbwvCk-5dYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: don't depend on hardcoded perf sample_freq
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 9:46 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 03/25, Daniel Borkmann wrote:
> > On 03/19/2019 10:53 PM, Stanislav Fomichev wrote:
> > > When running stacktrace_build_id_nmi, try to query
> > > kernel.perf_event_max_sample_rate sysctl and use it as a sample_freq.
> > > If there was an error reading sysctl, fallback to 5000.
> > >
> > > kernel.perf_event_max_sample_rate sysctl can drift and/or can be
> > > adjusted by the perf tool, so assuming a fixed number might be
> > > problematic on a long running machine.
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >
> > Mostly trying to understand rationale a bit better in context of
> > selftests; perf_event_max_sample_rate could drift also after this
> > patch here, but I presume you are saying that the frequency we
> > request below would interfere too much with perf tool adjusted
> > one and thus affect whole rest of kernel also after selftests
> > finished running, so below would handle it more gracefully, right?
> Not really, the kernel would straight out reject out attempt
> to syscall(perf_event_open) when sample_freq >=
> kernel.perf_event_max_sample_rate sysctl:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/events/core.c#n10724
>
> For this test, we don't really care about specific sample_freq, we just
> want our bpf prog to trigger at least once, so we can check the
> build-id.
>
> Maybe another way to fix it would be to convert to sample_period.
> Song, any specific reason you went with sample_freq and not
> sample_period in your original proposal?

I guess it's fine as-is.
Applied to bpf-next.
Thanks
