Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C47DF6C
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333959; cv=none; b=aA6CvfSbHi3qYzmaLp9JvLXr54RXjn3QX0icP2Iet2V67PzDiSnDkvPkCQoXt2JrcnC+xqmqxFzgHRjHBsQlXOxUhhKWA6foI4mq8MngqWNXSHL2OAgwtV/ANAnVr1I205Hl6CfDUxHDSWNsy6K4iHEp645Al1W7yFuycONiZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333959; c=relaxed/simple;
	bh=n6wTbVRTDYFJc2Gf7cka02W+8y6BABmcmGbaaEZngY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwXITRuYSuqbu4RymoI0rVWz8RpB/TLF6ujqHKDX7rMZH/09/MrfZguUkBA9YloLniyXgOjYbErZTUnFtWUHjKAufrqo02GwQN+gkykyU28AsPUqIDv9nFY6izDcGN/ggNiBsW6pSgr+youEjqxtSQNxeAJG7b+MF1UeYqN5Bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e+LQ68XW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e+LQ68XW"
Message-ID: <7b3ba4a8-a785-4f70-879d-50e63d6de787@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780333945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnJmZslpteFykqsLOpA1Qkus2CFQZ1/b7kK//IqqF8Q=;
	b=e+LQ68XW8vPbh9dxoddqt2LrKM95uUip+UtzwMnY9jjsIHfWnrm0ZQ+UyqWAVLIERJ8ULB
	PwCyjeOKegKXp34zkNaaK+biGjDACuHAyfPpk5VEEoWJQwvfIaMerHt6TjFaQpK3hRiW42
	tNs8FRndFiwtB1Hvd2M23uB7litRzW0=
Date: Mon, 1 Jun 2026 10:12:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Content-Language: en-GB
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org
References: <20260407080900.551797-1-chenyuan_fl@163.com>
 <20260601064611.807637-1-chenyuan_fl@163.com>
 <20260601064611.807637-2-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260601064611.807637-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/31/26 11:46 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
>
> Root Cause
> ----------
>
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base
> BTF deduplication for modules to fail.  As a result, the module retained
> its own copy of struct bpf_prog_aux with a different BTF ID than
> vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,
> the kernel must be robust against such inconsistencies: a BTF mismatch
> should result in a clean rejection, not a kernel crash or information
> disclosure.
>
> When the distilled base dedup fails and btf_types_are_same() cannot
> match the module's bpf_prog_aux type against vmlinux's,
> is_kfunc_arg_prog_aux() returned false and the code fell through
> silently without setting arg_prog.  The kfunc then received whatever
> value was in the argument register and dereferenced it as a
> bpf_prog_aux pointer, leading to:
>
>    BUG: kernel invalid pointer dereference, address: 00000000000009e2
>    RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>    RDI: 0x000000000000046d (stale register value)
>
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able
> to control the register value -- for example by writing a BPF program
> that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
> could redirect the dereference to arbitrary kernel memory, turning
> this into an information disclosure.  The fix ensures the verifier
> either validates and injects the correct bpf_prog_aux pointer, or
> rejects the program outright -- no silent fallthrough that could
> be exploited.
>
> Crash Stack Trace
> -----------------
>
>    PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>     #0 machine_kexec at ffffffff812f6e26
>     #1 __crash_kexec at ffffffff8145a788
>     #2 crash_kexec at ffffffff8145ac24
>     #3 oops_end at ffffffff812bb67c
>     #4 page_fault_oops at ffffffff813053a1
>     #5 exc_page_fault at ffffffff828e60a1
>     #6 asm_exc_page_fault at ffffffff810012a6
>        [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>        RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>        RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>        RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>     #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
>     #8 bpf_trace_run2 at ffffffff814f8332
>     #9 __traceiter_sys_enter at ffffffff81415f45
>    #10 trace_syscall_enter at ffffffff81416735
>    #11 do_syscall_64 at ffffffff828e06a1
>
> Fix
> ---
>
> Introduce a two-layer argument-injection detection:
>
>    1. get_kfunc_arg_inject_type() -- lightweight name-based classification
>       of injectable types (currently only KF_INJECT_ARG_PROG_AUX). This
>       ensures we recognize injection candidates regardless of BTF type IDs.
>
>    2. is_kfunc_arg_prog_aux() -- strict type validation within the inject
>       case; if validation fails the program is rejected with -EINVAL instead
>       of silently bypassing injection setup.
>
> This design ensures that BTF inconsistencies result in a clean verification
> failure instead of a crash or a potential information disclosure, and the
> approach is extensible for future injection types.
>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>   kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8dd79b735a69..928b6c42a4bf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10857,6 +10857,39 @@ static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param
>   	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID);
>   }
>   
> +/*
> + * Injectable argument types are implicit kfunc arguments whose value is
> + * injected by the kernel at call time rather than received from the BPF
> + * program.  Use name-based matching for initial detection to avoid false
> + * negatives when a module's BTF references the type via a different BTF ID
> + * than vmlinux's.  Actual type compatibility is still validated by the
> + * caller with btf_types_are_same().
> + */
> +enum kfunc_inject_arg_type {
> +	KF_INJECT_ARG_NONE = 0,
> +	KF_INJECT_ARG_PROG_AUX,
> +};
> +
> +static enum kfunc_inject_arg_type get_kfunc_arg_inject_type(
> +	const struct btf *btf, const struct btf_param *arg)
> +{
> +	const struct btf_type *t;
> +	u32 res_id;
> +
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return KF_INJECT_ARG_NONE;
> +
> +	t = btf_type_skip_modifiers(btf, t->type, &res_id);
> +	if (!t)
> +		return KF_INJECT_ARG_NONE;
> +
> +	if (strcmp(btf_type_name(btf, res_id), "bpf_prog_aux") == 0)
> +		return KF_INJECT_ARG_PROG_AUX;
> +
> +	return KF_INJECT_ARG_NONE;
> +}
> +
>   /*
>    * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
>    *   - the _impl prototype with full arg list (meta->func_proto)
> @@ -11899,8 +11932,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   		u32 ref_id, type_size;
>   		bool is_ret_buf_sz = false;
>   		int kf_arg_type;
> -
> -		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
> +		enum kfunc_inject_arg_type inject_type;
> +
> +		inject_type = get_kfunc_arg_inject_type(btf, &args[i]);
> +		switch (inject_type) {
> +		case KF_INJECT_ARG_PROG_AUX:
> +			/* Validate the arg type against vmlinux's definition */
> +			if (!is_kfunc_arg_prog_aux(btf, &args[i])) {
> +				verbose(env, "arg#%d implicit argument type mismatch, "
> +					"expected struct bpf_prog_aux *\n", i);

Change the above verbose(env, ...) to
verbose(env, "%s implicit argument type mismatch, expected struct bpf_prog_aux *\n",
	reg_arg_name(env, argno));

Please do not break strings in two lines.

> +				return -EINVAL;
> +			}
>   			/* Reject repeated use bpf_prog_aux */
>   			if (meta->arg_prog) {
>   				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
> @@ -11914,6 +11956,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   			meta->arg_prog = true;
>   			cur_aux(env)->arg_prog = regno;
>   			continue;
> +		default:
> +			break;
>   		}
>   
>   		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))

I think we can do some checking in is_kfunc_arg_implicit(meta, i) to validate
the result of is_kfunc_arg_prog_aux(). This will make code simpler.

Also, please add some comments in the code to explain the reason of this code is due to pahole 1.30.
So later on at some point, this code can be removed.


