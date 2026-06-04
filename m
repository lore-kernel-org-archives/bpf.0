Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EE39A4B9
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588770; cv=none; b=UjgwH/rb5iIoFGdmh1+oMkOEk8xpcJwDU7igUD2WkgkjShxQk91mveBRm8aL9hsrKsmDGFVxaeQPDo9k8DiFD7zGKtegC/M66/Ee2Avv57ZpLcOX2a5ZqTVJUo9QxCZOVByIrGV9zyNLj1QmnSJPVe4VyijJLjWXJ6ka3JS+yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588770; c=relaxed/simple;
	bh=gaeaHjJrge4LKzIxhoFtatJPq0B811tpxJbmbSzUzv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=taqahGTjdlBkXou43ZdF6qtuTyYuo40KsmiaTwKeLGY9IDTvU90djAEZfFTsdDDH1vhn9QQaHOt5XS+myMoWwHVYup133WtcytYGqMfeOWsHcSbHC2SkSlYzFKwIIvP//14IwdL8iuCzNn7ypFZ7P6qCskq5YSJiCpDGujuratk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YSa1F56x; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YSa1F56x"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423b08b293so442757b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780588768; x=1781193568; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dcr160ztftDL6aQ6BmVMYcIb6LF1JPSaLmdRHjZV18=;
        b=YSa1F56x140kSdZ5/wqG/SmGl+FG+mA0+yz1kiFbKM2uZ2AFkGx1HVZW8kWBQzgIsf
         Q+ppnUh84TYjfXA1YboTTg3qQiXLj9lvI3uVzmexzrw0FB4PWwRbfmLmdjr+O8hfM0XW
         dOrV1nzvdNFwx20mZ2K9RBASTXMNTQDzbtAHOO0KG4uEBe63OTSMUdSRe1lAt8MJXQ52
         jAw/EXaQu7I9qlza4mmWYnZsP9KKwTydgIrz0kvIE9jaNCvieALXK/4EvIjyHl2A9GyY
         cYIdzWCnWnOXdN9tSG4JfJJoaxKEpZow1mmTwvNWQ+OKrhzh/jLNKD70ZeqOYep8mbUK
         V9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588768; x=1781193568;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dcr160ztftDL6aQ6BmVMYcIb6LF1JPSaLmdRHjZV18=;
        b=VfUgvkgbnO6aU9TYMl7RNwGhi86OFY+3UWhcx/H+cw7c8l2Y1LkHG1/Ag7wEcZ7U6p
         Owx09fzYwK4cGsEyZQ1M15/i/eqYUGMxSbqNaJbDSG5NHkgMfpl8QVCxTJ+SlCYH3f2b
         FUySYVm1bMxblaiBOpdTKF3baXb+VKj/FlwHIep1+Rq4U64YbRuDi642fVsbieGO3BiW
         GuOyg8PVFBNuf4T2cqrwCNyVu0G2k6CMvjvBGUErYFc8FVrE5MAiH/TPNDdZVrjYDell
         yJsaoE4qutUTpRx0StgTqQlQU6kaKm57JBTDrDyyxNFiwPyZOP+Hs2Ye4VNMIxEAiLHA
         EcNg==
X-Forwarded-Encrypted: i=1; AFNElJ+ftWGIij4WPbnFj+Q3T2sKgeiKdsgj1ao5GG5pYDuAq30gDeQMW0oR8EzHSL6019dAluY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6BuIx54f2Kjxh1JUKCArcVLsIgm2yZR+1hrhzpow0s92cycYv
	q8t6eOucLfysj4eyV9p3FDg8Utlv8jx4WM8DuflsfKAR7Nrq9GFTJR8g4uYHGDqmdyU=
X-Gm-Gg: Acq92OEgl5QS+hRE9S8OxSnDUZs3Db3TLd2jGxXhHdZzXx3HifCc9KJh13uqLnmdoxm
	ztJb1Jz/CyeSDZpeSeYeMKHc9/hwkniNzSqDG++lrJWypKaRuGwHQ8D3noEu3q5ET5fqcfEOQX+
	sFL+FghBdBkqShfnTVmhK0uyqtJ6foAg1UPQqtscGXsB5pYTLwP1XYR315sGmLXbv9iwoX26abi
	ZsTkwtabO4cCs8hl2w5QrgWU9eN62LbNkc8HjxHEaFbViPoVMtfWyKXUJ+jTsFCMougBiofCilf
	Yh5WeaWRHpb9Rw1JusLkMv0inoVnhc9deHT0rUZ9CXGoKmxl/gauAGZaXALXmlqs+UITy5I0ulg
	2l2kc60nPK//V7FRilXfjhSOKc+NAnQHKMZAfstmwjSO/ahzsCZ5Wd0sFOy2QpB9H+HHPMCeYa9
	kPUxli3mgq+fsnNFQdU+JRCU4Xvx4ys9Zql/YRUV/toeUabA==
