Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80C3D093F
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874389; cv=none; b=p8XElD1OsqdTn4hzYim/wDaNQhuF3TdEwQ+6/PrceyR8AL0FYckyrcSridyR1MprxA4JlG3O6O5IraicOnIpC9ENtwzSvDkBy7UVrprD66sVDP+yj3FTflZtRN7Pg1wdYFZXtBefy1KyUuwLIQNgTnR+bFHu3OwTF+2/6rQdxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874389; c=relaxed/simple;
	bh=ArHjFX46wE+NLVjxlxNeZT2uFfa6b5ED8yVO/Enj0vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3hXkEdOvwZ7cVVUut0+6d4wNA01NJqAGJs8jawuMyyb1x9scYiSx6ncy4JZ55/mtlFN6J6JIg+kgHon+ciof9GYStSeRY5fPlMu/JCP3Sf3955FTSGXxtJBqfBvay3KDk1fE//ehguqY83p6g0kPrUCqJqGN4KAVSdpu9Gekts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJjefOIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJjefOIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2335DC4CEF7;
	Mon, 30 Mar 2026 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874389;
	bh=ArHjFX46wE+NLVjxlxNeZT2uFfa6b5ED8yVO/Enj0vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FJjefOILAt7smb8vystU9/QhE7TonJBMNR4Fesb5TaOSg6eSfnmqvdHy07M/myb5m
	 sBAEjMAQP81e2TZzTjLkXrU0bXZZ654/5ERpL82LRZgfXTDvHFEK/q/sc5OhykXiI9
	 usnA6RPCR1p1yeAbIdpwGaqUztD6jdXzJd757v/tMVtyybY3j6XNl0HTaXB6scMIjO
	 iyqy5j4VhzvC6GU5X7wqRixBGe1aMsAhlIkeGhlVcU94Pm/hw++hygwf7LaU6xyOo7
	 cuJQ/ZHE7jMpYK7B0TDP6LfC5vMUbRXh7FfXfyH2gqLZUCxZJmx4EQUImglaQDPHtM
	 jU/OxBrJH8YBw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Emit verifier warnings through
 prog stderr
In-Reply-To: <87o6k5h7he.fsf@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
 <20260329212534.3270005-3-memxor@gmail.com> <87o6k5h7he.fsf@gmail.com>
