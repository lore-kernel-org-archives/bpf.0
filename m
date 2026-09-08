Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEF572667;
	Tue,  8 Sep 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884340; cv=none; b=N9nBGAT2hnZn/RmV80U//0RtkL3UD9FbXPp7Ko9dwSLgaojkWmkrKfdQU9MWIcXrpG2rW07HoEN8AhsOXI2+hbLPTEABqDpza9qU0S5RHNnouuNbr2UIHRmVmUup4n7o3S5Ay8iwI3ooKoOQCi0pAD9qPqyTmlo1QK5Pqx0Lz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884340; c=relaxed/simple;
	bh=vw1QjrhmmDi5yqIFq3jWk+nMBfNqbW8KO4UuWR0wGyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sRS6Dx2+Vi3PN08UD85r+3QmI7zpefj/+djx0aXrEJaInw2TRqg7Wj7PhF38duCZZUOW2pVaclH4LFQlx6TAIAEA03tlVy1pKa4wl9JKDnbuAKp7SfWHhepOU1ECfsrHbAWRWFcHuLAgJxELIWbjE/sC2pQOdxSFgUFDhTqFkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIJVey6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIJVey6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F245F1F00A3D;
	Tue,  8 Sep 2026 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884339;
	bh=XIz1WNRfjVai+B//TeytB0d3qjhRgjrFm/mWruttF3A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hIJVey6eXNMSqenjKnHt/h3sPBnFmxxNwxxhNSLcnZqLT8BPOeaFF1hH0tR+Co41r
	 ael/HHqtugbbBaP3x76wS8jPP2c3Gd9Hrxs2w2259eSP6c3ptcA12BHppqw4qNwESw
	 1mKbemsI2cMKk4icBvIYGk2I5/TJB0NnIVWjmks371jAh/qHe5t7X83AHcmsWDWNvm
	 7oHnROaYqtHg5NUCH71/D8qPX0B0cJufiagv+qF4iN92DTstNu/8SfbSaSjrf2kb2d
	 FohgbJaqS25TpKPd3r0YgaIUmj59g9wU7LWskx7jcSw1XhD9kcFPO5BHHxszsbRQ+7
	 0cTLaVelCJyCA==
Content-Type: multipart/mixed; boundary="===============0769803629942985773=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf31b548282f8e22f34ed509308df909261914918d9d3a5b3d9baf31210dc254@mail.kernel.org>
In-Reply-To: <20260908135302.74963-6-tasos.papagiannnis@gmail.com>
References: <20260908135302.74963-6-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 16:18:57 +0000 (UTC)

--===============0769803629942985773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..b2325b193576
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <test_progs.h>
> +
> +#include "copy_from_user_bprm.skel.h"

[ ... ]

> +	if (!child) {
> +		char *const argv[] = { arg0, arg1, NULL };
> +		char *const envp[] = { env0, env1, NULL };
> +
> +		skel->bss->monitored_pid = getpid();
> +		execve("/bin/true", argv, envp);
> +		_exit(errno);
> +	}

This isn't a bug, but would execvp("true", ...) like test_lsm.c does be
more portable here than the hardcoded /bin/true? With the absolute path,
hosts where only /usr/bin/true exists would see execve() fail with ENOENT.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..b334a157419e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +#include "bpf_misc.h"

This isn't a bug, but is anything from bpf_misc.h actually needed here,
or could that include be dropped? The test-tag macros, __sink, the
__clobber_* and __imm_* helpers, SYS_PREFIX and CAP_* defines all appear
unreferenced; __ksym, __kconfig and __weak come from bpf/bpf_helpers.h,
u32/u64 and BPF_F_PAD_ZEROS from vmlinux.h, and BPF_PROG from
bpf/bpf_tracing.h.

[ ... ]

> +	data_len = bprm->exec - bprm->p;
> +	data_len_match = data_len == sizeof(expected_data);
> +
> +	invalid_flags_ret = bpf_copy_from_user_mm(data,
> +						  sizeof(data), (void *)bprm->p, mm, ~0ULL);
> +
> +	copy_ret = bpf_copy_from_user_mm(data, sizeof(data), (void *)bprm->p,
> +					 mm, 0);

This isn't a bug, but could the first call be wrapped the same way as
the copy_ret call just below, so both fit in 80 columns? The first
bpf_copy_from_user_mm() call breaks after the single data argument and
pushes the remaining four arguments onto a 92-column continuation line,
while the identical call three lines below is wrapped conventionally at
the last argument that fits.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245694915
--===============0769803629942985773==--
