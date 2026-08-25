Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688482192F9;
	Tue, 25 Aug 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653942; cv=none; b=pYEOQ5CQ6QWmJjYUmJZztHl7VENpRmjD8LPuCpMTXi63W3KdaA6FkLlU7Ws8D/ocac1U4JKiYmw0PXGfPZsyEIBKJvKd9N/cdgcuEWMBWT5JpzKTik5W0LwoOF5QrCcm/pzh9YUvGgZwjxeauDafpYjBo7ikJ1K7JBGZ9Xom0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653942; c=relaxed/simple;
	bh=Jtp7DwbuDlqyr2ZqwFfr2J/yKB1S60q3EAiIjWm3giU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kok/cXuJ6CAHgmC5BXL8RRUHNHmGM1Fw2EOllXixIGTU3Hpa0qKUD9+ZKsqFpWtFU52L1OhhwEmoYJsMKusYTuojgwBDVPlYl6B9HMzzL/4O4bPOXA2vrZVW7X5B09g55pxrklssuRcXo3Xxf4OOmgpQ4HN4pM6Jaof6cZ/i/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTjtKVUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTjtKVUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52461F000E9;
	Tue, 25 Aug 2026 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787653941;
	bh=W5y1g/S/6GpD1ZczzIx0C4bcJtcC52RyUVvncYTsbIg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QTjtKVUl6i9gNYOSRwXJZLq7reEwZhwWFA+UTyN7a49vD+JAQpKuesQlsNmff0aT/
	 boyPR6xa3jgKG3hfYG8o8O0u54jUP+VmVvRACGzkmmr+s69LF5QngzBtoUhyQUIcoM
	 FwFdhXcvt4YMcRsXRUj65GLfVsqqff0cR7Udnu9kg8+rG2Iz/TvQudBUwVfW4Sl0k/
	 tEUGhT0Be2muhq8o4d4dhHDdsPJBkKq8ABdFMmXY+RMHIbAXFrC07yW2Tm/2syiuys
	 pVmGLz3pszgBykjYx6BYCrzGoESj+EBZyu5NZjAHN5cvY27hHLPQyrRDu2Qn2zpxCP
	 axACzOENwQujA==
Content-Type: multipart/mixed; boundary="===============5248335280663691553=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6056ca7f764664cedc6f3df0eb24f3652d0a07f6d3417aaaeeea4451dab37aa1@mail.kernel.org>
In-Reply-To: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,jiayuan.chen@linux.dev,emil@etsalapatis.com,ahemadkhawar123@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 10:32:20 +0000 (UTC)

--===============5248335280663691553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/testing/selftests/bpf/progs/arena_memcg.c
> new file mode 100644
> index 000000000000..88259cfea06b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 50000); /* number of pages */

This isn't a bug, but could the 50000 carry a short note that it just has
to outrun ARENA_BUDGET on the smallest page size, so a later change to
either constant does not silently make the loop finish before memory.max
is reached?

> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +SEC("syscall")
> +int noop(void *ctx)
> +{
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32835197153
--===============5248335280663691553==--
