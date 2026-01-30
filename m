Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33722E6CD3
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779854; cv=none; b=DsTyV6fIqfB3hf8mHbawKN9p81HhfPaeUDLkKOoA12idfjO2yj02AKUPwkHYsJwR0w0ycL/7TJDMnHnMEIMFCNeh3+NNp9dFFxerGw+bqeGGC/HrfBcPVo605tSMtimpOkX+AhxzkPQ/7B2762ORMwUocUpJYphNuAUF8lcqbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779854; c=relaxed/simple;
	bh=k2f9uH6BfiJzF8ASZPcpUZfp5fTOE0d7jw5xpgULCxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChR423hGajKyQfLu+70ZrHrrDcl8Xw0U76SZWTJHiQASKDgWbg5pS/2g4bVYa32cVAH94rkn8eNWL9d65zcNNrVQzpTGYafZBhmEvDZ4KazjUIUnRZeMR++8XGFCCp1HbS9r80kcn5bD73BzBVWS6fAduai7AkwYULiFQCMBdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf4T801P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf4T801P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-481188b7760so14730475e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 05:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769779850; x=1770384650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYJnW+BLFcrS18Pqzm8TX7d0ehBBvxV5Jh5Gmirlg0g=;
        b=mf4T801Pd475IR5Mt9va+MeidehAFpPHqYta2zV3ZonKPZBRdMr95gw1ANMHw7tdxX
         O1HDSlBpGZSqMk69FBQW+enmdStbBY0Wsqbg+y3UtdfYEcHiucWMvAGPazmQuYbdpK1U
         ZBxFWs5qT0vhfflsTsqPT8eMa/B+e3HlJcZGUgXBZx4TBGAyeoyBtUP3f2wUJ2jVEHFe
         jcsJeDHmhMhm71/xERTdUwv4pdJZkL8ORLRyfn9AWX2PmEmKaFFB7ywSKogBAYkSu0DY
         JynEC0IOqU/KtrtXFQ4gTBcVHjPb/qf+fJQCf3RqjpnQ5WDvJU72bn/EfQgCjb+ugmrU
         xKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779850; x=1770384650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYJnW+BLFcrS18Pqzm8TX7d0ehBBvxV5Jh5Gmirlg0g=;
        b=fNTo7zkYdt1mgR7twkQZBbUyMF/rPtIzIJaKHCM/Z0hBZd23bQ/IJ6jBXxn8G8xUEv
         bw5be/Qxdb039y6uHV5h4cyDuB+2SZ6Gpa1xVJ+VFZ4nldBYf5YVS/Gl2DOdPlNuIKey
         A+91K6JbLNa+HQP4FTxd2tgq5Tp92/rzA/JLEP1Zgiz5xLWqyLDxGm/jALxW/pKeDe35
         QSYVGXc9RBJR3ya1pbe9lKIB5UBhIdnW/xVhFa0glTA/1fbJDzXWDLOyuVs+0ptaCH3t
         KTwCFQM9NGNokYcmheXposHmXw0e1KVAHgmD2wJfgXVqgo9/dwHusF1gdChxPJHERKoX
         7bvw==
X-Gm-Message-State: AOJu0YzpCUPhzd2UIAt8IzaSXCpSqi5WmBKuuLUfuBdhkpX6gPS9y9Nu
	kmoTwSq23fgOLzF4dfQSVgm+/ARs8DS/00v54qos2f4KrvU9EacuMATO
X-Gm-Gg: AZuq6aIcrdlSND4Ind/UKYNoDfHGcTZ1bHY1O1F335OzF+qRAemmOyVU9G5e7ZyHW4Q
	udsg2aMcE0B1N9KRFXAqynGI4c4BTuCopI89zWMExv3i6klSpU4NQiYYM+yHsD+thrG8hQ6OiKK
	B+D5NtH6IBx+V3yQjtyZQZHMMT5w3SRn8M1gQIprFxXiSqKCzKJN5x7xviAnEvQA/vP4KUzeefD
	Qu9+JFNpIkrhoOYGfKdRVwQ66mXotHn71nSzb74nV7JrAOKUR4JqTWnn7yBnv0VnPzl+GVB3osV
	lScklBdtLs+obnTEVBJh5Lp9kjLmKAIFPH4GrmN/6pCbgTurxoj1CEV6WyYvZdAEv0NTkq+lOFP
	/gxV/BR+OMPHIjCAYtLaebT4jkHGT4G8kJOtJr0NkokBHWWgsJIFuGE/Gme6PB0uI0LnnzqfbK9
	YtwHQO1roWZE5GnjVVk0esz7/PtYcPoLyEDRA=
