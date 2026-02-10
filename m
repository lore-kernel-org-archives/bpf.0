Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDB1FCFFC
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683190; cv=none; b=Z2dqUppNxF36dWdUfrloGU7yuVmksiZpGCsXstNzMEyAYkBVN7PN8ZpQqfnrZdj+K/bqTuIqkp4Vkt6mWQ4hTDsQo33+G/mw+qhwq0UYEGZIiFNoCAcP5Ck+pCM/hzS/4P04T37GZBVIQTPrF0c0UICB4VXMMaS3aLSEr6NnMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683190; c=relaxed/simple;
	bh=44qXTO+Dh4UZYq6Kz4s7NQcP6gnfpf0LvKrR3W6vKEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qwkrn4N2OsQtrjFVECWPVOdzBEI4/rDVEwpBU82bE/xs1siWswGed3h8H6Ky64z1ydtppNcegSRtQzdwA3RAeO4lhqGRrjIYYJeILdhrsMx0ZmQRIv4NkTvVuvhnYGZJEN2RgyQtQ/FShE3fa22iH0QL21gZahwEGlrGixcPjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=K5DmfWPI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="K5DmfWPI"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89549b2f538so4562636d6.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770683188; x=1771287988; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziB2fJwsIb/uqK+s3UxnTwxo0FPoqIaDh6cL82YzFHU=;
        b=K5DmfWPIGXwSh2DRuanWKi3CAEjZp8tTTombP8PoPpoa/Lnu0Bn8tYumg7fWziEcB3
         0/UnMlvQ9TD+NNlFOEzx7Gt6thakWp0Zam543Zyp0mrT4VfmXKhL91Gi3DRovu2eeJFn
         yhzgeb3Gy4MsHE2ZwSPlSHP4qBG8LlyvT2LoUeZfcqIrqujyYXDKZUxvdRUa2wOwENiZ
         NLZNJkLtQLWWdq3nNJMUOQWUWKTcsbf/iX5uY7rRklWjGfZxoFOm2Ckmi3weLq6bCUgB
         IdqzJ7FnrZ6HKO8pIlzgNV7l+pTgldkW/q4m6Su5XG6Vq3/e+rCEp9yWgSMEKTPPd+Cs
         Bm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683188; x=1771287988;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziB2fJwsIb/uqK+s3UxnTwxo0FPoqIaDh6cL82YzFHU=;
        b=vKoVY82YliOaWgPz9K1y5OPc3k2tDA/UU7TSZPccNcHUUG/kabC49dn8cFrPsK40CN
         0CmqplA2WXM3KjXkYhdRQk3HMB6BbbVEG6eVNnXFRJwwJFLrbGZj+T7zu2n9hNqnn2xc
         3w5cvoTLH5yKke2WCtdIInJn/5D0rhcxnI5dB82n27QUCLRCTLlmNAc1iafuMFOjNKvN
         U0OG/ElYL0oVZk3zN5xSaY2MTiJJ8eNDWiRl0eJ/HvMzSOgT/GLXzD04AluwZDQSX1Ys
         LMj8ArSQFCy1AuU0P61qPSMDWgL4qayaKNowySvtwAC+Gs1VEFRE1zw3qrcI16DJrNUW
         q8mA==
X-Forwarded-Encrypted: i=1; AJvYcCX4g4jYwe4N5fToFGjZnVfp+WKNbqAuBF+1QwrTxsAoxhQ8y4HdhuBbC+bQJhP8HZQpk6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yn1Nu+knZTNlKDupeH2yVaHjgso7G1X6vs/WuW5TdTaPexX6
	wtpH6/6f67rBmvquoXqjH/zK1mPmAITE7CBJO8fuCFYjziVsndjnnwfrjBvXw+jcKis=
