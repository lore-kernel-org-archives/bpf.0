Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610549;
	b=21EQv6ZUCUnECMi4zWvezyEOWANr5CAueL2L46AmrQGYTn65k/PnExxrx2MS7HAlszXS
	 h1/HLw18m+YftTAjTxG0jOH6GonhKWX+MQ8DnphAQnytwcm77TXZj2FfLKruE0groF0/i
	 U5sx7EeNwd55XSWZxhtxRTTEwxTKY25G25Gwt5Xhp4CGpH1VMn/5os5uS9CzaG2+RKxm9
	 yrSqFB13Gvd83kEJyepaCSc/7MquxZtKQHCsaMncb/Q7tMiOYlmfBX0yNHAFPTuZe0zir
	 ozvL7QuvZXON4gxKJdshPz5GZn79VSKGHNmMPsZT2cOmvkP3vd0h7byESK8Ek5pRGtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FM9UAblZjAoFoMq/VXmoefX20CG318XawGlW2CzYy0Q=;
	b=Es3hopsoS+lKzNVrBJTrUW9gexFV3quxc21YTJeJH6JX7Xhxm0eKp7q70STcw6anD1Zc
	 M8Yu+Fp1KT08eSUif74vPbqqc7UcJYQdwbeZ6SSKjxSauMtu8TRgZfd7nxxXF98Pdqqm+
	 Ofs03eJC9fbrYvANCyaLYvcNDbhBJdZr2ZvNtfe+UN/g7I5tVB7CG45NYScb08Fj/YuCj
	 2UF2Dp2aFaY0uNYHC5amLuW2hvN55XNe9HJuICEm0ZapgYBuk091D2xTikedjyS5ls9a0
	 49sN0oWFdR8/Zs2onBOZ4m9NEyW+XagfwGV1bzY7aJ28MJfLfiCvG2VjtdFGwu2XhPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hBvG//xX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0B606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBvG//xX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D51F000C4;
	Fri, 13 Nov 2026 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794610549;
	bh=FM9UAblZjAoFoMq/VXmoefX20CG318XawGlW2CzYy0Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hBvG//xXGju++MVBOMM7wjM9q4QkfzfOjUhBtUQEqw7GWNj2xGqeKVlVFdOyZr7bx
	 bM7vY4P+PrvMnMhS/twbfIPXInEI8y5ieMJQSc/IdwQUKbAd47DKdvJiKvuHio1VG7
	 q0mkkklQBjajUc7T3Xa+3Aa562XBWOAdLpS63O01AFIDH0GmhIar0ZA5qwLk2L4oq4
	 A7UVJblA3DpQtPAXBSRkXKldm+e/8xoKqWVgoq+kdeYCKvz+rVWQ4vamlIu+Et0SD0
	 mCz5qdLYM0iFfXj/t78KzmGwScDfV7gPgARmHKSqgDMheHN6THCtxq+L+pYWBqAEiI
	 bjbrNlyLnBufg==
Message-ID: <sashiko-outbox-213842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Fix sign extension of unaligned enums
 in btf_dump_get_enum_value()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261113223449.97604-1-dennylin0707@gmail.com>
References: <20261113223449.97604-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:55:48 +0000
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
- [Medium] libbpf: false -E2BIG on unaligned enum bitfields in
  btf_dump_get_enum_value()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] libbpf: out-of-bounds read in btf_dump_type_data_check_zero()
  [1]
--

commit 7eb03a62b6fbbb96cde677bedc0b0fa89d38e668
Author: Hungyu Lin <dennylin0707@gmail.com>

libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()

This commit fixes sign extension for unaligned enum values in
btf_dump_get_enum_value() by copying the unaligned value into a local
aligned buffer before reading it with the same signed loads used for
aligned data.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index bbe86928b3eca..30fe3bb48df6c 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2329,16 +2329,13 @@ static int btf_dump_get_enum_value(struct btf_dum=
p *d,
>  				   __s64 *value)
>  {
>  	bool is_signed =3D btf_kflag(t);
> +	char buf[8] __attribute__((aligned(8)));
> =20
> -	if (!ptr_is_aligned(d->btf, id, data)) {
> -		__u64 val;
> -		int err;
> -
> -		err =3D btf_dump_get_bitfield_value(d, t, data, 0, 0, &val);
> -		if (err)
> -			return err;
> -		*value =3D (__s64)val;
> -		return 0;
> +	if (t->size <=3D sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {
> +		if (data + t->size > d->typed_dump->data_end)
> +			return -E2BIG;
> +		memcpy(buf, data, t->size);
> +		data =3D buf;
>  	}

[Severity: Medium]
Can this return a false -E2BIG regression when dumping a struct that has
an unaligned enum bitfield within the last t->size - 1 bytes of the
buffer (for example, enum fs_context_phase phase:8 in struct fs_context)?

When emit_zeroes is false, btf_dump_type_data_check_zero() ignores bit_sz
on BTF_KIND_ENUM and BTF_KIND_ENUM64 and calls btf_dump_get_enum_value()
directly instead of btf_dump_bitfield_check_zero():

tools/lib/bpf/btf_dump.c:btf_dump_type_data_check_zero() {
	...
	case BTF_KIND_ENUM:
	case BTF_KIND_ENUM64:
		err =3D btf_dump_get_enum_value(d, t, data, id, &value);
		if (err)
			return err;
	...
}

Previously, the unaligned path called btf_dump_get_bitfield_value(d, t,
data, 0, 0, &val), which computed nr_bytes =3D 0 and did not fail the bounds
check.  Requiring data + t->size <=3D d->typed_dump->data_end rejects any
unaligned enum bitfield whose underlying enum size extends past the end of
the struct, causing btf_dump__dump_type_data() to fail with -E2BIG on a
full-sized buffer.

[Severity: Medium]
This problem wasn't introduced by this patch, but can
btf_dump_type_data_check_zero() read past d->typed_dump->data_end
[1] when dumping a truncated composite type?

btf_dump_type_data_check_overflow() intentionally skips bounds checks on
BTF_KIND_STRUCT and BTF_KIND_ARRAY so truncated structures and arrays can
be partially dumped.  Before dumping each member, however,
btf_dump_type_data_check_zero() recurses into the composite type and calls
helpers such as btf_dump_base_type_check_zero() and the aligned path of
btf_dump_get_enum_value(), which dereference data without checking that
data + nr_bytes or data + t->size fits within d->typed_dump->data_end.

[1] https://sashiko.dev/#/bug/linux-c12e98ee-e737-47d5-ad42-ceec0d189844

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113223449.9760=
4-1-dennylin0707@gmail.com?part=3D1
