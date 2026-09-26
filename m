Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D384352C28
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399921; cv=none; b=a8Ls7s1KV2udtO8QnAQKg7LBGnESBNdfkgNITWjrkBZM82UA0ETiu5L/pijWO++BTOsPrydI459WDp/cYy25QN3uRmeKI0+3zjBRHsm/1GSmKOfFVYA9U4GmQEbWv4zsIjph3UzhafiyntUcHorSwzs8EPijf3RKW0jc8AhidPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399921; c=relaxed/simple;
	bh=SlqZoxvD09uKxpqL4WnT1quALiGFGv1bxI+87zez7mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXw1EeEKX3463NO4iC36VJ1H0nhouqilQCg3vTMXnaSKfleuDO/l1z8LwIugBXeHqslxFHVgWAzJjccggHHrFZ89ctsA8wB66jo/O+n2SFPpBFj6P2/QaB+cPi+Mn54j0eyd6ZO27WN8KJPVpHcMZxbKF+LOcVApHNGYTkaxbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHfn5GEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHfn5GEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28911F000FF;
	Sat, 26 Sep 2026 05:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399920;
	bh=9F3Pitp5Vm2H9qDLckf9CCKmLDxSL+SpTbD2PrXaZQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHfn5GEaGp5ZrTucXrgUMaj/txxSGrvd16XBn8TbLn15dPhShrHF+rTausbQFsDIn
	 b1quRq6pyNMXkXDdT3J1UiH0N+gHzEEAYEvoi2QyMV3SXjyZ2S3niDDi13Qn6QN3Tq
	 jQLpebF00nlkhiyQvcIJODSZDn5PpX6AKXAUUQtNyrkG+UPpeX8f0rY8ZGdXSqlJOl
	 gvpTNRxuh8+4jxuMdLaU8UDt75QwrQWQwxapaIioeQzzEz/kO3Kmr8vSWhWyuSD84k
	 WG2lQqI+9/Rw9OX/RyUcY+1ttI6JeescIiczC9IGeN5nTWzyTJNR7eUsFmDkh6OilC
	 9z7Z1iR+TS7JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 19/21] selftests/bpf: Add __set_global() and
 __ret_global() test tags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050143.2222664-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050143.2222664-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:18:39 +0000
Message-Id: <20260926051839.F28911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: selftests: out-of-bounds heap access in access_global_var
- [Medium] bpf: selftests: multiple __set_global or __ret_global tags are s=
ilently overwritten
--

commit 81344b890bb87ceeed0ef105e0aab6e9d6797e2d
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add __set_global() and __ret_global() test tags

This commit adds __set_global() and __ret_global() tags to the BPF
test loader. These tags allow setting a program's global variable before
execution and verifying its value afterwards.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> @@ -311,6 +326,142 @@ static int parse_caps(const char *str, __u64 *val, =
const char *name)
> +static int parse_global_var(const char *str, char **var, __u64 *val, con=
st char *name)
> +{
> +	const char *colon =3D strrchr(str, ':');
> +	char *end;

[ ... ]

> +		term =3D end + 1;
> +	}
> +
> +	free(*var);
> +	*var =3D strndup(str, colon - str);

[Severity: Medium]
If a test author uses multiple __set_global() or __ret_global() tags in a
single test, does this silently overwrite the previous allocations? Only the
last tag seems to take effect, making it impossible to configure multiple
global variables in one test.

> +	if (!*var) {
> +		PRINT_FAIL("failed to allocate %s variable name\n", name);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int access_global_var(struct bpf_object *obj, const char *name,
> +			     __u64 *val, bool set)
> +{
> +	__u32 off, sz, zero =3D 0;
> +	struct bpf_map *map;
> +	size_t vsz;
> +	void *buf;
> +	int err;
> +
> +	err =3D find_global_var(obj, name, &map, &off, &sz);
> +	if (err)
> +		return err;
> +
> +	vsz =3D bpf_map__value_size(map);
> +	buf =3D calloc(1, vsz);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	err =3D bpf_map__lookup_elem(map, &zero, sizeof(zero), buf, vsz, 0);
> +	if (err) {
> +		PRINT_FAIL("failed to read '%s': %d\n", name, err);
> +		goto out;
> +	}
> +	if (!set) {
> +		*val =3D sz =3D=3D 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);

[Severity: Medium]
Is it possible to have an out-of-bounds heap read/write here? The function
find_global_var() extracts off and sz from BTF, but off + sz is never
validated against the buffer size vsz before accessing buf + off.

> +		goto out;
> +	}
> +	if (sz =3D=3D 4)
> +		*(__u32 *)(buf + off) =3D *val;
> +	else
> +		*(__u64 *)(buf + off) =3D *val;
> +	err =3D bpf_map__update_elem(map, &zero, sizeof(zero), buf, vsz, 0);
> +	if (err)
> +		PRINT_FAIL("failed to write '%s': %d\n", name, err);
> +out:
> +	free(buf);
> +	return err;
> +}

[ ... ]

> @@ -557,6 +708,24 @@ static int parse_test_spec(struct test_loader *teste=
r,
>  			spec->mode_mask |=3D UNPRIV;
>  			spec->unpriv.execute =3D true;
>  			has_unpriv_retval =3D true;
> +		} else if ((val =3D str_has_pfx(s, "test_global_set=3D"))) {
> +			err =3D parse_global_var(val, &spec->priv.set_global_var,
> +					       &spec->priv.set_global_val,
> +					       "__set_global");

[Severity: Medium]
Storing the variable in a singular field here also means that using multiple
__set_global() or __ret_global() tags will result in the earlier ones being
ignored. Should this support a list of variables instead?

> +			if (err)
> +				goto cleanup;
> +			spec->priv.has_set_global =3D true;
> +			spec->priv.execute =3D true;
> +			spec->mode_mask |=3D PRIV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D19
