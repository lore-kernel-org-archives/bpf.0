Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8288F44
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591675; cv=none; b=KpB56PX+ih1Vnq3e0yy/CPuCyBXGU8d1L6YG+z5SCquTc88L1BvS6JClftYH5xMXnaGKHctNLYdQEjSC+EfQGc15Dm5r9GkBPPZpovMcdRJ7IIKkcfG7/pgNLtEUtT3negTnWCScqqMUhF49v+swuR3VuDJ/R65eZJglMFWJ/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591675; c=relaxed/simple;
	bh=q/lsiqsHmcSsR9c6b82fAhX5Oh1lAYYIzqxhbw8boeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAFNcLL7okv6fHQWt0L8yUkiluQmbPHnOvLs9oIeiHZVMn5+JTqO0Hyrmva/CZdN7ixQfxlPtrFSCWFOs4vtAoh6phv1CZKGjUjGwqAHzeJOdPtFrE3X9OWVNt3UbqI2G9XjDMpgsAm0Ik+1joMeupDSK+PgCDr9D1G37g5JdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ap+cm8ca; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ap+cm8ca"
Message-ID: <a2523eea-a75c-4b25-80f0-0bb2ef036759@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709591670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCi1b/dm4V9s8twJItFv7nLcDCuWHMp7K++mXnSVMW4=;
	b=ap+cm8ca1tiFtOxgoCepV4JQOCn9E47eM34iA/DccbSGj3TDx/TbraNtqjSRr9qvkcJLyQ
	YpHW5gOhMj2k5fLmhxxYvBrESDzmfEErWUo4nyIOgaYiQNdsKCWP7LEANMLCy67eYOt0Ot
	YzfLrA1rdn5cCqb4NaUJrcuFYgSQS/E=
Date: Mon, 4 Mar 2024 14:34:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240224223418.526631-1-thinker.li@gmail.com>
 <20240224223418.526631-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240224223418.526631-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/24/24 2:34 PM, Kui-Feng Lee wrote:
> +void bpf_struct_ops_tramp_buf_free(void *image)
> +{
> +	arch_free_bpf_trampoline(image, PAGE_SIZE);
> +	if (image)

Moved the "arch_free_bpf_trampoline(image, PAGE_SIZE);" after the image NULL 
test. I think it was an overlook at the bpf_dummy_struct_ops.c. The exisiting 
__bpf_struct_ops_map_free(image, PAGE_SIZE) had been testing NULL before free also.

> +		bpf_jit_uncharge_modmem(PAGE_SIZE);
> +}
> +
>   #define MAYBE_NULL_SUFFIX "__nullable"
>   #define MAX_STUB_NAME 128
>   
> @@ -461,6 +486,15 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
>   	}
>   }
>   
> +static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
> +{
> +	int i;
> +
> +	for (i = 0; i < st_map->image_pages_cnt; i++)
> +		bpf_struct_ops_tramp_buf_free(st_map->image_pages[i]);
> +	st_map->image_pages_cnt = 0;
> +}
> +
>   static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
>   {
>   	const struct btf_member *member;
> @@ -503,12 +537,21 @@ const struct bpf_link_ops bpf_struct_ops_link_lops = {
>   	.dealloc = bpf_struct_ops_link_dealloc,
>   };
>   
> +/* *image should be NULL and allow_alloc should be true if a caller wants
> + * this function to allocate a image buffer for it. Otherwise, this
> + * function allocate a new image buffer only if allow_alloc is true and the
> + * size of the trampoline is larger than the space left in the current
> + * image buffer.
> + */
>   int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>   				      struct bpf_tramp_link *link,
>   				      const struct btf_func_model *model,
> -				      void *stub_func, void *image, void *image_end)
> +				      void *stub_func,
> +				      void **_image, u32 *image_off,
> +				      bool allow_alloc)
>   {
>   	u32 flags = BPF_TRAMP_F_INDIRECT;
> +	void *image = *_image;
>   	int size;
>   
>   	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
> @@ -518,14 +561,30 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>   		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
>   
>   	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
> -	if (size < 0)
> +	if (size <= 0)
>   		return size;
> -	if (size > (unsigned long)image_end - (unsigned long)image)
> -		return -E2BIG;
> -	return arch_prepare_bpf_trampoline(NULL, image, image_end,
> +
> +	/* Allocate image buffer if necessary */
> +	if (!image || size > PAGE_SIZE - *image_off) {
> +		if (!allow_alloc)
> +			return -E2BIG;
> +
> +		image = bpf_struct_ops_tramp_buf_alloc();
> +		if (IS_ERR(image))
> +			return PTR_ERR(image);
> +		*_image = image;
> +		*image_off = 0;
> +	}
> +
> +	size = arch_prepare_bpf_trampoline(NULL, image + *image_off,
> +					   image + PAGE_SIZE,
>   					   model, flags, tlinks, stub_func);
> -}
> +	if (size > 0)
> +		*image_off += size;
> +	/* The caller should free the allocated memory even if size < 0 */

I massage the logic a little such that the caller does not need to free the new 
unused page when this function errored out. I kept both the "*_image" and 
"*image_off" param unchanged on the error case.

Applied. Thanks.

[ ... ]

> @@ -781,10 +850,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   	if (st_map->links)
>   		bpf_struct_ops_map_put_progs(st_map);
>   	bpf_map_area_free(st_map->links);
> -	if (st_map->image) {
> -		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
> -		bpf_jit_uncharge_modmem(PAGE_SIZE);
> -	}
> +	bpf_struct_ops_map_free_image(st_map);
>   	bpf_map_area_free(st_map->uvalue);
>   	bpf_map_area_free(st_map);
>   }

[ ... ]

> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 02de71719aed..da73905eff4a 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -91,6 +91,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	struct bpf_tramp_link *link = NULL;
>   	void *image = NULL;
>   	unsigned int op_idx;
> +	u32 image_off = 0;
>   	int prog_ret;
>   	s32 type_id;
>   	int err;
> @@ -114,12 +115,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		goto out;
>   	}
>   
> -	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
> -	if (!image) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -
>   	link = kzalloc(sizeof(*link), GFP_USER);
>   	if (!link) {
>   		err = -ENOMEM;
> @@ -133,7 +128,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>   						&st_ops->func_models[op_idx],
>   						&dummy_ops_test_ret_function,
> -						image, image + PAGE_SIZE);
> +						&image, &image_off,
> +						true);
>   	if (err < 0)
>   		goto out;
>   
> @@ -147,7 +143,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		err = -EFAULT;
>   out:
>   	kfree(args);
> -	arch_free_bpf_trampoline(image, PAGE_SIZE);
> +	bpf_struct_ops_tramp_buf_free(image);
>   	if (link)
>   		bpf_link_put(&link->link);
>   	kfree(tlinks);

