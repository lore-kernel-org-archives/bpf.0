Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD53F9A1C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002281; cv=none; b=d0553d0f5R/fH1QxeWPrDCFihrp6g4V85nuenyjX8usFw7zE9pDV8e8yaq/k2Wh42CQZr2A9xV/IgFAmcOEIBcXDUREMsn59tH3LM7JLoOnsxoq1/vXSj8PnhGmmD/DOwFG3PdcEgsozSXqW0j+xF2VsFVZAPHmuA3KpDge1lH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002281; c=relaxed/simple;
	bh=snJbCqsV6XY9dMSah5nV4HNe7AsltPmi1gNFYhBYqnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1sMmFyR+39kdxSW6kTZHSwKL+J6Oqk0ce75kCpUajDZyH87qzh1QezkcyIAeNdB65PT/z/JM5thU1aRXjDKmx8Kt5YVGXoijsKOkS+coL40NLYe3WZlXW5D6Ntoz88BlROLsdCdiZVlUnzJcDe0O7qhgYDEeP/1jW45hJ+Cnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPAQr87T; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPAQr87T"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bdb3fd39045so753391866b.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781002277; x=1781607077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8ErJ00E8PKRsdFWMxWMRo7VvS6t4bL6fzK+P8bzKpY=;
        b=aPAQr87T2/iktbPwxV0I63ZOPn6TtsDMnQPvbeGUukeD0UWTsZI8wR4rF5/DqWOajh
         ippNJN37hNg+QTOTSO1y3tcQzm9VLN4OsjdhvA33AAGgPtsDLuSNcSi6ofDxvQjzkgIV
         U2sppcj/E10R32qHjN4E0QAwOY9r1M8y6AYdYsD8X/rd7b8A5iQ9AqOUh2DY1Hv8L8gk
         kL0OADGwt5vGfO759+L29a4jIbvekseCS4X+WAJU2oO5JSgPsoaz7Un3gxslSXfOvn+f
         TgVuFgQ2deHqSOHBjUIkN28blkBlYuFxak5kKK5E3L+L9U7Z3PXNIH7PvyBhXlNYXvaN
         pBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002277; x=1781607077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8ErJ00E8PKRsdFWMxWMRo7VvS6t4bL6fzK+P8bzKpY=;
        b=oJlziOFoDwZTLpLEyg/XGlGjbppEaGaUZ+DdlmP/JiVl3NoccjsnaDQ4268uAQg2eo
         /9dPFU7iK2hyUWd6vIHdNVUZHLptLLIJydkxEHlmN/CTwpJEmnBpfbTi1Uio3fCOP5De
         DGeWO9HdJfKrN+wao6XmujK5lV0eBkdHGk3SLGQmMnIhWwSrJq1UzfYZnzESKditvWJZ
         FR3k9HzBU+lq05qWQoaFpsBR+/DYLKnVum4AgWWdAehJ1CYw+EomCE5R4Diysea54m93
         x5R6y24y363aawkqUurQdxlRdq4RldjSlqvGNIK5HpkypLseR6NizDFnX9iJqWw4LdlG
         88sA==
X-Forwarded-Encrypted: i=1; AFNElJ8YYqs0R0b6qYC7ALXjfa59eeUe7BQtnhAwE8MuYARMRjsTKWJDp2JrM/zEymbVvFMFxWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdr9tbgJdHbLOI370GK1R9LUEEk0Qorlatwdm/3wGGt0M8A5m
	n00tEH7GMiK214a5QxLkhcRcigiu4f/e9Rv5i1fC8CdI2tG93Yff1cgLFdaRfpVw
