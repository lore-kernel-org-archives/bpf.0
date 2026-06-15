Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784140626D
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538050; cv=none; b=PVZHrzfLvjJDpBvGFMOA2GRCOvLB4P3Wtry0nBVRkMr/lbV3ibpLr6fOjZTfprWtxETKEYOSDETNyBgcHyq/UNa7G0SxUwLvpEY10AfZ5Y8fdxFR7EephRFOVReusXsm6BODgZbyWoi/2fVZNrFklxgrGtPDO/aR4+kt0o0HPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538050; c=relaxed/simple;
	bh=PK4Wm2GZ5RkA1l6QLug8G/v9mfi8d3lVnWBvBfNnWzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qR/UT99Y6nsm84RaoXtgLkGwBq7xQ4YULE7OxJt+LJf1CC59BS3slmStfzLZrMJ1jA9PkW4Ha8qw3nPHNd4QjlIRNIgohl62ULauHFDAzVlDAFRhG7R+dP448C4/Z4ooG6ouSP2F4LIKDFRROkaD/N9eWIiyQNg1lhIG6mVMGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOMeJGsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOMeJGsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4161F000E9;
	Mon, 15 Jun 2026 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781538049;
	bh=HlAeYgHTFaDG5kP94g8EaPcdJXnOvOCPwUTkFHcSgco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOMeJGsuWEUoEAUvTpLmNHPBy0mR4iWevlMH3rCADIKxXfeO32zugYIy93Eg/WgxQ
	 /mSqY7IvdDkYHOiyTuxsPsHAWJXHnl/nF808Sg7gBgXwwvpHjIFl6+cD4kksWgZ5Rk
	 M4CunXt7cUsLdVJgBPBsP1SlJZgYLUr1l9FrWJEWYnWSx6Gom8rFaH8S8MFQ88lSyz
	 gL7aaQQtqG0t0TtuYzvewqeIjY7z1lLJ/kh7crvYzX8AUXaQiMWNPYz+UQIdV9UOY9
	 6m2CjySDo0eRkggmtYtAsXRzoM0pufdxAeEPBEEX/oEMk409GQiuuZ4Cti2kk4wmta
	 DSYSNLRXjiriw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 10/12] selftests/bpf: Add tests to verify
 verifier log for global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615152646.27639-11-leon.hwang@linux.dev>
References: <20260615152646.27639-11-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 15:40:49 +0000
Message-Id: <20260615154049.6A4161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect `data_len` argument passed to `bpf_snprintf` makes the ne=
gative test brittle.
--

commit d5b0b79b30e924d1fec11028be9289d47ccc5221
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify verifier log for global percpu data

This commit adds new eBPF programs to verify the verifier log correctly
rejects bpf_strncmp and bpf_snprintf when a percpu array map is used as a
const string. It also updates the prog test to execute these new checks.

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> index ba92ffb0ca499..2222ad3a49bd7 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c

[ ... ]

> +SEC("?kprobe")
> +__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be =
used as const string")
> +int verifier_snprintf(void *ctx)
> +{
> +	u64 args[] =3D { data };
> +	char buf[128];
> +	int len;
> +
> +	len =3D bpf_snprintf(buf, sizeof(buf), fmt, args, 1);

[Severity: Low]
Should this be passing sizeof(args) instead of 1?

The bpf_snprintf helper requires data_len to be the size of the data array
in bytes. Passing 1 makes the test brittle if the verifier's argument
evaluation order changes in the future, as it would fail on the data_len
argument before checking the fmt argument.

> +	if (len > 0)
> +		bpf_printk("snprintf: %s\n", buf);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615152646.2763=
9-1-leon.hwang@linux.dev?part=3D10
