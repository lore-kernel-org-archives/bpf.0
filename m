Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A89306768
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288669; cv=none; b=rHQIUIWam+5kP4JImd71jVmxULjAiEwCH5XDQfVoaQENmNZlxPcWs3e5d4irLsfbOkllWeQOKVwgDyjBuyg62yh91Hwyvutq0P9CP7FUOp1e9aHEX1kZ/Z6eHxytIoTh0Hks0ozDFdC22KvU9Ar1FcSpXjdLqWAi1sZucJq7li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288669; c=relaxed/simple;
	bh=1jp9afXwBOF7+mFS/rMDQCykTgY7Trr94fA/Qd/+7yE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ovg7c3IM984SyOiT/nl1Z8N/zFDzxqII+g6hIEpxw25cwRb4lmSPiKCghSo2I6wj16FSmocdt9LujWEq0XA6PwmF9oZBlGyhgITd8dgkTQTdGnwhFPhIKBuGxsWjLpI9Y/ewvnb/lhvkhd+Axi7gwKm4gffsABEp4GTTIUW5NvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ1FQF79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ1FQF79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9411F000E9;
	Wed, 29 Jul 2026 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785288661;
	bh=KhRJd4msSQ6Cqf6XG71K7ULNyKkyleRKLtfqHhZuUHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZ1FQF79YDfGTdz65pHKEy+9hPWdIvkTLbdjVd3Go0RMQi+iSkgYTl4NnN0wCm9eH
	 +4sVlbKR6xkcaleaUcYPzxQna1DpOIoKJ4KUy9EIXdL16fRumJQPajRwJNPCkqZY7i
	 NIk6baOO4XkZrv2B19tSOOxRGfQs9swn2llAyFZYB1BTnu0Fu/gcbpuh7Q4vbua3c5
	 Jc4qzoQ9jlTqMYnHuxODcEjjfBoyCq2xWHAwhDS+2/wDhuQVBRfl/5hvAdzg+pPyN4
	 iFRd+8DvqRQ9Mrlgm8rYAD+QITONhIbcE1xWKg4ECwJtv+gKFFYOEGFXEucTE/yktk
	 C1JVo3txscbQw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 01:31:01 +0000
Message-Id: <20260729013101.9D9411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test dynamically alters a global system-wide setting (`kerne=
l.ftrace_enabled`) but is not marked as a serial test, which will cause fla=
ky test failures during default parallel execution.
- [Medium] The test does not explicitly ensure `kernel.ftrace_enabled =3D 1=
` after reading its original state, causing guaranteed test failures if the=
 testing environment starts with ftrace disabled.
- [Low] A multi-line comment violates the BPF subsystem's mandatory comment=
 style.
--

--- Patch [3]: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent=
 test ---
commit 16e4b9c3d2d63207f5f4817fc1dedd224a76749e
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

selftests/bpf: add ftrace_permanent test

This patch introduces a selftest to verify that kernel.ftrace_enabled=3D0 i=
s=20
refused with EBUSY when fentry, fexit, kprobe, or kretprobe BPF programs ar=
e=20
attached. It confirms that the sysctl is allowed again once the programs ar=
e=20
detached, and skips kprobes testing on architectures without=20
CONFIG_KPROBES_ON_FTRACE.

> diff --git a/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c b/=
tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
> index 0000000000000..dbe78009a2913
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c

[ ... ]

> +void test_ftrace_permanent(void)
> +{

[Severity: Medium]
Since this test dynamically alters a global system-wide setting=20
(kernel.ftrace_enabled), could this cause flaky failures for other concurre=
ntly=20
running BPF selftests?=20

Should this function be named serial_test_ftrace_permanent to ensure the te=
st=20
runner executes it exclusively?

> +	struct ftrace_permanent *skel;
> +	bool kprobes_on_ftrace;
> +	int orig =3D 1;
> +
> +	/* Save and always restore ftrace_enabled. */
> +	if (read_ftrace_enabled(&orig)) {
> +		test__skip();
> +		return;
> +	}
> +

[Severity: Medium]
If the testing environment happens to start with ftrace disabled (orig is 0=
),=20
will check_blocks_disable() unconditionally fail when it tries to attach=20
programs?=20

Does the test need to explicitly set kernel.ftrace_enabled =3D 1 here befor=
e=20
proceeding?

> +	skel =3D ftrace_permanent__open_and_load();

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/ftrace_permanent.c b/tools=
/testing/selftests/bpf/progs/ftrace_permanent.c
> index 0000000000000..ca706d8edc23b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ftrace_permanent.c

[ ... ]

> +extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
> +
> +/* This function is here to have CONFIG_KPROBES_ON_FTRACE used and
> + * added to object BTF, so the userspace side can read it back via
> + * skel->kconfig->CONFIG_KPROBES_ON_FTRACE.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment has text on the same line as =
the=20
opening /*, which conflicts with the BPF subsystem's required comment style.

> +int unused(void)
> +{
> +	return CONFIG_KPROBES_ON_FTRACE ? 0 : 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729005959.3853=
865-1-andrey.grodzovsky@crowdstrike.com?part=3D3
