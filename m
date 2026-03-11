Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEF3DDDB6;
	Wed, 11 Mar 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247217; cv=none; b=d1qcT/IZwej0Xk45I15JFWxUkPJ9LT5g2hwX7nt0m7Pie16I9jsdT5qnc4hXxAX1Kxjz6R/8sSuV6VKhjView36gp2sJJPGl+Kv1Rh7isl2L8AVP066JmnmTCO4SYvs094GBkVbGm+VtLnkumSMRZSR0tc7lsPNRqqV7Vn1fX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247217; c=relaxed/simple;
	bh=3haxPrvoOERxfJywZ9OYABdIOP9HtBpqmHOCHCOKxLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LG92gO3LWefgNL8xxZ5gs1SlfDHGlhhShyyuIUBdK0hshUO4M2NP2xZOiXPCWSnziZgP37t8Oqb2wSvVKXzrA4HwJ4nx3yGvMnl+J7F7KvFI2irtdrtFBblvyxrGAasj8dKTsya12szeQAhMHJNQ1cPM36nH9b0/6X939imlpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfDNqoWF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfDNqoWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3130C4CEF7;
	Wed, 11 Mar 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773247216;
	bh=3haxPrvoOERxfJywZ9OYABdIOP9HtBpqmHOCHCOKxLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfDNqoWFYhdujhV9IOYoLDVkX6/RaS8MBI+l0fR0aQB/YDbCwCc6QWj3c2DVinfZV
	 rPxqoqFlnGzDj+ZVJVENOUknqzOkyPp4PzbAm4ruwYFOexE6YnT9BZpwjZ8aPncmge
	 t88TnIPqXhzP+jAnEPy/jX3F6PUPONhbpqGNwXZHMdMWQepTw9yJF0f2sPWV144E2S
	 MImIrH1gw3oZU2rc+/dR2UcfbbNRV67BW0GULaVpqJ06ZseE4GRMVoopOBE4P3eaVA
	 o09sOWb2tSJw6F6H9UhVbyWJBP5sXGVMmYpsa9KhJk5MMWLImoBkE/Z14CW7+/vrx/
	 4n0z4tX0lD1Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D093808200;
	Wed, 11 Mar 2026 16:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: livepatch_trampoline: skip
 when
 prerequisites are missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177324721255.3744293.12344401725525506418.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 16:40:12 +0000
References: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 rostedt@goodmis.org, jiayuan.chen@linux.dev, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Mar 2026 18:44:48 +0800 you wrote:
> livepatch_trampoline relies on livepatch sysfs and livepatch-sample.ko.
> When CONFIG_LIVEPATCH is disabled or the samples module isn't built, the
> test fails with ENOENT and causes false failures in minimal CI configs.
> 
> Skip the test when livepatch sysfs or the sample module is unavailable.
> Also avoid writing to livepatch sysfs when it's not present.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] selftests/bpf: livepatch_trampoline: skip when prerequisites are missing
    https://git.kernel.org/bpf/bpf-next/c/c02e0ab8aeec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


