Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2153F1074
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371064; cv=none; b=ZS/phRVbfQRPSjbncTNsVlyCDsqmgZuUyrAfUfNywW3DxZDnYjcGzn8H5knMIETiwzDciVeiMSQQZ9mIerT+k3yrLTeHugAi3vCz1D3bERDXfUntCZoqD1O7BXGIM7IkLnD9D6l0UHR353FUvAOxjwY+/EEjGAPtBrapPIfy8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371064; c=relaxed/simple;
	bh=XPhGq8dnIYV04gpQkXsLdRPnwT9BShLXJtyZJ4ptcqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7SBX0BMnQymcOo8I7KZLezc2jWgkD7CddA6Bm6qOpEO+5e0cafuD5KcIUBgnhsKB1mq0nb6QvEmjLLH8xjJGwBaRYN4UCtv62TQzrivqBnYxDiVOJ7JDZJdo9XAAxpzq/6p7tTm263Zz852j/HAta6rEP/Fxqj21MNLgfLzzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrSZDvaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrSZDvaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C91F000FF;
	Fri, 25 Sep 2026 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790371062;
	bh=EsjCT/JcV2DUoCJfjhnJ2b318KnXH8spuGYW9q17PYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CrSZDvaqOeNSnljyi1bFQ8X37w/AcUwlmUDrfpHDqLUReRnP5wwm4s3KwkFapvifM
	 WeQb3lYD8lVcVmnjQuVBtmEJGR5J8nJJs7FlSpk4UbvpMk5h8liSME+GLGxHmayjtY
	 CBanH+OfwJA62d88BvkJ/w3MKtdBa+TVpEJVwohvTpFAob/A0MN6cNyS4sAjzECfrn
	 VUyw2/F2P8qznh7hSOocN0nJp9avNFxBmg6dZLa+HxsHZ9aM7jR8HE+x8dMb7mrnsr
	 yW69qWp94BG2kpzaIA8cico1srbwSPlv9i01sieF8OpVMpRwovUBahSq+GCfvBzWxw
	 Y5+CU3S3h4fGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH vfs v2] bpf: Allow bpf_d_path() from filp_close_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925210347.1364191-1-ihor.solodrai@linux.dev>
References: <20260925210347.1364191-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:17:41 +0000
Message-Id: <20260925211742.7B1C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] bpf: dead code in bpf_d_path_allowed for BPF_TRACE_FENTRY_MULTI
- [Low] bpf: build failure due to missing filp_close_sync BTF ID
- [Low] selftests/bpf: use of deprecated CHECK() macro when updating existi=
ng test
--

commit 83314c61560bbf42baf321997dbfd6e5b66818d7
Author: Ihor Solodrai <ihor.solodrai@linux.dev>
bpf: Allow bpf_d_path() from filp_close_sync()

This commit allows bpf_d_path() to be called from the filp_close_sync()
fentry program. It updates the allowlist and related selftests to reflect
the target function change introduced by recent VFS updates.

Link: https://lore.kernel.org/bpf/20260924204226.190315-1-ihor.solodrai@lin=
ux.dev/

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..c3b869646baeb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -974,6 +974,10 @@ BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
>  BTF_SET_END(btf_allowlist_d_path)
> =20
> +BTF_SET_START(btf_allowlist_d_path_fentry)
> +BTF_ID(func, filp_close_sync)

[Severity: Low]
Is this function available in the current tree? The commit message mentions
VFS commit c1ed65ea167b, but without it being merged, resolve_btfids will
abort the kernel build because it cannot find the target function
filp_close_sync.

> +BTF_SET_END(btf_allowlist_d_path_fentry)

[ ... ]

> -	return btf_id_set_contains(&btf_allowlist_d_path,
> -				   prog->aux->attach_btf_id);
> +	if (btf_id_set_contains(&btf_allowlist_d_path,
> +				prog->aux->attach_btf_id))
> +		return true;
> +
> +	if (btf_id_set_contains(&btf_allowlist_d_path_fentry,
> +				prog->aux->attach_btf_id))
> +		return prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY ||
> +		       prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY_MULTI;

[Severity: Low]
Could this check for BPF_TRACE_FENTRY_MULTI be unreachable? For multi-attach
programs, prog->aux->attach_btf_id is always initialized to a dummy ID
(bpf_multi_func_btf_id[0]) at program load time. Because this dummy ID is n=
ot
present in the btf_allowlist_d_path_fentry set, the btf_id_set_contains()
check evaluates to false before reaching the expected_attach_type condition.

> +
> +	return false;
>  }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index 1a2a2f1abf033..7665e1d28a641 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -165,7 +166,7 @@ static void test_d_path_basic(void)
> =20
>  	if (CHECK(!bss->called_close,
>  		  "close",
> -		  "trampoline for filp_close was not called\n"))
> +		  "trampoline for filp_close_sync was not called\n"))

[Severity: Low]
Since this test is being updated, should this deprecated CHECK() macro be
migrated to a modern ASSERT_*() macro? The BPF subsystem selftest standards
mandate using modern assertion macros when updating existing tests.

>  		goto cleanup;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/test=
ing/selftests/bpf/progs/test_d_path.c
> index 561b2f861808e..edb5494a47f74 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat=
 *stat,
>  	return 0;
>  }
> =20
> -SEC("fentry/filp_close")
> +SEC("fentry/filp_close_sync")

[Severity: Low]
Similar to the BTF ID issue above, will this test fail to load because
filp_close_sync does not exist in the current kernel tree?

>  int BPF_PROG(prog_close, struct file *file, void *id)
>  {
>  	pid_t pid =3D bpf_get_current_pid_tgid() >> 32;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925210347.1364=
191-1-ihor.solodrai@linux.dev?part=3D1
