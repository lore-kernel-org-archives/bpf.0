Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCD314A83
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449487; cv=none; b=fwHoHzsp9KE/Xy2b30ADTibIAh25eEQjZw8st2aR8HicuR0hlzy3FgxGSB6Nl7WcHJ/CRWfbWnLcmM82e5VGnU+LRzr05mfKokzVy6S3IN4t/y9HpSBuaDfrI5MkLrtBI41phr9AzfJxC4xnDlcZ7SWo7CHewS+Zk+ckQe707u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449487; c=relaxed/simple;
	bh=QnA+5qHZJgzv3tgzyyIt8UfWetnEUQ5cHhuMFh3NI+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OM3YmfhbHKq1BLcMDZ1OfC6TkqNWXoDWWLBTYYZshcLSuk2AuTaO+u1If/0lJmVJVoKE4GteJvtxI61EPOC6hGgSGQKBCswfOuFKMKvH19qeqgMLw892tTrO3yzpgskSYJOB0vZk/BocpYxYQ7+DjyGmQbxq9iOD3zwIDoU6gts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbAEvUo/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbAEvUo/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4890098abbaso841695e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776449476; x=1777054276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDK9k3JzrEikRrM/TE53GzqRlBKicGkcXvS0/GRxI4E=;
        b=EbAEvUo/xa9AHDlDeHPzw0OXwNT10Rrna6iBcCYqlCKVe5EqJ1jb80YxGOe2wdo7T2
         DmWsBva8tybREVq5jVDvMq3ZX84HVOZC8SkPYjfwBZJFG6dPzHjPZsC8dQsasBLBBCfe
         Jjd37JRPWOQhwArtXhuGbW7kOZ8bu6PWQ2oZcg9xh7MNFccG3nzEBF1WvRFmyXslxPjY
         LvcSIY2VTFsoRRjzoSrDOz+cOeWy1xGBs1W85bBCET5FVZrlnlKeN6YbzPeuUKlRmSt8
         0XmYzz6jP6CFwYNVx8ERe6EW46b4FXFblIPE2/rB6XGJwP6wuIKu688lu7QU0/SICCRW
         UOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776449476; x=1777054276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDK9k3JzrEikRrM/TE53GzqRlBKicGkcXvS0/GRxI4E=;
        b=m5ga7l9oopbSvduR8l6B0R41tFZ2pFjyMX2OIsTIsdS+4L31MWXGM8wGyiYedCX/Gz
         kNyYBxC3rSPqPh5K9U6l2ze8pjvCg7O62JwEbyMsRfWIQ5W+SvcK4/BAXshYM+mpsOLM
         IrW7fhdHdfSPrbJ4QSzbhSjPb+0r6EH0iTGrbkkIXPpfZlOwPILaWjj/HgxGsMr74Vab
         XR990zIBVSDQPzsFGnREXfepS7UGT3/ftd74op8LEsuXpcfoTzUBJn5pwWaTyxn8o1So
         1QXgyAV5CS841lor+FNdx2KKZ3led1dnln04QNevv39voxvbFt2T6IS0CmOA76yD9RlG
         xGdw==
X-Forwarded-Encrypted: i=1; AFNElJ+MkslmfiUo8GH80uxfH5pJdSKBj8DgSKv1D1LQLDYsfX6vqcfd398mdZuMvUQGJ+NAfco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhEGa5VUTwOizl2DQKp/uzd3LESCOKR6IYTzUTyNcK+3ZtfpS
	Oo2n7g02cs7I1/+kne3gXgfzvnBCeWrMzGd864yiyphFirHVUVEm2SAX
