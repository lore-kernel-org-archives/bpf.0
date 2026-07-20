Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C43AFD09
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538593; cv=none; b=U+KEW+A1xls4lGJxPDNq4TmSqN4PRHDM1zXSCcureD3csxAtmmxmMLnzwiFbAzpElAea4j7Jn63ak/cqLnUYp27pb5Ana+MePRo/6X1Jfe/lt78UgZk5otW2/Gus1LGZtnBlD44hy1tt7xHqkA37Qtbq1/JJp4Oz6UBz5nOr2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538593; c=relaxed/simple;
	bh=UXqVKNjsL7cgotOZF7Khx9XZ0NQ5tlfz+7Wi2zwDg08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tOJlhYSkKDlGs3q+a6HYyr3RgdEwWHMdzDSNDOLnnVTEuCnJHScjE1psktjaYioUfmJQLNTa62yosDCieekwOY+wCh92oQZy+dl1YmivrP6xJt2uF2mt7YCL5hhXADfi+zQ5mNhbtHGAhbHOlyvj+eWl2+DJPyMYUXWMdqKGP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAMtPSLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAMtPSLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC2C1F000E9;
	Mon, 20 Jul 2026 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538591;
	bh=sUoFArQGayORkIoEXV1nkZ9QYGogwGwwEk/g6UShUVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAMtPSLgXX0lkXLdb1TwGaaB24PT9ndwxywZLHV+ZxdwpRKzTNatmheMexO/bPHFL
	 ZCkm6jShh053qobx7OpQelJ56l0p9eNQfa7vFFLhZO8glqoLbTJZPfKhkSAJf/7E/0
	 N6qRLqbIFFpKcd1o/pC6rsCyLen3sFIq5f2qUl4D4xZ0NDBkSx5iMIaSqSZIRKkg7M
	 Dv/eKFfwfUqweDhygRytO1TysaCC6Krocmdbwg4VbVPM38U7jWz1Ofn4psfHFfjsZB
	 xHnR6CU2tOwiOUJgsklLnkh3ImJXmdm/hBiitQcQG5PJA1+ac6G+s+Ay0XTgA8q5jo
	 kRZehwoLawfFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/9] bpf: Factor stackid_fastpath function from
 __bpf_get_stackid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-3-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:09:51 +0000
Message-Id: <20260720090951.8AC2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A pre-existing TOCTOU race condition in `stackid_init` involving `=
sysctl_perf_event_max_stack` can cause a `max_depth - skip` underflow, lead=
ing to a kernel heap buffer overflow.
--

--- Patch [2]: [PATCH bpf-next 2/9] bpf: Factor stackid_fastpath function f=
rom __bpf_get_stackid ---
commit 1a0215d43cbe727ac7583d25380f0acdc326abc9
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor stackid_fastpath function from __bpf_get_stackid

This commit extracts the fast stack hash and trace check logic from
__bpf_get_stackid into a new stackid_fastpath function. It optimizes both
the just-ip and buildid code paths by avoiding new bucket allocation during
the fast path check.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 0eafe55b18289..7bc2a966e3e81 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -531,28 +532,46 @@ static int stackid_init(struct stackid *stackid, st=
ruct bpf_map *map,
>  	stackid->hash =3D jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32=
), 0);
>  	stackid->id =3D stackid->hash & (smap->n_buckets - 1);
>  	stackid->bucket =3D READ_ONCE(smap->buckets[stackid->id]);
> +	stackid->hash_matches =3D stackid->bucket && stackid->bucket->hash =3D=
=3D stackid->hash;
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but could the stackid calculation
in this function underflow and cause an out-of-bounds write?

Just above this diff in stackid_init(), stackid->nr is calculated like this:

	max_depth =3D stack_map_calculate_max_depth(map->value_size,
						  stack_map_data_size(map),
						  flags);
	stackid->nr =3D min_t(u32, trace->nr - skip, max_depth - skip);

If sysctl_perf_event_max_stack is lowered concurrently while a BPF program
is executing, max_depth gets capped to the new smaller sysctl value.

If the BPF program provides a skip value larger than the new sysctl but
smaller than the old one, max_depth - skip will underflow to a large u32
value.

The min_t() would then incorrectly select trace->nr - skip, resulting in an
unsafely large stackid->len.

Later, this length is used to write into a bucket that was allocated based
on the smaller map->value_size:

	memcpy(new_bucket->data, stackid->ips, stackid->len);

Does this sequence allow a kernel heap buffer overflow to occur?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D2
