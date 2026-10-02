Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984F4848AD;
	Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932493; cv=none; b=qj6bvPW8EDSqT31cBkKkFW+ydUibbIlCqKPvmfpZgEq9UITODB/j7eVFdF6RRKDAWy1oVQ+rIxtLxe+EwC5CoAzkk0mIgzIfCBrtdU78a7n06CHceC9n79QSnMe1v3f6J8/O5qvinNSxL5xBQJfh5UFcsTrTTsT7KYpoIk5E6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932493; c=relaxed/simple;
	bh=V2jj3x39fXHeJwxn4UyJwJJtgmfXGlE3J/IxoBaHtMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhMvVAXt9Z4mhLRwHZGmk7oHR4BRPDQhBCR8Sl9Ma8/lDo2LP8N/ECH/v6rlX1FjWdA+cUBpaxIOpwr1xrZqJfVS0iKSVISCqEQMoZJZ8SerhsJ7qQ7qMlrZJcTq/uSggddsG2Tt/lM5ayYxaHSuUDnoSsnXDHNl9iDBsCi1WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhnHZs8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhnHZs8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FBC1F00893;
	Fri,  2 Oct 2026 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932492;
	bh=ptPWMo8zJ8revgIW/Vq5XPA500wI1DerRYQgr4zUFd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YhnHZs8+6UgjTJoLT5mhl1Y71rQ3tJdaz6yre1Ed9lcTrhluaydEVw01vbkELNx5W
	 E2SPwZYdOVcVAchArOYqhtyUeFCxxH6o4IXK5v26rlnFMCIVyJXRDGXzoHahHg8N3t
	 Q/y7AoFaEKDoATHD1ftzi8m8YUaSYqK9hzEzkXKHSNM3HIwAQ9IkVyfRm5DGmrE0jz
	 ResG74wzM9VGR9O09epaCBaZnNToqoLoOZXV/bLbYftbc1LiA5K91CUD5TeYoVDNaV
	 zFDeZixOKhP5r4IXHdbox7O0fMgjNlBvSGaVzTehnv+Pe7oHHMZRix7aYpwmVJg2x5
	 RdUupuzx1CVFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261002-module-stubs-v2-1-a0d8c6ad1738@suse.com>
References: <20261002-module-stubs-v2-1-a0d8c6ad1738@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:51 +0000
Message-Id: <20261002091451.D4FBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: resolve_btfids build failure with CONFIG_MODULES=3Dn and LTO/GC
--

commit caaeb9d0651743944c690c066494bb16509c01e9
Author: Petr Pavlu <petr.pavlu@suse.com>

module: Add stubs.c for CONFIG_MODULES=3Dn module_put_and_kthread_exit()

This commit introduces kernel/module/stubs.c to hold stub functions when
CONFIG_MODULES is disabled. It moves the stub implementation for
__module_put_and_kthread_exit() to this new file and removes the
corresponding #ifdef from the BPF verifier's noreturn list.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..be70f10e49682 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20417,9 +20417,7 @@ BTF_ID(func, __ia32_sys_exit_group)
>  BTF_ID(func, __kunit_abort)
>  BTF_ID(func, kunit_try_catch_throw)
>  #endif
> -#ifdef CONFIG_MODULES
>  BTF_ID(func, __module_put_and_kthread_exit)

[Severity: Low]
If CONFIG_MODULES=3Dn and dead-code elimination (like CONFIG_LTO_CLANG or
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) is enabled, will this cause=20
resolve_btfids to fail?

Because the #ifdef is removed, this unconditionally requires the function to
be present in the BTF. If there are no callers in the kernel, the linker=20
might discard the stub function, causing a missing BTF ID and a fatal build=
=20
error under CONFIG_WERROR.

> -#endif
>  #ifdef CONFIG_X86_64
>  BTF_ID(func, __x64_sys_exit)
>  BTF_ID(func, __x64_sys_exit_group)

[ ... ]

> diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
> new file mode 100644
> index 0000000000000..1385c87e81695
> --- /dev/null
> +++ b/kernel/module/stubs.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +
> +void __noreturn __module_put_and_kthread_exit(struct module *mod, long c=
ode)
> +{

[Severity: Low]
Does this stub need a __used attribute to prevent the linker from discardin=
g=20
it?

If no code references module_put_and_kthread_exit() when CONFIG_MODULES=3Dn=
,=20
this function is silently discarded by the linker during dead code=20
elimination, which leads to the resolve_btfids build failure mentioned abov=
e.

> +	kthread_exit(code);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-stu=
bs-v2-1-a0d8c6ad1738@suse.com?part=3D1
