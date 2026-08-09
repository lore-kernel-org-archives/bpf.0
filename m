Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D313002C8
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284467; cv=none; b=rqD1uOXri3m9OkQstIOC1OJKdBGw76YuPHB554HaqXebUNFOXz4y/Zsp3WsGwxeshdeDUPAqkHVB7y6MrNCqAD+IEEot95oqwrlwLCQoCUl6QgKDzbQJdIva6pe9Zp23lY2+z6KrWUetUHhJ8VkwUuy3lm5D/ZqJQm9DXjFzB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284467; c=relaxed/simple;
	bh=7wyY7/+A6nb+iJspnju0eoIt080o/PyJdnGJy20DGpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SFCKF8AJSBRv08ETn9yW+hzg6kJKQ59SJrXcaNgq+ilYr6JgeJ1j1lzHAXWE+yMVVR3Hibfi0P2gvKu4SU9fRQdj1543xt7DtUvQ/KspzNMh2qHoRSKNlxI5KmrqtKBqrCrseR0FveSnj33uIML3ohCUmzP+wnfe81q8UGogg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxABQIMc; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxABQIMc"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so1631045e9.0
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786284463; x=1786889263; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VxuYGRbEWzeF1f6dRCirk7TM/15PLndzwVrHxUkRlc4=;
        b=lxABQIMctLLSVLehQ2OJC1fm1YQ+YjJvp9NCbXWCnb16rQTClaOlTmYeSfyJvql1i4
         LYqRedp/yengUAoUZrpiWq5bqkD04X1U8k5KmtVGPh/5mCMn9unFg4Pq43W2Hs2o3+a7
         7F60Daatzu6Lm1pr9AAg5EPSD3/akKz2ECmQfJ91E2hsvSb1gTxKqonwIFuuYPtyIQu7
         laGzPXPzAHzjXXRvAOdLJyQIQ7h7UBWGUDbhk4u3pozJuTV4AGe9IescXRIZ1F1fBjzT
         +gVBlHCE9I0adm3OvImVrVvKDOgDHiRVUyLtZH4ovPJ+fxTrIFcmoiAY8I0TXp5jkFyD
         GMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786284463; x=1786889263;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxuYGRbEWzeF1f6dRCirk7TM/15PLndzwVrHxUkRlc4=;
        b=KBoWHeJ9QT8h+/BrChITTTpA5KiO6ZGLPFSzICpUMrtD0Vcjad1DdEBz2/n8tSDf+g
         3am496CWzyEEh5lCL98yXYgVpw9G8O7WyIv3Z/9zXy8ZLeU1bUmqijgRj8V/+iEyC0AI
         25GFO/XthOyKQdSOKg5CQGLI7BFysvdnEyyWxVbV9MOAId9aVwpT+jt6wYbnzOT9K48d
         e1oN6EO0bHo7cYeA5wTL8Y2EbrDaULiLAbP4MGO5iOuqNNzaJEXG0AujSZQmlZ9/lf53
         Pj1qHmIab/ou9dWEkc7znLQQUs4CTSuK8h7Js4j+pp7+5cceACx6icJ4CZKRU/BINYF4
         KDmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnxX0kp1epJdIKlDx9OG+W4dwaj81E2TvyhrXShsvCniXwFyqCZjKpBPh6Vmyu9N+ywdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeBTgxrFtvN51Bgc20GIuvyB4BRayY4DydOcSSEf7mulIQHI6
	ixXQVPugodDVFbM52J0ldD0bmmdutLX6TFCz6tgTcHfF8IPQifEWTNW8
