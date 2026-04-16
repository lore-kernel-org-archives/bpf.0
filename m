Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F725393E
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354972; cv=none; b=POa529DoVbT8mUtQuP+WuSQyzD4w5p05txXQYVTbAugZ3yUheG4sJqVtaEbpVCuEZtWtnaCl6XA8MmSwfOOX9DNABiane4PAGFXSe9ZGXJo2Su2FbZtYrAc2VwnPTBTVZg0GVSsc/28r7O1rNEK4VkMH4ledcfoAJ2iyoKdzo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354972; c=relaxed/simple;
	bh=avNqUDwNb13wdWGpLyJhBQVu+g3MUeohUPP8JqCUu6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KprMOCAazF+grVweUdJlFJWBvwGdVPzo7SZQysbIKL7hz6mL6PlIvf4HjKBGJajhP4o5sGtjKB0r73XciZMLTbApyxpLd4IAX741V2wgT0kDaA2SSd5etvT6v9OVj/HLGVm05Ifmmf5wiZW63d/0AU8QEy5ZQPzc8Wayu0eW4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym0qX38Q; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym0qX38Q"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so5337566a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354971; x=1776959771; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBLJ49byYPHKkVFUvdH5VMTRvoFH5tXyoF9E/yGBGss=;
        b=Ym0qX38QUdSUAzsSzEkXQtONWeOwHbASTcs++KKz76I1qpQSuT+vKMayrpMrfrG3Ax
         B8URnD9ZfUS/jquFxoMi3IaSKjZnNWk2TyWspU4PyqfJpydKDKnVKMb2pu5SgqEx2o5M
         CdFuHG10rlHyiIr0oHAPK2JbGrqEbEyvuHF+3nS3qaQO+Nzwygy4xCJL4Vp7kPODtyfj
         8t3LLMwB1wDL3Nn75DRXbqp4yzqJDlBJxU3yy6bvKzI30xaEtVffM1zAxKiftTd1iSQ0
         LLu1ULSyYQwRJ/kDNEQqxC4/QAJJvDOosN/pUrWh2D8EBt8v131/EUx1nIP2t1B19PoS
         LrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354971; x=1776959771;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBLJ49byYPHKkVFUvdH5VMTRvoFH5tXyoF9E/yGBGss=;
        b=AZ1CteBn7WrQ1ZcoiO+/LcsMnaFAb7p2qophP6bs91FnrhYGAFI3o/o2PGfEhXX8Te
         8Lv+EnTrhooqTxpl74n4Z5QVHEKokGGqs/ja4jLq/8/zrPjQjh9lfw1cxJCiJzzOmzM1
         QGWrhrshEG/ET0W+/IGyPNVNiWUxgbCisNVxcT3oy1SOdUSrDSg7LhJV423wbboaLhCq
         A7TtofSzerRq5bY770WgqoUfppo8cjDMzPiXu9UIfyOOnIIKscHI9heFzgbcCCXoHY5e
         EdlVFXKNHA/RpMLSGfRwbgx/Q2vBStTaVTANxTAe1xuctHqJYBo7JrZlchsHb+vsZiRF
         Cb8A==
X-Forwarded-Encrypted: i=1; AFNElJ/m1s5+4+yQu/HvLN1/QgXCu1Dg9PU43m0PtfEvUkrmipkj1MoeUT6tqPNcMiKZt+30OAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxy9Fqz0xK29uPxL9TYimOPFuObRjJIja6ksY8Ba7bzmIaMfdk
	KIEOUvpN0q9qhCaxS1mxDV1hibX6VShwbE+IZaXWabV+E9YqXf2b9YwT
X-Gm-Gg: AeBDiet0j3g+z/bYTc81fZQa2GZ+y2qeTWW0W2LWiMBYw04m+Jk144kUBkrsDoDoitI
	V68sE9uyZIpgkXsQoDn/rzb5SI57V8BuL+hlwQYkKyV6kSgN7KfD15voCs7Paj1pv3fU9KOQvsM
	Sun3XmYmvP7IPBOj/39vSaRwkwIC77fp/ls7jWluZw+xZrgs6scshnGyzDqSVlBHCt0gHS0mWBN
	DquW1cylINAaYeTjFCWu6ggnte5HrJW8hlm+hT+t7UHn2LBzO27zrGcg8qL1GcFW7nkAmT2jVwS
	DMHo/b4AYk2Idm7HGBx0jwDQmoWvLSq4vTFRaWAafcPuRj/1+afyveXtFGYKNolrQl4dfCSl4pt
	A0Pyod8rKJgZ+AZlHXHfzx01It0fcHwqhH5v598nJM2+CAkPwZhHl3XgMuC5+fqc1tY/ElIHw+D
	68QklNp9HKpV/dblYR0hewt8INzNdNygZL/PyAmC5N7S6WxZEzYwUhNsV06/iKAa/tTuF1SeL7o
	gFbMflOrIC8waVGe2njVA/zMhvdcjJPT4ri0OXi0wa4yfCGTE1WbJCO
X-Received: by 2002:a17:90b:4a45:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-3613dc55a79mr44822a91.2.1776354970610;
        Thu, 16 Apr 2026 08:56:10 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613dc72d42sm1313a91.11.2026.04.16.08.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 08:56:08 -0700
