Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394B415F22
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502190; cv=none; b=EOCfZCe82wiiHK3yxW2saHNKXGlqrN4yh/Ti6VrbLtWT6H/FyfYZoHpWp3LmX5/eoPR0JZgS2az45UDzqdsr0y6E2mMs6t9qaejE/Cii5pUrDdS6RL9XewylB00fP3joWYEAQJlKn82QBADk5fPBkhO2HSnsL8JeUb/1lu+YOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502190; c=relaxed/simple;
	bh=xetbWwyyOnMmrIXZ4AMthfK2uHz9ESR0Ciz7rkXPvnU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NWUkizU5hR4dbPtAxh1+b9x2W3eFC6QdP8tnHt7DlwIMsfwleMLVa3HOyaJIDqiTIfkRydpVWRY3jZgiqCgur40PRNs1gJq8Hv7L8/Y27MRJeNQXI7d1+tJQsvPf+xAkA7djg+TptSKgPlAz75Lo5lFpFCgaOzSkft0yj4b6BxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQyVxLtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQyVxLtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E781F00A3E;
	Fri,  4 Sep 2026 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502188;
	bh=23+y1FOeV6gLVAzsWahT6F2Hueq6E8nF1+OOxCn3GLk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XQyVxLtLWKzQw0IkRJxxkAyO2sx0LBFoEseJuvlqY6QycPtZLus4+bmSykCdbGRt/
	 wSsiEpsq5tU5lMnhqGv1PFo+GbBbIrZmhwoFuZGf6HFNbIKOBRoxwnWC/r+2zxhx+7
	 OHAEtYv4sLwqUc9pgQ6bnnyA5uDvTTRsU+LjVNRjMyo6RMs+ouhZELa6ZvVhH1d/5w
	 FSEOJVswAAoM0Yh+qe652Xa7OlC6tQSHHbrEzUhb1EfkxKb9Ub72jhgPYmrkQQ1npH
	 L88Irzv5I0M4hgZv5Zq1TyGJMrW8lFv1LMmX0DiHJ8wCuCJ4Kodl6wDzFUIF41prTZ
	 OtWzMralCvwVg==
Content-Type: multipart/mixed; boundary="===============3437268227977362249=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b138867c4eb9919dddb35a674224d5346c809970749a5a52f378fbc3ad19e376@mail.kernel.org>
In-Reply-To: <20260904051013.3978240-1-yonghong.song@linux.dev>
References: <20260904051013.3978240-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 03/12] bpf: Support by-value struct arguments up to 16 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:48 +0000 (UTC)

--===============3437268227977362249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A global function taking a struct or union by value is rejected today:
>
>   Arg#1 type STRUCT in tar() is not supported yet.
>
> A struct of at most 16 bytes arrives in one or two consecutive
> registers. Currently, the struct is composed of scalars.
>
> The slots of a value are independent of each other, so the compiler may
> split one across the last argument register and the stack, as in
>
>   static void f(int a, int b, int c, int d, struct pair p);
>
> or place it wholly past the registers, and the verifier describes either
> the same way. What has to follow the slots is stack_arg_cnt, recomputed
> from the slots consumed, together with the "no stack args in global
> functions" and JIT support checks.

This isn't a bug, but could the wording be more precise? The phrase
"Currently, the struct is composed of scalars" reads as a statement of
fact about a particular struct, but the code enforces it as a requirement
on every by-value argument through btf_struct_is_composed_of() in
btf_prepare_func_args(). Would it help to say that only scalar-composed
structs are accepted for now?

Also, the changelog doesn't mention that sub->arg_cnt changes meaning from
the BTF parameter count to the argument-slot count, which is the reason
the kernel/bpf/verifier.c hunk is needed at all. Would noting this change
help reviewers understand the verifier.c modification?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============3437268227977362249==--