X-Gm-Gg: AR+sD13YUTylkhY6naiYLVzRG9cc5nwoGXgrZOj8GVsWQcQkavmIw5eEa8+tuqkp0y0
	QBPgLr+/Bc5T+MVPveaGyl0odoQQFPz8W5gUi+oIX1N4XNTRUxoPSv0afWnyuZyLXaEcSYZNsmF
	gm2EKbyi68GhFyJbD6usgVikVqd0Mh7k5YcjBBUBIB4Pmux/EYA2K06eQa5r1Q7KjBUgJwuyO+q
	55R0fVIID8VpHxd8fOtvVc1bQE8zCE0D7CIKocj4TmQR6accfVETTfcu6HF5ARVBW3qcWjVsnbK
	H/2biUy/9NAmK19GittpmvnOJ7+VwNp6CamZDoDutkzZdrWk9LzYII9rze9HwqkffctCrJGD7uQ
	jsDqcE+ICJCDuYjQdUrSjLedStd5BqMZsqDJaZimYtZnPzRONY2pwEOEXy9ROi8hKacCM7nieUK
	YsZBraP8SJmSq4yxhvHowR2yLjXRmjf3k2rCHwV9nF3teC63IqKSxwqkU0TW1q+JYIGK3ztFpyZ
	AHuxejtrzsrk2u1XtU/O6oz5JzqLINp4Mf0id3Nz+AnzBSeBHZb2g9l14935kUNZ2KaF+84x79u
	Mj6R+g79JfAndEfaQttV1drojWo=
X-Received: by 2002:a05:600c:3548:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4995e0def7bmr223498705e9.14.1786284463161;
        Sun, 09 Aug 2026 07:07:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f9424sm175138815e9.8.2026.08.09.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 07:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 16:07:41 +0200
Message-Id: <DKKGZT7LJJW1.S0PQ3KJ9R3LC@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test resolve_btfids
 arena argument suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260809085155.3305519-3-memxor@gmail.com>
 <e425dd364d874c0071dd4096c38ba72df96da2afd8c541d99f3a48c878808e5d@mail.kernel.org>
In-Reply-To: <e425dd364d874c0071dd4096c38ba72df96da2afd8c541d99f3a48c878808e5d@mail.kernel.org>

On Sun Aug 9, 2026 at 11:57 AM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/t=
ools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> index 732cfed35e1c..9bd84fe32b89 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> @@ -15,6 +15,7 @@
>>  #define DECL_TAG_FASTCALL "bpf_fastcall"
>>  #define DECL_TAG_KFUNC "bpf_kfunc"
>>  #define TYPE_ATTR_ARENA "address_space(1)"
>> +#define ARENA_ARG(n) (1U << (n))
>
> This isn't a bug, but ARENA_ARG(n) is zero-based while the KF_ARENA_ARGn
> flags it sits next to are one-based, so the same argument is spelled two
> different ways inside a single table row.
>
> For example, '{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false }'
> means KF_ARENA_ARG2 and ARENA_ARG(1) refer to the same parameter.
>
> Would a name like ARENA_ARG_IDX(n), or a short comment noting that
> ARENA_ARG(0) corresponds to KF_ARENA_ARG1, help keep the two columns
> from drifting?
>

I think it's ok, we might drop the other flag soon anyhow.

> [ ... ]
>
>> @@ -49,13 +50,18 @@ struct kfunc_symbol {
>>  	const char	*name;
>>  	s32		 id;
>>  	u32		 flags;
>> +	u32		 arena_args;
>> +	bool		 arena_ret;
>>  };
>>
>>  static struct kfunc_symbol kfunc_symbols[] =3D {
>> -	{ "kfunc_a", -1, 0 },
>> -	{ "kfunc_b", -1, KF_FASTCALL },
>> -	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
>> -	{ "kfunc_d", -1, KF_ARENA_ARG2 },
>> +	{ "kfunc_a", -1, 0, 0, false },
>> +	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
>> +	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
>> +	  ARENA_ARG(0) | ARENA_ARG(1), true },
>> +	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
>> +	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
>> +	  ARENA_ARG(3) | ARENA_ARG(4), false },
>>  };
>
> This isn't a bug, but the new arena_ret field duplicates information
> that the existing flags field already carries.
>
> resolve_btfids only ever arena-tags a return value from KF_ARENA_RET:
>
> tools/bpf/resolve_btfids/main.c:add_arena_tagged_proto() {
>     ...
>     if (kfunc->flags & KF_ARENA_RET)
>         /* tag return */
>     ...
> }
>
> There is no return-position suffix mechanism, so arena_ret is exactly
> !!(flags & KF_ARENA_RET) for every row and the old expression it
> replaced was already correct.
>
> Since only KF_ARENA_RET drives return tagging, could the return
> assertion keep using !!(flags & KF_ARENA_RET) instead of the new
> arena_ret field?
>

I found this more clear, but am fine with reworking in any direction.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/313052=
17088

