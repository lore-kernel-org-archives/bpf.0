Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B93515DA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608474; cv=none; b=TWU37IXCogAhZpBYs0I8grDz/JbOtFRGbbmfsvQu340fpBxifFSNl40DAAwX4AmksiYpPLxmVsIleAPOD22GlQMXFHH3i17DC/GGMqt80wHcLwrroBAjiPVv1/mO41y1UqEwwwDcdISO9Iw/A8ZbJFLFKOEKtEpz48Q8iJ/Ghfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608474; c=relaxed/simple;
	bh=E9IxCt1qs9zRar51TjBxb0OyNLChg/BODe7MStRC6VI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RT5mnoaysCzptwV3bgwhETD7IGDkgJqODxK0ZhMFnBk/X9qiyAU3qaqBVSy1ckx0FmIq1n9TcfZihMS3TSqP8+4XBm8XOy8aiRotAjPkK+8Ul+aKQG2h0W06nzPH1pcdolrWiOUUS67+TpfaKqcMFGXCEJqGj1Tn8B2gCH8lyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB09Wad+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB09Wad+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBBF1F000FF;
	Thu, 17 Sep 2026 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608472;
	bh=ob9e/4dOGvR3gzKersJbH9YDfxKhqSO8vZHssei37+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lB09Wad+bglJRoB/7FkfvQJi6y+3o0z5f6hu+JD2/pFozoHWES258VYu0zMhRKpkB
	 9/Zw5yvdooq6guKznBD92bCBhQaGSL4F5Zu0ivHrKNS3mRAoP6cK0lKrCKLILMMv0+
	 POjBJU0jg+BCAd9o/2fvOl0GtRyGJybV6FEsajd7tCVQNbR6AXoxqyVT6fV6cMRbyI
	 cT1ebkMoKONONSPaVa3hdk22xY2bBIYQQa9peEt7Wc/frz6Kd0DmjGaijS5orcTXGk
	 llspwPC/8/0XShfN7bH0qzkOGyvrY4aoND0NNnLz3SkAHj0Vwq1xgwrHlgN4oh7Azz
	 h6MvAKp3tjJEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Show the tag kflag in
 the raw BTF dump helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917012037.1396254-5-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 01:27:51 +0000
Message-Id: <20260917012752.6CBBF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: NULL pointer dereference in test_btf_attrs on test failure
--

commit 551463268433576dd9cc5cc27a8ffb06a64ecabb
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

selftests/bpf: Show the tag kflag in the raw BTF dump helper

This commit updates fprintf_btf_type_raw() to print the kflag for
BTF_KIND_DECL_TAG and BTF_KIND_TYPE_TAG types. It also adds a new subtest
test_btf_attrs to prog_tests/btf_write.c to verify this behavior.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
> index 5c84723cf2540..7ddda9348e4fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> @@ -606,6 +606,64 @@ static void test_btf_add_btf_split()
[ ... ]
> +static void test_btf_attrs(void)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int id;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
> +		return;
> +
> +	id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");
> +
> +	id =3D btf__add_struct(btf, "s", 4);
> +	ASSERT_EQ(id, 2, "struct_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "field_ok");
> +
> +	id =3D btf__add_decl_tag(btf, "tag", 2, -1);
> +	ASSERT_EQ(id, 3, "decl_tag_id");
> +	t =3D btf__type_by_id(btf, 3);
> +	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "decl_tag_kind");

[Severity: Medium]
In BPF selftests, ASSERT_EQ() logs a failure but does not abort the executi=
on
of the test block. If btf__add_decl_tag() fails, the subsequent call to
btf__type_by_id() will return a NULL pointer.

Will this cause a NULL pointer dereference when t is passed to btf_kind(),
which unconditionally dereferences it?

> +	ASSERT_EQ(btf_kflag(t), 0, "decl_tag_kflag");
> +
> +	id =3D btf__add_decl_attr(btf, "tag", 2, -1);
> +	ASSERT_EQ(id, 4, "decl_attr_id");
> +	t =3D btf__type_by_id(btf, 4);
> +	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "decl_attr_kind");
> +	ASSERT_EQ(btf_kflag(t), 1, "decl_attr_kflag");
> +	ASSERT_EQ(t->type, 2, "decl_attr_type");
> +	ASSERT_EQ(btf_decl_tag(t)->component_idx, -1, "decl_attr_component_idx"=
);
> +
> +	id =3D btf__add_decl_attr(btf, "member_attr", 2, 0);
> +	ASSERT_EQ(id, 5, "member_attr_id");
> +	ASSERT_EQ(btf_decl_tag(btf__type_by_id(btf, 5))->component_idx, 0,
> +		  "member_attr_component_idx");

[Severity: Medium]
Similarly, could chaining a potential NULL return from btf__type_by_id()
directly into btf_decl_tag() lead to an out-of-bounds dereference due to
pointer arithmetic on NULL?

> +
> +	id =3D btf__add_type_tag(btf, "tag", 1);
> +	ASSERT_EQ(id, 6, "type_tag_id");
> +	ASSERT_EQ(btf_kflag(btf__type_by_id(btf, 6)), 0, "type_tag_kflag");

[Severity: Medium]
Is it possible that calling btf_kflag() on a potential NULL pointer from
btf__type_by_id() results in a segmentation fault if the type addition fail=
ed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917012037.1396=
254-1-ihor.solodrai@linux.dev?part=3D4
