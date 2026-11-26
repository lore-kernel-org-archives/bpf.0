Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703255;
	b=AZk85ujJqSzopmWFKFuTq0k76kZWEzlct8i1Yp3mpv4TjhwcSonJNqGtnNSTF7XDN+bw
	 fXeuJKVqewzGtziIDoFctIgaKJDVtlVNjToYYlC096fIxcbp2IM1vzFiXbh5MZmkm/T0e
	 BgjMDGzzrcpB/Ve7m1fyw/t0zTz6CpDtGyPuoLNI8j68a2LS+XoO6xd32Ll2Da9z0s35z
	 nU1s09SDM8ZOYBTmLtvWEF6iaBwB0zo+mnutu93Aj300Q/M9qQnFf1eD0QdIPGmGA3p0L
	 B1NMAV8UBHvAU27N0h3Xe6IEYa7jUsoqSSgb1oVZkg43Nn8M0BHkZgbwB7UzBCwA7/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IzU9OGONA8Kfie9ObCLUApPnMIlV90vU57cP5+15laM=;
	b=aAQfYEdEU7sJP4v0tNnm0J5AJK4U7406O5uwsBpoSLfw9lnsCCnn9cbympybyAaOkj+d
	 lBi9RK7LvQ5HEd+dPBHJCkfEP5AXgThObPbEkLw/7PwW4hZnAsbPY9vyKdO9pPTwxr/U+
	 nK2d1ECQqJscFfdpcFXwpITAnK2ZenelUysAVmC7cbhwsU6kgJ0f0GqXAehe4eVQE+8fD
	 p02dNYBCQuzHxDqPB1HcO8Pvu5cVv1QonlFmaeLxj7Do+X107O3JDdENUXk1rXxv3EKgo
	 2quSX2w+iJQYQfffqeWPklMcd98biwhMQE1emlACEFK1P+SJ+QfxxQizdVNccLYIFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg8suqzm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5410606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg8suqzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B991F000C0;
	Thu, 26 Nov 2026 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703255;
	bh=IzU9OGONA8Kfie9ObCLUApPnMIlV90vU57cP5+15laM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Tg8suqzmqylKaH1SN4DlyINQ74N6K0tvZeSp4CCv0XSkbYwfzmnbg7AJFEupMMyXH
	 JgMnNVPX2Ysd4/doE9s6gMyyCWKqJDgmpNY2BVo1nChH+ECDrVoUXMjCQXvnpb/yCu
	 azAJOSCX/TR0Ej3dunDsKx2HcLgbU0Ay/THJp4qgurzqrxg8kckRZBHq/H4LZfjM/z
	 8YfeY0E7NpENrWyv/wpsCicPwT3b7SCPGUHGSmJa/nKM0wfpJh/TEDux4go15i6StJ
	 DGUpaKMj6odn+1scF/JBTPKcaXQwMOCUcsa7T5+WXU6/8qa49gr2LyoBmPkYSvjdBQ
	 HROr7rw+0SaPA==
Message-ID: <sashiko-outbox-235702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: Test functions which
 must have no fmod_ret tag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261126142915.1106330-8-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-8-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:27:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: fmodret_untagged.c duplicates fmodret_retval.c
  BTF tag test
--

commit 6b9f59cbaa78b14e32ed408a9747440fae862df8
Author: Anton Protopopov <a.s.protopopov@gmail.com>

selftests/bpf: Test functions which must have no fmod_ret tag

This commit adds a BPF selftest that loads vmlinux BTF and verifies that
specific kernel functions are not tagged with bpf_fmodret_retval:.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c b/=
tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
> new file mode 100644
> index 0000000000000..9f4b0586fe8f0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Functions which return errors, but which the build must not tag as fm=
od_ret targets */
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#define TAG "bpf_fmodret_retval:"

[ ... ]

> +/* Has the build tagged the function FUNC_ID, or any function if FUNC_ID=
 is 0? */
> +static bool tagged(const struct btf *btf, int func_id)
> +{
> +	int id;
> +
> +	for (id =3D 1; id < btf__type_cnt(btf); id++) {
> +		const struct btf_type *t =3D btf__type_by_id(btf, id);
> +		const char *name =3D btf__name_by_offset(btf, t->name_off);
> +
> +		if (btf_is_decl_tag(t) && (!func_id || t->type =3D=3D func_id) &&
> +		    !strncmp(name, TAG, strlen(TAG)))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +void test_fmodret_untagged(void)
> +{
> +	struct btf *btf;
> +	int i, id;
> +
> +	btf =3D btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return;
> +	if (!tagged(btf, 0)) {
> +		printf("%s:SKIP:no CONFIG_BPF_FMODRET_SCAN\n", __func__);
> +		test__skip();
> +		goto out;
> +	}
> +	for (i =3D 0; i < ARRAY_SIZE(funcs); i++) {
> +		id =3D btf__find_by_name_kind(btf, funcs[i], BTF_KIND_FUNC);
> +		if (ASSERT_GT(id, 0, funcs[i]))
> +			ASSERT_FALSE(tagged(btf, id), funcs[i]);
> +	}
> +out:
> +	btf__free(btf);
> +}

[Severity: Low]
This isn't a bug, but could these untagged vmlinux function checks be folded
into tools/testing/selftests/bpf/prog_tests/fmodret_retval.c instead of add=
ing
a separate standalone test file?

test_fmodret_retval() in that file already loads vmlinux_btf, checks for
CONFIG_BPF_FMODRET_SCAN, and scans BTF_KIND_DECL_TAG entries for
bpf_fmodret_retval: via tagged_errors().  Adjusting tagged_errors() to star=
t at
id =3D btf__base_btf(btf) ? btf__type_cnt(btf__base_btf(btf)) : 1 would let
test_fmodret_retval() check these vmlinux functions directly without
duplicating the BTF load, tag lookup, and skip handling.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126142915.1106=
330-1-a.s.protopopov@gmail.com?part=3D7