X-Gm-Gg: Acq92OEsHH4fiWaCCm6ce0AKM6QAtDzMbvZudQsFIiXhSabSH04Zt7GORp3ncHGyv0Y
	g+9qq17wV0jEHE2PWiDxPz31gAyAQlWHZztaJMsmvqg+Mq9t6xz8S/EvH5M4uhwaE7+SVBUbFES
	KRH9F0Ck16v0+mur7zYwMmhWJFw/mmI4CLnFIViSX0tFRMA7Tq9I3+Tl3nxka9jAJhwj6Lgleo0
	DIeMT7ud+Ac9Hy6W6a1l4vRgg9VqhimGJAvDYxKmb1GcLrskC4RVhkQKWL/bUCidAhdQc/KHeVA
	jJyOCfOOimZAH5GpFDF+MHzwd5vT6PGMHkWWOG+1Kr4MqDY3uGmSSSsONPfBMLXvPJIZA1kkZGE
	2KES3PC63B75BUKhxWGd64lSzDn5uKBrFEkKL241TQHbXh9JyZ/JzgaW9DcUpjilBQX4mWMnlN1
	mgNV9vfzbheOZ/ch9ZcM5+OJcoMb/7bIv6AamsfQU0GaX1wUXwJzVu+O0EvPMFUX1wpX/GOQEEz
	ivM27r0Sw0OjAROfYjVtQ==
X-Received: by 2002:a17:907:7f89:b0:bec:7ab2:9128 with SMTP id a640c23a62f3a-bf36fd9c7f4mr910584366b.8.1781002277151;
        Tue, 09 Jun 2026 03:51:17 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055500875sm1005188566b.53.2026.06.09.03.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:51:16 -0700 (PDT)
Message-ID: <1143dc72-ab34-47a0-b7dc-7a04bf6e7569@gmail.com>
Date: Tue, 9 Jun 2026 11:51:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Cancel special fields on map value
 recycle
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Justin Suess <utilityemal77@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260609093719.2858096-1-memxor@gmail.com>
 <20260609093719.2858096-3-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260609093719.2858096-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 10:37 AM, Kumar Kartikeya Dwivedi wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Map update and delete paths currently call bpf_obj_free_fields() when a
> value is being replaced or recycled. That makes field destruction depend
> on the context of the update/delete operation. For tracing programs this
> can include NMI context, where referenced kptr destructors, uptr
> unpinning, and graph root destruction are not generally safe.
> 
> Introduce bpf_obj_cancel_fields() for the reusable-value path. It only
> performs NMI-safe cleanup for timer, workqueue, and task_work fields.
> Fields that need full destruction are left attached to the recycled value
> and are destroyed by the final cleanup path instead.
> 
> Switch array and hashtab update/delete/recycle paths to this cancel
> helper. Keep bpf_obj_free_fields() for final map destruction and for
> bpf_mem_alloc destructors. Preallocated hashtabs do not have allocator
> destructors, so teardown continues to walk the normal and extra elements
> and fully destroy their fields.
> 
> This deliberately relaxes the eager-free semantics of map update/delete
> for special fields. Programs that relied on a recycled map slot becoming
> empty immediately after update/delete were relying on behavior that
> cannot be implemented safely from every BPF execution context without
> offloading arbitrary destructors.
> 
> There is a chance this change breaks programs making assumptions
> regarding the eager freeing of fields. If so, we can relax semantics to
> cancellation only when irqs_disabled() is true in the future. However,
> theoretically, map values that get reused eagerly already have weaker
> guarantees as parallel users can recreate freed fields before the new
> element becomes visible again.
> 
> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           |  1 +
>  kernel/bpf/arraymap.c                         |  8 ++---
>  kernel/bpf/hashtab.c                          | 32 +++++++++++--------
>  kernel/bpf/syscall.c                          | 27 ++++++++++++++++
>  .../selftests/bpf/prog_tests/htab_update.c    |  4 +--
>  .../selftests/bpf/prog_tests/map_kptr.c       | 10 +-----
>  .../testing/selftests/bpf/progs/htab_update.c |  4 +--
>  7 files changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d4188a992bd8..8d12aa3728ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -808,6 +808,33 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
>  	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
>  }
>  
> +void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj)

This function looks very similar to bpf_map_free_internal_structs() from helpers.c.
If I understand it correctly, it does exactly the same.

