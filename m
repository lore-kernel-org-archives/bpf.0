Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A297331EBC
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599451; cv=none; b=E/Fe7hS+1N6WHhRtmZWxBnKbXWzxF8gZ15gU80ufjc2NIrq7pUxRew67/zBt4IDSIle+ymzNN/PDBLB5g7IrHO6I4F9SU80SKc0ojyrz+MSJo9odaNQROBqPi47zsy1GQiNKZJXItEZAYjPwB2WVehmB793TwOY+pz1QMHUmwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599451; c=relaxed/simple;
	bh=lz1OCQ2sQ+5annchJ7niCTwVzll5LUmzgw1ESv151A4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WnutK/9NOx3tBw+yH+twE4+dEY4r1SeXvQJdTjGGzIsbtFCmItUp9gqh5y4iClwJid/S9hRGBTgpyWtOaACjEE98lUvGu40VLhDuXeK6aM8HDNMFsRAvi54jhElw6e8a1A3Eagjm5mc3nWL+ySyLqY1XvbzcFc9m5EEm8ZY+EXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLtImVVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLtImVVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB61F00A3E;
	Sat,  5 Sep 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788599449;
	bh=ES8R3CuegPayR9r2plLeLdw4O4w6CI8gEA13cSZ5QnU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XLtImVVG8010ma/23Y1EsVro667UU6BU+OWLeSP7WW8fSN6pp4+VzvneS4t65mSlp
	 jhVdkv+p4r1WenGAOWbq9dhkwfw4sSQaQaYPHKc4AmK3XKzTFSMc7aOGpQiTzUGery
	 uwse3nI0dCyPUs1iI7hE+cQwKxiPFobip2To7FtGdLTARWDWvMAfv3FNDDiPQBc65x
	 7+cii5kfV7BCU7pUWVF5JJw8IqvWqXugCVeofXP/VcJJoRzdmvsZc+/jBeeTsTFQRK
	 wjoWzbL3ejHgxzRvbC8r7TjV6VPPMQGPny9fU8ETznE0THIJEAxHQ1aiys/eCiE8FI
	 2nHK36CttCEHA==
Content-Type: multipart/mixed; boundary="===============1312955101584312548=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef316c927b247279b1ef545f4d8a49c9e5c9430b9c9a841ef057041dcaeae444@mail.kernel.org>
In-Reply-To: <20260905083418.3723623-8-memxor@gmail.com>
References: <20260905083418.3723623-8-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 7/7] selftests/bpf: Check callback map value lock identity
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 09:10:49 +0000 (UTC)

--===============1312955101584312548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit bc45ac4e826b8cd6d25406fcd3cef1fbb13c58c1
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Date:   Mon Apr 28 20:52:43 2025 +0000
>
>     selftests/bpf: Check callback map value lock identity
>
>     Add a verifier test which retains a map value from an outer callback and
>     then acquires a lock through an inner callback value before attempting to
>     release the outer callback value. Both values can denote different elements,
>     so the verifier must reject the mismatched unlock.
>     Also exercise two distinct one-element inner arrays. Their concrete map
>     instances share inner-map metadata, but their callback values must retain
>     distinct lock identities.

The commit message states that lock identities are distinct because "their
concrete map instances share inner-map metadata, but their callback values
must retain distinct lock identities." Is this the correct explanation?

Looking at refine_map_lookup_value() in the verifier, it assigns
reg->map_uid = reg->id where reg->id is a fresh ++env->id_gen per lookup.
This means map_uid encodes the lookup operation, not the concrete inner map.

In callback_inner_map_value_lock_identity, the outer lookup uses
inner_key=0 and nest_lock_different_inner_value uses inner_key=1. These
two separate bpf_map_lookup_elem call sites would get different map_uid
values (and hence different callback-value IDs) even if both used
inner_key=0 against a single shared concrete inner map.

Shouldn't the explanation be about distinct lookups preserving distinct
identities, rather than about the two concrete inner maps?

