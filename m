Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7936D51F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812443; cv=none; b=qqUTWbmo5eA/K326TfZQQruR5oMbIup5FiLFclfuGg9DG6Z9gRvB8NdOyIV+Yg7MfaxEulNihwgvUTkPFGqETnJe7h3d0mEbxYmr+l1y2CO7HM1TP1/ObmiYRdE5RkCNd/IRhaqQvrMJ9KAKSc5HgywpY8yaE1g0j6z7qNm+uKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812443; c=relaxed/simple;
	bh=SrwTwrfcakfm8KlIbLxUGVRV7G3fFfsel2xTVoF4YZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uRFUv9ePfQ00hqmDwYHhJ7ZPt2d0NhRMNK7IYnYNB3yNwCNH6XdZtbT52cuMMJGARDrhI9Hi1vxbfIRvxBL31UaoEvyKS4wjszvcJKZ0y4VCotn1QYqnlUjCyW7faxvpIKMNZE3AUtB548dAy7GbuSpI5OCwAn+qocsAQDxLFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXWDwxdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXWDwxdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9846FC2BCB0;
	Tue, 21 Apr 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812442;
	bh=SrwTwrfcakfm8KlIbLxUGVRV7G3fFfsel2xTVoF4YZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sXWDwxdnzDPjati6Gi4H0+g4fcoei7upipGJ30DUkowHvevONUAelVqKjqbfye+6r
	 QS/Z11QAR/JMPEJzsv3m1zLy0BmaHTcwez2N+CgvrlkUE0ksUA9lvE4glLO9Hb+J5S
	 Ue3ehSvsyP4wg24+d+WLsH067+yzuE05GOA4wHS72F/kWYutspr3oBOzZZ24eR1gra
	 K3J2/MkVb/dC5FVW0yRH3g7oIRIqHdpGn97OuSDvMWFdtgpmGCzJgQFqmDaPZgMrMz
	 NGgaAEk/vmSX4owVKedC3j7TS7PZe5iggOYccGfEvs2FIxR5v5ZOI5UOBaKJSKFv3t
	 bto0/VMS27wYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D9E393020A;
	Tue, 21 Apr 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] s390/bpf: inline smp_processor_id and
 current_task
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177681240559.3038431.3671881704528464406.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 23:00:05 +0000
References: <20260414142930.528751-1-max@linux.ibm.com>
In-Reply-To: <20260414142930.528751-1-max@linux.ibm.com>
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Apr 2026 16:29:26 +0200 you wrote:
> Inline these calls in bpf jit:
>  - bpf_get_smp_processor_id()
>  - bpf_get_current_task()
>  - bpf_get_current_task_btf()
> 
> s390 has a 8 KiB per-CPU prefix area in the CPU's
> virtual address space, called the lowcore. It is a
> struct that contains the cpu number and a pointer
> to the current task. These are exactly the values
> returned by the BPF helpers.
> 
> [...]

Here is the summary with links:
  - [bpf-next] s390/bpf: inline smp_processor_id and current_task
    https://git.kernel.org/bpf/bpf-next/c/9012cf2491e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


