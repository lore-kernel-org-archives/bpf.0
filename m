Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652358834
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579142; cv=none; b=mcgqX6Je+/7FsL5OoF+cl0VAOjfMUE0HifO+s4u8FmD7Q/FBQR6vWze/T35DmADRuHMUC0CamTXevq9pe69MP7S9KJXh5jD8dvLHdblXZrcSYNHv0EX8qqqqn5yYMqsKmQdR7My5dXAdP4pgYXjQ6/zS89FdOZ9fem9AqtF1xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579142; c=relaxed/simple;
	bh=X0z0P0fwFMHqGMcKxLSWer/OE+l6j7WMhDlgM0fUgRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V+daDdD8S/TLc0+vje/dISbiwJ4xU/SSKqKy2pFn3i3KkKA0nAr82qT0kKwSAoLtZ08r5toKezhq0njH8kpq0ecCVEf+s/nA+kconBur3aW8bQQGHJQ9TJGIDvJ39YFDj01xPM+NCTYbqdHCOVUmjI+CJUZ/FWaw6NcCqI3I1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhIRc0bZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhIRc0bZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0CD1F000E9;
	Sat, 27 Jun 2026 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579141;
	bh=raUkQLLAVj5N+BQMiiLWxPCwjbHCL62aH2eSTFpVUeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhIRc0bZjZmJWu0mzc9SwwJv2J4UjQqOrJH7L/AbT+ZWXTX8OwQe6A8903tci6nb2
	 ERKECEQ2UdOZ3kJeOfqmacE36ioVDXo00vEkl7Pvcuanp+mIi6efbm/REqQ121wkZP
	 VZbc/Lnk+lxgBV8oCBZQmBzLZCPSwuW6K7cx5XQwPuTQhHQp0mcV9YnjemJQ+DW/P7
	 QiwTlfN1XI1HcTXW28xnWWNflfhh44r4eGEWJul8EFl29HTfwGCwGR/Fdpk8sF/YlI
	 bnO7IVKElpG0iwt7gqYAXPnQol/O8sQDvQ7WIIlP0u2HFMavwpsaFgEsFf/6j85oYS
	 i1H0nVstE0aPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] selftests/tc-testing: Verify bpf redirect on
 RED block with preceding clsact (egress) classifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626165156.169012-4-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
 <20260626165156.169012-4-jhs@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 16:52:20 +0000
Message-Id: <20260627165220.CA0CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded BPF object path 'action-ebpf' instead of using '$EBPFD=
IR/action-ebpf'.
--

commit f4ff308069725bd7a3b6c6f843ecb0fda5b73239
Author: Victor Nogueira <victor@mojatatu.com>

selftests/tc-testing: Verify bpf redirect on RED block with preceding clsac=
t (egress) classifier

This commit adds a test case to reproduce a NULL pointer dereference when a
bpf filter attached to a RED block (which uses shared blocks) returns
TC_ACT_REDIRECT while a preceding clsact egress classifier is present. The
issue stems from a stack-allocated bpf_net_context being torn down before
tcf_qevent_handle() calls skb_do_redirect().

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.jso=
n b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> index a1f97a4b606e8..762f86ceab1cd 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
[ ... ]
> @@ -1540,5 +1540,37 @@
[ ... ]
> +    {
> +        "id": "fb8d",
> +        "name": "Verify bpf redirect on RED block with preceding clsact =
(egress) classifier",
> +        "category": [
> +            "qdisc",
> +            "red",
> +            "qevent",
> +            "clsact"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP addr add 10.10.10.1/24 dev $DUMMY",
> +            "$IP neigh add 10.10.10.2 lladdr 02:00:00:00:00:01 dev $DUMM=
Y nud permanent",
> +            "$TC qdisc add dev $DUMMY handle 1: root tbf rate 1Mbit burs=
t 10K limit 1M",
> +            "$TC qdisc add dev $DUMMY parent 1:1 handle 11: red limit 1M=
 avpkt 1400 probability 1 burst 38 harddrop min 30000 max 30001 qevent earl=
y_drop block 10",
> +            "$TC qdisc add dev $DUMMY clsact",
> +            "$TC filter add dev $DUMMY egress protocol ip prio 1 matchal=
l action gact pass",
> +            "$TC filter add block 10 protocol ip prio 1 matchall action =
bpf obj action-ebpf sec action-redirect"

[Severity: Medium]
In the setup block for "Verify bpf redirect on RED block with preceding cls=
act
(egress) classifier", will this test fail with a file-not-found error when
the tdc.py runner is executed in an out-of-tree build environment or with a
customized $EBPFDIR?

Should this path be updated to use $EBPFDIR/action-ebpf instead of the
hardcoded action-ebpf so it aligns with other tests in the suite and finds
the BPF object correctly?

> +        ],
> +        "cmdUnderTest": "bash -c 'data=3D$(head -c 1400 /dev/zero | tr \=
"\\0\" \"x\"); exec 3>/dev/udp/10.10.10.2/12345; for i in $(seq 1 8000); do=
 printf \"%s\" \"$data\" >&3; done; exit 0'",
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.1690=
12-1-jhs@mojatatu.com?part=3D3
