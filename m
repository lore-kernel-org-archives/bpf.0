Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7639B956
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769262; cv=none; b=gPmmRGy9kZ9Kse8UNx+KQM7RJauSHtuCFeCeusdAcMNAPHl11sYI/L6R9mb9ig9CFDjYzOsChSWGeYsYB9+BHVkc+SY1ZExddFvOu/gQvoWsrXYt2oLHRd4//LgeKZrV52mWX+v6/VsuYWqEqVbLHPwgd+MDtkao4chxToXpEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769262; c=relaxed/simple;
	bh=G6ODFsAzZ/IX1uRf9G5Y/eGBAKg6MxslNA7wzCpZVgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gf67X4zCJiqRkKrD5ixqStK53hRkxXKfg7b9nlGSqTWHx9QIFzjHyQs8/LoDkCr5FLdgJv5m/C7Lmz7Ud8+mfERU+s93AscLWzFxRuha0anRJFx3w6eY/ygH6MSXypFjDIKS1BXAsw4f2ikXzKGJTn7Sx+eFT19E9o307vZ9St8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsU5Qy33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsU5Qy33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BE31F000E9;
	Wed, 26 Aug 2026 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769231;
	bh=arR/b6CFbC1+P5umGW3BGdAgrEWVDWVkt69k7kesrPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsU5Qy33nIePwAyHXEDacPIiM5y1ESKBh1nUBh/JAmU7th4Ij1/JHAGHCzG8KpP42
	 KnRuq8u3ethqFcMI47hG7iLMK6w7OfB0xyILcRLpiaYjttADxHJy5+Z0r7zpBNDLi0
	 4VdAwp3tjxGkjQLbSYkZJ77FBsIYR6QjL3FvqLPcs2nx7rD62doFezORvYQlGbJ3hR
	 2KfoCfx5mg3P77sMQtQeJPoOWFVHfsnXWuIA0UwMj+wEtXAQkztkkQ4cKJkNiFDEon
	 to0WzSzdmxRsh1pbKdBgDY+UkNzdP38evNrCchkPdz7aSWa3LcoXPH+V+2qbA6EPAe
	 3RA/n3SyG4PSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Cover BPF program
 dynamic loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:33:51 +0000
Message-Id: <20260826183351.92BE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Calling `bpf_program__load_dynamically()` multiple times on the sa=
me program overwrites `prog->fd` and leaks the previously loaded BPF progra=
m's file descriptor.
- [Medium] bpf_link leaked on error paths leaves system-wide raw tracepoint=
 active.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
- [Low] `dynamicload_verify_override()` is skipped entirely if the precedin=
g `test_dynamicload` logic encounters a failure.
- [Low] Missing early return check for state-altering assertion allows test=
 execution to continue in an invalid state.
--

commit eb781cf99ff72cd5528638c785d25a5ff470c1c9
Author: Slava Imameev <slava.imameev@crowdstrike.com>

selftests/bpf: Cover BPF program dynamic loading

This commit adds load_type and dynamicload tests to verify the per-program =
load
type enum (disabled/auto/dynamic) and its transitions. It also tests the fu=
ll
lifecycle of dynamic load/attach/reattach/unload.

> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools=
/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 0000000000000..799c43034ff92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_dynamicload.skel.h"
> +
> +/* prog4 is tagged __load_dynamic in the source instead of being set
> + * imperatively; verify that an explicit bpf_program__set_load_type() ca=
ll
> + * before load overrides the tag's declarative default.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment does not follow the mandatory=
 BPF
subsystem style, which requires the opening '/*' to be on its own line.

> +static void dynamicload_verify_override(void)
> +{
[ ... ]
> +void test_dynamicload(void)
> +{
> +	struct bpf_link *link;
> +	struct test_dynamicload *skel;
> +	int err;
> +
> +	skel =3D test_dynamicload__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	/* the __load_dynamic tag alone, with no imperative call, must set
> +	 * prog4's load type before it is ever touched below
> +	 */

[Severity: Low]
This isn't a bug, but this multi-line comment also does not follow the
mandatory BPF subsystem style.

[ ... ]
> +	/* attach prog3 */
> +	link =3D bpf_program__attach(skel->progs.prog3);
> +	if (!ASSERT_OK_PTR(link, "attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called"))
> +		goto cleanup;

[Severity: Medium]
Does this code leak the manually managed link object and leave the system-w=
ide
raw tracepoint active if this assertion fails? The cleanup path only destro=
ys
the skeleton, which doesn't track this standalone bpf_link object.

[ ... ]
> +	err =3D bpf_program__unload_dynamically(skel->progs.prog4);
> +	ASSERT_OK(err, "prog4_unload_dynamically");
> +
> +	test_dynamicload__destroy(skel);
> +
> +	/* separate scenario: imperative override of the declarative tag */
> +	dynamicload_verify_override();
> +	return;
> +
> +cleanup:
> +	test_dynamicload__destroy(skel);
> +}

[Severity: Low]
Is it intentional that dynamicload_verify_override() is skipped entirely if=
 the
preceding test_dynamicload() logic encounters a failure and jumps to cleanu=
p?
This could mask test coverage since it won't be reported as executed or ski=
pped.

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/t=
esting/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..fc91f6666c506
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,167 @@
[ ... ]
> +	/* bpf_program__set_autoload() is a thin forwarder to set_load_type(),
> +	 * restricted to AUTO/DISABLED to preserve its original bool on/off
> +	 * meaning; it does change the load type of a program that isn't
> +	 * currently BPF_PROG_LOAD_TYPE_AUTO.
> +	 */

[Severity: Low]
This isn't a bug, but this multi-line comment does not follow the mandatory=
 BPF
subsystem style, which requires the opening '/*' to be on its own line.

[ ... ]
> +	/* loaded program type cannot be changed */
> +	err =3D bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYP=
E_DISABLED);
> +	ASSERT_ERR(err, "set_load_type_after_load");
> +
> +	err =3D test_load_type__attach(skel);

[Severity: Low]
Should there be an early return check here? Without it, if the underlying A=
PI
mistakenly succeeds, the program's load state is incorrectly modified to
DISABLED and the test continues running, which could cause cascading and
confusing failures.

[ ... ]
> +	err =3D bpf_program__load_dynamically(skel->progs.prog3, 0);
> +	if (!ASSERT_OK(err, "load_dynamically_1"))
> +		goto cleanup;
> +
> +	err =3D bpf_program__load_dynamically(skel->progs.prog3, 0);
> +	if (!ASSERT_OK(err, "load_dynamically_2"))
> +		goto cleanup;

[Severity: High]
Does calling bpf_program__load_dynamically() multiple times on the same pro=
gram
overwrite prog->fd and leak the previously loaded BPF program's file descri=
ptor?
The test seems to actively rely on this behavior by loading the program twi=
ce
without an intervening unload.

> +
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
Will this bypass bpf_link__destroy(link) and leak the system-wide tracepoint
attachment if the assertion fails and jumps to cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826181825.1826=
541-1-andrey.grodzovsky@crowdstrike.com?part=3D5
