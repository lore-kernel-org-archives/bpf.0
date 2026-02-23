Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7533986D
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869548; cv=none; b=AmMMGQv1foV9L0ehkxAnPmJdEVY+PEQ62HRTLftafuh+5MLSQD2p52WcED8gDZtnJh7Vb8HWyKX+fUL04XG6wF78gW4QAfelHaOM/L8NRG6RCileeG1uGUh6oppM/uJEbRzYSOO3y5N3KfPgzfTc61PaR1Qeff7xy/M9qhV3bKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869548; c=relaxed/simple;
	bh=Ytr5JbLh0vlwWhuTr+MZ+p6RrnYDndVaGbBTX2pbsu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOVC6nRPTvpWp41yNlBxh7hJnEQnTqAcMVRLhk7HjyjYREDNwVGBb7UBO91Eoj3d4SGxgAvs7yZ5vhiBi8xl267BveE9CCylmCzMSyU+6fAmySJfSb8TU2+ho7uMoAsRG7mL2LMEonSyvzYonVedhwCVN6lf8N58xYZGCWc3RQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRrdt9bj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRrdt9bj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4376acce52eso2893121f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869545; x=1772474345; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fq60hVWJ0M4t3xbnR9qhGWSI++dn5Iz5WOr+/RkQS8=;
        b=dRrdt9bjWcwlXn085FdeHLNJE+EBeGAUlL+4UWjm6t7k8Ot256OMzkL98a2s4T5xZD
         pwUFS0gSIioL+vyTXqH4DUeuo3d/89yQzZot/4WtgKQ3fg3aFTkAdGqdH4VWe6EFXWXm
         l9ZSZZVsIrRrTbsNHPh/aorwfyUzINFOtWxZYbMgj2rVdrmeCskOQLnzuR9x+LJTsE4e
         Lx0cQMiRU+rpmnW6XJDCpwhcLVX+AeSqrr9WRf0Fl8GmR37nIqvA8kJDxY/g2Nahi0vW
         eqk457Zr9/egxjWIDr5Arb9r34FQGjxlwa3fiVVPlGUHdVvtF5ON5WaWmzmsxkrWNJ7d
         Lotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869545; x=1772474345;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fq60hVWJ0M4t3xbnR9qhGWSI++dn5Iz5WOr+/RkQS8=;
        b=sztn9cNV1jxgL9XfYOQjCOmnUMBb7znI6ccs6paqzeDp+nbA3hfrMVRHBlcICpVo44
         Nwq1bj0MAl/TpFHKogZ2t9khc7JdG3dkj4GY8BTiViByHI6JmLNjUlzLmlsqU1g19tAW
         gebDnQWYUdExcJuo97XnTUfRr1Ji81WpgP9+tzt3Oiu7v5Oxd8NxN9OCXreagK2mzpev
         8BJM7sEgNwjHK+rjhbwuExDTXcNn1xeal082nm6tjAt5NeQD8LWivue2dFsDQlNuQQvU
         DEfqv+PrgGqguqDF/gcNM0JVW2O3bwj7KwwGznMjx7iMrFugYKUxzqDoQnTb+gn+Zx5T
         emHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnukCsaPIc/zUYKnQFoM8doOUyig8dJX1+SLZN5/SYa4y6VGoDe+DamUNutuuiORd82Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtecmB5r9iTxlBOyF8DRRZ8HGFbkXWolv9bO6Gm054bGD6CcDB
	YsiOcyzfyb8Vs5qf1AiNeOIyI803p4BEFgeaFuDGMkSMk2B0XOwF14aS
X-Gm-Gg: ATEYQzzrn394xuAqzdKBRibENbKpTsYZ4ZGWeG9pf+rOETs5UdG0bOMjGkx1PH7t/L+
	NB/DRClywOAwwmbMdc5B+3Ggor/7X3XwwcD0R4dp07ZBfZM+84ki8L/s2kz4aofBotLA9LHJx/+
	hQS5XHEgvjZosDIr1ZYHAiM0CzmrrtcR0Ot/ujNoiNm+jdLSEaDpZ++8LXTaV/5DDnFJhjYcDDd
	bqzUnYe+E4sGl6kXKinSlOCL8YFZzA4fcdyJS2KiRPBY9Pgm4kdBHSyDfMGHBZv8laezMNQanki
	vN37Z7afF9SXbVKri2WjyFILfuvXDMcAe2z62IxfMiEXVEdtXvR1I2Wnxcrj/GDffiiQiKtPSGJ
	K81lAgsrd0kGEMxL6gfFq6Kcx/4KMMgoSD1eQQFWjdTECy0NvnZbXy3uO7qrcKOk7BGIZRTpMtv
	5ksWzajEb9CMbNkqOl2VY=
X-Received: by 2002:a05:6000:288e:b0:437:a49:137c with SMTP id ffacd0b85a97d-4396f153b4amr18790012f8f.3.1771869544799;
        Mon, 23 Feb 2026 09:59:04 -0800 (PST)
