Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046A2264C0
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363920; cv=none; b=VI0p+FVZd/145GpsOzbioSvTNvrsfqCbUHrO9Tls1RHzvF8s7LcuMSEBab5JuobAxichGatUz7/PRaSK6cT/V2czX6n3XC/ok83ADep5u2XiYjxQTHnQ9KNzHKx3RnFji5eGs00jn36M8LEv02FQB/QahzxNU6vU6xVvKAidc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363920; c=relaxed/simple;
	bh=LgziWZNA8xzhmH1cLRM9G84w107hkKvp8KAyDSsEgDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4SxN01X2q26uWcAAe0SDB9FwxGAMGx0W8GUA0mYqjxFkVfNXtJwR/5xPqVdFph30JaPk50Iu7jvLNIZ0e1sy0sE1wVNF50LS0Ll5ABS9EanZmhWiSDLk5hpLlcLJjcvz7bU5PooR/S5WBAT7w+X4s4syE8a0fmfbpn+N7m1uS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBj2DebP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBj2DebP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57421F00893;
	Tue,  2 Jun 2026 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780363919;
	bh=D0nkD05hgvUTxlj6+pA7sgytT6/aM+YUKBaGcNqMb0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBj2DebPoClqx3RWjCveFpOliMgScFi8Ot8gWH3YfU4xZbYiX80XMJB/pgbo4gJG8
	 Cig5q0PEjLqK2Cx13tDa1K//HGMZfkeWBfQdWU2g8vzDzRj65HrPl/O8CI+JobTQWv
	 SFPAo04/xDtuyXIHzCEtvp0ddjgOT8bQJfX8nc5rG7YXRiiQ3ATC7CR2beLeZ/B6VA
	 uAmeELyCD8yVfTt57oeBgRrP63K2aPh6u8S9xIk6Yk/ydvET0rhUH/25F/MtkrvtY4
	 iRFWhbvn/c1I3yOB2/gWhlkT5vP6OEEL2SX9VwBpzuBVigB65zI6ZB9MQYylqkVzps
	 UwWOVBpiZ4s8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: Remove __arg_arena from
 the codebase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602004120.17087-5-emil@etsalapatis.com>
References: <20260602004120.17087-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 01:31:58 +0000
Message-Id: <20260602013158.D57421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Leftover `__arena` typedefs in header files cause their correspo=
nding pointer types to silently drop the newly introduced `btf_type_tag("ar=
ena")` annotation.
- [Low] The removal of the fallback `__arena` macro from `bpf_arena_spin_lo=
ck.h` breaks the header's self-containment.
--

commit b79db788bee1871973404a0b3039c644cb84cce8
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Remove __arg_arena from the codebase

This commit removes the __arg_arena annotation by subsuming it into __arena,
which now includes a BTF type tag. To avoid compiler issues with BTF type
tags on non-pointer types, typedefs previously used for __arena are replaced
with direct pointer annotations.

> diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing=
/selftests/bpf/bpf_arena_htab.h
> index acc01a876668e..d7ba86362d862 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_htab.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
> @@ -14,9 +14,8 @@ struct htab {
>  	htab_bucket_t *buckets;
>  	int n_buckets;
>  };
> -typedef struct htab __arena htab_t;
> =20
> -static inline htab_bucket_t *__select_bucket(htab_t *htab, __u32 hash)
> +static inline htab_bucket_t *__select_bucket(struct htab __arena *htab, =
__u32 hash)
>  {

[Severity: Medium]
Since __arena now includes __attribute__((btf_type_tag("arena"))),
applying it to a non-pointer typedef causes the compiler to drop the BTF ty=
pe
tag on pointers declared with that type.

This patch removes htab_t to fix this, but does this miss other __arena
typedefs like htab_bucket_t and hashtab_elem_t in this file, or
arena_list_node_t and arena_list_head_t in bpf_arena_list.h?

Will pointers declared with those leftover typedefs silently drop their
BTF type tag annotations?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_=
lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> index 164638690a4df..ae6b72d15bb67 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> @@ -16,10 +16,6 @@
>  #define EOPNOTSUPP 95
>  #define ETIMEDOUT 110
> =20
> -#ifndef __arena
> -#define __arena __attribute__((address_space(1)))
> -#endif
> -
>  extern unsigned long CONFIG_NR_CPUS __kconfig;

[Severity: Low]
Does removing this fallback definition without including bpf_arena_common.h
break the self-containment of this header?

Any source file including bpf_arena_spin_lock.h on its own might now fail
to compile due to an undeclared __arena identifier.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/=
testing/selftests/bpf/progs/arena_spin_lock.c
> index 7236d92d382f1..cf7cda79c16c0 100644
> --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> @@ -4,6 +4,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> +#include <bpf_arena_common.h>
>  #include <bpf_arena_spin_lock.h>

[Severity: Low]
This isn't a bug in this file, but this looks like a workaround for the bro=
ken
header self-containment mentioned above. Should bpf_arena_common.h be
included directly in bpf_arena_spin_lock.h instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602004120.1708=
7-1-emil@etsalapatis.com?part=3D4
