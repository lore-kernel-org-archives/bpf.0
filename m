Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D663EBF2E
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460930; cv=none; b=PuRmJUi22EofycSjJIvRY/wA/OpK67AuoKbzlO1KCgmzXMEN9hI6v5b8cUzQQzOULyWQtqvk5jobSPWb8qlbg1AjzSM3ZUqaHw4Iq9BXw9Z4SjTKJOeyGM55KT/am0BWSJglB8d0BSo65RkUBCUfvddCfBqbe6XReGWctUfk/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460930; c=relaxed/simple;
	bh=RKEt7MkBs3BOq7SX0U+G8FTIJ6+es4CHAUfIG3yLClk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C5JOD4nyiHrDzd3fitYXxmvoc4dEfgnZFbyorfT+9ji1rkhw7VGbzsMR119yWQHJ4zfTfWDTdMkHP124bXlTAV0eOU6KT9QRTUUZ83L7adt0J1CmLZkxLmzb1ZUCpW9BEB+07pvkLV/JpGcGSya1MMfXOTDld3lDO4EHrzRBzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TIRscrF0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TIRscrF0"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb49f63238so23423285a.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771460927; x=1772065727; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ODgY2O45++1KV5UPYYW8rsWjYqGl90bySQTiNM3Ts=;
        b=TIRscrF0bqpmetKDlFltxFY8okrwFnygVKxyXk9zyIN8EORDyLZ9Gz0MhuyjF/QFM1
         VA/XWsczem+oVcjUlnwS7aIFeZjNyrCkHjy1ZCUbn5Sppt3E05T76SKmhcGzxQfLDYSu
         72S/AZ1WITyyL0py/poF0ka1+2hLjJae6/9feH+E9m549ERMQlkD7uZcFUQvdfknImUV
         UXCx5S0nd4MdL9N5qB3KFtNWPHchUYRfNuabJrrtsSyYRqbI7i1f4JjTi+V7tnllEp6Z
         7OV0wL4SBQLauviwkqQ+L9732oLzbWZ3lobPTt+pGbCY3gvs+yoFewilGINJRcnqPuuc
         Jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771460927; x=1772065727;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6ODgY2O45++1KV5UPYYW8rsWjYqGl90bySQTiNM3Ts=;
        b=lZIpMCb1v/0MEpcs94ms8IHdvM2HX1+ROxHwH18NXAq56oK/uL6aZ/3hsQwZWku2x/
         lqt5/0FjpyCA6QXV7ZH3EvoE8pzVRFzBR7N/3DsFlM/sskD6a0jzPybtdjw/9+s5tlDO
         5CWWwyO0KedTby/5JF6jy0FDlfl9VSajbAYASn3ufVoLcVVvSkHVRtcgfxYgsy83gGNk
         1w+3lNBU0hCO5xUbFdXqxBgTXajFazpPPiIeC76Wo2we+bPHucD/5q+KMOEJrkWusXsd
         sIrN0rZQFE90xPvpQI5qQEBLiqLMZor8vLLlO4sNFkP8NkJKC2QPMBcsO254PiEmrwIz
         CJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ0wix/hLz64w8S0c+3jm7nJiRGsND+233R1cHR5AWia2UNzuKLpADi6lZ5MCkNGjFJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr53BXThmRtwXjhAb3hjHflMZEVTchuCFotx83ZcB5nBrlyrOB
	jetPNwkwwqx3fr4/vDT4I8hn9pumjtbXDWhm9JjMQ99wu/P9RJojLmLoq526Y2QEMMg=
X-Gm-Gg: AZuq6aJ+ejsqlonA8iO7bq+DRT3F7w4AgdCfOzNQ74pu8+nk0tJ2x//ryqhN3vT0rfJ
	sOsC9FhxVWhkJnsTdmMm5QUlxTO6GgtP5AYjoElZFqVWUROPwjC/PqK60L6xWI8AvBZaJc45S/h
	0XJYj6TLMteCcH3I47pyfh7Q0ySTU1uJ+eH8YEd57o74lGnPNi1k51zmWefn2r1my3PuzFv/3d0
	MRzOrUOHuowfMJvS7XDS/o5A/EyYJ5R3dN0hbhpSFUY5A9uJ7bJyRvvyoZ/NiOdH/sKdazwH6wK
	tGza45A41JaIZVNQHc2M+ysLjZ9wRybxxGgfcoP3Zu4yjFMdLfoqcDlBE6tqmM5pxO1nDQ+tshj
	+4jwOZW9lzCmfRQlRCdVfFY7fPXCsbD0qRsO3OLsiw3lMM8BSQ4n8KkGEKArODujGFd6DQDCQjF
	zJNpEEFZRtmJp31a0u4VBzF+U=
