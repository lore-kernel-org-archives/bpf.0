Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CF305691
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878853; cv=none; b=Cy9MkFbar0FJtF1741NXO3dbtBi2m0tHn9omWHAOtHlanDTTqDzJ5BJLSMv+dncesV9idpwdsR90lHa/zELlb7MQ9MuHM6/rU5VuXALpaEzIi65wMfx840tQu7tKteTUGLHjHJiOFMDRkpwrOnRoWdvECJJUFs0TG7juPcZBYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878853; c=relaxed/simple;
	bh=VNxsveOGpxNqgob/e59QYJpj1dGgos+O56uZxCQfwW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8YXn3ptvzErI2OIOt/cXQaWyxdz4FMWKrvvpZoftfzVrf2Mame1fy6glO3vcdbi/y+hcL3wg3gXcLpy3lskUGMZx1xPD4eMGcOcpx1ev2smlIPkSX/fcLDqSRLO9FEdAS5F2rE2wuwtji3KjavaO16Ws+ir82GN4Vm8rZjHmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtwWy2f0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtwWy2f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB1C2BCB0;
	Fri, 15 May 2026 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778878852;
	bh=VNxsveOGpxNqgob/e59QYJpj1dGgos+O56uZxCQfwW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rtwWy2f0+2Wh9hwNqXjWMLazStJVG/LG30OQGwGsCDYBf0q/7gvZnxiMcLsVkwd3l
	 iWb7OKEgRuKT2FZ+/URcFHeR35yfBLK0t9noie4GwDXZLzpMOpGVxDefTTd4vWYSrH
	 MjEG+b3VKf2oway+j0ypZvNfsmC1WzK7+8uBbg4mSYVyuVWWPfxOapz5lIcU+T8muQ
	 DM5lFAO/R7rBtJLaWRxzds/wh7SCBW5W585ZeemlWkZjJCEB5o1il2U5wsb+l/YPof
	 scz8zIdS7+qELjAYLzSi1JbJhEfvvgHW+xDVJoJ0Y0EFTP5tU7/h6AiVZcC7vjMiMI
	 4j57CH5hz2wZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: add bpf_icmp_send
 recursion test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515194746.50920-5-mahe.tardy@gmail.com>
References: <20260515194746.50920-5-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 21:00:52 +0000
Message-Id: <20260515210052.BFCB1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing packet filtering in root cgroup program causes system disr=
uption and state corruption.
- [Medium] Uninitialized `unreach_type` prevents ICMP generation and causes=
 guaranteed test failure.
--

commit 58dd624e2dc9a29c48c701ba76fcd20e713e626f
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send recursion test

This commit adds a new test to verify that bpf_icmp_send returns -EBUSY
when recursion occurs. It attaches a BPF program to the root cgroup to
intercept the generated ICMP packets.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index d9badfc6e620c..2363b1c7c711c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> @@ -173,3 +175,41 @@ void test_icmp_send_unreach(void)
>  	icmp_send__destroy(skel);
>  	close(cgroup_fd);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd =3D -1;
> +
> +	skel =3D icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	if (setup_cgroup_environment()) {
> +		fprintf(stderr, "Failed to setup cgroup environment\n");
> +		goto cleanup;
> +	}
> +
> +	cgroup_fd =3D get_root_cgroup();
> +	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.recursion =3D
> +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET, "127.=
0.0.1");

Is it necessary to set skel->bss->unreach_type before triggering the progra=
m?

In progs/icmp_send.c, unreach_type defaults to 0. Looking at bpf_icmp_send()
in net/core/filter.c, for IPv4 it requires type to be exactly ICMP_DEST_UNR=
EACH (3),
otherwise it returns -EOPNOTSUPP:

net/core/filter.c:bpf_icmp_send() {
...
	case htons(ETH_P_IP):
		if (type !=3D ICMP_DEST_UNREACH)
			return -EOPNOTSUPP;
...
}

If the kfunc returns -EOPNOTSUPP (-95), no ICMP packet is generated, which =
seems
like it would prevent the recursion this test is designed to verify and cau=
se
the assertions below to fail.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testin=
g/selftests/bpf/progs/icmp_send.c
> index 6e1ba539eeb0f..a2ef6a02c2cb0 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c

[ ... ]

> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data =3D (void *)(long)skb->data;
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	struct iphdr *iph;
> +	int ret;
> +
> +	iph =3D data;
> +	if ((void *)(iph + 1) > data_end || iph->version !=3D 4)
> +		return SK_PASS;

Will this cause system-wide disruption and state corruption by intercepting=
 all
IPv4 traffic?

Because this program is attached to the global root cgroup, it will interce=
pt
all egress traffic on the host. Without further filtering for specific test
traffic (like protocol, port, or destination IP), any background IPv4 traff=
ic
will trigger the program and call bpf_icmp_send().

This seems like it would generate ICMP Destination Unreachable messages for=
 all
legitimate background connections (e.g., SSH, DNS, or other selftests),
causing an ICMP storm.

Additionally, concurrent background traffic might cause races on rec_kfunc_=
rets
and rec_count:

> +
> +	/* This call will provoke a recursion: the ICMP packet generated by the
> +	 * kfunc will re-trigger this program since we are in the root cgroup in
> +	 * which the kernel ICMP socket belongs. However when re-entering the
> +	 * kfunc, it should return EBUSY.
> +	 */
> +	ret =3D bpf_icmp_send(skb, unreach_type, unreach_code);
> +	rec_kfunc_rets[rec_count & 1] =3D ret;
> +	__sync_fetch_and_add(&rec_count, 1);
> +
> +	/* Because we attach the root cgroup, let all traffic pass to avoid
> +	 * disrupting unrelated network activity. Otherwise we could just let t=
he
> +	 * first ICMP error message pass to trigger recursion and drop the rest.
> +	 */
> +	return SK_PASS;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515194746.5092=
0-1-mahe.tardy@gmail.com?part=3D4
