Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409C33F59E
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426371; cv=none; b=hAsVxDswVVx7YpnzTqXsJwj7YC0AzwnNbY+V1uvZjjCQNwMk/HCv9i8Wsyq1hy6vgjidFH9BP6qm1O1ExrpShZZn4ghfB4BhGYHzuxQArtgfd/zPm2d79vq9XJX5klmXOpQ3Xs/kaB/3EFVPoK9Qpu1RJDtrMcHKkBcCYiZMDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426371; c=relaxed/simple;
	bh=V5GSsYl7LuZX1O2sGJUeZdEteKsZi3QSUFovKuCeBYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/RTPS3gWUnk87+jaPoGoqJUsBJ8kRXUDjyVdAiclB/Rs+6fDL6DjU9BU61jC+RYsZJJkWXNz6qSYGJIb0pwT1kZ+c8mlmNwZc2SmH4NJrVJo5tghAXz6rox7LVFfdMsprCQ1pZ/n3iURZtcG2MvZj08j0k3yRex18RmZrpRdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vc5UE61q; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vc5UE61q"
Message-ID: <8f2dd2e9-726c-4295-995c-3bdbcda56070@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780426368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XktaSwFKmZJRVa2O5ok0+clipt+j4kB9CAvol3Nk4z0=;
	b=Vc5UE61qmbi0/jFyZoFbZdacgUCDg0k6pqBWZOQ6+xcN06znEoa9WfuZn9Y35x7ddhwt7C
	t2WQjY2XQ1UySiDG8Zx/HXztY0dmZJzVudG/95yEaWzaDdsrVJV2yIBpKEKFhyiRdX2Jfn
	Pol5viaEDwUVulD2HwLlTPlZ/yS5QHo=
Date: Tue, 2 Jun 2026 11:52:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
To: chenyuan_fl@163.com, eddyz87@gmail.com, yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
 <20260602085827.2562222-1-chenyuan_fl@163.com>
 <20260602085827.2562222-2-chenyuan_fl@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260602085827.2562222-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 1:58 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
> 
> Root Cause
> 
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base
> BTF deduplication for modules to fail.  As a result, the module retained
> its own copy of struct bpf_prog_aux with a different BTF ID than
> vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,

Hi Yuan,

Could you please elaborate on the "incorrect type information" generated
by pahole 1.30?

My understanding is, the symptom of the problem you're trying to fix is
that module BTF with custom kfuncs with KF_IMPLICIT_ARGS ends up with a
copy of an arg type, instead of referencing the BTF ID in kernel BTF.

Do you know how this happens? Is it a bug in pahole or in resolve_btfids?

I have a suspicion we might not need changes in the verifier to fix this.
Might be wrong of course, would appreciate a bit more details.

> the kernel must be robust against such inconsistencies: a BTF mismatch
> should result in a clean rejection, not a kernel crash or information
> disclosure.
> 
> When the distilled base dedup fails and btf_types_are_same() cannot
> match the module's bpf_prog_aux type against vmlinux's,

Dedup happens in pahole, but distill_base is done in resolve_btfids.
I think distill_base is supposed to remove the (copy of) target type from
module BTF. Can you confirm that it doesn't?

> is_kfunc_arg_prog_aux() returned false and the code fell through
> silently without setting arg_prog.  The kfunc then received whatever
> value was in the argument register and dereferenced it as a
> bpf_prog_aux pointer, leading to:
> 
>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>   RDI: 0x000000000000046d (stale register value)
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
> 
>   PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>    #0 machine_kexec at ffffffff812f6e26
>    #1 __crash_kexec at ffffffff8145a788
>    #2 crash_kexec at ffffffff8145ac24
>    #3 oops_end at ffffffff812bb67c
>    #4 page_fault_oops at ffffffff813053a1
>    #5 exc_page_fault at ffffffff828e60a1
>    #6 asm_exc_page_fault at ffffffff810012a6
>       [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>       RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>       RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>       RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>    #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
>    #8 bpf_trace_run2 at ffffffff814f8332
>    #9 __traceiter_sys_enter at ffffffff81415f45
>   #10 trace_syscall_enter at ffffffff81416735
>   #11 do_syscall_64 at ffffffff828e06a1
> 
> Fix
> 
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
> check in check_kfunc_args() so that an implicit argument reaching
> is_kfunc_arg_implicit() without being handled by a prior handler is
> rejected with -EFAULT, instead of silently skipped.  Recognized cases:
> 
>   - struct bpf_prog_aux *  : is_kfunc_arg_prog_aux()
>   - __ign suffix args      : is_kfunc_arg_ignore()
>   - list_push/rbtree_add   : is_bpf_list_push_kfunc() / is_bpf_rbtree_add_kfunc()
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8dd79b735a69..55c74d064e4e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11916,9 +11916,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>  
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
>  
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().  Don't flag them.
> +			 */
> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +				reg_arg_name(env, argno));
> +			return -EFAULT;
> +		}
> +
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>  
>  		if (btf_type_is_scalar(t)) {

