Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6A24B28
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290842; cv=none; b=UfLhw4Q+L6HzzS3TYSEZoUOh8xmde85anNkK1axWs6RIdztsCzs6cjXgH2a5m+P152PTYRtQOHzZJ6s9Gd+vCgOdp4hv7/3fkj4JXnuqlO1cCE/Oo85mhXFNcKmNjSDuFXrgbIFOtinID1QKmNfWlPSY259vVG34LVEJZ4u1E68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290842; c=relaxed/simple;
	bh=Xzn1S2txrhvM7JgRtNtYkUjdOKDS5BVmmxsAeiyy37U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fc4jkpe+S3a8Xf2H8giP87uQocZe7fErbuJvRotpqOZ39co31kh+8olGnzVctYDczwS+Jq0VaL13GeagfKCD/A/3vHuIJYjt9Redz6d4stiX/bJHs9viSKx31BcAhn0KYXkG5k8PX7kUYjhzf+qmJm+R0vfen5p/T3WbzgMQJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4CfeVf7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4CfeVf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A3DC2BCB0;
	Sat,  9 May 2026 01:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290842;
	bh=Xzn1S2txrhvM7JgRtNtYkUjdOKDS5BVmmxsAeiyy37U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=r4CfeVf78CJOme6rXdU5PHXMN/4S8LnmTWvjEHLutRVHr+bVcJ98jjqGnLQfXP6Y5
	 yj3WMtzuk4PSiQHR7KCoIGmKxDUO8EbF+mQ7C2+M4b9dHn+uMdaT2to2fmxvgvJeCD
	 oe9eL2wK0/n+TepJLzV5w2sAe3Bhj2qLgEcTlOCkuMuA9bK4hOCLXJarOnIsXsUeYo
	 lsPmY6OZKYz74ugsTo5DGho+meq25Z11zmvk/JS/XJASlC+SuhxhrI77IddijqhgpR
	 whvrBA9IHkkUYA4N0KMz3MYsffNF7hjtL4jw/YcersO9rvvvPCGIvZm8H/FpzeG14u
	 hBpzE3MA9QX+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/23] selftests/bpf: Add BTF fixup for
 __naked subprog parameter names
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213140.1138756-1-yonghong.song@linux.dev>
References: <20260507213140.1138756-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 01:40:41 +0000
Message-Id: <20260509014042.03A3DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BPF object 'tobj' is leaked when 'fixup_btf_from_path()' fai=
ls.
--

commit af529dd65e68c8ac479551b0ac6332c3b5f56771
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add BTF fixup for __naked subprog parameter names

This commit adds a mechanism to fix up missing parameter names in the BTF
FUNC_PROTO entries of __naked subprogs by reading them from a separate BTF
file. This allows the verifier to resolve stack argument slots by name.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> @@ -1231,13 +1351,27 @@ void run_subtest(struct test_loader *tester,
>  		}
>  	}
> =20
> -	/* Implicitly reset to NULL if next test case doesn't specify */
> +	/* Implicitly reset to NULL if next test case doesn't specify.
> +	 * btf_custom_func_path also serves as btf_custom_path for kfunc resolu=
tion.
> +	 */
>  	open_opts->btf_custom_path =3D spec->btf_custom_path;
> +	if (!open_opts->btf_custom_path)
> +		open_opts->btf_custom_path =3D spec->btf_custom_func_path;
> =20
>  	tobj =3D bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
>  	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
>  		goto subtest_cleanup;
> =20
> +	/* Fix up __naked subprog BTF using a separate file with named params */
> +	if (spec->btf_custom_func_path) {
> +		err =3D fixup_btf_from_path(tobj, spec->btf_custom_func_path);
> +		if (err) {
> +			PRINT_FAIL("failed to fixup BTF from %s: %d\n",
> +				   spec->btf_custom_func_path, err);
> +			goto subtest_cleanup;

Does this error path leak tobj?

If fixup_btf_from_path() fails, the code jumps to subtest_cleanup, which
appears to bypass the tobj_cleanup label where tobj would normally be
closed and freed. Should this be goto tobj_cleanup instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D18
