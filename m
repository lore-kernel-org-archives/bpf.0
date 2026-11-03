Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676777;
	b=dqixVd6fV+PNfKYONElp4kw3/JUuYa2r5XrRSAp//YiUYaTSmxTjSD807M3c7ZJ+zZ4Z
	 m/12VJQ5ruAU2A2u/SJm08TXjddUSOxniGaQqz62nHKzwVajlA2zTTDOQfDX8X9hGwbVx
	 IVaeUWIjBkC2BbR+qKz0swhl/actA76EAfAzUCYL7mKftZ9CQ1+YC2yd0WPYHBXq2as0K
	 PUcuAWk7YsFqUm5diK8+Pixmjig76CjLTVs1QNuLUWZKmpth7kofP8S6XZcB4FyD90h/c
	 Ub2jzW6fkWmTjf26kH9j20pklhbZj16ndOZRmpkBFKC4Kc05osun6KVJlvu1TzerDqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JxhW9dG6cYmQ5UijK/Xj6wGP+4rIcfFWx2TW6kgtn1E=;
	b=O8Ogwn0Yt1WqEyWTyfh1vRabS+sQk7GtFTQsalYoNeScz+TQMjRFlMltbKICEdR4lrYq
	 1HgYIRYujTtEEwCQSsvc556b3QzO3yE/iZasPE8AkBTqUOP6DZdYISE5z+y4t3SZm7lUj
	 it0ZVXtqUBx2fc7L1p4IHTD7DKd71nIc+n3jzpVRVcg17w22koZAJ0wmKtRNCkIq47AgN
	 nzI0ElqEcLvDiO6uPiHNkrEgBVuULL5GE1YWbobZqPp4Dq4amJ+QBQyYaXtaYrilJ0/jT
	 Q0WTeXXOVkg1sglCPjnxUEC1YWmXNY/QN+05yLOwtmSwu95PVEOdDj7eJWD7lNn/xHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb+yIX+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B52606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb+yIX+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F51F000C1;
	Tue,  3 Nov 2026 03:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676776;
	bh=JxhW9dG6cYmQ5UijK/Xj6wGP+4rIcfFWx2TW6kgtn1E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mb+yIX+Bu8z6wW+V13qJfwflZ51gqcfRwBnZgHzOhuAJPwsZVkb1FCai2bMIkfE8V
	 ik3uUCHsVU3m7P2CbPg2ZaSIfbwq4B0SKZP0sFxSjY9Vipd3Q9VIA2cOfgBe9si69l
	 q38fUk1hh0Scr+268Lw2gv8uQOS8VR6elLSfoPqznEhfh9AIBysy76CSkNJchiT7Fs
	 d7+RqDYAR/w3NJKHHSaRQJ2uo65zB+pd6CsLK+j3i3yW/WFk6xISM2a2p5a7bJlOE5
	 7AI0nLz49vB6QNf+vy5swYj8oRV+JIBWSttePYxZlzlkBUrMNCsTXwoluGux1j2GDH
	 M8/rfzsfVPyWw==
Message-ID: <sashiko-outbox-194519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add overflow test for
 BTF dump zero-scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>, bpf@vger.kernel.org
In-Reply-To: <20261103032619.1378-3-gubin@cmss.chinamobile.com>
References: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
 <20261103032619.1378-1-gubin@cmss.chinamobile.com>
 <20261103032619.1378-3-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:32:55 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: wrong expected_val in test_btf_dump_struct_data()=
 overflow test
- [Low] selftests/bpf: multi-line comment style in test_btf_dump_struct_dat=
a()
--

commit c037995f7dcc94c6cb7bb8863c0b417b37425882
Author: Gu Bin <gubin@cmss.chinamobile.com>

selftests/bpf: Add overflow test for BTF dump zero-scan

This commit adds a TEST_BTF_DUMP_DATA_OVER() test case in
test_btf_dump_struct_data() that dumps an all-zero union bpf_iter_link_info
with a data_sz one byte short of the type size to verify that the zero-scan
returns -E2BIG instead of reading past data_end.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index dbef014f75acd..f6cff6cc56c4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -1161,6 +1161,13 @@ static void test_btf_dump_struct_data(struct btf *=
btf, struct btf_dump *d,
>  			   "(union bpf_iter_link_info){.cgroup =3D (struct){.cgroup_fd =3D (_=
_u32)1,},.task =3D (struct){.pid =3D (__u32)1,},}",
>  			   { .cgroup =3D { .cgroup_fd =3D 1 }});
> =20
> +	/* overflow test for all-zero union: with a data_sz one byte short
> +	 * of the type size, the zero-scan must not read past data_end and
> +	 * must return -E2BIG.
> +	 */

[Severity: Low]
This isn't a bug, but in BPF code multi-line comments place the opening /*
on its own line with the comment text starting on the next line. Could this
comment be formatted to match the BPF style?

> +	TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link_info,
> +				sizeof(union bpf_iter_link_info) - 1, "", {});

[Severity: Medium]
Will this test fail the expected string check in btf_dump_data()?

When btf_dump__dump_type_data() enters btf_dump_dump_type_data() at
d->typed_dump->depth =3D=3D 0 for a union:

tools/lib/bpf/btf_dump.c:btf_dump_dump_type_data() {
	size =3D btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bi=
t_sz);
	if (size < 0)
		return size;
	err =3D btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
	if (err) {
		...
	}
	btf_dump_data_pfx(d);

	if (!d->typed_dump->skip_names) {
		if (fname && strlen(fname) > 0)
			btf_dump_printf(d, ".%s =3D ", fname);
		btf_dump_emit_type_cast(d, id, true);
	}
}

At depth =3D=3D 0, btf_dump_type_data_check_overflow() only checks base typ=
es and
returns the union size (16), and btf_dump_type_data_check_zero() immediately
returns 0. Then btf_dump_emit_type_cast() and btf_dump_struct_data() emit
"(union bpf_iter_link_info){\n" into str before iterating over the union
members at depth =3D=3D 1, where btf_dump_type_data_check_zero() on the .cg=
roup
member detects the overflow and returns -E2BIG.

In btf_dump_data(), after verifying that btf_dump__dump_type_data() returns
-E2BIG, it checks:

	if (!ASSERT_STREQ(str, expected_val, "ensure expected/actual match"))
		return -EFAULT;

Because str contains "(union bpf_iter_link_info){\n" while expected_val is
passed as "", shouldn't expected_val be "(union bpf_iter_link_info){\n" here
(similar to the atomic_t overflow test in test_btf_dump_int_data())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103032619.1378=
-1-gubin@cmss.chinamobile.com?part=3D2
