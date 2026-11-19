Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065699;
	b=V/Ivv8pb2yUSteAxAcoplJte5sVledocsJyed7b5OI+6r9VCKYoAVCkZo0SsyBS9i0dZ
	 2vyvW1dCqMzU64hVB098uV6c/FOnfRRkJYcLEBvlOZwplvMKce60RUikUp57XRstc8SAs
	 17Oa+0rSuT46HePFP9ngYskHybVttQuYl+LGZpjAwL4m98lTMjalEnWkidA/yeahCLlyJ
	 j9HAjpqlm1KzhEVHtneDwKuPqioQrz49ZrscWUMBI/Uj248NbqC655U7GQBTti46uuLYH
	 Sv26s/Czr+/asehyWxfy6Z0R2SI5ATd6Ok1Siwo1B6bmclM9Mmdu5QGdF2Zpan2v6EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/DDSAAcOxTfjcMOcdDdfFUsg08lZcQJaH+m5IcXnapc=;
	b=djE95xHXBhVfUZoLV1BF9c0+pGf7qFfXmAa79H9BU1+fMHYIRizdCIa6qc++bm8F35I0
	 zsQzEEp3G0u6CVhTLbPugZJqc4uS4G0uU7IgIRof5ermhod6ApPpApHEgHrMQ6M/goPeY
	 rLzZt84zPYUGn57pcYr38900cTgFVhtBpHi4TlduH/3kubG7Anj7Ruy9C+AsCi6EaF0g6
	 C0GohPg0IpfN/6Rq6Zk+1Z+1takoUQPC8/+96nBI7FTfc9OMB2hUkUOuj/IkK7VTw1AV4
	 JqMjuunL1rt2E/9jBBDlCWK0ww7mcwBcgCTUOdTr63kH78eKhl+OcZ0tQ0O0tXJguZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+p8nsZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB4606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+p8nsZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F6D1F000C6;
	Thu, 19 Nov 2026 05:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065699;
	bh=/DDSAAcOxTfjcMOcdDdfFUsg08lZcQJaH+m5IcXnapc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K+p8nsZuxJGfxadmGiL45wWaXhYyWMDsZ3INhvrWEdw4qVWiSv8a+aZhS0tF7AJMk
	 t8gGOPFJWkycM60zop5p6wKf79RSDFn62llmf8NEL+yPuOIICYwzjiqsblAShf8rIy
	 8R/HedmlkRQjBi2UMYD6tHtwgZfly/capOXi3TK2BN7/ECoSt8B94VrvHPtmtTRTEL
	 D6tEiL4MuDUijiSxAEqoWVNyjkSq5Vx9j65B6GhGsLwckjsMCGQ+0EQZjgfZn31YRd
	 BMPAhXdYNbrZWiRw99IiTPuzdqKOF8jcuL1+2mzrxXBm6kLyuLKbTREtvQDltuYpFE
	 HZ2n7/R9L/Xnw==
Message-ID: <sashiko-outbox-222472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: Accept sign-extended 32-bit
 enum values in CO-RE relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261119051459.1902876-1-yonghong.song@linux.dev>
References: <20261119051443.1902163-1-yonghong.song@linux.dev>
 <20261119051459.1902876-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 05:21:38 +0000
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
- [Low] libbpf: non-standard multi-line comment style above
  bpf_core_enumval_is_sext()
--

commit 2ec397921876fd311cd75d218c792d79da6cd995
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Accept sign-extended 32-bit enum values in CO-RE relocations

This commit accepts sign-extended 32-bit unsigned enum values in
BPF_CORE_ENUMVAL_VALUE relocations and sign-extends the patched 32-bit
target value to match GCC's output.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 7aa7eb4e4021b..76efee8e876f0 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1032,6 +1032,19 @@ static int insn_bytes_to_bpf_size(__u32 sz)
>  	}
>  }
> =20
> +/* A 32-bit enum value is in the low 32 bits of the ld_imm64, extended as
> + * the compiler chooses: clang zero-extends an unsigned value, GCC
> + * sign-extends every value, as its __builtin_preserve_enum_value() retu=
rns
> + * int. Check whether the instruction has the sign-extended form of an
> + * unsigned value, so that the target value gets that form too.
> + */
> +static bool bpf_core_enumval_is_sext(const struct bpf_core_relo *relo,
> +				     __u64 imm, __u64 orig_val)
> +{
> +	return relo->kind =3D=3D BPF_CORE_ENUMVAL_VALUE && orig_val <=3D UINT_M=
AX &&
> +	       imm !=3D orig_val && imm =3D=3D (__u64)(__s32)orig_val;
> +}

[Severity: Low]
This isn't a bug, but BPF code uses the multi-line comment style where the
opening /* is placed on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119051443.1902=
163-1-yonghong.song@linux.dev?part=3D3
