Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5D3A8FE6
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955712; cv=none; b=ARd6UZjknH3ia1AK01YMQw7X0ggS8mBoqNmon5QlOhsvH2aQt1ixQPv+s3DHMDjqnv8E3lBFdE/x9a6N1P1NGdZm276P3ZAfZ7BT6rJEMDjcEBPiUgVAEnpLrSMJEPDBI96f6517KadQBD4CuFEz/b1L0Rt3g6wZYMUabFCrvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955712; c=relaxed/simple;
	bh=AnfYKvtyCzbHnH+cekY8s0sC3mbCYE+L6XA6+UaT4mw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kITrq6sEo++gDsKTKNw09066md93kAqDVLr617AhM9bnFR3wMtAiSbWehV5UdIMDvXXkH7ja0zKVraqYNNdnYjXA6anLSrdg16d//H/ZWzxpuh3GUgBP1wcNms07TTjD4CEVn0HYLgQgLNbqMG5Teh7+bxOy+eL1tn6E0DIiYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bIjfoKCH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bIjfoKCH"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb420fbb5dso329111785a.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771955709; x=1772560509; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eim94QHukcC7eFwnevuzAZ/rxNvr8WPzeMv7vQfsO64=;
        b=bIjfoKCHPLy3wOz5hnPQzBhklXIOivopFxcZTW9+8e3j+LnUzEjSIYpcXPRIQNzrD9
         K1/cRkcEaV8DvQ08wgTecYf9E0z+XZ6p78tqiw4I+wwqKyaWUtgdt2pvBY9fUrgM67kd
         s9mEYrO0c0FclW2IqU8wbmRuL8ptc1tAmYrCruq+nmsOuGgeWM2sm7oQvCKMeXLPtzKA
         wC2dwAwuBFZU/PbFTgqxWzgfeM7MemCfQkLAE2MG2BKQCMmnk/Tb7zfURhuKMp2V7KQm
         WvUd1x6Vut0XNl6XuN9Y8GGJzeUrzelmesTdy1lnTQYpqLEU/F+8BZukjwF+A5G3qipx
         6N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955709; x=1772560509;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eim94QHukcC7eFwnevuzAZ/rxNvr8WPzeMv7vQfsO64=;
        b=v7/qqB1ZvfF9mxTfxpof1/agqQ065ACBdtcKD+nKp9eWAb14U/khypoK53X077G8Um
         e1gnudMQjfS4vu1LMyDBd86LRH0hDy9Zm2wN7SEJqZ/PBvc5BOdwRie/it90HIIKh62E
         s9wVXEAApfavO6wOvMlGx93ovehPM1R4BD9xh1wmZxCz9qodOD2Ct13my2KKi7Ni19ma
         025fQIWcdoRKtSg1OvWY4Xig/JzlKJffqYBubLxgpcZ8nRdenp+q9ReTWtpKBcBOwdIF
         jRr21PhLtCKFoU8E04NGVfKrsyS3E6GygeiiDno5UBLx2Rgpnk+jMiqFrgHLyH2csIAq
         Fm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0IoapcQQRRvxOe/lSyoDs9ZSbk3kZNx3IReoPZ5MNSc4mJ5QSC950Dc5x2xjqhPILHus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDK/gcnM/0uWlSOGemG6AAND1IYQMs3eX293BKpTMobf2YNUjL
	Qsk4+fYGmUs24QwBlJbpoqIx6IHIwRkhsU7nL4WLgaVzItKR2XCSi11SyoyEocv6J30=
X-Gm-Gg: AZuq6aIOgA9pX1c0AXeobYhy40GMGe+ZXaxuGHsjIQhTKrflhV5VS4zEHGKc4HyOgK/
	PtHZ4xpc74cIYVFFj/RUk9J1FFDF8jR4RJjGYiM9GPwEloemZVVmVxQV/BrScdCFylfBoXqIBkV
	+U+nreaAna5rxUvpYBSInNi1ex++8EJuj0mJrKwz2/D96XlP275SnTRtDnFzvU3d2PctbzLLaVP
	yy263jmgpAhJnWRrk0fs2KsX9vd61K3LkgKeq34rnn9zBp1h216l9aVHSx1AYHoF9DRr3cY68IC
	f6qYEajUCOsPfTmgykmiAJafY1E3lEAynczlM4eCeZPansvE97BK0b35ecxs2ZtHv9rhLiMOskV
	QKiOsn6T9XQAo5iQFB09CJH8B4AmIOd64ofaUGMw6lL2WMtaop7MRtBx5vK434G1bdYQt/Q5sfE
	YCRmxXD8Pe4YEXD9IQvzxMwWdVa87kyWjs/Q==
