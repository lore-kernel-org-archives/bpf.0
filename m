Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749943E0C7C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247215; cv=none; b=ZOMD1WfQCVDFk/YpKpGpWS28eUOxNQKrYzRSDLEerPVhqKzbiyAQ+LPhDKk6yb0mItMR90BIQ+zfPWipLRjX3FCMgQrPsXTVIEL9066ZRsIC2NhVVQfxR4WcdL08gCew51CF35sov53As51uWFMr2IDQrXpYkHafqshyp+x44Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247215; c=relaxed/simple;
	bh=oglE1Kufq4Nj1aaH1W8F91v9znSRmag7fImn8qcdr8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RquSMyLYIjCNwykoTiK9T6gT4O8Nnq4IbIQvhXtJnE95LN7EwDz1wKuYVrZ0/LbFfLIhibQ/2G7cf0UeQezpAaRYMXJfUqs/mgpyCxisQ/SNtX9LKxz/E3bH9rYo2jbNBofGY4ChgjaqcbZsdXvDampn6r+CzHj+VMyV/ReaWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvRSxRGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvRSxRGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3426EC4CEF7;
	Wed, 11 Mar 2026 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773247215;
	bh=oglE1Kufq4Nj1aaH1W8F91v9znSRmag7fImn8qcdr8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvRSxRGRpmTkyAwO26yOKpq/qnHXa9weYtfPgd/ipgbvOpY1NR2gYGAtioqt3xibU
	 LnlATrdF9ZPVwRHsSh4pxXC3LQ9P8FUu8IOzeJgSExoMD2FUuMePZJkB1EjNbeAQsQ
	 Rn2vb/l9ENjzyIn7/Y81kkQWoeT5Tp6/XWuzMU/ihm8gk2+GWtESk5Yv9luFnHKbZD
	 2dNbRsvNtiHmeyjl7o5YnvgnzXVQoxeFUeapPclYpkqFjLWL7c0hlZnIe61RJCAa3I
	 I/UGFusmLgdsVdJjhCRjvPz+SQeTW7M7ivfGnbVYJrTOsCv5eFRrpPrNdmS/Ks4/zO
	 yR+Y8p7ImQRbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF2A3808200;
	Wed, 11 Mar 2026 16:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Speed up module_attach test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177324721130.3744293.6181771015474364338.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 16:40:11 +0000
References: <20260306101628.3822284-1-vmalik@redhat.com>
In-Reply-To: <20260306101628.3822284-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 slopixelz@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Mar 2026 11:16:28 +0100 you wrote:
> The module_attach test contains subtests which check that unloading a
> module while there are BPF programs attached to its functions is not
> possible because the module is still referenced.
> 
> The problem is that the test calls the generic unload_module() helper
> function which is used for module cleanup after test_progs terminate and
> tries to wait until all module references are released. This
> unnecessarily slows down the module_attach subtests since each
> unsuccessful call to unload_module() takes about 1 second.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Speed up module_attach test
    https://git.kernel.org/bpf/bpf-next/c/900b7cc73ce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


