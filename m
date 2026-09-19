Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376D23D297
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782167; cv=none; b=FJD6/i2KYLq3SLjsN75zrDJuGDwncHZkt39wQsLWGgjmlgDsUg40bThhwf7L2qAaxcokN5+CO45/56uczvAqDsz/gWRG8sugPD+kLn0mdKEv+kmWja0BW0SQSQleXrMhNYXoo8CYjC5nRgXPeuzXQdUA//JcowZrEwh1ar1FuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782167; c=relaxed/simple;
	bh=MTgOI8Q692pR6CXWgEd47aj34p26mZFuKMARVhNO1Ag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rqiWfxart8HrxMa82hGESroFmHLjxHwRk4FylaaCiKnYUONgK0tJVrTmZHyRFjgLnZGLzUCo4Q6c7+mAhre1QeSE6NYk7hILeC0IvbqeGElkTbd7YD1NNh616Kr7anRaM24kAd3Lo6U5uALCRC/BTET6o0w1g7lYf0sSKJzb97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR7c8YHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR7c8YHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8C51F000FF;
	Sat, 19 Sep 2026 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789782165;
	bh=ACY2hicVDo6Rc72dBmkMINBZAYh+gvY/W3Xrhy5+dpw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KR7c8YHyGDnHqPPvNhPvRLn++x6ePISRH5STLzzliNdelN1LJ64qo65O3njFUS9lE
	 NMUYaHMKnnacUvL0eePuFJAXZo5Tf+qA9+pVm044RmIwZVEqyqbzMNKZjl17AO4o7c
	 TUek7uJhdub4nLDW02XLcDbDdSswJ91NYi76qmTmNROkbRykgIk7b7yIri2EhHlRMd
	 blO8Xx1UD9lNcP7eWBzTAPquOg03f99avcE2a3DS7ZAoka3URvitZ7qs+lI7Hoc8g/
	 MM/XYxNlgQK/InfkZqxt1DrdHDR7HI8hl7CtuN8Knv8f/AQxP2kLo/jHJ3xMJiDH58
	 NWbNACTikdxIA==
Content-Type: multipart/mixed; boundary="===============0892532250352779811=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4eecba505001ba8b9cd025603697aad6909aadaecc45000e8750d85b5119fad@mail.kernel.org>
In-Reply-To: <20260919004327.1403382-3-memxor@gmail.com>
References: <20260919004327.1403382-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover frame changes in bounded loops
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 01:42:43 +0000 (UTC)

--===============0892532250352779811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
> index d248ce877f14e..48a966cda199b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
> @@ -303,4 +303,40 @@ __naked void maybe_exit_scc_bug1(void)
>  	::: __clobber_all);
>  }
>
> +/*
> + * The loop reads zero from the caller's stack on its first iteration and
> + * one from the callee's stack on its second iteration. At the loop header,
> + * only the frame number of the pointer in r1 changes.
> + */
> +static __naked __noinline __used
> +void loop_stack_frames_reg(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) = 1;"
> +"1:"
> +	"r0 = *(u64 *)(r1 + 0);"
> +	"if r0 != 0 goto 2f;"
> +	"r1 = r10;"
> +	"r1 += -8;"
> +	"goto 1b;"
> +"2:"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("xdp")
> +__description("bounded loop changing stack frame in a register")
> +__success __retval(1)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void bounded_loop_stack_frames_reg(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) = 0;"
> +	"r1 = r10;"
> +	"r1 += -8;"
> +	"call loop_stack_frames_reg;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";

This isn't a bug, but the subject says "Cover frame changes in bounded
loops" (plural) and the test name ends with "_reg", which reads as one half
of a pair. The verifier fix this accompanies (ccf21c431c086) explicitly
notes "The same problem occurs when the pointer is spilled to the stack",
and that spilled case goes through stacksafe() -> regsafe() ->
regs_exact() on spilled_ptr - a different comparison entry point than the
register case covered here.

Would it be worth adding the spilled-pointer variant too, so the
spilled_ptr path through regs_exact() is covered as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35410977924
--===============0892532250352779811==--
