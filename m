Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5238331D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135997; cv=none; b=aXPzSeewYtxFHK5e+jdQwGx0M+529Jb/igo2V2t6j6Qpha55plShYAbQC/ST0YQyjNOZ9DyFLjQFZuGEKyMyVFWfL1wQmT2VSVu31SUAMuysCC3rpzZ+48BfqjoZxf5V3xxcNqagihrDXfbCjwkEveTM039oPO7aH/0a/jg5bSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135997; c=relaxed/simple;
	bh=WyKLS/taVLqfZfg2PaZJlY5ReH7lDHDZbxJ3W4Sl5n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f8m1gAP6LRiyKcN0HbWrZdeau3X11uodW9f0LH9ZDCoBteTp8PQ8pto/vpn0Kn17uT8isGaX9Xq3UWk2xpF2d20JXY/FwW+YF7WSFotH3j51+NzxMFO67ElhNFIDkzT4rFFqeMqyVeCNkOTwE+NvyBVKM3JHAN6FXwcooaIKFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfllHCTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfllHCTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949CF1F000E9;
	Fri,  7 Aug 2026 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786135995;
	bh=hsOAJ5qQwG4VFYhkuoKu/UqRM4LuCwEroNf3veDFH0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfllHCTOpLGUXHnICqG6PwWqNg7DWIG2gOj3akQBEXVcbPHJimdifMVVQIGU2II7i
	 jyXT5YzGkIbxUQxF7aOuxAWZS9wESGhnzpqK66KPrYk4LvoBn9MCGQc1dysTE2GRqj
	 2ukj3gD/54w5Itq2KRjW406f+mwqRxmGmXTd3SQd1nSH0AiVtThHCcGRsveLaZxnIq
	 BoDuOx4hNMSXsE3I1Tp209BMmVuAh9+RBT1FhrTn+L/nF/De5dxsc8Z4vSzE/B7Zyd
	 5joop44Czhb8GZfejOP/8Cvl1BgYmil42tYngCNgLdwTZGZdkLiQA+IjzjdCx0mir/
	 FqV/vNyUCRoHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_ST
 reject msg on cpuv4 toolchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807204434.1036279-2-vineet.gupta@linux.dev>
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
 <20260807204434.1036279-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 20:53:15 +0000
Message-Id: <20260807205315.949CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch conditionally alters the expected verifier error messa=
ge for BPF_ST toolchains, which eliminates the test's intended coverage (ve=
rifying that `map_kptr_match_type()` rejects scalar registers) on modern co=
mpilers and introduces brittleness tied to compiler optimization levels. As=
 acknowledged in the commit message, the test now bypasses the original val=
idation path, and changes in optimization (e.g., compiling at -O0) will bre=
ak the `#ifdef` logic because the compiler may still emit `BPF_STX`. A more=
 robust approach is to force the compiler to emit `BPF_STX` (e.g., by using=
 a 64-bit constant that cannot be encoded as a 32-bit immediate, or by usin=
g `barrier_var()`), which preserves the intended verifier coverage without =
relying on fragile macro checks.
--

--- Patch [1]: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_=
ST reject msg on cpuv4 toolchains ---
commit 302e7847f20b43d2cf543bac72a29e4a57633dfa
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: map_kptr: expect BPF_ST reject msg on cpuv4 toolchains

This commit modifies the reject_scalar_store_to_kptr test to expect a
different verifier error message on toolchains supporting BPF_ST. This
avoids a test failure when the compiler folds the constant into a
BPF_ST store immediate instruction instead of using BPF_STX.

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/te=
sting/selftests/bpf/progs/map_kptr_fail.c
> index f11848dfa78f9..5e25ca806060c 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -386,7 +386,16 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
>  }
> =20
>  SEC("?tc")
> +/*
> + * A compiler with BPF_ST folds the constant into a store-immediate, whi=
ch the
> + * verifier rejects on a different path (and with a different message) t=
han the
> + * BPF_STX form.
> + */
> +#ifdef __BPF_FEATURE_ST
> +__failure __msg("BPF_ST imm must be 0 when storing to kptr at off=3D8")
> +#else
>  __failure __msg("invalid kptr access, R")
> +#endif

[Severity: Medium]
Does this conditionally altered expectation eliminate the test's intended
coverage on modern toolchains?

As noted in the commit message, the test now bypasses the original validati=
on
path on BPF_ST builds, meaning it no longer verifies that
map_kptr_match_type() rejects scalar registers.

This also appears to introduce brittleness. If the optimization level chang=
es
(such as compiling at -O0), the compiler might still emit BPF_STX, which wo=
uld
evaluate the wrong macro branch and fail the test.

Would it be more robust to force the compiler to emit BPF_STX here, for
example by using a 64-bit constant that cannot be encoded as a 32-bit
immediate, or by using barrier_var()? This could preserve the intended
verifier coverage across different toolchains and optimization levels.

>  int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>  {
>  	struct map_value *v;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807204434.1036=
279-1-vineet.gupta@linux.dev?part=3D1
