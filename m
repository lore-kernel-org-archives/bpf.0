Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A453F8EB4
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421161; cv=none; b=RdeDtlghxuXa8mjwq17nvG1DCAcldyCOx2OZsgn4HbUEow/Kn3hGnS2xcM8pRT//sOrtKJSFjESBPboYTw//4fDmtzyRwNyK5YYDG+d5bVCyno6PazAt0eJ/7hvv/sAfdwctsp4jK8nUZbZKTyWgMwoD8n78sdE7Y8vQic9E56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421161; c=relaxed/simple;
	bh=IT6I/3Zno+NO3Cuj4K5LWdh9boWuPO9/GhL3kMZ4B/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKTz32tMYnelbcZ/f4LHrsaMZZ5lTOp3rePr70ypoRGjd2rX28514yzylP02EKpXA1L12R4t2Rdy5OLwN4Zojxy9dUX0oSCdEx/DDLm8NU9STXghjNtOcXAgkVJMVbCSJUMM7gzMg3o7viPRjq5fXvHJwYoEco7WkNR2PlTjOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2kLduNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2kLduNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1D1F00898;
	Tue,  2 Jun 2026 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421159;
	bh=924y3xmxSTlfelh/p9f3kho8xXh8rAgumAP7TjYh6sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2kLduNRBy4/Qd7XyhLZSQWVdsSpCFIiCassm1nxUD1frjKtu1F3U76Ogi+zqwL5E
	 SfbXgOrfhD3GvyfwtF1N6cEInddqrGTL0Wyclzj+x1MSbtaUbyh/Zi7fCO66UpfDxV
	 yTY+U94z69AXSzLPexyUg+Le93Zt0FBJdAQQa7nbnMftp5uDlQqvYHXOkClhMdNLkh
	 P2u7/PPMt8XFRkwLCFazHJxVE1Kf+masu4VWtAYAtuYwAraHX2HBJ/niTI0yez7AHB
	 IjoUHQJbJkuS3vnvth1u0n/1jaF6y/3E8vG3Am+lXlJUBqxw8gTeO8Dyhjt7jMZnyG
	 PzeixWIbH8Nsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 7/8] selftests/bpf: Use common CFLAGS for
 urandom_read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 17:25:59 +0000
Message-Id: <20260602172559.B3A1D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Replacing CFLAGS with COMMON_CFLAGS for urandom_read breaks cross-c=
ompilation with Clang.
--

commit 537d69efefb1121c195758d9362eba3f31c54f36
Author: Leo Yan <leo.yan@arm.com>

selftests/bpf: Use common CFLAGS for urandom_read

This commit introduces a COMMON_CFLAGS variable to separate general flags
from CC-specific ones that might be incompatible with CLANG when building
urandom_read and its shared library.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index bc049620c7745..1e47e29ba4214 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -51,7 +51,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
> =20
> -CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11				\
> +COMMON_CFLAGS =3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11				\

[Severity: Low]
Does this change break cross-compilation with Clang?

By defining COMMON_CFLAGS from scratch without including the pre-existing
CFLAGS, this drops any earlier contents from the urandom_read build.
This strips CLANG_CROSS_FLAGS (which is appended to CFLAGS earlier by
tools/scripts/Makefile.include), depriving Clang of essential
cross-compilation arguments like --sysroot and --gcc-toolchain.

Does this also inadvertently ignore any user-provided CFLAGS?

[ ... ]

> @@ -261,7 +261,7 @@ endif
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c li=
burandom_read.map
>  	$(call msg,LIB,,$@)
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \

[Severity: Low]
When replacing CFLAGS with COMMON_CFLAGS here for the shared library build,
does this remove the required sysroot and toolchain cross-compilation flags?

[ ... ]

> @@ -271,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c ura=
ndom_read_lib2.c liburandom
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) $(filter %.c,$^=
) \

[Severity: Low]
Similarly, does the urandom_read build rule also lose these required
cross-compilation flags when using COMMON_CFLAGS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com?part=3D7
