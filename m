Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A2411A01
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504828; cv=none; b=p6TlbayYmueoZwGtNN0BQ+8loDcj/mJp4yMJ/sNdoXV+nTtIXeoC3iU8IIsedttls/qgOgrZAr0MIW4L3LoBEIv7x3Fi2g+AHjyc97q+esFE4xfqmNojpepB0iUj3EGbFli1pz9s9vxusETgg9IdT69KthVqIvFM8Lwlq76yk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504828; c=relaxed/simple;
	bh=E6iVu8a/ec9mnm9FMCXI6Nm/poLUIfvZ4FKSyQhg698=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ4TpXfbAo122JdNmaPH9XluuW3kMfCQqVA5eY4rzkABHb8n5Ziv+ovl0xA+ufvTuC1wkVB39fjZQWf0M45+c4D4S3NBMd7hWU4RVkW+m8HEWte6Hl5fd6zueJGtw6YvPV0sNgUsEtw4HYeScCIoLGtDse+lpY4LcYzgH/m7Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKWx98DE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKWx98DE"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so1855556a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504825; x=1786109625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjaUc1SiB8XTSSq8oTqhInDIunuYgzO6br5wDyE4FFc=;
        b=UKWx98DES9tDlhDASZky1IrN/Xca41vBU9nj+MLl5LlyYuQt78G0+z6thUP6gwhKy0
         LdR40NiEP1TwI3EJ8dCnNTDwLK3x0ipWQ7nLOrDuIp4cw2yUkQoP9xEX2EUirjBHraYS
         7nd5GklAJNpK8UUlvzywi0aViCJP4bf0vIXb9cD4AjWG3Sa3dx/JhlYf67h7KUDtF3FJ
         OwEwUjuGAeligvNtRLdccVwJM1yMfB92Ir0AZNAXXUhMPJhWtW1jpIUbzKll0ZH/4qaS
         DZW8bmCoHRACIBaZE0h0G67AcGFKYEY4T9sI60g1Rk277KafVzt9pjoIN0bYPcNfBfUi
         vV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504825; x=1786109625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vjaUc1SiB8XTSSq8oTqhInDIunuYgzO6br5wDyE4FFc=;
        b=rGAaw/duQv532+YgH7JfNyjZYpSC3hCLyN4XfAZkdvSm708uFKAw8+RqT2cAis9Fz2
         p1VxDnE3S3nkKwMWotcVe56Ub1bv+0LPA6JKrflWFHCIUqI0FrKfuDO9fZ1v9qCkUGLi
         cITejBaf9VA8kHSn9gjn33jos9x/QeGpwt7vlqb/HUMS8chus5aAooRwFuYCfm/6nI31
         GHLbtoEcexHGusGejz0KYWQAZGBUTbByu/8g0AKzDad/0E4KHX5jBnYP6PPzaJSN0oq5
         y//8b/1wUkXzCng7l5ZPgA21/+qp9OrYnqwd9La7nbGsdcInncQv/ERBPOWzPQmeMzGd
         hrQg==
X-Forwarded-Encrypted: i=1; AHgh+RqgoFzYfa4h4hLrvqVcVtOseY/xJbivsRR1xBwGiqnW5/wFE1Ml9ypptCAMyAMdXNs8Tcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxax1T3C13vkMXKb7zsKMqIPtsPG3x1oWIMyTDLv6naEATuncxV
	NihgphZyKHyiWJbaLG6TCtPWbNmbvrHxU9IeJTTYP5pdyLggJjF4V7sz
X-Gm-Gg: AR+sD11yTdZ5TFv5w/vhkIbVbWmm+NS0mPiMov3LvuH8zay2HNPIY986KsfabtHZAuO
	MATZGgUrgW3QNjBofCfsYVyj3x1o4S0OI875wWecYVmN3D7sS3VDG3CmzY9+/DLJlyN8UzSUIpT
	+kV/tgsckTNmu0RgGMleWGiwthcnNA9NEKr/MXSJL+1N9uvBcLSQWaZb9LQIH60bMYZV5sfcXUQ
	60KYT/jpT/BvwHxemCKKFqx/ddR7vQoQEZy941RMoFd21OKesl5CAj65ccYbqasVvPUTD+8vLbz
	ru988m8BaDRSvTIrwCGzmLhCqA5yXjvuaGER1wOft2AEVTDeGWU8K9QuAJ3gSjr+il/FCtAT++F
	X/ZGATg0okjYewc737Tv3j/qa0UlWkdMsbpx6BzpfhLyvIetX7T5EwzbR8ydEO2XclJNTqmyDlb
	vAmy9TLZCR3UdZQvKacFO3K4KYDmKGPn/xuMHcSMG8F0ujAQwchubuH8c/lg==
X-Received: by 2002:a05:6402:2106:b0:699:fbe4:16d5 with SMTP id 4fb4d7f45d1cf-6a0987cc820mr1092010a12.1.1785504824434;
        Fri, 31 Jul 2026 06:33:44 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a0556sm1856441a12.5.2026.07.31.06.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:33:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 Jul 2026 15:33:42 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>, Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv2 bpf-next 08/11] bpf: Restore trace->nr value properly
 in bpf_get_stack_pe
Message-ID: <amykNotpsnxhWNYI@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-9-jolsa@kernel.org>
 <CAEf4BzZWgmL39Q8kQNu8B=-B1Vw2OipHvCaLbxCgU9XE6aNfVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZWgmL39Q8kQNu8B=-B1Vw2OipHvCaLbxCgU9XE6aNfVg@mail.gmail.com>

On Thu, Jul 30, 2026 at 04:01:28PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 29, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > In bpf_get_stack_pe The __bpf_get_stack call changes trace->nr value,
> > so both kernel and user path need to restore its value back.
> >
> 
> something feels off here, this trace_in->nr restoration just in
> bpf_get_stack_pe is weird. maybe we should either make sure
> __bpf_get_stack doesn't modify trace_in->nr or restores it before
> returning to bpf_get_stack_pe()?..

I think it'd be cleaner not to modify the trace->nr and just
pass the wanted count as argument, will check

jirka

> 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/stackmap.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 05269f2a9e08..875f530f3597 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -942,9 +942,9 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >         struct pt_regs *regs = (struct pt_regs *)(ctx->regs);
> >         struct perf_event *event = ctx->event;
> >         struct perf_callchain_entry *trace;
> > +       __u64 nr, nr_kernel;
> >         bool kernel, user;
> >         int err = -EINVAL;
> > -       __u64 nr_kernel;
> >
> >         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> >                 return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
> > @@ -962,15 +962,12 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >                 goto clear;
> >
> >         nr_kernel = count_kernel_ip(trace);
> > +       nr = trace->nr;
> >
> >         if (kernel) {
> > -               __u64 nr = trace->nr;
> > -
> >                 trace->nr = nr_kernel;
> >                 err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> >
> > -               /* restore nr */
> > -               trace->nr = nr;
> >         } else { /* user */
> >                 u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
> >
> > @@ -981,12 +978,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >                 flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> >                 err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> >         }
> > -       return err;
> >
> > +       /* restore nr */
> > +       trace->nr = nr;
> >  clear:
> > -       memset(buf, 0, size);
> > +       if (err < 0)
> > +               memset(buf, 0, size);
> >         return err;
> > -
> >  }
> >
> >  const struct bpf_func_proto bpf_get_stack_proto_pe = {
> > --
> > 2.54.0
> >