X-Gm-Gg: AeBDietcnrjRy6YlxMIOkuAP6obkgAorLPF38uLt4cxgZjtXHEsHlaE+O2E8onClo5E
	BqfrhsutmY49PvUnnQks1lMDlIXmlNxZMJIbKt2YFaiyt5HTOjAKQrxE4SyQ3RyqfMRfoOYRFmQ
	3nrVM19SxKznn2T/lguatmlyIEZFiQ9ATr+uD5jUQLbALUxr4pmlxluCaNXVwbLFVIGPx2MsotO
	hjUHJ96TG6edpEvwSkoZ3jK8RphNqJd7e6Vtv9J/d1YZM0ho6Gtgydn1nXaWh9Vkenj6tBk6AJ8
	9k3jAx8BJkezqlriLzYalIYkDh2wRc2cBZZO8KRJ7FBiUMm7oGpqrhgp41Ytrup4f1Xyu+KgRLo
	K6RspOTHgjNtoMcb0Ee/n1htw8fbTQX2PGJTNggMjl8+X0CCmNMEZilhHWhJ2rirwOX8rGHiBDL
	MzQ3ZDDwzKrlnOShhJ1oRtoIkWe0Vm0W2f7VmCOvz8pWT+DXUL4pRoqdkKHA4qBjsnHmjuj+pdN
	pE4IZhx8fC7T4vhHtEUsw==
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488fb78ede0mr57130655e9.29.1776449476060;
        Fri, 17 Apr 2026 11:11:16 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm60163415e9.0.2026.04.17.11.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:11:15 -0700 (PDT)
Message-ID: <7e798013-d1d9-4845-98bb-ee383eb3af00@gmail.com>
Date: Fri, 17 Apr 2026 19:11:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/6] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <20260417143023.1551481-2-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417143023.1551481-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 3:30 PM, Alan Maguire wrote:
> BTF maximum vlen is encoded using 16 bits with a maximum vlen
> of 65535.  This has sufficed for structs, function parameters
> and enumerated type values.  However, with upcoming BTF location
> information - in particular information about inline sites -
> this limit is surpassed.  Use bits 16-23 - currently unused in
> BTF info - to extend to 24 bits, giving a max vlen of (2^24 - 1),
> or 16 million.
> 
> Also extend BTF kind encoding from 5 to 7 bits, giving a maximum
> available number of kinds of 128.  Since with the BTF location work
> we use another 3 kinds, we are fast approaching the current limit
> of 32.
> 
> Convert BTF_MAX_* values to enums to allow them to be encoded in
> kernel BTF; this will allow us to detect if the running kernel
> supports a 24-bit vlen or not.  Add one for max _possible_
> (not used) kind.
> 
> Fix up a few places in the kernel where a 16-bit vlen is assumed;
> remove BTF_INFO_MASK as now all bits are used.
> 
> The vlen expansion was suggested by Andrii in [1]; the kind expansion
> is tackled here too as it may be needed also to support new kinds
> in BTF.
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com/
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

