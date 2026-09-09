Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C670809;
	Wed,  9 Sep 2026 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988307; cv=none; b=DPlrJ7MZHc4BadjEZw3YJhFrRuBlrfSU7Yl0QALlLeuX9QSK2uqAr97k+zxTkGzd2sipjmKMc4aEEUjVrN3pre8dgk9xFGFoh8YEzuD3NpgjGcWh1MrHmqCL5nW9ID+T2Ur56aZBm8K2MEKYRdz+PjLo2BiOIZPO+7NGApPPvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988307; c=relaxed/simple;
	bh=GUoT4KzhJ0ptKTRFixl7KlEZxiE5gKxOkKNPBs6qT9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=is9EHI4baX51hmzFpglRGddDuj88sPYuMD/sPP+R7+PjL165g9MkJ2Udz7pUofyx8ULlj5AvBy+djpXZznaqSBxFe8yMvs4es9vPaM028T5LNzjm296boixKUvCjQ0QWryuMgsFe2n6KZfZ6d78HbVqgEHptI5EG4KmyArwWnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=LYStQf7Q; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="LYStQf7Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=GUoT4KzhJ0ptKTRFixl7KlEZxiE5gKxOkKNPBs6qT9s=; b=LYStQf
	7Q6uPWWdMGqzOeGtMLo/Y9asjziM5rg33zNU7ru+n0zGoja9Pt7rc6ZAci0StHobVVcH9YptEQdRd
	D4n35WhFBkTgWnf8D/LAQ+RVZPshfgiAmxOGJrfhr9lL8aE5VkOEMnTl69tw3cBfSFqArL8GUazQP
	wZj0j3vt0TUYmaS6vNvC/By8l5T9crqLiyzcZGSSc1XdgUa8ypkdeSjsDNUB6aWaedDz07Cb21ssO
	gECkD3M0LZx3aczbS5vO7bzSZ2OpGzO1XNJqmZBMEuDP+qEo9cNaYV28DI3Qd33hJauKGekKT4R4I
	4aCtnWTYjWtpqgEgwqVVK5iqE6Mg==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1x4OYL-00000004Hxv-1Xph;
	Wed, 09 Sep 2026 20:05:53 +0000
Message-ID: <6f1db74b0bfb6c67fbea7e2dbcce72c4ceb04f61.camel@surriel.com>
Subject: Re: [PATCH bpf-next v2] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
From: Rik van Riel <riel@surriel.com>
To: Josef Bacik <josef@toxicpanda.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, Brian Vazquez <brianvv@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, "Jose Fernandez
 (Anthropic)" <jose.fernandez@linux.dev>, "Paul E. McKenney"
 <paulmck@kernel.org>
Date: Wed, 09 Sep 2026 16:05:51 -0400
In-Reply-To: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
References: 
	<20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 17:51 +0000, Josef Bacik wrote:
>=20
> Plain cond_resched() is not enough either. It is a no-op under
> PREEMPT
> and PREEMPT_LAZY, the only models arm64 and x86 have offered since
> commit 7dadeaa6e851 ("sched: Further restrict the preemption modes").
> It is also never a Tasks RCU quiescent state, in any model: the
> reschedule counts as a preemption. The walking task stays a holdout
> and
> stalls every synchronize_rcu_tasks() caller, ftrace and BPF
> trampoline
> teardown included, until the syscall returns [1].
> cond_resched_tasks_rcu_qs() is the usual tool for that [2]. It
> reports
> the quiescent state at each yield and still reschedules as
> cond_resched() does on PREEMPT_NONE and PREEMPT_VOLUNTARY kernels.
>=20
> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Link:
> https://lore.kernel.org/bpf/20260715215314.44423f47@fangorn/=C2=A0[1]
> Link:
> https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-=
laptop/
> =C2=A0[2]
> Assisted-by: LLM
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>=20

Looks like you got an RCU quiesce in every path that
loops back.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
