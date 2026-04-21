Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77135C193
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770005; cv=none; b=lPX5ZNb2JqwyyskWTUoCOFnY4cas96cIbattsLFyOUzsSiDMP7651Uj4rqPj/v7PKsx+g1SZAIu1DlMfZ5/zLqhoEnPYBxkeKnlPJxYzjp/iz1q6YXx6q8kOYR+UdzelXfx8AuNbQwZfawJeRawSpIgObk7snuNe6gYqvIxw0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770005; c=relaxed/simple;
	bh=r+4ndBprULq01dd5C6U6AA7SFZeXs/V3B4q0gYuKqVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIh8AHfkbNlvT6Qqa8LTFV1cyEa0DMaPfKZFhhi4OecXXL6bli573Dpqu9T1gxZsOYBSH8aanV4X9ChiYhjyH2BWI486NhiEgBMqz2i8xn4Y//t/t+WSl4dXvjpAUSTxkeWfinf3TxtZFtU+KgE++0AnOEksSXQ6XIdTuVBNwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebMgZ5Hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebMgZ5Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FDAC2BCB0;
	Tue, 21 Apr 2026 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770005;
	bh=r+4ndBprULq01dd5C6U6AA7SFZeXs/V3B4q0gYuKqVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ebMgZ5HwJLkXVTbK7XzD4co+sWTopbXJMh/OkkGVzfM/zByCOKAGUQSiwBM8XdXzm
	 Ibz6VissrkP9m6WwyoYefFmUvG/vb9PkM1PTZXrzKwZA2AHFi40SKI0QTDRtILOUQH
	 LtepzYrjEbvAyIB2WdkfQXBe+sn6jdXcqDNpwpHfZXrQvHbtEvPOGISuVAKAslDxeJ
	 nG9bPjEtW8qWOBNOtVNJqGO8EIXf6tP2IH+BFl4TGxclTUL0DewXJS1bDUbLzff6xk
	 xB6eGFJdPH69tX5Yatu/UZqwEHj7E5ahn+dvGRtiuoZdrrhPzlMvWUrjiQAE48zXe8
	 xxtZ7pNctUZvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: add
 icmp_send_unreach_recursion test
Reply-To: sashiko@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420105816.72168-7-mahe.tardy@gmail.com>
References: <20260420105816.72168-7-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:13:24 +0000
Message-Id: <20260421111325.61FDAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The `recursion` BPF program drops all unrelated IPv4 traffic on th=
e system, causing severe network disruption and test flakiness.
- [Medium] The test leaks the cgroup testing environment by failing to call=
 `cleanup_cgroup_environment()`.
- [Medium] The assignment to `rec_kfunc_rets` relies on an indeterminately =
sequenced evaluation order, making the test brittle and compiler-dependent.
--

commit 61d5cc3970ae5880f18e7f23d796670f691dcd7f
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add icmp_send_unreach_recursion test

This test is similar to icmp_send_unreach_kfunc but checks that, in case
of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfu=
nc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> index 047bfd4d80f75..a4f4324b2b99d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
[ ... ]
> @@ -157,3 +159,44 @@ void test_icmp_send_unreach_kfunc(void)
>  	icmp_send_unreach__destroy(skel);
>  	close(cgroup_fd);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
[ ... ]
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

Since this test manually invokes setup_cgroup_environment(), shouldn't there
be a corresponding call to cleanup_cgroup_environment() in the cleanup path?

By bypassing the test__join_cgroup() wrapper, the test framework won't
automatically clean up the cgroup state, leaving the test worker in a modif=
ied
mount namespace which might cause subsequent tests to fail.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c b/tool=
s/testing/selftests/bpf/progs/icmp_send_unreach.c
> index 112b9cbfab6fe..9aca7c0b12e1f 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
[ ... ]
> @@ -67,4 +70,31 @@ int egress(struct __sk_buff *skb)
>  	return SK_DROP;
>  }
> =20
> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data =3D (void *)(long)skb->data;
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	struct iphdr *iph;
> +
> +	iph =3D data;
> +	if ((void *)(iph + 1) > data_end || iph->version !=3D 4)
> +		return SK_PASS;
> +

Because this BPF program is attached to the system-wide root cgroup, will t=
his
unconditionally drop all unrelated IPv4 traffic on the system?

Unlike the egress program which explicitly filters for IPPROTO_TCP and
SERVER_IP, this program intercepts all outbound IPv4 traffic, drops it
(returning SK_DROP), and sends ICMP errors.

This could disrupt host networking and cause test flakiness if background
traffic concurrently increments rec_count. Could the BPF program be updated
to explicitly filter for the test's traffic?

> +	/* This call will provoke a recursion: the ICMP package generated by the
> +	 * kfunc will re-trigger this program since we are in the root cgroup in
> +	 * which the kernel ICMP socket belongs. However when re-entering the
> +	 * kfunc, it should return EBUSY.
> +	 */
> +	rec_kfunc_rets[rec_count & 1] =3D
> +		bpf_icmp_send_unreach(skb, unreach_code);

Is it possible for the array index (rec_count & 1) to be evaluated before t=
he
function call returns?

In C, the evaluation order of the left-hand side and right-hand side of an
assignment is not sequenced. If the compiler evaluates the array index befo=
re
the function call, both the outer and inner executions could use
rec_count =3D=3D 0. This would cause the outer execution to overwrite the i=
nner
execution's -EBUSY result with 0.

Would it be safer to store the kfunc return value in a local variable before
assigning it to the array?

> +	__sync_fetch_and_add(&rec_count, 1);
> +
> +	/* Let the first ICMP error message pass */
> +	if (iph->protocol =3D=3D IPPROTO_ICMP)
> +		return SK_PASS;
> +
> +	return SK_DROP;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420105816.7216=
8-1-mahe.tardy@gmail.com?part=3D6
