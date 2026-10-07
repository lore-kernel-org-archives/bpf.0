Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D053FD960;
	Wed,  7 Oct 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398737; cv=none; b=g1mSxeVOgbZId5uq2sMDveuJFtvk6cl8Y+uDayC6FbAo1FMhV8QpNd3d577lDerUhhSO71JGlgPNcbsXpTJF6+0RHA4mDV7iV7QAvHdLLWpEEXGRH8SSttOpgijvE9dtRwvlp6xgnwFtu9dJo7leHey0PlU52CH4tEqfaS3fWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398737; c=relaxed/simple;
	bh=4NvZwkDuxegacMnkTyzXcJczJEwWltlbMkMH2GUMUdA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Olo2jaW8ULQwxgNSxHxOAZae02zEYQlmN2FVcf+yBbIt1EyzhCVDRGPaVOJ4FxHmmMeC84IevbjdmjfcZkIgeMxQkAstprEVoUbZAi5/NWefHr+nS0Jso6pifVz2sEjgT8zlQZia62ogk2bimgpxbcESa+tqGrKYsItMtRxO77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU3Azl0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU3Azl0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D241F000FF;
	Wed,  7 Oct 2026 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398735;
	bh=PFlsxWZxbU0FjhvEcWoUwbSY3M7N7uIowCAm1NbEOwA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YU3Azl0tfuC+5sQkSdqnB/bCZpvfHJNxFC/fnf5e9NKyvWpsBtBpParXAgorB9maK
	 9gZor5Pe7x5FyzqRSuVig6loOBP4Q/xvHSEUl24sLefi1Ut7eiYb0f4Z7uqWxXAkq3
	 h+EkDMf4G7A5G3MTJpboNU6DOruCtVi3QKcLLusTfR03t0P7JZqOSQfurXqyAN2Di8
	 smt/PfvBq9vpDKt0PWN0PCYdc0Ha4FWGIB0nOJwFH0ZRSP366SCGWDjPJGfh1Pz1Bk
	 k5eBeMDLLai6DphSFWMZGJBM7Jh/gF16zesltmchXJ4GwJPpQcdsP/4KVwXp6P7wNB
	 vrzMO+VCk4YuQ==
Content-Type: multipart/mixed; boundary="===============2160530181907937439=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6ddac0398e54f73f0d424069145c6901d8d0ff3401fb160db0a9e3b281270c06@mail.kernel.org>
In-Reply-To: <20261007181249.352831-2-skokovmaksimevg@gmail.com>
References: <20261007181249.352831-2-skokovmaksimevg@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
From: bot+bpf-ci@kernel.org
To: skokovmaksimevg@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,vadim.fedorenko@linux.dev,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,skokovmaksimevg@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  7 Oct 2026 18:45:32 +0000 (UTC)

--===============2160530181907937439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

TL;DR: Nit only: the multi-line comment in bpf_prog_test_run_skb() should
start with /* on its own line, per BPF style. No functional problems raised.

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 513354e928cb..45718fa9adfd 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1237,7 +1237,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		memset(__skb_push(skb, hh_len), 0, hh_len);
>  	}
>
> -	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +	/* A helper such as bpf_skb_change_tail() may have downgraded the skb
> +	 * from CHECKSUM_COMPLETE. skb->csum is then unused by the stack and
> +	 * there is nothing to validate.
> +	 */

This isn't a bug, but could the opening of this multi-line comment be put on
its own line, with the text starting on the next line, as is preferred for
BPF code?

	/*
	 * A helper such as bpf_skb_change_tail() may have downgraded the skb
	 * from CHECKSUM_COMPLETE. skb->csum is then unused by the stack and
	 * there is nothing to validate.
	 */

> +	if ((kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) &&
> +	    skb->ip_summed == CHECKSUM_COMPLETE) {
>  		const int off = skb_network_offset(skb);
>  		int len = skb->len - off;
>  		__wsum csum;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37667470582
--===============2160530181907937439==--
