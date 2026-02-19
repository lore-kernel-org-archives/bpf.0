Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BA3376A0
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523124; cv=none; b=F7sJ/Wrcvwc1nnpWIEXVC7tZCixkUxm3MgRuTQSL0s1aAJBYYxr3jPRsCPmobItmh5ZgFchmvCbcKmClRC3n26t84OazBPTenu8xM21vpbcMvGaIR2wiKZCP/wL1noNRSxtuU/Z+u8hc8DGogg/oi5NXwxyVRhcVG86BBOhYKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523124; c=relaxed/simple;
	bh=4qhRYzJYJqhw3wJ4QLMXajHjE6ubBZx/Hpkw7X+3UHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C76qbcOSR+cHGfYufqsiqkvlsL0WcvhqxriApkxjDNSCqfwz6KTe5a0+DsafIzmtICPKTK2/OWPWtvpCFozbSvuj/OEj+wvU3TtrY3NUbmWKg29h4IxIKQLsnx0nGPPV4zjcn0p9HRrFpYlMd/CyzYw9337QfhVFXbjsFcRRNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3v5bVWC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3v5bVWC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so7415115e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523121; x=1772127921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VwhaUWlIsNbttqV6ewM4koeUigGqNxaBh6Phv9tZqE=;
        b=S3v5bVWCErQNywHCUVA8S+2TD4Ap53iIWNYIOcnClls63cIX/KCnOmimGJ1vFuwtYh
         wwIdrpRUSaUIoJcKTO9jt3mqmL6ohfriA0LP+Kskp3FCf9xU8CD+ovk4OG4TA2kOfu4z
         7wBT5JDvakNhEgKBFzy7L/RX1HM1m1jIB+MMnC1gfVtMCO4rHWKvUhIZhEfJ+pTuob2K
         Hzzm/NYTjgN5yCqRhfta9zo5hp6OLcDc2swDXKhHZpgIbdQSv9hUvrvf2kIz2k28MSBH
         N1tAjaWUS0c4iQDJhzl66T/Pr7RFK+TAzIinyJtoFc5OE9EmevgRjyS4R9nuJzO5uMn8
         fSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523121; x=1772127921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VwhaUWlIsNbttqV6ewM4koeUigGqNxaBh6Phv9tZqE=;
        b=E4EUt7H+yeK4dEu3utmsOcgOunnxikIsTnimocUq5hOptmal4kX5HFQPy2d9oL+oxx
         35NM36jXH8hQjD776YtEFErI3bHK12zoDoB3rhdwYdaAVYr09zs+PlrCzUCqfqoBJYu1
         oQ+Mh1hD6GcXyS24FaqQyn9acEJM1cvl5p9LM9v9jc0CBxHYRaRHcVWn6G7C9lHD7QOh
         JVIXTqiIcBmEOnQ9HnNOFS7T58l/bMzbpMXQXWGHwePkqkac3hL02DNKQnf+iNyWj+7V
         dZQ+71WjRcyx576Yz4Ue02EhhMh9q77A4h3EiBSeUc8DlN2nr9pHsbuc/31jItx34L9v
         aP4w==
X-Forwarded-Encrypted: i=1; AJvYcCUIsq1jikObqms7oY++oY6SyPjkyWmew6MB6dFZfqzpMnMAX0366oV5Up64yK5h9UGpKgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4d+Rkq/HBPPuiCZ1MSRImgDWagB+ZUef/b/eiBmSj9ndHsy+
	xaiwy2bRHKhMuafChLcoi/i5jtaB0hl6r06rr55Kqaa2qdpMFKHGoQXP0tyQpw==
