Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB773BBA1E
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998354; cv=none; b=eXENzWwmBOAinsdtg2jm97RVDKPRJi9gscKiVmbKVJoLlDwzxrYU1V+YUx+HXUGLT8CsF1lhSeeVLhazEErNmbvVE6LR6tlAGbnBBW+QOd4vJ918GL/6REAFhVQSshQSsKOc3iEp0J994k4vnKOhtKNibLvV65wx/TMhMnpbnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998354; c=relaxed/simple;
	bh=uCccX+Ut3lfeMmsNLbzivnasSX8pDbm1Jw8FlHSHmg0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UjrfDXCUVY5hi8sfaT++AQBNSVTY3s0jrSLttQQVEt+QwYX2L09nvpWm7LMc+1+4HID3IOsujaYhvUhPg0bkAdjx00yAXwPrmG4Vla/dOROYiiazYkSWnafWzPUvyIEA/z/47kmIqEJA+TvIX0hxFc7fTKzUjLlUCFCt5WsEKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRkVVFnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRkVVFnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12871F00A3A;
	Mon, 17 Aug 2026 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998353;
	bh=xd7QqXrm62qcCjpZjHbFYzkVxNCW2DT81+5wOGQk0hM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hRkVVFnHCZ9jJJQtxK1tcGfGMGLKc19zYCqDz+D4kHQ/U6p+ZJjva2fXYolbikPdQ
	 DzPZGrAg7CfFR21lYYGa1B4c7do/cgDB6cLpnA9RLngt9+JlA8cFhyMW6NHKuUJBIB
	 I9W9CWe7eN2KTQcFGBJPeJTXuawfHv7YwYCZ4pRhlER8wK0CivNmmgvUlKoO2aEmIk
	 H1ljNtgwNsjrqmeZzlWwAgaIRNAl/BE9HChLt2LafcNbuzS+4KEosOOxEptemx1GP2
	 vNyBoNM5XYAWtWYHz4LBIDOqZ2XDKMr94Zxb5ptJ+Y+GyVBXhkCxOIH8oe7T3CWYwf
	 LTJkb/ZCfVIrw==
Content-Type: multipart/mixed; boundary="===============5538890704170967722=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <50547d51c1e2ebea6eb4b3d97d3672f9189ad2a4940f880c6bfcebf0b89cf384@mail.kernel.org>
In-Reply-To: <20260817191616.11071-3-emil@etsalapatis.com>
References: <20260817191616.11071-3-emil@etsalapatis.com>
Subject: Re: [PATCH 2/6] selftests/bpf: libarena: Inline nonatomic bitmap operations
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:25:52 +0000 (UTC)

--===============5538890704170967722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> index 8c5936ae9958..163e2b83d943 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>  #pragma once
>
> +#include <bpf_atomic.h>
> +

Does this break host-includability?  The other libarena headers (common.h,
buddy.h, asan.h) deliberately keep themselves dual-use: common.h has an
explicit #else /* ! __BPF__ */ arm that defines __arena to nothing, and
buddy.h/asan.h fence their function declarations behind #ifdef __BPF__
while leaving structs visible.

Including bpf_atomic.h unconditionally pulls in vmlinux.h and
bpf/bpf_helpers.h:

tools/testing/selftests/bpf/bpf_atomic.h:
  #include <vmlinux.h>
  #include <bpf/bpf_helpers.h>
  #include <bpf_may_goto.h>

  extern bool CONFIG_X86_64 __kconfig __weak;

None of that is usable from a host compile. The Makefile adds both
-I$(CURDIR)/libarena/include and -I$(INCLUDE_DIR) (where vmlinux.h lives)
to COMMON_CFLAGS, so a host TU that includes bitmap.h would pull vmlinux.h
into a build that also has libc/uapi headers, under -Wall -Werror.

No host TU currently includes bitmap.h, so this is latent rather than
breaking the build right now, but it silently removes a property the
neighboring headers maintain.

The include is also redundant: all three existing consumers (bitmap.bpf.c,
test_bitmap.bpf.c, test_parallel_bitmap.bpf.c) already include
libarena/common.h, which pulls bpf_atomic.h indirectly via
bpf_arena_spin_lock.h at line 8. And it doesn't make the header
self-contained anyway - bitmap.h still relies on the includer for __arena,
u64, size_t, and bool.

Would #include <libarena/common.h>, or wrapping the new include and the
three inline bodies in #ifdef __BPF__ the way buddy.h does, keep the
dual-use property intact?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062809860
--===============5538890704170967722==--