X-Received: by 2002:a05:6a00:4213:b0:842:4387:34b6 with SMTP id d2e1a72fcca58-84284f34197mr7686550b3a.35.1780588767651;
        Thu, 04 Jun 2026 08:59:27 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm6507929b3a.34.2026.06.04.08.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 11:59:26 -0400
Message-Id: <DJ0E1ER599F1.36FPRHEE3YZAP@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: clean up btf_scan_decl_tags()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Matt Bobrowski" <mattbobrowski@google.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260603201822.770596-1-mattbobrowski@google.com>
In-Reply-To: <20260603201822.770596-1-mattbobrowski@google.com>

On Wed Jun 3, 2026 at 4:18 PM EDT, Matt Bobrowski wrote:
> Refactor the newly introduced btf_scan_decl_tags() to improve
> readability and maintainability. The current implementation uses a
> manual if-else chain and a magic number offset to strip the "arg:"
> prefix from declaration tags.
>
> Replace the if-else logic with a table-driven approach using a static
> const array. This separates the tag data from the scanning logic, making
> the helper more extensible for future tags. Additionally, replace the
> magic number '4' with a sizeof-based calculation on the prefix string to
> ensure the offset remains synchronized with the search key.
>
> Finally, optimize the loop by moving the is_global check to the top of
> the block. This allows the verifier to fail-fast on static subprograms
> without performing unnecessary BTF string and type lookups.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

We can also modify the new btf_scan_type_tags() to conform to the same
pattern. It currently recognizes a single type tag, so if anything it
would be more code, but we don't want it to slowly end up looking like
the if-else chain we're replacing below.

> ---
>  kernel/bpf/btf.c | 46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 68921d9172b5..55aa3ba1b1e0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7808,14 +7808,28 @@ static int btf_scan_decl_tags(struct bpf_verifier=
_env *env,
>  			      u32 arg_idx, bool is_global, u32 *tags)
>  {
>  	int id =3D btf_named_start_id(btf, false) - 1;
> +	const char tag_key[] =3D "arg:";
> +	static const struct {
> +		const char *tag_value;
> +		enum btf_arg_tag arg_tag;
> +	} tag_values[] =3D {
> +		{ "ctx", ARG_TAG_CTX },
> +		{ "trusted", ARG_TAG_TRUSTED },
> +		{ "untrusted", ARG_TAG_UNTRUSTED },
> +		{ "nonnull", ARG_TAG_NONNULL },
> +		{ "nullable", ARG_TAG_NULLABLE },
> +		{ "arena", ARG_TAG_ARENA },
> +	};
> =20
>  	/*
>  	 * The 'arg:<tag>' decl_tag takes precedence over the derivation
>  	 * of the register type from the BTF type itself.
>  	 */
> -	while ((id =3D btf_find_next_decl_tag(btf, fn_t, arg_idx, "arg:", id)) =
> 0) {
> -		const struct btf_type *tag_t =3D btf_type_by_id(btf, id);
> -		const char *tag =3D __btf_name_by_offset(btf, tag_t->name_off) + 4;
> +	while ((id =3D btf_find_next_decl_tag(btf, fn_t, arg_idx, tag_key, id))=
 > 0) {
> +		const struct btf_type *tag_t;
> +		const char *tag;
> +		int i;
> +		bool found;
> =20
>  		/* disallow arg tags in static subprogs */
>  		if (!is_global) {
> @@ -7825,19 +7839,19 @@ static int btf_scan_decl_tags(struct bpf_verifier=
_env *env,
>  			return -EOPNOTSUPP;
>  		}
> =20
> -		if (strcmp(tag, "ctx") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_CTX;
> -		} else if (strcmp(tag, "trusted") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_TRUSTED;
> -		} else if (strcmp(tag, "untrusted") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_UNTRUSTED;
> -		} else if (strcmp(tag, "nonnull") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_NONNULL;
> -		} else if (strcmp(tag, "nullable") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_NULLABLE;
> -		} else if (strcmp(tag, "arena") =3D=3D 0) {
> -			*tags |=3D ARG_TAG_ARENA;
> -		} else {
> +		tag_t =3D btf_type_by_id(btf, id);
> +		tag =3D __btf_name_by_offset(btf, tag_t->name_off) + (sizeof(tag_key) =
- 1);
> +
> +		found =3D false;
> +		for (i =3D 0; i < ARRAY_SIZE(tag_values); ++i) {
> +			if (!strcmp(tag, tag_values[i].tag_value)) {
> +				*tags |=3D tag_values[i].arg_tag;
> +				found =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
>  			bpf_log(&env->log, "arg#%d has unsupported set of tags\n", arg_idx);
>  			return -EOPNOTSUPP;
>  		}