X-Gm-Gg: AZuq6aIJd2+9vcaQej2KhZvjUwB23oILRC8qmuFOP5aiVYs9ENYna6KWE37WYMaUGFs
	WPMb5brK4GGiJeV06oxttsIYfa1HIszBTxmgn0X6f+JvuwbGSB5/n355WE9yxJk+t+hfBf+ESK0
	B2BWGfUynajM8cUfOX8KQ3PYWtcSdYpxbiOIO23xQ8GyJlN49KqqB/wHf0/YCsg/e+Ut/Qk8nYu
	NvqtgO5SYXzKe7Zef9BDPbW3ebhAnRX4nZucO0T+k8HNcsjU7HDL1/fqlnvxsp6LEClZQVdPsIt
	d+yJ58D7Pz9t8nbbpf/fOO/Dbp6ya8Rpu9fwz36GccW1guNTwQhnH3UBAPHkwyG2s3T5276t9iI
	q6Pw3ij+oj71qQ2t+Xc1esE9Cid0cLbuoj6t3fEUgOTzTbe/NlEUmaNw6UUGmmGtz/FdyW9O1BH
	HdYz/4yOjUYKLvz4Syro7yTP0MRYPmMot7jykAElBYJdgIFUInb3OdLcRGr1Wg1BUrwlr+KSCOP
	qY=