X-Received: by 2002:a05:622a:20f:b0:4ee:4512:4a24 with SMTP id d75a77b69052e-506e9258ab4mr42700241cf.72.1771460926650;
        Wed, 18 Feb 2026 16:28:46 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506a1a50276sm153771311cf.22.2026.02.18.16.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 16:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 19:28:45 -0500
Message-Id: <DGIIHMD5LE8T.ADJM2OXAWCGZ@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Handle duplicate kprobe
 symbols in attach_kprobe_opts
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com>

On Wed Feb 18, 2026 at 5:56 PM EST, Andrey Grodzovsky wrote:
> Add fallback to handle EADDRNOTAVAIL by retrying with absolute
> kernel addresses from kallsyms when symbol names are ambiguous.
>
> When kprobe attachment fails with EADDRNOTAVAIL (or EINVAL in
> legacy mode) and a symbol name was used, the kernel encountered
> duplicate symbols in kallsyms. This patch:
>
> - Adds module_name parameter to kallsyms_cb_t callback and
>   parser to distinguish vmlinux from module symbols
> - Implements find_kaddr_cb() to look up symbol addresses in
>   kallsyms, rejecting ambiguous symbol names
> - Modifies add_kprobe_event_legacy() to support absolute
>   address format
> - Implements retry logic in attach_kprobe_opts() that falls
>   back to address-based attachment on failure
> - Updates avail_kallsyms_cb() callback signature
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 150 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 133 insertions(+), 17 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..684781d25859 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8449,11 +8449,12 @@ static int bpf_object__sanitize_maps(struct bpf_o=
bject *obj)
>  }
> =20
>  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
> -			     const char *sym_name, void *ctx);
> +			     const char *sym_name, const char *module_name, void *ctx);
> =20
>  static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>  {
>  	char sym_type, sym_name[500];
> +	char module_name[128];

Why 128? __MODULE_NAME_LEN is defined as (64 - sizeof(unsigned long)) in
moduleparam.h.

>  	unsigned long long sym_addr;
>  	int ret, err =3D 0;
>  	FILE *f;
> @@ -8465,18 +8466,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb=
, void *ctx)
>  		return err;
>  	}
> =20
> -	while (true) {
> -		ret =3D fscanf(f, "%llx %c %499s%*[^\n]\n",
> -			     &sym_addr, &sym_type, sym_name);
> -		if (ret =3D=3D EOF && feof(f))
> +	while (!feof(f)) {
> +		/* Position indicator - will be updated by %n if format fully matches =
*/
> +		int n =3D 0;
> +		/*
> +		 * The module name and symbol name are both without whitespace,
> +		 * but we cannot use %s to capture, as it consumes the closing ']'
> +		 * of the module format. Hence the %127[^] \t\n\r\v\f] which provides
> +		 * the equivalent effect.
> +		 */
> +		ret =3D fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n",
> +			     &sym_addr, &sym_type, sym_name, module_name, &n);
> +


The following:

> +		if (ret =3D=3D 4 && n > 0) {
> +			/*
> +			 * Module symbol: all 4 fields matched AND we reached %n.
> +			 * n > 0 means we successfully parsed up to the closing ']'.
> +			 */
> +			err =3D cb(sym_addr, sym_type, sym_name, module_name, ctx);
> +		} else if (ret =3D=3D 3) {
> +			/*
> +			 * vmlinux symbol: 3 fields matched, next is matching failure against
> +			 * '[', but we don't care as we got what we needed. Also note that th=
e
> +			 * trailing newline was consumed by the space after the symbol name.
> +			 */
> +			err =3D cb(sym_addr, sym_type, sym_name, NULL, ctx);
> +		} else if (ret =3D=3D EOF && feof(f)) {
>  			break;
> -		if (ret !=3D 3) {
> -			pr_warn("failed to read kallsyms entry: %d\n", ret);
> +		} else {
> +			pr_warn("failed to read kallsyms entry: ret=3D%d n=3D%d\n", ret, n);
>  			err =3D -EINVAL;
>  			break;
>  		}
> =20
> -		err =3D cb(sym_addr, sym_type, sym_name, ctx);
>  		if (err)
>  			break;
>  	}


is pretty difficult to follow. Can avoid the long if-else chain
immediately after the fscanf? Maybe something like the following:

char *name;

while (
	ret =3D fscanf(...);
	if (ret !=3D 3 && ret !=3D 4)
		break;

	if (ret =3D=3D 4 && n > 0)
		name =3D module_name;
	else
		name =3D NULL;

	err =3D cb(..., name, ctx);
	if (err)
		...
}

if (!feof(f)) {
	pr_warn(...)
	ret =3D EINVAL;
}

It's also closer to the original code.

> @@ -8486,7 +8508,7 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, =
void *ctx)
>  }
> =20
>  static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
> -		       const char *sym_name, void *ctx)
> +		       const char *sym_name, const char *module_name, void *ctx)
>  {

Is the new argument really needed here? It seems like both for kallsyms_cb
and avail_kallsyms_cb this change is actually there for find_kaddr_cb.
But find_kaddr_cb doesn't even use the module name, it checks if it's 0.
If not then it skips the function.

We can remove the extra argument from all the callback signatures, and
instead just change libbpf_kallsyms parse with an extra parameter:

static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx, bool
skip_if_module)

