Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E55382F0F
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573549; cv=none; b=N3Ih8XXkYHJgNR3bDPMlBfGEtlj/BDvnxiEzdD1ftRVFUoLQa/PHFhHiRQTTzgs/9j49OYpFepYGGAvGsdBKTVbvKkxLIWVVq1TioFyYs3ByVEFGdQuTczLEq+aHNlEDmWmw9Xph/H+GzeFkWckS+V6qYwyrVa7LcLcX4Xsyw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573549; c=relaxed/simple;
	bh=uQoYobiJBLW1BwG4IeY+AthOG/587Taupj/7yoajbuw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/1HhmBLpqHt2NcD8PV+TI6bwwZZ1x68rSIglatNSOsqiaTirtgBiXqJCUtd8AedFJ+xI9u+gwYplO7S4/tWhbPMZrcgRHDwyZspubsd/asF8/8YWisUDUlzZ/DYT7tjsHqTzI3KAvz6AfoR7tKoSlYwV2X9Khdt8dhZ0TVMJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/kHgP0F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/kHgP0F"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48378136adcso36842815e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772573545; x=1773178345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jFfuFE8AhVRdTQIo7yFIA0XBx4MtB82nE83fwRvD6WM=;
        b=X/kHgP0FzP4oeBcJSgmywn0E9Rzbl7VZOoJKx+x7DBg+mdoJuPuHssUZnKevzmPG1o
         Or0qJrFzOlC4PkfBkgVDjoeAJkkFChno6GPIqexNargHLdkLl6Mtv86uLIeU3NOLRcbi
         eP2CKaTFAJfFP/vi/Ft42DtY40/MxRBwXhYzuoa0xTeYB/7hZN2xgY6XtVufSSjQQeSb
         RHmwgXY0QCs2tCgRzy3LASyAoH6Hbp/gfhMdyXd8RVUPFW9jBnHfY/vstT0NviIv9qiW
         qY6BDs3urUqGCssyeKmVwRGo5+ae/Yay/Y+o04r03qvi1Lkwb0PObl3ZU4vAS4VPvXkY
         xzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772573545; x=1773178345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFfuFE8AhVRdTQIo7yFIA0XBx4MtB82nE83fwRvD6WM=;
        b=DoE7qycjbjWC+L/MqXQj1ktSHG/AoYfe7mQN31PbZjCvV9xUO+Zj79tkmM4+2z3/sP
         ZWXvjmcf16xIdqn0sC6KzrWQMzCPzAedPh+48lHL/BHf96hB6tdgTM4udbDs4jTqCyr/
         wyCkH1fvswuoq0WBtz9DUAM9E8n20OgJeWn6esk9MYcpU+Bu+r3cAw2Rgw02N9ygQ4Fc
         y1BVuWUWFLVEjFIUVEU9Bo2oUtebD2tOe5q+rvJQz7O2zaMVKplJb/y+Fer3nLlnDD3D
         FceyYDz3ihPh1DlKlP8YmaycoJSpjlan/cIOfL6vAVhXGMwZzDOekMFyIDMPZ4k0g5Ia
         11ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmF/Z7mxu+GAzJVRboMiCzXZVJ8BqLTyOYy3ezaS+cOdZPHFQBULIDc6VG8ZCws2j70Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbnr7wyxAm5CMORi1tOSZhH4m4i93U+geExBFv/qmfTSnCVK/
	eOQKV1DlgvO7IfYJVroFMYBAWraR4DGmpR3jEA3MOX6EfHQWZag01qF5
X-Gm-Gg: ATEYQzzXSRn0PywQ6+wfnhp7pzPdC1WBA68cDxUERH6RZbpQK3n8v+G+g9RJa1aH2kT
	Qg0d/bEIg18fq8zhrBkkXj4X1gS9hKmvAadKBkdt06s+N25gTmrkx6w+BNp1JXb35eo3rzknk8J
	OZGo1WvT27nkL/4zCdcHKXY+g/fRid9ZrqoqJhpvKFQlq6U0XdMMA6nXDD1eRjPRoFUbQrPi6k6
	kp6FIFSJTPX4BTEjuI5Vq8CLMIC6elq9vIEjGS2+z+dhavFsMHSLZyWh+chboEVJKNUptHglrqE
	s63Bk7UqppJ6UQx664TuZV709jbdB6t7VdPynEEn9X2buV/M5hdj7mQhYQ3nwo/xk3GkmCYSHgu
	PZxFe/qd0uhK+mOK9Dd0AOSLSGPOMqG1KwWbMFO/1fZIIw9MjRzSQb1OZCfy9/+vRPJ8UJgU21U
	r32XdGYZ1DqjA=
X-Received: by 2002:a05:600c:3e0c:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-483c9bbcdf3mr295238065e9.11.1772573545049;
        Tue, 03 Mar 2026 13:32:25 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187bf2fcsm6734425e9.4.2026.03.03.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:32:24 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Mar 2026 22:32:23 +0100
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/bpf: bpf_cookie: make perf_event
 subtest trigger reliably
Message-ID: <aadTZ8r5XAn4-pOt@krava>
References: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
 <20260228074555.122950-3-sun.jian.kdev@gmail.com>
 <aaVgTiHlc4rXvzKJ@krava>
 <CABFUUZGAK-kD75QAc8acfoGvPVj+EuaFNLT7rcPcWP7SOnpKqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZGAK-kD75QAc8acfoGvPVj+EuaFNLT7rcPcWP7SOnpKqw@mail.gmail.com>

On Tue, Mar 03, 2026 at 10:15:26AM +0800, sun jian wrote:
> On Mon, Mar 2, 2026 at 6:02 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Feb 28, 2026 at 03:45:55PM +0800, Sun Jian wrote:
> > > The perf_event subtest relies on SW_CPU_CLOCK sampling to trigger the BPF
> > > -static void burn_cpu(void)
> > > +static void burn_cpu(long loops)
> >
> > nit, there's another burn_cpu in prog_tests/perf_link.c,
> > we could add it to trace_helpers.c or test_progs.c
> >
> 
> happy to refactor into a shared helper if maintainers prefer, but I keep it
> local to minimize the diff.
> 
> > >  {
> > > -     volatile int j = 0;
> > > +     long j = 0;
> > >       cpu_set_t cpu_set;
> > > -     int i, err;
> > > +     long i;
> > > +     int err;
> > >
> > >       /* generate some branches on cpu 0 */
> > >       CPU_ZERO(&cpu_set);
> > > @@ -443,9 +445,10 @@ static void burn_cpu(void)
> > >       err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
> > >       ASSERT_OK(err, "set_thread_affinity");
> > >
> > > -     /* spin the loop for a while (random high number) */
> > > -     for (i = 0; i < 1000000; ++i)
> > > +     for (i = 0; i < loops; ++i) {
> > >               ++j;
> > > +             barrier();
> >
> > what's the rationale for barrier call in here,
> > together with the volatile change above?
> >
> 
> The burn_cpu() loop is only meant to consume CPU time to reliably trigger the
> SW_CPU_CLOCK perf_event overflow. With an side-effect-free loop, the
> compiler may optimize the loop away or significantly shrink it under -O2.
> 
> The old version relied on volatile to prevent the loop from being optimized, but
> checkpatch warns against it. Using barrier() achieves the same goal  — keep the
> loop intact as a CPU-burn  — while making the intent more explicit.

ok, would be great to have this in the changelog, other than that:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
