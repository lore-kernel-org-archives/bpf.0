Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E125F7A5;
	Sun, 31 May 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780244412; cv=none; b=WeBTtzvDTpSQuFrA+pY8LoMd4j60nPvu6WRWiVe7kMXjegovcryugRF8hPGwS9uyo447IbsgLvgC4L4KRbMflwH4kun3UZIrwPWQJoYGbcCWcdPWoYdEOFQqMtdFwKJ2tjF6Xu5C58mSzn45LEhT5MXdL0Ns4c3IpdRFw8ENmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780244412; c=relaxed/simple;
	bh=d7Ks5AfGzNPtzFQrMSc5GGnGCbasmw+Xk5mJNMjvT3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N5vT1u+WDfHTQCTH9ahVZ2Jt368Mmi2pxqQ7A0DXDgOd8JCtDTSsKxtz/s2IPQPyNduIZEg/7EyHZ5uXGa/Szw+hJqC1l9aZVmyeTPll3Zk5TJznmi6B9YhFImPECBhbDTvdYjUFquen5r1vuAseL3awFgNHH7OT4IFxlnMddyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bewiwCgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bewiwCgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B196C1F00893;
	Sun, 31 May 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780244410;
	bh=hnv6GbhPuz3vGa0HA6tRNZSKBlVN7uvJdLKnMl11kW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bewiwCgMXWiHz6oct8cXk8H4WsBzYlog+FRAqk+rEoId/1Y7NfEFmOzqM9kv1kL2h
	 5s7WqcKCSIr6TrOg4mco66vL9GUKmeVGdNYkseor7gLSaisiDwLeoYJzD0L5Gr0OLJ
	 8k84pCstvmvQ5/DdJCe5zdTEZnGw9+fwEEZxMlAljAR4QUtC1IBkFw25RhVwKZuAcb
	 P85UxyX9JJ2wTJ0pjug7zDx0v5rF+JMm5MaTmkHEfF7dNnS6PFc2h+79jAUO5fa1l8
	 /OgfmVABPAaiJWHnL+pAEN+klPd0AcwPYE+USa7ySAN+QJjoz60AqgaGJxvZ6bKmY9
	 WldqHoZD95JnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8C39302EC;
	Sun, 31 May 2026 16:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Align syscall writeback behavior
 with
 user-declared size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178024441364.2925449.1504432439651064028.git-patchwork-notify@kernel.org>
Date: Sun, 31 May 2026 16:20:13 +0000
References: <20260531075600.4058207-1-yuyanghuang@google.com>
In-Reply-To: <20260531075600.4058207-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, jolsa@kernel.org, john.fastabend@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, shuah@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, leon.hwang@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 31 May 2026 15:55:58 +0800 you wrote:
> This series fixes an out-of-bounds write vulnerability in BPF_PROG_QUERY
> while maintaining backward compatibility for older userspace applications.
> 
> BPF_PROG_QUERY unconditionally writes back the 'query.revision' field
> to userspace. If userspace passes a smaller 'bpf_attr' structure (e.g. 40
> bytes, which was the cgroup query layout before 'query.revision' was
> added), the kernel performs an out-of-bounds write.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat
    https://git.kernel.org/bpf/bpf-next/c/21c4b99b27f3
  - [bpf-next,v3,2/2] selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
    https://git.kernel.org/bpf/bpf-next/c/5add3a4ad1a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