It looks like all callsites of vlen have been migrated to u32 (except 
the ones that are guaranteed to work with narrower types: 
btf_func_linkage(), cs->num_params).
Extending kind from 5 to 7 bits does not require modifying users at all.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   include/linux/btf.h            |  4 ++--
>   include/uapi/linux/btf.h       | 26 ++++++++++++++------------
>   kernel/bpf/btf.c               | 27 ++++++++++-----------------
>   tools/include/uapi/linux/btf.h | 26 ++++++++++++++------------
>   4 files changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 48108471c5b1..c82d0d689059 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -415,12 +415,12 @@ static inline bool btf_type_is_array(const struct btf_type *t)
>   	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
>   }
>   
> -static inline u16 btf_type_vlen(const struct btf_type *t)
> +static inline u32 btf_type_vlen(const struct btf_type *t)
>   {
>   	return BTF_INFO_VLEN(t->info);
>   }
>   
> -static inline u16 btf_vlen(const struct btf_type *t)
> +static inline u32 btf_vlen(const struct btf_type *t)
>   {
>   	return btf_type_vlen(t);
>   }
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 638615ebddc2..618167cab4e6 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -33,20 +33,22 @@ struct btf_header {
>   	__u32	layout_len;	/* length of layout section	*/
>   };
>   
> -/* Max # of type identifier */
> -#define BTF_MAX_TYPE	0x000fffff
> -/* Max offset into the string section */
> -#define BTF_MAX_NAME_OFFSET	0x00ffffff
> -/* Max # of struct/union/enum members or func args */
> -#define BTF_MAX_VLEN	0xffff
> +enum btf_max {
> +	/* Max possible kind */
> +	BTF_MAX_KIND =		0x0000007f,
> +	/* Max # of type identifier */
> +	BTF_MAX_TYPE =		0x000fffff,
> +	/* Max offset into the string section */
> +	BTF_MAX_NAME_OFFSET =	0x00ffffff,
> +	/* Max # of struct/union/enum members or func args */
> +	BTF_MAX_VLEN =		0x00ffffff,
> +};
>   
>   struct btf_type {
>   	__u32 name_off;
>   	/* "info" bits arrangement
> -	 * bits  0-15: vlen (e.g. # of struct's members)
> -	 * bits 16-23: unused
> -	 * bits 24-28: kind (e.g. int, ptr, array...etc)
> -	 * bits 29-30: unused
> +	 * bits  0-23: vlen (e.g. # of struct's members)
> +	 * bits 24-30: kind (e.g. int, ptr, array...etc)
>   	 * bit     31: kind_flag, currently used by
>   	 *             struct, union, enum, fwd, enum64,
>   	 *             decl_tag and type_tag
> @@ -65,8 +67,8 @@ struct btf_type {
>   	};
>   };
>   
> -#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
> -#define BTF_INFO_VLEN(info)	((info) & 0xffff)
> +#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x7f)
> +#define BTF_INFO_VLEN(info)	((info) & 0xffffff)
>   #define BTF_INFO_KFLAG(info)	((info) >> 31)
>   
>   enum {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..fedead837b9a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -182,7 +182,6 @@
>   #define BITS_ROUNDUP_BYTES(bits) \
>   	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>   
> -#define BTF_INFO_MASK 0x9f00ffff
>   #define BTF_INT_MASK 0x0fffffff
>   #define BTF_TYPE_ID_VALID(type_id) ((type_id) <= BTF_MAX_TYPE)
>   #define BTF_STR_OFFSET_VALID(name_off) ((name_off) <= BTF_MAX_NAME_OFFSET)
> @@ -289,7 +288,7 @@ enum verifier_phase {
>   struct resolve_vertex {
>   	const struct btf_type *t;
>   	u32 type_id;
> -	u16 next_member;
> +	u32 next_member;
>   };
>   
>   enum visit_state {
> @@ -2031,7 +2030,7 @@ static int env_stack_push(struct btf_verifier_env *env,
>   }
>   
>   static void env_stack_set_next_member(struct btf_verifier_env *env,
> -				      u16 next_member)
> +				      u32 next_member)
>   {
>   	env->stack[env->top_stack - 1].next_member = next_member;
>   }
> @@ -3293,7 +3292,7 @@ static s32 btf_struct_check_meta(struct btf_verifier_env *env,
>   	struct btf *btf = env->btf;
>   	u32 struct_size = t->size;
>   	u32 offset;
> -	u16 i;
> +	u32 i;
>   
>   	meta_needed = btf_type_vlen(t) * sizeof(*member);
>   	if (meta_left < meta_needed) {
> @@ -3369,7 +3368,7 @@ static int btf_struct_resolve(struct btf_verifier_env *env,
>   {
>   	const struct btf_member *member;
>   	int err;
> -	u16 i;
> +	u32 i;
>   
>   	/* Before continue resolving the next_member,
>   	 * ensure the last member is indeed resolved to a
> @@ -4447,7 +4446,7 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
>   	const struct btf_enum *enums = btf_type_enum(t);
>   	struct btf *btf = env->btf;
>   	const char *fmt_str;
> -	u16 i, nr_enums;
> +	u32 i, nr_enums;
>   	u32 meta_needed;
>   
>   	nr_enums = btf_type_vlen(t);
> @@ -4555,7 +4554,7 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>   	const struct btf_enum64 *enums = btf_type_enum64(t);
>   	struct btf *btf = env->btf;
>   	const char *fmt_str;
> -	u16 i, nr_enums;
> +	u32 i, nr_enums;
>   	u32 meta_needed;
>   
>   	nr_enums = btf_type_vlen(t);
> @@ -4683,7 +4682,7 @@ static void btf_func_proto_log(struct btf_verifier_env *env,
>   			       const struct btf_type *t)
>   {
>   	const struct btf_param *args = (const struct btf_param *)(t + 1);
> -	u16 nr_args = btf_type_vlen(t), i;
> +	u32 nr_args = btf_type_vlen(t), i;
>   
>   	btf_verifier_log(env, "return=%u args=(", t->type);
>   	if (!nr_args) {
> @@ -4929,7 +4928,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
>   {
>   	const struct btf_var_secinfo *vsi;
>   	struct btf *btf = env->btf;
> -	u16 i;
> +	u32 i;
>   
>   	env->resolve_mode = RESOLVE_TBD;
>   	for_each_vsi_from(i, v->next_member, v->t, vsi) {
> @@ -5183,7 +5182,7 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
>   	const struct btf_type *ret_type;
>   	const struct btf_param *args;
>   	const struct btf *btf;
> -	u16 nr_args, i;
> +	u32 nr_args, i;
>   	int err;
>   
>   	btf = env->btf;
> @@ -5278,7 +5277,7 @@ static int btf_func_check(struct btf_verifier_env *env,
>   	const struct btf_type *proto_type;
>   	const struct btf_param *args;
>   	const struct btf *btf;
> -	u16 nr_args, i;
> +	u32 nr_args, i;
>   
>   	btf = env->btf;
>   	proto_type = btf_type_by_id(btf, t->type);
> @@ -5336,12 +5335,6 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
>   	}
>   	meta_left -= sizeof(*t);
>   
> -	if (t->info & ~BTF_INFO_MASK) {
> -		btf_verifier_log(env, "[%u] Invalid btf_info:%x",
> -				 env->log_type_id, t->info);
> -		return -EINVAL;
> -	}
> -
>   	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
>   	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
>   		btf_verifier_log(env, "[%u] Invalid kind:%u",
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 638615ebddc2..618167cab4e6 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -33,20 +33,22 @@ struct btf_header {
>   	__u32	layout_len;	/* length of layout section	*/
>   };
>   
> -/* Max # of type identifier */
> -#define BTF_MAX_TYPE	0x000fffff
> -/* Max offset into the string section */
> -#define BTF_MAX_NAME_OFFSET	0x00ffffff
> -/* Max # of struct/union/enum members or func args */
> -#define BTF_MAX_VLEN	0xffff
> +enum btf_max {
> +	/* Max possible kind */
> +	BTF_MAX_KIND =		0x0000007f,
> +	/* Max # of type identifier */
> +	BTF_MAX_TYPE =		0x000fffff,
> +	/* Max offset into the string section */
> +	BTF_MAX_NAME_OFFSET =	0x00ffffff,
> +	/* Max # of struct/union/enum members or func args */
> +	BTF_MAX_VLEN =		0x00ffffff,
> +};
>   
>   struct btf_type {
>   	__u32 name_off;
>   	/* "info" bits arrangement
> -	 * bits  0-15: vlen (e.g. # of struct's members)
> -	 * bits 16-23: unused
> -	 * bits 24-28: kind (e.g. int, ptr, array...etc)
> -	 * bits 29-30: unused
> +	 * bits  0-23: vlen (e.g. # of struct's members)
> +	 * bits 24-30: kind (e.g. int, ptr, array...etc)
>   	 * bit     31: kind_flag, currently used by
>   	 *             struct, union, enum, fwd, enum64,
>   	 *             decl_tag and type_tag
> @@ -65,8 +67,8 @@ struct btf_type {
>   	};
>   };
>   
> -#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
> -#define BTF_INFO_VLEN(info)	((info) & 0xffff)
> +#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x7f)
> +#define BTF_INFO_VLEN(info)	((info) & 0xffffff)
>   #define BTF_INFO_KFLAG(info)	((info) >> 31)
>   
>   enum {

