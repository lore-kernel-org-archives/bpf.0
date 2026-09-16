Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0A440641
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549409; cv=none; b=mWG3/Gy+tvFOcd+o+BVOcUee3mceJwmugWuNdsQTUk+KP+/pqH39Gs916SZJWZEpOD07ycGIH8rXk1YgxFi9iSya9aixDi8NaCP7eJsG6EY+wlm8VpLxJufvpKEd0Xkv9GumZW+3gw/KD2NeznO6AiYXCTQptI+kBMkvm+yE178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549409; c=relaxed/simple;
	bh=4KmEHZynPwjsy0K3hxSBV+5bXJemzSzRx4B9631B+gQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J8oatjoEnAiWqF1NqV+yAhtRsBVH97Vd/foqSZKaqYXXDdsY7jK2F08CjhzW31e01PA2TflXE/9OND2G7mDroCOlDSHzW2THabKynXAkQajJcyW2kDQDnWqxoTMXhxIK6NXSg8Tie5c75QDaTk0og0nPpDPJG7NT58VM/OB2nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6zILBtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6zILBtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3411F000FF;
	Wed, 16 Sep 2026 09:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549396;
	bh=7vkxNxFT5U6EtkNZarS4fgANjmeJnpUy5I9jHOIon4Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T6zILBtqhlS30wo6ovnAARqJEW8cuCkxRAs1tDMmcuFsTRRbU2Ku5NO5xZnDvBZo/
	 UzQtd7GtxsTP+T/HeB4fQ0BwLZPwa1m/UlT/OZCSjUjtW6ov99mwTV2DtjAKqt3w/2
	 V34x6sh3JpFtEsqg9VyZ9VMHwuQkzG7NC9NOil/6NSBMmr0f8MlDHdYjJwbfc33LyQ
	 K4zYMmrKGYdPK2iZQMSkwSD8ZeXPnatyMALRavSsxvmnSbY/IBohjbYthTjYsC4eRo
	 xtFKhCzARzkL2lNObeJMG9v147k2MC90AtRwkEtdC/FGcGH11QVKz5R6S+BKljKq5L
	 zxDFYrNJavkcw==
Content-Type: multipart/mixed; boundary="===============0276429710653294798=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ebf69156810d89f0e1b7d48b3cf58bebe72e5a9dd06b40375a79d2d4b37ef22@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-11-alan.maguire@oracle.com>
References: <20260916074118.1007116-11-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 10/11] selftests/bpf: Test bpftool dump of BTF location info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:15 +0000 (UTC)

--===============0276429710653294798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> index d5b25302b0c89..f8ea9dfd0780b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> @@ -57,6 +57,35 @@ static struct btf *mk_btf(void)
>  	return btf;
>  }
>
> +static struct btf *mk_loc_btf(void)
> +{
> +	struct btf *btf;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
> +		return NULL;
> +
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	btf__add_func_proto(btf, 1);
> +	btf__add_func_param(btf, "arg1", 1);
> +	btf__add_func_param(btf, "arg2", 1);
> +	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2);
> +
> +	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_REG);
> +	btf__add_loc_param_value(btf, 1);
> +	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG |
> +			    BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET);
> +	btf__add_loc_param_value(btf, 2);
> +	btf__add_loc_param_value(btf, 0x10);
> +	btf__add_loc_proto(btf);
> +	btf__add_loc_proto_param(btf, 4);
> +	btf__add_loc_proto_param(btf, 5);
> +	btf__add_locsec(btf, "inline.text");
> +	btf__add_locsec_loc(btf, 3, 6, 64);
> +
> +	return btf;
> +}

This isn't a bug, but mk_btf() ends with a VALIDATE_RAW_BTF() sanity
check -- would it be worth adding one to mk_loc_btf() too (or capturing
the btf__add_*() return ids), so a construction failure shows up as
itself rather than as a dump diff?

> @@ -105,6 +134,26 @@ static char *dump_c(const char *btf_path, bool sorted)
>  	return buf;
>  }
>
> +static char *dump_raw(const char *btf_path)
> +{
> +	char args[MAX_BPFTOOL_CMD_LEN];
> +	char *buf;
> +	int err;
> +
> +	buf = malloc(DUMP_BUF_SZ);
> +	if (!ASSERT_OK_PTR(buf, "alloc_dump"))
> +		return NULL;
> +
> +	snprintf(args, sizeof(args), "btf dump file %s", btf_path);
> +	err = get_bpftool_command_output(args, buf, DUMP_BUF_SZ);
> +	if (!ASSERT_OK(err, "btf_dump_raw")) {
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	return buf;
> +}

This isn't a bug, but dump_raw() looks like dump_c() with a different
args string and tag -- would a shared helper that takes the extra
bpftool arguments and an assert tag cover both?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============0276429710653294798==--
