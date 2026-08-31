Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08082D12ED;
	Mon, 31 Aug 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173002; cv=none; b=meyN9s8Iu4DaPP1vChP5rC67zl4TNLWaNntKBOdzVh/jc4uaREbjPWPxypITSrh9HN4RxEDoHOuuEtilK7r0EtYLn5itsAZMwkHKJsOnz1Xl5udWT/KbotkgQtZHmvOSbalS4O6uV+m8WlmoaQSbfxyxSujSrjK098IVObIM+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173002; c=relaxed/simple;
	bh=ug7bAlLKt3YpwNFxULh4dFtl98BUSdircIxJOXkRAbY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H4ZOgxxyvREYxQSWnYr/zkMs3sREvqnDHGVCuuLmMLAfk52GjR+P3WAkJ11NZSGIDSOWAznG08uMDuqkuYcb7YdtdV9MPvYpVka4ZpgVWuFbVsLia6NiprnNdcYhL2hyZUY2CGZi+rbrRGsBLGk/XsUpilFCQXPrMId0KVIjos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxDv0P+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxDv0P+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1101F000E9;
	Mon, 31 Aug 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173000;
	bh=MIt3VgCTlKr0UD2zCebrs70lbSFzbpSN9wJEPrwNXAg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OxDv0P+yxaBAXiwD0OBwDSNFCk78n2D5JDu3hoGe5vXjRm0auREjUOoheJKZjVxlH
	 bm7iCMJgN4Ut4WQ00S+ZqAmvjJQufY+5oyRp+Dj8sNVyhxGpq6Dvte+MLKMeUWEE7m
	 KHrlGQZh3uEEMFnQrIn/ZoYp4REMeRnXLVsC6JmlVnb60bstoyVMA9sEvikEXoO3rP
	 PQR7iy3xBGIMsgy7HuvyDtW+pNH/0m2rurgylRPpzhEstCyULSQedmDRQQatLEopq3
	 SRIEei6zEwm07sL9tS6yHypptiM/mZPR80zLABNPkupvc5upoHKU7Ohm8bK0rOEEQh
	 uPiMO4phUbElg==
Content-Type: multipart/mixed; boundary="===============3851992486102112929=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a28fcf46a2cf6d16bbfc7b814c323b846c8774111393ad02c1b30cac2e66493@mail.kernel.org>
In-Reply-To: <20260831092305.42062-5-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-5-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Allow reads through trusted-or-null BTF pointers
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 10:43:19 +0000 (UTC)

--===============3851992486102112929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow reads through trusted-or-null BTF pointers
>
> Currently, a trusted-or-null pointer
> (i.e. PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL) has to be checked
> for NULL before it can be dereferenced. Marking a field from
> PTR_TO_BTF_ID typing to trusted-or-null can reject programs that
> previously dereferenced the pointer directly. This is useful as we
> need to mark new fields as trusted in order to pass those as arguments
> to kfuncs.
>
> This patch adds support to dereference pointers marked as
> PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without the need for a NULL
> check. We define that those pointers can fault on dereference, so
> reads need to happen through BPF_PROBE_MEM. If the dereferenced pointer
> is another BTF pointer, we clear trusted flags and mark the result as
> PTR_UNTRUSTED.
>
> This applies only to reads. Other cases still require an explicit NULL
> check. After such a check, the pointer retains PTR_TRUSTED and can be
> used normally.
>
> To summarise, before that patch, reads to PTR_TO_BTF_ID|PTR_UNTRUSTED
> are allowed through BPF_PROBE_MEM and reads to
> PTR_TO_BTF_ID|PTR_TRUSTED are normal loads. This patch allows
> PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL to happen through
> BPF_PROBE_MEM.
>
> The unchecked read path has two consequences:
>
> 1. It uses BPF_PROBE_MEM, which is slower than a normal load. An
>    explicit NULL check refines the pointer to PTR_TRUSTED and allows a
>    normal load.
>
> 2. A faulting read returns zero, which is indistinguishable from a
>    legitimately zero-valued field. Programs that need to distinguish
>    those cases must check the pointer before reading the field.
>
> The next patch updates current tests and also introduces more checks to
> ensure this change does not break anything.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

This isn't a bug, but could the changelog use the imperative mood here
("Allow reads through PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without a
NULL check") and drop the "To summarise" paragraph, since the preceding
paragraph already states the before/after behaviour?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33379004067
--===============3851992486102112929==--
