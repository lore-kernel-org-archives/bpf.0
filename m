Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEA49250F
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083563; cv=none; b=M4te0xrdSAhP3lDfTjdHWVU+fQ83DX2jtRXXvpQvx7N5w6V1ANKownv/nERML9H5nHJK+QR6j7X63MLe4VzLXFulwXU2aFW53z4w5RuEytAP9X9qZ2+g7xAdDFa+mKASkQpcFo7CXk2zC/rj++yPqwkPUM4gwlKUy3pGFtLD3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083563; c=relaxed/simple;
	bh=mewwZhswcQwqh7o4uuMTa7YHHrayMPY8MpXuYliBGww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH57Iiq7g6cwzSwJ5yygOxihJLC8Ehl1SNeIJ5cFOx3qa5eBlClYU43OMGcX1g2lePBMNVmr0ZwAghZ1kc8eWKWx9RtU32gPkhR6q2KcEi2xkXl7qWD/i2CwIDO1CDZT8iX9jXDEFAHrrkTewuokiGVmjvtdfgNPo0newBrNZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUFU1VP5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUFU1VP5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3960446f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083551; x=1778688351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlLGLVG6rpf3xsr4LqdJXr2wFrUMiHHPEPRsZhGBHnI=;
        b=BUFU1VP55dQi9KZ+ZbCjwXPQWYNATS39OQG+aAbegFM4qPeVYD+lIpCSUwDGJ8vGvw
         ubpxLlNiI29G2u7222grUl3r/fLoZrQsL1jMyIYE4hFB4m++PP7Z5z1zduyNj6GaJrWy
         lEozWaeqwXX98QgF9KYG/JRNOjlX6RgU/pq2WcLlkJKp35pR7wK9i9TmOrSt6FZlEHUQ
         eGz4VAb+PLQjrgkg8PAypudDWVOnoy2DoKkXao0HGdDp+uyvySRsvCyi1zpkVpQizu/L
         T7W9Nfu6yNawzdYSprs6MLVkdkrUB/IgkHDhQgQGJwpiHAYD8FrgLHr9+lDZQUcMjt/o
         uAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083551; x=1778688351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlLGLVG6rpf3xsr4LqdJXr2wFrUMiHHPEPRsZhGBHnI=;
        b=Pse7DSNN7AqEfCH2MJ6h2x0dv4OGrhuF9BcU/xfFA+uA66p06QiYO0sXyqJOMV7QyV
         UZivVmPHjYmTcTzF40rxUlwCC//WIMbLDCCrxOyB2PDCiuKsEOMW+3RzIri/s7ls19qU
         sZQphavo3udXyu9xyS2dkewnxBfBuXtlOMNYy4g1di+GbcPTTCMxalYxLrLPROgFum3I
         HFb+MOqH+1/Pqa1EiPFpJBvakFxtJSmawtlbah12ZYaBeegsHK7mecI9D/x6+VOSQVvM
         4Ibs3Zf6y/nZRw3BR1694eNVAzWyYUh4woAbaev9ab029ipYaUsngglYd5AcXSf/KAIB
         6LVw==
X-Forwarded-Encrypted: i=1; AFNElJ8xbgrrQtTWJ3dXZUkiJ/NFqXfG01XEj9yK9fsRwtIkGtF8tpQDs9vy+vRKksaBg85DuSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqlGN17JCPqACCIJu+4D1tw2SiaiaPTBkw1mAgfXGjBYOkCKX
	PODO3M5dmG/GNl+6FOQ4d2y7apK/GvXXlkafMrE4W6Qoasm5IfMg4qs7
X-Gm-Gg: AeBDiesaeqXPy+FI1vhwLXTdpS/dplUhflie/7kOy2hHuFNXuwZwRgl/j+oJwMMuYF0
	rTm/1H0JQ1fAvZ5sA2Iz2ijgmxSBJD98VLzQRLgnHMs3xWc1W2/eIywSfoqvfHFfVpNpTkfhj2T
	H//8eyd1sMR5W4SWGdpY3KouF80xCkVxdcSx5j5hB9dHiFC5xeg2B3+BdQOVDP/wUnh/1o2etR7
	oy2NcRsZLFuQJdaMSsR7PE/0wX/rus/KYVeR6kUgrDAB86sGBQwHHmmlI6UZzVKkKYTo7tV+V3E
	RO9aAbX7SMQL6wbqxTtU/4RXyBgMROSlHdL8UNs23n/l/pWQxhHzLqBtY2Ip78KdrL6ILTIM8hv
	5rvSW1fS784PhSm63OuokBJozIgqmDF2CBNN4k1khyH9Skf5vf9op+il/ENRvtcCZ3MbIg59Qbf
	tqjeEnxIu/ZU3/4UyEOffdCB9CeRiKjlwExMO5qso6s9GS0lrUtBuikmGChqyJsPEqjoR8zbAPV
	kntnUjCkt1GDUBC6tmPIxCll/IrVbZ5PKyDGa5v8yUPrmFarLTwsXK3CDKGwXxmfq8EkGdJX5KX
	qIg2bYE2KpYrjEWuK0xmCHeHQC3aAW2VmkZbd5G1LyTdUG+s6qdQtw==
X-Received: by 2002:a05:6000:230a:b0:43e:b0f7:9ce9 with SMTP id ffacd0b85a97d-4515b61af48mr6971029f8f.14.1778083550879;
        Wed, 06 May 2026 09:05:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b5a044c6307a465e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b5a0:44c6:307a:465e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e174sm13608738f8f.1.2026.05.06.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:05:50 -0700 (PDT)
