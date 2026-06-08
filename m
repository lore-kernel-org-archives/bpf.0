Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E63812D3;
	Mon,  8 Jun 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925512; cv=none; b=bn1gX4sToRYwzkzowLX7Z/YJw6rLykzexQ9ifaAxC/QLBMIE7UYEFuRtry9xpsMv97KU2nCVy8+BN6KWDOFwIs6+snaOhlvYLMCfmgYHUTYEfQnrhNgEdcP+ZgOFapbAu2+X0A/3iOWCq0iArwSAb1ovRdxSbmLI+CgzBtXUFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925512; c=relaxed/simple;
	bh=kuyvvj+Mp4x9S+syP+xAhNTdiJddrx2uGyukKH7Lu2Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VZ6cgHIy20ieh4KBG7EnJPek9bEYMlQ/ZGt5t8Kuc4HSZvqdCqeOJWy0jGDeyz8CKhOLYqPM4KQA2sV3664ZoAo4yya+49qmXZ2I+0IKqeao/iNQVxQx9kZOgvlSJv2uma+XrYlZZc7N/jncs9N4VGOdKKDLIEbGS8XVxP6O3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKw72Vsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKw72Vsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE31F00898;
	Mon,  8 Jun 2026 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925509;
	bh=3hUCD52RQZCWYTA6/jfn4ZCEYBcs2/9ic1Q6KExOLzc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OKw72Vsk86BhNF41oeC7W6l2DuhElFkbTwQ4S2c4fTWakIrbXO1nROmNEbRKWTzy+
	 dVq28g4gweCRvHXSlpdBC6bk+ZHS2ihmEAT4Orwv5Qg36TcGP9ngJixgAHV8mF2hQX
	 g44IMaDIfx3idL8XPCtrWQP7qgWvWzf1+pDi7Jxf8ayjsBty/fW6JHdRTYU3mHShHO
	 tNIFcB/NYgMhhBJFeZDWKXi652XIUqTwiEIg4pmrQsifMTXxg6XW9BTeqDMdH9a5p6
	 bELnBpVdySMQpmMbAd8olsYrBXNHU4j8lRAtLVbypSnqTnSuyguQuz9i3HPt2wnv7s
	 hmoQZLcT9ujCg==
Content-Type: multipart/mixed; boundary="===============5164577399796536821=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <520beb0ce4f6b49c0e41862bd9bcdbc9e4fdc85581cb8c3825516a22c62b7170@mail.kernel.org>
In-Reply-To: <20260608125846.157004-3-jiayuan.chen@linux.dev>
References: <20260608125846.157004-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v8 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,willemdebruijn.kernel@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,joe@wand.net.nz,kuniyu@google.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 13:31:48 +0000 (UTC)

--===============5164577399796536821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..b644acd3e903 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c

[ ... ]

> @@ -145,6 +145,85 @@ void test_tcp_custom_syncookie(void)
>
>  destroy_skel:
>  	system("tc qdisc del dev lo clsact");
> +	test_tcp_custom_syncookie__destroy(skel);
> +}
> +
> +/* TCP and UDP servers share the same port. The BPF program intercepts

The BPF subsystem style guidelines ask that the opening /* of a multi-line
comment be on its own line. Should this be:

	/*
	 * TCP and UDP servers share the same port. The BPF program intercepts
	 * the UDP packet, looks up the TCP listener via the dest port, and
	 * attempts to assign a TCP reqsk to the UDP skb.
	 ...
	 */

The same nit was raised on v8 by the automated review at:

	https://lore.kernel.org/bpf/20260608130746.218891F00898@smtp.kernel.org

> + * the UDP packet, looks up the TCP listener via the dest port, and
> + * attempts to assign a TCP reqsk to the UDP skb.
> + * Although bpf_sk_assign_tcp_reqsk() assign udp skb to tcp reqsk, the
> + * network stack should not crash.
> + */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27139886597
--===============5164577399796536821==--
