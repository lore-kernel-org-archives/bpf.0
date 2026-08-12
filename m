Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6E38F929
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560168; cv=none; b=rl5O++wvzTsAiA9TotSqcJy0tsrDJKd0VscsJFGlWIH6dBJWd0x8dssg64sQmtbiORqwVMXLn8+FE6M+d8EsW1fB/5q6Zy1yMhb+N//Hqpn0IBcONELFX+SGUkMh+NSGDUV6OInme5j1fUKoeLhAZAAa0m2zDI1lCyspmBDdqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560168; c=relaxed/simple;
	bh=8ui2i8X9X+ttiVH9C2u7PSYuxw+exyfP5CSHL6zWTqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihl1hwpB5FAj+JMJif4PmhYUGJy/ICB/SJrGHg6qDYkavq67lEjqvdBLXU7/pneNqjGPdr85qmbvqCXEzRuKG6hjcVSP4BtQFYvnAHVfhgQbkoJDLuLMJC4McLvBp0Z/h9ZOXF5mlKDM1z54mdgManCMSfPjMPlTLBGeORilC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mashl4kY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mashl4kY"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8200ca16f26so19660627b3.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786560166; x=1787164966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NJq4BeRPMu0DvX0JybLuJRAOSyVWG0mjimxTrgQADmI=;
        b=Mashl4kYz2KKl1mfTCwPj0ljoFUPk+mDXjSeE5XzkrgVWnaR8VeGwRQ7tyHYRj5h66
         tVeuMf0ho/Js3Jr4mh8ytMGyem9l+8NQu3e57Kp5W7DKXvSgO73/T6KjiuUUN8W5w6wJ
         mcZOm6hnP7+0p9arJoDiDdz/ubmrQ/PgEUSHYNyothKyQz1AZw7k2wwC69nBTXTF+pj4
         O4LR5f+q6XlGCDJn4oDNihtGeSQ2VfMLdHvn20eSBbEgcjdi2K/eC4D4ErubCfA97XYi
         lsNHl0Q7yYbwj/0F523i6wmyVdwtu5Z4SDy+N4rubDT1RXb/2Li/uRqoiPfsrtWiGccj
         6gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560166; x=1787164966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJq4BeRPMu0DvX0JybLuJRAOSyVWG0mjimxTrgQADmI=;
        b=mjsbmycFBtviRQDJys4HGJyo81+fHWRvuQeuN4AEX/OhIaudLp5Id8h8Y66HfJTIZH
         Lbad5E8F0CKO7wjWeNwWZr+23IaDwccCWym1HZZR6+j+1K0C0w4/wBxa5pbHiZ+BcoZA
         H7mfSInopP10iV+d7s6T9vSSUtGLRPGCNeRrIznHTbfxCpm8VjuciVOBCnO8LZtBTL7Z
         P+e/MCmsu9ZYdthOGv96DlM6cl+nVppjTEUv2YCCyZf8/jd8Pt8Ya3B5Qa/22x/DuzSw
         xJrjl0tSJndI45vwBlHnw5k9LdcUiFjNvL2STcxCCLAyLqzGwwmBqMbKTf6N+XLbRWhp
         lnhw==
X-Gm-Message-State: AOJu0YwSbed2/NSjK8L7kA8kvbJfCMEFJ3jxpBs9ia5C4sqdIrrZzcNB
	/JUpK/GH2N0WMN/m8QtXpEkH/WggR+uWK6wRqORXlUZOs65VhFa6Cjaw
X-Gm-Gg: AR+sD11IVHso+GAx5xtDPDKyY3k9NebKwEg52sWIt2AHm1pKgt7PBiK1TaHhdl2Y1Xq
	pLevVEvGu2E2iICWfNWHQcyZFzv7v/Dy9awTt4iC678rjnMnq6hJ76N6YVUNzuoriylAjhPjfnh
	DASunujXhpdIsY4XweI72bjvqJFlhVWUTxes04tPbTetmsTT+L6WYZA2QOoEG0Kv3NKJmZI4sfp
	x4jCJWiqQu+SJFH01YjIpcXoEhder+eHCIRZHuTXRAR9OlEDlgEkvOmktC9EpITVrVIfMGUyTs4
	zKm1pvjXK5aHE0RsCYzqKr7jq/R/51nyz/C44a6Uq2ZbAx1ueWfnPlfL1TJ6uCwufzO67iPM1xA
	UrsCYi687GZ9mytYdWvTbAFNLXnIW+3+TGluPVGUGuF9bDREP/17TlEfEiFTo5/PWqW+hi+FHb3
	5Ar/jb9sR7x0umD6tg/eNK/2VBzzUxzMoCEerL16AnT/VDmaB/NPQcwxE/XUuzp3+4PBFhXVWX2
	aa6L17lOrWM6LR1CClMfw==
X-Received: by 2002:a05:690c:6610:b0:81c:8005:9104 with SMTP id 00721157ae682-83109926bc4mr35751497b3.30.1786560165845;
        Wed, 12 Aug 2026 11:42:45 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:3077:a5d:da73:f5b4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8346e1a954dsm167657b3.41.2026.08.12.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:42:45 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:42:44 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, song@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test linux_binprm user
 memory kfuncs
