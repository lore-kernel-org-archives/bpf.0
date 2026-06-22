Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF62383312
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114813; cv=none; b=Nyvm2Qe9IbiCATpYrWEMvvBXVxuX2P4qZ2R4FT8tUt4rVoBDuu0P3wTV2K/nUHiiG3LXqJjIjvo/4bAQzCDXXTadmjRX+HfWMwW3Q4GFUVwtgL1ZqbJDhG9S+aESYMXLYEs2P1V4DvTgwY5h8dJJMozMIVgsMcsG4ulyG7hkv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114813; c=relaxed/simple;
	bh=OuiCDSVzJnHg8iWXJ0eYmGpaz3Bj6nflB+6xUepmDkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XaoeF0pPZFnminhTzDCUbnZh2/xG149dtMVhoJaqF/dnmnJDZahU4u6OHnU+oK2eZMoEoVZFD6ixmoxxSH6Dslx6VBGCdKfDUhbSXVrdSlThTL9uJYlSF6t1/lNhyNTx4Ra6WeXCLlRktOVxwx6yzgeZMCDCew3hCccDRuaG2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcUWjimV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcUWjimV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34061F00A3E;
	Mon, 22 Jun 2026 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782114810;
	bh=u2xRxhY1C5So/QQ7oc6+F7sxEOQpFTPV2V1mqkGDQfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FcUWjimVzYeyEGPncEDGs2+yd1rsA1BKg6+cEqxDRi9iHjLR/3IFMGRaz9LcuXYzv
	 1v7uznfRl9lym44KNAgN5zVgvndl4u13h4dQrTIYiqgZvPTk8emzkXWG5un77UCCUX
	 cAfz2H7ouMc+Vs1IRX/QHBwRR6MZP6vl3uaTFAD3IZs1QkzffkAmvkBT0trpkPscKO
	 I80I+g5MijSqasFasL6ssb/gDuN3+Lp5eVlfq7Riv+BWc0sSr6mD05/nlhwvuPDZy4
	 xdecN6wc4myebDZh+eZ8g76LrFSsd/GnMfy1XxVF244MZo5LVMyp8QZNdTDTLNYFRe
	 amvP4Kv1MM20w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 3/3] selftests/bpf: test BPF_F_COMPARE
 compare-and-delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gyutae Bae" <gyutae.opensource@navercorp.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622071649.31541-4-gyutae.opensource@navercorp.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
 <20260622071649.31541-4-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:53:30 +0000
Message-Id: <20260622075330.B34061F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
--

commit d9d64a94ef921683b52276aed902be3aa7f68eed
Author: Gyutae Bae <gyutae.bae@navercorp.com>

selftests/bpf: test BPF_F_COMPARE compare-and-delete

This patch introduces a selftest for the compare-and-delete operation on a
hash map. Since there is no libbpf wrapper, it uses the raw bpf syscall to
verify the deletion behavior based on a revision field.

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c b/to=
ols/testing/selftests/bpf/prog_tests/map_cmp_delete.c
> new file mode 100644
> index 0000000000000..6d6df13adcc42
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c

[ ... ]

> +struct val {
> +	__u64 revision;	/* synchronization field we compare on */
> +	__u64 payload;
> +};
> +
> +/* libbpf has no wrapper that passes the compare-and-delete fields, so
> + * issue bpf() directly. 'flags' is a parameter so tests can also
> + * exercise the no-BPF_F_COMPARE case.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style? The guidelines specify that the opening /* should be on its
own line, with the text starting on the following line.

> +static int cmp_delete_flags(int fd, const void *key, const void *compare,
> +			    __u32 off, __u32 size, __u64 flags)

[ ... ]

> +static void test_contract(void)
> +{

[ ... ]

> +	/* mismatch -> -EBUSY, entry preserved */
> +	snap.revision =3D 9;
> +	ASSERT_EQ(cmp_delete(fd, &k, &snap, off, sz), -EBUSY, "mismatch_ebusy");
> +	ASSERT_OK(bpf_map_lookup_elem(fd, &k, &v), "still_present");
> +
> +	/* compare fields set but BPF_F_COMPARE omitted -> -EINVAL, entry prese=
rved
> +	 * (a dropped flag must not silently become an unconditional delete)
> +	 */

[Severity: Low]
This isn't a bug, but is this multi-line comment using the preferred
formatting? Similar to the comment above, the opening /* should typically
be placed on its own empty line.

> +	ASSERT_EQ(cmp_delete_flags(fd, &k, &snap, off, sz, 0), -EINVAL,
> +		  "cmp_fields_no_flag_einval");
> +	ASSERT_OK(bpf_map_lookup_elem(fd, &k, &v), "preserved_no_flag");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622071649.3154=
1-1-gyutae.opensource@navercorp.com?part=3D3
