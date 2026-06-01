Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4F382F1E
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352954; cv=none; b=PTQVmyi9TIv0gYKCUK9cjJ7EA9KHwT5Pr7A0zpkP0re/56VOtWHP0NBZe+kN/3F4RdtKVNct4VOEu+98V4Mtr7Ht2TXKHiE+Yr5noVSxGzk9dlkqxBH4YfbzNaN5hPqvHpEK0mZzsoyYQlqDRH5ObrupIT9B/ZQuUd+awfZenSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352954; c=relaxed/simple;
	bh=eqtsRTEvqyy62gD36KSoXtw/LH7oskRsLAGUESad9DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/U5tGALNwvUWMbX0BSWyh5/idKPzw4zRPGPgBVB5yTO1Jrl26DxRAZcVgkYopSQYunN1ACu4Hyw/tLqBB7Dqgj+jn8iJMre9L4EsNIt8HgM49CRmwSziF/1AqPavylvGCRVnGutnxiOIiQ9HnDk5KsRpr4woMloWxyYUDOH8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZAU3e7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZAU3e7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C06A1F00893;
	Mon,  1 Jun 2026 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352948;
	bh=pDCc+SxG/akyN6mR9eKn3gDrnACK7xE9E4qKS9FO+Uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZAU3e7EsOlDNcvIIjeme6rAGkHstwx/LVWeN/oG91IQCfIbzxNrvDLgXc/AwkzEz
	 9WBOYYl+giOPJ6dpfKcCQ0B8Opj5JrQGyq1qvVS2O0uqgcW4RjwV+pbyCFoSFZJ8cl
	 z2vhYJ2XZX8nl5RxJ6j8k6q2K9JzvE5zsxsS3AIdfG/tWItC/TE8r6evFr0vm4am95
	 iLrGT07twM5L9fHBY2rkG2kAUN41+5d+lzzPkpZTUoqnD6H5EegSXtIvUh3+SNLwGj
	 8kknGsm/zXnC5m7MxvPG4MEAisJd+rT5UF6wRYo3dqtfP1XLjZe+Zj/poT0zMjWpA0
	 +I35pEkJD84pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 12/14] selftests/bpf: Verify arena type tags
 in resolve_btfids test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601221805.821394-13-ihor.solodrai@linux.dev>
References: <20260601221805.821394-13-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 22:29:08 +0000
Message-Id: <20260601222908.7C06A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF kernel comment =
style, with text starting on the same line as the opening '/*'.
--

commit 628aab60f23e099095fe093c7589706d10a3df81
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

selftests/bpf: Verify arena type tags in resolve_btfids test

This commit extends test_resolve_btfids() to verify that resolve_btfids
correctly emits the address_space(1) type attribute for kfuncs flagged
with arena attributes.

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index eeda4e3b6a7f6..6449b551fde1b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
[ ... ]
> @@ -253,6 +282,36 @@ void test_resolve_btfids(void)
>  						     kfunc_symbols[i].id),
>  				    kfunc_symbols[i].name);
> =20
> +	/* Check resolve_btfids wrapped exactly the arena-flagged return/args w=
ith
> +	 * the address_space(1) type attribute, and left other pointers/returns
> +	 * untouched.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the modern BPF
subsystem comment style? The guidelines require the opening '/*' to be on i=
ts
own line, with the text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601221805.8213=
94-1-ihor.solodrai@linux.dev?part=3D12