The rest of the changes in this patch make sense - we only free timers, workqueues and task works,
other special fields are kept in the element as is. So existing code will be holding
old fields for a longer time, potentially up until map is unloaded.
There is still a way for user to destroy those sticky kptrs by, for example, 
scheduling a task_work and explicitly releasing the kptr.

> +{
> +	const struct btf_field *fields;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +	fields = rec->fields;
> +	for (i = 0; i < rec->cnt; i++) {
> +		void *field_ptr = obj + fields[i].offset;
> +
> +		switch (fields[i].type) {
> +		case BPF_TIMER:
> +			bpf_timer_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_WORKQUEUE:
> +			bpf_wq_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_TASK_WORK:
> +			bpf_task_work_cancel_and_free(field_ptr);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
>  	const struct btf_field *fields;
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> index ea1a6766fbe9..0a28d4346924 100644
> --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -23,7 +23,7 @@ static void test_reenter_update(void)
>  	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
>  		return;
>  
> -	bpf_program__set_autoload(skel->progs.bpf_obj_free_fields, true);
> +	bpf_program__set_autoload(skel->progs.bpf_obj_cancel_fields, true);
>  	err = htab_update__load(skel);
>  	if (!ASSERT_TRUE(!err, "htab_update__load") || err)
>  		goto out;
> @@ -50,7 +50,7 @@ static void test_reenter_update(void)
>  	/*
>  	 * Second update: replace existing element with same key and trigger
>  	 * the reentrancy of bpf_map_update_elem().
> -	 * check_and_free_fields() calls bpf_obj_free_fields() on the old
> +	 * check_and_cancel_fields() calls bpf_obj_cancel_fields() on the old
>  	 * value, which is where fentry program runs and performs a nested
>  	 * bpf_map_update_elem(), triggering -EDEADLK.
>  	 */
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> index 03b46f17cf53..ec6f2f2e8308 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> @@ -51,7 +51,6 @@ static void test_map_kptr_success(bool test_run)
>  	ret = bpf_map__update_elem(skel->maps.array_map,
>  				   &key, sizeof(key), buf, sizeof(buf), 0);
>  	ASSERT_OK(ret, "array_map update");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
> @@ -59,49 +58,42 @@ static void test_map_kptr_success(bool test_run)
>  	ret = bpf_map__update_elem(skel->maps.pcpu_array_map,
>  				   &key, sizeof(key), pbuf, cpu * sizeof(buf), 0);
>  	ASSERT_OK(ret, "pcpu_array_map update");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.hash_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "hash_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "pcpu_hash_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.hash_malloc_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "hash_malloc_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_malloc_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "pcpu_hash_malloc_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.lru_hash_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "lru_hash_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>  
>  	ret = bpf_map__delete_elem(skel->maps.lru_pcpu_hash_map, &key, sizeof(key), 0);
>  	ASSERT_OK(ret, "lru_pcpu_hash_map delete");
> -	skel->data->ref--;
>  	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
> @@ -175,7 +167,7 @@ void serial_test_map_kptr(void)
>  		ASSERT_OK(kern_sync_rcu(), "sync rcu");
>  		wait_for_map_release();
>  
> -		/* Observe refcount dropping to 1 on synchronous delete elem */
> +		/* Observe refcount dropping to 1 on map release. */
>  		test_map_kptr_success(true);
>  	}
>  
> diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
> index 195d3b2fba00..62c1b1325ec2 100644
> --- a/tools/testing/selftests/bpf/progs/htab_update.c
> +++ b/tools/testing/selftests/bpf/progs/htab_update.c
> @@ -22,8 +22,8 @@ struct {
>  int pid = 0;
>  int update_err = 0;
>  
> -SEC("?fentry/bpf_obj_free_fields")
> -int bpf_obj_free_fields(void *ctx)
> +SEC("?fentry/bpf_obj_cancel_fields")
> +int bpf_obj_cancel_fields(void *ctx)
>  {
>  	__u32 key = 0;
>  	struct val value = { .payload = 1 };

