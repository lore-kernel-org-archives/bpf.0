Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3439E9AD;
	Sat, 13 Jun 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781322016; cv=none; b=nPuOrBp7cyEvCWb8Ox5+U26DDMzQE5G2uXRCNkRpjINChiHTP1UWmOk5xCQImRjvunQ9J8hSb/z8BtAYbHzIC64BdfyJAYUycq3OHL61QXk9IVyIZ5GCpdsq+vHH7ZX5ltOyI12fa3YY9ldEa6oM2EuX/UmijDJ3Ht+JCxPTmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781322016; c=relaxed/simple;
	bh=iVNTNmW7AfPOJsRka9dUIfK1/SA81v8w6HGedDsUdWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aAHbB9wvuqaTwL4dHISLhTcslQFUdA40eapS/oZ+4F/cia2SN63Cn0Tqi8b+yC8v72KuH/KSLVnCC8Cp9QrnQ5UeYhmbh878pB+O+aNIyJnmXgXuqQ0SZ0hP2nsgwt+x07RTfLiGb4fa/VGMzHrm9Rw2bWEbfEZ68/5C7B2jG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8H+g6F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8H+g6F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CA91F000E9;
	Sat, 13 Jun 2026 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781322014;
	bh=13bqDkCdcR0uhLPX4wI6VvKsDwP1Uaa3YIKoaR069C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d8H+g6F2Uo56gwnTgCjul4niytS3G4Ocplxu3xQ6ahUSZ2g4PyfhJcyhRGxgnhaGE
	 2ayYJ926svxMxLYdexgreDQOVIVHCOnJ4ybR5lmak/g0WUo+FNbnHAqthyuDR/e+Sv
	 48JwHGY71+2tuY4GQ24aPRlAp/z7KhgivtM/7mhv2yT5oRGuKwfyaa1Z1BQkUgT3PU
	 BEUpluXhbGDhBYRTPoE9f3/TyDTc17EVGeJDR1eMsnR79z3Fq7IqJdXPMTsD8eZBPA
	 AqgdOo6mJJs/wfYsZ2/tG73NzksYxeiBkKCub/3vh/+y7mU3zgc3dLcVhLWgzXRslx
	 FvYg+NWc5FnXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397539E9607;
	Sat, 13 Jun 2026 03:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix setting retval to -EPERM for cgroup
 hooks not returning errno
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178132201113.1349961.7433371950134456676.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 03:40:11 +0000
References: <20260610201724.733943-1-xukuohai@huaweicloud.com>
In-Reply-To: <20260610201724.733943-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev,
 mattbobrowski@google.com, kpsingh@kernel.org, sdf@fomichev.me,
 zhuyifei@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Jun 2026 20:17:22 +0000 you wrote:
> This series fixes the issue reported by sashiko in [1]. The issue is that,
> when a cgroup BPF program exits with 0, bpf_prog_run_array_cg() sets
> the hook return value to -EPERM if it is not a valid errno. This is
> correct for errno-based hooks, which return 0 on success and negative
> errno on failure, but wrong for void and boolean LSM hooks. Boolean
> LSM hooks should only return true or false, and void LSM hooks have
> no return value at all.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
    https://git.kernel.org/bpf/bpf-next/c/4c71303c8374
  - [bpf-next,2/2] selftests/bpf: Add retval test for bool and errno LSM cgroup hooks
    https://git.kernel.org/bpf/bpf-next/c/cec842377617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


