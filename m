Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D417BCA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209122; cv=none; b=D8Jps7lyuahCkLUqvUiMdkKoChuSzpcq4FtfUUA8S0lL2lYPJppIhxLJy5vA+rbMPR0AvZo4JeTg3jwx+NaYstM3YrMsz+Ptubmw0QZ4NzQ41Rj977Yn/HQDrx65RawOYE0zX4GwfuG/KmOU1O/SqDGbhNUIypXeoGQbpACZ8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209122; c=relaxed/simple;
	bh=yQJblCtXtd/1vN8mGD/8QdYfZBemWv4zHX2KdWn3Txg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cdNxCV3KpeCOhz3IWk5QGWYutqua0HKIqV2fsBHS6ys7XtVTXmVX6fzFf1XBbU1M0uu8+l8cK3Y9izaXiSrRlqCM0RzP06aYlrdsaiHHV5Lv+NtL9etY/CydF7w2wvYuxTQe/W9qDGcgVD7jaguzFQfVHxNyUKOo7TXpZnfYh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ3v9Zem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ3v9Zem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB171F000FF;
	Thu, 24 Sep 2026 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209121;
	bh=VSS+4T9k6o2BvhXJ5s57ozFKFmNFk5IonUFdZiZdlHU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iQ3v9Zem31EVZlU+IvjZhKZ3ON6oup0ycMLyjN0GIAwIBi+EUQY44pnAgRbWoxeuV
	 wE+SJh1w1Hmejp8NBVWrke5h6amIInCO47fwx8tCdo19GOfpamtnaSwuLjC9l4dIS7
	 2wi4YEH19+yH9mGCgYYefo3nc4muZ6phz+3E3BMDMpa96kIE+QjhTkeknqQpvpktIB
	 TAK5x0OrGzzSe7pfi4mLhQq9JZ8akZGnZsPeihlABd0Fs6fPEe7yUDPF4NwC2HQZhG
	 dAzLkVwVXYgQpo9AaoWE6pzo1lNez7PcoZYuPK1uLHVosMGDf4eClibXL1jLD2UhHr
	 6D7XzBiggH6WA==
Content-Type: multipart/mixed; boundary="===============6625234536607686615=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2878a03f0ff558265aef53bb2378205f2944df2b07e11441748be729843e4afd@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-7-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-7-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 6/8] selftests/bpf: Cover BPF program load strategy transitions
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:18:39 +0000 (UTC)

--===============6625234536607686615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..67813a8c76462
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_load_type.skel.h"
> +
> +void test_load_type(void)
> +{
> +	struct bpf_link *link = NULL;
> +	struct test_load_type *skel;
> +	int err;
> +
> +	skel = test_load_type__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;

[ ... ]

> +	/*
> +	 * leaving MANUAL for AUTO must restore autoattach (regression test for
> +	 * the autoattach residue bug: set_load_strategy(MANUAL) clears autoattach, and
> +	 * nothing used to restore it on exit)
> +	 */

This isn't a bug, but would it be clearer to say only what is being
checked (e.g. "leaving MANUAL restores the previous autoattach setting")
and drop the reference to a residue bug that isn't in the tree, plus the
notes on how libbpf's switch is structured internally? The comment
describes a bug that only existed in an unmerged revision, so a future
reader cannot find it in the git history. The comments at other points in
the test (describing "AUTO and DISABLED share one guard keyed off the
source strategy being MANUAL" and calling set_autoload "a thin forwarder
to set_load_strategy()") also document how libbpf's implementation is
laid out rather than what behavior is being checked, so they go stale if
libbpf is restructured.

> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
> +	if (!ASSERT_OK(err, "set_load_strategy_auto"))
> +		goto cleanup;

[ ... ]

> +	err = test_load_type__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;

[ ... ]

> +	err = test_load_type__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	ASSERT_FALSE(skel->bss->prog1_called, "prog1_called");
> +	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
> +	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
> +
> +	err = bpf_program__load(skel->progs.prog3);
> +	if (!ASSERT_OK(err, "load_manually"))
> +		goto cleanup;
> +
> +	/* attach prog3 */
> +	link = bpf_program__attach(skel->progs.prog3);
> +	if (!ASSERT_OK_PTR(link, "attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_again"))
> +		goto cleanup;

This isn't a bug, but the manual load/attach tail here and the BPF object
(progs/test_load_type.c with prog1..prog3, all SEC("raw_tp/sys_enter")
setting prog{1,2,3}_called) are close to what the next commit in this
series adds as progs/test_dynamicload.c and the
dynamicload_verify_main_cycle() function. The only part of load_type.c
that dynamicload.c does not also cover is the pre-load strategy
transition and autoattach-restore sequence. Could the transition checks
become a subtest of dynamicload (reusing test_dynamicload.skel.h), so the
series doesn't carry two copies of the same load/attach cycle and BPF
object?

> +	/* detach prog3 as test_load_type__destroy doesn't detach manually loaded programs */

This isn't a bug, but could this comment say what is actually going on?
The stated reason doesn't match libbpf: bpf_object__detach_skeleton()
destroys *prog_skel->link for every program whatever its load strategy.
The real reason test_load_type__destroy() won't detach prog3 is that the
link lives in a local variable instead of skel->links.prog3, and the
cleanup label already destroys that local. The comment's current wording
might lead readers to think libbpf leaks attachments for MANUAL programs
on destroy. Alternatively, storing the link in skel->links.prog3 would
let test_load_type__destroy() handle it automatically.

> +	err = bpf_link__destroy(link);
> +	ASSERT_OK(err, "link_destroy");
> +	link = NULL;
> +
> +cleanup:
> +	if (link)
> +		bpf_link__destroy(link);
> +	test_load_type__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/testing/selftests/bpf/progs/test_load_type.c
> new file mode 100644
> index 0000000000000..3d9b81691d7ad
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_load_type.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +bool prog1_called = false;
> +bool prog2_called = false;
> +bool prog3_called = false;
> +
> +SEC("raw_tp/sys_enter")
> +int prog1(const void *ctx)
> +{
> +	prog1_called = true;
> +	return 0;
> +}
> +
> +SEC("raw_tp/sys_enter")
> +int prog2(const void *ctx)
> +{
> +	prog2_called = true;
> +	return 0;
> +}
> +
> +SEC("raw_tp/sys_enter")
> +int prog3(const void *ctx)
> +{
> +	prog3_called = true;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============6625234536607686615==--