Date: Wed, 6 May 2026 18:05:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: paul.houssel@orange.com, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/bpf: add tests to verify the
 enforcement of CONFIG_CGROUP_LSM_NUM
Message-ID: <aftm3Gu7e7joX9PA@mail.gmail.com>
References: <20260506150547.767315-1-paulhoussel2@gmail.com>
 <20260506150547.767315-3-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506150547.767315-3-paulhoussel2@gmail.com>

On Wed, May 06, 2026 at 05:05:47PM +0200, Paul Houssel wrote:
> Add a selftest that verifies the kernel correctly enforces
> CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
> per-cgroup LSM hook slots.
> 
> The BPF program side (progs/cgroup_lsm_num.c) defines 12 lsm_cgroup
> programs, each attached to a distinct LSM hook. The test side
> (prog_tests/cgroup_lsm_num.c) attempts to attach all 12 programs one by
> one to a cgroup, and verifies that exactly 10 succeed and 2 are rejected,
> matching the value of CONFIG_CGROUP_LSM_NUM set to 10 in the selftest
> Kconfig fragment.
> 
> Signed-off-by: Paul Houssel <paulhoussel2@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |  1 +
>  .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 +++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_lsm_num.c      | 46 ++++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 24855381290d..e4c5dd86c640 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -11,6 +11,7 @@ CONFIG_BPF_STREAM_PARSER=y
>  CONFIG_BPF_SYSCALL=y
>  # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
>  CONFIG_CGROUP_BPF=y
> +CONFIG_CGROUP_LSM_NUM=10
>  CONFIG_CRYPTO_HMAC=y
>  CONFIG_CRYPTO_SHA256=y
>  CONFIG_CRYPTO_USER_API=y
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
> new file mode 100644
> index 000000000000..1c5825c6c3d0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Orange */
> +
> +/*
> + * Test that the kernel enforces CONFIG_CGROUP_LSM_NUM as the maximum
> + * number of concurrently used per-cgroup LSM hook slots.
> + *
> + *  - load a BPF object with 12 programs each on a distinct lsm_cgroup hook
> + *  - attach them one by one via bpf_program__attach_cgroup()
> + *  - at some point the slots are exhausted and attachment fails
> + *  - verify that 10 succeed attachment and 2 fail
> + */
> +
> +#include <test_progs.h>
> +#include <bpf/bpf.h>
> +
> +#include "cgroup_lsm_num.skel.h"
> +#include "cgroup_helpers.h"
> +
> +void test_cgroup_lsm_num(void)
> +{
> +	struct cgroup_lsm_num *skel = NULL;
> +	struct bpf_program *prog;
> +	int cgroup_fd = -1;
> +	int attached = 0;
> +	int failed = 0;
> +
> +	cgroup_fd = test__join_cgroup("/cgroup_lsm_num");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		return;
> +
> +	skel = cgroup_lsm_num__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto out;
> +
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		struct bpf_link *link;
> +
> +		link = bpf_program__attach_cgroup(prog, cgroup_fd);
> +		if (!link) {
> +			if (errno == EOPNOTSUPP) {
> +				test__skip();
> +				goto out;
> +			}
> +			failed++;
> +		} else {
> +			attached++;
> +		}
> +	}
> +
> +	// CONFIG_CGROUP_LSM_NUM set to 10
> +	// -> 10 programs shall be attached
> +	ASSERT_EQ(attached, 10, "at least one attached");
> +	// -> 2 programs shall be rejected
> +	ASSERT_EQ(failed, 2, "limit was enforced");
> +
> +out:
> +	close(cgroup_fd);
> +	cgroup_lsm_num__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> new file mode 100644
> index 000000000000..662aee2283c2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Orange */
> +
> +/*
> + * 12 LSM programs with lsm_cgroup attachment type, each on a distinct LSM
> + * hook. Used by prog_tests/cgroup_lsm_num.c to verify that the kernel
> + * enforces the CONFIG_CGROUP_LSM_NUM limit on unique per-cgroup LSM hook
> + * slots. With CONFIG_CGROUP_LSM_NUM set to 10, 10 shall be attached and 2
> + * rejected.
> + */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define LSM_CGROUP_HOOK(name, hook)		\
> +	SEC("lsm_cgroup/" #hook)		\
> +	int BPF_PROG(name) { return 1; }
> +
> +
> +LSM_CGROUP_HOOK(hook0, socket_create)
> +
> +LSM_CGROUP_HOOK(hook1, socket_post_create)
> +
> +LSM_CGROUP_HOOK(hook2, socket_socketpair)
> +
> +LSM_CGROUP_HOOK(hook3, socket_bind)
> +
> +LSM_CGROUP_HOOK(hook4, socket_connect)
> +
> +LSM_CGROUP_HOOK(hook5, socket_listen)
> +
> +LSM_CGROUP_HOOK(hook6, socket_accept)
> +
> +LSM_CGROUP_HOOK(hook7, socket_sendmsg)
> +
> +LSM_CGROUP_HOOK(hook8, socket_recvmsg)
> +
> +LSM_CGROUP_HOOK(hook9, socket_getsockname)
> +
> +LSM_CGROUP_HOOK(hook10, socket_getpeername)
> +
> +LSM_CGROUP_HOOK(hook11, socket_shutdown)

Please remove all the unnecessary newlines. One empty line after the
macro definition is enough :)

> +
> -- 
> 2.54.0
> 
