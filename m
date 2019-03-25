Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8569C10F03
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6492087C
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="JsFB6Cr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfCYQqh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:46:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42804 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbfCYQqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 12:46:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so6698888pfn.9
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2019 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vgSXodRe8p3+p6qeVRpInQzzxzgpiDDDNX5gzeFMyf4=;
        b=JsFB6Cr2pHEw+4Wjxv+y/wTZRfGiaWMgm8AhtWh6dxHvri2TIB69TM51vLX/FVOant
         TzwHxO3OqTTvcesY506vmR6+RZ4pvCZY5vE7a6EMqb/VAUVcgNw29thktfkknfTPFXLe
         85DncV+c+F1XNwd/HB1BoE6TcHa6lyaj/EJfp+P7bXhTfTDKp5/VuMKm748VtPEVPGDH
         OJtJqyb20Wb7hMwaSeXvBnYtOfxV5rkcFEfZW1wRtWoTcVO3Vaog2ELU8oYsb/diu9nw
         2BWe15qZYkapooi6EesTNWrPaSu7AW0F9eLvwsZgtOmfzZuKhTBLyybuhvBCir3XIlyv
         KsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgSXodRe8p3+p6qeVRpInQzzxzgpiDDDNX5gzeFMyf4=;
        b=bGm8o34BODPJwrHfB7W01TyfHWMGbI+7kNHWYaonO6hd29bylMPUrk9TSzqpfX8N3h
         6aHlcOksvJrx2tCZwwDwtfaMVa43Qx4S/B+SvFM14+ykubrMJvumbhWUNUSVe7RM4vdO
         dh6jIAvufhkJbot48gfAJ8FBicEY3lxZiPFjUYOiRQPIgyoul0iyxyhrmeACLIOb2gKH
         4iW9CvMWkcP/8MxgRv4ZfMAREcfeAdzvR6z8UfordyUoXlH+qnxzr0wKXJLld3snIyyV
         TB5Fh5dodBfnxup+n4mA5MeKpJx/VuRXRITeduM6tfM2kMj110/qS7y3XfxCH9ACJNzi
         WdEg==
X-Gm-Message-State: APjAAAWd+LI7OfaPGmgOAvxaBLirwNXE/6CX4/Pgh12HY2A/XbRkQtjg
        ZKicE/Jh2/rPZwJaIX1OgSRQ7w==
X-Google-Smtp-Source: APXvYqxbxzUmeuv6Wg+B0ee09XUk2uH0yM4sQAFdX/kOE68jnll7xii3hfk1qncLiaFGjjlleFw/sQ==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr5440772pgc.7.1553532395841;
        Mon, 25 Mar 2019 09:46:35 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id y2sm15939412pfm.47.2019.03.25.09.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:46:34 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:46:33 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH bpf-next] selftests: bpf: don't depend on hardcoded perf
 sample_freq
Message-ID: <20190325164633.GA7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319215324.37242-1-sdf@google.com>
 <e880b488-1afb-d15e-29e2-df7940dc8def@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e880b488-1afb-d15e-29e2-df7940dc8def@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/25, Daniel Borkmann wrote:
> On 03/19/2019 10:53 PM, Stanislav Fomichev wrote:
> > When running stacktrace_build_id_nmi, try to query
> > kernel.perf_event_max_sample_rate sysctl and use it as a sample_freq.
> > If there was an error reading sysctl, fallback to 5000.
> > 
> > kernel.perf_event_max_sample_rate sysctl can drift and/or can be
> > adjusted by the perf tool, so assuming a fixed number might be
> > problematic on a long running machine.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> Mostly trying to understand rationale a bit better in context of
> selftests; perf_event_max_sample_rate could drift also after this
> patch here, but I presume you are saying that the frequency we
> request below would interfere too much with perf tool adjusted
> one and thus affect whole rest of kernel also after selftests
> finished running, so below would handle it more gracefully, right?
Not really, the kernel would straight out reject out attempt
to syscall(perf_event_open) when sample_freq >=
kernel.perf_event_max_sample_rate sysctl:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/events/core.c#n10724

For this test, we don't really care about specific sample_freq, we just
want our bpf prog to trigger at least once, so we can check the
build-id.

Maybe another way to fix it would be to convert to sample_period.
Song, any specific reason you went with sample_freq and not
sample_period in your original proposal?

> 
> > ---
> >  .../bpf/prog_tests/stacktrace_build_id_nmi.c     | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > index 8a114bb1c379..1c1a2f75f3d8 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > @@ -1,13 +1,25 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <test_progs.h>
> >  
> > +static __u64 read_perf_max_sample_freq(void)
> > +{
> > +	__u64 sample_freq = 5000; /* fallback to 5000 on error */
> > +	FILE *f;
> > +
> > +	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
> > +	if (f == NULL)
> > +		return sample_freq;
> > +	fscanf(f, "%llu", &sample_freq);
> > +	fclose(f);
> > +	return sample_freq;
> > +}
> > +
> >  void test_stacktrace_build_id_nmi(void)
> >  {
> >  	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> >  	const char *file = "./test_stacktrace_build_id.o";
> >  	int err, pmu_fd, prog_fd;
> >  	struct perf_event_attr attr = {
> > -		.sample_freq = 5000,
> >  		.freq = 1,
> >  		.type = PERF_TYPE_HARDWARE,
> >  		.config = PERF_COUNT_HW_CPU_CYCLES,
> > @@ -20,6 +32,8 @@ void test_stacktrace_build_id_nmi(void)
> >  	int build_id_matches = 0;
> >  	int retry = 1;
> >  
> > +	attr.sample_freq = read_perf_max_sample_freq();
> > +
> >  retry:
> >  	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
> >  	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> > 
> 
