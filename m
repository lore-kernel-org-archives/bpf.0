Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893717B418
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719282; cv=none; b=n2aat8fgiBD+9dB9izq+yFww8ksTGEAHDINJPEjYcK23JqCSs3d3dKLbpTgabMNfsRV1di9C7nECreUCOQAJBpX/5vqQJfFOTD8bjGvYXedwwpBiOnwj+qbIEo2NRUjLiU7lWhJ3dFmI06/bBD4XMJ2DaWqqpoGmqn13dLkg3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719282; c=relaxed/simple;
	bh=r0AUboPD7siAciA8qX0Q5aEf8EMQYzUhHAaXERGo4cw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP591xLQDKJk3iRmbDfbRv8KbK/CoPCwCPHkOv1DRvRxh5PvIzGvZdIi9gLizjytFt++VDpCCmBtnTScaxhby+RUBLl4AOX/80swwfF9fkSwzPcmzToY+C9/pid/0Q+5FAIapC7a18oG+cztxOsy5n2tk6pRWmzQ9RHbS8+oIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8Q4TVlM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Q4TVlM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso4352815f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719280; x=1773324080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLvBiBWzeZrCuHWYQT1BfKFZEwcwKUCQ7j4Ug6sOub0=;
        b=Y8Q4TVlMvZCGTImKP8HZO1iOLxrwdsPg2iGssjV8Ih6l93bsfui/5ijg6F5kFLWpNK
         Iyd5oyybclnY2l1WxLf5tPGkDXQ/qsyIDcpbqP6iBOta3N+QlRiU5GlzqgeYwY0YVfyp
         HwwdiGE5ignaCekHv+hwsDbTV0U0bQzg4tvPAGJ0RYDtrbi7QZEWd8WYP2j3b8cYhmrx
         cFYRuVsjPD/YDW6eoS2RXrOHH4OebMz3FPb4gg3/mcm1b5ZnopHEKf64cgEA620gDUkG
         jXhgGhvaM0ml0DbFEIlL3O1jKX2/JTVOyWbea+qZxXnn7Vprw5n0vGs1ZC7lrxcugDYu
         L97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719280; x=1773324080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLvBiBWzeZrCuHWYQT1BfKFZEwcwKUCQ7j4Ug6sOub0=;
        b=AgnJk/tra70E3L4Wwc4hSh71jAfn8BAQSI+RxsKnDHMrM4nZ8wdZxz31pl2g6fchyE
         9bFBTzz8WqvqyFVfx7yCFKnrAd4g0/HW9xbd5SOadpJ4ogsNnjehvvkPnrjXe+cibJKJ
         lWJV3kC1wzMjWtPBO7VCV5crdOrYv74qTl2sJ7Tmm6FdK4HgKWMfUHrk02rb+tDDIWUV
         zskmiTkujNz3ECdDeginZKVI8GRfIM7rTLdPI9aUMHS8SEYBjVDlv7hCgmY9qInVwAVN
         8Kx0lw1CMovxLu/0hvz7f7LYYg1pHrYnefeli8k4XGaPV+5MW0zlGMqG9VJP/Z5T4wq9
         F5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXwRogs3KjS1UMbBAu/GHg+b/kZ5qsQjWUlqj1lYg66KBOJoxHifww4h0//FtlcB5yCxLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjJyC8tE1okNPALcnDOja33wWH0Kxk7YaWuP0jc5ZtDvzWxqb
	zBBfdbt3Ihct+D58qiEgozzEtCD25XaqlB2RwtW2a/mUP36sr6wvygyF
