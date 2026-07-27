Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB83630B0
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163940; cv=none; b=JUPermfBcERKOY40oH45qO9ZYSGOUQqiblAs+N50/L6fno6OPLq01J9oheizL/vZmoYj7+IOiLHC6pySiSEFHhejRsu20oXXU4Qk0NEbocDhJX9/Cg+dPrms2no7SmvZVj01EcrBaHlq773BPoNi67QB25m5MhrNmxnRLOWIfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163940; c=relaxed/simple;
	bh=FcRgAImNnwGe+ukVnJ73LLN5fj5RpHrhASKi8SAOcso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s85t9+uvPJftWLy9hru+2RveIPj6MesQpOxOtGs/7sxFvmgC8X5wxwFmEOHwjXpXGFO8/sC16xVqzAC3SravAMrMXNNIQ5EbDlvHlCeKxjn1ZopYruVl4MA6hy4fSSK4q5bBDvw0B1sNBKxZGzzizrdHQGw+9zuKV8vmvEGt6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRzpdNGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRzpdNGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B9C1F000E9;
	Mon, 27 Jul 2026 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163937;
	bh=GIwybR7W6mWapGWy9TBWhNRTd/97GC3elz+LlCP0ars=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRzpdNGk1S8l6dfrq2u00m9Vzd61rktgl0s0qkMjNRFbZ9tSu5BYv3PvhTueOTafL
	 qwA2M3rhq6JYcL1byw0TyvOCAGtqaBS0/SY4tWA312anrB4BWM7kd/uLPDYoGNWPLI
	 KP4qyvB8g8Jpk4YT0eOYfkBBhr6x4syG0Qa/id0yTGCJNXWZWW78Bx4TyDaBj+3+xN
	 Dm4eNWPYx+yA+CiClTm5OHuwHyFO1fnG3wxk1oyl5qRwsohHj6r5IpTULE/vysERFJ
	 Cv5EVlhvVsN9FNpZ93rIjsaIrckXUPzz1FmGxybDGM6W5Pr6VVktKyL5gYZf7d+hgZ
	 3R3BSuvQT5M4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727142844.21212-2-leon.hwang@linux.dev>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:52:17 +0000
Message-Id: <20260727145217.72B9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU read barrier (`rcu_dereference()`) when accessing `dir=
ect_functions`.
--

--- Patch [1]: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for dire=
ct calls ---
commit 738274783fa707248af104af5e45da296f7e4d84
Author: Leon Hwang <leon.hwang@linux.dev>

arm64: ftrace: enable single ftrace_ops for direct calls

The BPF tracing multi link updates several direct-call sites through one
ftrace_ops. This commit selects HAVE_SINGLE_FTRACE_DIRECT_OPS on arm64 when
DYNAMIC_FTRACE_WITH_DIRECT_CALLS is enabled. It also generalizes the
unreachable-trampoline comment.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 39eba438dad43..94fa6e72c2867 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -188,6 +188,8 @@ config ARM64
>  		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
>  		if DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_SINGLE_FTRACE_DIRECT_OPS \
> +		if DYNAMIC_FTRACE_WITH_DIRECT_CALLS

[Severity: High]
This is a pre-existing issue, but by enabling HAVE_SINGLE_FTRACE_DIRECT_OPS
on arm64, does this expose the architecture to a missing RCU read barrier
in the ftrace code?

When HAVE_SINGLE_FTRACE_DIRECT_OPS is selected, call_direct_funcs() switches
from using READ_ONCE(ops->direct_call) to using ftrace_find_rec_direct():

kernel/trace/ftrace.c:call_direct_funcs() {
...
#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
	addr =3D ftrace_find_rec_direct(ip);
#else
...
}

Looking at ftrace_find_rec_direct(), it accesses the __rcu pointer
direct_functions directly without an rcu_dereference():

kernel/trace/ftrace.c:ftrace_find_rec_direct() {
	struct ftrace_func_entry *entry;

	entry =3D __ftrace_lookup_ip(direct_functions, ip);
...
}

Without the READ_ONCE() provided by rcu_dereference(), the compiler might
reload the pointer between computing the hash key and accessing the bucket
array inside __ftrace_lookup_ip().

If a concurrent writer substitutes a new hash table with a different size
between these reloads, could the computed key exceed the new bucket array
bounds and lead to an out-of-bounds dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727142844.2121=
2-1-leon.hwang@linux.dev?part=3D1
