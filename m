Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1B35B65E
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905383; cv=none; b=SndPQbJGJBaPv9ujTUxuQNONhiFaOMhGJBkzunKHKhjYmrCPXIr9+Xn5g1YWgKO6dX+WBMRbfAwNJ7KfKr/IQDt0RmcTzMHrcp3f1CSDCWFLgNg6cleCTc59YwVJLDDhSxoEDv95/SX9VR59cuNqwrFfe+uCUadd3HSjZ4pH8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905383; c=relaxed/simple;
	bh=RXBnDIYPJzkjXQcaxtks1nwurfCHX/8lYNVQ1dOLgOY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHlvBkcVEPEVxs2On/+0BLTMvOCWDBTpj02ph7c9vl3PQsOtcqWDFS6lWuUyb0MqxdRrvOQMZzReYuVA3iPm9Pxur9eA4fhTbTLsmiNXmOGv4J2JKp4S+T/rpK+y0ugXB1I2njJjGtVKpI6emVx0jZ/JN1rkLMzEqhR5+RtwJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A236gkCK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A236gkCK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48069a48629so71255815e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770905381; x=1771510181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39A83dbW8SapOJ4euOAGCwGf4g6DhC01TAjXoMBhAvc=;
        b=A236gkCK1/rb6FqZzPsRejiWWsd/HmXMD/O/qUXkPve0DyRvCS1lQPmiCl0qiWvr4b
         qq7zUmD4b1nI8hrA7yQnCuy5gCgnX9NlAPpE7X3Eh8arb7+9Nuw1nkichgtY2z8N5xki
         jRKM3Li5lISGcogwmunjmdaAI3sfsW6av0NnCbi0saE8FP/b4K0iFarMWZ7QXky9ByEY
         lFSUvt2FFu+cnet6PqGN7V6em9AQWLndD0yS5vip7WEjGdUQXv05X53dWsjTQu/JNkQS
         /8jQb2k1JsDv+52X/zCkks8vH75I//MxKLQWkybjApD72xMVCpFPGpCMx3UVL0DBIf1S
         +CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905381; x=1771510181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39A83dbW8SapOJ4euOAGCwGf4g6DhC01TAjXoMBhAvc=;
        b=cf5hG86/GEEXgoc/cpGRxBJuXbEppMcVbi2wDyKg6mKppOQoRZ8mr0FYPZilI/H5SH
         bDZzAU8tOkXZZUmgbuBw6BE1MLDY/1h+nnq5yibQIHBePH3Cu3mHcggQo/gAQiYnedy8
         is9janxeDgqasCeHZnoFfG9g2aKer7gZJ8uwD25rc39Bl1uK3dUMx13mr1wdYDriH8gi
         qQ+lLqqTEyjR8uxl66zQBdr3dU/FfLaWwvNZRTbgESIR7ZerWNazpj8iN/7Q/fkZK6GG
         9fybSj1ukq7ZNN8y8tNUQQBLIlaGL2Mm0hbYvvxz58+ncHVgfHbWxffHJ+B1iZxZJ/pU
         TxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7P8ELveGRSsI1oPTPeSTJH7MWax0hyuBvTU0758PYwbWd/vAN+g+ZY15dL3G4GtH7ZSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gtI8C1a9UzYdLfPBliN7Y2w9kzf0EYOT6RB1qnmktGM3NP0n
	OaJZUI1Iz0UZ0vPHR7z5V5I5/Ydz10G3L+NWWLulhojHOnPC3BUv2MZW
X-Gm-Gg: AZuq6aIWlUVRHuGMmVxotkXqhVQRzPVtyi91BpfYRiTMf2yxdV3Bi9atVxgEq+MHmPj
	S7LsuN8QhOAgNkCrVfhfsuiRTtngvroWNY7CJZhtjXOXpHbb30WuCEerNsAa0vbxe4Z4UzjmBKe
	gX8WLIUCzvwm4oKD3IHIBCscbiVsQdbMsMEsuAI3aa94n0HKpK4c90cnsx/0UX4PxpVIyaHGegL
	sur7Q+JBWUeec4maDMMNEGQ0jp3MSHx6juXyyniiPJ3GxiDqNG5/Dqxp6RGJDewTv3ZLs1TBaGe
	ZrqLRU0IVeaT6A/pB+RXg1ep79VKd/sBUI85TTtn+yPGZGR89DKGDU5FiE5NbCYh9TGYBL6ssl5
	uzM3Ewz0v4e/YsIY2hqpOzojPep4hCmeG9idth9D8UGKGNZEufOxwtqNqrRXb8Ig37DdHABSE