or something like that, and skip calling the callback when the flag is
set if module_name !=3D NULL.

>  	struct bpf_object *obj =3D ctx;
>  	const struct btf_type *t;
> @@ -11518,10 +11540,20 @@ static void gen_probe_legacy_event_name(char *b=
uf, size_t buf_sz,
>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe=
,
>  				   const char *kfunc_name, size_t offset)
>  {
> -	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
> -			      retprobe ? 'r' : 'p',
> -			      retprobe ? "kretprobes" : "kprobes",
> -			      probe_name, kfunc_name, offset);
> +	/* When kfunc_name is NULL, use absolute address format (0xADDR),
> +	 * otherwise use symbol+offset format (SYMBOL+0xOFF)
> +	 */
> +	if (kfunc_name) {
> +		return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
> +				      retprobe ? 'r' : 'p',
> +				      retprobe ? "kretprobes" : "kprobes",
> +				      probe_name, kfunc_name, offset);
> +	} else {
> +		return append_to_file(tracefs_kprobe_events(), "%c:%s/%s 0x%zx",
> +				      retprobe ? 'r' : 'p',
> +				      retprobe ? "kretprobes" : "kprobes",
> +				      probe_name, offset);
> +	}
>  }
> =20
>  static int remove_kprobe_event_legacy(const char *probe_name, bool retpr=
obe)
> @@ -11642,6 +11674,47 @@ int probe_kern_syscall_wrapper(int token_fd)
>  	}
>  }
> =20
> +/* Context structure for finding vmlinux kernel symbol address */
> +struct find_kaddr_ctx {
> +	const char *func_name;
> +	unsigned long long kaddr;
> +};
> +
> +/* Callback to find vmlinux kernel text symbol address, skipping module =
symbols */
> +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> +			 const char *sym_name, const char *module_name, void *ctx)
> +{
> +	struct find_kaddr_ctx *data =3D ctx;
> +
> +	/* Skip module symbols - we only want vmlinux symbols */
> +	if (module_name !=3D NULL)
> +		return 0;
> +
> +	/* Only match text section symbols ('T' or 't') */
> +	if (sym_type !=3D 'T' && sym_type !=3D 't')

nit: toupper(symtype) !=3D 'T' ?

> +		return 0;
> +
> +	/* Check if this is the symbol we're looking for */
> +	if (strcmp(sym_name, data->func_name) =3D=3D 0) {
> +
> +		/* If we already have an address, we've encountered a
> +		 * duplicate symbol name. Reject such symbols to avoid
> +		 * ambiguous resolution.
> +		 */
> +		if (data->kaddr && data->kaddr !=3D sym_addr) {
> +			pr_warn("kernel symbol '%s': resolution is ambiguous: 0x%llx or 0x%ll=
x\n",
> +			sym_name, data->kaddr, sym_addr);
> +			return -EINVAL;
> +		}
> +
> +		data->kaddr =3D sym_addr;
> +		pr_debug("found kernel symbol %s at address 0x%llx\n",
> +			 sym_name, data->kaddr);
> +	}
> +
> +	return 0;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  				const char *func_name,
> @@ -11654,6 +11727,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>  	size_t offset;
>  	bool retprobe, legacy;
>  	int pfd, err;
> +	const char *optional_func_name =3D func_name;
> +	struct find_kaddr_ctx kaddr_ctx =3D { .kaddr =3D 0 };
> =20
>  	if (!OPTS_VALID(opts, bpf_kprobe_opts))
>  		return libbpf_err_ptr(-EINVAL);
> @@ -11684,21 +11759,22 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  	}
> =20
> +retry_create:
>  	if (!legacy) {
>  		pfd =3D perf_event_open_probe(false /* uprobe */, retprobe,
> -					    func_name, offset,
> +					    optional_func_name, offset,
>  					    -1 /* pid */, 0 /* ref_ctr_off */);
>  	} else {
>  		char probe_name[MAX_EVENT_NAME_LEN];
> =20
>  		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
> -					    func_name, offset);
> +					    optional_func_name, offset);
> =20
>  		legacy_probe =3D strdup(probe_name);
>  		if (!legacy_probe)
>  			return libbpf_err_ptr(-ENOMEM);
> =20
> -		pfd =3D perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_nam=
e,
> +		pfd =3D perf_event_kprobe_open_legacy(legacy_probe, retprobe, optional=
_func_name,
>  						    offset, -1 /* pid */);
>  	}
>  	if (pfd < 0) {
> @@ -11707,6 +11783,46 @@ bpf_program__attach_kprobe_opts(const struct bpf=
_program *prog,
>  			prog->name, retprobe ? "kretprobe" : "kprobe",
>  			func_name, offset,
>  			errstr(err));
> +
> +		/*
> +		 * If attachment fails with EADDRNOTAVAIL (or EINVAL in
> +		 * legacy mode) and we used non-NULL func_name, try to
> +		 * find function address in /proc/kallsyms and retry
> +		 * using KADDR instead of ambiguous symbol. Legacy
> +		 * tracefs API converts EADDRNOTAVAIL to EINVAL, so
> +		 * we need to check for both.
> +		 */
> +		if ((err =3D=3D -EADDRNOTAVAIL || (legacy && err =3D=3D -EINVAL)) && o=
ptional_func_name) {
> +			pr_debug("kallsyms lookup for %s\n",
> +				 func_name);
> +
> +			kaddr_ctx.func_name =3D func_name;
> +			kaddr_ctx.kaddr =3D 0;
> +
> +			/*
> +			 * Drop the function symbol and override the
> +			 * offset to be the desired function KADDR.
> +			 * This avoids kallsyms validation for duplicate
> +			 * symbols in the kernel. See attr.config2 in
> +			 * perf_event_open_probe and kernel code in
> +			 * perf_kprobe_init/create_local_trace_kprobe.
> +			 */
> +			optional_func_name =3D NULL;

AFAICT this will cause NULL to be passed to snprintf in
gen_probe_legacy_event_name.

> +
> +			err =3D libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx);
> +			if (err) {
> +				pr_warn("failed to get addr for %s\n",
> +					func_name);
> +				goto err_out;
> +			}
> +
> +			pr_debug("retrying %s using kaddr 0x%llx\n",
> +				 func_name, kaddr_ctx.kaddr);
> +
> +			offset +=3D kaddr_ctx.kaddr;
> +			goto retry_create;
> +		}
> +
>  		goto err_out;
>  	}
>  	link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
> @@ -11822,7 +11938,7 @@ static int avail_func_cmp(const void *a, const vo=
id *b)
>  }
> =20
>  static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> -			     const char *sym_name, void *ctx)
> +			     const char *sym_name, const char *module_name, void *ctx)
>  {
>  	struct avail_kallsyms_data *data =3D ctx;
>  	struct kprobe_multi_resolve *res =3D data->res;

