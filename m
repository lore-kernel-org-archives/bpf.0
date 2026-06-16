Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308A3DA7C2
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591333; cv=none; b=cjQGNIzBLPX0DuyHs6YBcic6qE/mLX+YrMPH2a+9mVxixLqsIiVEvPfoY3BcSF3KBs+jeob/GWsza7AxnYivglGeEUxR/2cMAR9egE7Cqak6OJ8a26FzlWn8EUIIQ1WwNmFKNbElR99LdVhl2jcKMxHSnHiy/V/ez5SE9VMBiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591333; c=relaxed/simple;
	bh=u7xDC0swnatPKTgn6ex4GcA4dvl1kPdMYyASNlMe2bc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qfpUSR7We8riEOA4efYRixLAr7UL6yGnn73XxgGNI46LqN2oTeElh9WgdWVb21GljXb7ZZrSVL5kqfp5WKuVuAkf8J8k37sEnfZCsr9i2GG3CIcFdGOX6Vfvld4FAWhywWa4rbjwKN73dbPBtZCzri+YuNUMx6omaypr0Rr+bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K1oemrk4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K1oemrk4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so1861076a12.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781591331; x=1782196131; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0otWC+MgUJwYmo1tOj7SD3LRYNlRGR240ZBbyZkfoGk=;
        b=K1oemrk4ZryYth/EwhhuQ9ijZXGpb4bSRKh3EJtWGxXszKsUZ/G4RFxfGs3f4tS7VH
         rEQQkPrpx6xpI2Kg5YUWftbwArxkGhQZkbrB899rgv/uNQtamDc4PkHrFh5t+jrV9gH9
         GcM8NCQbPJAkGj8A4C6iBG8hBOAvDcZwI6eQ2aurRPR28erdnTXv1v8GGpKGKx6Yc/LD
         MUeeKEH+pauAGoyD0xwfmu4OaEnSURhJqcp5rsfA11JU9so6IwpzrMVt0EvKoPEuuWFK
         AsNnalNCcCo87S2hOQz7ps/yvPheaF4bhNftTpJJ19q8CvnObtYnUhVhjkbO7h62kjK+
         GLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591331; x=1782196131;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0otWC+MgUJwYmo1tOj7SD3LRYNlRGR240ZBbyZkfoGk=;
        b=miqAKGGBdn5sNYInIUiWU9I4zRNuTb9VGlGP+IPZSj0ldgo+AFYICJkj43cC6HaQOh
         WifFqGFf+tS3TBY7mGkgOEhYIB3IcYtvmnTAUjvImfyu+Jgv5Z2XIk9SwgzJeKP/8xB4
         uihEKfd4NlCWIvk8mL8t7rIk5XqNnJf6nB3UXj9ZAlw9Xe1TOti9CJXtpW7OuajTYLYl
         zN3v+nh+y7GoH2bKQ+2IQsH2ogAA250Rht3YKm0tOsbBMpDdILeLXXjh0Zy6ITWgjVfE
         emLgQxBK1f9bdPNUUGUxBc/lOhFf2qAwRjjd7LvX7+bb5JFu5gmao5jQ9t9Ov7MpS9kk
         Hhng==
X-Forwarded-Encrypted: i=1; AFNElJ/IKlBuLLg+ADGCSVXTwmfq47PwTQo8RBuqHCjjce06yaZIXF1DGLaKfGQstZCp+3DvY5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrZJbM4Slf8G921BTf2hz5L8tC1ARLrE2R8RsSCvJFCCd2xZf
	8TNdX7rlbbLWVh+26vLhxSykfNKpBV1a0/4K/iMgHFayKMoA5sHfFVEI69s/WagdNxk=
X-Gm-Gg: Acq92OGVct5tvG6eHN9dMMnSDGP/Jh5ijnKkNV4Gqs6yMC12nG9+3VAk+nEXINM2L/S
	hY1f40QLEnezL9nkqNu3oA7AlO9TunMPn3x/o0Y3x16My1ldhg1bG2fxCfkKRlPGlQU2nDYVong
	ZRc+oPWZykfc8PuDoYSjZOEXx0GhApKU+Q+LoHSc1PCwdZLrJPjt4hEaZesdPTOMen3V18plxjP
	i6nKYMdEQy6MBokWgMhBPk+mWvyOGAJ9fJ6edIu8TJfYZ692ilE9+jrQ6oVioaW0/OfSZoUFyPp
	JD1q5QHpkbYDJl0LVgf2UzcqPAvNtc/bWt/+KFsh9uxtywBfFVxSdixpS7TUzoy5i95GU8jWi0F
	TJLaVam17Bz9HiA3peLwC7Nm6dXT+PPNtIV4PPRNL4tyvuixHOYUYDk4bXVsW7HndcMecyAkE7b
	OXbsx1kOdLjJNi8ozcTwk5WwX0bFRpQMzPEsT8lKpHkS4YOLyJnuKhI8fN
X-Received: by 2002:a05:6a20:9f48:b0:3b2:86e8:a817 with SMTP id adf61e73a8af0-3b796409353mr15915671637.31.1781591331546;
        Mon, 15 Jun 2026 23:28:51 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651aef27sm10560415a12.30.2026.06.15.23.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 23:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 02:28:50 -0400
