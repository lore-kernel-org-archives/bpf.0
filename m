Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB592D0C84
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018529; cv=none; b=t8hOToMbi1bylBAqxDFZAiDmOyKbDYDgUx+WWmbeh48MFWloSUhpf/gVpYexDULrxw1NltMh9GNGNGFjbPj8ILeJfBL2q1P6diBp/9h3zAcfT/C4W6M4W0Vryje1jdZs85uikq6UVAv5KWvgcvWgIVgTnqKGZgPeaIBMn6Fn/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018529; c=relaxed/simple;
	bh=JJYU8CP+n60EbBg3rm8XAbdc4a+qSVrzSEYhBeeUZm0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Pvq2DqJpGzdpWIzDIYhXdAgw21V+GpMPfcG/FFnINRLq7aT0BqpgaIJxbZEOcnPU/WjJjTi4YDdd4EVmIn7bcFLLuzZJ1lIDr8BFNCy9FYHqrUw7ghVv/2Pg/P2sFvj3GVyYpXkB6H0qYGaBWSoAKpb+T81iGboTILBFr9v+Mvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEbks0ea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEbks0ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B434BC19424;
	Sun, 12 Apr 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018528;
	bh=JJYU8CP+n60EbBg3rm8XAbdc4a+qSVrzSEYhBeeUZm0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hEbks0eaES+i9S4jtG/ku7p96ci9aOZ9qch1EjVAUVR3dNIV4UEUIbCTDfCEzxnRa
	 lJEYaf9o+92tvzYprRnogTA839/c4xB+6H14eTT/1S4163kVa9tEYsIJg3+tEMj5Zp
	 R7ghTKEwWiOsd8gKEKT2e+NSaY4AAWzHUFTrDaoBxUobsUbj9QxnFZRTyFicD3Djb3
	 T5go37Z4ZVXlaOJtdh6LhQcjk06Iqgzuv0fz99xlR1f59ET7dgYrY54J6ArNhizyDH
	 4+mKmfl9piXoFsiiSFlsfhiS9Ho40uuRtxSYrIJXM73Dlj1l+5q2s/i833vJZBj7Lq
	 kYoVUCzEoae3w==
Content-Type: multipart/mixed; boundary="===============0005545890210084584=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc6ef7461ae9a8ac98f5cc4913100e5e6079ee2130869dfbe8d1b2181a6705ff@mail.kernel.org>
In-Reply-To: <20260412174546.18684-6-emil@etsalapatis.com>
References: <20260412174546.18684-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v7 5/9] selftests/bpf: Add basic libarena scaffolding
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 18:28:48 +0000 (UTC)

--===============0005545890210084584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> new file mode 100644
> index 000000000000..c692e20ea7b1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c

[ ... ]

> +#include "../libarena.skel.h"
> +typedef struct libarena selftest;
> +#define selftest__open libarena__open
> +#define selftest__open_and_load libarena__open_and_load
> +#define selftest__load libarena__load
> +#define selftest__attach libarena__attach
> +#define selftest__destroy libarena__destroy

Alexei raised this in v4 review:

    https://lore.kernel.org/bpf/CAADnVQLCyP+NzO9-332JO+dBe=EDEOr+ax+-ZrvAqJ9yTNYyEA@mail.gmail.com/

asking about the purpose of these #defines and calling them
obfuscation. These aliases don't appear to have been removed or
discussed in subsequent versions.

Would it be simpler to use the libarena skeleton functions directly
(libarena__open_and_load, libarena__attach, libarena__destroy, etc.)
and drop the selftest typedef and alias macros?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24313021445
--===============0005545890210084584==--
