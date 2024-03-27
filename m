Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF9139589
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557037; cv=none; b=icKJLl+7SiFDAzq/sRP0b7H3RxStkiUUGaLJYBMwLtjHUa+lHGLJg0a5sHRWSK7VeQStgL/PH4uGky7m+mmEgRW2wBqG1Sd6gHNbOvTDX1vaK5wFzjherDWiw74Q8/eL1XKwX0/L1owtLJSr2lMPHcAKJO5NM/KNBeiQAMm2I1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557037; c=relaxed/simple;
	bh=juDkeDzotP3uJps0XSMfXNYUxgsPmeWL9RIl7vdcllI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IE0lxKcL1YlWtQ7B2vLx8cyi6bOFxapVcuWgqEwWGX2sIs0e1cVt6RCW4TfhO0suLf82KVdutCLtGLqVJT5qWfrgkXkzDhQqtPFqqokMsxT95QIacCd8Y8VqcbbulLrMQHqjDceL0kpXw+Xt6mcOvAGH3KOJuPGA/m1wXvxqFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3/J+tRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3/J+tRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78DF5C43394;
	Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711557036;
	bh=juDkeDzotP3uJps0XSMfXNYUxgsPmeWL9RIl7vdcllI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3/J+tRJ5oit11oMg2bUBL7M7QGk7fT+Mym4SmhsheR6DnebL3bQkQQVywN3ymWeF
	 wEGeIUa6no/EtIg86zKZrPeAAA+GzhSuIKYrbAvuSMQ/A0sgNMw31JpT+LrW1R6OjH
	 G0FiDpsw7zsS3j1NJ8gLM9JWpafLOVqnFPq2KULOxIM6NCcq59B22XxA/GbJsqPQXs
	 cjPjxLJI3Iv0QfAm6eFEVMXCcx+2OrJtJGlX2B5F6dOHa1YjmMsgeuMrXH+4k6aIYY
	 CwNggjjvY3mhFWKk37vcurrCdt3q28aiOLdUE2bpS0f13bndUw+XAyyYOy4ee8Hrfb
	 6LqRTecd7+0Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A655D95063;
	Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: improve error message for unsupported helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171155703643.16147.8693476873039047007.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 16:30:36 +0000
References: <20240325152210.377548-1-yatsenko@meta.com>
In-Reply-To: <20240325152210.377548-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Mar 2024 15:22:10 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> BPF verifier emits "unknown func" message when given BPF program type
> does not support BPF helper. This message may be confusing for users, as
> important context that helper is unknown only to current program type is
> not provided.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: improve error message for unsupported helper
    https://git.kernel.org/bpf/bpf-next/c/4c91c5925ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


