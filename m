Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5583FD13D;
	Fri,  8 May 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254812; cv=none; b=Tp6EuxFf/M+IQ51piXSFJVGD5KR7DPzq1CTSszdnXvJ7zPVhB5a+bf91CnNekmnZQrAAHFBNrKnh7JRF/3oEu4VNZByxCItPA68zddkDjqx6lu+Fk1l74zZypnJjCUvGp3EyAeTTiFL2w5/ereVnQTzO/uTUYMEFbkqw26/dAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254812; c=relaxed/simple;
	bh=5EjtDlUmrIuStydpM3BHOspQa1U4dcycPlThtC7+yjs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ilc/WS0buY53ZUnKOxe5iNrjB9WgXHoZkvzZI2qLFrnAU64FsEewbHg0NM79SR6ziVcM7fYeeykwphOGdb/4qLEoS8WmPPqmiAcPCqdSGovop67J2QQ0fti/0pwonp2eQPQpOJY8NOg0J4R/CYL98H6lvrotMLaGQj5W3qTj3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6g6Ee+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6g6Ee+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29644C2BCB0;
	Fri,  8 May 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254811;
	bh=5EjtDlUmrIuStydpM3BHOspQa1U4dcycPlThtC7+yjs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=t6g6Ee+K+pTb0MKucmrg+Rik/fVxeI6T70n0nWBI/Jbuoq2JaXlABABbtH5s3tAq4
	 8AZ7z1jtmfppe/RgTn1Go8heZoor43pDeGPV72vKRD2ycbyozvlbGU9iPcQCpbiDu1
	 qWHKn/68tqPbt3C1GoZH3Ui+EwHxFO/hdgeLsev0JUWaFG+z9ToWWyGajtQGEbCRxl
	 ShypMRIVOZ2PXbmoqNmA84V3h6KhJk2EDc2u8Nx9rbjkBB35OxYbJVcTUC9nQWxKwt
	 yn9f2GN/jcdj7kSzfNZiRUWbwuqrQ/ftJAHAzdPXRHmcaudCBpO6KTsZ1j9FO5nubf
	 dr37E+SkHYfVA==
Content-Type: multipart/mixed; boundary="===============9112384240899730167=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5eb9dcb3bb77920b11e2efc3e082c685cc089499a4be5cc3469c3db4d2779da0@mail.kernel.org>
In-Reply-To: <20260508150055.680136-5-vernon2gm@gmail.com>
References: <20260508150055.680136-5-vernon2gm@gmail.com>
Subject: Re: [PATCH v2 4/4] samples: bpf: add mthp_ext
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: tz2294@columbia.edu,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,laoar.shao@gmail.com,gutierrez.asier@huawei-partners.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  8 May 2026 15:40:11 +0000 (UTC)

--===============9112384240899730167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
> index 0002cd359fb1..2a73581876b4 100644
> --- a/samples/bpf/.gitignore
> +++ b/samples/bpf/.gitignore

[ ... ]

> diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> new file mode 100644
> index 000000000000..120c331ff26a
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.c

[ ... ]

> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <time.h>
> +#include <stdbool.h>
> +#include <getopt.h>
> +#include <sys/epoll.h>
> +#include <sys/stat.h>
> +#include <linux/limits.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +#include "mthp_ext.h"
> +#include "mthp_ext.skel.h"

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	const char *root_path = DEFAULT_ROOT;
> +	unsigned long threshold = DEFAULT_THRESHOLD_MS;
> +	unsigned long interval = DEFAULT_INTERVAL_MS;
> +	unsigned int init_order = DEFAULT_ORDER;
> +	unsigned int min_mem = DEFAULT_MIN_MEM;
> +	bool fixed = false;
> +	bool debug = false;
> +	struct mthp_ext *skel;
> +	struct bpf_link *iter_link;
> +	struct bpf_link *ops_link;
> +	struct ring_buffer *rb;
> +	int root_fd;
> +	int psi_fd;
> +	int err = 0;
> +	int opt;

[ ... ]

> +	/* Attach struct_ops to root cgroup for mthp_choose */
> +	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
> +	opts.flags = BPF_F_CGROUP_FD;
> +	opts.target_fd = root_fd;
> +	ops_link = bpf_map__attach_struct_ops_opts(skel->maps.mthp_ops, &opts);
> +	err = libbpf_get_error(ops_link);

Will mthp_ext compile with these symbols?  bot+bpf-ci@kernel.org noted in
v1 that bpf_struct_ops_opts, BPF_F_CGROUP_FD, and
bpf_map__attach_struct_ops_opts() do not exist anywhere in the kernel
source tree:

https://lore.kernel.org/bpf/c13f99d42c434ec73ec1e8cf1141047146ab359e60e56e78e1c32554d6e01e9b@mail.kernel.org/

The struct bpf_struct_ops_opts type is not defined in
tools/lib/bpf/libbpf.h.

The BPF_F_CGROUP_FD flag does not appear in include/uapi/linux/bpf.h or
any other header.

The bpf_map__attach_struct_ops_opts() function is not declared in
libbpf.h or exported in tools/lib/bpf/libbpf.map.

You mentioned in your response that this depends on patches from the 'mm:
BPF OOM' series (PATCH#2), but this dependency was not addressed in v2 -
the same non-existent API calls remain in the code.

Should this series explicitly list the dependency on the 'mm: BPF OOM'
PATCH#2 in the cover letter?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25563319416
--===============9112384240899730167==--
