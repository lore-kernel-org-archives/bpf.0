Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F381363095
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450995; cv=none; b=Bpv7A/8fhW/WISFCSVEUv6SQOtJ3HtbvyrVjrM6No42xG1JXKDCZxkNQONquvuvRVtPqqKGpP/yPvlVVuKspLW1JVx6Bcmla64MBDg4MCihaap0Iy3bDNvv0+ApwZsTe2wZ3aCIKGjuChnMM4nBwSxpf2+ofRcSc/2W8cs1r4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450995; c=relaxed/simple;
	bh=nUBDYLzZaW4p0B2ZFjD+V5dVTauUWeXwCeIunREtbP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8q4jaozCl9nZSBUGfseQqq4Q+7RzDjJ6FOLtFrj04K2pmZVL2oMSJjPxnuF38GpZETHIhoez1ceIcygOP2BoCzJAnfAEEY+rI1HgHc/Rntxe6GSS6klhvBZkcKKrvtHlgxO6Qz7eDd1AbpjIr9bNY7IO/CQHFlamEaQvxcapVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOhO3PW7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOhO3PW7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso9674915e9.3
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776450990; x=1777055790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxyygLf7so+BFh+zGgkdtjhm0tPEJBMXuamZ1cDp5RI=;
        b=HOhO3PW7QJPETeUJxQ4K0Pn/Sb/kBfyNZdU1U+E6v5F/D4l1n4rbus+qZYvi+F9Tfi
         GR4V65jMn7Esz0HzWgNqcfIfoN5WMPZHnhfm2JDD0QzQgz0KGYVi8yX7brxA9qx/oi02
         pdfKBJ6xBTXz7PYgQqxxUOyNZh9VWVZd2jcluivRrVRKSPnvBiTEXytjLtDde6mCkcX6
         Ym5zaulLb8GrW9p3jbMjuCDXrXm5EC4HJSQX+IeNnmcYbGGVLWiQZT8zBQuOT9gZfuab
         8sAucJCh0JwPMDN0q42U3yAS/2LM5PxwBIjtWwgGW4gtmfUYbmRJxGANzJ8FIq1SoHGO
         nlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776450990; x=1777055790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxyygLf7so+BFh+zGgkdtjhm0tPEJBMXuamZ1cDp5RI=;
        b=B0IBrIE+r6ARLqPfQ712UOCozzHtRDqFfzUUMsor1nyHmzpcoA/7KISjJuMKMAv3hf
         WRBXTGYI4Y98lGEqFGwcAi4zZ1L4HHHi2EmxO5wSK11/4ncYF+1ZdEc+FU/qMFVEwIN4
         qoCyyxZMH/GomQ1e21Uc4S964nPQLs/590PdzlLFVeAbDA/6VALFnRNzXW5NdgEYIx4K
         azoUTSDAKYx4A42xiBaJbYy9F4lNngiF+cd2XH6H0vsuVd8ZzoDTSd2vBYD+dJmVQLkK
         S/nVUBHISlGpkAKC/QwscIIDku8ox2+6qW6Y+fqVkcVoTrFeM+izq0o74rDBWfacxLCp
         n4NA==
X-Forwarded-Encrypted: i=1; AFNElJ8xKhhvKsVl4nZV87WgZ8oqVVzEO62AOCR0+LZrsHGFYwsC2QQEqT6djYi1P0q/4AJRgxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrk/i20ZXKDjIJxCD5OceI2sT427oSiTRLGsCJJcXFJWkGbata
	UW00mK5NvyGxuZMDn/C2cb0rIOEmgX+8LcIO4Zyh+6i1DEbdKApvsXb5
X-Gm-Gg: AeBDievG3EkZZCxVJwwX4Ozbhl0EX79SNhp+KIqXX6D41lrlFbeV2/zAehPlEdGR47O
	r02nkNzysQAClqRuGtfbuSi5WTFdHBohIcPzPQzhC71zukrn8t23JGHP+6DG180x992HTTfQYSm
	fJdV9T52Ta+THnMGpXB4VPBEXeW7RuupxYFHdGMGFV1U/3XsnBXO99EH/O2Hbfo8pHZ7wnGffee
	uXratnMXa78FgV7rAI1iT943ycVFkxWe8bw1rFzSsoidCbZ4VkPpMRqfas51tCONp1VtynSilEG
	JuufPlQU6IaZUCfOSu/13JmMVrS3EY32BwMA4CC/ehYZF3zz0EZd3MaXGciTeOFWQGTKqhThl5p
	SDajcXhfmIQe02mWqI/WwKGJVMbN046Qo5Kah0lH29X2MtWZ5i608BiC3PVvUF/80mRZqVWP9lX
	IwJIDhYdAYv8n2YvgW/1tHEgVeU36oj/laI2zhZZWceKsP3TQIbxq7p0spJzg/a3mSAmbCmb0Aw
	dFo6UQc62CdtzWEKTaFFw==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488fb78ee4emr55431905e9.25.1776450990290;
        Fri, 17 Apr 2026 11:36:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm67662425e9.4.2026.04.17.11.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:36:29 -0700 (PDT)
