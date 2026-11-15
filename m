Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733771;
	b=KTBdKZePeosEDeyS3lS1IpyfR/UOup01FS8PHYuKEsjWCs6YS5GYm125xCPuifKzNSup
	 vYzHU7FT1mL7/FWmOaBa98+44Nd6im8avDV9VCMV+1XaZT9fiAwmUTNewAfU2chvZQPtf
	 cVyOCMbi4bTnpaCUgT7oVwHMSSWYJw6ELrxgQU5N1elxbOr0VNb858+p0hz4jq/Z3rNAh
	 P+nC19C6P0mINIVSTon2P8w71+tnzQt194i7k0QUqpfdJDZWuDUNIE5cQtvUIlAB7AFSj
	 AIxo6HIMd7ltgPPDu4mdXOkVCT7vg8SO8zj4AadPv8o/sU65KwzE0UEiRwz2J4g2Pfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uFovKk5cdXE5I4O3uxg99AqolpAH6cV9t5HIdCMk60U=;
	b=ORUXc1DyGzB9ZxawIJdinlyBsqEx1qx49ZJH2/1tSdNOxJjbp2PYHniLRYRhFLaosago
	 w88PxotWhb0kPXSxPCNPhPsd5XBYSpxiv0mlha0oy5kjk9L28m8G6rzbKMK2vYyfVhV3k
	 MJ4/s8405/TKiHKdGIlZw/yFDlK3DEBL7cPSu205reY3cELDeBNRk0fKi/yjlxF524hLA
	 NPOjOBFQ6YQPJ/z8ix7m5n3NFj2ZsXqfARRJEtTPMwoQ+cK57B94WRKL7Z5yCKZ1asIHp
	 FpuD7/wRRzTX7poa1UUybubjwRYu/hYGZf1oE5sxgsknAfHFsIHQQqbKq+bEtLV7owQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8OONdX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D51606A31D
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8OONdX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D331F000C4;
	Sun, 15 Nov 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794733771;
	bh=uFovKk5cdXE5I4O3uxg99AqolpAH6cV9t5HIdCMk60U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m8OONdX+1zpBASvN8E55okDEnxR6TWcilo6ubpsrxQ2vWuKXP0zReeQ2XdOO2PYAN
	 RNYDK7fC0TsIJ3Ucmcv3qWBCEJGQZ1U1MV1CZ5ZrsIqyeeoFpLSiZSRPcdOvVnnD64
	 T2KFlOVyW4c4PwdgHRd7d47YnBQjzNDCxcL+xk7LTtpDxqIaxpU++emwNZowZNgWTf
	 bP9MbVszMfYeKuMJsWE27ckOi5M9hqS31FbvbPLVAQW4AAhKDC3mBDYOFAvk5x6LLz
	 Y2paY3xFF+qbaAJFW6urlLOx4NAvqkGRZ2czWT+FaY4efwW51eCktdRR7zS5ivUmx1
	 TT1tyDbIYDZ5A==
Message-ID: <sashiko-outbox-215331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Dump unaligned enums and
 a zeroed fs_context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261115084923.53182-3-dennylin0707@gmail.com>
References: <20261115084923.53182-1-dennylin0707@gmail.com>
 <20261115084923.53182-3-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 09:09:30 +0000
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
- [Medium] selftests/bpf: enum bitfield OOB read in
  btf_dump_type_data_check_zero()
--

commit 796295518e9df1f4059137fab9435ca1e6bd6793
Author: Hungyu Lin <dennylin0707@gmail.com>

selftests/bpf: Dump unaligned enums and a zeroed fs_context

This commit extends the BTF data dump selftests to dump a signed enum from
an unaligned address and a zeroed struct fs_context without emit_zeroes.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index b5c90f7293398..d6fd9933ff258 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
[ ... ]
> @@ -1182,6 +1184,12 @@ static void test_btf_dump_struct_data(struct btf *=
btf, struct btf_dump *d,
>  		type_sz =3D btf__resolve_size(btf, type_id);
>  		str[0] =3D '\0';
> =20
> +		/* 'phase' is an enum bitfield 3 bytes before the end */
> +		ret =3D btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts=
);
> +		ASSERT_EQ(ret, type_sz,
> +			  "unexpected return value dumping zeroed fs_context");

[Severity: Medium]
Does dumping struct fs_context with emit_zeroes set to false read 1 byte
past zero_data + type_sz when checking the phase enum bitfield?

In struct fs_context, phase is an 8-bit enum bitfield (t->size =3D=3D 4) pl=
aced
3 bytes before the end of the struct.  btf_dump_type_data_check_overflow()
checks bit_sz (1 byte) and allows the access, but
btf_dump_type_data_check_zero() ignores bit_sz for BTF_KIND_ENUM and
BTF_KIND_ENUM64 and reads the full t->size via btf_dump_get_enum_value():

tools/lib/bpf/btf_dump.c:btf_dump_type_data_check_zero() {
	...
	case BTF_KIND_INT:
		if (bit_sz)
			return btf_dump_bitfield_check_zero(d, t, data, bits_offset, bit_sz);
		return btf_dump_base_type_check_zero(d, t, id, data);
	...
	case BTF_KIND_ENUM:
	case BTF_KIND_ENUM64:
		err =3D btf_dump_get_enum_value(d, t, data, id, &value);
	...
}

Because data at type_sz - 3 is unaligned for a 4-byte enum,
btf_dump_get_enum_value() copies 4 bytes with memcpy(buf, data, t->size),
reading 1 byte past d->typed_dump->data_end and mixing adjacent bitfields
and out-of-bounds memory into the zero check.  In this test, passing the
oversized 512-byte zero_data buffer and only asserting ret =3D=3D type_sz h=
ides
the out-of-bounds read from AddressSanitizer.

Should btf_dump_type_data_check_zero() call btf_dump_bitfield_check_zero()
when bit_sz is non-zero for BTF_KIND_ENUM and BTF_KIND_ENUM64, matching
BTF_KIND_INT and btf_dump_dump_type_data()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115084923.5318=
2-1-dennylin0707@gmail.com?part=3D2