X-Received: by 2002:a05:600c:8b56:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4836570d1a3mr40145995e9.18.1770905380545;
        Thu, 12 Feb 2026 06:09:40 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm375008145e9.11.2026.02.12.06.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:09:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 15:09:38 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
Message-ID: <aY3fImpJnH6R2mKV@krava>
References: <20260211084858.750950-1-jolsa@kernel.org>
 <20260211084858.750950-6-jolsa@kernel.org>
 <CAEf4BzYP0+u6mMz1NsZW+sT7Ts=VyM4vnFbbo6sxEZKWznGSXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYP0+u6mMz1NsZW+sT7Ts=VyM4vnFbbo6sxEZKWznGSXQ@mail.gmail.com>

On Wed, Feb 11, 2026 at 01:45:15PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 11, 2026 at 12:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding usdt trigger bench for usdt:
> >  trig-usdt_nop - usdt on top of nop1 instruction
> >  trig-usdt_nop_combo - usdt on top of nop1/nop5 combo
> >
> > Adding it to benchs/run_bench_uprobes.sh script.
> >
> > Example run on x86_64 kernel with uprobe syscall:
> >
> >   # ./benchs/run_bench_uprobes.sh
> >   usermode-count :  152.507 ± 0.098M/s
> >   syscall-count  :   14.309 ± 0.093M/s
> >   uprobe-nop     :    3.190 ± 0.012M/s
> >   uprobe-push    :    3.057 ± 0.004M/s
> >   uprobe-ret     :    1.095 ± 0.009M/s
> >   uprobe-nop5    :    7.305 ± 0.034M/s
> >   uretprobe-nop  :    2.175 ± 0.005M/s
> >   uretprobe-push :    2.109 ± 0.003M/s
> >   uretprobe-ret  :    0.945 ± 0.002M/s
> >   uretprobe-nop5 :    3.530 ± 0.006M/s
> >   usdt_nop       :    3.235 ± 0.008M/s   <-- added
> >   usdt_nop_combo :    7.511 ± 0.045M/s   <-- added
> 
> consistency, usdt-nop. And for nop_combo I'd use usdt-nop5, that combo
> doesn't matter for performance beyond the fact that we have nop5 there

ok

SNIP

> > +static void usdt_setup(const char *name)
> > +{
> > +       struct bpf_link *link;
> > +       int err;
> > +
> > +       setup_libbpf();
> > +
> > +       ctx.skel = trigger_bench__open();
> > +       if (!ctx.skel) {
> > +               fprintf(stderr, "failed to open skeleton\n");
> > +               exit(1);
> > +       }
> > +
> > +       bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, true);
> > +
> > +       err = trigger_bench__load(ctx.skel);
> > +       if (err) {
> > +               fprintf(stderr, "failed to load skeleton\n");
> > +               exit(1);
> > +       }
> > +
> > +       link = bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_usdt,
> > +                                       0 /*self*/, "/proc/self/exe",
> > +                                       "optimized_attach", name, NULL);
> > +       if (libbpf_get_error(link)) {
> > +               fprintf(stderr, "failed to attach optimized_attach:%s usdt probe\n", name);
> > +               exit(1);
> > +       }
> > +       ctx.skel->links.bench_trigger_usdt = link;
> > +}
> > +
> > +static void usdt_nop_setup(void)
> > +{
> > +       usdt_setup("usdt_1");
> > +}
> > +
> > +static void usdt_nop_combo_setup(void)
> > +{
> > +       usdt_setup("usdt_2");
> > +}
> >  #endif
> >
> >  const struct bench bench_trig_syscall_count = {
> > @@ -609,4 +667,6 @@ BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
> >  BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
> >  BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
> >  BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
> > +BENCH_TRIG_USERMODE(usdt_nop, usdt_nop, "usdt_nop");
> > +BENCH_TRIG_USERMODE(usdt_nop_combo, usdt_nop_combo, "usdt_nop_combo");
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> > index 03f55405484b..3656676d99d2 100755
> > --- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> > +++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> > @@ -2,7 +2,7 @@
> >
> >  set -eufo pipefail
> >
> > -for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5}
> > +for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5} usdt_nop usdt_nop_combo
> 
> usdt_{nop,nop5}, consistency ;)

ook, will change

thanks,
jirka
