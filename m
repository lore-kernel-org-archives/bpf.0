Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB11DF75B;
	Mon, 22 Jun 2026 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090624; cv=none; b=Eiyx98hgNtsC9LpbtJJbFS4NfTVFPLsomvfsyXXTpSaO2eV1FE1sSe8YSwxFRAIZCxtZK7dvlykwyw+UuuL+1KDFBcMUs3s8TdhrcT6gHb7ExfxErKmV1vD4bFZ81NlHhNtY9Jhq4p0RH2CPvPYzVHs0HdfP13w+ME5waGi1Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090624; c=relaxed/simple;
	bh=hNgwj2CtWJOIz4/Crp4yMBFqaqG7JCX9MQe/jc1WQV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DRACgTGtUmDl9Z+gXZB6MRG+81IvFpru4i00IqAIg1WoUylHOdhNtpCb1Kg13u1J+HEL/JnUsqCn4Fshqk0oss3QcHJX3V0neO5OCrBKy4uF+dTu+h6yQWIyFcIbyPdMZSeyB92/XDH6veGzhvTxMjZWmT8U82ZOicd6rxbX78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAa4dljL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAa4dljL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03491F000E9;
	Mon, 22 Jun 2026 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090623;
	bh=V2flqI0IXEn2UaMSOMyQ4oI71syaSztiL53xPPDD8Ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VAa4dljLCvSaNdjowLmsBHwzbVQzPxIu2Wty2UOOR0E2Qbrad/EsPvWEauWlVghYD
	 wa7rb16tlLjCGc+FOlwSaULxCREKZw24J1GcbmrNgkh1qMBr5S9GSBMHZyO3H76BuC
	 bkSogG4x+9u+xB4/JS7ckh6XmO7BKGlV0W8BmH0HQvi2O8Cj5U5KUoZCoCiH7xkkww
	 WIXZbqouNdNN5P5Uk76jQ12gcsVIsIGZstA46j/rsoGGrt7rWMuKnJRZvNaUiTbKd+
	 BSGrK7MqGRHR+GzUjafyE8+XOO6w8M7McU1G6nxNa3V4BbnPVBJfj25xcEEzJx2I6Y
	 HSlIzNaaxierg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198293AAA6EF;
	Mon, 22 Jun 2026 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup
 commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209061474.558026.16457667469698870550.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:10:14 +0000
References: 
 <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
In-Reply-To: 
 <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, sdf@fomichev.me,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Jun 2026 17:01:17 +0800 you wrote:
> bpftool cgroup show and tree call libbpf_find_kernel_btf() to
> resolve attach_btf names, but never release the returned BTF object.
> 
> For cgroup tree, do_show_tree_fn() is called once for each cgroup
> visited by nftw(). When more than one cgroup has attached programs,
> each callback overwrites btf_vmlinux with a new object and loses the
> previous allocation.
> 
> [...]

Here is the summary with links:
  - tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup commands
    https://git.kernel.org/bpf/bpf/c/bda6a7308ef8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