X-Received: by 2002:a05:600c:a08b:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-4839e63e9c9mr57382465e9.12.1771523120737;
        Thu, 19 Feb 2026 09:45:20 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eafe:5787:b13c:ff75? ([2620:10d:c092:500::7:44d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31d7b18sm16454235e9.14.2026.02.19.09.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 09:45:20 -0800 (PST)
Message-ID: <41b15342-0783-4605-877e-d525e6b980f8@gmail.com>
Date: Thu, 19 Feb 2026 17:45:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/5] bpf: Add KF_ACQUIRE and KF_RELEASE support
 for iterators
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20260218182555.1501495-1-puranjay@kernel.org>
 <20260218182555.1501495-2-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260218182555.1501495-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 18:25, Puranjay Mohan wrote:
> Some iterators hold resources (like mmap_lock in task_vma) that prevent
> sleeping. To allow BPF programs to release such resources mid-iteration
> and call sleepable helpers, the verifier needs to track acquire/release
> semantics on iterator _next pointers.
>
> Repurpose the st->id field on STACK_ITER slots to track the ref_obj_id
> of the pointer returned by _next when the kfunc is annotated with
> KF_ACQUIRE. This is safe because st->id is initialized to 0 by
> __mark_reg_known_zero() in mark_stack_slots_iter() and is not compared
> in stacksafe() for STACK_ITER slots.
>
> The lifecycle is:
>
>    _next (KF_ACQUIRE):
>      - auto-release old ref if st->id != 0
>      - acquire new ref, store ref_obj_id in st->id
>      - DRAINED branch: release via st->id, set st->id = 0
>      - ACTIVE branch: keeps ref, st->id tracks it
>
>    _release (KF_RELEASE + __iter arg):
>      - read st->id, release_reference(), set st->id = 0
>
>    _destroy:
>      - release st->id if non-zero before releasing iterator's own ref
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   kernel/bpf/verifier.c | 67 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0162f946032f..aa48180b6073 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -355,6 +355,11 @@ struct bpf_kfunc_call_arg_meta {
>   		u8 spi;
>   		u8 frameno;
>   	} iter;
> +	/* Set when a kfunc takes an __iter arg. Used by the KF_RELEASE
For new comments we use kernel style with /* on the first line and then 
your text goes to the next line.
> +	 * path to release the reference tracked on the iterator slot
> +	 * (st->id) instead of requiring a refcounted PTR_TO_BTF_ID arg.
> +	 */
> +	bool has_iter_arg;
>   	struct bpf_map_desc map;
>   	u64 mem_size;
>   };
> @@ -1083,6 +1088,22 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>   	return 0;
>   }
>   
> +/* Release the acquired reference tracked by iter_st->id, if any.
> + * Used during auto-release in _next, DRAINED handling, and _destroy.
> + */
> +static int iter_release_acquired_ref(struct bpf_verifier_env *env,
> +				     struct bpf_reg_state *iter_st)
> +{
> +	int err;
> +
> +	if (!iter_st->id)
> +		return 0;
> +	err = release_reference(env, iter_st->id);
> +	if (!err)
> +		iter_st->id = 0;
> +	return err;
> +}
> +
>   static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>   				   struct bpf_reg_state *reg, int nr_slots)
>   {
> @@ -1097,8 +1118,13 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>   		struct bpf_stack_state *slot = &state->stack[spi - i];
>   		struct bpf_reg_state *st = &slot->spilled_ptr;
>   
> -		if (i == 0)
> +		if (i == 0) {
> +			/* Release any outstanding acquired ref tracked by
> +			 * st->id before releasing the iterator's own ref.
> +			 */
> +			WARN_ON_ONCE(iter_release_acquired_ref(env, st));
>   			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
> +		}
>   
>   		__mark_reg_not_init(env, st);
>   
> @@ -8943,6 +8969,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
>   		/* remember meta->iter info for process_iter_next_call() */
>   		meta->iter.spi = spi;
>   		meta->iter.frameno = reg->frameno;
> +		meta->has_iter_arg = true;
>   		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
>   
>   		if (is_iter_destroy_kfunc(meta)) {
> @@ -9178,8 +9205,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
>   	/* mark current iter state as drained and assume returned NULL */
>   	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
>   	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
> -
> -	return 0;
> +	/* If _next acquired a ref (KF_ACQUIRE), release it in the DRAINED
> +	 * branch since NULL was returned.
> +	 */
> +	return iter_release_acquired_ref(env, cur_iter);
>   }
>   
>   static bool arg_type_is_mem_size(enum bpf_arg_type type)
> @@ -13797,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   		}
>   	}
>   
> -	if (is_kfunc_release(meta) && !meta->release_regno) {
> +	if (is_kfunc_release(meta) && !meta->release_regno && !meta->has_iter_arg) {
>   		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
>   			func_name);
>   		return -EINVAL;
> @@ -14205,6 +14234,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   		}
>   		if (err)
>   			return err;
> +	} else if (meta.has_iter_arg && is_kfunc_release(&meta)) {
> +		/* For KF_RELEASE kfuncs taking an __iter arg, release the
> +		 * reference tracked by st->id on the iterator slot.
> +		 */
> +		struct bpf_reg_state *iter_st;
> +
> +		iter_st = get_iter_from_state(env->cur_state, &meta);
> +		if (!iter_st->id) {
> +			verbose(env, "no acquired reference to release\n");
> +			return -EINVAL;
> +		}
> +		err = release_reference(env, iter_st->id);
> +		if (err)
> +			return err;
> +		iter_st->id = 0;
>   	}
>   
>   	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> @@ -14356,6 +14400,18 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   			regs[BPF_REG_0].id = ++env->id_gen;
>   		}
>   		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> +		/* For iterators with KF_ACQUIRE, auto-release the previous
> +		 * iteration's ref before acquiring a new one, and after
> +		 * acquisition track the new ref on the iter slot.
> +		 */
> +		struct bpf_reg_state *iter_acquire_st = NULL;
This variable declaration shouldn't probably be here.
> +
> +		if (is_iter_next_kfunc(&meta) && is_kfunc_acquire(&meta)) {
> +			iter_acquire_st = get_iter_from_state(env->cur_state, &meta);
> +			err = iter_release_acquired_ref(env, iter_acquire_st);
The acquire and release paths for iterator references in
check_kfunc_call() are far apart, which makes the lifecycle
hard to follow. The guard conditions are also asymmetric:
meta.has_iter_arg for release vs is_iter_next_kfunc() for acquire.

More broadly, could iterator release be unified into the release_regno
dispatch, similar to dynptrs? E.g., set meta->release_regno in
process_iter_arg(), then add an iterator sub-case inside the
if (meta.release_regno) block, keeping all release logic in one
place.
> +			if (err)
> +				return err;
> +		}
>   		if (is_kfunc_acquire(&meta)) {
>   			int id = acquire_reference(env, insn_idx);
>   
> @@ -14368,6 +14424,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   			ref_set_non_owning(env, &regs[BPF_REG_0]);
>   		}
>   
> +		if (iter_acquire_st)
> +			iter_acquire_st->id = regs[BPF_REG_0].ref_obj_id;
> +
>   		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
>   			regs[BPF_REG_0].id = ++env->id_gen;
>   	} else if (btf_type_is_void(t)) {
Have you explored marking iter_next as both KF_ACQUIRE and KF_RELEASE,
so the auto-release of the previous iteration's ref hits the existing
release path naturally?
I understand it doesn't work as-is - the release branch errors out
on the first _next call, also last call does not do acquire.
But maybe there is a clean solution.