Date: Mon, 30 Mar 2026 13:39:46 +0100
Message-ID: <m2tstxze25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
>> There is a class of messages that aren't treated as hard errors, such
>> that the program must be rejected, but should be surfaced to the user to
>> make them aware that while the program succeeded, parts of their program
>> are exhibiting behavior that needs attention. One example is usage of
>> kfuncs that are supposed to be deprecated, and may be dropped in the
>> future, though are preserved for now for backwards compatibility.
>>
>> Add support for emitting a warning message to the BPF program's stderr
>> stream whenever we detect usage of a _impl suffixed kfunc, which have
>> now been replaced with KF_IMPLICIT_ARGS variants. For this purpose,
>> introduce bpf_stream_pr_warn() as a convenience wrapper, and then mark
>> bpf_find_linfo() as global to allow its usage in the verifier to find
>> the linfo corresponding to an instruction index.
>>
>> To make the message more helpful, recommend usage of bpf_ksym_exists()
>> as a way for the user to write backwards compatible BPF code that works
>> on older kernels offering _impl suffixed kfuncs.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
> In the commit message: ..such that the program must __not__ be rejected..
>>  include/linux/bpf.h          |  9 ++++++
>>  include/linux/bpf_verifier.h |  3 +-
>>  kernel/bpf/log.c             |  6 ++--
>>  kernel/bpf/verifier.c        | 53 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 2c4f92085d79..d0158edd27b2 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3912,6 +3912,15 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>>  		bpf_stream_stage_free(&ss);                    \
>>  	})
>>  
>> +#define bpf_stream_pr_warn(prog, fmt, ...)                              \
>> +	({                                                              \
>> +		struct bpf_stream_stage __ss;                           \
>> +									\
>> +		bpf_stream_stage(__ss, prog, BPF_STDERR, ({		\
>> +			bpf_stream_printk(__ss, fmt, ##__VA_ARGS__);	\
>> +		}));							\
>> +	})
>> +
>>  #ifdef CONFIG_BPF_LSM
>>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
>>  void bpf_cgroup_atype_put(int cgroup_atype);
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 090aa26d1c98..5683c06f5a90 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -873,7 +873,8 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
>>  		  char __user *log_buf, u32 log_size);
>>  void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
>>  int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
>> -
>> +const struct bpf_line_info *bpf_find_linfo(const struct bpf_verifier_env *env,
>> +					   u32 insn_off);
>>  __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
>>  				  u32 insn_off,
>>  				  const char *prefix_fmt, ...);
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 37d72b052192..598b494ded36 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -329,8 +329,8 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>>  }
>>  EXPORT_SYMBOL_GPL(bpf_log);
>>  
>> -static const struct bpf_line_info *
>> -find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>> +const struct bpf_line_info *
>> +bpf_find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>>  {
>>  	const struct bpf_line_info *linfo;
>>  	const struct bpf_prog *prog;
>> @@ -390,7 +390,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
>>  		return;
>>  
>>  	prev_linfo = env->prev_linfo;
>> -	linfo = find_linfo(env, insn_off);
>> +	linfo = bpf_find_linfo(env, insn_off);
>>  	if (!linfo || linfo == prev_linfo)
>>  		return;
>>  
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8c1cf2eb6cbb..f50e0ebd0ded 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3206,6 +3206,7 @@ struct bpf_kfunc_desc {
>>  	u32 func_id;
>>  	s32 imm;
>>  	u16 offset;
>> +	bool warned_deprecated;
>>  	unsigned long addr;
>>  };
>>  
>> @@ -14045,6 +14046,53 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
>>  	return 0;
>>  }
>>  
>> +static bool get_insn_file_line(const struct bpf_verifier_env *env, u32 insn_off,
>> +			       const char **filep, int *linep)
>> +{
>> +	const struct bpf_line_info *linfo;
>> +
>> +	if (!env->prog->aux->btf)
>> +		return false;
>> +
>> +	linfo = bpf_find_linfo(env, insn_off);
>> +	if (!linfo)
>> +		return false;
>> +
>> +	if (bpf_get_linfo_file_line(env->prog->aux->btf, linfo, filep, NULL, linep))
>> +		return false;
>> +	return true;
>> +}
>> +
>> +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
>> +				       struct bpf_kfunc_desc *desc,
>> +				       const char *func_name,
>> +				       int insn_idx)
>> +{
>> +	int repl_len, line;
>> +	const char *file;
>> +
>> +	if (desc->warned_deprecated)
>> +		return;
>> +
>> +	if (!func_name || !strends(func_name, KF_IMPL_SUFFIX))
>> +		return;
>> +
>> +	repl_len = strlen(func_name) - strlen(KF_IMPL_SUFFIX);
>> +
>> +	if (get_insn_file_line(env, insn_idx, &file, &line))
>> +		snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s:%u", file, line);
>> +	else
>> +		snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "insn #%d", insn_idx);
>> +
>> +	bpf_stream_pr_warn(env->prog,
>> +			   "WARNING: %s calls deprecated kfunc %s(), which will be removed.\n"
>> +			   "WARNING: Switch to kfunc %.*s() instead.\n"
>> +			   "WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(%.*s).\n",
>> +			   env->tmp_str_buf, func_name, repl_len, func_name, repl_len, func_name);
>> +
>> +	desc->warned_deprecated = true;
>> +}
> Commit message suggests this is a generic functionality that we plan to
> use for all kinds of deprecations, but this function looks tightly
> coupled to KF_IMPL_SUFFIX functions. I think we can make it a bit
> friendlier to extending if split into 2 separate helpers:
> is_kfunc_deprecated() and warn_deprecated_kfunc(), so in future new
> logic for detecting deprecated funcs goes straight to
> is_kfunc_deprecated() and we make sure printing and file/line
> extractions are not changed. 

I agree with splitting this into two separate helpers.
