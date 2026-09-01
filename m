Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C788486BA2
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282636; cv=none; b=MEW05W5s1Rp1yo2oOuumq/HkpQQ3QESNjzrAWolwgwKU+M6Z9Dgx8OnCJI5AclHmAOIO1joSkEmLA95ru04NSiukGm6vqc4mUOzSvvqyscmBzpmHzsECgsRtONVVQPr3BmwCLUPM2w2KO2P5tWUs/E6nRMxggId+ZMXH2M6FgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282636; c=relaxed/simple;
	bh=1EyrdpqjQqyHh3jE/lmR28NrAqL4wgfNCNPQ9Exz81s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmvB6wlDFaiyHQp8Eo2vOJr/FbRh7CSUO0sm9qlRy/kzRhgOiox/zEBbIL+iwphayNtIIKWvY7Q3FU6ZJtak67RKxSs0oZPRnHb2FJ6ZCqmy1Y1HcAEhcYVTQkEaoZ+Y4iX3/9dp5u2QUI0GjXV0gk8CpIrnadFg2hEmgXHDgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuAOv1j3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuAOv1j3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so97195e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282632; x=1788887432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LO/tmfF2ANZjALAcTnvQI6CixtWn0Z9DWifGrRqbIBE=;
        b=JuAOv1j3A2Ei5qSmq7jygNBBv/O5nVrGad7n4lPxqHS6MOCeArBQ0n4HKnfFo4ED7u
         rcORWhDpQJ9X7oQH/jNPU9bWsz3lPDnSDqLAEJMl0/MKidgfoIFu7CgeSZ6w3SzmO9nC
         wUg5ZGPWntSWQcxMwH5DnyoPyS6bdJTu/0KaoeVtaO17crQI3Y5ocpUIEpdFQWuyBz1q
         45dogb7TKCt52OZeQMwr6RCuDvDBgi4HLkI4LV1jwSzntl/TX9SDP49idwQn0kDMFt26
         9diPeu/ALWt2llXChvwU8abClOKmfo6q4ZYGXEHKjx1LLWRJHFV5TCMWKsFpmCl/N6fK
         mcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282632; x=1788887432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LO/tmfF2ANZjALAcTnvQI6CixtWn0Z9DWifGrRqbIBE=;
        b=AS+xYIPulb3qHqj4UJowSSsqgfAlW1clAEVyyr5ZhP6HfVm6Zkq2K65Aw58IQb5vVE
         ZG0ES6Se+fV5c6UeRGpj6jzKXzc/C5h+VgwUTfXtrIASf1iATCbofPzfyZhIMllN4RPf
         qGC0f73Q21qZZEE8jVpzHXE2A6swRdswXt/0H5I8zDNeM+65GM2cijOcxHyokK9Z+avw
         NqTtIzhMVKua0Am3BWztTCQxcWfOdm4PiRRvhyxcOOqK0zt6ZMcB2h6FRUP+QwwftpwQ
         iiCWmoolaAVCVDE2Y/iuYxo5WdiDqBirCWyj5ckrImrlqBKMJ666WORRvlrZoDTOaMXd
         Zitg==
X-Forwarded-Encrypted: i=1; AHgh+RoGrShY/SceS8BnhCly8DlWirK+hhtWSJF961Idb21+zGKCV2HYF+xV5Qzb9e1z1WkZF4o=@vger.kernel.org
X-Gm-Message-State: AFuF++l5UdxTYehyNxH0VFOIz0+72AzQOwgrh2hwsEq0SQ7njIA6PHne
	g6XJbn+OewYPQb7MG2CPPDuw3jtLP1RWRgf1Xsk0pjuvOjM/Zr4tqbUM
X-Gm-Gg: AR+sD137odbvqbZXHcLdxdRPT7PkyvOhpDT0dT4H7Wlvj6oMr1wgKLP12jwFe/UjAYv
	GGwJvquYR4HsIshDSM83ymFJdTNYXeezKFR868I4fiyCb/sbVFWiaG333RItHOOj/e7ioEJsNgT
	r1eYHHZMY9oj7r9Q7YC5dhJveqbuh8PzvOYddCW9NjdSs4WCg53VOTcUlzcLEjMxZnmVk/ojKAY
	K2C55uqcc3trwRQ6HO8qc25afJXBrYihqP20rCRmJ8s50aGA/qMjymol1HLRpj6Mk5aldHYt+K7
	RfNGfpvrKhsHydpMPMxfK5TJnx1PTJ74Cb74UZh3oMjrTIgFtxrsxybNscOOAUsbOZ983iglmSs
	+hs+P1RfvubBxveUQo7vkDu23tdECq7/9dYeqgQ9JrWOzREGFdNj5IKy5of8e+QQlBC6D0s5+Mo
	2xfH/g+Nme0JxWEISqNNYhz0WBfcPsuIq7A85D5Bp6hzuuoBwnL454a/9/cY1wd1gFFrjhiu+Xq
	Wdi2TpxMpbbTnWjmYrWd+15Wg==
