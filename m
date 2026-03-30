Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C93BF68A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870754; cv=none; b=r9HUssOhKtMvA6RIrjBfbRRrPKtuCE2rFLnI5HD0wu3JBrRFst/Evp9Uoxc1kqVdZlOFthEeJ+JCOxH2dB8rtq4KY8RNfb+YYUCCmYgbxqNhI4ZcOdLU9FLS26GUOjSQlRsTA88atKrx1YHlGSJXd9num3NAbp3Msvr4OgUNAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870754; c=relaxed/simple;
	bh=ZYRJx/I5+1KfuQdPQQc0kQq0yncC1iZME1SDfw6Dnz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8JZWWeNJIsL/BZsXKq569rSncfuCNoKT8TO4oMcB14Vl9TiBExfTUQmHOJI2fiVZeHeq68Q2LErKZO7IYKD6UDjPyFooXchUegNu2jHkBIQZf4s7kjn5nBjOfWcjfNoTGvspvknGGS9qC0+YVdBv/3N+bM7pObzBf0RNwGfpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le2de8bd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le2de8bd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so34511415e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870751; x=1775475551; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5em8DwDaFkXA2YjHRd+fhMRb18sZEEB4ksg5SaFWGY=;
        b=le2de8bdd9LDKe5VGUUvGeXsLy7qcMDjBRuSScfzmpK6LqazJjY4mJT3BgS50rHnaa
         WihRtMhEqO0vLDSlopCHOmay09CNewY5NCRZH/+gOGLceofSPUQQRBmG4hQ+5UW6TiY7
         QemCFNdmcIjMsVu1KfpLQX6qyH4Z/BqBqR2ZDOYK1sMJ4HtrsOJ7F9z3LPCtE+ZvsF8W
         nosvUN/n//Riof8XtZbCweZjuFzOeMu0XDuhdCa2HHxndB4sn1+uuwO/AOKj3U9DF6bt
         ZX60uljp6b74TjwDykmQ7Yn8LWNTofGtiUS/SBlG7cy+5OOPa9J25E+niDXLIy7PxbIr
         vQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870751; x=1775475551;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5em8DwDaFkXA2YjHRd+fhMRb18sZEEB4ksg5SaFWGY=;
        b=N+7kSp6gr6IIHsAMCLGuIFxrxaI2nzCTuhFrDDnVOB19bsMdYyYZ56JtggjG63iOmG
         C3wrygWhA2S2Awy5nypIob0zSfbbPHVtYL9K5lGn3WYnWQhvlxSKcElemUpiuaNEBF4z
         p1N6Y2DaHXhAefZHYUHCh0ZKQLZMV7QKqa7oPOG8pWDOyztzC37Ciaepm0oing8IllKY
         evFETlWsX4ivATtDEFev4hgd2eP+WGExmVNjHGuXcswknAIsMs5mAb9H+N9DeLPY4qQj
         JCO3bOrY1KmHKv63W0dsMsfJEX0wY/4CnHYutThFbOelCBf+sup0tLyRTMCew1qnYFeB
         RSEg==
X-Forwarded-Encrypted: i=1; AJvYcCWyz/jy59HpUmFOUGYiEgx+WVeflKvu/YlPodPu90akhkzK5lUKwzYNa0OuCTyu61i+8a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSED02+3kT25DHLJJxpxIZxHCUqkL5LkIEt3RWeB6RtGyuBcpC
	g8NGcigI2vlv7qrpwNdD+QVR1dj13I6BRiCbl5gtgvrNfb4DnImLXNgp
X-Gm-Gg: ATEYQzzMnhtq/Gj9wscvyVds1pB1tuUr8c/eW2Ru7rVRBf4mmx9QsCvclLMmkc6XePC
	DElLKmbDWbx2S0WQjp/PmHlfMOsAR+wf/aJ7/2Q/7UiZG6uMdtZwMiT8Qhrg+sk8OfNByizxkJN
	dkwQqNXeqfPWVcv3gbCMlEPBC86flyEArBHOtTY4eUy/yDcWn58o7fBKRly+NMH3Lw7LG14jmk2
	pV2LyLC7A7rj8d91LwTQTfcip5YNg8Oc/FazQQ0Bef8BqAJ/WZTejf9MaM9X32zCn/jNgPVAacD
	00KwYhyqNOqo3WvJj5Suj13T1NUXe8SUQn+WTr+zdBZ43Ra2TM7cR7siIm/yQ044aSI4UG4EydD
	AeF/hlibP7UKLwKEd4Fesdt3rTahz6sTc0tdA5q/4W/CXDF+AA2XIH5JrpWxKIw6D40Sh92qKPl
	6rN2U0OfqKNBJiEoY=
X-Received: by 2002:a05:600c:a010:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-48727d4588cmr219566255e9.7.1774870750726;
        Mon, 30 Mar 2026 04:39:10 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4b08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b105sm534051655e9.1.2026.03.30.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:39:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Emit verifier warnings through
 prog stderr
In-Reply-To: <20260329212534.3270005-3-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
 <20260329212534.3270005-3-memxor@gmail.com>
