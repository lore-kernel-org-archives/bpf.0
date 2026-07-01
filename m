Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573493DC4D9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934720; cv=none; b=fHuxCQ8XO7+P2VRnm6oIY9GZL4jC0varyVl7LT8xkGuTtIjAejSZEB3ENxeSHbz43QvfVV7G0/8Xv5EFQkdyKIanikH2mHvjJMyahn1o9ovuV3gv9Lvw/bCwpp0Kroolltg00yn76vhZilVBj3VOOZYgciNgAA6edIpQYnuqJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934720; c=relaxed/simple;
	bh=LuV1UwgEhG30/taOaQiDTjYGkHYFkN8ojOulBV56o34=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iZb+Vh0AK4CBc1PJtTGPCbo+lok1qKpJLQEqkkHbqrT6s7YpyWeqAlWAohSxc878wTNZ6BKOCR6jt+0z1fiU8J4YKp3o+goPvaaiusdteDQxf/uVJf4TdgQTEEGDi/jztm7T8BQr/z8Gv8TJqSXlKvHRa7JL+m0InSuxX6nPKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKidwwdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKidwwdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55DB1F000E9;
	Wed,  1 Jul 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934718;
	bh=LcCLmpSUMQC8d4mXOIG9DaS4mePVg7iQ8pgJ1qQ4a1o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZKidwwdc99XG6qTNWisb9CirgH7cTRV5iKcwYUrE36PehKyqPwAU4j8Ya81hH9vET
	 P6746U1IYCYR561HkNUM00xrdPX44BDLdcB1kYYPEQp7bVEU8PZLZUJQGbUFy/5g8Y
	 5z0M1RS4viC3ZSn9V9Ki2dmIPxiZZ3tu9ZnzGXR7s1Vve2YimhqleNrC6hYPvHO4vs
	 FSwE4MHn1IqPhbDjjcyPMruBETLsuNCvtHQuhmodIgDYKDVocT1dWUn1YXynKlDw9o
	 erLXvSKVyP6kIs/2TxNE7Wtrn70nSk7mbZzHr3yp/fBANvaTfEpD7RFiD3IsTeDOy3
	 rIPxsckFqI44g==
Content-Type: multipart/mixed; boundary="===============8390509962774880332=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <be23e3157458e8ec12b457978c5c13d20fad8fea8fefafd4f7f49fbebb534903@mail.kernel.org>
In-Reply-To: <20260701185235.4516-4-emil@etsalapatis.com>
References: <20260701185235.4516-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: Add arena-based bitmap data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 19:38:38 +0000 (UTC)

--===============8390509962774880332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> new file mode 100644
> index 000000000000..cf6b63f5d9a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -0,0 +1,34 @@
> +#pragma once
> +
> +#define BITS_PER_BYTE		8
> +#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)

This isn't a bug, but is BYTES_TO_BITS() used anywhere in the series, or
could it be dropped from the header? BITS_PER_BYTE itself is used for
building BITS_PER_LONG_LONG, but BYTES_TO_BITS appears unreferenced
throughout the implementation.

> +
> +#define BITS_PER_LONG_LONG	(sizeof(long long) * BITS_PER_BYTE)
> +#define BITS_TO_LONG_LONGS(nr)	(((nr) + BITS_PER_LONG_LONG - 1) / BITS_PER_LONG_LONG)
> +#define BIT_MASK(nr)		(1ULL << ((nr) % BITS_PER_LONG_LONG))
> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG_LONG)
> +
> +struct bitmap {
> +	u64 bits[0];
> +};

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28541348016
--===============8390509962774880332==--