Message-Id: <DHUPA71FA3G8.JVO2WB7X5YWX@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <qmo@kernel.org>, <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/8] libbpf: Add feature for kernel extended
 vlen/kind support
X-Mailer: aerc 0.21.0
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
 <20260416143904.1220662-4-alan.maguire@oracle.com>
In-Reply-To: <20260416143904.1220662-4-alan.maguire@oracle.com>

On Thu Apr 16, 2026 at 7:38 AM PDT, Alan Maguire wrote:
> Add feature check for kernel extended vlen/kind support, and reject
> BTF that uses extended vlens/kinds if the kernel does not support
> it.  There is no reasonable path to generally sanitize such BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/features.c        | 43 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          | 17 ++++++++++++-
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  3 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..f835931f4afe 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -615,6 +615,46 @@ static int probe_kern_btf_layout(int token_fd)
>  						 (char *)layout, token_fd));
>  }
> =20
> +#define EXTEND_TYPE_LEN	((3 * sizeof(struct btf_type) + sizeof(__u32))/s=
izeof(__u32))
> +#define EXTEND_VLEN		0x10000
> +#define EXTEND_SECINFO_LEN	(EXTEND_VLEN * sizeof(struct btf_var_secinfo)=
/sizeof(__u32))
> +
> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +	static const char strs[] =3D "\0int\0foo\0bar";
> +	__u32 types[EXTEND_TYPE_LEN] =3D {
> +		/* int */
> +		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +		/* var */
> +		BTF_TYPE_ENC(5 /* "foo" */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
> +		/* datasec */
> +		BTF_TYPE_ENC(9 /* "bar" */, BTF_INFO_ENC(BTF_KIND_DATASEC, EXTEND_VLEN=
, 0), 0),
> +	};
> +	struct btf_var_secinfo *s;
> +	__u32 *types_data;
> +	__u32 i;
> +	int ret;
> +
> +	types_data =3D calloc(EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN, sizeof(__u3=
2));
> +	if (!types_data)
> +		return -ENOMEM;
> +	memcpy(types_data, types, sizeof(types));
> +
> +	for (i =3D 0, s =3D (struct btf_var_secinfo *)&types_data[EXTEND_TYPE_L=
EN];
> +	     i < EXTEND_VLEN; i++, s++) {
> +		s->type =3D 2;
> +		s->offset =3D 4 * i;
> +		s->size =3D 4;
> +	}
> +
> +	ret =3D probe_fd(libbpf__load_raw_btf((char *)types_data,
> +					    (EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN) * sizeof(__u32),
> +					    strs, sizeof(strs), token_fd));
> +	free(types_data);
> +
> +	return ret;
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
> =20
>  static struct kern_feature_cache feature_cache;
> @@ -699,6 +739,9 @@ static struct kern_feature_desc {
>  	[FEAT_BTF_LAYOUT] =3D {
>  		"kernel supports BTF layout", probe_kern_btf_layout,
>  	},
> +	[FEAT_BTF_VLEN_KIND_EXTENDED] =3D {
> +		"kernel supports extended BTF vlen/kind", probe_kern_btf_vlen_kind_ext=
ended,
> +	},
>  };
> =20
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..5f19d8ac17a9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3139,10 +3139,11 @@ static bool btf_needs_sanitization(struct bpf_obj=
ect *obj)
>  	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>  	bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DATASEC)=
;
>  	bool has_layout =3D kernel_supports(obj, FEAT_BTF_LAYOUT);
> +	bool has_vlen_kind_extended =3D kernel_supports(obj, FEAT_BTF_VLEN_KIND=
_EXTENDED);
> =20
>  	return !has_func || !has_datasec || !has_func_global || !has_float ||
>  	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_data=
sec ||
> -	       !has_layout;
> +	       !has_layout || !has_vlen_kind_extended;
>  }
> =20
>  struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*orig_btf)
> @@ -3156,6 +3157,7 @@ struct btf *bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *orig_bt
>  	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>  	bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DATASEC)=
;
>  	bool has_layout =3D kernel_supports(obj, FEAT_BTF_LAYOUT);
> +	bool has_vlen_kind_extended =3D kernel_supports(obj, FEAT_BTF_VLEN_KIND=
_EXTENDED);
>  	int enum64_placeholder_id =3D 0;
>  	const struct btf_header *hdr;
>  	struct btf *btf =3D NULL;
> @@ -3217,6 +3219,19 @@ struct btf *bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *orig_bt
>  	for (i =3D 1; i < btf__type_cnt(btf); i++) {
>  		t =3D (struct btf_type *)btf__type_by_id(btf, i);
> =20
> +		/*
> +		 * If BTF uses extended vlen/kind and kernel does not support
> +		 * it, there is nothing we can do.
> +		 */
> +		if (!has_vlen_kind_extended) {
> +			if (btf_vlen(t) > 0xffff || btf_kind(t) > 0x1f) {
> +				pr_debug("Unsupported %s for id %u\n",
> +					 btf_kind(t) > 0x1f ? "BTF kind" : "BTF vlen", i);
> +				btf__free(btf);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		}

What's the point of the patch?
Just to make libbpf error early?
It seems it can be dropped. The kernel will error if it's old.