Date: Mon, 30 Mar 2026 12:39:09 +0100
Message-ID: <87o6k5h7he.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> There is a class of messages that aren't treated as hard errors, such
> that the program must be rejected, but should be surfaced to the user to
> make them aware that while the program succeeded, parts of their program
> are exhibiting behavior that needs attention. One example is usage of
> kfuncs that are supposed to be deprecated, and may be dropped in the
> future, though are preserved for now for backwards compatibility.
>
> Add support for emitting a warning message to the BPF program's stderr
> stream whenever we detect usage of a _impl suffixed kfunc, which have
> now been replaced with KF_IMPLICIT_ARGS variants. For this purpose,
> introduce bpf_stream_pr_warn() as a convenience wrapper, and then mark
> bpf_find_linfo() as global to allow its usage in the verifier to find
> the linfo corresponding to an instruction index.
>
> To make the message more helpful, recommend usage of bpf_ksym_exists()
> as a way for the user to write backwards compatible BPF code that works
> on older kernels offering _impl suffixed kfuncs.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
In the commit message: ..such that the program must __not__ be rejected..
>  include/linux/bpf.h          |  9 ++++++
>  include/linux/bpf_verifier.h |  3 +-
>  kernel/bpf/log.c             |  6 ++--
>  kernel/bpf/verifier.c        | 53 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2c4f92085d79..d0158edd27b2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3912,6 +3912,15 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>  		bpf_stream_stage_free(&ss);                    \
>  	})
>  
> +#define bpf_stream_pr_warn(prog, fmt, ...)                              \
> +	({                                                              \
> +		struct bpf_stream_stage __ss;                           \
> +									\
> +		bpf_stream_stage(__ss, prog, BPF_STDERR, ({		\
> +			bpf_stream_printk(__ss, fmt, ##__VA_ARGS__);	\
> +		}));							\
> +	})
> +
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
>  void bpf_cgroup_atype_put(int cgroup_atype);
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..5683c06f5a90 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -873,7 +873,8 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
>  		  char __user *log_buf, u32 log_size);
>  void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
>  int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
> -
> +const struct bpf_line_info *bpf_find_linfo(const struct bpf_verifier_env *env,
> +					   u32 insn_off);
>  __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
>  				  u32 insn_off,
>  				  const char *prefix_fmt, ...);
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 37d72b052192..598b494ded36 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -329,8 +329,8 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>  }
>  EXPORT_SYMBOL_GPL(bpf_log);
>  
> -static const struct bpf_line_info *
> -find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
> +const struct bpf_line_info *
> +bpf_find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>  {
>  	const struct bpf_line_info *linfo;
>  	const struct bpf_prog *prog;
> @@ -390,7 +390,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
>  		return;
>  
>  	prev_linfo = env->prev_linfo;
> -	linfo = find_linfo(env, insn_off);
> +	linfo = bpf_find_linfo(env, insn_off);
>  	if (!linfo || linfo == prev_linfo)
>  		return;
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..f50e0ebd0ded 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3206,6 +3206,7 @@ struct bpf_kfunc_desc {
>  	u32 func_id;
>  	s32 imm;
>  	u16 offset;
> +	bool warned_deprecated;
>  	unsigned long addr;
>  };
>  
> @@ -14045,6 +14046,53 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static bool get_insn_file_line(const struct bpf_verifier_env *env, u32 insn_off,
> +			       const char **filep, int *linep)
> +{
> +	const struct bpf_line_info *linfo;
> +
> +	if (!env->prog->aux->btf)
> +		return false;
> +
> +	linfo = bpf_find_linfo(env, insn_off);
> +	if (!linfo)
> +		return false;
> +
> +	if (bpf_get_linfo_file_line(env->prog->aux->btf, linfo, filep, NULL, linep))
> +		return false;
> +	return true;
> +}
> +
> +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> +				       struct bpf_kfunc_desc *desc,
> +				       const char *func_name,
> +				       int insn_idx)
> +{
> +	int repl_len, line;
> +	const char *file;
> +
> +	if (desc->warned_deprecated)
> +		return;
> +
> +	if (!func_name || !strends(func_name, KF_IMPL_SUFFIX))
> +		return;
> +
> +	repl_len = strlen(func_name) - strlen(KF_IMPL_SUFFIX);
> +
> +	if (get_insn_file_line(env, insn_idx, &file, &line))
> +		snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s:%u", file, line);
> +	else
> +		snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "insn #%d", insn_idx);
> +
> +	bpf_stream_pr_warn(env->prog,
> +			   "WARNING: %s calls deprecated kfunc %s(), which will be removed.\n"
> +			   "WARNING: Switch to kfunc %.*s() instead.\n"
> +			   "WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(%.*s).\n",
> +			   env->tmp_str_buf, func_name, repl_len, func_name, repl_len, func_name);
> +
> +	desc->warned_deprecated = true;
> +}
Commit message suggests this is a generic functionality that we plan to
use for all kinds of deprecations, but this function looks tightly
coupled to KF_IMPL_SUFFIX functions. I think we can make it a bit
friendlier to extending if split into 2 separate helpers:
is_kfunc_deprecated() and warn_deprecated_kfunc(), so in future new
logic for detecting deprecated funcs goes straight to
is_kfunc_deprecated() and we make sure printing and file/line
extractions are not changed. 
> +
>  /* check special kfuncs and return:
>   *  1  - not fall-through to 'else' branch, continue verification
>   *  0  - fall-through to 'else' branch
> @@ -14231,6 +14279,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  {
>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
>  	u32 i, nargs, ptr_type_id, release_ref_obj_id;
> +	struct bpf_kfunc_desc *desc;
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	const char *func_name, *ptr_type_name;
>  	const struct btf_type *t, *ptr_type;
> @@ -14253,6 +14302,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	func_name = meta.func_name;
>  	insn_aux = &env->insn_aux_data[insn_idx];
>  
> +	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
> +	if (desc)
> +		warn_for_deprecated_kfuncs(env, desc, func_name, insn_idx);
> +
>  	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
>  
>  	if (!insn->off &&
> -- 
> 2.52.0
