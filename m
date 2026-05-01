Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654C36607D
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670135; cv=none; b=gl3sp1oY1VKbnoecXEGUSC0ivVEo0QjFN9u2DEagyjIL00J9na9Cwj7+3tM/pHQ/E5CwkVvlrhScW4cZahvnhZLbYi2DGVtcOdkL8aD8VY1of4OqJp+SzQ4nDjBDLVBwP5zAw0BzLv8MsnJ9lOVzAu2YDMQ1/7SDPAoJwgzKg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670135; c=relaxed/simple;
	bh=jxjmOwLyUPIPw9O2nsIiqGlfPEE7Ot7XTJvJcppgvnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BZ0gJ5dlj92JfxU0ij13YQL2hoS3K7ewXBaF8Y7XHI8IuRzH1G0gKXZRKr7WwLbkP7x8ao9ixJueC4RKK/9neKvENUv+RNIzY4zJwxfW/esdn0Pw2ItfVXI5ZtFnE6+ubQIuNow7gRp/0l/FZNrmjhT3Eocjxkrggi6lMroCaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjYbiaZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjYbiaZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A834C2BCB8;
	Fri,  1 May 2026 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670135;
	bh=jxjmOwLyUPIPw9O2nsIiqGlfPEE7Ot7XTJvJcppgvnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WjYbiaZ8+T7OdwS1MZvQXD14VbD8J95BERKDLZdPctrZfHWIAVppsmKzlPB29UMYp
	 FuXOKemYsxLjJO723sq86EskPILb0z6OeQnvT2JoJvKiMqBogOLYJgOA7s1Nflp5jn
	 6+yFXtt1Z9pFc3Uke0tIqbopK7T9UEugyIqD9EAVbN3PsD3Vipxc/1pqeaxnj9yosh
	 S0CxqrBm84/MiVcsiExFS32lUDhxEnPSP00EGwkOjnB/Ks+j4R0VAHVd1EJDkM1Zqt
	 p0He9pjjoveAWe97M3Uu42RRGhH+fsmE1usLiNQhpe0QKKKeVit0+7Zz+9womGQ3OO
	 4782cRjA7cdmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] lib: compile generic bitrev.c conditionally on
 GENERIC_BITREVERSE
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430211351.658193-6-ynorov@nvidia.com>
References: <20260430211351.658193-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 21:15:34 +0000
Message-Id: <20260501211535.4A834C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit breaks loadable module support for `lib/bitrev.c` by =
forcibly compiling it statically into the core kernel (`vmlinux`) even when=
 configured as a module (`CONFIG_BITREVERSE=3Dm`).
--

commit 7ea6ceee0bfd2cae761187221063672a5947f4c4
Author: Yury Norov <ynorov@nvidia.com>

lib: compile generic bitrev.c conditionally on GENERIC_BITREVERSE

This commit simplifies the build logic for the generic bit-reversal library.
It changes the Makefile to compile lib/bitrev.c based on
CONFIG_GENERIC_BITREVERSE instead of CONFIG_BITREVERSE, and removes the
corresponding preprocessor conditionals from the source file.

> diff --git a/lib/Makefile b/lib/Makefile
> index f33a24bf1c19a..23e07d19d01c9 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -145,7 +145,7 @@ obj-$(CONFIG_DEBUG_PREEMPT) +=3D smp_processor_id.o
>  obj-$(CONFIG_LIST_HARDENED) +=3D list_debug.o
>  obj-$(CONFIG_DEBUG_OBJECTS) +=3D debugobjects.o
> =20
> -obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
> +obj-$(CONFIG_GENERIC_BITREVERSE) +=3D bitrev.o

Will this break loadable module support for lib/bitrev.c?

CONFIG_BITREVERSE is a tristate, allowing the library to be built as a
module. However, CONFIG_GENERIC_BITREVERSE is a boolean. When
CONFIG_BITREVERSE is set to modular, CONFIG_GENERIC_BITREVERSE evaluates
to y.

By switching the Makefile rule to use CONFIG_GENERIC_BITREVERSE, bitrev.o
will be built into the core kernel unconditionally when the generic
implementation is used, even if a modular build was requested.

Could this regression lead to unintended kernel bloat by ignoring the
configuration intent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430211351.6581=
93-1-ynorov@nvidia.com?part=3D5