X-Gm-Gg: AZuq6aI8IiUTaJFHbnaQF9ScPIjPG6keS9Sv5b2Bba4Axtg8jp88Pi/sgpwR2ve8bAw
	qDyhcTU6XIZ4ugaObwnNg0uwtuU1fDm5ECBw5FrY871azVhMSUdpgQzDyAtkBl9AeLtkfXPz7vs
	g8NjfBiJMevfwrxsxvz817YVAPRUvjRPjaS/vne/lReRDatES9ysGC9z/A/fz+MssHJrneZDRpw
	lbpk7Ht9lMeYv1zIE9s2LSWN+aZnT1TyL36moahTH3kAh7xph+A71WDCChMzRkDJnMZOkJ0V8o6
	XD+ug3RNgM1I8TfDoQ74dH2RH5lVIiMtxP0FGFW3p7wMzBqgu3Ao3Npp3/8hSuF+U6fifI+3BN7
	IJqdalWU030B6SmZiY7cjPMVvOMBwIcxLssbqt51uUQ7DDgQqPlIs8Mht/m7Z7HeqWVu0y9uDph
	M3wjrFhErMaSo2Rj6XMKSiEhA=
X-Received: by 2002:a05:6214:e6c:b0:889:a88f:f01f with SMTP id 6a1803df08f44-8953cd98fdemr191358266d6.61.1770683188230;
        Mon, 09 Feb 2026 16:26:28 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89651161382sm54670476d6.51.2026.02.09.16.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 19:26:27 -0500
Message-Id: <DGAUSYFN8OW4.2D08XFDK2CPG9@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] libbpf: Add gating for arena globals
 relocation feature
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260209234850.2750149-1-emil@etsalapatis.com>
 <DGAUH7XDYUV0.1J1I31HIRDODC@etsalapatis.com>
In-Reply-To: <DGAUH7XDYUV0.1J1I31HIRDODC@etsalapatis.com>

On Mon Feb 9, 2026 at 7:11 PM EST, Emil Tsalapatis wrote:
> On Mon Feb 9, 2026 at 6:48 PM EST, Emil Tsalapatis wrote:
>> Add feature gating for the arena globals relocation introduced in
>> commit c1f61171d44b. The commit depends on a previous commit in the
>> same patchset that is absent from older kernels (12a1fe6e12db,
>> "bpf/verifier: Do not limit maximum direct offset into arena map").
>> Without this commit, arena globals relocation with arenas >=3D 512MiB
>> fails to load and breaks libbpf's backwards compatibility.
>>
>> Introduce a libbpf feature to check whether the running kernel includes
>> patch 12a1fe6e12db, and only relocate arena globals if it does.
>>
>> CHANGELOG
>> ---------
>>
>> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsa=
lapatis.com/)
>>
>> - Reworked test to use simpler array-based program (Andrii)
>>
>> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena=
")
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> This patch does not properly parse the verifier log for kernels without
> 12a1fe6e12db. Will fix and respin.
>

Actually the patch works as intended: I thought the arena tests should
have been successful even after reverting 12a1fe6e12db, but that is not=20
the case. I still missed one of Andrii's points on v2 so I'll respin
anyway.

