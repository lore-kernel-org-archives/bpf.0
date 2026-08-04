Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34E3EDE7A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835003; cv=none; b=S6/P2B0PvDsQwC+VZWUXg+o3CStHGVAd912MMTcxtiwK4jVPTq+uSNtmCuDOMM3hsn2hMoN3J8pb+vXVz5Xmd8efj+LE7DEWuida7a66RrxyeZwSy5wsp9NRiD+ocgSVQRiBBTXuUsz5fvhtGcgmfkUuQFyOGvFGPBS/ucCmRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835003; c=relaxed/simple;
	bh=4RnfTQVjVWJQ4mE5NBYc9aWk8W1gF/iUjTd0tcdfm4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swcb7mCZb6wSclakUFvWisv/oe4n9nG23RYP6BwCxBUlPwYbq99QirpTXQPxJsqsROKkbgLoPGLwk4S8+m5Sj4P/uFVEkSkisrOsq4/trrRTF78sFJq8YWFWF4nWzghxt+aCloCyDWGySIJCvq39IxkgsKmd3npX1WUXoOXmX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NdCR7OZT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NdCR7OZT"
Message-ID: <e81cd652-44ec-44ef-87ca-217a4eecd344@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785834989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7WVS9+Dj1aYQt4n8Wp3bUj42/l8lW+B2HDlbRvzazE=;
	b=NdCR7OZTZLrUtL4NmxOGPkDTeYYjesw833waZosaz8i/8gIYwsQlqCk1/Iu29ogwIKLQQq
	mmwK0ZR7INhQFEoeuMqjUYaUZmrJXVj4YHstHNv+oFi3tTKUywPbjdOE4+EBwTmJHbtism
	oT4VePPoh9Btc12hpIojIhQdkTf4tDA=
Date: Tue, 4 Aug 2026 17:15:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260804083212.79271-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

[PATCH bpf-next] bpf: ...

On 4/8/26 16:32, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
> explicitly marked as safe to call while holding bpf_spin_lock.
> 
> Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.


Sounds reasonable to me. I did see the requirement when implementing a 
custom struct_ops.

A selftest is required for this new flag.

Thanks,
Leon

> 
> Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>   include/linux/btf.h   |  1 +
>   kernel/bpf/verifier.c | 20 +++++++++++++++-----
>   2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index c09b7994de4e..380dc10b6750 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,7 @@
>   #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>   #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>   #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
> +#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
>   
>   /*
>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7aa47342dc65..9f3feba3c2fe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
>   	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
>   }
>   
> -static bool kfunc_spin_allowed(u32 btf_id)
> +static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
>   {
> -	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
> -	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
> -	       is_bpf_stream_kfunc(btf_id);
> +	struct bpf_kfunc_meta kfunc;
> +	int err;
> +
> +	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_id) ||
> +	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) ||
> +	    is_bpf_stream_kfunc(func_id))
> +		return true;
> +
> +	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
> +	if (err || !kfunc.flags)
> +		return false;
> +
> +	return *kfunc.flags & KF_SPIN_LOCK;
>   }
>   
>   static bool is_sync_callback_calling_kfunc(u32 btf_id)
> @@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>   				     insn->imm != BPF_FUNC_spin_unlock &&
>   				     insn->imm != BPF_FUNC_kptr_xchg) ||
>   				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> -				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
> +				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
>   					verbose(env,
>   						"function calls are not allowed while holding a lock\n");
>   					return -EINVAL;

