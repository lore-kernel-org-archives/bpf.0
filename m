Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4683A75AB
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630302; cv=none; b=c9TGRzfE2BQgGaLPdPNqpCF4MRbOfLHby6X6DfXr7sH++3p1zqeKyhOBqM3ifpmi7binOqiIlDmDrJvxmHcoh+uld5ODPqzU87U6fmfTQkq4RgKBeV4IYWgGj3caYZEK4oyhwrkl2z7JBHgFccJNnDyiBVomeIBabSco67HNn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630302; c=relaxed/simple;
	bh=XvqagfhOZdNS/U2+g4qgNNZCZCKvIzP2nNX6//fbb/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tBjZzOfDWa43Dm0tzi84huGJOU0kBs9KBGmbKNOGQqZ7qa5O0fy2yNpsu1J78cnCc+es3n80xuhBnrsPft/TgVebtRxERPaM6IjZC9rX0nuyisNll1jCuUK+Js595Peu5q8V+1dX1KM9UCgTWLqNrXijabneKXCz5RtxAsQ0xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joibfsz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joibfsz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A214C2BCB0;
	Tue, 12 May 2026 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630301;
	bh=XvqagfhOZdNS/U2+g4qgNNZCZCKvIzP2nNX6//fbb/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Joibfsz8Eb5j+azBmwpd2d4ShjUjeiHydyO+9SHw2xh9Y+JGUKOYlU6CU/acCDC+f
	 BXLpCvLY+2S7nUZv7FbhotbxYKqaI/qbBWq3QULB1zx4v3e0MuiqwMbeWpnpIogbii
	 lC7rnAqlqWTErf8c0f+NC3o+m72zKpVCpKBNyHfaBq8/0PxDb3ye1dgdAPt2opCWmN
	 4QVVG40YYlonuqo9qdPi03IOCpDeV3aG0x5RlXofFIp7/5n+nL/jSGMRHdpy6SAJ+1
	 nksu7odf0A4iGe22e63ZmFypZ2Dfbx4oOCNnJLPUPfQYKhVBagJK2Lkt1rWY29BlRN
	 Pc7sWGsbeDa5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add tests for wakeup_sources
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Wu" <wusamuel@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511174559.659782-3-wusamuel@google.com>
References: <20260511174559.659782-3-wusamuel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:58:21 +0000
Message-Id: <20260512235821.9A214C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] BPF verifier rejection due to direct memory access on scalar regis=
ter
- [High] Incorrect expected failure messages will cause negative tests to f=
ail
- [Medium] Early return upon skeleton load failure skips the negative test =
suite
- [Medium] Architecture portability issue due to layout mismatch in shared =
structure
- [Medium] Uninitialized memory leak in ring buffer
--

commit 4b176327f91f44d20f491d6779d845f94357d717
Author: Samuel Wu <wusamuel@google.com>

selftests/bpf: Add tests for wakeup_sources kfuncs

This commit introduces a set of BPF selftests to verify the safety and
functionality of wakeup_source kfuncs. It includes a functional test iterat=
ing
over the global wakeup_sources list and a negative test suite for verifier
checks.

> diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source.c b/too=
ls/testing/selftests/bpf/prog_tests/wakeup_source.c
> index 0000000000000..ebfdc03271b9a 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source.c
[ ... ]
> @@ -73,46 +73,46 @@ void test_wakeup_source(void)
>  		return;
>  	}
> =20
>  	if (test__start_subtest("iterate_and_verify_times")) {
>  		struct test_wakeup_source *skel;
>  		struct ring_buffer *rb =3D NULL;
>  		struct rb_ctx rb_ctx =3D {
>  			.name =3D "bpf_selftest_ws_times",
>  			.found =3D false,
>  		};
>  		int err;
> =20
>  		skel =3D test_wakeup_source__open_and_load();
>  		if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>  			return;

If test_wakeup_source__open_and_load() fails, the code executes an early
return. Does this silently skip running the negative test suite via
RUN_TESTS(wakeup_source_fail) at the end of the function?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/test_wakeup_source.c b/too=
ls/testing/selftests/bpf/progs/test_wakeup_source.c
> index 0000000000000..fd2fb6aebd82b 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_wakeup_source.c
[ ... ]
> @@ -32,61 +32,61 @@ int iterate_wakeupsources(void *ctx)
> =20
>  	bpf_for(i, 0, MAX_LOOP_ITER) {
>  		if (bpf_core_read(&pos, sizeof(pos), &pos->next) || !pos || pos =3D=3D=
 head)
>  			break;
> =20
>  		struct wakeup_event_t *e =3D bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
> =20
>  		if (!e)
>  			break;
> =20
>  		struct wakeup_source *ws =3D bpf_core_cast(
>  				(void *)pos - bpf_core_field_offset(struct wakeup_source, entry),
>  				struct wakeup_source);
>  		s64 active_time =3D 0;
>  		bool active =3D BPF_CORE_READ_BITFIELD(ws, active);
>  		bool autosleep_enable =3D BPF_CORE_READ_BITFIELD(ws, autosleep_enabled=
);
>  		s64 last_time =3D ws->last_time;

Since pos is read from memory via bpf_core_read(), the verifier tracks it as
a SCALAR_VALUE. Because ws is derived from pos via pointer arithmetic,
will the BPF verifier reject direct memory dereferences like ws->last_time
with an "invalid mem access 'scalar'" error?

Should these accesses be wrapped in BPF_CORE_READ() instead?

[ ... ]
> @@ -76,17 +76,17 @@ int iterate_wakeupsources(void *ctx)
>  		e->last_time_ns =3D last_time;
>  		e->max_time_ns =3D max_time;
>  		e->prevent_sleep_time_ns =3D prevent_sleep_time;
>  		e->total_time_ns =3D total_time;
>  		e->wakeup_count =3D ws->wakeup_count;
> =20
>  		if (bpf_probe_read_kernel_str(
>  				e->name, WAKEUP_NAME_LEN, ws->name) < 0)
>  			e->name[0] =3D '\0';
> =20
>  		bpf_ringbuf_submit(e, 0);

bpf_ringbuf_reserve() does not zero-initialize the memory, and
bpf_probe_read_kernel_str() does not pad the remainder of the buffer with
zeroes if the string is shorter than WAKEUP_NAME_LEN.

Could this expose uninitialized kernel memory from previous ring buffer uses
to user-space through the remainder of e->name?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/wakeup_source.h b/tools/te=
sting/selftests/bpf/progs/wakeup_source.h
> index 0000000000000..cd74de92c82f8 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/wakeup_source.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright 2026 Google LLC */
> +
> +#ifndef __WAKEUP_SOURCE_H__
> +#define __WAKEUP_SOURCE_H__
> +
> +#define WAKEUP_NAME_LEN 128
> +
> +struct wakeup_event_t {
> +	unsigned long active_count;
> +	long long active_time_ns;

Because this structure is shared between BPF and user-space, could using
architecture-dependent types like unsigned long cause a size and layout
mismatch?=20

BPF programs are compiled for a 64-bit target where unsigned long is 8 byte=
s,
but the user-space selftest may be compiled on a 32-bit host (like ARM32) w=
here
it is 4 bytes.

Should explicitly sized types like __u64 be used for shared structures?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/too=
ls/testing/selftests/bpf/progs/wakeup_source_fail.c
> index 0000000000000..b8bbb61d4d4e0 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
[ ... ]
> @@ -44,19 +44,19 @@ int wakeup_source_access_lock_fields(void *ctx)
>  	val =3D *(int *)lock;
> =20
>  	bpf_wakeup_sources_read_unlock(lock);
>  	return val;
>  }
> =20
>  SEC("syscall")
>  __failure __msg("type=3Dscalar expected=3Dfp")
>  int wakeup_source_unlock_no_lock(void *ctx)

Is this the correct expected failure message for a kfunc argument?

The check_kfunc_args() function typically emits messages like "arg#0 pointer
type mismatch" when an incorrect type is passed, whereas "expected=3Dfp" is
usually emitted by check_func_arg() for standard helpers.

Will this test fail because the verifier output doesn't match the expectati=
on?

>  {
>  	struct bpf_ws_lock *lock =3D (void *)0x1;
> =20
>  	bpf_wakeup_sources_read_unlock(lock);
> =20
>  	return 0;
>  }
[ ... ]
> @@ -60,17 +60,17 @@ int wakeup_source_unlock_null(void *ctx)
>  	bpf_wakeup_sources_read_unlock(NULL);
> =20
>  	return 0;
>  }
> =20
>  SEC("syscall")
>  __failure __msg("R0 invalid mem access 'scalar'")
>  int wakeup_source_unsafe_dereference(void *ctx)
>  {
>  	struct list_head *head =3D bpf_wakeup_sources_get_head();
> =20
>  	if (head->next)

Since bpf_wakeup_sources_get_head() returns a BTF pointer, the verifier tra=
cks
it as PTR_TO_BTF_ID.

Because the verifier allows direct dereferences of trusted pointers (result=
ing
in PROBE_MEM), will this program successfully load instead of failing with =
the
"invalid mem access 'scalar'" error?

>  		return 1;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511174559.6597=
82-1-wusamuel@google.com?part=3D2
