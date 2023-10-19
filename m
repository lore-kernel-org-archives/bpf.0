Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F312744F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trjltUnh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B48C433CA;
	Thu, 19 Oct 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697725222;
	bh=3ACcqyvE5OaR/NHrlabOG7tqnMLHNizxrLLL57CVdIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=trjltUnhcI7uS/UY32Po8PUPPNz5UiYyUhbG9nJMAt4QPdd+8knCZAquaFjxFs2bO
	 TvPlZndEROwL+ISRxtTP7gDCXq9rmJkZX4dP+CoaFkpR7WVgzbphEjzGcARTiXkPll
	 bEP7SH27MWecn3Nunz1tBHEmQ3BBrsurdD2Gm0qGcSsf5QCVtcCcylZON6Jn+rxpeB
	 Zu7LxKxtl5+2DMvq147BMQyFoGzBc89tOl1C/CWWY/vOei1uxw9mNIgavQQ/vke3Sy
	 bzfHXLh08LV/K1bO36OBBv0BbWmGT+E0uLszlAlMFKXFBcndL4vKZR/gNrYkFGILhs
	 uk/jBVdZU7tHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B159C04DD9;
	Thu, 19 Oct 2023 14:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] Fold smp_mb__before_atomic() into atomic_set_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169772522250.22901.8109174108695874164.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 14:20:22 +0000
References: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
In-Reply-To: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
To: Paul E. McKenney <paulmck@kernel.org>
Cc: bpf@vger.kernel.org, void@manifault.com, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 18 Oct 2023 15:28:32 -0700 you wrote:
> bpf: Fold smp_mb__before_atomic() into atomic_set_release()
> 
> The bpf_user_ringbuf_drain() BPF_CALL function uses an atomic_set()
> immediately preceded by smp_mb__before_atomic() so as to order storing
> of ring-buffer consumer and producer positions prior to the atomic_set()
> call's clearing of the ->busy flag, as follows:
> 
> [...]

Here is the summary with links:
  - [bpf] Fold smp_mb__before_atomic() into atomic_set_release()
    https://git.kernel.org/bpf/bpf/c/e661451ce4e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


