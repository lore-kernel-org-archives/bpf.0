Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EE44062B;
	Thu, 20 Aug 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265283; cv=none; b=D4yB2lxhkJ3MWUH0X5KQJ94lh7tL4NORE6j7BkqX8ViEfKsqe59f7Jqkrg2LaEIs9XJyKri2cuio1yEWY7yyENWXAj9If7PSVSGx27eqi0JguSlegfzG57SG38AaSoVydn65oUboFIMyWjOpUOaClfTFnTy98rXiLKY8yBNCR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265283; c=relaxed/simple;
	bh=g8fUCZCD593bu7tF5d7m7ZKelyYZU0v+x72Q6l8bTlc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JyDogceTtWAUE1LpVcgv6Ukt33iujkxEatYsiEy2UnuHHPFTmbvEBugxtOIIduGAQrVzwJyWGkFGBCMzmy0+m2q4jPgsjhOpncq455uj4on55VFfSoaiSQuw65Y3BTwuyNVetdh/mHkGR8YW7Ecbs6wg8+kspQ8T1a0xR7hp7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iktcuM35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iktcuM35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DB71F000E9;
	Thu, 20 Aug 2026 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787265281;
	bh=Z65Uj+abR9rXUy9DVQRv9JEAa70b7rXlElcSc7Gp3Z0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iktcuM35jCcA6Pp/78fNMQdAdB3BNN6xPofOq0XxENcqXopvposzpjJ+wRt2JjIZP
	 cTO15bFNYZJ5UmNqTD+Bmgk0O8u6EsoJuovadtEGTFglGT3+u5BpDn+IwK4+iY+9fv
	 GWMHlLaG773gi8x+rMCek/eXzOpNyXONQhrji3cIvyEjCMS0xmhEJY/bdQIiPhy1me
	 Z5BeMtbDcUpsoWumc6K/vsEvFFbH6RucpBRqCKI+daXBisrSsb8IFj81r/yZtY25Hj
	 155w9wJ2JWkNFhKFbLTcGTeClBcduHUCvxJ9CiqCCU7vIibwuLKCq0193/7jaVdzkL
	 Z32VVux6Q5j0g==
Content-Type: multipart/mixed; boundary="===============9105663885118799983=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <582672b5848bc6547246eae92b66d98e8dfd53569b964d02b76fa98ba563bdf2@mail.kernel.org>
In-Reply-To: <20260820214332.89030-1-sean@mess.org>
References: <20260820214332.89030-1-sean@mess.org>
Subject: Re: [PATCH v3] selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage
From: bot+bpf-ci@kernel.org
To: sean@mess.org,linux-kernel@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: sean@mess.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 22:34:41 +0000 (UTC)

--===============9105663885118799983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 986a6389186b..b815bf0d8877 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -17,7 +17,6 @@ test_verifier_log
>  feature
>  urandom_read
>  test_sockmap
> -test_lirc_mode2_user
>  flow_dissector_load
>  test_tcpnotify_user
>  test_libbpf

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
> new file mode 100644
> index 000000000000..7b7352dbcd82
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
> @@ -0,0 +1,334 @@

[ ... ]

> +// This test works by sending IR over rc-loopback, so the IR is processed by
> +// BPF and then decoded into scancodes. The lirc chardev must be the one
> +// associated with rc-loopback, see the output of ir-keytable(1).

This isn't a bug, but now that find_loopback_devices() discovers the
nodes itself, should the ir-keytable(1) sentence be reworded (or
dropped) so the header does not describe a manual step that no longer
exists?

> +//
> +// The following CONFIG options must be enabled for the test to succeed:
> +// CONFIG_RC_CORE=y
> +// CONFIG_BPF_LIRC_MODE2=y
> +// CONFIG_RC_LOOPBACK=y
> +// CONFIG_LIRC=y
> +
> +#include <linux/input.h>
> +#include <linux/lirc.h>

This isn't a bug, but is <linux/lirc.h> still needed in
prog_tests/lirc_mode2.c, or can it be dropped now that the raw-IR
values are written as plain ints?

> +#include <glob.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <test_progs.h>
> +#include "lirc_mode2.skel.h"
> +
> +/*
> + * Read the DEVNAME= line out of the first uevent file that matches
> + * pattern, and turn it into a /dev/<name> path.
> + */
> +static bool find_devname(const char *pattern, char *path, size_t path_sz)
> +{
> +	glob_t gl = {};
> +	bool found = false;
> +	FILE *f;
> +
> +	if (glob(pattern, 0, NULL, &gl) || gl.gl_pathc == 0)
> +		goto out;
> +
> +	f = fopen(gl.gl_pathv[0], "r");
> +	if (!f)
> +		goto out;
> +
> +	char line[256];

This isn't a bug, but could `char line[256]` move up with the other
locals at the top of find_devname(), to match the rest of the function?

> +
> +	while (fgets(line, sizeof(line), f)) {
> +		char *val;
> +
> +		if (strncmp(line, "DEVNAME=", 8))
> +			continue;
> +
> +		val = line + 8;
> +		val[strcspn(val, "\n")] = '\0';
> +		snprintf(path, path_sz, "/dev/%s", val);
> +		found = true;
> +		break;
> +	}
> +
> +	fclose(f);
> +out:
> +	globfree(&gl);
> +	return found;
> +}

[ ... ]

> commit 13acc020a68a79fa42ce134695e01654e17c1edf
> Author: Sean Young <sean@mess.org>
>
>     selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage
>
>     While porting, extend coverage of the BPF_LIRC_MODE2 attach/detach/
>     query API:
>
>      - bpf_prog_attach() with invalid flags is rejected with -EINVAL
>        and does not attach the program
>      - bpf_prog_query() with invalid flags is rejected with -EINVAL
>        without disturbing existing attachments
>      - bpf_prog_query() reports the correct program id, not just count,
>        at each step, via bpf_prog_get_info_by_fd()
>      - a lirc chardev can hold more than one attached program: load a
>        second, independent instance, attach it alongside the first,
>        confirm both are reported by bpf_prog_query(), then detach it
>        without disturbing the first program's attachment
>      - detaching an already-detached program consistently fails with
>        -ENOENT, for both the first and second program

This isn't a bug, but could the changelog open with why the test is
being moved under test_progs, before listing the extra coverage that
was added while porting?

The changelog body starts at the secondary half of the change and
enumerates the new assertions, but never states the primary change or
its motivation. The conversion itself - deleting test_lirc_mode2.sh
plus test_lirc_mode2_user.c and the standalone TEST_PROGS/
TEST_GEN_PROGS_EXTENDED wiring, and re-adding the test as a prog_tests
entry with a skeleton - is what most of the diff does, and a reader
learns only what was added on top of it, not why running under
test_progs is preferable (single runner, DENYLIST/CI integration, no
separate binary to install).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32422213902
--===============9105663885118799983==--
