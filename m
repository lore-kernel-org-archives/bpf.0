Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F510796
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145041; cv=none; b=JESYc1WkcdMEmmlxtyx4YAPgJcfdksuCAVG4Z4j0jk+k2xG4/+mZtpsAQ8KAahb1WjsXDROxLNL0de5EkedtjuWtOpB4ZajU0G/0xLoj7mMtbWnIOlZRPa/LBPnaQvyw4UXTYvRd2050ST0euyACnwdXra9LQsNflvwWUF/zJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145041; c=relaxed/simple;
	bh=DcT66ko7vBL43v0rbhjVLHGBwO53COmY4khLrWM76dM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccjdjp7GPXU8P5VXguMetGkqUk+qbUosX7e05MojtjL3E4VSd4CSZsHbSD7ANXeTQPjJJngUUH75E56cYWCsHmDTNbP+gLi9fJCL4JQDhBYzktQcnth18sJYZ20wRqNZ71vVq0Iw8hUfYVfuiQtiMk1AnhQMsVRKOGbGAwZSALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuwUDetV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuwUDetV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4132a4b0971so2562495e9.3
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710145038; x=1710749838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9sHooF8FldApF8H7ljg9XtOinrRnXP+BPx0Qa15axk=;
        b=kuwUDetVahrVoRrzG2+IdrSQy1l4NsQ4ljLddI+IXTNK/5P44o6X0ussO24D6JDD0v
         QIeCuyj2pEfnoH2eyL5TJ+NGqXXFUdJceDaIZQZeo40uCjq+o7y0cWGtO3FD+Kei+i/s
         pWhVPQjFJk4+gEyPBXUaujHk/jRO4/Gt0/UwLBps0PnZgUeQrmlkbyPxQakDjVxo7L8t
         d/0AO1e+TArD0AAjZbvTIDXPYoocZvC20Lp3j+qB4VL/Er4g746S8Uhv+Y2BC0XzTn5G
         QagrtVJF68xwCO9kYlxgiKfycZEhlwElK1G1TiUaVfMKa8rzcqWHHjNekjtVokASgHmF
         sSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145038; x=1710749838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9sHooF8FldApF8H7ljg9XtOinrRnXP+BPx0Qa15axk=;
        b=ZTzjSTaUWwhSLbSqUXgyrTdPh/YzolLoRk8YFzuTIWPxP/H1fMMpChDw/v3J6Mm10n
         +7gjzHNDhJD15r7isdXdoh3oYeuXPv3Q+hiuPW6au2OQhl+xLjCuJwlI0cj0DcIFoY02
         O+S6ib0/IDVYnuSJ6wmZ+4Ic+OaDcB3XRg4m9aPCa/tLIEmq0QBuKxBfzOX+2eiC49Db
         2C/peDFKyZUKn175xifru9irsDNRh0PaRgayBoeapfg1XfhRCGCEO/Nh5Bv0NDC+88kR
         7rPqElNM15/B5s3dvuTkBS27CYd1cEGzuNIVfKAUIycNgzveMvKGov9qTGhvgks2NiJz
         TgQA==
X-Gm-Message-State: AOJu0YwG9wT7xnJweVb836dykoO1paIvh+A5rHV/scusaksAflLzXf/9
	YUJLBgJe/FB1W0zJTTF3OVzux+VAmj1afl7niCWqRqGm0O4ugkdT
X-Google-Smtp-Source: AGHT+IHXPIRmJC2xvFKushuH1VFGRIkCfLLas1BHx+dgcRvB1Gc7o8+vFn/bSmGgdYFH+ggHIyeJ7Q==
X-Received: by 2002:a05:600c:c0d:b0:413:28ba:1b17 with SMTP id fm13-20020a05600c0c0d00b0041328ba1b17mr1960266wmb.6.1710145037480;
        Mon, 11 Mar 2024 01:17:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b004132f3ace5csm65733wms.37.2024.03.11.01.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:17:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 09:17:15 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add fexit and kretprobe
 triggering benchmarks
Message-ID: <Ze6-CzsPJ6w3Modl@krava>
References: <20240309005124.3004446-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309005124.3004446-1-andrii@kernel.org>

