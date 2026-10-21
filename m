Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551006;
	b=hSf8ozyaqAW9dc3BIpus47XlqDdyzq9F8ArgRHWo4e6lnlOGjnoYClgX6uvfSOCg2miM
	 4PojX8uZH4or7Z2PWcjfhTfdGElnf9hGfcA+NffCEQowgwBpBpxNErLR3aThx4/vONWaN
	 gz6MYJipho3bHJ/PyoBeQXlsu2jlTrxZDvzpSDQQnzPVJrGwhZtDaiwwcT3LPhyg5r7k1
	 Xg0XkPTq6d/auWudPh9J5f0KTnnQ39+rZHv2/rFwLBi18lrH0L534p/Iq/I4Ga0lQ6Q1S
	 1wXoIAYIUQnnt2HBNqWN0ExPnFjDmdGP5pm1Fbg0/+dC3x0cARW8R6F/c9ivIFR/lpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=J/0LdjEtn9CGZq4Bd8pDsYlZBnyNvZj2vRgzmFMbmxY=;
	b=v4H5GkkjX4HPTrVgdaYJh17q8eT6B0UrBKIJlw640n5kkRmhag8UxYeohnc+ZwAPimqC
	 mXdhCl9b9kKMc45BjiqENM2Zy0DKS/+x2fz17K+VQY4q5Yly2uX+Ll3kWMRLqpUiCAB6j
	 CyIass77/vS3f72yARZoXse8YyuIENDGcrfTPI6bbQoLECF1Pm5tt0PdQuOwgLx9tCj/u
	 qfEKAMl5eeinCJ47VTM3k+O3nxel1nisdEHWULx08IeTP83F1Tq+uiCDboNlS2EYPfLtU
	 1NnAUXh7cRqTNdEwo8N1VKD7zfP5Vh/J1jH9SuUZKfafFuK6zmdqC024DKokBn+V3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHoujgab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD2606A319;
	Wed, 21 Oct 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHoujgab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8EC1F000C9;
	Wed, 21 Oct 2026 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551005;
	bh=J/0LdjEtn9CGZq4Bd8pDsYlZBnyNvZj2vRgzmFMbmxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CHoujgabDdxCimSVYd02l9eV9pzenVF3SK/ZqJ7Nka0cK9u06fIwXFnoqrSh3Mxa5
	 uteS3GJfPHcF4inoAjKmXXZkP2CpxtwQMgP+bLweGqXJUne60Qe5Jee2kEkxY/plIz
	 MRjDS8/5/laL/4ozDAWrnCbrgZtzeYpLXmsrVvaNReg2XylZGc3KR0cWTTDxvaFN8t
	 OCM1VxT4jd9ZAuKh/MWRqqJxV5darmIBZg2AdaQ2hfK6JU0dCG5vYOyDeFT87KxgmW
	 UM2zEievoM+x69Q2O/56bcQqPA5mz0fgcFbHKZhVvDYgLAx7sbF2o8DC3wsxNfmhH2
	 lIVVw/TxPuAsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44C23809A18;
	Wed, 21 Oct 2026 02:50:05 +0000 (UTC)
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
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255100454.346551.9983209413928203259.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:50:04 +0000
References: <20261019082214.102398-1-dmantipov@yandex.ru>
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: edumazet@kernel.org, daniel@iogearbox.net, kuba@kernel.org,
 rsworktech@outlook.com, yarapov_d@mcst.ru, netdev@vger.kernel.org,
 bpf@vger.kernel.org, lvc-project@linuxtesting.org, shodan.ai@mcst.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 11:22:14 +0300 you wrote:
> In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> is checked for error but not propagated to 'out_err' label, so error
> handling may not work as expected. Fix this by assigning error value
> to 'err', thus making sure that error won't be silently ignored.
> 
> Reported-by: Sashiko <shodan.ai@mcst.ru>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - [v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
    https://git.kernel.org/netdev/net/c/82e31923c055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


