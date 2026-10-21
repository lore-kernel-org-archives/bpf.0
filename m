Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543807;
	b=f25h62Zk2R38iPeCawiZZaoqsMLNmGV8evwMNZBccARGD6jH2z2ISaY9CGD8Xn9ReM3K
	 5GVtv733DaYqvtmjeDMDIUO6x9d85jBdz1LfGyR1ubL3amRqAaOqDMo/84q3pY4SIApgu
	 QuybG2MKy87IhKHAF+NGT5GFmAT34LfoIv4DiOiyC60AdehaT+TALf49VtbAkqF8vnQXW
	 tQkm1z57il81dsaqSX89lTQjMpt+euJ/QdjHFIpZVf57HqVUUK+M5coFVAOsnH00K2fGv
	 QDNXPXSWlr+fo4qV6ZXterzT5R4u7BvNs4g7okme2GiFDnQAFPzXKPcjCVLKPF8LMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=btzv8yxdLMuufig8GN8fOweJKrlu33F8NF1e7HqNh6Y=;
	b=5nQj1D7Mlh19OXzZVpGTiwQfWOQH8STeLaMPOQDouHvsPrRNxc6tfTWZVUzc0ZuPE++9
	 7Cf5PaJswoTDhQ0z2kVg2d0133zTZTWTp04NZTD3z40+1xsRaxijVi563Ub2IGFb7v82m
	 3KXLrDbVIpFbY3oHnUK3iZrrddfQnXnxXeTKMAq0rfQX/M9qHSNW1jnirM1VzUAkjcnPw
	 By/6CFIJ4/wAoR74LylAHLTe+IwFCtNdCvUkzwN1p3DkzAGxAClUX+inLxIIOzXIGs4OL
	 zeu8N87vXq9BO+FoVp008P70g5WY9JPeX/0fESu1qTs0mtp/Buy5AZL6AdBGJsXI68A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lo/4Gd8t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AC606A319;
	Wed, 21 Oct 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo/4Gd8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063971F000C9;
	Wed, 21 Oct 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543807;
	bh=btzv8yxdLMuufig8GN8fOweJKrlu33F8NF1e7HqNh6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lo/4Gd8t0xdKeFxm8pH2mSZnImTANzVJqqmkMenB9IpMPWKCC4AXLET2TsKHl518z
	 FdeK0Ww0uc1FcyEEbapDCgX1ly2TdxHFkGrVIzQWQ0oEHde5w/CadH+H4lOwBgNsMH
	 y3t3Ai5I7Ox9ot/Hp2DwzI6rubKIAiV52S92p7DI+ryVbCNW4Z634QS0rur81KFYAD
	 x/zWMwa+OnBQiib9y9EtazxSeRyAheLakIDYaPD96sCaAZBJDineWoyRvVqwtnbW1r
	 s31drer5t8JoDxK0We9IOMiWYeJvDZGHEQVc6aAR+gSgsewuLJ7tgaeDSGmabdI2EI
	 WlTwmd+VxOY7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F152C3809A0C;
	Wed, 21 Oct 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Time tc_edt from its first
 packet with data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254380580.297162.17752534638843075425.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 00:50:05 +0000
References: <20261019-selftests-bpf-tc-edt-serial-v2-1-41c3813e7916@gmail.com>
In-Reply-To: 
 <20261019-selftests-bpf-tc-edt-serial-v2-1-41c3813e7916@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, alexis.lothore@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 14:35:55 +0800 you wrote:
> tc_edt sends 1MB over a TCP connection that a BPF program shapes with
> EDT, and checks that the rate it measures is within 2% of the target
> rate. The transfer takes about 200ms, so the margin is about 4ms.
> 
> The measurement starts before send_recv_data(), which first creates the
> sender thread and accepts the connection. On a KASAN kernel, x86_64 VM
> with 32 vCPUs, that takes 0.7ms when idle and up to 4.7ms with all
> CPUs busy, while the BPF program spreads the data over 200.08ms in the
> median. The test also fails without test_progs -j where everything runs
> slower, e.g. on s390x and with ASAN in BPF CI.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Time tc_edt from its first packet with data
    https://git.kernel.org/bpf/bpf-next/c/7c3188f84b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


