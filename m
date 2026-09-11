Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9113939B5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142770; cv=none; b=T8uavHoOPz8zl0Bi29WWSZd6Z0+Jyzk5pZUGMU3WlJM5l0kjRojrln54xk6QSa4xrKHh7pOkpD9RM85QAaNySsVYVzsUf4TqCLV08YVQFg/p8z+slGorANqlrvFkjAuZE4vs0QMApFOrT/WV4epPbI4q1VkggGh7EfIDuzUrHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142770; c=relaxed/simple;
	bh=xv3h7r6Oi7984ZPae4SoiWAAPyjh7bl3pzZs5/eG4tM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pFo+HOQVfPsoTCtqI5otcaVJx+mfhlPdA2c12HEjlA7nojwvGKeLabn9DRFCcs/r2tMP9W+MWgLfeKRH2qNVAbLMPmZKsJquq003RwWCUDrD187uMm3IYhgKVP6J4Xlb82ixhWwEjXIe5GKw5Sl0flLP3H/0a8mmI4mVVtDqFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDiFJG1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDiFJG1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D3C1F000FF;
	Fri, 11 Sep 2026 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142768;
	bh=xv3h7r6Oi7984ZPae4SoiWAAPyjh7bl3pzZs5/eG4tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDiFJG1vujCvCmKq/li+SxAafSwVMzMHAxAL/9oEetgGAPuTatAr7s45etgfPAL0A
	 L84j8T9pFd3TGb1RXIsW3Qb52pAdwxSIau+ek+Y5QOUjAkJTanjzpKQxuRD5hnDEN5
	 5kzHLAFyIeqzT3h4XM0y4GYYwj+urf/8FDmCBrtDRVGQ08cy1dHXnDl+qWvggirFMi
	 C8yB7vPKVBjetylT+ePF7fNIKFuRrtUESyEFmRypA3ugYvIRqHbgBnozPgkLaKpIfZ
	 UNGIC0RgG+zMk34un8vVbbkjFX5NY5NARZQx0nh1kxrIU9jf50ICzoqYlqtztSIqT6
	 YQ7u2L+9Q4NVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 13/15] selftests/bpf: Add inline-asm tests
 for by-value arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911155020.2012089-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
 <20260911155020.2012089-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:06:08 +0000
Message-Id: <20260911160608.B9D3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required kernel BPF comment =
style.
--

commit d1826c8bebe9c02679f7bde2ef6a1536675d8bf2
Author: Yonghong Song <yonghong.song@linux.dev>
selftests/bpf: Add inline-asm tests for by-value arguments

This commit adds inline-asm tests to cover struct argument passing,
specifically for structs passed in register pairs, refused pointers, and
structs too large for by-value passing. It also checks various placements
that global functions cannot have.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_arg_func.c
> new file mode 100644
> index 0000000000000..ae3faa8a4a940
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c

[ ... ]

> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
> +
> +/* One slot per parameter, so the slot count is settled before the param=
eters
> + * are walked. The cases below reach the same count only once they have =
been.
> + */
> +__noinline __u64 global_arg_six_scalars(int a, int b, int c, int d, int =
e, int f)

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style? The guidelines require multi-line comments to have
the opening /* on its own line, with the text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911154914.2004=
336-1-yonghong.song@linux.dev?part=3D13
