Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892A3A5E89
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719336; cv=none; b=bQGTFNGfHqlMgnlszGVhbkmV9RnZs1Sp79xBuygFK6ph/TKBctnZQMtRl9Tl4+4rIdd0W+MdTqqwpyIMS0xl7e6SpW7frbrCNBLYrdebyQFPsz+FfREU9CHegD34EihQAZmhH5P4A4R49q6ql4AA+oiPyonytGmwqTOMqHWFU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719336; c=relaxed/simple;
	bh=ettProgvvtb94g0KD3nrnOQrimmNTPkTrd7KKVi1Jqg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaViSBkaXT4pOSvFOoeuuAOUIssZMnwfO/DeFzCsuQD65oENohwMPw43oZXWvdkVtp7loqPKEIiLCvMLZql0olOKuDs/PleaiHe75kdMc/F7GaD1JQqeakEQfSLV12PB27QESncdFhyBJ7o4QlbDzyhlg/lfD9S0V75dqtvhTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyifn2+h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyifn2+h"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48069a48629so84872995e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719332; x=1773324132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wusvTo0xaA7ryqymJA64/SEOx0W1yyCVK0CAbnCinrA=;
        b=Wyifn2+hTEtRtK4VNNutKwtOMZDKrzc0sC0qXAdFzqyaYvSuoIGRYrL9XX9vVo8R2J
         k7ar85/kzLw3RKsh6n2H9NqPUfbB3IVZ34rNdtrIDE3IlaisUCtjd2o3ppLz7pfGyIHc
         o5RdySbjJ+6pv2gQ+z0SsqWHVx2gW2wuXCFNjaJCFgxJWRRMwrKVBB8RSQ2OdMkZ2OOM
         wR8l51rAjLu+Dw1et9GmQaDl6orNI3EirFZdraoVsVJC4KYt7Ah7aoPopgYxhZpoV2IU
         ZDEgiDFi2AOA8LJakImnEYZw4ASKmNOfhMbM+JV6sUmH8c1etJ+OrN9C0cmovMXNw/Pi
         IG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719332; x=1773324132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wusvTo0xaA7ryqymJA64/SEOx0W1yyCVK0CAbnCinrA=;
        b=Hc0pGgrkBtWEpNq34l/xqPT0eBWCFHCaETtRgGMlW1N0LjISyIp9w3L5fYw0ErD2ts
         iYA7PrZf1nJN2NZUmT7fJIhA16XSYu18Y7AGh3OMCCTDDfVhukAkjJSrEftbX2bIn1hI
         ooN8D0ewPJ1jOjeQYAeGuWvyXQBtoIEk8MyYsOfRiwtpmT+OVndy88MZwhd8QBIljgZ2
         8yTNKfEAosv2Z9JuRfcqvP7xGgxBs0sqxFPfE65xbSlsQ1Y22Mm4nfH66nDeJuAMV5qv
         +xHUTpg9d50Tvi6K6w5L+KZTY4qmMAT7RM5uO+2gB8CNEZ5XtY5jhcrQivBPxrQcEDaB
         0HQw==
X-Forwarded-Encrypted: i=1; AJvYcCXCs/N/4XOVBJJq2iGfZ6ZoCiCtpYZVXz39ukeX3mQ3/xVKM4nRJ1i9sULKkiRvvmqKxAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrryd9JCJ/lVdVlym4sLy7+jhXWkyLxFFVmJ3spReH962kwiHK
	y8i6brua0nZG/FmjgjN3TD1Iry2yp+Avl3/LOJ/vIGB/RpiI2lk2xY7wZ/MvbU8h
X-Gm-Gg: ATEYQzz5HBYHGrOLrwVjr1VNqxECetEQSt5y8V804xBu/02MUnoFgyytnSLBmO42Sk/
	t3Ot0OZxgmQZ9aSZ0F8fWmF5bA5KfLAM14MMYw3Jj5l4qfwpH3hvOkt1pD24Yn84GRDNAhbXzhS
	NXLGrNkyl29ZdNqIlw2OF2qfMLUEar7JFKaV6x1+8yUk6/okd7u7f19ilLZCOVh0gNwFCFjxKOk
	2z0Mkg98YXFxDC30mPiifgPhWAToYct3JckV2w3rYZV9ZItDkXfoqongFkRTiXV5TOlDdsjBUKA
	hvf/AUY6z6QTZKo5r6gHXDHnc7FpdFzxA21PYEaMX+0FUYp1COYBfInN/wZldvVkJjjDtacE71i
	uWBbEcWOcDHcftH9Y/GkVuXII5yH15PT2IZBGDEYANKRYZDTZt0sqwg7Tes73KXHHwin1qAMg
X-Received: by 2002:a05:600c:3b99:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4851983121emr98695355e9.6.1772719332344;
        Thu, 05 Mar 2026 06:02:12 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm88235765e9.9.2026.03.05.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:09 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 09/23] bpf: Add support for tracing multi link
Message-ID: <aamM4VPi3UL5sfeI@krava>
References: <20260304222141.497203-10-jolsa@kernel.org>
 <e0a34750677c3cfbc461c9653f39b1d8388c1e3ca8a95e918e380e61999adf51@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a34750677c3cfbc461c9653f39b1d8388c1e3ca8a95e918e380e61999adf51@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:30PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> > +	struct bpf_tracing_multi_link *link = NULL;
> > +	struct bpf_link_primer link_primer;
> > +	u32 cnt, *ids = NULL;
> > +	u32 __user *uids;
> > +	int err;
> > +
> > +	uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
> > +	cnt = attr->link_create.tracing_multi.cnt;
> > +
> > +	if (!cnt || !uids)
> > +		return -EINVAL;
> 
> Should attr->link_create.flags be validated here as well?
> 
> Both bpf_kprobe_multi_link_attach() and bpf_uprobe_multi_link_attach()
> reject non-zero flags:
> 
> kernel/trace/bpf_trace.c:bpf_kprobe_multi_link_attach() {
>     ...
>     if (attr->link_create.flags)
>         return -EINVAL;
>     ...
> }

argh right, that's missing, will fix, thnx

> 
> Without this check, userspace passing flags != 0 will be silently
> accepted, which would prevent using the flags field for future
> extensions since old kernels could not be distinguished from new
> ones.
> 
> > +	if (cnt > MAX_TRACING_MULTI_CNT)
> > +		return -E2BIG;
> 
> [ ... ]
> 
> > +#else
> > +
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
> 
> Minor: there is a stray ')' after CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> in this comment.

yep, will remove, thnx

jirka
