Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166123EFFD6
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210898; cv=none; b=AtDgtsqdK7TwUUeUkU43i4a1NkCCxuXqjFwLF18Htk9oG9LyIGHmSsNouEIYDrxbR5nviVtcatgXNbYAwg7HMsRU5OoEjYiVEApKg/rCjx98SaI+OE7RXECbiklgTnDree4wV4bnyxH+Pi41fbnYQTq9BNkFRFXmyBYY+4YMDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210898; c=relaxed/simple;
	bh=v+8+THsiQ+JGWlbKGg4Jfj6Y4acNA1mRPE3nwjflLjE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=re81lxSRZexS1JotoJdTBlgwoXGajQ+zAGXXR42CxM7+l3m7uA4xSE4YfoI/iL+22rZE+d3comTTPTgyWk++mBHRyntShwaR6IgEFotH1NEt36lGsgw34TGVXMLR6FaWaAHdVF2tnvcnj6Szi575HWupNBFC2R7JflfEERs7mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/W3TMP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/W3TMP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D3C4AF0B;
	Tue, 19 May 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779210897;
	bh=v+8+THsiQ+JGWlbKGg4Jfj6Y4acNA1mRPE3nwjflLjE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O/W3TMP129U7kd4ZmIwS01cOReIp+BPq6JNZreGW9rYLxjIHwdL+wxujgjUo9rDY1
	 HnrjDvUbSAtnOyfYg4C+tWGRroo97QKAtwXdXRziAmslZ1PMlS7Cq3ErZIOhVRTCfX
	 wVqWl4NV89u3UHZomIoNONjZ7DfCso3sBLU63cIWMGXxZ/XDaThXnNFY9izDDxMlg9
	 aqKeMGPodURZdkwuhb8PCUPIMgl6cDobLzTwmXgn9sip0kPa1lptUr7iEIZroSFACC
	 l2wFSId8YkNzcTlEDjydCckRcbLVjgbxtrKM5/Esux++6bcLO8fP2LzXEEQ3wjLdiA
	 OZba5pBJsAF4A==
Content-Type: multipart/mixed; boundary="===============8230685369894232359=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2afdea40f0c5a11c2337efafe6f460899d85bc28650e04d5e0b9ceb35f3ad9fc@mail.kernel.org>
In-Reply-To: <20260519163632.2220753-2-puranjay@kernel.org>
References: <20260519163632.2220753-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 17:14:57 +0000 (UTC)

--===============8230685369894232359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> index b9fd848c035d..f40e36aa183e 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> @@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
>  		__u32 *saddr = data + saddr_off;
>
>  		batch_gen++;
> -		batch_hash = (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
> +		batch_hash = ((batch_gen ^ bpf_get_smp_processor_id()) | 1) * KNUTH_HASH_MULT;
                                                                           ^^^^

Does forcing the LSB to 1 with '| 1' inadvertently destroy the lowest bit
of entropy from the batch generator?

Since batch_gen increments sequentially by 1 per batch execution, forcing
the least significant bit to 1 maps pairs of adjacent values to the same
number. For example, if the CPU ID evaluates to 0, both batch_gen = 2 and
batch_gen = 3 will yield 3 before the multiplication:

  batch_gen = 2, CPU = 0:  (2 ^ 0) | 1 = 2 | 1 = 3
  batch_gen = 3, CPU = 0:  (3 ^ 0) | 1 = 3 | 1 = 3

Could this cause 50% of consecutive batches to generate the exact same
batch_hash as the previous batch, causing those iterations to hit the warm
LRU cache entries that were just populated and defeating the purpose of
the cold_lru benchmark?

Reference: https://lore.kernel.org/bpf/20260519165140.12529C2BCB3@smtp.kernel.org/

>  		if ((void *)(saddr + 1) <= data_end)
>  			*saddr ^= batch_hash;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26112027147
--===============8230685369894232359==--
