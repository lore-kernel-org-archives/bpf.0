Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D2F7F14;
	Fri, 28 Aug 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912259; cv=none; b=UQbb26nO+NkiRCSXB3XnBYtTNkUpC5T8OetAHe3LI6imdu2jGwu/VvQhBKAU2caaGDaclhJ558kRdTl/qtj8uHQkZspESmSx/yBqQe0Am5AI2hQXIzaPjgPKW8w2LylgL8E6loWUW1jjr5kIUo49AuNvew8F65SFowv8wRoC1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912259; c=relaxed/simple;
	bh=FUz9qI4QA7NVnVb09W6JnVtOxrKl1kV43wQRKQ/gPpE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rQgnx5Z/35jqslDhtsxK0zFvwR5pJktxhaNx/M1Sf1eK3gnS89DJaEs/+Nd9MLu5XtIoK0jsqAwJKB5CfrDPIu4m4HsWiYH69DJwQ9qWMiw/1S/mo/d9PiWTQHgECaBkj+08jODyJ5bRTPwb8gizfCYiCaXBCOdEh/raryHwRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgSMR+Ly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgSMR+Ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3041F000E9;
	Fri, 28 Aug 2026 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912257;
	bh=/jaJov8w0VZZHNFMIEwScO1SDzSxdnaOoSHGPvPT/SU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TgSMR+LyVmGApETjSmznJ8EbqHcGygCfbOINSxm3pJgc31+tjOkYyBq7vciWKNDEy
	 M63n2M90Adoet1BkiTEbB/hnfo83cbUGKK0hTS4sHrtnFkBO5pYx9vw1xs2yr3u6jj
	 /47lSN7D00sTFMzGqG2OKMvOhPKagex/q5P1BL2mFxZ61ZfSP5Uo4iZ7hQ+u7B7gsg
	 hP8g/xkHpWQNDzA3ftX8uRA++A/rSYhtvHc3ToZFBgIqnNVLuyiS1nOe/Hgasj+hfT
	 /VOxP/ZXvdpCrappQ7+8c8vD71V7lZ0xqy/muSZSxfVao/0sPzOKfYECz3Xzx8aJEt
	 e8i63SEw6Z5Xg==
Content-Type: multipart/mixed; boundary="===============7473488389980377832=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8705b5a092f5086b25a31ee0cb9d2a7a46105a013c003eed257950207463b210@mail.kernel.org>
In-Reply-To: <20260828093142.179856-2-jiayuan.chen@linux.dev>
References: <20260828093142.179856-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for key-less BTF hash map
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 10:17:37 +0000 (UTC)

--===============7473488389980377832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> new file mode 100644
> index 000000000000..6e1496cbd8bf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <test_progs.h>
> +#include <bpf/btf.h>

This isn't a bug, but tools/testing/selftests/bpf/prog_tests/btf.c already
has a table-driven harness for map-creation-rejection cases. do_test_raw()
(around btf.c:4519-4530) does:

    opts.btf_key_type_id = test->key_type_id;
    opts.btf_value_type_id = test->value_type_id;
    map_fd = bpf_map_create(test->map_type, test->map_name, ...);
    err = ((map_fd < 0) != test->map_create_err);

and struct btf_raw_test already carries .map_type, .key_size, .value_size,
.max_entries, .key_type_id, .value_type_id and .map_create_err, with six
existing .map_create_err = true entries already in that table. A key-less
hash/rhash case could be two more rows in that table rather than a new file.
Is there a reason to create a new file instead of adding cases to the
existing test?