>>  tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.c          |  7 ++-
>>  tools/lib/bpf/libbpf_internal.h |  2 +
>>  3 files changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index b842b83e2480..b1a088dd83ac 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>>  	return probe_fd(prog_fd);
>>  }
>> =20
>> +static int probe_kern_arena_global_reloc(int token_fd)
>> +{
>> +	const size_t bufsz =3D 1024;
>> +	int btf_fd, prog_fd, map;
>> +	char log_buf[bufsz];
>> +	int ret;
>> +	static const char strs[] =3D "\0f\0";
>> +	const __u32 types[] =3D {
>> +		/* [1] FUNC_PROTO `void(void)` */
>> +		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 0),
>> +		/* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
>> +		BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLO=
BAL), 1),
>> +	};
>> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
>> +		.token_fd =3D token_fd,
>> +		.map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>> +	);
>> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
>> +		.token_fd =3D token_fd,
>> +		.prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
>> +		.log_buf =3D log_buf,
>> +		.log_size =3D bufsz,
>> +	);
>> +	struct bpf_insn insns[] =3D {
>> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	const struct bpf_func_info_min func_infos[] =3D {
>> +		{ 0, 2 }, /* main prog -> FUNC 'f' */
>> +	};
>> +	int insn_cnt =3D ARRAY_SIZE(insns);
>> +
>> +	btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, si=
zeof(strs), token_fd);
>> +	if (btf_fd < 0)
>> +		return 0; /* BTF not supported at all */
>> +
>> +	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &=
map_opts);
>> +	if (map < 0) {
>> +		ret =3D -errno;
>> +		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
>> +			__func__, errstr(ret));
>> +		close(btf_fd);
>> +		return ret;
>> +	}
>> +	insns[0].imm =3D map;
>> +
>> +	prog_opts.prog_btf_fd =3D btf_fd;
>> +	prog_opts.func_info =3D &func_infos;
>> +	prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
>> +	prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);
>> +
>> +	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc", "GPL"=
, insns, insn_cnt, &prog_opts);
>> +
>> +	ret =3D -errno;
>> +	close(map);
>> +	close(btf_fd);
>> +
>> +	if (prog_fd >=3D 0) {
>> +		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n",
>> +			__func__);
>> +		close(prog_fd);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Be conservative and NULL terminate the buffer to ensure strstr term=
inates. */
>> +	log_buf[bufsz - 1] =3D '\0';
>> +
>> +	/*
>> +	 * Feature is allowed if we're not failing with the error message "dir=
ect value
>> +	 * offset of %u is not allowed that was removed in 12a1fe6e12db
>> +	 * ("bpf/verifier: Do not limit maximum direct offset into arena map")=
.
>> +	 * Instead, we should be failing with the message "invalid access to m=
ap value
>> +	 * pointer". Ensure we match with one of the two and we're not failing=
 with a
>> +	 * different, unexpected message.
>> +	 */
>> +	if (strstr(log_buf, "direct value offset of"))
>> +		return 0;
>> +
>> +	if (strstr(log_buf, "invalid access to map value pointer") =3D=3D NULL=
) {
>> +		pr_warn("Error in %s(): Program unexpectedly failed with message: %s.=
\n",
>> +			__func__, log_buf);
>> +		return ret;
>> +	}
>> +
>> +	/* Feature is on. */
>> +
>> +	return 1;
>> +}
>> +
>>  typedef int (*feature_probe_fn)(int /* token_fd */);
>> =20
>>  static struct kern_feature_cache feature_cache;
>> @@ -581,6 +670,9 @@ static struct kern_feature_desc {
>>  	[FEAT_BTF_QMARK_DATASEC] =3D {
>>  		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>>  	},
>> +	[FEAT_ARENA_GLOBAL_RELOC] =3D {
>> +		"Relocatable arena globals support", probe_kern_arena_global_reloc,
>> +	},
>>  };
>> =20
>>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature=
_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..0aeb740a5f47 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
>>  	memcpy(obj->arena_data, data, data_sz);
>>  	obj->arena_data_sz =3D data_sz;
>> =20
>> -	/* place globals at the end of the arena */
>> -	obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +	/* place globals at the end of the arena (if supported) */
>> +	if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
>> +		obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +	else
>> +		obj->arena_data_off =3D 0;
>> =20
>>  	/* make bpf_map__init_value() work for ARENA maps */
>>  	map->mmaped =3D obj->arena_data;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inte=
rnal.h
>> index fc59b21b51b5..e0223a6e4c95 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -392,6 +392,8 @@ enum kern_feature_id {
>>  	FEAT_ARG_CTX_TAG,
>>  	/* Kernel supports '?' at the front of datasec names */
>>  	FEAT_BTF_QMARK_DATASEC,
>> +	/* Kernel supports relocating arena globals to end of the arena */
>> +	FEAT_ARENA_GLOBAL_RELOC,
>>  	__FEAT_CNT,
>>  };
>> =20

