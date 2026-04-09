Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C192309AA
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701579; cv=none; b=rzVk8GurWI2z4VzWkWu/Q0CKcdnFWTHqnhUW9rY5VXp5s5D1hXOp44OnK7XcWuu7flRLdVB+RjhUobGba4B9Vc83fX6IAizC7tD+O8ul8orJeRczC1SrXjxWkj56LBdNxtnqjWPFzuy8efrpGL95T7UHuJe5zeRNF/S1aJnzxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701579; c=relaxed/simple;
	bh=IQsclcGALKCbMKdjzMzKpJbzOxXUv4E6GsmBANRb2s8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Is3/hyX5smGBZpaZD6u7ARzZmX1SK4gX4V8sB2X8gr92QSe4eA3KXtvIX+wxtbt3V4kYHNNdOxeAwhYk+3zFQypKwnOMgHrJKdouKkDFwdTtH0DLCgcZS1UItBEqWVaHBiX5BSVAbFxN3Tbb1aWVBeYNdQMgDsg39PFesi7PL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7BBFv8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7BBFv8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64861C19421;
	Thu,  9 Apr 2026 02:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701578;
	bh=IQsclcGALKCbMKdjzMzKpJbzOxXUv4E6GsmBANRb2s8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R7BBFv8vGzCMSl6lc5Er50a9FCXAjnZQUoANzC7vKJGMvHNAvFOLI3SzREbNMQpUe
	 ma04SvMokTq7OZdgd9t9J+xO0sskM4Stp0WpexT/5ZcYuf4yaEXqMt3jmOjXRcIFzX
	 GjCQeZfF5Yrh0d3ItT1QR42gmm8aPMGejVnTztiiFqdukX0vz83ZOoBxg3o5tpmy+D
	 t+HwRA1R4sJiAKZUVFY2ZHcTXEUxlgGU8AZQW+zvDgvJSrhjHyFe79FoySASM09l9D
	 7WSvwMYbMv6cDSERVP0B4cOkJetd4pqPtGhoNJmn+lJjWPlMk3tvnmrMlzZaqSFr7l
	 qwOEwp97u1iow==
Content-Type: multipart/mixed; boundary="===============5269330392652719733=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebe2561af12fef3888da2ac17b7da0735be644338ab28369a4f162a117db3b80@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-4-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-4-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 04/14] bpf: make liveness.c track stack with 4-byte granularity
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:26:18 +0000 (UTC)

--===============5269330392652719733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 998986853c61..9e36ea5f2eec 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +/*
> + * When both halves of an 8-byte SPI are set, print as "-8","-16",...
> + * When only one half is set, print as "-4h","-8h",...
> + */
> +static void bpf_fmt_spis_mask(char *buf, ssize_t buf_sz, spis_t spis)
> +{
> +	bool first = true;
> +	int spi, n;
> +
> +	buf[0] = '\0';
> +
> +	for (spi = 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
> +		bool lo = spis_test_bit(spis, spi * 2);
> +		bool hi = spis_test_bit(spis, spi * 2 + 1);
> +
> +		if (!lo && !hi)
> +			continue;
> +		n = snprintf(buf, buf_sz, "%s%d%s",
> +			     first ? "" : ",",
> +			     -(spi + 1) * BPF_REG_SIZE + (lo && !hi ? BPF_HALF_REG_SIZE : 0),
> +			     lo && hi ? "" : "h");

Is the ternary condition here inverted? The lo bit (spi*2) represents
the LSB / lower-addressed half of the 8-byte slot, which starts at
offset -(spi + 1) * 8 (e.g. fp-8 for spi 0). The hi bit (spi*2+1)
represents the MSB / higher-addressed half, which starts 4 bytes
higher (e.g. fp-4 for spi 0).

With the current expression, when only lo is set (lower half at fp-8),
the +4 adjustment fires and produces "-4h". When only hi is set
(upper half at fp-4), no adjustment fires and it produces "-8h".
This swaps the two half-slot offsets in the verbose log output.

For example, a 4-byte write at fp-8 marks the lo bit via
spis_lsb_half_slot() in check_stack_write_fixed_off(), but
bpf_fmt_spis_mask() would then print it as "-4h" instead of "-8h".

Should the condition be (hi && !lo) rather than (lo && !hi)?

Note: this function is removed in cc55f39c101d ("bpf: change logging
scheme for live stack analysis") later in this series.

> +		first = false;
> +		buf += n;
> +		buf_sz -= n;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============5269330392652719733==--
