Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E33B47C3
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520208; cv=none; b=ddfiskqvIYGSYUvgK5Mh8paBJwdr2oSOKkKqSmeqB8xjMJQuj9tEoB1tH8L3qLZX3wUwfvKLYshRVVWUEGj+v0Lm6c4C32qQfnHx7unXIAXVXy4sHcJG065riQbJArtWpz6g4rzXrtEbVBh7e9iAYtOHSTbI+yXu4tYC2eg/CxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520208; c=relaxed/simple;
	bh=GSTaBVJpiV71k26Kc4BG10R/1a6b0qXXuI6yUsD4Aqo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mtRk6oePdv5PFBQJ7ntMM7TINFovioug/1LXV8QP6LdJoo+WQBeF+iybo1+V+PTdBpJRv2IpD//lspH/hupMq5xDE6DthG+9DHIH4y5bEGCY0tUOgUEeddWQDVvGhAdTLUzIFqDNimbdDK04fE+6sZhu4nq2E34m2blNW008A+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONDOx53y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONDOx53y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD631F000FF;
	Fri,  9 Oct 2026 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520204;
	bh=1wp2cqSNSdGBfSOH14iZRB5Yb6L1ucqiPFXM4o7wt2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONDOx53yzSn0TdbmTeBO9/dePHzlHci3EUzezsSi7yI1H4bFd1x+dRbV9qMkg7Asl
	 Xo00EwRhbPqTwd0JPnecTePxu5Wyw5XbxrtHyf+jrBetEy71Tycvxqz0V75KRt8saz
	 6m8D3kuGzXJL0g8hLLcsL7FP48aYe2w5yMhddxijJxew1b/YH/5e3f94dy4y2jA/Yn
	 eRyBN3ayjYKc+WMXGsPvXwNOnE01IbQPQODf6CXlBx5Wu/olKoKKFp/sQMAhhUzKW/
	 O9x4NYiuAOyIymiXFAdwPVkN+FY3ay5Tv8YhOi7OpB7hl8/+gewqqAUXRUnW0xds+z
	 GOg6xb1Ap1E7A==
Message-ID: <sashiko-outbox-164834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 15/24] bpf, arm64: Dispatch exception
 cleanup pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041605.33513-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041605.33513-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:30:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64/bpf: PAC modifier mismatch for bpf_throw's C frame causes FP=
AC panic
--

commit 2f751c03b321c9d53d97196968f653cf6c3fa289
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, arm64: Dispatch exception cleanup pads at run time

This commit adds arm64 support for unwinding BPF frames and redirecting
their return addresses to cleanup pads. It signs the modified return
addresses using PAC when address authentication is enabled.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb04..56d1310eca323 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c

[ ... ]

> +/* PACIASP's modifier is the entry sp, record + 16 for a BPF prologue. */
> +static void bpf_unwind_store_ra(unsigned long record, u64 ra)
> +{
> +	struct frame_record *rec =3D (struct frame_record *)record;
> +
> +	/*
> +	 * Whether the slot holds a signed address is a property of the build,
> +	 * not one to be read off the value: a PAC can come out equal to the
> +	 * bits stripping puts back, and a signed address would then be taken
> +	 * for an unsigned one. What signs is CONFIG_ARM64_PTR_AUTH_KERNEL --
> +	 * the prologue here, and -mbranch-protection for everything the
> +	 * compiler emits.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) &&
> +	    system_supports_address_auth())
> +		ra =3D bpf_unwind_sign_ra(ra, record + sizeof(struct frame_record));

[Severity: High]
Will this hardcoded PAC modifier cause an FPAC panic when returning from
bpf_throw()?

The unwinder uses bpf_unwind_store_ra() to redirect the return address for
the first BPF frame. The caller of this first BPF frame is the C function
bpf_throw().

While record + sizeof(struct frame_record) correctly assumes a strict BPF
JIT prologue where the entry SP is FP + 16, bpf_throw() is a compiled C
function. Its actual frame size is compiler-dependent and may be larger
than 16 bytes due to local variables.

When bpf_throw() returns, its epilogue will authenticate the return address
using its actual entry SP. If we sign it here using FP + 16 instead of the
actual entry SP, could authentication fail and trigger a kernel panic on
PAC-enabled kernels?

> +	WRITE_ONCE(rec->lr, ra);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D15
