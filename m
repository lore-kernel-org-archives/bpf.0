Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887D4D90D4;
	Fri, 18 Sep 2026 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731516; cv=none; b=sQAnOOz/8bDHlfmAOqAzm8tTlgCUPJVryAFJ3C0ZWdviPYmvwDSmO4YJzfppKMFxhzQ6BkIhSAdpsAKGoWCpla8cmf03T2cQfcYXu0tnLXr3H5sI0AngM65c1inYhCwqi3Pds0G/a/f3600RuFBJYqOdKu5TJRMw+4FJh/GFGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731516; c=relaxed/simple;
	bh=3FIurDf4ew+UmNKOaulZUP0fzuB4sQ6WqS5t+tYmlPA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bttr6Gn9GktZtM/GOd1DBhlj08zqzC/WhUJQHNo1K8D+Aq/ebYWbdngeLTD2O8pbhYxvR0iChpxbHLlWb/00ywmS3gh+L57cMJ0ias5+hqj9R3CeMx3QxT2lSHAvY3kyjZsnq+o0a0P9JUXwxzDnIF6mt1ym22VrS1L3H1+qLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLGdoYjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLGdoYjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56B1F000FF;
	Fri, 18 Sep 2026 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731515;
	bh=1Wf7nUY4OvwVga8yXR0/S8oe1wqhMNKSdVwo0smTlFg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JLGdoYjG+kBeQPwpu4ZKGyMAjId/VTaBq0cHrBlJMAC9N4j0urkfvhR6Nuu6KOvqm
	 Derb0hZKtigi5LGzl4cDWC0mqWd7NZthXuwGlCcEvheYgUMs9BvDtUilgNt6UGMGmZ
	 lF8FJQ66YpSERYv2O3zDB4lu6OWD8s/nxNE1dDhLnIMStyUwl3BJukMmKQN51ipx01
	 bhbprbQbAEM5OuMiLQ2nE77GZgZEoLCkyMtjzNJYLARfqz8zmWJb8ZZiyT58u1cY3+
	 o5Ms73GBdYGH6PEx0eL/n8dHITZex83b5q2zSAAIP930cBMqN9gzf5nBrWmPOWAPKU
	 8dVlt+i+ZJGjw==
Content-Type: multipart/mixed; boundary="===============0981821882642161934=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aec6c555995eb1efb36bafec4c49e2235fc6899cb74beb6dcb3ce058ada6d814@mail.kernel.org>
In-Reply-To: <20260918102610.gxA3km8_@linutronix.de>
References: <20260918102610.gxA3km8_@linutronix.de>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Use %p for pointer formatting
From: bot+bpf-ci@kernel.org
To: bigeasy@linutronix.de,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 11:38:34 +0000 (UTC)

--===============0981821882642161934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Use %p for pointer formatting
>
> Networking used to print the socket pointer with %p as output in the
> /proc interface. This was later changed to %pK in order not to reveal
> the actual pointer value. The output format has then been copied to bpf
> tests which produce the same format including the %pK format modifier.
>
> Networking recently replaced the socket output with a plain 0 because
> the socket pointer added no value to the output and the %pK should be
> removed from library handling. The format remained otherwise unchanged in
> order not to break any tools which parsing this information.
>
> This change removes the %pK modifier from bpf, following the change in
> networking.

Does this subject line accurately describe what the patch does?

Looking at the actual changes, no %p format specifier is introduced
anywhere in the test code:

- bpf_iter_netlink.c gets a literal "0  " string
- bpf_iter_tcp4.c / bpf_iter_tcp6.c / bpf_iter_udp4.c / bpf_iter_udp6.c
  get a literal "0" string
- bpf_iter_unix.c gets "%08u" with a constant 0 argument
- test_snprintf.c simply drops the %pK specifier (its remaining %p was
  already present before this patch)

The only place where %p appears in the patch is in README.rst, in a
historical verifier log excerpt.

The body text says "This change removes the %pK modifier from bpf",
which matches the v1 subject "selftests/bpf: Replace %pK output with 0"
rather than this v2 subject.

A few additional points:

The changelog is unchanged from v1 and doesn't mention the
header/column-width edits this version adds:
- bpf_iter_netlink.c "sk" column changed from 17 to 3 chars
- bpf_iter_unix.c "Num" column changed from 18 to 10 chars

This seems relevant since the body asserts "The format remained
otherwise unchanged in order not to break any tools".

The referenced networking commit isn't named in the message. Looking at
the v1 discussion, commit 7c0ec6288b497 ("net: Replace %pK output with
0") was cited below the --- separator, so it's absent from the committed
message. That commit doesn't appear to be in this tree yet (checking
net/netlink/af_netlink.c, net/unix/af_unix.c, net/ipv4/udp.c and the
tcp_ipv[46].c files still use %pK), which would make a Link: or commit
reference useful for readers.

> order not to break any tools which parsing this information.

This isn't a bug, but there's a grammar error here ("which parsing"
should be "which are parsing").


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35336391118
--===============0981821882642161934==--
