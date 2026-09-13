Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B903368D76
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314581; cv=none; b=qWqdRb/hZ1tmAdudtOsYBWVgcsfX2RrMySxxR5j4vekxAKHh2+rySQVJIWILIuZyhVMs83Kh1IdsEyWbefcmtDc+nfk//eTYI/dakbBvcsNj9FsIbrJOubJl1gzTVyuNO1Tcs8vy30vE5x9tInR3NUgH53P4AY/3xiytjPqlSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314581; c=relaxed/simple;
	bh=X75EtRD2388NtG0Oa1NqeZrIwCyzXn/H4pYUA6iHync=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VkolkWAi17+9klfbUiQFb+R4IU5Whh5B3S/PfvxS2dhB6UH51SgpSdUXLGRpMxQWvd4PY1H5DbV0ntonJe8Di0rzAxMPc2w7r+GfEtW93UniWICHU6bdHzoBVe9TtL/05SXvdcmsh4ERX+E9l+SEaepPQ/gLvKjqaQOtdOnDLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+Vy/shq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Vy/shq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD41F000FF;
	Sun, 13 Sep 2026 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789314579;
	bh=xKZ61gLka90CyeTFxYGpjMbJ38y4zLm+D02llTwH6e0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q+Vy/shqa2Dj0zHnYS6GIuLaYC1VuhXB8A611mgjow3ae+1ODjUbCjwYpA3C2lRq6
	 2cXojpHlGigZPsYoh0HCvoleVf06TlPf0XDZykFO3WfAuzL5FvJCWN7lwBvqCkRrP0
	 pvPu+e/208AjojUYOP5e5BsbAJvdVOWRIySzXel1XmjIjnuTpS0rNHXL29SPrcfWyS
	 v6IdgWfrRUruATqYVKy1wjquWBvrguZq8OlXj/uvEwFXapz1JMMGl+4gdoRi6vinr0
	 3Il9c9GjeIa+1LNFXX3tDz0rrT0FIyjGqKudnXfk1NGOJYQaNjZPlNfOpfZY6GBzLL
	 xPoNy7A/Jg1mA==
Content-Type: multipart/mixed; boundary="===============7879078182914649759=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f85793fdaef592ac92c1a8a338ea3973f859920d50dc6eab84293dbd1257b048@mail.kernel.org>
In-Reply-To: <20260913145233.1446643-4-caomingpei@gmail.com>
References: <20260913145233.1446643-4-caomingpei@gmail.com>
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Cover struct_ops bitfield and offset validation
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ameryhung@gmail.com,qmo@kernel.org,caomingpei@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 13 Sep 2026 15:49:39 +0000 (UTC)

--===============7879078182914649759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> index 71c420c3a5a6..846b5a934dc8 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c

[ ... ]

> @@ -76,6 +76,23 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>  	.zeroed_op = (void *)zeroed_op,
>  };
>
> +struct bpf_testmod_ops___local_bitfield {
> +	int data;
> +	unsigned int extra_bitfield:31;
> +	unsigned int extra_bitfield2:1;
> +	char onebyte;
> +};
> +
> +SEC("?.struct_ops.link")
> +struct bpf_testmod_ops___local_bitfield testmod_local_bitfield;
> +
> +struct bpf_testmod_ops___bad_offset {
> +	unsigned int extra;
> +};
> +
> +SEC("?.struct_ops.link")
> +struct bpf_testmod_ops___bad_offset testmod_bad_offset;

This is the first place in the tree that puts two struct_ops variables
into the same '?'-prefixed section. Does libbpf handle this correctly?

Looking at init_struct_ops_maps() in tools/lib/bpf/libbpf.c, the code
receives one sec_name for the whole section and advances it inside the
per-variable loop:

    for (i = 0; i < btf_vlen(datasec); i++, vsi++) {
            ...
            map = bpf_object__add_map(obj);
            ...
            if (sec_name[0] == '?') {
                    map->autocreate = false;
                    sec_name++;    /* persists across iterations */
            }

Both new variables live in the same ELF section "?.struct_ops.link", so
they are handled by a single init_struct_ops_maps() call. libbpf sorts
DATASEC var_secinfos by offset (btf_fixup_datasec()), so iteration 0 is
testmod_local_bitfield (offset 0, size 12): sec_name[0] == '?',
autocreate is set to false and sec_name is advanced to ".struct_ops.link".

On iteration 1 (testmod_bad_offset, offset 12) sec_name[0] is now '.', the
branch is not taken, and testmod_bad_offset keeps the default
autocreate == true from bpf_object__add_map().

As a result:

1. The SEC("?...") annotation on testmod_bad_offset is inert.
   bpf_map__set_autocreate(skel->maps.testmod_bad_offset, true) in the new
   test_struct_ops_bad_member_offset() is a no-op, so the test's apparent
   opt-in isolation is not real.

2. testmod_bad_offset is now initialised and created during every other
   subtest that loads this shared skeleton: struct_ops_load,
   struct_ops_not_zeroed, struct_ops_incompatible, struct_ops_null_out_cb,
   struct_ops_forgotten_cb, test_detach_link, plus test_cpp.cpp:127
   (struct_ops_module__open_and_load()). Those loads happen to still
   succeed today only because 'extra' is absent from the kernel struct
   bpf_testmod_ops and the zero-filled variable passes the
   libbpf_is_mem_zeroed() fallback in bpf_map__init_kern_struct_ops() -
   i.e. the negative-test map is now silently registered as a real
   struct_ops map in unrelated tests.

3. The outcome depends on which variable LLVM emits first in the section.
   If testmod_bad_offset were emitted at offset 0 and testmod_local_bitfield
   after it, then testmod_local_bitfield would be the one with
   autocreate == true, and every other subtest plus test_cpp would fail
   their load with -ENOTSUP "local bitfield extra_bitfield is not
   supported". The patch works only by relying on unspecified
   global-emission ordering.

Giving each optional map its own section name (e.g. distinct sections or
fixing libbpf's init_struct_ops_maps() to not advance the shared sec_name
inside the loop) removes the coupling.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34765254213
--===============7879078182914649759==--
