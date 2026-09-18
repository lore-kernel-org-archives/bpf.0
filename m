Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9ED4AB3C0;
	Fri, 18 Sep 2026 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733922; cv=none; b=LfRGm994YrFB5O3boDkzUMo/PNwr72Mwp4JYQl/du0RxYpvSox79CG+QkZARkzG74JwwLJt8U0oOSbdb1f6T6DhFf6EDsq8omvyl69qvgzG44+CrZk5N/EuztsYesrtIaVlyXb54g+IqxiNBG465FhRKQC+8LNEsS9Y1Eo+080I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733922; c=relaxed/simple;
	bh=W30kLLrcOgwsVvtEnHgzJIoxD686qATyr73s4hc2OCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiQU6JD5zNsyKfkRtw8u+tmndAYVVJ2DLJBJokKUvS3yVd8UT3rOntfG45soyVFJeo6LYsGBBv9/EF4rJvqnsucMvjmRplZ9tzMWa1ZuVzZL4WJyD84nzjeCNtN1a0UQQjvIJkEDv0HlFvcDBG9by0M+7bCwtCXZkvg2Nugqdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mws1UsRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mws1UsRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D11F000FF;
	Fri, 18 Sep 2026 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733920;
	bh=1TYvlIfCtLdqHpeJoQsXsU42SLAAUvbsKO95maH9PDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mws1UsRBTP1Dx9MUaCMx7CciHF+x8bsh6VQal9UxLrLB+bJ/C01mAIno+zKKrOcbM
	 6r92UejHJgIYuRD5xxtmdyiccvuFmzgYtA6y0SgVbN+kOFAAaInYK7PIPhtGNzuFeS
	 wo5P0ir1dFYlpLycvD00qzkUvEThUHPkwmhlmAPrInngwcSxDBsKvGWovoNm4UWwe4
	 wknqsQCmG7EXWpjRWce03zvAGjVz9hjsEpLBhB7Ywm7zFatE5BbkJ0kmIUCR9TGgoY
	 PgW6dmrkbo1HL70lEA8I0B+vWw/22hvDVNBaGJryCOfX147XNrUMl7EvIrF8LCDYwT
	 I9ExzcVWzp1WQ==
Message-ID: <5bded51f-d0f9-41ae-92ad-e1ce008a101e@kernel.org>
Date: Fri, 18 Sep 2026 13:18:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover bpftool ring buffer
 event_pipe
To: Tianyi Chen <diannaaav@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260911025114.190899-1-diannaaav@gmail.com>
 <20260911025114.190899-3-diannaaav@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260911025114.190899-3-diannaaav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-11 10:51 UTC+0800 ~ Tianyi Chen <diannaaav@gmail.com>
> From: Tianyi Chen <hi@tychen.cc>
> 
> Produce known ring buffer records and check complete plain, JSON and
> pretty JSON output. Exercise ID and pinned map selection, SIGINT and
> SIGTERM shutdown, empty streams and invalid map types or selectors.
> 
> Also produce a perf event sample and check its existing header and raw
> payload output. Use a payload whose size plus the raw sample length
> field is aligned to eight bytes so the expected bytes exclude implicit
> perf padding.
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  .../bpf/prog_tests/bpftool_ringbuf.c          | 425 ++++++++++++++++++
>  .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
>  2 files changed, 472 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
> 
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


As bpf-ci's review says, please look into reusing the existing helpers
if possible.


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
> +	struct bpf_map_info info = {};
> +	__u32 len = sizeof(info);
> +	const char *path = bpftool_path();
> +	char *argv[12], id[16];
> +	int out[2], ready[2], n = 0, err, err_fd;
> +	struct pollfd pfd;
> +
> +	if (!ASSERT_OK_PTR(path, "bpftool path (set BPFTOOL to override)") ||
> +	    !ASSERT_OK(bpf_map_get_info_by_fd(map_fd, &info, &len), "map info"))
> +		return false;
> +	snprintf(id, sizeof(id), "%u", info.id);
> +	argv[n++] = (char *)path;
> +	if (format)
> +		argv[n++] = (char *)format;
> +	argv[n++] = "map";
> +	argv[n++] = "event_pipe";
> +	argv[n++] = pin_path ? "pinned" : "id";
> +	argv[n++] = pin_path ? (char *)pin_path : id;
> +	if (option) {
> +		argv[n++] = (char *)option;
> +		argv[n++] = "0";
> +		if (pair) {
> +			argv[n++] = "index";
> +			argv[n++] = "0";
> +		}
> +	}
> +	argv[n] = NULL;
> +	if (!ASSERT_OK(pipe2(out, O_CLOEXEC), "output pipe"))
> +		return false;
> +	if (!ASSERT_OK(pipe2(ready, O_CLOEXEC), "exec pipe")) {
> +		close(out[0]);
> +		close(out[1]);
> +		return false;
> +	}
> +	child->pid = fork();
> +	if (!child->pid) {
> +		close(out[0]);
> +		close(ready[0]);
> +		err_fd = capture_errors ? out[1] : open("/dev/null", O_WRONLY);
> +		if (dup2(out[1], STDOUT_FILENO) < 0 ||
> +		    dup2(err_fd, STDERR_FILENO) < 0)
> +			goto exec_fail;
> +		if (!capture_errors)
> +			close(err_fd);
> +		close(out[1]);
> +		execv(path, argv);
> +exec_fail:
> +		err = errno;
> +		write(ready[1], &err, sizeof(err));


I think that ignoring the return value from write() can produce a
compiler warning (-Wunused-result).

[...]

Looks OK otherwise, thank you
