Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792813808;
	b=z7n8NJaBegycUV0i7T4/o/FjaoWCaYUglEVmEzVdEkD8/bd8QpSnH6uz7/+DcJ3BPASR
	 Af+GqC/94A0mdyfa6k+l+QUA0xHEaHtweeRcnwDVVX0Dr1MCK7Y9xn/+BkFAvlDcymJOL
	 oeTCIeO8Xz7Hge6/T2wdN0XgvPiAgp96/GhlB+fu80KPpKN1LhSjbpIi2EtQ2T7mE+B9Z
	 FTpfgtDx2qAqnWAter1qWmEuLzcSFcSnS8tf996u889aWK/zfj63cOA/b99g0BekO4Ju9
	 Op2lkvst/vD/3jmCggNJJSA9qfuM1Dq6H9SbAplJyuzRePoR0AchbyajyweLesFoYXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792813808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+4MejMJKUNb+D836272CdqqFDwtARUtaxiK/ZKGgMMo=;
	b=wQUgIA5KQTopcpwwLTfpTGmieRjj8/2ayJJGCZbMOTR6VAiicgECjUNy7TZPC4onZp8y
	 Tp8TKDzYneW2ayHveZsvoBFyI49FtZ0u6rpCd24j6GlG03FQR9bhl31VsoyoQ8HbQMr5f
	 BAX0XbePrWC0SklsdOD/1v//HqKtfHzDhgLRhxDdq4vGReiWhNcgwoilGx8Oa6nwpcsLv
	 3dNO/NW7imK+tmA+HHuEASJNkUSSrErwnJQZVZ0rA2tim4HY/iir8m6in0fdf3DZr2I40
	 tx2KT0/lcd3k1om7xaIDq0g38zsxKP1G3XcBtgMHHSBoR4pmfMpSSePB0/MdTP4MV3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMAYmtgD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BD606A31A;
	Sat, 24 Oct 2026 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMAYmtgD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C81F01825;
	Sat, 24 Oct 2026 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792813807;
	bh=+4MejMJKUNb+D836272CdqqFDwtARUtaxiK/ZKGgMMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMAYmtgDJz5a7ZDzdgMnxmnHA5Dwh38jeasxLTyZlZQ4ipP1bdAcbNjsVSLTr8EOO
	 f0AC0NeL71EJib5TaYSQLr9QZfYCQXf7V0RBoBLZ2oK+qmWBw9mwmUTmwxKdbXR0Ou
	 8954kxymnh3W0g0rIAc+TW4bvOTjjh4xTAGlJMYLkBQVRug3aQMvke0DMHoe90Xow3
	 hwRf7+vY1X0LPPUfhRZEsPZQLo4pmKHhXUIkis2Y2ROz42enSsKc3rGimfbpTCC0Tx
	 CJXVszNMSNCyY69b9bERrROb6inl+YXQ4gTgoEwh9/a2O16iTUBkPGlCd0DgFAjZ9Y
	 gwKnWQKW8RFPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE7BC391B179;
	Sat, 24 Oct 2026 03:50:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281380657.1449642.15113400726872173798.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 03:50:06 +0000
References: 
 <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: 
 <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Oct 2026 16:48:35 +0800 you wrote:
> st_ops_assoc_in_timer_no_uref drops every reference to a struct_ops map
> and expects a timer callback of its prog, 500ms later, to find no
> struct_ops associated anymore. It fails now and then while test_progs
> runs other tests in parallel.
> 
> Since commit 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
> optional"), a struct_ops map clears the association only after the RCU
> grace period of bpf_map_put(), so nothing waits for a prog that reads
> the association in between. A timer callback can then return into a
> freed trampoline, and the kernel hits an int3 Oops.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] bpf: Protect the struct_ops association with a spinlock
    https://git.kernel.org/bpf/bpf/c/232475c32994
  - [bpf-next,v6,2/4] bpf: Dissociate struct_ops progs before the grace period of the map
    https://git.kernel.org/bpf/bpf/c/377ab5f2ef79
  - [bpf-next,v6,3/4] selftests/bpf: Test freeing a struct_ops map under a running prog
    https://git.kernel.org/bpf/bpf/c/a451867eb5f6
  - [bpf-next,v6,4/4] selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer
    https://git.kernel.org/bpf/bpf/c/ac3df711a428

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