>     Keep a nested same-element lock/unlock program as a positive control. This
>     ensures assigning fresh identities to callback map values does not reject
>     balanced locking through one callback argument.
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 64ac49ad67e6..5c572dd725e7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -25,6 +25,7 @@
>  #include "verifier_btf_ctx_access.skel.h"
>  #include "verifier_btf_unreliable_prog.skel.h"
>  #include "verifier_call_large_imm.skel.h"
> +#include "verifier_callback_lock.skel.h"
>  #include "verifier_cfg.skel.h"
>  #include "verifier_cgroup_inv_retcode.skel.h"
>  #include "verifier_cgroup_skb.skel.h"

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callback_lock.c b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
> new file mode 100644
> index 000000000000..d23e13908ceb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct bpf_map;
> +
> +struct lock_value {
> +	struct bpf_spin_lock lock;
> +};
> +
> +struct inner_lock_map {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct lock_value);
> +} inner_lock_map_a SEC(".maps"), inner_lock_map_b SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(max_entries, 2);
> +	__type(key, int);
> +	__array(values, struct inner_lock_map);
> +} lock_map_of_maps SEC(".maps") = {
> +	.values = {
> +		[0] = &inner_lock_map_a,
> +		[1] = &inner_lock_map_b,
> +	},
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 2);
> +	__type(key, int);
> +	__type(value, struct lock_value);
> +} lock_map SEC(".maps");

A subsystem pattern flags this as potentially concerning:

A new prog file is being added for spin-lock identity mismatch tests,
but tools/testing/selftests/bpf/progs/test_spin_lock_fail.c already
exists in the same directory and is dedicated to exactly this behavior.

That file already has lock_id_mismatch_* programs (kptr/global/mapval/
innermapval variants plus lock_id_mismatch_mapval_mapval and
lock_id_mismatch_innermapval_innermapval1/2), and every one of those
expects "bpf_spin_unlock of different lock" - the same string these
tests expect.

The three new programs here are callback-frame variants of the same
mismatch (one more source of lock identity), and the map fixtures
(lock-bearing ARRAY plus ARRAY_OF_MAPS of lock-bearing one-element
inner arrays) closely resemble fixtures already in test_spin_lock_fail.c.

Could the three programs be added as new cases in test_spin_lock_fail.c
to avoid duplicating the fixtures and keep all lock-identity cases
discoverable in one place?

Note: There may be a defensible reason to keep them separate -
test_spin_lock_fail.c uses a hand-maintained table in
prog_tests/spin_lock.c and pulls in vmlinux.h + bpf_experimental.h,
while this file uses modern __failure/__msg annotations and needs no
table entry. Just checking whether the split is intended.

[ ... ]

> +SEC("?tc")
> +__description("nested callback can lock its own map value")
> +__success
> +int callback_value_lock_identity_same(void *ctx)
> +{
> +	bpf_for_each_map_elem(&lock_map, nest_lock_same_value, NULL, 0);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

The preceding kernel commit 06ece9a5c36d ("bpf: Assign lock identity to
callback map values") adds the same three-line ID assignment to three
frame constructors - map_set_for_each_callback_args(),
set_timer_callback_state(), and set_task_work_schedule_callback_state() -
and adds a deliberate exception, map_value_has_static_identity(), that
keeps ID 0 for top-level one-element ARRAY maps.

Does this test file exercise all those paths?

Looking at the programs, they all use bpf_for_each_map_elem, so they
only exercise the for-each constructor. Nothing here loads a
bpf_timer/bpf_wq/bpf_task_work callback whose map value carries a
bpf_spin_lock.

Also, all three programs iterate maps with max_entries==2, or inner maps
with a non-zero map_uid, so map_value_has_static_identity() returns
false on every path the tests reach. The ID-zero exception is untested.

Should additional test cases be added to cover:
- timer/task-work callback constructors with spin locks?
- the map_value_has_static_identity() exception (single-element top-level
  ARRAY)?

A regression that removed the !map_value_has_static_identity() guard, or
that dropped the assignment from the timer/task-work constructors, would
still pass this test file.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33955969043
--===============1312955101584312548==--
