Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA838D6A2
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079503; cv=none; b=R3iRDS5BPL270vWpgDeOk+tgvBXIr2yn4KM8d/Vo8ijF0tkemLmkA60DnQnvk+HcRKkNzEikOVIsupvmEPtMrwxXHf2zNT9HTiuF7dK0yiVRUGRaQfAbhpjajPcnqm2+LfI1vnwYQB11KIIIZcgaMYTG2GTrUgzPVzZpRMAe8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079503; c=relaxed/simple;
	bh=rORPvjP8gvreriX65aIm4e1aTM5uMIhGYlStD83GdaU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=iJU/VLJwHmvP0DPBJ2D5/mAGk7Zqt1Irnwnx63Ng9eWjujvEcvuH2ZU+++PewPHKnifs9JeZGmCCvEeaBqHuMObYMJgpOukfx0T50Co02U+8FSSHA3PIom8VZu9bmN4NhXJGzeRtQZvSl6lmdDY7hVML7AjLRWeftHirtxgxHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvpCt3pq; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvpCt3pq"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b613a17bso63175485e9.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079497; x=1781684297; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74MoGD/NWRaqE58OxICPjJay3SrK/7VuiZbI8nsLHPc=;
        b=PvpCt3pq75U1M2Eo40fbWp1Z6LBnxDPRfW3M6PlnaJufWHySDc0tHJigjM+GskEq75
         +6w79Cov6hOyLoXfpq2ewhDblmw3jHNJYJz243ag1CITFsOL42Pv+zAoWlDsXBGDHdiH
         SNjspx+dBcphWIV/5WOT1yUAsUgymX9fxFA9qQtaCIjwbIkQ0sn9BnQWNbS1hNjpToQf
         iz6ProtJZFcEU9ptREbimKEsFgZK/ZoONo7f8RuswOmEeDRuN6Vl8g1DDsTUCM5YKmem
         na9uA9Ht/FMFyd6OkFN/OjvdnduGFxKTODJutLYDJKqFNAKUBUyat/ml9so2p3UPF+T7
         mJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079497; x=1781684297;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74MoGD/NWRaqE58OxICPjJay3SrK/7VuiZbI8nsLHPc=;
        b=HGIl5qj9k9iwgy1nIxtWJYJnuv5GUeijLIendGlTcZ7JX0L+guR+An8+lXkT6GUv/3
         uGAv9ZOYaKhtNj0egqTlxxIw8obLpEXAv8GlxoF1bpNG3RlaEfkoHxbmoPOFG+i0wDFo
         Heqh+vHRpKJeg5Qa668HU4CMFGiDLW37+k99XPZvOMCIlXqgJW6qkXbh7mOXulruS05f
         OVy4IEGqKT65Qk1B7xE2096xPmxI+m/RIfBgB+5fSsIxjJBvSD7UYvOgPMV5d4vy3m4y
         lpfpqm9oRLSLtrErsIyGf4oq1JjA38ikauhgFlfI2h1imTfhwLFzRnx8QiS9UrYhpAVw
         uOCw==
X-Forwarded-Encrypted: i=1; AFNElJ/cbSg+Ep/VBwSQjfVzjN8ju/2ebTkFG4/iOmU/ua+9xgxzfIWr92kCZnuyoOkv2j/4kjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TF6h5k9/6HMQn1iRuk/pJhDtClf+cTLBJq67/olFYDXV4i1E
	pAKOp3WBdOvDanVYw4dbAPQ8nxabrYADJ1q5x7BhoL2hSQGuEiHv5vSs
X-Gm-Gg: Acq92OFtz2kcHA+3DVAzwglORI8/MJVG6i1VyX8Qxrcxxb0FI33iZBuPqyfrWWZ5m16
	WOol54Miu52DeYXHR5pGChkilUoSpOh5//065utGhB5jkdVAagWvw55DHrq/29it3pWPbKkLonh
	mXw94oMrbHXCqE+mJOFMeLJ8OwkEGSmPcnOYq1XnEvybGVfheknDKlolQqyS2kO+P9RFR/TPcBf
	C+n/0Nfz+SLIxxU6naR3KeKNiguIXWYxjmy1fYoCYZ7gzkjMFD6tRh7CmvWANVRUhPkh5LD5JZT
	2Pjuo4pxNRsh4cFRcO1/cykSPfULusKTLeS9HTF3p6xZGT1CMaQd1J9mlYoR2od96qxxGe+06uG
	gcy2dbXzeIZJ2F7+KW4Y+fVb75PrivzBiBNg6DkCN9oOR3+NFMAZLpDeZTc1Kl+h5MDFx8lXxck
	+ABj8NilVWWhsdT/qhLPI/7KM59Hy3j9mWO4EwKBZGyzLOzQ6fnsQLBcgR+F5s8sIm3zLxyGuYz
	vMpykmo5rnQ+ldF1xZrXHz0Y88oMor4L+mWDvF0Otj3WWskgW8Us3l0lzjVcPqgSHZZhmBmv8mw
	ofR/PLeQU58=
