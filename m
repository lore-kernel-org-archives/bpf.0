Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A6314A6F
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365952; cv=none; b=J4Ny0BY4+jyxqoFD193sIvI2lMtGoEsbhPQmVfjwAac8aZ52I2BFswLmfJAofCNbmSnbKtv/NCYDsN7fV55n5FbIdU3iiLsK08g3Y8R7jb0NvSSf4Nlg8AwnxR/qKDLECNENsiIZ1ZvAinuV/SyIpERo8ulFZxkla+I2eG18Tn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365952; c=relaxed/simple;
	bh=VE7FO05ZjRXzZwbS3JdIlUtzVpIctrUeY7xnv1SWqY4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkFOKwc2h7kTzhcgwH621O80Oocziuaz9dIvTJga6krE/AHQVPE6ve73vrGL3XYGtllFzgyZZCq8G0JsBE5JHYiSdQiNCneecb7k+qVKadHqa6uzpNK2JiW3TMEQ4PXbtnfkB2rOoXjycthntJungca+jBb0R/TBQwwdllscrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOVUOqkQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOVUOqkQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48068127f00so49843235e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365947; x=1771970747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ETPiIInMfyZpj40Gyl1+1if1tvqeAr6aqhBy8zpuKY=;
        b=YOVUOqkQoG5b1xVeyfvh2Z4WGi0MICd4hp1tS3VQYdn9uPj5SphvDL2XjxNWEr0ChA
         ld25urCRrAlM1PxD3vgOdQSqpv5yQ+p+4Y5f/rwCEeEUyC+BcrTYi8T2fRBIhr7oydpH
         YWQSjSwjNo8gWEGjylBbZ/+m5+vgtphdRDniH14uhMlwDdWNcv6JQbmZ/0Os6bb8PneX
         aZZ9fYYz1gYN4eFqB02NbcdCnGpfbHxOMI68hTW4hl2rICz2tcU9t5FSdqniSvDyjqtS
         ZrF6wVRz+Q9ersn0cZ7mYTtENmeQ/9T8/+rh9ohzqO8iapiNQg7Xcwd4VRe1d9PcPG9b
         BpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365947; x=1771970747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ETPiIInMfyZpj40Gyl1+1if1tvqeAr6aqhBy8zpuKY=;
        b=BOphBmcZQczXTBwjporr2unqDIEBLveEgtckykS8aw0bICtrbBA4lvKgVnCWbZWI/v
         IaVfwhE+Rsn01kFsSOtmAxl1SPR0cBZCoHxkkn7m3wSThb6EE5w1P2jSSod3BxcoxZKh
         +epdLownvUHcVFRQ04zSXHp9rnJw/cNvoOl40WVmGE75HGPf209PnUPoT/hvM40f8MDh
         YxUplA7N5QVWLdbL5NNObDtnw1UH43rf534OKTbN9LslG5dhZpf2IJLaVhxtetxWM0Xr
         BihLrHHz1bLAp7bJiFa8uehBMekp4CqckxeP1ckJLQ9MwN9JksEYwYXmTrEgnbD8dQXE
         RV3g==
X-Forwarded-Encrypted: i=1; AJvYcCWInKafz3KmBreYUB7vyyj7gVB540+IFtNoy5OOWmwUBaKI/Mb2iGlzEieT4q2oeovjfxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwBeBQXjOxOdLg2NbPG0cfC0Sgb2YOpQwjV0ZK/WV9BIKa9QM
	Bpp26IxN63SBskVoZiZIUzrvQw+Ar+t9OKb5Qhm3ZvbpEpzsxhtZOLJb
X-Gm-Gg: AZuq6aJ1DQuHypDnuGLbpWHAwxhi7SMnVDqXyvdlJcrYv0HiT4E+udN0oF9+DGu/GR9
	K+e9bJzORpTbih6AFKi6nso2K64Yu9y00M9H+gFbIRC8Ehwhf+X1DeiKg9gHJb3u7DidSlvM/8c
	yxIg9P5NUisXyj/eIcpcU/GbcfZi5ULO1O99hHYWrA4VAR9fJ4i9xbkQtg02v2h1HCUrHTDx2xb
	30bGM8rancBWjSWJNU0JzV/BZaOEn7ACaTbXaJ2imO8gxOc4sklmU+tKuUlX1pNkulC11iflmaG
	yFyJDk6mxognkvDtzEGPyXrwKpSZQLiFuitmz9pv3gxU1t48b0s+QMsBRXds0gMdCIluINNooX9
	hfjiJ8oirE/jRSVN6NVtCDA/Ma9jvBhlE895rxPLIjGS9IYJxOuIQqIMZp6R2ltrezD2EVyckkb
	4vtbAhuWB7Rgj8fJ68rCpp3i8BD2Nv+QWr
X-Received: by 2002:a05:600c:4f50:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-48373a662a4mr239777785e9.27.1771365947496;
        Tue, 17 Feb 2026 14:05:47 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48387ab1974sm168192265e9.3.2026.02.17.14.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:05:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:39 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi
 link
Message-ID: <aZTmM5ScQ0vKSkLI@krava>
References: <20260203093819.2105105-8-jolsa@kernel.org>
 <1aa999b2eb50ae6a0a80a5ef21c5f8c22bcb2605e971652c6f202a292b996032@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa999b2eb50ae6a0a80a5ef21c5f8c22bcb2605e971652c6f202a292b996032@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 68600972a..010785246 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> 
> [ ... ]
> 
> > @@ -1863,6 +1864,10 @@ union bpf_attr {
> > 				};
> > 				__u64		expected_revision;
> > 			} cgroup;
> > +			struct {
> > +				__aligned_u64	btf_ids;	/* addresses to attach */
> > +				__u32		btf_ids_cnt;	/* addresses count */
> > +			} tracing_multi;
> 
> The comments say "addresses to attach" and "addresses count", but the field is
> named btf_ids and contains BTF type IDs, not addresses. Should these comments
> say "BTF IDs to attach" and "BTF IDs count" instead?

yep, wrong comments, will fix

> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index f7baeb827..82e625aa0 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
> > +					       struct seq_file *seq)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
> > +}
> > +
> > +static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
> > +						 struct bpf_link_info *info)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	info->tracing.attach_type = tr_link->attach_type;
> > +	return 0;
> > +}
> 
> Both functions above use tr_link->attach_type, but looking at
> bpf_tracing_multi_attach() below, this field is never initialized:
> 
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> 
> [ ... ]
> 
> > +	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
> > +	if (!link) {
> > +		err = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	link->nodes_cnt = cnt;
> > +
> > +	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
> > +		      &bpf_tracing_multi_link_lops, prog, prog->expected_attach_type);
> 
> bpf_link_init() sets link->link.attach_type (inside the embedded struct bpf_link),
> but struct bpf_tracing_multi_link has a separate attach_type field that remains
> zero-initialized from kzalloc.
> 
> The show_fdinfo and fill_link_info callbacks read tr_link->attach_type which
> will always be 0 (BPF_CGROUP_INET_INGRESS) instead of the actual attach type
> (BPF_TRACE_FENTRY_MULTI or BPF_TRACE_FEXIT_MULTI).
> 
> Looking at the existing bpf_tracing_link_show_fdinfo() and
> bpf_tracing_link_fill_link_info() in kernel/bpf/syscall.c, they use
> link->attach_type (the inner struct's field). Should tr_link->attach_type
> either be removed and link->attach_type used instead, or should it be
> explicitly initialized to prog->expected_attach_type?

right, I'll add linkinfo/fdinfo in separate change, thnx

jirka