Received: from localhost ([2620:10d:c092:600::1:3fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c95dsm22346865f8f.33.2026.02.23.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:59:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
In-Reply-To: <DGMIM8SH2Q43.1I9LNNV1X34KB@etsalapatis.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
 <DGMIM8SH2Q43.1I9LNNV1X34KB@etsalapatis.com>
Date: Mon, 23 Feb 2026 17:59:03 +0000
Message-ID: <877bs3cpeg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Emil Tsalapatis" <emil@etsalapatis.com> writes:

> On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add bpf_program__clone() API that loads a single BPF program from a
>> prepared BPF object into the kernel, returning a file descriptor owned
>> by the caller.
>>
>> After bpf_object__prepare(), callers can use bpf_program__clone() to
>> load individual programs with custom bpf_prog_load_opts, instead of
>> loading all programs at once via bpf_object__load(). Non-zero fields in
>> opts override the defaults derived from the program and object
>> internals; passing NULL opts populates everything automatically.
>>
>> Internally, bpf_program__clone() resolves BTF-based attach targets
>> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
>> func/line info, fd_array, license, and kern_version from the
>> prepared object before calling bpf_prog_load().
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>>  tools/lib/bpf/libbpf.map |  1 +
>>  3 files changed, 82 insertions(+)
>>
>
> The code looks in order, one issue below.
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..4b084bda3f47 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
>>  	return prog->line_info_cnt;
>>  }
>>  
>> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts)
>> +{
>> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
>> +	struct bpf_prog_load_opts *pattr = &attr;
>> +	struct bpf_object *obj;
>> +	int err, fd;
>> +
>> +	if (!prog)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (!OPTS_VALID(opts, bpf_prog_load_opts))
>> +		return libbpf_err(-EINVAL);
>> +
>> +	obj = prog->obj;
>> +	if (obj->state < OBJ_PREPARED)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	/* Copy caller opts, fall back to prog/object defaults */
>> +	OPTS_SET(pattr, expected_attach_type,
>> +		 OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type);
>> +	OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach_btf_id);
>> +	OPTS_SET(pattr, attach_btf_obj_fd,
>> +		 OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd);
>> +	OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd);
>> +	OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags);
>> +	OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex);
>> +	OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: obj->kern_version);
>> +	OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array);
>> +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_fd);
>> +	if (attr.token_fd)
>> +		attr.prog_flags |= BPF_F_TOKEN_FD;
>> +
>> +	/* BTF func/line info */
>> +	if (obj->btf && btf__fd(obj->btf) >= 0) {
>> +		OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf));
>> +		OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL) ?: prog->func_info);
>> +		OPTS_SET(pattr, func_info_cnt,
>> +			 OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt);
>> +		OPTS_SET(pattr, func_info_rec_size,
>> +			 OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size);
>> +		OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL) ?: prog->line_info);
>> +		OPTS_SET(pattr, line_info_cnt,
>> +			 OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt);
>> +		OPTS_SET(pattr, line_info_rec_size,
>> +			 OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size);
>> +	}
>> +
>> +	OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
>> +	OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
>> +	OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
>> +
>
> Can we make it so that cloning  prepared but not loaded programs does
> not load them? The name of the method itself implies the new instance is
> identical to the old one, which is not the case - we're currently
> loading the cloned program even if the original is not loaded. I don't 
> see why for OBJ_PREPARED progrmas this shouldn't be explicitly done by the 
> caller with bpf_prog_load() instead.
Mekes sense, but there are few problems:
we won't be cloning a program, but rather it's
attributes (struct bpf_prog_load_opts); I don't think we can do true
cloning with returning a new struct bpf_program.

So the best we can do is to change to something like
bpf_program__clone_attrs() (or bpf_program__load_attrs()) then in
veristat do:

attrs = bpf_program__clone_attrs(prog)
bpf_prog_load(bpf_program__insn(prog), attrs)

Let's see what option maintainers prefer.
>
> If we do make it so that the cloned program's obj->state is identical to the
> original's let's also add a test that checks that.
>
>> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
>> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
>> +		err = prog->sec_def->prog_prepare_load_fn(prog, pattr, prog->sec_def->cookie);
>> +		if (err)
>> +			return libbpf_err(err);
>> +	}
>> +
>> +	fd = bpf_prog_load(prog->type, prog->name, obj->license, prog->insns, prog->insns_cnt,
>> +			   pattr);
>> +
>> +	return libbpf_err(fd);
>> +}
>> +
>>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>>  	.sec = (char *)sec_pfx,						    \
>>  	.prog_type = BPF_PROG_TYPE_##ptype,				    \
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index dfc37a615578..0be34852350f 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(const char *sec,
>>   */
>>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>>  
>> +/**
>> + * @brief **bpf_program__clone()** loads a single BPF program from a prepared
>> + * BPF object into the kernel, returning its file descriptor.
>> + *
>> + * The BPF object must have been previously prepared with
>> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
>> + * overrides the defaults derived from the program/object internals.
>> + * If @opts is NULL, all fields are populated automatically.
>> + *
>> + * The returned FD is owned by the caller and must be closed with close().
>> + *
>> + * @param prog BPF program from a prepared object
>> + * @param opts Optional load options; non-zero fields override defaults
>> + * @return program FD (>= 0) on success; negative error code on failure
>> + */
>> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
>> +
>>  #ifdef __cplusplus
>>  } /* extern "C" */
>>  #endif
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index d18fbcea7578..e727a54e373a 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>>  		bpf_map__set_exclusive_program;
>>  		bpf_map__exclusive_program;
>>  		bpf_prog_assoc_struct_ops;
>> +		bpf_program__clone;
>>  		bpf_program__assoc_struct_ops;
>>  		btf__permute;
>>  } LIBBPF_1.6.0;