X-Received: by 2002:a05:600c:5250:b0:490:b9c3:6c69 with SMTP id 5b1f17b1804b1-490d7237273mr72992915e9.30.1781079497402;
        Wed, 10 Jun 2026 01:18:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm547618435e9.0.2026.06.10.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 10:18:16 +0200
Message-Id: <DJ57ZL6ZWBSA.2XW48G2H9QM0G@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Validate BTF repeated field counts before
 expansion
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moses" <p@1g4.org>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260610081434.2141515-1-p@1g4.org>
In-Reply-To: <20260610081434.2141515-1-p@1g4.org>

On Wed Jun 10, 2026 at 10:14 AM CEST, Paul Moses wrote:
> btf_parse_struct_metas() walks user supplied BTF during BPF_BTF_LOAD,
> and btf_repeat_fields() expands repeatable fields from array elements
> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>
> The remaining-capacity check performs the expanded field count calculatio=
n
> in u32. A malformed BTF can wrap that calculation, causing the check to
> pass even when the expanded field count exceeds the scratch array
> capacity. The following memcpy() can then write past the end of the
> array.
>
> Use checked multiplication before copying repeated fields and reject
> impossible counts.
>
> Add a raw BTF test that exercises repeated special-field expansion with a
> large array count. The compact element layout keeps the array byte size
> representable while the repeated field count overflows the old u32 capaci=
ty
> calculation in btf_repeat_fields().
>
> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating =
btf fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
>
> ---
> v1..v2
> 1. Combine fix and test
> 2. Drop check_add_overflow
> ---
>  kernel/bpf/btf.c                             |  8 ++---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 37 ++++++++++++++++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..7a28886f1307 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>  static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
>  			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>  {
> -	u32 i, j;
> +	u32 i, j, total_cnt;
>  	u32 cur;
>
>  	/* Ensure not repeating fields that should not be repeated. */
> @@ -3686,10 +3686,8 @@ static int btf_repeat_fields(struct btf_field_info=
 *info, int info_cnt,
>  		}
>  	}
>
> -	/* The type of struct size or variable size is u32,
> -	 * so the multiplication will not overflow.
> -	 */
> -	if (field_cnt * (repeat_cnt + 1) > info_cnt)
> +	if (check_mul_overflow(field_cnt, repeat_cnt + 1, &total_cnt) ||
> +	    total_cnt > (u32)info_cnt)

I already applied both of these to bpf-next, it seems patchwork bot didn't
reply. Yeah, check_add_overflow() isn't strictly necessary, though let us l=
et it
be now.

Thanks

>  		return -E2BIG;
>
>  	cur =3D field_cnt;
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 054ecb6b1e9f..9fcbc554e351 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -4258,6 +4258,43 @@ static struct btf_raw_test raw_tests[] =3D {
>  	.max_entries =3D 1,
>  },
>
> +{
> +	.descr =3D "struct test repeated fields count overflow",
> +	.raw_types =3D {
> +		BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_STRUCT_ENC(NAME_TBD, 0, 0),				/* [2] */
> +		BTF_TYPE_TAG_ENC(NAME_TBD, 2),				/* [3] */
> +		BTF_PTR_ENC(3),						/* [4] */
> +		BTF_TYPE_ARRAY_ENC(4, 1, 1),				/* [5] */
> +		BTF_STRUCT_ENC(NAME_TBD, 10, 8),			/* [6] */
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_TYPE_ARRAY_ENC(6, 1, 0x1999999aU),			/* [7] */
> +		BTF_STRUCT_ENC(NAME_TBD, 2, 8 + 8 * 0x1999999aU),	/* [8] */
> +		BTF_MEMBER_ENC(NAME_TBD, 4, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 7, 64),
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0int\0prog_test_ref_kfunc\0kptr_untrusted\0elem"
> +		    "\0p0\0p1\0p2\0p3\0p4\0p5\0p6\0p7\0p8\0p9"
> +		    "\0outer\0trigger\0elems"),
> +	.map_type =3D BPF_MAP_TYPE_ARRAY,
> +	.map_name =3D "repeat_fields",
> +	.key_size =3D sizeof(int),
> +	.value_size =3D 8 + 8 * 0x1999999aU,
> +	.key_type_id =3D 1,
> +	.value_type_id =3D 8,
> +	.max_entries =3D 1,
> +	.btf_load_err =3D true,
> +},
>  }; /* struct btf_raw_test raw_tests[] */
>
>  static const char *get_next_str(const char *start, const char *end)

