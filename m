Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE704481259
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909220; cv=none; b=aasJsqeijNDXCrx+2KAWD0sMWFiJJD5dGOLuXfia+lRhSUEjTDpttIAwHOYLHGhVMlhE9CGui7R4dx1dYKR0ssbuEG7EM2o6s0UN5m6BsRKjydLb/B2G2wUnBTIYPC9kXYKYG+RBCqGiI4Xeznxy89ag3Cmh9fvak7UQgzo9A50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909220; c=relaxed/simple;
	bh=nxSvtZjpHBTYBqqqTi+QkAQPbhkvMv7HuGVgVBlics8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJP/cwilmZVcgbqqQe+XbFYFbCta/MmStaun5Tf0+zTklloBnSnndUQUk0BCAFT3uiEZ8cCTaxzy9VaerWZe6qQyjmpM1C8YXAlz17wzfy+Dnq8PwhIoAdw8Jz6hJSbBwOyvSTDWTJ5lPb4Kz0dq0Mi/9J0IWn4lcWo7L3TQfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfXW6llr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfXW6llr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522481F000E9;
	Wed,  1 Jul 2026 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909219;
	bh=RflKE3Fxq7bxEDvAC+1KFZ5T7prYhHLsxED+mM8dKXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfXW6llrqo5aGGqPbpOxc1Z0NXbkLpnCsYB7pvqk93yvBGPCk6zqU2vZE0peOZqoS
	 NCZiSXtoL2KXbYVyB1jdocCfyDzb6pUS00FhAHz0XQcfr8F4kHWwWBHE0RTuHbDpq7
	 bB1Euzu79kKEI2vGRMtlLvgkbghcjyTnJEISTcBboDBdLw+OQ69oh4884m8Oh5RnQv
	 oiBL9tTlJ7E5fKCj7rRxRuErEt5gzf70Vs0ipbE/2FHeWTc1kp0Bh9DzSUc+akVMPX
	 3IZioJ3UUFnk5CSBuWeVb4z+YiTFWxNqvle6EJMhwXMgFgLtja4Z8xmJKVGPNgOO+l
	 RgnjI0w7JzMpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] selftests/bpf: Add test for redirect from qdisc
 qevent block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630123331.186840-4-daniel@iogearbox.net>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:33:38 +0000
Message-Id: <20260701123339.522481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test is flaky due to a race condition with asynchronous ARP =
resolution.
- [Low] Semantically incorrect use of the tcx-specific constant `TCX_REDIRE=
CT` in a legacy `cls_bpf` program.
--

commit fc8f69a4140a0efbcb7d3933eb46154533713ffc
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add test for redirect from qdisc qevent block

This commit adds a regression test for a NULL current->bpf_net_context
dereference. It verifies the behavior when a BPF classifier attached to
a qdisc qevent block asks for a redirect.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_qevent.c b/tools/t=
esting/selftests/bpf/prog_tests/tc_qevent.c
> new file mode 100644
> index 0000000000000..67e1d17567abd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_qevent.c
> @@ -0,0 +1,113 @@
[ ... ]
> +static void blast_udp(void)
> +{
[ ... ]
> +	/*
> +	 * Push far more than the RED queue can hold. Once qavg crosses qth_min
> +	 * every further packet hits the congestion_drop / early_drop qevent.
> +	 */
> +	for (i =3D 0; i < 50000; i++)
> +		sendto(fd, buf, sizeof(buf), MSG_DONTWAIT,
> +		       (struct sockaddr *)&dst, sizeof(dst));
> +
> +	close(fd);
> +}
[ ... ]
> +static void run_qevent_redirect(struct bpf_program *prog, __u64 *counter)
> +{
[ ... ]
> +	if (system("tc filter add block 10 bpf da object-pinned "
> +		   PIN_PATH " 2>/dev/null")) {
> +		test__skip();
> +		goto close_ns;
> +	}
> +
> +	blast_udp();
> +	ASSERT_GT(*counter, 0, "qevent classifier ran");

[Severity: Medium]
Since static ARP entries are not configured, could this lead to a flaky test
due to a race condition with asynchronous ARP resolution?

When blast_udp() loops through sendto(), the first packets might trigger an
ARP request while the rest get dropped or queued by the neighbor layer befo=
re
reaching the RED qdisc.

Because ASSERT_GT() is checked immediately after blast_udp(), is it possible
the check evaluates before the network stack finishes processing the ARP
reply, leaving the qdisc with no packets and causing the test to fail?

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_qevent.c b/tools/t=
esting/selftests/bpf/progs/test_tc_qevent.c
> new file mode 100644
> index 0000000000000..1529c111f4aa4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_tc_qevent.c
> @@ -0,0 +1,23 @@
[ ... ]
> +SEC("tc")
> +int qevent_redirect_verdict(struct __sk_buff *skb)
> +{
> +	__sync_fetch_and_add(&verdict_calls, 1);
> +	return TCX_REDIRECT;
> +}

[Severity: Low]
Is it correct to return the TCX_REDIRECT constant here?

Since this program is attached using the legacy cls_bpf via tc filter add b=
pf
da in run_qevent_redirect(), shouldn't it return standard TC_ACT_* return
codes like TC_ACT_REDIRECT?

They both evaluate to 7 so it functions correctly, but mixing the newer TCX
framework constants in a legacy program might cause API confusion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630123331.1868=
40-1-daniel@iogearbox.net?part=3D3
