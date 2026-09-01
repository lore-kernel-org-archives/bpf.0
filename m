Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C93AC0CB;
	Tue,  1 Sep 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231048; cv=none; b=u9KI+ACL4DwP8YkYtNJCA9adbWVBcbnLZYdOHeZDTTje565Hra+lFMSQ+P9L85FMJg7rS+arM6PZJYBqnQCW8q6N2QLLK1x1c1rBgKLsuyRR/HQJopNxE4WM2zGspPeJY+uiDZEIIxW4mumO1nP+K9iynTHstbAv7wk5VGxcBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231048; c=relaxed/simple;
	bh=0oTlVcg/slOeyxwlhmb2CPyyqZc8h0C/OfXA/4iz7A8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aN/qIqfxfoPXm0DsBBg2b38Uv6k/4WIZ2Xt4ly08BZUTuDMxetzO41gcb7sVpDhIBJbS7iHZ3OgMhmZzEJ0zvb+xKGIbmutBv4CYPteSL4q07Fih+wbnI9OpmknlAcxen22q4EkJCN595L8TgGXg4KMrgVwGYdFWzy7A0lyGGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3sqZ5wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3sqZ5wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BE31F000E9;
	Tue,  1 Sep 2026 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788231045;
	bh=B31WDxXmWvC78nyAEw77XkUldK8/MmelFrCkkwtq8rI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g3sqZ5wm8g/fvbN6uAhsgnXNhMVdmrI+blpZJVmntANy60KKpozLY8YraHztL9/0M
	 zAl9IZtBzpzGTtrfBVWP64hVmKFloLr/luHeh6AhtDuWIoqVwlFFHffY6Yz7jCrhyJ
	 30OCooU6CLwiatLoTiO6gOBd2BRzm+dzt6yw+oK3DOXWjYfZTPXnyfWqawNhVzlt5X
	 eRQv0HMUauyAs0St/ZLjwXZKDnh3BN5tEuy2YJ04MLPtsMctb7q4tu50z0iCGeo27v
	 rhQMtujth3MM3rGQ6nPsTehXceFGxitmOeWh8eeYwqdmiwqcCXyCkjp/8oTTy70EAG
	 1WLC6M1ht1t0A==
Content-Type: multipart/mixed; boundary="===============8556434494740287810=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <114d1ed8b1f7d95d56efdf5fa8ee09eee9ef8ced7d27c123b00479f163dbef00@mail.kernel.org>
In-Reply-To: <20260901014713.3502900-4-sanghyun.park.cnu@gmail.com>
References: <20260901014713.3502900-4-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover attach type checks in link update
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org
Cc: sanghyun.park.cnu@gmail.com,leon.hwang@linux.dev,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,sdf@fomichev.me,pulehui@huawei.com,suchitkarunakaran@gmail.com,xukuohai@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 02:50:43 +0000 (UTC)

--===============8556434494740287810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> index 15093a69510eb..3b43c34917ccc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <test_progs.h>
> +#include "cap_helpers.h"
>  #include "cgroup_helpers.h"
>  #include "testing_helpers.h"
>  #include "test_cgroup_link.skel.h"

[ ... ]

> +static void test_cgroup_link_update(void)
> +{
> +	const __u64 caps = (1ULL << CAP_NET_ADMIN) | (1ULL << CAP_SYS_ADMIN);
> +	struct bpf_link *link = NULL;
> +	__u64 saved_caps = 0;
> +	int cg_fd = -1, err;
> +
> +	skel = test_cgroup_link__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		return;

This isn't a bug, but since this subtest never goes through
ping_and_check(), would a local `struct test_cgroup_link *skel` work
here instead of the file-scope global (which would also make the
trailing `skel = NULL;` unnecessary)?

> +
> +	err = setup_cgroup_environment();
> +	if (!ASSERT_OK(err, "cg_init"))
> +		goto cleanup;
> +
> +	cg_fd = create_and_get_cgroup("/cgroup_link_update");
> +	if (!ASSERT_GE(cg_fd, 0, "cg_create"))
> +		goto cleanup;
> +
> +	err = join_cgroup("/cgroup_link_update");
> +	if (!ASSERT_OK(err, "cg_join"))
> +		goto cleanup;

A subsystem pattern flags this as potentially concerning: the three-call
sequence setup_cgroup_environment() + create_and_get_cgroup(path) +
join_cgroup(path) is exactly what test__join_cgroup(path) provides in
test_progs.c. Using the shared helper would collapse these three blocks
(and their three separate ASSERT/goto arms) into one call plus one
ASSERT_GE(cg_fd, 0, ...). The harness also sets env.test->
need_cgroup_cleanup so teardown happens even if the subtest exits early.

The hand-rolled sequence is functionally equivalent - the three calls
are in the same order, all return values are checked, and the single
cleanup label reaches cleanup_cgroup_environment() on every failure
path. There's also a consistency argument for writing it out:
test_cgroup_link_attach() in this file hand-rolls the same sequence
because it needs four cgroups and cannot use a single-cgroup helper.
Does the test__join_cgroup() approach make sense for this subtest, or is
the hand-rolled version preferred for consistency with the sibling test?

> +
> +	link = bpf_program__attach_cgroup(skel->progs.sendmsg4, cg_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_sendmsg4"))
> +		goto cleanup;
> +
> +	err = bpf_link__update_program(link, skel->progs.sendmsg6);
> +	ASSERT_EQ(err, -EINVAL, "reject_sendmsg6_update");

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> index 3bfa479104be8..30727945cecc3 100644
> --- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> @@ -213,6 +213,12 @@ int BPF_PROG(socket_first, int family, int type, int protocol, int kern)
>  	return 0;
>  }
>
> +SEC("lsm/socket_create")
> +int BPF_PROG(socket_create_lsm, int family, int type, int protocol, int kern)
> +{
> +	return 0;
> +}
> +
>  SEC("lsm_cgroup/socket_create")
>  int BPF_PROG(socket_second, int family, int type, int protocol, int kern)
>  {

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_link.c b/tools/testing/selftests/bpf/progs/test_cgroup_link.c
> index 4faba88e45a5a..a987744d129cd 100644
> --- a/tools/testing/selftests/bpf/progs/test_cgroup_link.c
> +++ b/tools/testing/selftests/bpf/progs/test_cgroup_link.c
> @@ -20,5 +20,17 @@ int egress_alt(struct __sk_buff *skb)
>  	return 1;
>  }
>
> -char _license[] SEC("license") = "GPL";
> +SEC("cgroup/sendmsg4")
> +int sendmsg4(struct bpf_sock_addr *ctx)
> +{
> +	return 1;
> +}
>
> +SEC("cgroup/sendmsg6")
> +int sendmsg6(struct bpf_sock_addr *ctx)
> +{
> +	ctx->msg_src_ip6[2] = 0;
> +	return 1;
> +}

This isn't a bug, but is the ctx->msg_src_ip6[2] store here load-bearing
for the -EINVAL assertion, or is it standing in for the out-of-bounds
write the companion patch prevents? A short comment (or making sendmsg6
as minimal as sendmsg4) would make the asymmetry between the two new
programs clearer.

> +
> +char _license[] SEC("license") = "GPL";

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33461362664
--===============8556434494740287810==--
