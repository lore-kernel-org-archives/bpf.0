Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCF468C19;
	Fri,  4 Sep 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519019; cv=none; b=GS4rxtahydsefpRDe033aGnwZoZsK42MCln3JvwvFFp/nf360uIpO363y8/uJrJzIRxOtSK0pNVF5ZcCxSJ7cSOh9yJHuAEGe8E5fAQ5EXi1UBHt11jl5vk60TVL399R68NBjja8PDoZL1heOYyVsF9MzqlldKe0x+JDe92ufOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519019; c=relaxed/simple;
	bh=s9uxXFvpTCk/Y5jnAxuIOLJsohEAF1Y8vrCJuw7ayKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=slLvrgwI8FTSXTxkS8CW7V6HCNpBubh9UAj6Cze/vhMcXcyNazjEgpMzvfmhGnzAQGR6H6JZRNWrNEOehd3V/g3UVIhF7HQYJ0KT6A62gNvKnNdmvpiJH8w3kbZhxtJPjCnRTS+/XKH9un2ez1gzryutF1WR+d5Dhwt1Mil+1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvYEZbbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvYEZbbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6351F00A3D;
	Fri,  4 Sep 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519018;
	bh=TAFrTDe5umwoBlyHKSIuK627CJ1GvkzYaJrFzDktHY0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gvYEZbbH/+d5NqS2Pu1v01hlJa0gJpW0mRt6YEPf8uywcAlpBoWGHMAU2opdrftOk
	 rrTxnadveiLckCaV0amQpQOuJyGiu2hufEfH/XbG6eHgjyQoTIntJgxk25uIcGS2dI
	 d2zwdrSHKL3n1ImQf2i/42BZBW67F7MJVldq9oi+jPS3TJXzxhSqSwWsiBkEHUs2Sm
	 Ns9JbCPUpRYCI78QcPtvVmz6iMJyLR2epoO5g/FSoQJOFxmS7Cwp+ewXPcRTcLyTER
	 1PQ6Qm2S/EE/reA3gODQVg9M46IYL5JtFJ6oSeg7qcUr82AeCdkZ+AfGvfVA5KPgTF
	 +2YGcDM4lqZtQ==
Content-Type: multipart/mixed; boundary="===============5450880720553597705=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b47a60308d94d4758e016e7850c9090a412f20b1d4f99874431d9f935e54901@mail.kernel.org>
In-Reply-To: <20260904094954.63447-2-jiayuan.chen@linux.dev>
References: <20260904094954.63447-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test bpf_sock_destroy() on a TIME_WAIT sock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,aditi.ghag@isovalent.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 10:50:16 +0000 (UTC)

--===============5450880720553597705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> index 9c11938fe597d..b90fab7073386 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c

[ ... ]

> @@ -204,11 +272,12 @@ void test_sock_destroy(void)
>  		test_tcp_client(skel);
>  	if (test__start_subtest("tcp_server"))
>  		test_tcp_server(skel);
> +	if (test__start_subtest("tcp_timewait"))
> +		test_tcp_timewait(skel);
>  	if (test__start_subtest("udp_client"))
>  		test_udp_client(skel);
>  	if (test__start_subtest("udp_server"))
>  		test_udp_server(skel);
> -
>  	RUN_TESTS(sock_destroy_prog_fail);

This isn't a bug, but was dropping the blank line before RUN_TESTS()
intended as part of this change? The deleted line had been separating the
block of test__start_subtest() calls from RUN_TESTS(), which is a
different kind of step. If the grouping was intentional, could that line
stay so the diff is limited to registering the new subtest?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33861180631
--===============5450880720553597705==--
