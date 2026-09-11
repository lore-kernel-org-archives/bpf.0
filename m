Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F443CBE69;
	Fri, 11 Sep 2026 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099033; cv=none; b=Bfd78wE1FJasnf/Z8BT9hcAUut/6PtJYXveKXkI2CdAblG5gFv34ltFhjY4GxIpbwX/0foSmTTjhgBZhJ9Lk6BDOcf/w5IhfNg/yjMilHWuhq2A3L5YMFYO3TiDTozcJtbz/0ryu/cW+JbDa/59l+pps5u1fAQG4b+IG1rxiumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099033; c=relaxed/simple;
	bh=21nOVExBn5cWQjaT+2dxEYyGtI3Rl3Zv+cu5ICkycEQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=srPps6iN1U1LnrXliA0AzJ1/hPlli2zQNcaJF1GOY4ifE200TEQnsz60kbkp/ySWbqbWfD4iGvYdBE/+eZJJMGuNNiJ180Y3y38WUk40BAz8rciph7+eCML3vdIu0PNVmadSXZUzqrPtYn0RY5S2MK6kCfB9CLZ1bwKntb48BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9vg+9SH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9vg+9SH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE31F000FF;
	Fri, 11 Sep 2026 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789099031;
	bh=IE1DpzKI7s+8OIo7SRwuyvn8ywBdmopLSwsnhGZuYCw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q9vg+9SHOpPcXwYpjqFhqkp7WNXYm+sbpaGAmte+sST+kP4+gPKsBK7SwKGFSB4pj
	 CWSO1/3oObNcmpk5o1Jt8SLv+30UuvbMqyM30UbBVOn8cmKsJoCjO3QiduDisbwoXd
	 JVmcA+d/bRnlHSOaxwT+x5HCyQgZdaS0fa/ZQl5qV1xtU/fKQpBXr9kYgpBkzCXew/
	 zxe3ZdRcgNBTg/O6xrjdP7rWQ80xCg8Fr8GXlSSsGJ3kEgIFeNdj8GA+9APdgo9quM
	 6R+HAf+00s8kHPyfsVE2O1vkRl97Yqxx2LtZRaFWTgT2uQrBNDpDCYQqD38NVC/43e
	 t29Srr9hSSTog==
Content-Type: multipart/mixed; boundary="===============3672371007177438593=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07997529fb699289db8722231132a345e5e86b6727ccbc8c0ddb1bfbbf066c9b@mail.kernel.org>
In-Reply-To: <20260911025114.190899-3-diannaaav@gmail.com>
References: <20260911025114.190899-3-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover bpftool ring buffer event_pipe
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 03:57:10 +0000 (UTC)

--===============3672371007177438593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
> new file mode 100644
> index 000000000000..1a4ae88c05a0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <ctype.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <test_progs.h>
> +#include "bpftool_ringbuf.skel.h"
> +
> +#define WAIT_STEPS 500
> +#define WAIT_US 10000
> +
> +struct consumer {
> +	pid_t pid;
> +	int fd;
> +};
> +
> +static const char *bpftool_path(void)
> +{
> +	const char *path = getenv("BPFTOOL");
> +
> +	if (path)
> +		return access(path, X_OK) ? NULL : path;
> +	if (!access("./tools/sbin/bpftool", X_OK))
> +		return "./tools/sbin/bpftool";
> +	if (!access("../tools/sbin/bpftool", X_OK))
> +		return "../tools/sbin/bpftool";
> +	return NULL;
> +}

Does bpftool_path() need to duplicate the path discovery logic that
already exists in bpftool_helpers.c?

tools/testing/selftests/bpf/bpftool_helpers.c:detect_bpftool_path()
performs the identical three-step search:

bpftool_helpers.c:detect_bpftool_path() {
    ...
    #define BPFTOOL_DEFAULT_PATH "tools/sbin/bpftool"
    env_path = getenv("BPFTOOL");
    if (env_path && access(env_path, X_OK) == 0) ...
    snprintf(tmp, sizeof(tmp), "./%s", BPFTOOL_DEFAULT_PATH);
    if (access(tmp, X_OK) == 0) ...
    snprintf(tmp, sizeof(tmp), "../s", BPFTOOL_DEFAULT_PATH);
    if (access(tmp, X_OK) == 0) ...
}

The existing implementation is already linked into test_progs via
TRUNNER_EXTRA_SOURCES, and it includes diagnostics that this copy drops:
"bpftool '%s' doesn't exist or is not executable" and "Failed to detect
bpftool path, use BPFTOOL env var to override", plus comments explaining
why the '../' fallback exists (for running non-default test_progs
flavors like no_alu32 or cpuv4).

The public API (run_bpftool_command/get_bpftool_command_output) uses
popen(), which doesn't work here since this test needs fork/exec with a
controllable child pid for kill/waitpid and a readable fd for
poll/read. Could the existing detect_bpftool_path() be exported in
bpftool_helpers.h to provide just the path lookup without the popen
machinery?

> +
> +static void consumer_cleanup(struct consumer *child)
> +{
> +	if (child->pid > 0) {
> +		kill(child->pid, SIGKILL);
> +		while (waitpid(child->pid, NULL, 0) < 0 && errno == EINTR)
> +			;
> +		child->pid = -1;
> +	}
> +	if (child->fd >= 0) {
> +		close(child->fd);
> +		child->fd = -1;
> +	}
> +}
> +
> +static bool consumer_start(struct consumer *child, int map_fd, const char *format,
> +			   const char *pin_path, const char *option,
> +			   bool pair, bool capture_errors)
> +{

This isn't a bug, but would a small options struct make the call sites
more readable than the trailing positional booleans?

Most call sites pass NULL and false for the last few parameters:

consumer_start(&child, fd, format, pinned ? pin_path : NULL,
               NULL, false, false)

consumer_start(&child, bpf_map__fd(skel->maps.perfbuf), NULL,
               NULL, NULL, false, false)

At these call sites nothing indicates which NULL is option and which
false is pair versus capture_errors. Only the reject path ever passes
non-NULL option or true pair/capture_errors, so those flags could be
isolated (perhaps a wrapper for the reject case) so the common call
sites don't have to carry them.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
> new file mode 100644
> index 000000000000..bbbc93c30a83
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34557186664
--===============3672371007177438593==--
