Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C852D7D3A
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787987483; cv=none; b=MY74TYdP59UXlKIfpK7Km6NsZtFUaTb99uLJVmhfXGgzLUw+jXeSpRfg26uA913lK7gYDrNdxnu8gY2f8w519SwF/GjAuTd/mw8D9lJsqJt/HX1CeXdJfPZPR4gXZ7Iz6EjKOakTETEVZJsqsyfuc385p6jtqtsMMeKNIvOUHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787987483; c=relaxed/simple;
	bh=kQN2y9Eup/LoFgYk2vBNkTYf+3S95OVxo4XXK/AGas4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SNU8EgakBkclkdMcm7B/8gQVr1RF1n2UVdOUwdc+JswxKFy2Zan5gvYQ1oCYBh3AeYteQ4UdhqAPFHJcuk0TDmNayDuRuQzeVcKkf97noY7n/kbvxAhVRf3sM38fz+YJ6H+1wanqtg5UvhKrRh7xwbE31py93PWh3YOnya2RMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKjt4LXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKjt4LXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486701F000E9;
	Sat, 29 Aug 2026 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787987481;
	bh=VvbddvA5nuIpuWZi9rjF7ZW30dmg3M9pyFi/RWtZm9M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PKjt4LXEQ3XpPbQiOXiYPtIWoX4D7z7hJhwLuqY3FBJk6fTI0gcRMcsk3LdEttxHD
	 MoayLICjSmduyH6f96oLI5VqiYg2BESM8jpm3waMyEz1MaEMc3s4mgbc5lW80bbAVE
	 GYe68f20plv4AFi6jX9htjp5AVfmOP5QyOa9ERqFi3ziYi/hvwGQ/rguiifV7j8M5E
	 x5JKm1k9A9UjHSNrvtetTmtyL5GhguAC4NScLl/SQ+qxqreTRmpiwhLwu/R8jKy+VC
	 +2M2s/9t40wsd7jcg0BsrTfAd1xWh0N7ixVGTiOXmWcp/Ja9kzDWPHiIB2LeHWj2GY
	 4oMJqSa9qM7jQ==
Content-Type: multipart/mixed; boundary="===============7380553698733034819=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04ed7758d10d1f334a272ee40bfda617b3ff67c46af3ade0afddc9e9ca24106e@mail.kernel.org>
In-Reply-To: <20260829061545.1695736-1-yonghong.song@linux.dev>
References: <20260829061545.1695736-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: Report which member makes a kfunc return type unsupported
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 29 Aug 2026 07:11:21 +0000 (UTC)

--===============7380553698733034819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Report which member makes a kfunc return type unsupported
>
> A kfunc that returns a struct by value may only return scalars, and the
> message that rejects one names the type but not the member at fault:
>   kernel function bpf_kfunc_call_test_ret_ptr returns STRUCT
>   prog_test_ret_ptr that is not composed of scalars
> Record the member that made the walk fail and name it. What is recorded
> is a path, not a single member, because the walk descends up to 4 levels.
> For
>   struct outer { struct inner { void *p; } in; __u64 tag; };
> naming 'p' alone would send the reader looking for a member struct outer
> does not have, so the actual message reads "member 'in.p' has type PTR".
> For
>   struct s { void *p[2]; };
> naming 'p' alone would blame the member, when it is the element type that
> was rejected, so the actual message reads "member 'p[]' has type PTR". A
> zero-length array has no element type to name and is rejected for its
> length instead, so it reports "member 'p' is a zero-length array".
> The detailed diagnostics for this failure:
>   Verification failed: Program Structure: Unsupported kernel function
>   return type
>   Reason:
>     bpf_kfunc_call_test_ret_ptr() returns STRUCT prog_test_ret_ptr by
>     value. Its member 'p' is PTR, not a scalar. Only kfuncs returning
>     scalar values, or structures composed of scalar values are
>     supported.
>   ...
>   Suggestion:
>     Call a kernel function that returns only scalars by value.
> A type nested deeper than the walk descends has no single member to
> blame, so that case reports the depth instead:
>   Reason:
>     bpf_kfunc_call_test_ret_deep() returns STRUCT prog_test_ret_deep by
>     value. It nests structs more than 4 levels deep. ...

This isn't a bug, but the bpf_kfunc_call_test_ret_ptr() output above is
reproducible against the existing test kfunc, while bpf_kfunc_call_test_ret_deep()
and struct prog_test_ret_deep do not seem to exist in the tree. Would it
be worth marking that second block as a constructed example, or adding the
test kfunc so both can be reproduced?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33238287240
--===============7380553698733034819==--
