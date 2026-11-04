Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762596;
	b=eEm9yOlEQTeIRowADi59cvgzPKKV7G3h3lLF96T8QpXFVMoltrmeaC4m0562kwW2M8OQ
	 76fveDQMess0CYhO/zU5dsfclnU3Xpd2p2TDABD3MgKFMxSv+h2UvBX37VWNSExV1LwSc
	 wfQssJLV7dj7BfQ9+gm3Aw8OjvJhrZX9+7qby2BURusXFm1W2eSPMygkJEVFDMt3XB8nz
	 zYR0EN06PZa/CMM5KrqNkhkM/yh5xkdXdycfl5gLffiYLDaZM0fmtPetwUdWMkuR6WdA/
	 YKeaIOR1EeqCFx3NAvz/fPrbjn+VFuQx1YMFWRrR6BQi2py4RgXmVyvjkeWp8179Gmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fo4ptXWeTkboDnVscHFNg+sSYsBpoQUwU/OqhLVgap0=;
	b=QV2f6x22VRKk6cFRpemEng30oY4hBXHHbT9q2SD9pcHN+LZZmFLc92E7V1woE4l+XmvQ
	 42WFfjrTEujTvLLrbzVo6A8UXwjgvsy+EZxtipfGz30NbA/+Bk3j2TKN6oDsxjl7dds+X
	 7ZnFLX1VQWFc/FgESysjeWHunghusnu4gqM8/GmYYoKt1OqO4mqFl93UkGvwKm3SOpgUv
	 3COZFjarCzHbXDZ+5c/4K9zFvFWWqVWwti4pCHS0LvVSoD8wF18DdNnPIvsMRkJV07oNh
	 0Csjsfn1RzMCEnVzY9wH0u2tpYCS9uI0tZzYeNj4FrfAPjn+JYKlJ0VTH7il1fD5aGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjqL9obg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A50606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjqL9obg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086861F000C1;
	Wed,  4 Nov 2026 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762596;
	bh=Fo4ptXWeTkboDnVscHFNg+sSYsBpoQUwU/OqhLVgap0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CjqL9obgIMeiNERc/MDZnGBFhX4HAiAVqMiqfDmKKZxmF2Ng84sR8fa1ntEphULjy
	 jVrlbyrJ4TSbDlH5h/tG/5+Fc+18nirp82TgVsyk9TwBeEWl4AyQt1mTz9/dzCVtV6
	 gMX4JRRx/opsaHkHAVZxQ+WyQ4qos9ZnopVScqPfUXIGFNT5E9ZXZMlbsdR3cj1g7y
	 sL/cT6oHrqSix5l9hCTc5fypXMPODeKrOuBHmjiTkqMmNcieepQSNwN8njbXG91M+Y
	 GnhuINJcEOQva3WYqpi7j8IdDGMpSrL9Ay0WJA8JZc3II9uNJMyQbFwLLpjH8wkXVD
	 mE2fYjez6vd8Q==
Message-ID: <sashiko-outbox-196596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add overflow test for
 BTF dump zero-scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>, bpf@vger.kernel.org
In-Reply-To: <20261104025806.1693-3-gubin@cmss.chinamobile.com>
References: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
 <20261104025806.1693-1-gubin@cmss.chinamobile.com>
 <20261104025806.1693-3-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:23:15 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: test_btf_dump_struct_data() fails on ENODATA check
--

commit 1be6c5280eb4868315725b469eaa863a95165c0b
Author: Gu Bin <gubin@cmss.chinamobile.com>

selftests/bpf: Add overflow test for BTF dump zero-scan

This patch adds a TEST_BTF_DUMP_DATA_OVER() selftest case in
test_btf_dump_struct_data() that dumps an all-zero union bpf_iter_link_info
with a data_sz one byte short of the type size, expecting
btf_dump__dump_type_data() to return -E2BIG.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index 35f214e254da8..68f33f8a54ab8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -1156,6 +1156,15 @@ static void test_btf_dump_struct_data(struct btf *=
btf, struct btf_dump *d,
>  			   "(union bpf_iter_link_info){.map =3D (struct){.map_fd =3D (__u32)1=
,},.cgroup =3D (struct){.order =3D (enum bpf_cgroup_iter_order)BPF_CGROUP_I=
TER_SELF_ONLY,.cgroup_fd =3D (__u32)1,},.task =3D (struct){.tid =3D (__u32)=
1,.pid =3D (__u32)1,},}",
>  			   { .cgroup =3D { .order =3D 1, .cgroup_fd =3D 1, }});
> =20
> +	/*
> +	 * overflow test for all-zero union: with a data_sz one byte short
> +	 * of the type size, the zero-scan must not read past data_end and
> +	 * must return -E2BIG.
> +	 */
> +	TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link_info,
> +				sizeof(union bpf_iter_link_info) - 1,
> +				"(union bpf_iter_link_info){\n", {});

[Severity: Medium]
As reported by Alexei Starovoitov on v3 [1], does this new test pass when
running test_progs?

When btf_dump_struct_data() iterates over the members of union
bpf_iter_link_info at depth 1, it invokes btf_dump_type_data_check_zero() on
the nested structs (.map, .cgroup, and .task). In
tools/lib/bpf/btf_dump.c:btf_dump_type_data_check_zero():

	case BTF_KIND_STRUCT:
	case BTF_KIND_UNION: {
		...
		for (i =3D 0; i < n; i++, m++) {
			...
			err =3D btf_dump_type_data_check_zero(d, mtype, m->type, data + moffset =
/ 8,
							    moffset % 8, bit_sz);
			if (err !=3D ENODATA)
				return err;
		}
		return -ENODATA;
	}

When checking the first member of .cgroup (.cgroup.order, a 4-byte enum at
offset 0), the recursive call sees a zero value within data_end and returns
-ENODATA. Because the loop compares err against positive ENODATA instead of
-ENODATA, -ENODATA !=3D ENODATA evaluates to true and the loop returns
-ENODATA immediately after i =3D=3D 0 without ever reaching .cgroup.cgroup_=
id at
offset 8 (the only member extending past sizeof(union bpf_iter_link_info) -=
 1).

Consequently, all union members are skipped as zeroed,
btf_dump__dump_type_data() returns 16 instead of -E2BIG, and str contains
"(union bpf_iter_link_info){\n}", failing the assertions in btf_dump_data().

[1] https://lore.kernel.org/r/DMLAKLO9AB4T.X5JCIISSONLF@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025806.1693=
-1-gubin@cmss.chinamobile.com?part=3D2
