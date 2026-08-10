Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B5411A17
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373374; cv=none; b=IY0Scry4dpvGwgb2uSM1vD/6XD58a8AuQTFuT/8PR5N+eI61FOATSV67YsQCQfRcUSELhEPiW7OHH+wOEbzeh2GMofb5K9Z0mm6PVIea4WIGShF45SiyfgcEb869hluj4PMvLZIxNeMq6Ijf2uOwzZbpbyircJDIanH6wnB7lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373374; c=relaxed/simple;
	bh=zr9++h3pQ31eNIe1HKWmqArrbphnQKU5HHPwEYg4TUo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AUQlwM1kbIQYjeR/vJYVXMl0FGMhOsmiTRe3TcEvkmH0w7MMpZBlkobBA/zu4360TjQHvCPN2a8SfOaTu8Krba8qzceClScFJiOv1jyeRglSatGkRVzXVxUt61kCxRmfBpGwQPP2bXnVoOUnt5+AtV6oUnC3yDgah6WVVATczV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM+dYab8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM+dYab8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E821F00ACA;
	Mon, 10 Aug 2026 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373372;
	bh=SXnVufDvvN/3GPQ0klDDYOutRwgbMjTD0Kr0uCn3yVc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GM+dYab8jMe86ulB0bhGgPXp41CALzZFzc2CmT/CJGSxQxOcPfZvMM6L/Riait4HR
	 ZXcBe2lPkrfc/ex4OfU5ND7bvA2MJs1NGduO3iA/jzzSJ0LhiaxZsmiF6KR6Lr2QVZ
	 Xmg8DxOvy91/tzcRe4qC+kbbK51v/tzO318AA/IkUlWwxe6XEH75gufRhc76AAzCiy
	 jCrSrIwh1QX4pEM1vyM4XcbdzNabMfV/T7IvpIfeRRVs/CFazuRMm2GefP51UiR2t5
	 7G05aXG4j0zVTdGl/wIW2iJjfrzhcjbo7XjQZnMxwLt61KcfYu1X+ltVPajc12v2cl
	 MQd0aHul4lXtw==
Content-Type: multipart/mixed; boundary="===============7254964115263791726=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <297869b0b439670b66b2761bed56af7f655ee163a786b4dbd3add871cb324874@mail.kernel.org>
In-Reply-To: <20260810135934.2887684-3-chenyuan_fl@163.com>
References: <20260810135934.2887684-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add regression test for queue/stack map size limit
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 14:49:31 +0000 (UTC)

--===============7254964115263791726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..043cbe92e2ba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -2,6 +2,8 @@
>  #include <test_progs.h>
>  #include <network_helpers.h>
>
> +#define U32_MAX ((u32)UINT_MAX)
> +

This isn't a bug, but for the single use in the test, would UINT32_MAX
(already available via <stdint.h>) work instead of adding a local
U32_MAX macro that relies on UINT_MAX coming in transitively?

> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);

This isn't a bug, but since no field of opts is ever set in this
function, would passing NULL as the opts argument read more directly?

[ ... ]

> +	/*
> +	 * Regression test for the u32 index overflow in queue/stack maps:
> +	 * a map whose element storage (max_entries * value_size) exceeds
> +	 * U32_MAX bytes must be rejected at creation time, otherwise the
> +	 * u32 head/tail index multiplication wraps and push/peek/pop
> +	 * address the wrong element. 8192 * 1MB = 8GB > U32_MAX.
> +	 */

This isn't a bug, but could these two comments be condensed to the part
specific to the test (why 8192 x 1MB and why E2BIG), leaving the
description of the head/tail wrap to the comment the kernel patch adds
in queue_stack_maps.c?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31396327144
--===============7254964115263791726==--
