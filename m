Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A333D518;
	Fri, 13 Feb 2026 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026659; cv=none; b=T4eYkH46OoG663fuE3LvBQceQ1uYz9qa1oIHakAHSdUm9gqTN9x30B8Favbl0UueIgypA8t9WhD04KHv5mxVuxpjw1dL0kRTnA+AhIH+3n5lsd2I/uC9VKo5TzU0292PepqiqWuFCOIP4XbA1Ep76dB+GfdZH6BUE86V4vYAXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026659; c=relaxed/simple;
	bh=QoKSwSBqaOpHpkjTew6izt4GjR7iLhEwaoFWROxFqU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I26S1AAX+M7phJ2KgvzRCc6eOgaLW1SRZZmPfl+lsHhzU/h2E/EyOnCdOCMlQblgJvvY1aYTXFhNtcc5Za+j4JK6HaklwtbZ/7P9Pi8rZXToX0v2TpjG8Jsc7mFVz7YohfUmlAgZ/NoBmZQJH1Rbnxr5+5+BkuM3l9Truo3KaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOEHHCPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOEHHCPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC3C116C6;
	Fri, 13 Feb 2026 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771026659;
	bh=QoKSwSBqaOpHpkjTew6izt4GjR7iLhEwaoFWROxFqU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOEHHCPFmdLlRt//NivYi2N9zSKkBexO9hurNKzWXSYkuzFGWrrRWxoRM27S3hhDf
	 c5Ci1IJ1PJWQ/ZsKRL5b5G1Pi3h1IyUbMrEitNLnNm9S9GvLau8jcAag/9UypOouEH
	 wXbVwyLXb4VVQZHpr1oZQ+7JzjwARGgKcQn43H5QL6BXLjNG8c/gJ74PIUWVWkUI2D
	 pnCfvn+7qMEDqDcQROGlWFJNOMtz1Dxst8Na1t0Z5sUIDcM90Ly8bW6eUJ8lyfL0Hp
	 PyktTrKI80RVICjuYRxMNeaRpSoSv6odVNWM363TM2DT8MXla0J7z4VNSfGOO0nOAb
	 Uj4GZRGURdPMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B01A3811A44;
	Fri, 13 Feb 2026 23:50:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Add powerpc support for
 get_preempt_count()
 in selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177102665283.2575868.6086661515797836268.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 23:50:52 +0000
References: <20260212092558.370623-1-skb99@linux.ibm.com>
In-Reply-To: <20260212092558.370623-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com,
 sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, christophe.leroy@csgroup.eu,
 maddy@linux.ibm.com, mpe@ellerman.id.au

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Feb 2026 14:55:58 +0530 you wrote:
> get_preempt_count() is enabled to return preempt_count for powerpc,
> so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
> bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
> powerpc as well.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
    https://git.kernel.org/bpf/bpf-next/c/4c51f90d45dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


