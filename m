Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE5284881
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365967; cv=none; b=m5d2fxGx9eyY+7W1RuYpgkUWOlctT0PGLmU+zSLtAKmO3kJK7Tvi/ev6F0wjtQZEt0DayfhWx+DDWXV1nT7l0gvHCsV3uH7oVzOAbL7PfQ8ZwQyJYgvUm2aNcO2LsG1I6d91qeWS7SvFO8UDhR1Xkz1SdOyeQSt0xA5Y3J0/cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365967; c=relaxed/simple;
	bh=mFCfGUQDd40qD07PrB1RhM8bNYoZDfNHBX018P0GV44=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWEWrGwOv3hutMLmHfanRUY2lB/gz76pUyp9SsGpZYwdL86eJGlRpDonl4k8FieEodS8q+5UiB/Xm2zt/CnLOOwnNN1FBsumAjnW6HYbdkipRrZX1Qe8DHzA1P0RtVebr8Gf5Xb/NAbevdLX5gwjZSDWT9H+iTxjaps26NVqTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuMwLYxJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuMwLYxJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48069a48629so44036575e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365965; x=1771970765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkTDjLRP8tcM0BRwbjDs1Q45R7jy4gONDRnlc0F5mJ0=;
        b=fuMwLYxJP5S6PLrxNXvq9bbQhBDSQxKKu5Oh+3WtU9yNOF9yDZPV742xdn8u7ogNKL
         yvy4bIiT6MqYQkAul09bsTfW003689OhRSXalY4koLtiS5epi0X+qpahzo9dzaHnqhlQ
         MXwZr7DN525q20iDQkgTmRjFPzDK9sLB9FsI2tvfG2FlrpeKC73FWSWXJptHhCYmDLYI
         +DpTJM1spwurV0PS/V4/VTniUMuS/iEMZwIKI/qjhte1n+F8oA+0LnuOQKgkQQmVAeKp
         5sIfZ/+Yn4L3xTDP9r8LH9AgzLF9FW/a+xWIzv5P0TD2vvUZHIaxG69MK1bWq7Q9b6D9
         Kmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365965; x=1771970765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkTDjLRP8tcM0BRwbjDs1Q45R7jy4gONDRnlc0F5mJ0=;
        b=F+sNZz4z3Um5Q731Jw9NsxRh3mwm2B0fWLIE27NrVZy1LVa62XGzqhS6x8nfpJu2Gu
         4hHBMkCU3P4cg72X7WJt63qHD9odWIFQ495HEpHsCpXvyxle+H99wsV8IpEHk7aJJ8CD
         D3b3sL5wzgDec45Vqpg95gGFKhWm2+BcDTyUNUJshPAVQaos22l8arVfAznpnhIwoPXB
         eJXUK/K70WVE+VIJmSxIlWH2MMR90uQ41czsqGGPXWNRShhguASwKcPcYalu1x4ZGnsR
         c1uOVtccoFmM8YGTYM0TgavnzCRfpBfZ3TD0wiZJUFY7tIr6O5tn6ib01n5hoxkted5X
         maTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB5yevpR9US5oMu+5YQW9nuGIf/qNwlVmKlsegAbjkQMW7fd1CkEQ2narjPQoBnfAkumY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxsD5tS4phoKUNMz5AR3XjOYcCl+myOWOBIQNpgFa9A3XNU0c
	kNwMRBa6uc9BVwN+vohXAisqNzjpvWjgUAKj9bKgQddAGIL3VCMPS5xl
X-Gm-Gg: AZuq6aIedizUiRioA2OnAcT6wBXGQaDB9x3mNRqFirWZr5MObf56g6lDr6Oqva5w86G
	lmQOffdP+cPdsGZH5mMtKSbmXJ3WQsYckt/RvbTcSM2kBflh59fMI66KltUmADiKAAEi+ccBLbe
	tc4D8RRrM9JLzfIXASaebFEJUPfnGlvXCwBF7tIK5LN6ESIR3lBGKe0kK+hokgIlMDjq15MqIhg
	r/da2VJSol0HfZiqEAkvyAVun4/FLXNXmj+3PNXv5R13/2PnnQm4NIDpMyiBPlgnXtbI/kJB54/
	ICa+NgOeB6g40zFqikjCExXM3bTc0rm50xA/TUVHBdmmzt9EClzFfKOFkYKumXlQzoA1UNZoQ2p
	iflLQkb4be4cCaWG5egASpqhLmeiJlaSd2q06mh0SQBSRmu+0JFC4UM5VZmQkNB3ZeEh6vPUzW+
	MCOQ0DjKO0ESJkBJdo17R6pjonHTVDyF7l