X-Received: by 2002:a05:620a:4491:b0:8cb:4ba9:cce6 with SMTP id af79cd13be357-8cb8ca83450mr1659112485a.66.1771955708562;
        Tue, 24 Feb 2026 09:55:08 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d05fa3csm986178185a.12.2026.02.24.09.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 12:55:07 -0500
Message-Id: <DGNDVI5OW8LF.38M1D6KV6YVHS@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: Handle duplicate kprobe
 symbols in attach_kprobe_opts
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
 <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com>

On Tue Feb 24, 2026 at 12:23 PM EST, Andrey Grodzovsky wrote:
> When attaching a kprobe to a function that has duplicate symbols in
> kallsyms (e.g. same name in vmlinux and a module), the kernel returns
> EADDRNOTAVAIL (or EINVAL via the legacy path). Detect this and retry
> by resolving the vmlinux address through kallsyms, skipping module
> symbols, and using the absolute address for probe creation.
>
> Extend libbpf_kallsyms_parse() to support module name extraction and
> add a skip_if_module flag so callers can filter module symbols at the
> parse level without changing callback signatures.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 153 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 135 insertions(+), 18 deletions(-)
>

Hello,


    looks much better!

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..5907ab09c4dc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8460,9 +8460,11 @@ static int bpf_object__sanitize_maps(struct bpf_ob=
ject *obj)
>  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
>  			     const char *sym_name, void *ctx);
> =20
> -static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
> +static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx,
> +				bool skip_if_module)
>  {
>  	char sym_type, sym_name[500];
> +	char module_name[128];

Sorry for the delay, picking this up from the last version: If the
name length is not available from a header and we'd have to hardcode it=20
then this is fine. sym_name[500] above seems to be hardcoded too.

>  	unsigned long long sym_addr;
>  	int ret, err =3D 0;
>  	FILE *f;
> @@ -8475,21 +8477,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb=
, void *ctx)
>  	}
> =20
>  	while (true) {
> -		ret =3D fscanf(f, "%llx %c %499s%*[^\n]\n",
> -			     &sym_addr, &sym_type, sym_name);
> -		if (ret =3D=3D EOF && feof(f))
> +		int n =3D 0;
> +
> +		/*
> +		 * Format tries to match both vmlinux and module kallsyms
> +		 * entries in one call. Module entries have the form:
> +		 *   addr type name [module]
> +		 * %n fires only if the closing ']' literal is matched.
> +		 */
> +		ret =3D fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n",
> +			     &sym_addr, &sym_type, sym_name, module_name, &n);
> +
> +		/* EOF or malformed line - handle after the loop */
> +		if (ret !=3D 3 && ret !=3D 4)
>  			break;
> -		if (ret !=3D 3) {
> -			pr_warn("failed to read kallsyms entry: %d\n", ret);
> -			err =3D -EINVAL;
> +
> +		/* ret =3D=3D 4 && n =3D=3D 0: scanset matched but ']' didn't */
> +		if (ret =3D=3D 4 && n =3D=3D 0)
>  			break;
> -		}
> +
> +		if (ret =3D=3D 4 && skip_if_module)
> +			continue;
> =20
>  		err =3D cb(sym_addr, sym_type, sym_name, ctx);
>  		if (err)
>  			break;
>  	}
> =20
> +	/* !err: don't overwrite callback errors with -EINVAL */
> +	if (!feof(f) && !err) {
> +		pr_warn("failed to read kallsyms entry: ret=3D%d\n", ret);
> +		err =3D -EINVAL;
> +	}
> +
>  	fclose(f);
>  	return err;
>  }
> @@ -8529,7 +8549,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
> =20
>  static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  {
> -	return libbpf_kallsyms_parse(kallsyms_cb, obj);
> +	return libbpf_kallsyms_parse(kallsyms_cb, obj, false);
>  }
> =20
>  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_nam=
e,
> @@ -11527,10 +11547,20 @@ static void gen_probe_legacy_event_name(char *b=
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
> @@ -11559,7 +11589,7 @@ static int perf_event_kprobe_open_legacy(const ch=
ar *probe_name, bool retprobe,
>  	err =3D add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offse=
t);
>  	if (err < 0) {
>  		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
> -			kfunc_name, offset,
> +			kfunc_name ? kfunc_name : "(abs_addr)", offset,
>  			errstr(err));
>  		return err;
>  	}
> @@ -11567,7 +11597,7 @@ static int perf_event_kprobe_open_legacy(const ch=
ar *probe_name, bool retprobe,
>  	if (type < 0) {
>  		err =3D type;
>  		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s=
\n",
> -			kfunc_name, offset,
> +			kfunc_name ? kfunc_name : "(abs_addr)", offset,
>  			errstr(err));
>  		goto err_clean_legacy;
>  	}
> @@ -11651,6 +11681,43 @@ int probe_kern_syscall_wrapper(int token_fd)
>  	}
>  }
> =20
> +/* Context structure for finding vmlinux kernel symbol address */
> +struct find_kaddr_ctx {
> +	const char *func_name;
> +	unsigned long long kaddr;
> +};
> +
> +/* Callback to find vmlinux kernel text symbol address */
> +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> +			 const char *sym_name, void *ctx)
> +{
> +	struct find_kaddr_ctx *data =3D ctx;
> +
> +	/* Only match text section symbols ('T' or 't') */
> +	if (toupper(sym_type) !=3D 'T')
> +		return 0;
> +
> +	/* Check if this is the symbol we're looking for */
> +	if (strcmp(sym_name, data->func_name) =3D=3D 0) {
> +
> +		/* If we already have an address, we've encountered a

Nit: Missing newline between comment open and the text.

> +		 * duplicate symbol name. Reject such symbols to avoid
> +		 * ambiguous resolution.
> +		 */
> +		if (data->kaddr && data->kaddr !=3D sym_addr) {

Q: Is it possible that data->kaddr =3D=3D sym_addr in the first place - tha=
t
is, can we get the same symbol resolution twice? If not, can we simplify
this to if (data->kaddr) { ... } ?

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
> @@ -11663,6 +11730,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>  	size_t offset;
>  	bool retprobe, legacy;
>  	int pfd, err;
> +	const char *optional_func_name =3D func_name;
> +	struct find_kaddr_ctx kaddr_ctx =3D { .kaddr =3D 0 };
> =20
>  	if (!OPTS_VALID(opts, bpf_kprobe_opts))
>  		return libbpf_err_ptr(-EINVAL);
> @@ -11693,9 +11762,10 @@ bpf_program__attach_kprobe_opts(const struct bpf=
_program *prog,
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
> @@ -11707,7 +11777,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
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
> @@ -11716,6 +11786,53 @@ bpf_program__attach_kprobe_opts(const struct bpf=
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
> +
> +			err =3D libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx, true);
> +			if (err) {
> +				pr_warn("failed to get addr for %s\n",
> +					func_name);
> +				goto err_out;
> +			}
> +
> +			if (kaddr_ctx.kaddr) {
> +				pr_debug("retrying %s using kaddr 0x%llx\n",
> +					 func_name, kaddr_ctx.kaddr);
> +
> +				offset +=3D kaddr_ctx.kaddr;
> +				free(legacy_probe);
> +				legacy_probe =3D NULL;
> +				goto retry_create;
> +			}
> +
> +			pr_warn("symbol '%s' not found in vmlinux\n",
> +				func_name);
> +		}
> +
>  		goto err_out;
>  	}
>  	link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
> @@ -11931,7 +12048,7 @@ static int libbpf_available_kallsyms_parse(struct=
 kprobe_multi_resolve *res)
>  	data.syms =3D syms;
>  	data.res =3D res;
>  	data.cnt =3D cnt;
> -	libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
> +	libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
> =20
>  	if (res->cnt =3D=3D 0)
>  		err =3D -ENOENT;

