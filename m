Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429F46C4C5;
	Tue,  1 Sep 2026 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248255; cv=none; b=T/OVfLklOWqkAMHyaPO76DjbA8iM0+VO1wNxQvAOLvO9O6LiQjzKHEOjG3eLel2MCHHzSyr4kYBzclSXzyBCFrRqKS/WjP+LkMHITqwP0ZYyrm3zMSavEHYIXfhlxsgq8bzTUncN99O7NvVMEYyacjTf91+3I/IGoxYbWBVJW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248255; c=relaxed/simple;
	bh=cD71fSU8oxhllEAjJzUHfMcjj0HRDjwY/mokw3TJ5hQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SkRzpp2NOFYD8HuOcwMdvdoZEgHOUDQxe9X2xeCenMtE6gz5G9xA6X4I1Z5ph8AmyWHrxnTUpcnmsR48GAVJ9PTqbaimSvKfh+48PjZFRYVjs5wc2/9c4Twmdv9UhIPGXFkV9ChXONarzwCjvJ0z76SVyqMs/7s5XvzW4T7xOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuADwWQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuADwWQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5311F00A3E;
	Tue,  1 Sep 2026 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248253;
	bh=cD71fSU8oxhllEAjJzUHfMcjj0HRDjwY/mokw3TJ5hQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HuADwWQgYH/3fzLXVihpBW5NgPVaKpQd6SpUz7IqGBdJL14sHe5eJ/vjvTAlENmnL
	 cweALiRXSegl7ThVsJiceYf2kFkO2RfS6K3x8U2Mq8P08kn9jbvdsZLsoi1k2A9eUn
	 ECfMduzf64WQXSNtHDRFogH1T7gmvvgHUl/yeDvGdnw8x01AwZFmigj/3qN3XIWt4c
	 764+W4LevwsYABRaRFJVBO3tOZo/xMzvkozab1eB19QDNBWOMOxIsgVKTIQ3jt7bPR
	 XfzWOaIPW4BKw7zEIgtmb2gKsYVQ+7JRS5n2IliNUu542bnGitXVLOgaXoyhC2TLYU
	 YKrTd0B4kgD5Q==
Content-Type: multipart/mixed; boundary="===============3706888861537028182=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <06a2dd01e897308215bde044bd80409b99491e61a646671383c8301738caac22@mail.kernel.org>
In-Reply-To: <20260901062845.1379760-4-chenyuan_fl@163.com>
References: <20260901062845.1379760-4-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Test rhtab kptr recycle from NMI context
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mykyta.yatsenko5@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 07:37:32 +0000 (UTC)

--===============3706888861537028182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
> new file mode 100644
> index 0000000000000..c96cf7f2d799b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 KylinSoft Co., Ltd. */
> +
> +/*
> + * Verify that the rhtab update/delete recycle paths do not eagerly destroy
> + * referenced kptrs. rhtab must match the hash map semantics introduced by
> + * commit a3a81d247651 ("bpf: Cancel special fields on map value recycle"):
> + * only NMI-safe fields (timer, workqueue, task_work) are cancelled on
> + * update/delete, while kptrs stay attached to the recycled element until it
> + * is eventually freed.

[ ... ]

> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "rhtab_kptr_common.h"

[ ... ]

> diff --git a/tools/testing/selftests/bpf/rhtab_kptr_common.h b/tools/testing/selftests/bpf/rhtab_kptr_common.h
> new file mode 100644
> index 0000000000000..1b629fcb6742d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/rhtab_kptr_common.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 KylinSoft Co., Ltd. */
> +#pragma once
> +
> +/* Magic value stored in the plain bytes of rhtab values ("RHAS"). */
> +#define RHTAB_MAGIC 0x52484153

This isn't a bug, but since only progs/rhtab_kptr.c uses RHTAB_MAGIC,
could the define live in that file instead of a separate _common.h
header?

The *_common.h idiom at the selftests root is for constants that
genuinely have to be identical on both the BPF and the userspace side.
Here the userspace side never includes the header and never uses
RHTAB_MAGIC. Moving the define into progs/rhtab_kptr.c next to struct
val_t would avoid relying on the root directory being on the include
path for .bpf.o builds, and root-level headers are not listed in the
.bpf.o prerequisites, so edits to the header do not trigger a rebuild.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33478386254
--===============3706888861537028182==--
