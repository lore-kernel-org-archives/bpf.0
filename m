Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A0225775;
	Wed,  8 Jul 2026 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482543; cv=none; b=Rh9Ycer2mE41WYDG1aY8kvFOUsOZt0A3UzITT8FswrYxIWrD0aO1k3gff5X/GcxENv81nk8GdQSURKZLHfEHcY7aXxR4NHXzTZd1VqGkoSRhJxbjJDj5WABoxgBGZw9swya+JzXWSWvNTRVUekUQL+tEFOpJt0DbbEISzzsyc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482543; c=relaxed/simple;
	bh=GgEn/+I8sy/BjjtWe8vo3bNHN2q3UJe51U2E/ajbzKw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NGnfTstqydcb7n7u/ZCuMcSpd/NSMDbYROIh2mKxjGDTh7w3WzBFB5M1iwTJtXvLwrn5+j1RYaGQEz560hDPoAPEbE1SDFg9+B7DycZvKoGMj4RzAqTvjc0RMkOwhc5y6E0BZc6npAoi/Mq7/6mun5s0hXLmQjwyYRVxClUHABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXKHz1a/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXKHz1a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C61F000E9;
	Wed,  8 Jul 2026 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482541;
	bh=demOWs72DQXcUcVol/P2x9dCCazEIJdn7cOo2EXPADU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NXKHz1a/bjIdxXH03GFRPNVsbGtJTZyYx3P2zGyACrgR2YgqTppogmIDCy0uBXTOF
	 s2cz3QFY4U4YoVvw3dRx7Jy9JnRyYSi48LBAItRndFvr9sbQS7y4p3dgAFtjdMXRs3
	 hGkecv4luagVeWHlxj1W7ESNfo3TogY50XWh7NnqnAcTTuz7fE/vdu9J4TEPwTpUEP
	 iGi0j/zpYRNuS1IrE17Y3PP6+j4yAV1tkbV8EKV+lpp3XkK508TdEyV0Ae0PC06NN0
	 2Vbe2o8XLoUR02PGH9G7PzIFKz4vfagkYkNZ3sLIq1Wte2tGXF5qaJ+ZRfEaPeaCjv
	 X3cn6iT872weQ==
Content-Type: multipart/mixed; boundary="===============3117783219876862957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <806266240f4dc8a44be70cc8abac6111fb15405c657d706f6045522e05746289@mail.kernel.org>
In-Reply-To: <20260708025807.702010-1-lgs201920130244@gmail.com>
References: <20260708025807.702010-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] libbpf: Limit bitfield dump reads to checked bytes
From: bot+bpf-ci@kernel.org
To: lgs201920130244@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,varunrmallya@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: lgs201920130244@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 03:49:01 +0000 (UTC)

--===============3117783219876862957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 53c6624161d7..d82e8e425203 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c

[ ... ]

> @@ -1784,13 +1788,13 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>   * stored in num, then we left/right shift num to eliminate irrelevant bits.
>   */
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -	for (i = t->size - 1; i >= 0; i--)
> +	for (i = nr_bytes - 1; i >= 0; i--)
>  		num = num * 256 + bytes[i];
> -	nr_copy_bits = bit_sz + bits_offset;
> +	nr_copy_bits = bit_sz ? bit_sz + bits_offset : nr_bytes * 8;
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -	for (i = 0; i < t->size; i++)
> +	for (i = 0; i < nr_bytes; i++)
>  		num = num * 256 + bytes[i];
> -	nr_copy_bits = t->size * 8 - bits_offset;
> +	nr_copy_bits = nr_bytes * 8 - bits_offset;

Varun R Mallya asked in v2 for examples that can break the older
implementation, preferably with an ASAN report to justify the change.

Could you provide a test case or ASAN report demonstrating the issue? Without
demonstrable evidence of the OOB read, it's hard to evaluate whether this
change is necessary.

The previous review is at:
https://lore.kernel.org/bpf/akugPNylTrOa_bNn@computer


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28914496440
--===============3117783219876862957==--
