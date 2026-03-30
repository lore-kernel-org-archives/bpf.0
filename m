Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5D325705
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882355; cv=none; b=E5H2cT6iF/TESEq5XuKQSvu79HzLaMVm7hFeOV1sd0jEOcedideGDCU2CObCwZJ//nwdZukzH7bDu7ydMd2DSOMz3L7p6Uq5MuoLDzaF5DyWTdqUOO0m5fufioOPquSKGikroxw47AwDT5s0ECQP5gR1+mfOk+nqQdgJ0CEsOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882355; c=relaxed/simple;
	bh=Dr49MJN7Xs6KFA9MCEfc/ZihEyIU2Q6UOjgd46I42Fo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRKVoLEmNRUf5oJVEcq/PryWbsTZVlS39MsUsIT7I2I7EDu0vLortnJfGovYc6bMnK/6wKKAz6skdadk5JXU6KH8xrw8fGavmLUu2D8igFr8a4zkOfPzuzA/wYuKyu71W/8vhvCuR3QMCOzNhXhNYD0nYW0rwZdVI5oM0DZGpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOKvv2rc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOKvv2rc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso1654916f8f.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882351; x=1775487151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eASIWITpIttTu7/75f4mcjIFMWWKY22XxTe2Uo0MgI=;
        b=pOKvv2rc1BrF03h411f4YQQDXlMki2qu+cmk60aLWx5vizfDvTF/Wfpt672laLEmM4
         VFLHk3oeGbVZw47hJxfPF+oC2X7MXT2f6ga5wZRdD/UJ5KrXkMB/5vjOwvdz6g0ESAmn
         HCpfAKEo/O4c0bjbNXRxLhtpgjSX5Op0O9+n7A+bgn5svT4akPrER6Oka4/KEHcOdjPe
         tDg98OWOXp1TDgR8O79guHkzg3TnKhm/xAJz0pC0ebBaJw0BTC8ZxS2l4NhVDj4VUJlz
         OMLy10zCO6gpimNXUiK2UGt0Dokn5EZBzJ7ecjZZis69n7kiYLQJbLiNon16YNdzPTYh
         Xe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882351; x=1775487151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eASIWITpIttTu7/75f4mcjIFMWWKY22XxTe2Uo0MgI=;
        b=Zj3KL8kk6NU+qgu9M9QSr2CBsc9v2/GDVWxnyJf+44/kNtoYD2VuV7a5tL1oLRPgqv
         +DS7k5BcBH9EA/OE7lJe4PXnLBMnEJtHcGGLsaiH/oooQ/X9tIQxAavjL0V0r+fEjcUV
         +pHhBqVBzcHxVABSg2rW+BabQnDsGhTM8lhgyKU7aMZehptuFu3QCxC6qq07oS/hKQFJ
         s+z+MvLcWFE5jFF971tY7lfAemv7cCljhCp9KOTrThGuH0CqhyMm2XwuyAYEBRFef4Vc
         0lFvhfkahZpVgmGobJo6C0GQz5K88Rj+4ObrPoeYzY+CI5hqCv7fjjNgWEjUzH6EhUbv
         e4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8gbAQxzwCuOVpZkoUyNxx0So82icFiQh5Kjia0v720x18y4JXNsRkHy2sCdcUNGXXm58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfig6w5LPY1pPeYqqJfYNpnSf7BDQEnfK2ArezB4HL1GJh/E6f
	aa3Q8WKlnVItJsRtJtU1V9amnOcYAHr4Z/IeDentxAN4s92BTFMunMwj
X-Gm-Gg: ATEYQzzIqmyvfhhnvfm9VaDCk5zktwLiawP0WznRYQv0glQa4xNFIEkAnwzfnSPNJ/3
	WlAA1kSjdaDEp1epcbpCnDUi9NmejrLhOx14SVm2bgEv4FdN9LAf7yYZ7LV7buNKynhmenYpMCp
	5o1+DR1jXFyJbB74hqB8QGfj/zZUWWr066d4C5a6V3s8cY+fN83XjfIO/4u3wENzq7QVvp0GhB7
	N6+rvD8NPR1+XdMJELk1NG1U0xgOwm1UMu7FHTdzTjsnVD3dWAt3LhES7TUdO7mtMXUPdA+aviY
	0P8tFz223efcE855/9Nn280tDovu7ME4asA50C7ClIaFzKX1AkMCjyg6jPlmWF/4nZ57A31uljZ
	0/ZefQGFcqTKfTia8HxcqE77pPZg2LgKBrdvegPm2UZ9RHvWTPWBrDq1jo8PwveDaVMensDuKsS
	ZYPKr4GaOLgqFyzr5TfJiHSW/DP+JlGhsQ3RxUUo8p7HpRx7LcQ12y+7G6ylFCeJdB2FAt
X-Received: by 2002:a05:6000:18a3:b0:43c:fe66:43fb with SMTP id ffacd0b85a97d-43cfe66466emr7307517f8f.17.1774882350832;
        Mon, 30 Mar 2026 07:52:30 -0700 (PDT)
