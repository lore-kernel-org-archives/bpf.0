Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6A38F65A
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312387; cv=none; b=G4NCersWZTU4lh0ZNsgIU8iO50a/J7vpNqF0WHwO6CnopNGcY8Ed3AoS01tEIuZg7PYaQDIexiyfry2cq2FX3SBnkByLkAJ3Yyuc5sjRXjjtITcAVR7DKaHd6yh3phQM/PB6dCOgRV47A6VUTGTuFZ8gE+9uljrZLSdxEd75HK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312387; c=relaxed/simple;
	bh=QqK4fKBnKsrw0aRpPX6/Mgiw31EdmjhT0xJqXC7trww=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIdYzY4BMM6c2F32Suk++WTEm+Fwhd83AikxER9sqgldoRc/BZi8duh6qIS/CRNncMlxJ3XnSGmfK2taBnSwcLa7SdIBhi2GLCz1TUK94ENah8Wf424Yu0ebB+n83emEUqGuBc8kbt01dI2o2rywiKLfHPngBsDqYBcUB24Jn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmJz0r2J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmJz0r2J"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439ac15f35fso807607f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312385; x=1773917185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vGgz7KnTK9vuGJli7OEIVFiI/JsHt8PWV7ea4j0pww=;
        b=WmJz0r2JsEpo5cD2TGk5qGe9YT1BLr2qPgz6Dc3Ln+VU1zQh0pxz6dSCE9rogSQZw2
         wmgZRkVKXH5tMpnkUw2ytOGRMNAHvoiV1pq2xYJa8q85X4NhTefMtvdErZOVx33eSBvp
         N3CS3pLbnuj6VLr8O1tSSXqnVqjkqeEFuiBjJUyby+kAJbW8+kS/iYrFcrXo7Z0oxfER
         620ATw+DjFOxJHsX8PsLsszseVTV8wZs1+xE6PoHy0F2a497O+dGYrkp8jXzHPOIp4TW
         sJkPV8Fwrg9TB67662/SzV3K8HBfZ4RJJhwM0nGB6UoiKh3poCG+tj3aCOW+/Bc4GAgB
         W56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312385; x=1773917185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vGgz7KnTK9vuGJli7OEIVFiI/JsHt8PWV7ea4j0pww=;
        b=qRCMxEdBcJ4c0a9q48Fm6lZhtA25inTbj2fhE7m2lI+RZQ9sQVj8vF93vweuWRGueg
         2ray7Us4gSx9YUtuGFWoQK8aO4sYcvqGDXDQWXQRRNUY38Bn+wmYZUkhlKvaE2leqavh
         nP8w8WgPmijudEwFFm6svLY91BxZfAqoGrWXc6yCcC+W2Qk6mEx4OeyMzw3O4Sq9bzqG
         m3HhtjzK1o7WCJLAbXefsAlx0G/5MD6JkrJmLzUbZ8YO7hy/87YMODNUcC+6fkVlBcxo
         sYPaueh6xCRBgM9eUQZnFg0+RnFZ3Pn/bECKb74FlzmaoLX9xqv1naUTXtqJfvjZ0voI
         SPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX++0sTb43FwjP1ekEYPF+uEJdHRGEfNNDo53xeS7lHbIGwy/x49+fPeqZkkPxu+FbzX4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwiGQqWxV/FmSzjF0vi1gg7ohX3SUf3GzGirSV7Ca01N1m1Mu
	KG1C7hVyB8BJ1iQrlGrnTQidyiES+ZMsv7RLLQuQ7wqTrWduZr/o/Jf3
X-Gm-Gg: ATEYQzxnuMd85qlKcX20mPkhz54e416ta1X3kS0jJ6NLPDK6weCY8YkXW0fTTHhnxrQ
	yM/9u/gMYz8n5wwK6WTvOM6j89z0xXDPuLLl8z1RrT5iZfFNanJb0mmhZpZVT9gYydIkBpOFNGw
	YLMILCyw1zezDRFOMSn2VQr5jh8TIY6P9yv56CQ30W70rW1trB3l347kkdsv4bGyQRKgT3FW/td
	gS0rN9BwX4t4Ef4RHaO9syzQSj4NvQkCWFQFedw0y+Zz1k3v5j/KDyyZFcNsMEkdB1QvIs61q2B
	HzNXEnPQHb+vTlAM2cD8tETT3BBp+astgWFwg65W/XF7qCIWe2UJgzzX+8UPx87yvCC4ImUtTrR
	H0rahg27YXwII1QxR9MRG3vPC1N6vxbBFYMuNByMCVW34NAMrEhlTSNz4qDhuPeCnonDVMmbRhS
	+V+eEcOSE=
X-Received: by 2002:a5d:5d0b:0:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-439f8431382mr10986545f8f.37.1773312384396;
        Thu, 12 Mar 2026 03:46:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm6568266f8f.10.2026.03.12.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:46:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Mar 2026 11:46:22 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Message-ID: <abKZfhWs9Gojuvip@krava>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev>
 <abHwii5stH93Vz5E@krava>
 <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>

On Thu, Mar 12, 2026 at 10:24:24AM +0800, Leon Hwang wrote:
> On 12/3/26 06:45, Jiri Olsa wrote:
> > On Tue, Mar 03, 2026 at 11:06:36PM +0800, Leon Hwang wrote:
> >> Uprobe programs that modify regs require different runtime assumptions
> >> than those that do not. Mixing !kprobe_write_ctx progs with
> >> kprobe_write_ctx progs via tail calls could break these assumptions.
> >>
> >> To address this, reject the combination of !kprobe_write_ctx progs with
> >> kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
> >> tail callee from modifying regs unexpectedly.
> > 
> > hi,
> > could you please give some example where this is actual problem?
> > I'd expect it's up to user (whoever installs the tailcall map) to
> > avoid such situations.
> > 
> The self test in patch #6 can verify the problem, that
> kprobe_write_ctx=true progs can be abused to modify struct pt_regs via
> tail calls when tracing kernel functions using kprobe_write_ctx=false prog.
> 
> Explain the problem by reusing the test code:
> 
> int dummy_run;
> u64 data;
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } prog_array_dummy SEC(".maps");
> 
> SEC("?kprobe")
> int dummy_kprobe(void *ctx)
> {
> 	dummy_run++;
> 	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
> 	return 0;
> }
> 
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
> 	data = regs->di = 0;
> 	return 0;
> }
> 
> The "kprobe" prog will be added to "prog_array_dummy" map.
> 
> In user space, the "dummy_kprobe" prog will attach to kernel function
> "bpf_entry_test1".
> 
> Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
> will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
> instead of 0.
> 
> bpf_prog_test_run_tracing()
> |-->bpf_fentry_test1()
>     |-->dummy_kprobe()
>         |-->kprobe() /* via tail call */
>             |-->regs->di = 0;
>     return 1; /* instead of 2 */
> return -EFAULT;
> 
> Yep, the commit log is not clear to describe this abuse problem. Will
> update it.

ah right :-\ ok, I think we need to do the suggested one way check and
that should prevent kprobes having writeable ctx

thanks,
jirka
