Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856112459C5
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491789; cv=none; b=gSPqIKHxPt1bS1nGEieH/5FNebQDnG3nTWKprPRo1ZBgM60kDcacvINVV2kUVShsPK83lelI41DMsllmamNmEAAchVby4LEsTjQ3fwAXJuUtXTHG+wzBYDHMBAkJVYrIHINXEOwcCkBajcC1Su+/6Gmkj736BJExMqAACgrnhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491789; c=relaxed/simple;
	bh=znV0qOImaIbwJ3lzkSgO1ldSMmE/YarnWTDfWKlgzd0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SOXb4WxJDm5Dh0P6b8mayFMymq2n2p7tyw/hsZYwjcBkytdeoEMjJ2gx7fIAvFjZjaqTnUG2tZLAM232VPj+jfxEg0Qx0ypF65EdmxTpobd97Ab6coObGHihyH2CjCGzmffeS/Gv12otaxOJsnZBbfk8HRMDUdUdw2SjyWtxP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctxqfScq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctxqfScq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43AF1F000E9;
	Mon, 15 Jun 2026 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781491788;
	bh=WtHmvXsyqlt99m+2BhnfdbMt47wfZfe9drYUtMG/6/s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ctxqfScqQbakseC5QHsvq/qqZzfGwmiiwN5NSZf2whs9nw7pp8quhnNa7SyMeNkNw
	 mjrBds93o3Zir6WlwQ774H9Enk06slXG8NYeReo33BP2LncN5MuKk+PWRkXjXIqC3U
	 fw7oOLjpVWkCBDsIMEdGw72CL0sQAHmyx40SENP4K4DQBj01vOWcCemTHe4LAFiVov
	 YR2SDV8iXGi5unkk7BP617cVRPPk+8KdUbvEtevL1H9f2lQg1p+Jf5ICSFEobH8tkO
	 gk65VNwl+NVh6iKZs/NMnPTO5m//ImHJfdY1eYI5xyE3G7e64P1W3fLIguJj6b9xdU
	 TOVFOcgZtq8cQ==
Content-Type: multipart/mixed; boundary="===============0456616277806906634=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e79bc5a7b24d6d92f1eb959d46518377e51e340bb09f2572c6a387b0f220f339@mail.kernel.org>
In-Reply-To: <20260615021959.140010-3-jiayuan.chen@linux.dev>
References: <20260615021959.140010-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/6] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Jun 2026 02:49:47 +0000 (UTC)

--===============0456616277806906634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2872,7 +2872,7 @@ struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>
>  		psge->length = start - offset;
>  		rsge.length -= psge->length;
> -		rsge.offset += start;
> +		rsge.offset += start - offset;
>
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

This looks correct. Would it be helpful to include a test case or
reproducer with this fix? Jiayuan Chen noted in the review discussion
that it took significant effort to reproduce this issue, and having test
coverage would help prevent regressions in the future.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27520503350
--===============0456616277806906634==--