Received: from krava (cust-west-par-46-193-1-135.cust.wifirst.net. [46.193.1.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm20300486f8f.1.2026.03.30.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:52:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 16:52:27 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev,
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
	martin.lau@linux.dev, menglong8.dong@gmail.com, puranjay@kernel.org,
	bjorn@kernel.org, leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/3] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Message-ID: <acqOKws88JsU3riu@krava>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-2-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330110019.549079-2-varunrmallya@gmail.com>

On Mon, Mar 30, 2026 at 04:30:17PM +0530, Varun R Mallya wrote:
> This patch modifies libbpf to automatically "upgrade" standard
> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
> supports it, making them compatible with BPF tokens.
> 
> To maintain backward compatibility and handle rare cases where singular
> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
> section types are introduced. These force libbpf to use the legacy
> perf_event_open() attachment path.
> 
> tools/testing/selftests/bpf/progs/test_fill_link_info.c has been
> modified to use SEC("uprobe.single") as it asserts the program type to be
> `BPF_LINK_TYPE_PERF_EVENT` and checks properties related to uprobes that
> use perf.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c                        | 53 +++++++++++++++++--
>  .../selftests/bpf/progs/test_fill_link_info.c |  2 +-
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1eaa7527d4da..bd7b6f486430 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8248,6 +8248,23 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
>  
>  	for (i = 0; i < obj->nr_programs; i++) {
>  		prog = &obj->programs[i];
> +
> +		if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
> +			const char *sec_name = prog->sec_name;
> +			/* Here, we filter out for u[ret]probe or "u[ret]probe/"
> +			 * but we leave out anything with an '@'
> +			 * in it as uprobe_multi does not support versioned
> +			 * symbols yet, so we don't upgrade.
> +			 */

nice, I missed that uprobe.multi does not support versioned symbols,
I guess we should fix that

> +			if (((strncmp(sec_name, "uprobe", 6) == 0 &&

str_has_pfx ?

> +			      (sec_name[6] == '/' || sec_name[6] == '\0')) ||
> +			     (strncmp(sec_name, "uretprobe", 9) == 0 &&
> +			      (sec_name[9] == '/' || sec_name[9] == '\0'))) &&
> +			    !strchr(sec_name, '@')) {
> +				prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +			}
> +		}
> +
>  		err = bpf_object__sanitize_prog(obj, prog);
>  		if (err)
>  			return err;
> @@ -9909,9 +9926,11 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
>  	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
> +	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),

should we add sleepable counterparts?

>  	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
>  	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> +	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),

just an idea for discussion.. I wonder if it'd be better to add new uprobe
section that will upgrade itself to uprobe.multi if it's present, instead
of changing the existing (expected) type

but I guess we want existing uprobe programs to benefit from that and
there's not really a reason anyone would want perf based uprobe when
uprobe_multi is supported

ok I talked myself out of it ;-)

>  	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>  	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>  	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
> @@ -12737,6 +12756,32 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  		func_offset += sym_off;
>  	}
>  
> +	/* This provides backwards compatibility to programs using uprobe, but
> +	 * have been auto-upgraded to multi uprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
> +		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
> +		unsigned long offsets[1] = {func_offset};
> +		__u64 bpf_cookie;
> +
> +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> +		if (offsets[0] || func_name) {
> +			multi_opts.offsets = offsets;

could we do the same as for ref_ctr_off case and drop the offsets array?

     multi_opts.offsets = &func_offset;

> +			multi_opts.cnt = 1;
> +		}
> +		if (ref_ctr_off) {
> +			multi_opts.ref_ctr_offsets = &ref_ctr_off;
> +			multi_opts.cnt = 1;
> +		}
> +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +		if (bpf_cookie) {
> +			multi_opts.cookies = &bpf_cookie;
> +			multi_opts.cnt = 1;

I think it's better just to set multi_opts.cnt = 1 once outside those if conditions

> +		}
> +
> +		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
> +							NULL, &multi_opts);
> +	}
>  	legacy = determine_uprobe_perf_type() < 0;
>  	switch (attach_mode) {
>  	case PROBE_ATTACH_MODE_LEGACY:
> @@ -12830,6 +12875,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>  	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
>  	int n, c, ret = -EINVAL;
>  	long offset = 0;
> +	bool is_retprobe;
>  
>  	*link = NULL;
>  
> @@ -12856,13 +12902,14 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>  			else
>  				offset = 0;
>  		}
> -		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> -				strcmp(probe_type, "uretprobe.s") == 0;
> -		if (opts.retprobe && offset != 0) {
> +		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> +			      strcmp(probe_type, "uretprobe.s") == 0;
> +		if (is_retprobe && offset != 0) {
>  			pr_warn("prog '%s': uretprobes do not support offset specification\n",
>  				prog->name);
>  			break;
>  		}
> +		opts.retprobe = is_retprobe;

is there any functional change above? looks like just opts.retprobe
is replaced with is_retprobe ?

jirka
