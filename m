Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C017A2FC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666899; cv=none; b=g32IdYz+6HzwbFEiJDDITehJeJgD+cMiqRFMo43dX4Kd+Mbpv9bkmbfXr9lhVJLwaC04H+AyvYIjIDxf59TCgodsZeKiJVrj4Ot6tGqkJ5PzjgzDZgiIBbAXEy9Q4AMiiLDNo4jk9NLhvGMLS0NtEfN43BoIs85Qqar+T5e/bZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666899; c=relaxed/simple;
	bh=llSMXw7G3kpnXsk5e6qj6SBgAaYcAM7nLPGGsUkX4YQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p0OgcooAuu/xG4rYNccFA+gS9oGGSIez/gnjLfKZeoFpKdrusZGhs/zsVwhBxt17HhIfZG2omY/tCf4Hmqvq5AJfK++rVAeOr6aOz/lNcFg8nTfrSTz6acBIJn8CjyCRFbnvopRe85DDuGeq/TynG42FVL6EjVPNeWFr/CZtdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5p8zu0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5p8zu0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E3A1F000E9;
	Fri, 14 Aug 2026 00:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666898;
	bh=whOIq62BFzpoHcpZWhrOUJKzqaBvWP1ErgiKZJphfZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f5p8zu0Epithta/p3NHNTLJly8g26xb6qcSi8HTrUqHaGUAsDI3SahYx/X2zXjLa4
	 5xOqSr8lBMlHxzufe/eCUNBsjn4NrxVKMsxNGyqqnz3VvcnHItcZ9nbxFN1UOvovVQ
	 SNAmdh3NUJ3ZveTito8JbJl8yKiAu6iegDv1mcpcrU5zveUFOAgypKzeAbwreLOqTj
	 jKUsVJFfj1vRqkSevVAGRTd9icxYZyKrfzdwSsWF8hINbFOw7DzsKxb+wfBY4s2Wjt
	 S7T7H5P1O7Sg1Un2fGs/wRw2Gznam6tW7UJ62sNcfnDC6O9mKrwe5ZaoEqTvXjso/z
	 1K0CQbuef723w==
Content-Type: multipart/mixed; boundary="===============4197804010435716492=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a94164ace11182f9ca7a0fb5e20375fbbcf5bbc51bda5d692cea3ec93a05b790@mail.kernel.org>
In-Reply-To: <20260813232943.581283-1-andrii@kernel.org>
References: <20260813232943.581283-1-andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftest/bpf: make pyperf600 a success again
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 00:21:37 +0000 (UTC)

--===============4197804010435716492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     pyperf600 has been running into 8K BPF_COMPLEXITY_LIMIT_JMP_SEQ limitations
>     for a long while now, after some internal compiler changes.
>
>     Until BPF verifier is bestowed with scalar evolution logic, make that test
>     actually work by doing what would anyone should do in such situations: by
>     moving repeatable per-iteration work into independently verified global
>     functions.
>
>     `void *` argument is a problem for global funcs, but a static function wrapper
>     doing necessary casts and a bit of __arg_nonnull magic dust is all it takes.
>
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This isn't a bug, but could this sentence be tightened? The phrase "by
doing what would anyone should do in such situations: by moving ..."
mixes "what would anyone do" with "what anyone should do" and repeats
the "by" clause on both sides of the colon. Also, the changelog says
"global functions" (plural) while the diff adds exactly one global
function (__get_frame_data).

> diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
> index 86484f07e1d19..fd93a96e59015 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf.h
> +++ b/tools/testing/selftests/bpf/progs/pyperf.h
> @@ -85,9 +85,11 @@ static void *get_thread_state(void *tls_base, PidData *pidData)
>  	return thread_state;
>  }
>
> -static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
> -					   FrameData *frame, Symbol *symbol)
> +__weak bool __get_frame_data(long frame_ptr_, PidData *pidData __arg_nonnull,
> +			     FrameData *frame __arg_nonnull, Symbol *symbol __arg_nonnull)
>  {
> +	void *frame_ptr = (void *)frame_ptr_;
> +
>  	// read data from PyFrameObject
>  	bpf_probe_read_user(&frame->f_back,
>  			    sizeof(frame->f_back),

[ ... ]

> @@ -119,6 +121,12 @@ static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
>  	return true;
>  }
>
> +static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
> +					   FrameData *frame, Symbol *symbol)
> +{
> +	return __get_frame_data((long)frame_ptr, pidData, frame, symbol);
> +}
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
>  	__uint(max_entries, 1);

This isn't a bug, but was the intent to change all nine pyperf variants?
pyperf.h already carries a per-variant inlining switch used twice in the
same file (the #ifdef SUBPROGS block at get_thread_state and the #ifdef
GLOBAL_FUNC / #elif SUBPROGS block at __on_event). The new __get_frame_data
is unconditionally __weak, so all nine includers change shape at once,
including pyperf_subprogs.c and pyperf_global.c whose reason for existing
is to exercise the static-noinline-subprog and global-func paths
specifically, and pyperf50/100/180 which exercise full unrolling.

The descriptions in prog_tests/bpf_verif_scale.c that document the
intended shape of these objects (for pyperf600: "Asm loop count -> 4. 16k
insns in loop body. Total program size ~82k insns.") are no longer
accurate for the smaller loop body and are not updated here. The changelog
only motivates pyperf600.

Would gating the new global function the way get_thread_state()/
__on_event() are already gated keep the subprogs/global/unrolled variants
testing what their names suggest? If it is meant to apply everywhere,
would it be worth refreshing the size comments in bpf_verif_scale.c?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31754735233
--===============4197804010435716492==--