Message-Id: <DJA9F2G6KYZ5.2RSSND5UY6YKW@etsalapatis.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 01/14] tools/bpf: Sync btf_ids.h to tools
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-2-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> Sync tools/include/linux/btf_ids.h with include/linux/btf_ids.h so
> tools-side code can use BTF_ID_FLAGS(), BTF_SET8_START(), and
> BTF_KFUNCS_START().
>
> Keep the tools copy's existing compiler header dependency:
> tools/include/linux/compiler.h already provides __maybe_unused and
> tools/include/linux/compiler_attributes.h does not exist.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/include/linux/btf_ids.h | 78 ++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.=
h
> index 72ea363d434d..4fe5c5f1558c 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -10,6 +10,9 @@ struct btf_id_set {
>  	u32 ids[];
>  };
> =20
> +/* This flag implies BTF_SET8 holds kfunc(s) */
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +
>  struct btf_id_set8 {
>  	u32 cnt;
>  	u32 flags;
> @@ -22,6 +25,7 @@ struct btf_id_set8 {
>  #ifdef CONFIG_DEBUG_INFO_BTF
> =20
>  #include <linux/compiler.h> /* for __PASTE */
> +#include <linux/stringify.h>
> =20
>  /*
>   * Following macros help to define lists of BTF IDs placed
> @@ -35,7 +39,7 @@ struct btf_id_set8 {
> =20
>  #define BTF_IDS_SECTION ".BTF_ids"
> =20
> -#define ____BTF_ID(symbol)				\
> +#define ____BTF_ID(symbol, word)			\
>  asm(							\
>  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
>  ".local " #symbol " ;                          \n"	\
> @@ -43,10 +47,11 @@ asm(							\
>  ".size  " #symbol ", 4;                        \n"	\
>  #symbol ":                                     \n"	\
>  ".zero 4                                       \n"	\
> +word							\
>  ".popsection;                                  \n");
> =20
> -#define __BTF_ID(symbol) \
> -	____BTF_ID(symbol)
> +#define __BTF_ID(symbol, word) \
> +	____BTF_ID(symbol, word)
> =20
>  #define __ID(prefix) \
>  	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
> @@ -56,7 +61,14 @@ asm(							\
>   * to 4 zero bytes.
>   */
>  #define BTF_ID(prefix, name) \
> -	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> +	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), "")
> +
> +#define ____BTF_ID_FLAGS(prefix, name, flags) \
> +	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), ".long " #flags "\n")
> +#define __BTF_ID_FLAGS(prefix, name, flags, ...) \
> +	____BTF_ID_FLAGS(prefix, name, flags)
> +#define BTF_ID_FLAGS(prefix, name, ...) \
> +	__BTF_ID_FLAGS(prefix, name, ##__VA_ARGS__, 0)
> =20
>  /*
>   * The BTF_ID_LIST macro defines pure (unsorted) list
> @@ -155,10 +167,58 @@ asm(							\
>  ".popsection;                                 \n");	\
>  extern struct btf_id_set name;
> =20
> +/*
> + * The BTF_SET8_START/END macros pair defines sorted list of
> + * BTF IDs and their flags plus its members count, with the
> + * following layout:
> + *
> + * BTF_SET8_START(list)
> + * BTF_ID_FLAGS(type1, name1, flags)
> + * BTF_ID_FLAGS(type2, name2, flags)
> + * BTF_SET8_END(list)
> + *
> + * __BTF_ID__set8__list:
> + * .zero 8
> + * list:
> + * __BTF_ID__type1__name1__3:
> + * .zero 4
> + * .word (1 << 0) | (1 << 2)
> + * __BTF_ID__type2__name2__5:
> + * .zero 4
> + * .word (1 << 3) | (1 << 1) | (1 << 2)
> + *
> + */
> +#define __BTF_SET8_START(name, scope, flags)		\
> +__BTF_ID_LIST(name, local)				\
> +asm(							\
> +".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
> +"." #scope " __BTF_ID__set8__" #name ";        \n"	\
> +"__BTF_ID__set8__" #name ":;                   \n"	\
> +".zero 4                                       \n"	\
> +".long " __stringify(flags)                   "\n"	\
> +".popsection;                                  \n");
> +
> +#define BTF_SET8_START(name)				\
> +__BTF_SET8_START(name, local, 0)
> +
> +#define BTF_SET8_END(name)				\
> +asm(							\
> +".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
> +".size __BTF_ID__set8__" #name ", .-" #name "  \n"	\
> +".popsection;                                 \n");	\
> +extern struct btf_id_set8 name;
> +
> +#define BTF_KFUNCS_START(name)				\
> +__BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
> +
> +#define BTF_KFUNCS_END(name)				\
> +BTF_SET8_END(name)
> +
>  #else
> =20
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[128];
>  #define BTF_ID(prefix, name)
> +#define BTF_ID_FLAGS(prefix, name, ...)
>  #define BTF_ID_UNUSED
>  #define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
>  #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_un=
used name[1];
> @@ -166,6 +226,10 @@ extern struct btf_id_set name;
>  #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name=
 =3D { 0 };
>  #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unus=
ed name =3D { 0 };
>  #define BTF_SET_END(name)
> +#define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused na=
me =3D { 0 };
> +#define BTF_SET8_END(name)
> +#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused =
name =3D { .flags =3D BTF_SET8_KFUNCS };
> +#define BTF_KFUNCS_END(name)
> =20
>  #endif /* CONFIG_DEBUG_INFO_BTF */
> =20
> @@ -215,5 +279,9 @@ MAX_BTF_TRACING_TYPE,
>  };
> =20
>  extern u32 btf_tracing_ids[];
> +extern u32 bpf_cgroup_btf_id[];
> +extern u32 bpf_local_storage_map_btf_id[];
> +extern u32 btf_bpf_map_id[];
> +extern u32 bpf_kmem_cache_btf_id[];
> =20
>  #endif

