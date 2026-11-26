Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716032;
	b=UYZbpdS82u7FELvadmL4irWzwymt6w9FgIcKXmWofrEu1zIFNtZ+fteM7f2xWPIumHQT
	 bH2rld73bF4m8bNW6CiO2Xq81AWuM+k8Pqr1BWwxtYT679bwsQjqXce6/VSYfS2t1ZFW8
	 6SwgG4xI2dMHA3ZxO/VYrdsvlnWzVK/PuXObeClVHOGgKMmaJCgwMEVsE0G/JkmKlQVU8
	 C2WWJhX0f+Vf9mXBBv8Ie3LkouMcrSttVnQiedvReUaNLjcYRSZpV4sBpO1OIdz0jHZH+
	 Qj409LTxeq0JUb5jLZozr1YfHD6bN5mRWhqikdAbC/zT2cfmmEs4br0Bp1BLLkbuStA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lRvYYmDZfWxGSUqDOxvo3toDW0SAzA59L8JKjdJoavI=;
	b=BOTgbEUxa9OeLWCN8tCsKrAznaO7K0RxDxZ4LlXn8AzT+UxxJzsctpcDPSFmNmw5z6Ns
	 RWUY9rlvVg0XlFeLYze8D41BpAMsnTCp05QD9h5qkci/g0I2wbneglOdMW2s1h8OwwlMj
	 qK/Eo1/vmef5l8293iYOPC5jnv1MhfhHMNKEVxRUSdKYdjJKtC+IKIcXwKbtcdyBGmWmO
	 jpsb/riMMQJonizcHcatvZa/JERhQA89Uz4Fj0LEGUwuEN41tq9z+mGBnevUtWlTu7dHL
	 JHz7Ydj4/dt8vseRCiPBiqMXifSLefwcAwatp6g+PhY6GcB88SKHEgZAgN1Ukgz02OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7W20Pct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE25606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7W20Pct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2674E1F000C0;
	Thu, 26 Nov 2026 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716032;
	bh=lRvYYmDZfWxGSUqDOxvo3toDW0SAzA59L8JKjdJoavI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F7W20Pctv2tcwkkYuDxJY5MGqhscvVTs2BN5N8guQtgUekPiim+E9BDb40FUpXRud
	 RXHPB98JfTAcpy6k1nkApRPg2X0HIbF5eAEuJZprKQnM7Hhe0eEeKZTBsjvtMQ3pkw
	 QwhQ5wWZSZVfEevQ8l3pYE8mZmjnXJj86bLX/5g+snl+oAC72t3hAdq+A/GWmAfz79
	 H1XEtB1MITkKGvucqdmdkRUFf1rvHHopeXHJapxsjfXQIl37RvTk7dTVZe9ranG8J/
	 xtW/D7PK7mSnhqVXqTel0CwJLksMtiXLK5EluG/X0dCD+r22dPe3sz8huI7PxJRIts
	 G3cNm9w0UcP3A==
Message-ID: <sashiko-outbox-235985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Test enum value relocations
 within the local enumerator range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261126175613.1883881-1-yonghong.song@linux.dev>
References: <20261126175602.1882988-1-yonghong.song@linux.dev>
 <20261126175613.1883881-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 18:00:31 +0000
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
- [Low] selftests/bpf: non-standard multi-line comment style in
  core_reloc_types.h
--

commit 7b2de00cc3d3bd98446d7a82129006ec470a720b
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Test enum value relocations within the local enumerator range

This commit adds CO-RE enum value relocation tests for target enum values
that fit within the range of the local enumerator type across 8-byte,
negative, and unpacked 1-byte target enums.

> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
> index 6d758e74bd586..116a67fdd1b2e 100644
> --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
> +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h

[ ... ]

> @@ -1355,6 +1363,52 @@ struct core_reloc_enumval___err_missing {
>  	anon_enum___err_missing f2;
>  };
> =20
> +/* 8-byte target enums, whose relocated values fit in the int enumerator=
s of
> + * the local enums
> + */
> +enum named_enum___enum64 {
> +	NAMED_ENUM_VAL1___enum64 =3D 1001,
> +	NAMED_ENUM_VAL2___enum64 =3D 2002,
> +	NAMED_ENUM_VAL3___enum64 =3D 0x300000000ULL,
> +};
> +
> +typedef enum {
> +	ANON_ENUM_VAL1___enum64 =3D 0x11,
> +	ANON_ENUM_VAL2___enum64 =3D 0x22,
> +	ANON_ENUM_VAL3___enum64 =3D 0x300000000ULL,
> +} anon_enum___enum64;
> +
> +struct core_reloc_enumval___enum64 {
> +	enum named_enum___enum64 f1;
> +	anon_enum___enum64 f2;
> +};
> +
> +/* negative value for an int enumerator */
> +typedef enum {
> +	ANON_ENUM_VAL1___negative =3D -0x10,
> +	ANON_ENUM_VAL2___negative =3D 0x20,
> +	ANON_ENUM_VAL3___negative =3D 0x30,
> +} anon_enum___negative;
> +
> +struct core_reloc_enumval___negative {
> +	enum named_enum f1;
> +	anon_enum___negative f2;
> +};
> +
> +/* 4-byte target enum with a value out of a byte, for the int enumerator=
s of
> + * the local 1-byte enum
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of multi-line
comments on its own line in these two comments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126175602.1882=
988-1-yonghong.song@linux.dev?part=3D2