> +
> +/*
> + * A key-less BTF (btf_key_type_id == 0) is only meant for array maps. A hash
> + * map with one used to NULL-deref in btf_type_show() when dumped via bpffs.
> + * A fixed kernel rejects such a map at creation; on an unfixed kernel the
> + * pin-and-read below deliberately walks that bpffs dump path, so running this
> + * test on an unfixed kernel panics it.
> + */
> +static void check_keyless(int map_type, __u32 map_flags, int btf_fd, int val_id)
> +{
> +	const char *path = "/sys/fs/bpf/keyless_map";
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	__u32 key = 1, val = 0x41424344;
> +	char buf[256];
> +	int map_fd;
> +	FILE *f;
> +
> +	opts.map_flags = map_flags;
> +	opts.btf_fd = btf_fd;
> +	opts.btf_key_type_id = 0;
> +	opts.btf_value_type_id = val_id;
> +	map_fd = bpf_map_create(map_type, "keyless_map", 4, 4, 8, &opts);
> +
> +	if (map_fd >= 0) {
> +		/* Unfixed kernel: reproduce the oops via the bpffs dump path. */
> +		(void)bpf_map_update_elem(map_fd, &key, &val, 0);
> +		if (bpf_obj_pin(map_fd, path) == 0) {
> +			f = fopen(path, "r");
> +			if (f) {
> +				while (fgets(buf, sizeof(buf), f))
> +					;
> +				fclose(f);
> +			}
> +			unlink(path);
> +		}
> +		close(map_fd);
> +	}

Does this block execute the kernel NULL-deref before the assertion can fail?

On any kernel lacking the companion fix f763f12b26fc ("bpf: Fix
NULL-ptr-deref when dumping a key-less BTF hash map") -- every kernel before
this series, any tree bisected between patch 1 and patch 2, and any backport
that takes the selftest without the kernel hunk -- bpf_map_create() succeeds,
so map_fd >= 0 and the block runs. It inserts an element, pins the map into
bpffs, and then reads the pin, which walks exactly the path quoted in the
fix's own splat:

  seq_read -> map_seq_show (kernel/bpf/inode.c)
           -> htab_map_seq_show_elem (kernel/bpf/hashtab.c)
           -> btf_type_seq_show
           -> btf_type_show (kernel/bpf/btf.c:8229)

with map->btf_key_type_id == 0, where btf_type_by_id() yields &btf_void and
kind_ops[BTF_KIND_UNKN] is NULL, so btf_type_ops(t)->show is a
NULL-pointer read.

That is an in-kernel oops in process context: the reading task (the
test_progs process, or one of its -j workers) is killed, so ASSERT_EQ()
below never executes and the harness reports a dead process rather than a
clean subtest failure. On any host booted with panic_on_oops (the norm for
BPF CI / syzkaller configs; tools/testing/selftests/bpf/config.ppc64el
already sets panic_on_warn=1 in CONFIG_CMDLINE) the machine panics and the
remainder of the test_progs run is lost.

ASSERT_EQ(map_fd, -EINVAL, ...) below already fails on an unfixed kernel,
because an unfixed kernel returns a valid fd instead of -EINVAL. On a fixed
kernel this block is unreachable. A selftest should detect the regression,
not trigger it; should the pin-and-read block be dropped (or at most gated
behind an explicit opt-in)?

> +
> +	ASSERT_EQ(map_fd, -EINVAL, "key-less create is rejected");

Does this assertion pass for the right reason?

-EINVAL is the generic BPF_MAP_CREATE rejection code, so this passes for
many reasons that have nothing to do with the key-less BTF check being
present.

Concretely for the "rhash" subtest: on any kernel that does not know
BPF_MAP_TYPE_RHASH (the map type is new in this tree; the selftest is built
from tools/include/uapi/linux/bpf.h, not from the running kernel's),
find_and_alloc_map() returns ERR_PTR(-EINVAL) because bpf_map_types[type] is
NULL or type is out of range. The subtest then passes without ever reaching
rhtab_map_check_btf().

Likewise, rhtab_map_alloc_check() returns -EINVAL for a missing
BPF_F_NO_PREALLOC / bad map_extra, and map_check_btf() returns -EINVAL if
the value type size ever stops matching value_size (4). Any of these makes
the subtest a green tick that pins nothing.

Is there a positive control? The test never asserts that the same
bpf_map_create() call succeeds when btf_key_type_id is set to a real type
id. Adding that (or checking for the create-time BTF log / distinguishing
the failure source) is what separates "the kernel rejected a key-less hash
map" from "the kernel rejected this map for some unrelated reason."

[ ... ]

The commit message states:

> Create a hash and an rhash map with btf_key_type_id == 0 and expect
> bpf_map_create() to fail with -EINVAL. On an unfixed kernel the map is
> created; the test then pins and reads it back to walk the bpffs dump path,
> which reproduces the btf_type_show() NULL-deref - so running this test on
> an unfixed kernel panics it.

Is "panics" accurate? What the traced path actually produces is an oops (a
NULL function-pointer read in btf_type_show() reached from seq_read() in
process context), which makes the reading task dead; the box only panics if
it was booted with panic_on_oops. More importantly, the message presents the
deliberate crash as the intended behaviour of the test rather than
justifying why the reproducer is kept in-tree when ASSERT_EQ(map_fd,
-EINVAL) alone already detects the regression. The commit also carries no
Fixes: tag, which is consistent with it being the selftest half of the
series, but a reviewer reading it in isolation gets no signal that the test
will take down a kernel that lacks the companion patch.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33161022932
--===============7473488389980377832==--