X-Received: by 2002:a05:600c:5288:b0:499:84fe:5f3e with SMTP id 5b1f17b1804b1-49b91c41014mr633455335e9.9.1788282632123;
        Tue, 01 Sep 2026 10:10:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:f403:a537:85fc:d569? ([2620:10d:c092:500::6:3965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4780f0dsm303135e9.12.2026.09.01.10.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 10:10:31 -0700 (PDT)
Message-ID: <ff4637bd-4919-4532-a416-fd98e2abf747@gmail.com>
Date: Tue, 1 Sep 2026 18:10:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Fix use-after-free of program BTF in
 mem-alloc destructor
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Yuan Chen <chenyuan@kylinos.cn>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
 <20260901062845.1379760-3-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260901062845.1379760-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/26 7:28 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> bpf_ma_set_dtor() duplicates the map's btf_record for the bpf_mem_alloc
> destructor. btf_record_dup() only borrows the BTF references held by
> the fields: kptrs and list_head/rb_root fields point at the program
> BTF, whose lifetime is independent of the map. The duplicated record is
> used from the deferred mem-alloc destructor workqueue, which can run
> after the program BTF is gone (bpf_map_free() drops the map's
> reference, and the RCU callback may run first). Reading the borrowed
> descriptors there is a use-after-free, detected by KASAN as
> "slab-use-after-free in btf_is_kernel".
> 
> Keep a reference on the borrowed program BTFs for the lifetime of the
> duplicated record. The record is freed from a preemptible worker, so
> the last btf_put() (which only schedules RCU destruction) does not make
> the field descriptors safe to read; snapshot the borrowed BTFs, free
> the record, then drop the references.
> 
> The rhtab kptr selftests exercise this path on every map teardown and
> triggered the bug under KASAN; with this fix they pass cleanly.

Does htab trigger the same kasan?

> 
> Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/hashtab.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index aaedda3730f3..30bcc573772e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -493,11 +493,76 @@ static void htab_pcpu_mem_dtor(void *obj, void *ctx)
>  		bpf_obj_free_fields(hrec->record, per_cpu_ptr(pptr, cpu));
>  }
>  
> +/*
> + * The duplicated record borrows program BTFs, but is freed from a deferred
> + * workqueue that may run after the program BTF is gone. Hold a reference for
> + * the record's lifetime and snapshot the borrowed BTFs, since
> + * btf_record_free() frees the record.
> + */
> +
> +/* Program BTF borrowed by the field, or NULL. */
> +static struct btf *htab_field_borrowed_btf(const struct btf_field *field)
> +{
> +	struct btf *btf = NULL;
> +
> +	switch (field->type) {
> +	case BPF_KPTR_UNREF:
> +	case BPF_KPTR_REF:
> +	case BPF_KPTR_PERCPU:
> +	case BPF_UPTR:
> +		btf = field->kptr.btf;
> +		break;
> +	case BPF_LIST_HEAD:
> +	case BPF_RB_ROOT:
> +		btf = field->graph_root.btf;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (btf && !btf_is_kernel(btf))
> +		return btf;
> +	return NULL;
> +}
> +
> +/* Snapshot the program BTFs @rec borrows into @btfs; returns their count. */
> +static int htab_record_prog_btfs_snapshot(struct btf_record *rec,
> +					  struct btf **btfs)
> +{
> +	int i, n = 0;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return 0;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		struct btf *btf = htab_field_borrowed_btf(&rec->fields[i]);
> +
> +		if (btf)
> +			btfs[n++] = btf;
> +	}
> +	return n;
> +}
> +
> +static void htab_record_prog_btf_get(struct btf_record *rec)
> +{
> +	struct btf *btfs[BTF_FIELDS_MAX];

it looks like temporary array and htab_record_prog_btfs_snapshot()
are unnecessary:

for (i = 0; i < rec->cnt; i++) {
        struct btf *btf = htab_field_borrowed_btf(&rec->fields[i]);

        if (btf)
	        btf_get(btf);
}

> +	int i, n;
> +
> +	n = htab_record_prog_btfs_snapshot(rec, btfs);
> +	for (i = 0; i < n; i++)
> +		btf_get(btfs[i]);
> +}
> +
>  static void htab_dtor_ctx_free(void *ctx)
>  {
>  	struct htab_btf_record *hrec = ctx;
> +	struct btf *btfs[BTF_FIELDS_MAX];
> +	int i, n;
>  
> +	n = htab_record_prog_btfs_snapshot(hrec->record, btfs);
>  	btf_record_free(hrec->record);
> +	for (i = 0; i < n; i++)
> +		btf_put(btfs[i]);
>  	kfree(ctx);
>  }
>  
> @@ -521,6 +586,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
>  		kfree(hrec);
>  		return err;
>  	}
> +	htab_record_prog_btf_get(hrec->record);
>  	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
>  	return 0;
>  }

