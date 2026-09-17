Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B94CDDFC
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677561; cv=none; b=JnIwPLmdfrtVIcvGnxFVpdYISSGnPvlqRxwAXFxgvxwFO2BBiSRnAQrXpDovtkkeKe7r5upQuQGu2WvjqD2wW/fHAKt8Z7zKbi6kTfsUP2upguBExCog4nTORFttgKIhWKiIfSvRgTU10J6T+A/zNr24mhdw+zlLL/HkD/NX7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677561; c=relaxed/simple;
	bh=nErkDrtV5/AjATaOqE6IcKTQrfOQKC9QUwkcHfWUbo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjrqD9BN6gd66p5Ni/A5ASUCv4IzVssUuVUpXJwkK7ZzsolAOnB8oqioaKgjrhaQUbbJlZ6SLqwWU6wszq8ylbUR+QNecV77BlKLXiOOsCNHJ4LRjmnVDF5o35B9Y+poxVRVVdRVvO7+kWsmxFo0Npo1d2S8A15O+mZ8dLooJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwkgt7gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwkgt7gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F51F000FF;
	Thu, 17 Sep 2026 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677560;
	bh=31SjR9YfSgo+/X/fnvQjy51ltGJdhxC1bHPrZmH1l0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gwkgt7gvYz7/XLqpCWQqxZHM45t1CFmhcQZEA+PWxyA1u74AyW5IYmIYLUt0WyvHO
	 2a0PjUebARa+AQPiQXlt4BS32USOwC0YEeprjneYvSIn+pJDGxQGHtw6ZlK/V92o1v
	 +QO75IhwJdHrWSc+R/pWjWiN48H63y43WhGkYxzciJw3PV3BfkAKUrnKqjbOmLcJX6
	 haVIDCsOuk79njl6mTDoQ6Tv5ouMh/ZzpbwaWn+Chs/G0rxlsHhf3AamHFkb+kG/36
	 ikVNE4hWS3bxB1lGfLE4WC3dZUWIr/FHdtYfXf/jxhH/JQTLTGFEBAoVRwlipNXTy8
	 orl1Q9WwKSzxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Cover BPF program load
 strategy transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917203040.3150212-6-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
 <20260917203040.3150212-6-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:39:19 +0000
Message-Id: <20260917203920.433F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_link leaked on selftest error path
--

commit 82f598b63abc74f2a315872de7cd207f7e441280
Author: Slava Imameev <slava.imameev@crowdstrike.com>

selftests/bpf: Cover BPF program load strategy transitions

This commit adds a load_type test to cover BPF program load strategy
transitions. It verifies transitions between DISABLED, AUTO, and MANUAL
strategies, as well as the behavior of autoattach.

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/t=
esting/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..55ca53685863c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_load_type.skel.h"
> +
> +void test_load_type(void)
> +{
> +	struct bpf_link *link;
> +	struct test_load_type *skel;

[ ... ]

> +	/* attach prog3 */
> +	link =3D bpf_program__attach(skel->progs.prog3);
> +	if (!ASSERT_OK_PTR(link, "attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_again"))
> +		goto cleanup;

[Severity: Medium]
Will this leak the bpf_link if the assertion fails?

When the test assertion fails, it jumps to the cleanup block in
test_load_type(), skipping the explicit bpf_link__destroy() call. Because
test_load_type__destroy() doesn't clean up manually attached programs,
the link will be leaked.

Also, if you choose to fix this by adding bpf_link__destroy() in the
cleanup block, it looks like the link variable is uninitialized at declarat=
ion,
so it might be necessary to initialize it to NULL as well.

> +
> +	/* detach prog3 as test_load_type__destroy doesn't detach manually load=
ed programs */
> +	err =3D bpf_link__destroy(link);
> +	ASSERT_OK(err, "link_destroy");
> +
> +cleanup:
> +	test_load_type__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917203040.3150=
212-1-andrey.grodzovsky@crowdstrike.com?part=3D5