X-Received: by 2002:a05:600c:1da8:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-482db498227mr33850995e9.26.1769779849856;
        Fri, 30 Jan 2026 05:30:49 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1130::11e3? ([2620:10d:c092:400::5:cab1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdeafffsm187887255e9.7.2026.01.30.05.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:30:49 -0800 (PST)
Message-ID: <b4641e74-a1d0-4688-bcc8-f824d61d757c@gmail.com>
Date: Fri, 30 Jan 2026 13:30:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next] bpf: Add the missing types in the logs
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130081520.59713-1-yangfeng59949@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260130081520.59713-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/26 08:15, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Add the missing types to avoid such uninformative errors as shown below:
> R1 type=ptr_ expected=ptr_
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v4:
> - Added a part that was accidentally omitted before, please ignore the v3 version.
> Changes in v3:
> - Fix the self-test failures caused by this patch.
> - Link to v2: https://lore.kernel.org/all/20260129073614.113380-1-yangfeng59949@163.com/
> Changes in v2:
> - Group together those for which only 0 or 1 can be selected. thanks, Mykyta Yatsenko.
> - Link to v1: https://lore.kernel.org/all/20260128085842.145057-1-yangfeng59949@163.com/
> ---
>   kernel/bpf/log.c                              | 53 +++++++++++++++++--
>   .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
>   .../selftests/bpf/prog_tests/spin_lock.c      |  6 +--
>   .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
>   .../selftests/bpf/progs/linked_list_peek.c    |  2 +-
>   .../bpf/progs/local_kptr_stash_fail.c         |  2 +-
>   .../selftests/bpf/progs/percpu_alloc_fail.c   |  4 +-
>   .../selftests/bpf/progs/rbtree_search.c       |  4 +-
>   .../struct_ops_kptr_return_fail__local_kptr.c |  2 +-
>   9 files changed, 63 insertions(+), 20 deletions(-)
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..c7d08b1ba96f 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -432,6 +432,44 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
>   	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
>   }
>   
> +static const char *dynptr_reg_type(enum bpf_reg_type type)
> +{
> +	if (type & DYNPTR_TYPE_LOCAL)
> +		return "dynptr_local_";
> +	if (type & DYNPTR_TYPE_RINGBUF)
> +		return "dynptr_ringbuf_";
> +	if (type & DYNPTR_TYPE_SKB)
> +		return "dynptr_skb_";
> +	if (type & DYNPTR_TYPE_XDP)
> +		return "dynptr_xdp_";
> +	if (type & DYNPTR_TYPE_SKB_META)
> +		return "dynptr_skb_meta_";
> +	if (type & DYNPTR_TYPE_FILE)
> +		return "dynptr_file_";
> +
> +	return "";
> +}
> +
> +static const char *trusted_reg_type(enum bpf_reg_type type)
> +{
> +	if (type & PTR_TRUSTED)
> +		return "trusted_";
> +	if (type & PTR_UNTRUSTED)
> +		return "untrusted_";
> +
> +	return "";
> +}
> +
> +static const char *rw_reg_type(enum bpf_reg_type type)
> +{
> +	if (type & MEM_RDONLY)
> +		return "rdonly_";
> +	if (type & MEM_WRITE)
> +		return "write_";
> +
> +	return "";
> +}
> +
>   /* string representation of 'enum bpf_reg_type'
>    *
>    * Note that reg_type_str() can not appear more than once in a single verbose()
> @@ -439,7 +477,7 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
>    */
>   const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
>   {
> -	char postfix[16] = {0}, prefix[64] = {0};
> +	char postfix[16] = {0}, prefix[128] = {0};
>   	static const char * const str[] = {
>   		[NOT_INIT]		= "?",
>   		[SCALAR_VALUE]		= "scalar",
> @@ -473,14 +511,19 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
>   			strscpy(postfix, "_or_null");
>   	}
>   
> -	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
> -		 type & MEM_RDONLY ? "rdonly_" : "",
> +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s",
> +		 rw_reg_type(type),
> +		 trusted_reg_type(type),
> +		 dynptr_reg_type(type),
>   		 type & MEM_RINGBUF ? "ringbuf_" : "",
>   		 type & MEM_USER ? "user_" : "",
>   		 type & MEM_PERCPU ? "percpu_" : "",
>   		 type & MEM_RCU ? "rcu_" : "",
> -		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> -		 type & PTR_TRUSTED ? "trusted_" : ""
> +		 type & MEM_UNINIT ? "uninit_" : "",
> +		 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
> +		 type & MEM_ALLOC ? "alloc_" : "",
> +		 type & NON_OWN_REF ? "non_own_ref_" : "",
> +		 type & MEM_ALIGNED ? "aligned_" : ""
>   	);
>   
>   	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> index 14c5a7ef0e87..141c611de1cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -69,7 +69,7 @@ static struct {
>   	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
>   	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
>   	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
> -	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> +	{ "new_null_ret", "R0 invalid mem access 'alloc_ptr_or_null_'" },
>   	{ "obj_new_acq", "Unreleased reference id=" },
>   	{ "use_after_drop", "invalid mem access 'scalar'" },
>   	{ "ptr_walk_scalar", "type=rdonly_untrusted_mem expected=percpu_ptr_" },
> @@ -87,12 +87,12 @@ static struct {
>   	{ "incorrect_value_type",
>   	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=48 in struct foo, "
>   	  "but arg is at offset=0 in struct bar" },
> -	{ "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
> +	{ "incorrect_node_var_off", "variable alloc_ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
>   	{ "incorrect_node_off1", "bpf_list_node not found at offset=49" },
>   	{ "incorrect_node_off2", "arg#1 offset=0, but expected bpf_list_node at offset=48 in struct foo" },
>   	{ "no_head_type", "bpf_list_head not found at offset=0" },
>   	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
> -	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
> +	{ "incorrect_head_var_off2", "variable alloc_ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
>   	{ "incorrect_head_off1", "bpf_list_head not found at offset=25" },
>   	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
>   	{ "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> index 254fbfeab06a..b365010e47c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> @@ -13,9 +13,9 @@ static struct {
>   	const char *err_msg;
>   } spin_lock_fail_tests[] = {
>   	{ "lock_id_kptr_preserve",
> -	  "5: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2) "
> -	  "R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
> -	  "R1 type=ptr_ expected=percpu_ptr_" },
> +	  "5: (bf) r1 = r0                       ; R0=alloc_ptr_foo(id=2,ref_obj_id=2) "
> +	  "R1=alloc_ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
> +	  "R1 type=alloc_ptr_ expected=percpu_ptr_, percpu_rcu_ptr_, trusted_percpu_ptr_" },
>   	{ "lock_id_global_zero",
>   	  "; R1=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
>   	  "R1 type=map_value expected=percpu_ptr_" },
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 8f2ae9640886..b497e61a3224 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1090,7 +1090,7 @@ int dynptr_read_into_slot(void *ctx)
>   
>   /* bpf_dynptr_slice()s are read-only and cannot be written to */
>   SEC("?tc")
> -__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
> +__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_mem")
>   int skb_invalid_slice_write(struct __sk_buff *skb)
>   {
>   	struct bpf_dynptr ptr;
> @@ -1111,7 +1111,7 @@ int skb_invalid_slice_write(struct __sk_buff *skb)
>   
>   /* bpf_dynptr_slice()s are read-only and cannot be written to */
>   SEC("?tc")
> -__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
> +__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_meta_mem")
>   int skb_meta_invalid_slice_write(struct __sk_buff *skb)
>   {
>   	struct bpf_dynptr meta;
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
> index 264e81bfb287..60f3f9e4d3a8 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_peek.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
> @@ -100,7 +100,7 @@ long test_##op##_spinlock_##dolock(void *ctx)			\
>   	return !!jiffies;					\
>   }
>   
> -#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
>   TEST_FB(front, true)
>   TEST_FB(back, true)
>   #undef MSG
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> index fcf7a7567da2..ae6cf9efab5f 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> @@ -40,7 +40,7 @@ struct {
>   } some_nodes SEC(".maps");
>   
>   SEC("tc")
> -__failure __msg("invalid kptr access, R2 type=ptr_node_data2 expected=ptr_node_data")
> +__failure __msg("invalid kptr access, R2 type=alloc_ptr_node_data2 expected=ptr_node_data")
>   long stash_rb_nodes(void *ctx)
>   {
>   	struct map_value *mapval;
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> index f2b8eb2ff76f..87154ca70bb4 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> @@ -60,7 +60,7 @@ int BPF_PROG(test_array_map_1)
>   }
>   
>   SEC("?fentry/bpf_fentry_test1")
> -__failure __msg("invalid kptr access, R2 type=percpu_ptr_val2_t expected=ptr_val_t")
> +__failure __msg("invalid kptr access, R2 type=percpu_alloc_ptr_val2_t expected=ptr_val_t")
>   int BPF_PROG(test_array_map_2)
>   {
>   	struct val2_t __percpu_kptr *p2;
> @@ -84,7 +84,7 @@ int BPF_PROG(test_array_map_2)
>   }
>   
>   SEC("?fentry.s/bpf_fentry_test1")
> -__failure __msg("R1 type=scalar expected=percpu_ptr_, percpu_rcu_ptr_, percpu_trusted_ptr_")
> +__failure __msg("R1 type=scalar expected=percpu_ptr_, percpu_rcu_ptr_, trusted_percpu_ptr_")
>   int BPF_PROG(test_array_map_3)
>   {
>   	struct val_t __percpu_kptr *p, *p1;
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/testing/selftests/bpf/progs/rbtree_search.c
> index b05565d1db0d..f060d7ae22fa 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_search.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
> @@ -189,10 +189,10 @@ long test_##op##_spinlock_##dolock(void *ctx)		\
>    * Otherwise, the test_loader will incorrectly match the prog lineinfo
>    * instead of the log generated by the verifier.
>    */
> -#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=rcu_alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
>   TEST_ROOT(true)
>   #undef MSG
> -#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=rcu_alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
>   TEST_LR(left,  true)
>   TEST_LR(right, true)
>   #undef MSG
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
> index b8b4f05c3d7f..f9836e8fd100 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
> @@ -13,7 +13,7 @@ void bpf_task_release(struct task_struct *p) __ksym;
>    * reject programs returning a local kptr.
>    */
>   SEC("struct_ops/test_return_ref_kptr")
> -__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
> +__failure __msg("At program exit the register R0 is not a known value (alloc_ptr_or_null_)")
>   struct task_struct *BPF_PROG(kptr_return_fail__local_kptr, int dummy,
>   			     struct task_struct *task, struct cgroup *cgrp)
>   {

