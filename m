Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514E370D5D
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556022; cv=none; b=ZNPivCgNMRT9QbZbJzMhsSoI3E5Tn2t7TJBpHvleNK35J8ULxX25zbGoJpEL5nSdfqP8r69wt6FDLZsyGm3wLNTtC9V4If1AFSxAASVjyfI35+1JeQ07K/9YU2UaZIWNIt3nXCnOAlpsylQCovxMvWDBpdPZ8K6U3X1O/OMcplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556022; c=relaxed/simple;
	bh=pVZtUT6bAcy1YAy6UpwvrO8GzHyqjmirjoQyRdI7jT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TKNKxNGzHtSm9O3cytTptJzZLxBS2CqeEzupIfGOWIt6UxYUM7DeHZ6/bUceYfmXVdBO8kz5NMWqhZGimPVFLFkv9jHW8pb66XIdFZ7QcaFTcry0S/dEaoTHKOVCtwBDpf72TVltMBSxEBhtKNwY+T4DZvszcBgsDW5tC0btyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMa1T/0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMa1T/0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF462C116C6;
	Tue,  3 Mar 2026 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556022;
	bh=pVZtUT6bAcy1YAy6UpwvrO8GzHyqjmirjoQyRdI7jT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMa1T/0KZdFeXnApGuQUP4NSJxMKLROhKfYRL72VYYnODL3T/CUyc//HJ8/0jGjon
	 tCdu0bSCXsNNoguwzgARerZflkDyi5314hxKmeVcmNt/lIcPqZS6nZxC9EgrWOSohM
	 eq6ueSIgyEIps/1ynsB22lCu6FmqVv07KYpkO1CyPo6LxCp+Bj4d2k/9JJUlDs/gev
	 VMiM20ixKLcVqFdsDjm/VKQXKjp93Fk1VkqVuZudW7vvcgrtinC9xQx+CRj25yRB4B
	 9izkk4jhGaUZNczns+VsJzfociB4kEoUjakV3+LaRj4cpyr8TJrXQEKtOhcCVin8cT
	 5odPW3WJVMaCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF0B3808200;
	Tue,  3 Mar 2026 16:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255602330.1378092.784944008193338204.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:40:23 +0000
References: <20260217160813.100855-1-iii@linux.ibm.com>
In-Reply-To: <20260217160813.100855-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Feb 2026 17:05:07 +0100 you wrote:
> Hi,
> 
> This series adds get_preempt_count() BPF implementation for s390.
> On s390 preempt_count lives in lowcore: a per-cpu data structure
> mapped at virtual address 0 or 0x70000 depending on the kernel
> command line.
> 
> [...]

Here is the summary with links:
  - [1/2] s390: Introduce bpf_get_lowcore() kfunc
    https://git.kernel.org/bpf/bpf-next/c/6fe54677bcc2
  - [2/2] bpf/s390: Implement get_preempt_count()
    https://git.kernel.org/bpf/bpf-next/c/0f87614c4dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


