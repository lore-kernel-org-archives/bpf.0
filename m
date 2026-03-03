Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635442F561
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559004; cv=none; b=WRV9nVKKboWVtTAtQTA/KNee3JsopFFm6htDLhPp71HL2M+h35bVFdcq//n5ajaL0tppka+8kjECKQcbapw/ZYK5wpFn8YmSD38BqF1jKbwVEU6MNouydW7SiHYkgBw46ik19BZQX1CMdegLnlM2ZpvAEz13SKz9CCUR6ldXJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559004; c=relaxed/simple;
	bh=WAecDIvaT+6PAVLqiZVch9LT/N0tKgyFseKciCkSoJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NmJPwXYDh65jcJ/ALT/BnIqKSXSKcRUCBBob+NQ+4hW1A/OCQ4yeBmQpAsjHh7/o20h6VTeUNBHYSiz+wTk7mV6fdv/SWXqOf5JiGz3/qt9vOPois0Im3iASZfGZf2Zz0ODtDddfqQDqhySvCX1rQEDzjlkLGBMGLiTDKyALzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPWCdQ7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPWCdQ7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE9C116C6;
	Tue,  3 Mar 2026 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772559004;
	bh=WAecDIvaT+6PAVLqiZVch9LT/N0tKgyFseKciCkSoJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aPWCdQ7TUjF6RbWrRfbzz/ZDzVCLv9Z4NsUDrlpDP0v42jvIeVyCF7xqQdutZ4wy1
	 2d2ucC4qfbyHDVMSJhoPiNZhQOK9HFCMeW/1/wb4PdRV41//3pIKH21XbnGF+NtEGX
	 SHXYDeAg7scVSVlQCE270bVnJ7tDUDhXIrzTIncwNVee9o+V0vNTrRtF4j0f27gFYD
	 6q/KeBEaWL56hPyRt8Nt6Y959kW5HOMq4bMqaN/02DzeIdKIAp8tqVLAKP2vhFNDGQ
	 txmATqUeZ71KX3cMVkZVuO6Vsg8DZ4Ce6UolsVgfQqVsIFbHOXkHClsbtRBvlAC1N3
	 Sk1651aZq4NCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FFE3808200;
	Tue,  3 Mar 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Split module_attach into subtests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255900556.1398754.11069934082669442357.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 17:30:05 +0000
References: <20260225120904.1529112-1-vmalik@redhat.com>
In-Reply-To: <20260225120904.1529112-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 slopixelz@gmail.com, mathieu.desnoyers@efficios.com, rostedt@goodmis.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 13:09:04 +0100 you wrote:
> The test verifies attachment to various hooks in a kernel module,
> however, everything is flattened into a single test. This makes it
> impossible to run or skip test cases selectively.
> 
> Isolate each BPF program into a separate subtest. This is done by
> disabling auto-loading of programs and loading and testing each program
> separately.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Split module_attach into subtests
    https://git.kernel.org/bpf/bpf-next/c/05c9b2eda8a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


