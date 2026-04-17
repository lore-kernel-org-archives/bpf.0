Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A62C9D
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450394; cv=none; b=Ly+cT+O54Q2z/0MQvuHRmOJQ1lsyCz9UDBC6FOhxWPWJ2anKFBwifGAdvbYYR5ppnw+kXl9FRF2xrwJV3RpboMA49YvIvFDMkN7RKE0MSIDk2rThgiLO/LIkJy+3bYRQSExa6XrvMP6P5QqaUeC8T3MzoOBbEDcIkBvIYiZmgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450394; c=relaxed/simple;
	bh=vOJpyjUqWSALPfn3quhXJh+G4IQNnpEwc+DeX4p5dT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxPu5vfaNafl1D1eTGnCNl8p1Um1eArmAzvbzeilEabyOKtudsMhrjaTnn1TsEwRNCAznFnvvlEz3mkG1P4VWfUCBLW5BwnoiQEUIZeYJBrmTReng6OEOP37dzgxoDwgYaPAfc2CPQOfpd7JUzuUfGwYFV3fxzaPp3toc7B79xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1LXQNN3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1LXQNN3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfbd17589so743122f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776450391; x=1777055191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4PyN2snt1SUaD7rr9j7JcGyfDxSKQ3kl+V9lXEc8sA=;
        b=X1LXQNN3cOxy4N+ZNkbzYy5v7BSrnuOF30dk00TYCy96ADaxrR1HtJ6ANy75pXxKxD
         NaCZAK0MAkCtFquSoPz9rvN3V8MR8YquiRGd6VB/rq/bPrPxSkfMGOU1P2smyxidHoQV
         CJufUq+co471BcAEyxFO9rG9RcjSlwN8nnFu1LoTr/obXWiWytliKrcen3yES8CAhPH4
         3tq3yEf3fp1enaXP46u0MDVOwmURPUS8hoB0wtmsObK2ufDZTBlj4kUj5mP4WnGUJ1S/
         2HgbFGW9AyoiZsh2Q9Q/lsassQ7rS18cXcTt/DLxvsYF301ocihzvEHTQlFpghIIm39s
         xiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776450391; x=1777055191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4PyN2snt1SUaD7rr9j7JcGyfDxSKQ3kl+V9lXEc8sA=;
        b=didxJR6a+BJbLeyn5t8EoTsezUXnxEJKtkRBS8v+4hmGZ71Un63CIQdO3pEXpaCtx1
         Vw9rs6MHCeEB0oWVnXAZ+pmqux0bOq9WMREPpc5wICWTap9niwcvbnvWAn2Y14C1Fx/X
         NvmMJrMTAEpWZAhrgEwc1Kk4nkEsIkER/fWUs8tsUqK3v2IebIOgqKpAuG/j6adPjNIz
         76wlwoH6r7p2x2zrADykp7pUnGrZ79zwf4qB7akYo6SdSRWHHcewGaIiz+yYQbT3+aFe
         2awgh2m1mGpaPpv4bSQqHVq//Sh6aQn023FYecyTxKUkuY9qn4YLcenLk2sHgSfrPYJh
         QDnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oAl8/f0Y1SYst+VD1+KEClK8ZvakVapfqyl9Kt0ZtNPKGuaShQnu7u/afY1y9pe0eY88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHKn7ZmHSmhSGUF9gnCI5TVT66dUKkTYF6k+DKUzJGDzRb94O
	4Y/V62oA5cBMeBjdKcQtHL/KW3k7zIsfD+TcnFD2pLjBwo65MIbr6gcXMr/UCpdU
X-Gm-Gg: AeBDietp6BmIAETua8BUseM6Zow4scJJz8UB5nur2TRueCYM7CtpUv1FHLlkTy15B8t
	7zAq+5aAw5InItpuEwYFDnbz1iu1bl+bPGbVwFU6KBEMMCK5OKcgpvKERcV9bE7eRc+E7NFgk8a
	KmWYgzKibCZZFCQj4OA8FxfGVVLKnS8yR7C4nKdoKHdMnNY/ZOz5Ja7kIDl+5aWsXR9z1qx4U36
	8KXQDE5Do95elr6AMXnEJWr70YQ8QIdKEQIHmOAJpHrGOjilJY/iD87MKwjoILDDLxGcJTMrXzJ
	U4R4d4xwjxCnBjOaJ/qfL0Xun5aDBZMUusnlTGVVyK6SKgda4nCqnpZb8YiqDz+wA28R/ha9vD8
	GoxNDUYm3Rq8Yfkwo2LV9BhLN1XyVdoE+H3gM712YYcAl1EFp6RPMYMc9ra11CxPyc9ooZ/GPH0
	D3kOxF2B0z/3iXkKncFztug+W3Bp66wtOlndL7/fAQm6AHr/pmBcCkz+bmQTuYiyjMhcwybm33M
	c+3vghMlfiNR1+DCLPKFLk6de9O5C8R
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-488fb6e8eb5mr57631085e9.0.1776450390508;
        Fri, 17 Apr 2026 11:26:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc13938fsm94390515e9.10.2026.04.17.11.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:26:30 -0700 (PDT)
