Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792818609;
	b=2q/Rz0C9rXa57Yw6rWDayjYi5tXCPxgH/H9cGMvJmxzyrG62Za9/RakDccQW0I4SVD2i
	 k0iJpbcJgsCfvdfirfUTkgqErzSyvCy6SWGNIsRquQCvidw5x6/QkSzKLExUNkVZV8kGy
	 OJMDtU2eZWnmuiVNMiQxvIcb87/AUD8q/dy99WubWOJU5XRiKNy2GFNUB5Gq64Etx+evW
	 tHB9MQ9X6k/gtvkwjxBnECMi7otoNADapMKgJVkmPLCDmX0Z8UZPB8eyObEuP59tJi5p0
	 oGhxSUWzOzbxCPCc9X+ngUbkSRxjElLofyqqNhEEhdTqO+uvCU7vIj2vU7jA/2jjU9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+5yqUHfrrkEhGhTjK6jc69LcasOC2fD+GLooCnMI9qY=;
	b=RVxfaVbWDKuNkuHII5FbbygdOcABRVE7bcCZx6M50TvFWZX5tNg4gXKSU9xKm0B2oOUS
	 BupMO+PwNrK7h9Fxw5GcTmBmDGZgExODKrhjBiJeV2jv5rGwd3oZ1gFAR54rp3hEdVRhE
	 rCNCs4acwKnsuRudBSbgyGNIpptUCS9HTWbCp/kFDAMvcgz7ogEqxLlHJwfSWw2jvGhGs
	 Njz5mQt1QK+xhjzjx+BsoCc3MUrM6U4e7imPB4IF1lvPOcPdubOPhx6vt2rDs1wSF1Nhd
	 o5mlOSnwy37RnGMklVbYQYdG7nGeY77HmgH6DFcHw7GiDWnyCjseOpXdHODXSq87iTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxUy0IYs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE4606A31A;
	Sat, 24 Oct 2026 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxUy0IYs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA3C1F01825;
	Sat, 24 Oct 2026 05:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792818608;
	bh=+5yqUHfrrkEhGhTjK6jc69LcasOC2fD+GLooCnMI9qY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lxUy0IYs95tYzHa6NS4Kcqf6CVRpoibReuyQcKdDSNRHzch3bf/XVyX1GObwzFway
	 03oJ/AROMp7JzzyLo9yduqVZAQap8SnGE6NvvsxN8VItZmznVxWG7gBrL8SCcR2WCh
	 ADkjbH7F0RDJxRSfVq5SczO1fOJYXxhmuKGJIR7c+yEsVFEcd4CwNlwa5njoWBJkCM
	 zve0wYQQygQynuC2Ykr9thdFyBe6t9lzQTTqLbd4fLMIo22y+5cgnGx1dC5eiyyn5m
	 LENZt4WdR0l5O2wO4KJCvdH2gj6b6PhxlGioqWcYf1ltTLSTbh7BcVetfCBy64DLrM
	 cXlgnupljJ9kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44587391B17B;
	Sat, 24 Oct 2026 05:10:08 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix bpf_send_signal_task() from
 kernel
 thread context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281860707.1477734.466775423559947933.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 05:10:07 +0000
References: <20261001072449.1377267-1-adi.sharma@zohomail.in>
In-Reply-To: <20261001072449.1377267-1-adi.sharma@zohomail.in>
To: Aditya Sharma <adi.sharma@zohomail.in>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, kpsingh@kernel.org,
 matt@bobrowski.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, puranjay@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  1 Oct 2026 12:54:47 +0530 you wrote:
> bpf_send_signal_task() returns -EPERM whenever the calling context is a
> kernel thread, even when the signal is for a different task. The
> cause is the nmi_uaccess_okay() check in bpf_send_signal_common(),
> which is a statement about current and not about the target task.
> 
> Patch 1 removes the check, as the signal path does no user memory
> access and the check has nothing to guard there.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()
    https://git.kernel.org/bpf/bpf/c/93bd472336ac
  - [bpf-next,v2,2/2] selftests/bpf: Test bpf_send_signal_task() from kernel thread context
    https://git.kernel.org/bpf/bpf/c/2c79610f72bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