X-Gm-Gg: ATEYQzziMkMYx3rHENpp/CeDgU4iB2uw0f+PRcT3BLRnPydt7oYJPpaEBJ6KEZf2aYc
	/OroD3STbR/TAeDGPLWLmOsq7ovNO4jz80ivA4wVNlJDVZog0RxMTbU0lTuSARwnXT71wIIim9G
	lKjyp04hqDNQVIL2ZrVIR2r1LnC9BILndgOhY5qKNCwoTSR7sg01TuwXhvCyz/QW/TwFw4+WQJ1
	mOD9XCeH/F74PyL0lbYcdhZDBXfMmmx60p4dbjyaVe/avNO0kUPstJ2esAucgPyWWc/ayKU80yg
	SX92TpvI6qikLvMR0GbnclTxsg6VuYvPX5fplT7McQFSn9J1D2TfBvtZ1rdmNDXzI9kM1CCS9Z5
	Muey3mqRo9nnknv6I8lcNsoEWW5J/0jGRXXUDD0Emxm/fSLmtCychPSM752rl10JCUzBFq61w
X-Received: by 2002:a05:6000:1847:b0:439:b636:1fa7 with SMTP id ffacd0b85a97d-439c7ffd017mr11726354f8f.54.1772719279156;
        Thu, 05 Mar 2026 06:01:19 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm37691451f8f.16.2026.03.05.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:01:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:16 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 22/23] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <aamMrKQOuNdlptyL@krava>
References: <20260304222141.497203-1-jolsa@kernel.org>
 <20260304222141.497203-23-jolsa@kernel.org>
 <30ebc83a-8f17-44fc-89a6-037e826f6c70@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ebc83a-8f17-44fc-89a6-037e826f6c70@linux.dev>

On Thu, Mar 05, 2026 at 03:30:01PM +0800, Leon Hwang wrote:

SNIP

> > +/*
> > + * Skip several kernel symbols that might not be safe or could cause delays.
> > + */
> > +static bool skip_symbol(char *name)
> > +{
> > +	if (!strcmp(name, "arch_cpu_idle"))
> > +		return true;
> > +	if (!strcmp(name, "default_idle"))
> > +		return true;
> > +	if (!strncmp(name, "rcu_", 4))
> > +		return true;
> > +	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
> > +		return true;
> > +	if (strstr(name, "rcu"))
> > +		return true;
> > +	if (strstr(name, "trace"))
> > +		return true;
> > +	if (strstr(name, "irq"))
> > +		return true;
> > +	if (strstr(name, "bpf_lsm_"))
> > +		return true;
> > +	if (!strcmp(name, "migrate_enable"))
> > +		return true;
> > +	if (!strcmp(name, "migrate_disable"))
> > +		return true;
> > +	if (!strcmp(name, "preempt_count_sub"))
> > +		return true;
> > +	if (!strcmp(name, "preempt_count_add"))
> > +		return true;
> > +	return false;
> > +}
> 
> These names intersect with the list in trace_helpers.c::skip_entry().
> 
> It would be better to move this list to trace_helpers.c.

ah right, will check

> 
> > +
> > +#define MAX_BPF_FUNC_ARGS 12
> > +
> > +static bool btf_type_is_modifier(const struct btf_type *t)
> > +{
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +	case BTF_KIND_TYPE_TAG:
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
> > +{
> > +	const struct btf_type *proto;
> > +	const struct btf_param *args;
> > +	__u32 i, nargs;
> > +	__s64 ret;
> > +
> > +	proto = btf_type_by_id(btf, t->type);
> > +	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
> > +		return false;
> > +
> > +	args = (const struct btf_param *)(proto + 1);
> > +	nargs = btf_vlen(proto);
> > +	if (nargs > MAX_BPF_FUNC_ARGS)
> > +		return false;
> > +
> > +	t = btf__type_by_id(btf, proto->type);
> > +	while (t && btf_type_is_modifier(t))
> > +		t = btf__type_by_id(btf, t->type);
> > +
> > +	if (btf_is_struct(t) || btf_is_union(t))
> > +		return false;
> > +
> > +	for (i = 0; i < nargs; i++) {
> > +		/* No support for variable args */
> > +		if (i == nargs - 1 && args[i].type == 0)
> > +			return false;
> > +
> > +		/* No support of struct argument size greater than 16 bytes */
> > +		ret = btf__resolve_size(btf, args[i].type);
> > +		if (ret < 0 || ret > 16)
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> NIT: can we avoid copy/pasting the code snippet from libbpf.c?

maybe we could make it global and use it through libbpf_internal.h,
will check

thanks,
jirka
