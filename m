Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017246D2C0;
	Mon, 24 Aug 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590947; cv=none; b=hX/C7HE4LMk7EqAfa0/ezBNfd1r76FxLLcd7pkQw36n0DZY4uTEA0vSRde7JyqPfPCpnUD8mhQx7/nOH4tGos/23cBeFU0Y3QxhR9GlVd7pW3j7p5uX7np/meGBPjlGcbZhIbXPOcIQHKZBJQpfxMZwqeKBKEu5R8Dfg+B1Xf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590947; c=relaxed/simple;
	bh=4NQ+tPASam+bub3Piu00I3hheuGyQKYpWkc0vd7V2bM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tLHinX9CdFLu6zz2nRNnGZHacvJg761+lCN3+Cno/3VWTe6ARclmwUS44N80kZpnW3VoItNBMM8VArp1HiC54dUQ+e/4mxzVHTvJGzvErYCu+y1R02pv2YUt7i4huNI8IXyctBcdq7D5oKni49O2AdsKE6DgQcOTE7JTvZ42CC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAo04CVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAo04CVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E81F00A3A;
	Mon, 24 Aug 2026 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590946;
	bh=Po/EBS3/pNf6ny6UA0CtZDiiSC2hgFFm/KHvckMz5gA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IAo04CVth6uyxcjPKlt91Qrgesgnkvlji/G0fZ3OCqWiB9lVZITWQSjCMc+mtJnRV
	 pc7/otIbLaaTKlB3uoPXtc3rKm27sdsspaQEr5ExO94i4aAKIKexBR9GIsJ1JoGHI8
	 1UmVnA5mY9Ebw6FUu3dBpMdBhOaFIRmNV73dMF/+9kwXN2e9MRiHTd6Esp6I9hjon6
	 HNgOTfcQpEVsfTaf0nD6rXfdnP4BfWWd0u2I2V39ePN9j98/wnKhet4+lebEaIYbqs
	 T1eN0e3IA93evY/loedm3lnqyszPp51jEJG+63KpYUrZuKtWx7Gim29TuT/2FQaz8u
	 16wrS2TMS7XkA==
Content-Type: multipart/mixed; boundary="===============1021056670152118957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a154e55437095a325d5bd815f88d5ee61b07adcac8ed64e7f153dde1472340fb@mail.kernel.org>
In-Reply-To: <20260824160523.3907021-3-usama.anjum@arm.com>
References: <20260824160523.3907021-3-usama.anjum@arm.com>
Subject: Re: [PATCH 2/7] uaccess: Add scope guard for bare kernel nofault regions
From: bot+bpf-ci@kernel.org
To: usama.anjum@arm.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,liam@infradead.org,vbabka@kernel.org,rppt@kernel.org,surenb@google.com,mhocko@suse.com,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org
Cc: usama.anjum@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 17:02:25 +0000 (UTC)

--===============1021056670152118957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 7ae185467347..b25e778ddc38 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -653,6 +653,10 @@ do {							\
>  #define __end_kernel_nofault_bare()	do {} while (0)
>  #endif
>
> +DEFINE_LOCK_GUARD_0(__kernel_nofault_bare,
> +		    __begin_kernel_nofault_bare(),
> +		    __end_kernel_nofault_bare())
> +

This isn't a bug, but would an unprefixed guard name such as
kernel_nofault_bare read more consistently at the call sites, alongside
guard(pagefault) a few hundred lines up in the same header?

Every other guard class in the tree uses an unprefixed name, including
the directly comparable one at line 303 in this same file:
DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable()).
The '__' prefix is meaningful on __begin/__end_kernel_nofault_bare()
because those are arch-implementation hooks, but the guard name is the
caller-facing spelling.

>  /**
>   * get_kernel_nofault(): safely attempt to read from a location
>   * @val: read into this variable


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32751368606
--===============1021056670152118957==--
