Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260613E5A0B
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649657; cv=none; b=lILNCYJQgP0JeVRwv2c0+zFy16k4f37nLy8vO9J8wDB/cSmbjIXN0HX/sppSUaI16zXZeSqPoI2Ahg7XMfy/bvA3rMV9EySRkAQLE+S3YM3IBg3zE+cnAjlOTS1uc1Q+C20tqk41abI86IjSN7d6GHN/Ea4RZ8GlZ8wZj1ELqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649657; c=relaxed/simple;
	bh=qm5tKcIWw7nqmy/bP+IcCgfjtooeUC+Ew9j33EppLqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j4EJSwCjJe8n8lYvMcBHqUYp4iFp36njXwbFlKs4pFANZQZURmUEQHmI6pwbdB5KPxm4pJuizMieqDQlOXU755/HerbmGqJmrS0wc5ke9RfnL3YHsTW6BpKLBDg27WMr6YVGuoA1OJ0hSaBtrbkc+e1xUFgTmzQscK6Yu96xv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQrlKTOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQrlKTOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD91F000E9;
	Tue, 16 Jun 2026 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649655;
	bh=6+HqT3FwGxs/VjD8UyUpgahA+c3+NQmghiLsfbjyi8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQrlKTOBJpTNb3A5/tjl+Vudj8OQD27SElA/1P/PPTyk+JSueTXyTRa5exRLSPNhI
	 mC+2+cIkWE9WwQjdgQIhJD9GUfjnrfd/YI1IzOiUDENFCT5UGgqtS670p78vr6cD8F
	 vJqyY0cBjB4DSOpq+cAp+Kb6PqsW2Im/W/dfjFJXhuC3kzSbmBXXXpoRS3Jv+7yEW8
	 iHSivVJq3xsAxTl+56f+MxE+lBTwfN4egwG13HAD7gkqLapYdktOCT5xnIz9YrJ1tW
	 zxUfYJXym1rnDJ7PtYWYr2Zo3SJCm8N/Q9Ri6YpqG6zYbwrxwNGzJmMQwnNI4LM9IG
	 9H+fnxoo0bRXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add bpf_fib_lookup()
 VLAN flag tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616223426.3568080-5-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-5-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 22:40:55 +0000
Message-Id: <20260616224055.9AFD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the mandatory BPF subsystem moder=
n comment style.
--

commit ce4915a9efe53d10db6f263bbf7bb1a929ea9dbd
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

This commit adds extensive test coverage for the new BPF_FIB_LOOKUP_VLAN an=
d=20
BPF_FIB_LOOKUP_VLAN_INPUT flags. It introduces 36 table cases and a new
cross-netns subtest to verify both the egress and input direction logic.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/=
testing/selftests/bpf/prog_tests/fib_lookup.c
> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c

[ ... ]

> @@ -52,6 +88,16 @@ struct fib_lookup_test {
>  	__u32 tbid;
>  	__u8 dmac[6];
>  	__u32 mark;
> +	/* input tag with BPF_FIB_LOOKUP_VLAN_INPUT; expected output tag
> +	 * with BPF_FIB_LOOKUP_VLAN (checked when check_vlan is set)
> +	 */

[Severity: Low]
This isn't a bug, but does this follow the required BPF multi-line comment
style? The BPF subsystem prefers having the opening /* on its own line,
with the comment text starting on the next line.

[ ... ]

> @@ -204,6 +448,105 @@ static int setup_netns(void)
>  	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
>  	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE=
);
> =20
> +	/* Setup for vlan tests: a subinterface for egress resolution and
> +	 * tag-as-input, a QinQ stack, and an iif rule so the input tests
> +	 * observe which device the lookup used as ingress.
> +	 */

[Severity: Low]
This isn't a bug, but could we also adjust this block in setup_netns() to
place the opening /* on an empty line? There are several other multi-line
comments introduced in this patch that follow this older pattern.

[ ... ]

> +#define NS_VLAN_A	"fib_lookup_vlan_ns_a"
> +#define NS_VLAN_B	"fib_lookup_vlan_ns_b"
> +
> +/* A VLAN device can be moved to another netns while staying registered
> + * on its parent. Neither direction may then cross the boundary: the
> + * egress flag must not publish the foreign parent's ifindex, and the
> + * input flag must fail closed rather than use a foreign ingress.
> + */
> +void test_fib_lookup_vlan_netns(void)

[Severity: Low]
This isn't a bug, but could we apply the modern BPF multi-line comment=20
style here as well before test_fib_lookup_vlan_netns() is declared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616223426.3568=
080-1-avinash.duduskar@gmail.com?part=3D4
