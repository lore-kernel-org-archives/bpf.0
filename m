Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3E3D9699
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087286; cv=none; b=Pn+OUGBlsb/GTMllIrF3ESnQjCZIPfLPUEDlHKMx0rs7P/qFfQ2crpD8FNHbzctgJhv6b7nqwuWacu5MCXANjnkE1ijXsDg8g4jrNcV237IRPCYq+fyNCLyLiWXE+ojhIie6oR/OIBOz6Nb+X2IFaY9Mboosi/zhQTXCt3KjzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087286; c=relaxed/simple;
	bh=FClVMBvV5hACYDKN7P5PWZ3WpqvqPkFe2o7qLXBCEoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FkmzO3kQctQTld0BIW5etLBnYLxPH7tODO409Q67qN6Ty+9T58emFIzTSo1ZHrItQ1ZJbHPP9CwucFSofwtdehZHXqwE/PJromdToNJGcysw/NqATgsRieE31VhW/SxbJBUuvEhHgmi4enGEQUg6fuZBPJw31SAapeXYYE3etA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaFB9kAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaFB9kAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509411F00A3A;
	Fri,  3 Jul 2026 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087284;
	bh=693pyIXeJcV3IbrozF6B2sqQ3ouP/uH8kfDJFotyYBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VaFB9kAGrOcsrrO+OQ8CSm7s9HzKfZhHPnRjAw7TNIF7Y+ZODE/8bHnVQyrC+vTMX
	 XQxjNiTOpCt5mh1+wWHJrvqSwdzVJ1bCjf5vTKGq1QaXb6CYHN0TAeMCix/i1h9zSc
	 Oj6HQD+o+QnDMiovDyiusc+WRTXy+oK4pbzzxJp6OyMi84FI7aMKMzyQiwXMt98ev3
	 JUERIrivCMgmzbbcI+PWXCEliyXNFEtl66U90BS4RlfSVTMuc6kW/4CAIRcaLzX48k
	 2I40zms3JNEFwKCvcUO63xXlPOPBmr2nuSz2yC0Am5u1pKZjVMbuMPXPn2gUh+sqEI
	 KjpQ2U48gUfhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] selftests/bpf: cover sockmap drop after partial
 TCP read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dong Chenchen" <dongchenchen2@huawei.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702140959.1806754-3-dongchenchen2@huawei.com>
References: <20260702140959.1806754-1-dongchenchen2@huawei.com>
 <20260702140959.1806754-3-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:01:22 +0000
Message-Id: <20260703140124.509411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_sockmap_drop_after_partial_read` relies on asynch=
ronous packet processing without any synchronization, making it inherently =
flaky.
--

commit 375b8cdbb19df93db8af9c80a28cbeb5b3bdb312
Author: Dong Chenchen <dongchenchen2@huawei.com>

selftests/bpf: cover sockmap drop after partial TCP read

This commit adds a regression test for a TCP socket that is partially read
before it is inserted into a sockmap with an SK_DROP verdict. The test
sends an additional byte to drive the verdict path, removes the socket,
and checks sequence numbers via TCP_ZEROCOPY_RECEIVE.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93a..106dd03cde84e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
[ ... ]
> +static void test_sockmap_drop_after_partial_read(void)
> +{
[ ... ]
> +	err =3D bpf_map_update_elem(map, &zero, &p0, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +		goto end;
> +
> +	sent =3D xsend(c0, buf, 1, 0);
> +	if (!ASSERT_EQ(sent, 1, "xsend(drop)"))
> +		goto end;
> +
> +	err =3D bpf_map_delete_elem(map, &zero);

[Severity: Medium]
Will this map deletion race with the asynchronous packet processing?

Because TCP delivery and BPF program execution occur asynchronously in soft=
irq
context, the map deletion might remove the socket from the map before the
queued byte is processed and dropped by the BPF program.

If that happens, the byte could bypass the SK_DROP verdict and be delivered
normally. This would add an unexpected byte to the receive queue, causing t=
he
subsequent TCP_ZEROCOPY_RECEIVE step to copy 2 bytes instead of 1, which fa=
ils
the final ASSERT_EQ(zc.copybuf_len, 1, ...) assertion and leads to test
flakiness.

Is there a need for some form of synchronization here before deleting the m=
ap
element to ensure the packet is actually processed and dropped?

> +	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
> +		goto end;
> +
> +	sent =3D xsend(c0, buf, 1, 0);
> +	if (!ASSERT_EQ(sent, 1, "xsend(native again)"))
> +		goto end;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702140959.1806=
754-1-dongchenchen2@huawei.com?part=3D2
