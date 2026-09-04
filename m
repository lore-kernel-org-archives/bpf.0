Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5B3CDBD3;
	Fri,  4 Sep 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509379; cv=none; b=t3pN7WY3bEr7xJd4ZMg4flr8bO604P4mC6eabTyV+PMEnKvkkFIBZhq9o/XDq7GhffjoDYKclhVoF6Ii3RDMG49dDG41x1WKlGBIZTMa4HjtP6HaNsF5yxZVg06xKpgleXjTjV4pGSNzyFgfPjUz89SKvp6+YgLu3c4udlffKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509379; c=relaxed/simple;
	bh=eCp98AznbRU8jyrmKlzJqal4mXvo7/LIF2BFxFcNfwc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iqSlUmmQq24jAvKRZCPEYx2lfTjfUmd7JdyR3lMXllB8Ys7r6iPtl6lFXJ5p4nK02JtXOH1rtre4cpQ7Qo13fIot2oHvIvTXg8MR+PMguXRBqRSrgiRfDH8cdRC/R3Yipfq1edICgQW7hxuLDJyKgTvgcki4tFCbeUJ84UZiB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKnVJEYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKnVJEYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEB1F00A3D;
	Fri,  4 Sep 2026 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509377;
	bh=9LsK2MXDRjynXM+7CGVIwb6k4vRvdO+pgdIiKPk0znQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HKnVJEYqZolyWQKkgqlul1DlzdlHmRsuzib4zRWUqfnZUjZxzo9zwHgZP+HGRXKGJ
	 v2mmnn/FlVKEngmmef/Bx7TfCaTF0Y2tj65GT/jtcFrosLrz6vfRYqzL5EIGOiXolI
	 ISkY7g9vuAf1cOFE6d2OhFS0nUZxvIEmRh3XwD4nNnEEMLgJmvW7vX+3xayBYf/rsy
	 CV8t4ZOvBUmHbUoMSwt36JJZFZaDZuGBLiJasVA1fxSADyBULdx4xcbviwjkkVQRAv
	 z34gDm7JLu+lYYBJSADKd5Fxp5mc17V8u+CU37puJ3S1KBcXGPahKEaJ+fj1PcbdV1
	 EyZMww7tldMxw==
Content-Type: multipart/mixed; boundary="===============7487938568132425462=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6aec8f5c91db3edfd8becf6f41bcb33fda2cbea1bb894888cbcdab4579b0f086@mail.kernel.org>
In-Reply-To: <20260904070210.4163193-3-donggeunyoo.kernel@gmail.com>
References: <20260904070210.4163193-3-donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: cover the exception callback using its own BPF stack
From: bot+bpf-ci@kernel.org
To: donggeunyoo.kernel@gmail.com,ast@kernel.org,andrii@kernel.org,catalin.marinas@arm.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,jolsa@kernel.org,memxor@gmail.com,mark.rutland@arm.com,martin.lau@linux.dev,puranjay@kernel.org,shuah@kernel.org,song@kernel.org,will@kernel.org,xukuohai@huaweicloud.com,yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,xukuohai@huawei.com,donggeunyoo.kernel@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 08:09:36 +0000 (UTC)

--===============7487938568132425462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
> index c8d716fbd4191..cac4e082139a7 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions.c
> @@ -212,6 +212,35 @@ int exception_throw_subprog(struct __sk_buff *ctx)
>  	return 0;
>  }
>
> +__u64 exception_cb_stack_src = 0x1234;
> +
> +/* The address handed to the helper has to be this callback's own stack
> + * slot, not one from a frame that is already gone.
> + */
> +__noinline int exception_cb_stack(u64 cookie)
> +{
> +	volatile __u64 val = 0xdead;
> +
> +	bpf_probe_read_kernel((void *)&val, sizeof(val), &exception_cb_stack_src);
> +	return val;
> +}
> +
> +/* Throws from a subprogram that has a stack of its own. */
> +__noinline static int throwing_subprog_stack(struct __sk_buff *ctx)
> +{
> +	volatile __u64 pad[4] = {};

This isn't a bug, but would 'u64' fit the surrounding declarations in this
file a little better than '__u64' for the three new locals/globals?
Looking at the rest of progs/exceptions.c, every other scalar declaration
uses the short kernel spelling: 'static __noinline int static_func(u64 i)',
'__noinline int exception_cb_mod(u64 cookie)', 'volatile u64 cookie = c;',
and 'u64 time = bpf_ktime_get_ns();'. The new code at lines 215, 222, and
231 is the only place in the file that switches to the '__u64' spelling,
and it sits directly next to 'exception_cb_stack(u64 cookie)' which uses
the other form in the same signature.

> +
> +	bpf_throw(pad[0]);
> +	return 0;
> +}
> +
> +SEC("tc")
> +__exception_cb(exception_cb_stack)
> +int exception_throw_subprog_stack_cb(struct __sk_buff *ctx)
> +{
> +	return throwing_subprog_stack(ctx);
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33848479344
--===============7487938568132425462==--
