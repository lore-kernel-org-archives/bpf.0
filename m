Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F273148BF
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439948; cv=none; b=Uspol9grM5KRqWL895mE2uZQNdNzYMakrauzFLlX38fEaKkYEhaDff4MdCyW5BDV6FoSvAvJdYIpCV6XQKHcL0sBWXFnJmfkh5XYtimhe96kbyiz4US0P475OAUeNHFZHy38rQ5cvNvESrhWol8JT5w1N2y7rkdGaYS3IqNZ66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439948; c=relaxed/simple;
	bh=3mhxq0H7Ye045I0R/BZnMqsyYb6Hn2IBTrLm0iFFy3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TXg573ki8HtWXlPSMw4C97+DRiObhftlMOBVKtPTtN/o5GCi0kgDA3oYuiF2UAyLsyTu3Tv9goAMhGDUj2Qb01YRjLAnmclvj5tVumruxHtQDGUPTqDiBbsnH+BmQrvjtAzM+GwDNwZcjbTJdpSb1DtxlrMc4aHbm5iLuOHKV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwmOWNpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwmOWNpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B561B1F000E9;
	Sat, 22 Aug 2026 23:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439946;
	bh=rXRhYat/hm8LZxNvDlsQ1BboTFNR76R7uIXFhOlPoio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwmOWNpjOYP6mkYGQLAWN6U6w5+dZhSsjIsjmdMGkKpP4Wvp1s1VtQiZOT8XJUn6l
	 rm1xsT7mPnR6llrfo1RdM24TQqO7QSWAi+dBDANLvnDIHqKxM77Egz7AMuQoqwWabH
	 72sy4fTWoPvJRNShJHSaS6vSdy2SSmc0p2Y4H0okS1EKbhAvDpB0oJPIZi39kvarTL
	 Q9vvtZhL4wfNBA/+az0lqg+VAjUSvWtbYXG2rVPF5GalACHjkdHLt5oDwXRWaGTKSP
	 2wz7/m7sakI0KIYL6kWv1EJaIm8zOKbUXRZrnMpTQDTkTYQo/TwRC419rZFPPpPo1U
	 ps/ZvmT57ScrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: verify preemptible uprobes
 avoid private stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Simon" <simon@swine.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822225444.2774461-3-simon@swine.de>
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-3-simon@swine.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 23:05:46 +0000
Message-Id: <20260822230546.B561B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious test failure (flakiness) due to insufficiently small ti=
meout limit in bpf_loop.
--

--- Patch [2]: [PATCH bpf v3 2/2] selftests/bpf: verify preemptible uprobes=
 avoid private stack ---
commit c17909e48f5484c8e9bf3341a1fc87b98ad29988
Author: Christian Simon <simon@swine.de>

selftests/bpf: verify preemptible uprobes avoid private stack
   =20
Pin two threads to one CPU and overlap invocations of the same uprobe
program. Verify that both invocations execute and that the first
invocation's stack frame is not corrupted by the second.

> diff --git a/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c b=
/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c
> index 0000000000000..07e0ff5487208
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c
[ ... ]
> +static __always_inline int run_stack_test(volatile __u64 *stack)
> +{
[ ... ]
> +	ready =3D 1;
> +	bpf_loop(1 << 23, wait_for_release, NULL, 0);
> +	if (!release)
> +		loop_exhausted =3D 1;

[Severity: Medium]
Could this iteration limit cause spurious test failures under load?

In a heavily loaded CI environment, the main thread's usleep(1000) can be
delayed significantly (for example, if timer granularity is 10ms or due to
hypervisor latency). On a fast CPU, 8.38M iterations of this trivial callba=
ck
might complete in just a few milliseconds, exhausting the loop before the
main thread wakes up and sets release.

If this happens, loop_exhausted is set to 1 and the selftest fails.
Is it possible to safely extend this wait time by wrapping the bpf_loop call
in an outer bounded loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822225444.2774=
461-1-simon@swine.de?part=3D2