X-Received: by 2002:a05:600c:458a:b0:483:6f37:1b33 with SMTP id 5b1f17b1804b1-48373a58babmr232652025e9.30.1771365964775;
        Tue, 17 Feb 2026 14:06:04 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483983fd224sm2137585e9.28.2026.02.17.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:57 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 09/12] libbpf: Add support to create tracing multi
 link
Message-ID: <aZTmRc6UwU8Hzb4i@krava>
References: <20260203093819.2105105-10-jolsa@kernel.org>
 <9c8e4f31ee1d79f8ae145ec1c4d388f0829a77f1a75e8ec80e1d4bcf00bde751@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8e4f31ee1d79f8ae145ec1c4d388f0829a77f1a75e8ec80e1d4bcf00bde751@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:14:03AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0c8bf0b5c..a16243300 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +struct bpf_link *
> > +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> > +				  const struct bpf_tracing_multi_opts *opts)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +	__u32 *btf_ids, cnt, *free_ids = NULL;
> > +	int prog_fd, link_fd, err;
> > +	struct bpf_link *link;
> > +
> > +	btf_ids = OPTS_GET(opts, btf_ids, false);
> > +	cnt = OPTS_GET(opts, cnt, false);
> > +
> > +	if (!pattern && !btf_ids && !cnt)
> > +		return libbpf_err_ptr(-EINVAL);
> > +	if (pattern && (btf_ids || cnt))
> > +		return libbpf_err_ptr(-EINVAL);
> > +
> > +	if (pattern) {
> > +		err = bpf_object__load_vmlinux_btf(prog->obj, true);
> > +		if (err)
> > +			return libbpf_err_ptr(err);
> > +
> > +		cnt = btf__find_by_glob_kind(prog->obj->btf_vmlinux, BTF_KIND_FUNC,
> > +					     pattern, NULL, &btf_ids);
> > +		if (cnt <= 0)
> > +			return libbpf_err_ptr(-EINVAL);
> > +		free_ids = btf_ids;
> > +	}
> > +
> > +	lopts.tracing_multi.btf_ids = btf_ids;
> > +	lopts.tracing_multi.btf_ids_cnt = cnt;
> > +
> > +	link = calloc(1, sizeof(*link));
> > +	if (!link)
> > +		return libbpf_err_ptr(-ENOMEM);
> 
> If calloc fails here and pattern was provided, btf__find_by_glob_kind() will
> have allocated btf_ids (tracked by free_ids). Does this leak free_ids? The
> error label below frees it properly, but this return bypasses that path.
> 
> Something like:
> 
>     if (!link) {
>         free(free_ids);
>         return libbpf_err_ptr(-ENOMEM);
>     }
> 
> or using goto error would fix this.

yep, will fix

> 
> > +	link->detach = &bpf_link__detach_fd;
> > +
> > +	prog_fd = bpf_program__fd(prog);
> > +	link_fd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &lopts);
> > +	if (link_fd < 0) {
> > +		err = -errno;
> > +		pr_warn("prog '%s': failed to attach: %s\n", prog->name, errstr(err));
> > +		goto error;
> > +	}
> > +	link->fd = link_fd;
> > +	free(free_ids);
> > +	return link;
> > +error:
> > +	free(link);
> > +	free(free_ids);
> > +	return libbpf_err_ptr(err);
> > +}
> > +
> > +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +	const char *spec;
> > +	char *pattern;
> > +	bool is_fexit;
> > +	int n;
> > +
> > +	/* no auto-attach for SEC("fentry.multi") and SEC("fexit.multi") */
> > +	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
> > +	    strcmp(prog->sec_name, "fexit.multi") == 0)
> > +		return 0;
> > +
> > +	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
> > +	if (is_fexit)
> > +		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
> > +	else
> > +		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
> > +
> > +	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> > +	if (n < 1) {
> > +		pr_warn("tracing multi pattern is invalid: %s\n", pattern);
> 
> When sscanf fails to match (n < 1), pattern is never assigned because %m only
> allocates on successful match. Should this print spec instead of the
> uninitialized pattern? Compare with attach_kprobe_multi() which uses:
> 
>     pr_warn("kprobe multi pattern is invalid: %s\n", spec);

yes

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
> > +	return libbpf_get_error(*link);
> 
> Is pattern being leaked here? sscanf with %m allocates the string, but there
> is no free(pattern) before returning. Compare with attach_kprobe_multi():
> 
>     *link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
>     free(pattern);
>     return libbpf_get_error(*link);

yep, will fix, thnx

jirka
