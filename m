Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622641A4E5
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352636; cv=none; b=dJ0x18Kc+3cZpfxB2afYhG4HQtwccRpjOck0dZcCcovOFDnYByrLf1NSjDLgkIucLFx/jmnKnXSqub6oooDT4vQYU6ljnbBn6gG2jijGhB2Mofh3HL22NckLvZz9vcM/U1/hQK1Obx2nLdZcr6/W7kcwXm+QJAtS0UqHrQpreqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352636; c=relaxed/simple;
	bh=mGXz1UMHhk0+md0JIpBwTDBGgzI16JVDAGkXPo6ecp8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WDnJPUd/LvwlcIqdxZUuZs+ZOciaUU9jwWfDg/xDjByQ+8rVcN9CV51n2f/BAaMWW2mQMvIKH1hcbactcDioREnSWlMO0WWqyoNhFe4v09jvl5bR0B3QGGwJ9ribFxnXlhzC2FcerEcfX+BKk1z2L20//nFBL6+VzbOzR2HMP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks8hwjQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks8hwjQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E009D1F000E9;
	Fri, 21 Aug 2026 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352633;
	bh=y2gx9l84/TdaG7x8qD8if57DeO/Ru66H2uWn2GDUsWY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ks8hwjQR6GCeILntLKoBEc3Z2kdgW97ebpO6i0mq/FFqqLMxMNccg+z+If5GAHvGj
	 mscnJoykTnp8mmfilKWdaHrQQ6RqcScr6mH4QYrng1rg+0C21PjDYg2k7fj5MFC74n
	 D5Ao9JXNGdiwDdksvb6fwHvM7+EIrxmRqFfcD3+w23iAfdkGr4zRQ3n1iSqqRfxiuo
	 Mp5Bs+yd6FqP8CLoDgJQB6pzFnPxE2tnpBgLBFU/1wGz7H8tUCWD08TUG9MJZxZwLP
	 6KSOGQPkC4lBoCLSQG0tMEVEOFqHObRy7meIJYKXc5ed8RqT+xOgfC4KoJF6W7OvYF
	 KsEqsYyQmBEZg==
Content-Type: multipart/mixed; boundary="===============4882818045740024818=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5da9714b6f6348052cb0023924690970f39cc93c0eea16f47183eb18ab3f75f8@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-2-daniel@iogearbox.net>
References: <20260821214111.1120748-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 01/11] bpf: Add a bpf keyring for program signature validation
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:50:32 +0000 (UTC)

--===============4882818045740024818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index dec7f2beabfd4..1cb59ddda2509 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -18,6 +18,16 @@
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
>  #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>
> +/*
> + * The id of BPF's ".bpf" keyring, reserved from the same space. It is
> + * explicitly not a sentinel like the two above as BPF resolves it to
> + * the keyring itself and passes that, so verify_pkcs7_signature() never
> + * sees this value, and system_keyring_id_check() must keep rejecting it.
> + * Left as a plain integer so that handing it over as @trusted_keys does
> + * not compile.

Does the comment accurately describe what the code enforces?

The comment states the value is "left as a plain integer so that handing
it over as @trusted_keys does not compile." Passing the integer 3 where
struct key *trusted_keys is expected triggers -Wint-conversion, but that
warning is not promoted to -Werror anywhere in scripts/Makefile.warn or
scripts/Makefile.extrawarn.

The kernel requires -Werror=implicit-function-declaration,
-Werror=implicit-int, -Werror=return-type, -Werror=strict-prototypes, and
-Werror=incompatible-pointer-types, but -Werror=int-conversion appears
nowhere. int-conversion only became a hard error by compiler default in
GCC 14 and Clang 16, while Documentation/process/changes.rst still lists
GCC 8.1 as the minimum supported version.

On a GCC 8.1-13 build, the misuse compiles with only a warning rather than
an error. Could the phrasing be adjusted to reflect that this is a warning
rather than a guaranteed compile-time failure across the full supported
toolchain range?

> + */
> +#define VERIFY_USE_BPF_KEYRING	3
> +
>  static inline int system_keyring_id_check(u64 id)
>  {
>  	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============4882818045740024818==--
