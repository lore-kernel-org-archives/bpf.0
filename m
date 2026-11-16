Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817245;
	b=OfseuphBWEWH33FVl1yFtSPCMHNZu4yCPTShflBAiuVLu0klq/1WJxk1A4JPLT6/sBjH
	 zMPXCpzIA2k9bupziFKCAEkluLK0BACY389VB1O7kjATmEAhU/l9fpkM8y5le4gkYmMW1
	 nWtI+Kl3lkmHviBLvtucLdFZujoWtegiY58StBB/4MUa0LNcYzc6fS1IUxWGDNepQegUo
	 73HuikMszQ8nGdTgwZ2uN5CRiPG7+ZCv9ZIRkkG4N1lxVFTlPWe5NYJH+qq1J7Dh/fYNJ
	 eygB1XQrcRhAOhhKT8BLLkQuvkEkjTHnnsrmgEJwMpNdAUZnCLQfiLadZH4u4OZb9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LuFvEEG6esClnVl/qeOY3LB1RlCq/q42sTjoGxHtJSg=;
	b=suURlxIHRG1K2i0xH6bHkgqZpJ2IhiYOhoOkkPdlscX5WmqM+OPJwKlRn3UGusIyjGqH
	 6ErNCpKmqk0OBfUcnUIfxiGZhL76TH6kGaRH74722BhhPHQihH95VAcgtSw6CCHA2NeFF
	 TT9Jqt+s2+/x1v4rCaHz4vj/U8U7EMrcqXEsWkg905GEARUJYmKHkQpPWkt2Hes7a7Pqh
	 9bH2m2vRHiovnKg7+zBsj0J9Dvt65DCHRQ/PKoHRJXov0SWubu2pNBttPKd3CxtdXPIyP
	 cwMpE7B3+2StfcYyovTvfZjGU5ScwIEDioV3F7YBE0RodHL6Ko9KHbdMkqlQNJrR5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9ggyewc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F6606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9ggyewc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899661F000C4;
	Mon, 16 Nov 2026 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794817245;
	bh=LuFvEEG6esClnVl/qeOY3LB1RlCq/q42sTjoGxHtJSg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Q9ggyewc2KSgJIa68V8JmVsWOfGoNrA9OEGRp0zbEOPADTmns58pN0X5fbe+bOJfi
	 T1ka/UfzHO1UFbJXOomYhO+RyxKVaXYN8xS41PVDTtRtKQCmV2f57XcZxCHinQRllP
	 h1YvawXsAnv8MJjBJj4vhEaHX3fgwhBZR0N8PkhDsH5AXsLU2zIC1oXcN3kSmmTVnO
	 3RgJg3MEioSL6j2Hcova6Kw5hUdxmtogBUvAmC8LZW0M40Gycf+MBKzAydwxn7vlag
	 mUvb6VT9SDbRwWfThXo5J3kRKeCvLog5WUpkAr9hEJFN+iiRkVbraBZdqKUkhmDO9X
	 e8I+cITjUi6Fw==
Message-ID: <sashiko-outbox-216524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Dump unaligned enums and
 a zeroed fs_context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116080151.44860-3-dennylin0707@gmail.com>
References: <20261116080151.44860-1-dennylin0707@gmail.com>
 <20261116080151.44860-3-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:20:45 +0000
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

commit b08982c8f9a5f24d9685e27855c93f8136d3ee81
Author: Hungyu Lin <dennylin0707@gmail.com>

selftests/bpf: Dump unaligned enums and a zeroed fs_context

This commit extends the BTF dump selftests to dump a signed enum from an
unaligned address and a zeroed struct fs_context without emit_zeroes.

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
> +
> +		str[0] =3D '\0';
>  		opts.emit_zeroes =3D true;
>  		ret =3D btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts=
);
>  		ASSERT_EQ(ret, type_sz,

[Severity: Medium]
Does dumping struct fs_context with emit_zeroes unset read 1 byte past
zero_data + type_sz when checking the phase enum bitfield?

In struct fs_context, phase is an 8-bit enum bitfield at byte offset
type_sz - 3 whose underlying enum type has t->size =3D=3D 4.
btf_dump_type_data_check_overflow() only checks that the 1 byte covering
bit_sz fits before data_end, but btf_dump_type_data_check_zero() ignores
bit_sz for BTF_KIND_ENUM and reads a full t->size (4-byte) enum via
btf_dump_get_enum_value():

tools/lib/bpf/btf_dump.c:btf_dump_type_data_check_zero() {
	case BTF_KIND_INT:
		if (bit_sz)
			return btf_dump_bitfield_check_zero(d, t, data, bits_offset, bit_sz);
		return btf_dump_base_type_check_zero(d, t, id, data);
...
	case BTF_KIND_ENUM:
	case BTF_KIND_ENUM64:
		err =3D btf_dump_get_enum_value(d, t, data, id, &value);
}

Because data is unaligned at offset type_sz - 3, btf_dump_get_enum_value()
calls memcpy(buf, data, t->size), reading 1 byte past data_end and mixing
adjacent bitfields (such as need_free) and trailing bytes into the zero
check.  Even if btf_dump_bitfield_check_zero() were used,
btf_dump_get_bitfield_value() bounds-checks nr_bytes (1) against data_end
before looping over t->size (4) bytes, which also reads 1 byte past
data_end.  Passing the 512-byte zero_data stack buffer here masks the
out-of-bounds read from AddressSanitizer and from the return-value check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116080151.4486=
0-1-dennylin0707@gmail.com?part=3D2
