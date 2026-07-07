Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3C2459E5;
	Tue,  7 Jul 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413627; cv=none; b=nkX8aWqSGOTUvt+QiyePXHlQqrDY7ZWX6GzbSdLn/FvWnRDidagc0D3IiQlPNHR46SILhaRNTq1veE0t6G3iugP7sCE30bGdOw96yp8tUx5N4sj4nk8jyJMwyZSL4wQFy6VNjvsWMmWDtA909WihideWK4byACjTuIIssP1SUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413627; c=relaxed/simple;
	bh=KQte1xYYXSlk71R+by2fCp6liTq7fRmyqHlxw6SQvvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fuaY6q49aLMHTzD8RbokdraQxvTaQ87Xrt0tR+cD1r7UCUfNKCKr1T4l2XF6ClsWYHAmI4x8eaFpt+vVIbVGs0SwpGOkZyITE8tQITyKhBrrVmp8lSZfzIx6OT/SYOb9uQDpz19f27W2STxW5bRrhzMyFFzkPANdXxQdE6VijaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqCum4IJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqCum4IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D263F1F00A3A;
	Tue,  7 Jul 2026 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783413625;
	bh=6pPjjJWgI4QmgLZ+t0RAIIz/DKF1BXp4p7v//2iLbnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NqCum4IJ6b0EY2vskmseepw8EDbH1VJs3jybVnAdBXN+OBvZvL4d+hFlPD6/RSDAp
	 KTrg1bhxjP+Dn1DK34id6JaXUwJnA7wezGasfjOxfZ4ebYpZ1C5yezSXuwJp6GVk+F
	 7QE9Vg1KQmvPAcIDsbWuxOaGYNos3LVouKviGvUSd2mgj0qRUeB+5iuDFdQ8WdAh4N
	 5pEHO87bXUaUAuomBMAbheTIM+c007Nde1cuMEZ5XKoprF06HbT7TVsjoBumlyUNJu
	 XaOspb4IMJpvKFrQDaOSx7VInSbkJrNRQA80vsUiWVT8GpCD+PFBiyLP/IG6bc1CV6
	 HY2pgW9yRUlZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198283925461;
	Tue,  7 Jul 2026 08:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf,
 sockmap: disallow sockmap mutation from tc, xdp,
 socket_filter and flow_dissector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341360589.1430372.1113135547618558255.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 08:40:05 +0000
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, shuah@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, sdf@fomichev.me,
 jiayuan.chen@linux.dev, varunrmallya@gmail.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jun 2026 14:54:04 +0000 you wrote:
> A tc, xdp, socket_filter or flow_dissector program updating or deleting
> a sockmap deadlocks on stab->lock vs sk_callback_lock and has no reason
> to. Patch 1 disallows it in may_update_sockmap(); patch 2 drops the
> selftests that exercised it.
> 
> v4:
>  - also drop BPF_PROG_TYPE_SOCKET_FILTER (John Fastabend)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf, sockmap: disallow update and delete from tc, xdp, socket_filter and flow_dissector
    https://git.kernel.org/bpf/bpf-next/c/7fb52b3bd3a3
  - [bpf-next,v4,2/2] selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