Message-ID: <91343a7a-4820-49fc-9ed0-5638ea74e203@gmail.com>
Date: Fri, 17 Apr 2026 19:36:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 3/6] bpftool: Support 24-bit vlen
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <20260417143023.1551481-4-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417143023.1551481-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 3:30 PM, Alan Maguire wrote:
> Adjust btf_vlen() usage to handle 24-bit vlen.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   tools/bpf/bpftool/btf.c        | 17 ++++++-----------
>   tools/bpf/bpftool/btf_dumper.c |  4 ++--
>   tools/bpf/bpftool/gen.c        | 16 +++++++++-------
>   3 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 2e899e940034..6ef908adf3a4 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -179,8 +179,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   	case BTF_KIND_STRUCT:
>   	case BTF_KIND_UNION: {
>   		const struct btf_member *m = (const void *)(t + 1);
> -		__u16 vlen = BTF_INFO_VLEN(t->info);
> -		int i;
> +		__u32 i, vlen = BTF_INFO_VLEN(t->info);
>   
>   		if (json_output) {
>   			jsonw_uint_field(w, "size", t->size);
> @@ -225,9 +224,8 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   	}
>   	case BTF_KIND_ENUM: {
>   		const struct btf_enum *v = (const void *)(t + 1);
> -		__u16 vlen = BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen = BTF_INFO_VLEN(t->info);
>   		const char *encoding;
> -		int i;
>   
>   		encoding = btf_kflag(t) ? "SIGNED" : "UNSIGNED";
>   		if (json_output) {
> @@ -263,9 +261,8 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   	}
>   	case BTF_KIND_ENUM64: {
>   		const struct btf_enum64 *v = btf_enum64(t);
> -		__u16 vlen = btf_vlen(t);
> +		__u32 i, vlen = btf_vlen(t);
>   		const char *encoding;
> -		int i;
>   
>   		encoding = btf_kflag(t) ? "SIGNED" : "UNSIGNED";
>   		if (json_output) {
> @@ -325,8 +322,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   	}
>   	case BTF_KIND_FUNC_PROTO: {
>   		const struct btf_param *p = (const void *)(t + 1);
> -		__u16 vlen = BTF_INFO_VLEN(t->info);
> -		int i;
> +		__u32 i, vlen = BTF_INFO_VLEN(t->info);
>   
>   		if (json_output) {
>   			jsonw_uint_field(w, "ret_type_id", t->type);
> @@ -369,8 +365,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   	case BTF_KIND_DATASEC: {
>   		const struct btf_var_secinfo *v = (const void *)(t + 1);
>   		const struct btf_type *vt;
> -		__u16 vlen = BTF_INFO_VLEN(t->info);
> -		int i;
> +		__u32 i, vlen = BTF_INFO_VLEN(t->info);
>   
>   		if (json_output) {
>   			jsonw_uint_field(w, "size", t->size);
> @@ -675,7 +670,7 @@ static __u64 btf_name_hasher(__u64 hash, const struct btf *btf, __u32 name_off)
>   static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 id, bool include_members)
>   {
>   	const struct btf_type *t = btf__type_by_id(btf, id);
> -	int i;
> +	__u32 i;

in libbpf, kernel and btf_dumper.c we did not migrate those callsites 
that use int for vlen, but we do it here. Not an issue, of course, 
either way it's correct.

>   	size_t hash = 0;
>   
>   	hash = btf_name_hasher(hash, btf, t->name_off);
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index def297e879f4..9dc8425b1789 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -150,7 +150,7 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>   {
>   	const struct btf_enum *enums = btf_enum(t);
>   	__s64 value;
> -	__u16 i;
> +	__u32 i;
>   
>   	switch (t->size) {
>   	case 8:
> @@ -189,7 +189,7 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
>   	const struct btf_enum64 *enums = btf_enum64(t);
>   	__u32 val_lo32, val_hi32;
>   	__u64 value;
> -	__u16 i;
> +	__u32 i;
>   
>   	value = *(__u64 *)data;
>   	val_lo32 = (__u32)value;
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 2f9e10752e28..37159e02f418 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -2094,7 +2094,8 @@ btfgen_mark_type(struct btfgen_info *info, unsigned int type_id, bool follow_poi
>   	struct btf_type *cloned_type;
>   	struct btf_param *param;
>   	struct btf_array *array;
> -	int err, i;
> +	__u32 i;
> +	int err;
>   
>   	if (type_id == 0)
>   		return 0;
> @@ -2229,7 +2230,8 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
>   	const struct btf_type *btf_type;
>   	struct btf *btf = info->src_btf;
>   	struct btf_type *cloned_type;
> -	int i, err;
> +	int err;
> +	__u32 i;
>   
>   	if (type_id == 0)
>   		return 0;
> @@ -2249,7 +2251,7 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
>   	case BTF_KIND_STRUCT:
>   	case BTF_KIND_UNION: {
>   		struct btf_member *m = btf_members(btf_type);
> -		__u16 vlen = btf_vlen(btf_type);
> +		__u32 vlen = btf_vlen(btf_type);
>   
>   		if (behind_ptr)
>   			break;
> @@ -2286,7 +2288,7 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
>   		break;
>   	}
>   	case BTF_KIND_FUNC_PROTO: {
> -		__u16 vlen = btf_vlen(btf_type);
> +		__u32 vlen = btf_vlen(btf_type);
>   		struct btf_param *param;
>   
>   		/* mark ret type */
> @@ -2492,8 +2494,9 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>   {
>   	struct btf *btf_new = NULL;
>   	unsigned int *ids = NULL;
> -	unsigned int i, n = btf__type_cnt(info->marked_btf);
> +	unsigned int n = btf__type_cnt(info->marked_btf);
>   	int err = 0;
> +	__u32 i;
>   
>   	btf_new = btf__new_empty();
>   	if (!btf_new) {
> @@ -2523,8 +2526,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>   		/* add members for struct and union */
>   		if (btf_is_composite(type)) {
>   			struct btf_member *cloned_m, *m;
> -			unsigned short vlen;
> -			int idx_src;
> +			__u32 vlen, idx_src;
>   
>   			name = btf__str_by_offset(info->src_btf, type->name_off);
>   