Message-ID: <any-GrHSwE5suq33@zenbox>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
 <20260812111140.7762-4-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812111140.7762-4-tasos.papagiannnis@gmail.com>

On Wed, Aug 12, 2026 at 02:11:40PM +0300, Anastasios Papagiannis wrote:
> This patch adds a sleepable BPF LSM program attached to
> bprm_check_security to test bpf_copy_from_user_bprm() and
> bpf_copy_from_user_bprm_str().
> 
> Starting at bprm->p, verify that bpf_copy_from_user_bprm() can copy the
> contiguous NUL-separated argument data. Then use
> bpf_copy_from_user_bprm_str() to read each argument separately,
> by advancing the offset based on the returned length.
> 
Can you test reading environment strings as well?

It would be nice to have an example on how to do that.

Justin
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  .../bpf/prog_tests/copy_from_user_bprm.c      | 52 +++++++++++++
>  .../selftests/bpf/progs/copy_from_user_bprm.c | 74 +++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..3d5080a3975e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <test_progs.h>
> +
> +#include "copy_from_user_bprm.skel.h"
> +
> +void test_copy_from_user_bprm(void)
> +{
> +	struct copy_from_user_bprm *skel;
> +	pid_t child;
> +	int status;
> +
> +	skel = copy_from_user_bprm__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (!ASSERT_OK(copy_from_user_bprm__attach(skel), "attach"))
> +		goto out;
> +
> +	child = fork();
> +	if (!ASSERT_GE(child, 0, "fork"))
> +		goto out;
> +
> +	if (!child) {
> +		char *const argv[] = { "first", "second-argument", NULL };
> +
> +		skel->bss->monitored_pid = getpid();
> +		execv("/bin/true", argv);
> +		_exit(errno);
> +	}
> +
> +	if (!ASSERT_EQ(waitpid(child, &status, 0), child, "waitpid"))
> +		goto out;
> +
> +	if (ASSERT_TRUE(WIFEXITED(status), "child_exited"))
> +		ASSERT_EQ(WEXITSTATUS(status), EPERM, "exec_errno");
> +
> +	ASSERT_EQ(skel->bss->bprm_argc, 2, "bprm_argc");
> +	ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_ret");
> +	ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
> +	ASSERT_EQ(skel->bss->str_arg0_ret, 6, "str_arg0_ret");
> +	ASSERT_EQ(skel->bss->str_arg1_ret, 16, "str_arg1_ret");
> +	ASSERT_EQ(skel->bss->args_match, 1, "args_match");
> +	ASSERT_EQ(skel->bss->str_args_match, 1, "str_args_match");
> +
> +out:
> +	copy_from_user_bprm__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..679363811edc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +static const char expected_args[] = "first\0second-argument";
> +static const char expected_arg0[] = "first";
> +static const char expected_arg1[] = "second-argument";
> +
> +int monitored_pid;
> +int bprm_argc;
> +int invalid_flags_ret;
> +int copy_ret;
> +int str_arg0_ret;
> +int str_arg1_ret;
> +int args_match;
> +int str_args_match;
> +
> +extern int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
> +				   const void *unsafe_ptr__ign,
> +					   const struct linux_binprm *bprm,
> +					   u64 flags) __ksym;
> +
> +extern int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
> +				       const void *unsafe_ptr__ign,
> +					       const struct linux_binprm *bprm,
> +					       u64 flags) __ksym;
> +
> +SEC("lsm.s/bprm_check_security")
> +int BPF_PROG(check_exec_args, struct linux_binprm *bprm, int ret)
> +{
> +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> +	char args[sizeof(expected_args)];
> +	char arg0[32];
> +	char arg1[32];
> +
> +	if (ret || pid != monitored_pid)
> +		return ret;
> +
> +	bprm_argc = bprm->argc;
> +
> +	invalid_flags_ret = bpf_copy_from_user_bprm(args, sizeof(args),
> +						    (void *)bprm->p, bprm, 1);
> +
> +	copy_ret = bpf_copy_from_user_bprm(args, sizeof(args),
> +					   (void *)bprm->p, bprm, 0);
> +	if (copy_ret)
> +		return 0;
> +
> +	args_match = !__builtin_memcmp(args, expected_args, sizeof(expected_args));
> +
> +	str_arg0_ret = bpf_copy_from_user_bprm_str(arg0, sizeof(arg0),
> +						   (void *)bprm->p, bprm,
> +						BPF_F_PAD_ZEROS);
> +	if (str_arg0_ret != sizeof(expected_arg0))
> +		return 0;
> +
> +	str_arg1_ret = bpf_copy_from_user_bprm_str(arg1, sizeof(arg1),
> +						   (void *)(bprm->p + str_arg0_ret),
> +						bprm, BPF_F_PAD_ZEROS);
> +	if (str_arg1_ret != sizeof(expected_arg1))
> +		return 0;
> +
> +	str_args_match = !__builtin_memcmp(arg0, expected_arg0, sizeof(expected_arg0)) &&
> +			!__builtin_memcmp(arg1, expected_arg1, sizeof(expected_arg1));
> +
> +	return args_match && str_args_match ? -EPERM : 0;
> +}
> -- 
> 2.55.0
> 