On Fri, Mar 08, 2024 at 04:51:24PM -0800, Andrii Nakryiko wrote:
> We already have kprobe and fentry benchmarks. Let's add kretprobe and
> fexit ones for completeness.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/bench.c           |  4 +++
>  .../selftests/bpf/benchs/bench_trigger.c      | 32 +++++++++++++++++++
>  .../selftests/bpf/progs/trigger_bench.c       | 14 ++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 60df99b6ac72..8e02645afe31 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -495,7 +495,9 @@ extern const struct bench bench_trig_base;
>  extern const struct bench bench_trig_tp;
>  extern const struct bench bench_trig_rawtp;
>  extern const struct bench bench_trig_kprobe;
> +extern const struct bench bench_trig_kretprobe;
>  extern const struct bench bench_trig_fentry;
> +extern const struct bench bench_trig_fexit;
>  extern const struct bench bench_trig_fentry_sleep;
>  extern const struct bench bench_trig_fmodret;
>  extern const struct bench bench_trig_uprobe_base;
> @@ -539,7 +541,9 @@ static const struct bench *benchs[] = {
>  	&bench_trig_tp,
>  	&bench_trig_rawtp,
>  	&bench_trig_kprobe,
> +	&bench_trig_kretprobe,
>  	&bench_trig_fentry,
> +	&bench_trig_fexit,
>  	&bench_trig_fentry_sleep,
>  	&bench_trig_fmodret,
>  	&bench_trig_uprobe_base,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> index 064a1ef7a6fb..3f24be9cfcb9 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -85,12 +85,24 @@ static void trigger_kprobe_setup(void)
>  	attach_bpf(ctx.skel->progs.bench_trigger_kprobe);
>  }
>  
> +static void trigger_kretprobe_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe);
> +}
> +
>  static void trigger_fentry_setup(void)
>  {
>  	setup_ctx();
>  	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
>  }
>  
> +static void trigger_fexit_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
> +}
> +
>  static void trigger_fentry_sleep_setup(void)
>  {
>  	setup_ctx();
> @@ -261,6 +273,16 @@ const struct bench bench_trig_kprobe = {
>  	.report_final = hits_drops_report_final,
>  };
>  
> +const struct bench bench_trig_kretprobe = {
> +	.name = "trig-kretprobe",
> +	.validate = trigger_validate,
> +	.setup = trigger_kretprobe_setup,
> +	.producer_thread = trigger_producer,
> +	.measure = trigger_measure,
> +	.report_progress = hits_drops_report_progress,
> +	.report_final = hits_drops_report_final,
> +};
> +
>  const struct bench bench_trig_fentry = {
>  	.name = "trig-fentry",
>  	.validate = trigger_validate,
> @@ -271,6 +293,16 @@ const struct bench bench_trig_fentry = {
>  	.report_final = hits_drops_report_final,
>  };
>  
> +const struct bench bench_trig_fexit = {
> +	.name = "trig-fexit",
> +	.validate = trigger_validate,
> +	.setup = trigger_fexit_setup,
> +	.producer_thread = trigger_producer,
> +	.measure = trigger_measure,
> +	.report_progress = hits_drops_report_progress,
> +	.report_final = hits_drops_report_final,
> +};
> +
>  const struct bench bench_trig_fentry_sleep = {
>  	.name = "trig-fentry-sleep",
>  	.validate = trigger_validate,
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> index 694e7cec1823..eb94f9c0186f 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -33,6 +33,13 @@ int bench_trigger_kprobe(void *ctx)
>  	return 0;
>  }
>  
> +SEC("kretprobe/" SYS_PREFIX "sys_getpgid")
> +int bench_trigger_kretprobe(void *ctx)
> +{
> +	__sync_add_and_fetch(&hits, 1);
> +	return 0;
> +}
> +
>  SEC("fentry/" SYS_PREFIX "sys_getpgid")
>  int bench_trigger_fentry(void *ctx)
>  {
> @@ -40,6 +47,13 @@ int bench_trigger_fentry(void *ctx)
>  	return 0;
>  }
>  
> +SEC("fexit/" SYS_PREFIX "sys_getpgid")
> +int bench_trigger_fexit(void *ctx)
> +{
> +	__sync_add_and_fetch(&hits, 1);
> +	return 0;
> +}
> +
>  SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>  int bench_trigger_fentry_sleep(void *ctx)
>  {
> -- 
> 2.43.0
> 
> 
