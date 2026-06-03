Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73095376BEC;
	Wed,  3 Jun 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483285; cv=none; b=htkIQaRyE2g2IWhHqfN9SAC+RqT26BrJGCD9kRAVwLjuo66pMe/BnpZM2/cBg3xM+SpyB/ns0ybwN/TG9mlSoMKgCaKh3AOapVzZsgMbyC5i95IWXise3ifvaN4zYU8h1ioUZxD9nwX1iqjBCFAHQRbOGeA7HktigbcyaASB4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483285; c=relaxed/simple;
	bh=g6HDe79wB/oCesWSJJrmnsqb7eV9mWH2J5I4ICar1/w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lCcGPELDlFE6ouN6++SEfpBiK7pPoLohvmM93d7wRQN4qwMq9H6mmWhwR5+7Ntbo4ik1bJSQTlKkP8xLpb2wkJ0dEa8Irqwt5mSZS4FiWewog9qXU6caCENAX0y5K+AnDQ/1Jw0KZJw3GU0+H1VgsAhdiU25i8roTCbJ42OkliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxBJys7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxBJys7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B931F00893;
	Wed,  3 Jun 2026 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483284;
	bh=/TuGeD5Jve17SZxHSLyVOcrWd165OE6zZCo+7OE9Ess=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nxBJys7FQyhXly+zo89zPkfrWq5gm3d/TyCxoFj4I3UsvHvxUBZfaOSMQ1M40WCFe
	 SiaQFmqBQOvm+d5lVk/7h2Rb7wUO2VEIq82XhTX46Yc+x9BfiV8VB8uA1yH7K79zG7
	 YxnfkEM3YgeGs3O2h+94gVX8Ed+erjVe4K5cCxGw4yl8JzmCl1xnrmIHQB62EElJ9x
	 6U5xFYz348tOtzTMRxV1PZkBifEGCAlCMy931Y+BKCrxqTpoEkC7S7j5quwE0SC9cl
	 oGIIgsMTyThiE/FUvk54JaINOu1E9pN8N2FYZ83H5sIge19Yq6gkVUF/6hKxevye8a
	 ZraxKump6K3fw==
Content-Type: multipart/mixed; boundary="===============1979031678491925245=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcec2fb5a8aeeffac9b199e86f6074b33daf27a1a0f52affcc1a6d50a3fad367@mail.kernel.org>
In-Reply-To: <20260603100438.2177817-3-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-3-zhaochenguang@kylinos.cn>
Subject: Re: [PATCH v2 2/4] LoongArch: bpf: Advertise JIT support for kptr xchg inline
From: bot+bpf-ci@kernel.org
To: zhaochenguang@kylinos.cn,chenhuacai@kernel.org,kernel@xen0n.name,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yangtiezhu@loongson.cn
Cc: zhaochenguang@kylinos.cn,hengqi.chen@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 10:41:23 +0000 (UTC)

--===============1979031678491925245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index f071d913e054..4f3aa53eda20 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2362,6 +2362,11 @@ bool bpf_jit_supports_fsession(void)
>  	return true;
>  }
>
> +bool bpf_jit_supports_ptr_xchg(void)
> +{
> +	return true;
> +}
> +

While patch 1 fixed BPF_XCHG (32/64-bit) to use amswap_db.{w,d} for full
barriers, do the other value-returning atomic RMW instructions also need
updates to ensure sequential consistency?

According to the Linux Kernel Memory Model, value-returning atomic RMW
instructions must be fully ordered. In emit_atomic_rmw():

1. BPF_FETCH operations (BPF_ADD|BPF_FETCH, BPF_AND|BPF_FETCH, etc.) use
   plain amadd.{b,h,w,d}, amand.{w,d}, amor.{w,d}, amxor.{w,d} without _db
   variants

2. Sub-word BPF_XCHG (BPF_B, BPF_H) use plain amswap.{b,h} without barriers

3. BPF_CMPXCHG uses bare ll/sc loops without dbar instructions

Could this leave BPF programs vulnerable to memory reordering bugs on
LoongArch if dbar 0 is not emitted or if the _db variants are not used?

(This was raised by sashiko-bot@kernel.org in v2:
https://lore.kernel.org/bpf/20260603102720.20CEA1F00893@smtp.kernel.org/)

>  /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
>  bool bpf_jit_supports_subprog_tailcalls(void)
>  {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26878707871
--===============1979031678491925245==--
