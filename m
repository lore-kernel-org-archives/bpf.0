Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F42F6188;
	Sun, 27 Sep 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540861; cv=none; b=K9iCZb73Y8p9w9tc3sv1t3Bk8oJt6bg/KHkqhl6ba98aMtbVXTSrrgahcqiHyj30wcKlmR5G2QfpJGuSASIALYssFA8x9RNME5R66/lyKiJt0pDgk9Ptsr1CgsTv1ySq1MCjAyEQU7rUdlZQwEiworBRMUmw8DPzi4ty8EixIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540861; c=relaxed/simple;
	bh=2McT5H+vyFZ/nhUJx89Md0zLrPwTAZr0CjF30ajbgLs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=klbXu11U+cxoV47/gYLrMYAkl2Td9c9ZsfqXb+5cigyj22yGTR3cnLIbDzbcyY8gWlAEDAuAQ7QvCDAyCqW0V2ahAWrUngfdtOnJo1tVuB00YdamocYmMjKe4RmZfPV6wyb4HNNiHtvDbzLT3gqQ1eaVRLX9cPDvbFxjgv9J5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCZL/hi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCZL/hi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390111F000FF;
	Sun, 27 Sep 2026 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540860;
	bh=FOsSKi5ZORnZmT17qt2zCGmjW3VmNSXmt7Nj8wdMHHc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mCZL/hi6skrN+wOmAwqIPsSmx5Up8zmNZWZZx9UNFDVjWLWfh/3MhAMZYBmBKqDUA
	 DGA2cm2qWW1gxpq5fgQUotNZT9yrqI1pY9hIQlJ9eFSgxdfv/DBT/Epd07hLvrFOkT
	 KdSAUDV6f8SnyHkCDfwJ5tB5SGg78RNJUCj9hM9A+Hqh9AM+Po2RpmmKcS/vnEJPYS
	 IIFtZTag9hVO4SdrkpCZpNgjeRLxUNyQqJy6chjYuL1MN7o+Rt/Gg7tydeLHBkFA24
	 sOAQQaY2Kkrjg6PNkyDcYGjKFjhFTyFz9Xv3RnXLBxgbHLrwBNG143DOpCUwXNL/65
	 IBAisj6AAhCYg==
Content-Type: multipart/mixed; boundary="===============1118561618928693856=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed8edf2cea6ce83f46358c910ad9315650cec3e36dca87ea46de30c43ab06a75@mail.kernel.org>
In-Reply-To: <20260926170149.541352-3-skokovmaksimevg@gmail.com>
References: <20260926170149.541352-3-skokovmaksimevg@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Check that bpftool map dump fails for socket storage
From: bot+bpf-ci@kernel.org
To: skokovmaksimevg@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kuba@kernel.org,shuah@kernel.org,linux-kselftest@vger.kernel.org,hi@tychen.cc,skokovmaksimevg@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:39 +0000 (UTC)

--===============1118561618928693856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 000000000000..2c488f83006e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/socket.h>
> +#include <unistd.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +#include "bpftool_helpers.h"
> +
> +#define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
> +#define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
> +
> +/* A socket storage map with a single element, keyed on a socket we own. */
> +static int create_sk_storage_map(void)

Does the comment match what the function does? create_sk_storage_map()
builds a BTF with one int type and creates an empty BPF_MAP_TYPE_SK_STORAGE
map with BPF_F_NO_PREALLOC, returning its fd. The function never creates or
owns a socket.

The socket and the single element are added later by the caller,
test_bpftool_map_dump():

    sk_fd = socket(AF_INET, SOCK_STREAM, 0);
    ...
    bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST)

Someone reading only create_sk_storage_map() would think it returns a
populated map. Should the comment say the function creates an empty socket
storage map, or move to the caller where the element is added?

> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
> +		    .map_flags = BPF_F_NO_PREALLOC);
> +	struct btf *btf;
> +	int int_id, fd = -1;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
> +		return -1;
> +
> +	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_GT(int_id, 0, "btf__add_int"))
> +		goto out;
> +	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
> +		goto out;
> +
> +	opts.btf_fd = btf__fd(btf);
> +	opts.btf_key_type_id = int_id;
> +	opts.btf_value_type_id = int_id;
> +	fd = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage", sizeof(int),
> +			    sizeof(int), 0, &opts);
> +	ASSERT_OK_FD(fd, "bpf_map_create");
> +out:
> +	btf__free(btf);
> +	return fd;
> +}
> +
> +void test_bpftool_map_dump(void)
> +{
> +	int map_fd, sk_fd = -1, value = 42, ret;
> +	char output[1024] = {};
> +
> +	map_fd = create_sk_storage_map();
> +	if (map_fd < 0)
> +		return;
> +
> +	sk_fd = socket(AF_INET, SOCK_STREAM, 0);
> +	if (!ASSERT_OK_FD(sk_fd, "socket"))
> +		goto out;
> +	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST),
> +		       "add socket storage"))
> +		goto out;
> +	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin map"))
> +		goto out;

[ ... ]

> +	memset(output, 0, sizeof(output));
> +	ret = get_bpftool_command_output("map dump pinned " PIN_PATH,
> +					 output, sizeof(output));
> +	ASSERT_NEQ(ret, 0, "plain dump fails");
> +	ASSERT_NULL(strchr(output, '['), "plain dump prints no elements");
> +	ASSERT_NULL(strstr(output, "Found"), "plain dump prints no count");

Can the "Found" assertion actually test the intended behavior? The kernel
won't create a local storage map without BTF. bpf_local_storage_map_alloc_check()
in kernel/bpf/bpf_local_storage.c returns -EINVAL when
!attr->btf_key_type_id || !attr->btf_value_type_id (enforcing BTF for
userspace sk dumping).

So in plain mode, maps_have_btf() in bpftool's do_dump() always returns 1
for this map, and get_btf_writer() gives map_dump() a non-NULL wtr.

In tools/bpf/bpftool/map.c:

    if (wtr) {
        jsonw_start_array(wtr);
    }
    ...
    err = map_dump(map, wtr, data_out, &d);
    ...
    if (wtr) {
        jsonw_end_array(wtr);
    } else if (!err) {
        printf("Found %u element%s\n", d.elem, d.elem != 1 ? "s" : "");
    }

The "Found %u element%s" message is only printed when wtr is NULL.
Before commit aba2896e679d that was the `} else {` branch, and after it
is `} else if (!err) {`. With the BTF writer active, neither version
ever prints it.

For this socket storage map, unfixed bpftool printed "[]" on stdout;
the '[' check catches that, but the "Found" check never can.

The commit message says the test checks "no elements and no count on stdout
in plain mode", and the bpftool patch adds the `else if (!err)` change so
the count is only printed after a complete walk. Neither is actually tested.

Covering the count path needs a map that has no BTF and can't be iterated,
for example a queue, stack or bloom filter map created without BTF.
Unfixed bpftool printed "Found 0 elements" for those. Otherwise the
assertion and that part of the changelog could be dropped.

> +
> +	memset(output, 0, sizeof(output));
> +	get_bpftool_command_output("map dump pinned " PIN_PATH " 2>&1 >/dev/null",
> +				   output, sizeof(output));
> +	ASSERT_HAS_SUBSTR(output, "can't dump sk_storage map",
> +			  "plain dump explains why on stderr");
> +
> +out:
> +	unlink(PIN_PATH);
> +	if (sk_fd >= 0)
> +		close(sk_fd);
> +	close(map_fd);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346398129
--===============1118561618928693856==--