Message-ID: <a32e74cd-d89c-4de0-87bd-ddb272debf4f@gmail.com>
Date: Fri, 17 Apr 2026 19:26:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <20260417143023.1551481-3-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417143023.1551481-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 3:30 PM, Alan Maguire wrote:
> Now that vlen is 24 bits, btf_vlen() must return a __u32.
> Adjust use cases in libbpf accordingly.  Also add error
> handling to avoid vlen overflow in btf_type_inc_vlen().
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Migrated all vlens in libbpf u16 -> u32, kind does not require widening.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   tools/lib/bpf/btf.c       | 50 +++++++++++++++++++++++++--------------
>   tools/lib/bpf/btf.h       |  2 +-
>   tools/lib/bpf/btf_dump.c  | 24 +++++++++----------
>   tools/lib/bpf/relo_core.c | 16 ++++++-------
>   4 files changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..267904939098 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -421,7 +421,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
>   {
>   	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
>   	struct btf_layout *l = btf->layout;
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   	__u32 kind = btf_kind(t);
>   
>   	/* Fall back to base BTF if needed as they share layout information */
> @@ -454,7 +454,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
>   static int btf_type_size(const struct btf *btf, const struct btf_type *t)
>   {
>   	const int base_size = sizeof(struct btf_type);
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   
>   	switch (btf_kind(t)) {
>   	case BTF_KIND_FWD:
> @@ -506,7 +506,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>   	struct btf_array *a;
>   	struct btf_param *p;
>   	struct btf_enum *e;
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   	int i;
>   
>   	switch (btf_kind(t)) {
> @@ -1007,7 +1007,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>   	case BTF_KIND_STRUCT:
>   	case BTF_KIND_UNION: {
>   		const struct btf_member *m = btf_members(t);
> -		__u16 vlen = btf_vlen(t);
> +		__u32 vlen = btf_vlen(t);
>   		int i, max_align = 1, align;
>   
>   		for (i = 0; i < vlen; i++, m++) {
> @@ -2121,9 +2121,12 @@ static void *btf_add_type_mem(struct btf *btf, size_t add_sz)
>   			      btf->hdr.type_len, UINT_MAX, add_sz);
>   }
>   
> -static void btf_type_inc_vlen(struct btf_type *t)
> +static int btf_type_inc_vlen(struct btf_type *t)
>   {
> +	if (btf_vlen(t) == BTF_MAX_VLEN)
> +		return -ENOSPC;
>   	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
> +	return 0;
>   }
>   
>   static void btf_hdr_update_type_len(struct btf *btf, int new_len)
> @@ -2652,6 +2655,8 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
>   	t = btf_last_type(btf);
>   	if (!btf_is_composite(t))
>   		return libbpf_err(-EINVAL);
> +	if (btf_vlen(t) == BTF_MAX_VLEN)
> +		return libbpf_err(-ENOSPC);
>   
>   	if (validate_type_id(type_id))
>   		return libbpf_err(-EINVAL);
> @@ -2686,6 +2691,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
>   
>   	/* btf_add_type_mem can invalidate t pointer */
>   	t = btf_last_type(btf);
> +
>   	/* update parent type's vlen and kflag */
>   	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, is_bitfield || btf_kflag(t));
>   
> @@ -2796,7 +2802,9 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
>   
>   	/* update parent type's vlen */
>   	t = btf_last_type(btf);
> -	btf_type_inc_vlen(t);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
>   
>   	/* if negative value, set signedness to signed */
>   	if (value < 0)
> @@ -2873,7 +2881,9 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
>   
>   	/* update parent type's vlen */
>   	t = btf_last_type(btf);
> -	btf_type_inc_vlen(t);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
>   
>   	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
>   	return 0;
> @@ -3115,7 +3125,9 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
>   
>   	/* update parent type's vlen */
>   	t = btf_last_type(btf);
> -	btf_type_inc_vlen(t);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
>   
>   	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
>   	return 0;
> @@ -3257,7 +3269,9 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>   
>   	/* update parent type's vlen */
>   	t = btf_last_type(btf);
> -	btf_type_inc_vlen(t);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
>   
>   	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
>   	return 0;
> @@ -4311,7 +4325,7 @@ static long btf_hash_enum(struct btf_type *t)
>   static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
>   {
>   	const struct btf_enum *m1, *m2;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int i;
>   
>   	vlen = btf_vlen(t1);
> @@ -4329,7 +4343,7 @@ static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
>   static bool btf_equal_enum64_members(struct btf_type *t1, struct btf_type *t2)
>   {
>   	const struct btf_enum64 *m1, *m2;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int i;
>   
>   	vlen = btf_vlen(t1);
> @@ -4406,7 +4420,7 @@ static long btf_hash_struct(struct btf_type *t)
>   static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
>   {
>   	const struct btf_member *m1, *m2;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int i;
>   
>   	if (!btf_equal_common(t1, t2))
> @@ -4482,7 +4496,7 @@ static bool btf_compat_array(struct btf_type *t1, struct btf_type *t2)
>   static long btf_hash_fnproto(struct btf_type *t)
>   {
>   	const struct btf_param *member = btf_params(t);
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   	long h = btf_hash_common(t);
>   	int i;
>   
> @@ -4504,7 +4518,7 @@ static long btf_hash_fnproto(struct btf_type *t)
>   static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
>   {
>   	const struct btf_param *m1, *m2;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int i;
>   
>   	if (!btf_equal_common(t1, t2))
> @@ -4530,7 +4544,7 @@ static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
>   static bool btf_compat_fnproto(struct btf_type *t1, struct btf_type *t2)
>   {
>   	const struct btf_param *m1, *m2;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int i;
>   
>   	/* skip return type ID */
> @@ -5077,7 +5091,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>   	case BTF_KIND_STRUCT:
>   	case BTF_KIND_UNION: {
>   		const struct btf_member *cand_m, *canon_m;
> -		__u16 vlen;
> +		__u32 vlen;
>   
>   		if (!btf_shallow_equal_struct(cand_type, canon_type))
>   			return 0;
> @@ -5105,7 +5119,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>   
>   	case BTF_KIND_FUNC_PROTO: {
>   		const struct btf_param *cand_p, *canon_p;
> -		__u16 vlen;
> +		__u32 vlen;
>   
>   		if (!btf_compat_fnproto(cand_type, canon_type))
>   			return 0;
> @@ -5439,7 +5453,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
>   
>   	case BTF_KIND_FUNC_PROTO: {
>   		struct btf_param *param;
> -		__u16 vlen;
> +		__u32 vlen;
>   		int i;
>   
>   		ref_type_id = btf_dedup_ref_type(d, t->type);
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index a1f8deca2603..1a31f2da947f 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -435,7 +435,7 @@ static inline __u16 btf_kind(const struct btf_type *t)
>   	return BTF_INFO_KIND(t->info);
>   }
>   
> -static inline __u16 btf_vlen(const struct btf_type *t)
> +static inline __u32 btf_vlen(const struct btf_type *t)
>   {
>   	return BTF_INFO_VLEN(t->info);
>   }
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 53c6624161d7..cc1ba65bb6c5 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -316,7 +316,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
>   {
>   	int i, j, n = btf__type_cnt(d->btf);
>   	const struct btf_type *t;
> -	__u16 vlen;
> +	__u32 vlen;
>   
>   	for (i = d->last_id + 1; i < n; i++) {
>   		t = btf__type_by_id(d->btf, i);
> @@ -485,7 +485,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
>   	 */
>   	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
>   	const struct btf_type *t;
> -	__u16 vlen;
> +	__u32 vlen;
>   	int err, i;
>   
>   	/* return true, letting typedefs know that it's ok to be emitted */
> @@ -798,7 +798,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
>   		 */
>   		if (top_level_def || t->name_off == 0) {
>   			const struct btf_member *m = btf_members(t);
> -			__u16 vlen = btf_vlen(t);
> +			__u32 vlen = btf_vlen(t);
>   			int i, new_cont_id;
>   
>   			new_cont_id = t->name_off == 0 ? cont_id : id;
> @@ -820,7 +820,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
>   		break;
>   	case BTF_KIND_FUNC_PROTO: {
>   		const struct btf_param *p = btf_params(t);
> -		__u16 n = btf_vlen(t);
> +		__u32 n = btf_vlen(t);
>   		int i;
>   
>   		btf_dump_emit_type(d, t->type, cont_id);
> @@ -839,7 +839,7 @@ static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
>   {
>   	const struct btf_member *m;
>   	int max_align = 1, align, i, bit_sz;
> -	__u16 vlen;
> +	__u32 vlen;
>   
>   	m = btf_members(t);
>   	vlen = btf_vlen(t);
> @@ -973,7 +973,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>   	bool is_struct = btf_is_struct(t);
>   	bool packed, prev_bitfield = false;
>   	int align, i, off = 0;
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   
>   	align = btf__align_of(d->btf, id);
>   	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
> @@ -1064,7 +1064,7 @@ static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
>   
>   static void btf_dump_emit_enum32_val(struct btf_dump *d,
>   				     const struct btf_type *t,
> -				     int lvl, __u16 vlen)
> +				     int lvl, __u32 vlen)
>   {
>   	const struct btf_enum *v = btf_enum(t);
>   	bool is_signed = btf_kflag(t);
> @@ -1089,7 +1089,7 @@ static void btf_dump_emit_enum32_val(struct btf_dump *d,
>   
>   static void btf_dump_emit_enum64_val(struct btf_dump *d,
>   				     const struct btf_type *t,
> -				     int lvl, __u16 vlen)
> +				     int lvl, __u32 vlen)
>   {
>   	const struct btf_enum64 *v = btf_enum64(t);
>   	bool is_signed = btf_kflag(t);
> @@ -1122,7 +1122,7 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>   				   const struct btf_type *t,
>   				   int lvl)
>   {
> -	__u16 vlen = btf_vlen(t);
> +	__u32 vlen = btf_vlen(t);
>   
>   	btf_dump_printf(d, "enum%s%s",
>   			t->name_off ? " " : "",
> @@ -1542,7 +1542,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>   		}
>   		case BTF_KIND_FUNC_PROTO: {
>   			const struct btf_param *p = btf_params(t);
> -			__u16 vlen = btf_vlen(t);
> +			__u32 vlen = btf_vlen(t);
>   			int i;
>   
>   			/*
> @@ -2159,7 +2159,7 @@ static int btf_dump_struct_data(struct btf_dump *d,
>   				const void *data)
>   {
>   	const struct btf_member *m = btf_members(t);
> -	__u16 n = btf_vlen(t);
> +	__u32 n = btf_vlen(t);
>   	int i, err = 0;
>   
>   	/* note that we increment depth before calling btf_dump_print() below;
> @@ -2449,7 +2449,7 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
>   	case BTF_KIND_STRUCT:
>   	case BTF_KIND_UNION: {
>   		const struct btf_member *m = btf_members(t);
> -		__u16 n = btf_vlen(t);
> +		__u32 n = btf_vlen(t);
>   
>   		/* if any struct/union member is non-zero, the struct/union
>   		 * is considered non-zero and dumped.
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 0ccc8f548cba..6ae3f2a15ad0 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -191,8 +191,8 @@ int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>   	case BTF_KIND_FUNC_PROTO: {
>   		struct btf_param *local_p = btf_params(local_type);
>   		struct btf_param *targ_p = btf_params(targ_type);
> -		__u16 local_vlen = btf_vlen(local_type);
> -		__u16 targ_vlen = btf_vlen(targ_type);
> +		__u32 local_vlen = btf_vlen(local_type);
> +		__u32 targ_vlen = btf_vlen(targ_type);
>   		int i, err;
>   
>   		if (local_vlen != targ_vlen)
> @@ -1457,8 +1457,8 @@ static bool bpf_core_names_match(const struct btf *local_btf, size_t local_name_
>   static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
>   				const struct btf *targ_btf, const struct btf_type *targ_t)
>   {
> -	__u16 local_vlen = btf_vlen(local_t);
> -	__u16 targ_vlen = btf_vlen(targ_t);
> +	__u32 local_vlen = btf_vlen(local_t);
> +	__u32 targ_vlen = btf_vlen(targ_t);
>   	int i, j;
>   
>   	if (local_t->size != targ_t->size)
> @@ -1498,8 +1498,8 @@ static int bpf_core_composites_match(const struct btf *local_btf, const struct b
>   				     bool behind_ptr, int level)
>   {
>   	const struct btf_member *local_m = btf_members(local_t);
> -	__u16 local_vlen = btf_vlen(local_t);
> -	__u16 targ_vlen = btf_vlen(targ_t);
> +	__u32 local_vlen = btf_vlen(local_t);
> +	__u32 targ_vlen = btf_vlen(targ_t);
>   	int i, j, err;
>   
>   	if (local_vlen > targ_vlen)
> @@ -1674,8 +1674,8 @@ int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const st
>   	case BTF_KIND_FUNC_PROTO: {
>   		struct btf_param *local_p = btf_params(local_t);
>   		struct btf_param *targ_p = btf_params(targ_t);
> -		__u16 local_vlen = btf_vlen(local_t);
> -		__u16 targ_vlen = btf_vlen(targ_t);
> +		__u32 local_vlen = btf_vlen(local_t);
> +		__u32 targ_vlen = btf_vlen(targ_t);
>   		int i, err;
>   
>   		if (local_k != targ_k)

