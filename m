Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65438224B04
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913991; cv=none; b=pRftgJVYvpdoNvGLWX/INz5gErJIgzzolcKbpOq7RjOjkmJEqxRjjvpA2pyY27xQmNfAoj9MSZsGOGXyMDn+PkB5/M5lH/oI+78m5lIsWEy97/2UAWZajkJvHFTvyU75ArR+O8f71NGvSqrObNX+I8qSA4wMvd5zV7C3It3eHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913991; c=relaxed/simple;
	bh=JwdK/5R1jTpWPL7HYChUWPb2NrumQPkjlLCu0mdd92k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVT+EjWq0a6qkFYPkVIfknv2GWF6MHU3qz7mG0T+8aMIbp4ytmxN8Z+XJEahwcUK4dDwuxlziqcxzyJIInzo34iEeg0rf4LpHdqDDk0U50RyQBS61iAN8bcY5VAWD/JUd0Q9cc/gD6iNq3VXmR/ZEKQYI00TMDIMNL6wsDleNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/EpnuLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/EpnuLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488D1F00A3D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913990;
	bh=y4LXRZ53BHaUiLlnVu4ZH3hhs4By6X8kv/X+fdQ5NVc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=L/EpnuLo8HLimGDbOolvx5lyuFmIe3zYXMZ1uX3CjO8a62GoBjHcd6FK1pV43sHHO
	 lffL2wf10tePjERjhbv4S+KKwoJ+PoV6hOJqriHkJLAQiSZTVegiE3TwxM/e+5eP8l
	 84P4Pe0XqxHNZwIZbLn+mnqTAl7vVE35x6g5dhV8AVXPnvzLbFAHyHy7pfjM1FmDtI
	 iYcFuVxQ+RG1bVV77W8tlSnPDW5clVgs3x3TpCrQczHFXOKEEYqOl6spOU6Dk/k9xd
	 YRkVLtoWs4PuuyUYhNjzO0LQB035QmWT9comZ6HAeCDceZ2LFikVsDbP9kiVhNli0E
	 ITAXVrWu4jgYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] selftests/ftrace: Add a test for eBPF compiled
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <178291356080.1566898.2303910167100203913.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291356080.1566898.2303910167100203913.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:53:09 +0000
Message-Id: <20260701135310.0488D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Hardcoded little-endian expectation for string memory read as u3=
2 causes selftest failure on big-endian architectures.
- [Medium] Improper cleanup of `trace-events-sample` module causes resource=
 leaks on early test failure and violates test isolation on success.
- [Medium] The test fails to verify the fallback to the interpreter on unsu=
pported cases, despite claims in the commit message.
- [Low] The test configures multiple fetch arguments but only verifies the =
dereferenced string, ignoring the register argument.
--

commit 4bb415f7039780520dc7b73a0fda0fb23e2616db
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests/ftrace: Add a test for eBPF compiled fetchargs
   =20
Add a selftest for trace probe BPF compilation to verify that BPF is
correctly compiled and executes properly for valid configurations,
and falls back to interpreter on unsupported cases.

> Add a selftest for trace probe BPF compilation to verify that BPF is
> correctly compiled and executes properly for valid configurations,
> and falls back to interpreter on unsupported cases.

[Severity: Medium]
Does the test actually verify the fallback to the interpreter on unsupported
cases? The script configures REG and DEREF fetchargs, but there doesn't
appear to be a test case that intentionally uses an unsupported configurati=
on
(such as dynamic strings) to verify the interpreter fallback mechanism.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetc=
hargs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetcharg=
s.tc
> new file mode 100644
> index 0000000000000..6c6f4dd4517ac
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Dynamic event - test eBPF compiled fetchargs for tprobe a=
nd fprobe
> +# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>=
]":README
> +
> +# Check if the sample module is loaded
> +if ! lsmod | grep -q trace_events_sample; then
> +  modprobe trace-events-sample || exit_unsupported
> +fi

[Severity: Medium]
If the script exits early on failure, will this module be left loaded
since there is no trap EXIT registered to clean it up?

[ ... ]

> +
> +# Now verify the trace
> +grep -q "test_tprobe.*myfoo=3D1819043176" trace || exit_fail

[Severity: Medium]
Will this hardcoded value cause false-positive test failures on big-endian
architectures? The test dereferences the string "hello" as a 32-bit unsigned
integer and unconditionally expects the little-endian integer representation
1819043176 (0x6c6c6568). On big-endian systems, this value would be
1751477356 (0x68656c6c).

[Severity: Low]
Does this grep ignore the register argument configured earlier? The tprobe
was configured to capture two arguments (mybar=3D$arg2 myfoo=3D+0($arg1):u3=
2),
but this verification only checks for the presence of the dereferenced
myfoo value.

> +
> +if [ -d events/fprobes/test_fprobe ]; then
> +  grep -q "test_fprobe.*myfmt=3D1819043176" trace || exit_fail

[Severity: Low]
Similarly, does this grep check ignore the myfoo register argument configur=
ed
earlier for the fprobe?

> +fi
> +
> +echo > dynamic_events
> +rmmod trace-events-sample

[Severity: Medium]
If the trace-events-sample module was already loaded before the test starte=
d,
will this unconditional rmmod incorrectly unload it and alter the preexisti=
ng
system state?

> +
> +exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178291352217.156689=
8.14481561093843379745.stgit@devnote2?part=3D4
