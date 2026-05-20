Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861363AC00;
	Wed, 20 May 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311217; cv=none; b=Zi1p/JPQk/gKP8kiRQIi9IKQEgn1llYFZpQF/Uo+waDtitMCVGxEmuezmZFPBBXeEReDd2SzTGum03+OMp4RbhMkIj/lqd4xvtAmNn0XBCcmCdCk3MH7TfLbga5jAf1HpkWws+DgpjzAE8Ca3awqiH/nQTIX9DXysjw2fFxIVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311217; c=relaxed/simple;
	bh=uKm5s5kMt9Mfwf1RMP9Sx3TkBYcz8atw92kZLg8oxak=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LfAoaXty2DOF+o/3FShonP29ucJcB4q30pRJqz5JZGAe8UCUHD+cVa2WLuMmI5qYhrkWk/caMFJ03NsMEobdUJnOGoVBSC/ePYNEB2m0GjYIGW8cTVWTgyEnWOJVDbtBRXYp2IhUz4iZZU3vdxQ/8w+NqAY5JUN0E3tipF8MLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXpRUuRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXpRUuRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036531F000E9;
	Wed, 20 May 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779311216;
	bh=E54m0vPKwml/JCeVyk46PYZjEMAFgp/2ycATfjyhhV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NXpRUuRGE4hFboclbq160ixefJUJCweZwpwlb4HBiJPA5WUcyBBnDvcX2R+ROrgsm
	 FLVvyageiQVnmNZYuTeXNtBU+1XLhp3bBNYT20hx+YSmtd+n2ODf+CIoXFz5A3/wvY
	 qD7pdP2fEJMF+ekQHxs+hvVFtFNyFh6I08hSJMJZqqpi4J847pESUCkDOHvzwIirQb
	 7mRWaO8xhEXYJKm0n7307B0wxN4Zr4i8zh3hMDC8vt9a2ilOUHzR1td/2MkLb6/cl8
	 ZF8S6YF9jtuzV/POw6exg9Tr1Qf7U8hhWCZMJYPwJ9Y1OfCd1+stoCcGVFfm5IaA/3
	 ynq7p5ZfGGjcg==
Content-Type: multipart/mixed; boundary="===============4961839549319086560=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32eaaf708c092e71f7848f2e55d09050fc3bd05f9da2aedb7adefab64648e6ce@mail.kernel.org>
In-Reply-To: <20260520203318.31939-1-meatuni001@gmail.com>
References: <20260520203318.31939-1-meatuni001@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix zero batch_hash on CPU 0 after batch_gen wraparound
From: bot+bpf-ci@kernel.org
To: meatuni001@gmail.com,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,meatuni001@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 20 May 2026 21:06:56 +0000 (UTC)

--===============4961839549319086560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> index 13777b3dcac8..816880c1cd5e 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> @@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
>  		__u32 *saddr = data + saddr_off;
>
>  		batch_gen++;
> -		batch_hash = (batch_gen + bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
> +		batch_hash = ((batch_gen + bpf_get_smp_processor_id()) | 1) * KNUTH_HASH_MULT;
                         ^^^^

Does forcing the LSB to 1 with '| 1' inadvertently destroy the lowest
bit of entropy from the batch generator?

Since batch_gen increments sequentially by 1 per batch execution,
forcing the least significant bit to 1 maps pairs of adjacent values
to the same number.

For example, if the CPU ID evaluates to 0, both batch_gen = 2 and
batch_gen = 3 will yield 3 before the multiplication:

    batch_gen = 2, CPU = 0: (2 + 0) | 1 = 3
    batch_gen = 3, CPU = 0: (3 + 0) | 1 = 3

Could this cause 50% of consecutive batches to generate the exact same
batch_hash as the previous batch, causing those iterations to hit the
warm LRU cache entries that were just populated and defeating the
purpose of the cold_lru benchmark?

This concern was raised in Puranjay's v1 patch where he used XOR instead
of addition, and he acknowledged the issue and switched to plain addition
in v2. This patch reintroduces the same '| 1' approach with addition, but
the entropy-loss problem remains.

Referenced discussion:
https://lore.kernel.org/bpf/2afdea40f0c5a11c2337efafe6f460899d85bc28650e04d5e0b9ceb35f3ad9fc@mail.kernel.org/

>  		if ((void *)(saddr + 1) <= data_end)
>  			*saddr ^= batch_hash;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26188863722
--===============4961839549319086560==--
