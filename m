Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E433E4C95
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540835; cv=none; b=ZtxHsZk2XgNlZVODUtmIe5LZ5Q4yJk6QTYu/d8oj3LaIeIxxwUU6zyxi/FlGndLIFB2Kn3uZWVAQdDxOYv4CDmFy2ifMU0p6maR9qYahfke7VjuK94SHe+BtqbEOI0sy5I68CEhxqRk11ZDCkC+T0o6PJQ3xt31LY1QvGq5njCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540835; c=relaxed/simple;
	bh=qr7v+UVslgRPNxieSLQvsDJzuO5W4c6lVoMGXKgIqZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YTirM/AZdRXW4KhPQONyTMHEJzMZaSqYndvYfFS/BwgXN0/D1GlEyCsno/ykzoeFPZlKy1TLJieQORaxn60IZ/1Lz1vwEuQF54svyPMUM31VD+pV+MmsNwUYmTPeO0eEbYdYwp5osQc/X4tRkH0vQ23crRd9j9T9vQR0OBn8DhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvLayQor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvLayQor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895EB1F000E9;
	Wed,  8 Jul 2026 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783540829;
	bh=Mkm/atzKNm92/sZfQSlUY3V25UoVEyts66nWe3sdwlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DvLayQorF4NPvuVw9IXEOrIGob+7P2Ce8mY510+yU48R/6/eKYY4SacRqZiskMukJ
	 CyB32KiHXb4I+Aad5wgqRmaCesgeOMYPD5lDBSv35LmJgcgK6PgnjM0TQ2Fn8GO2Rj
	 VrxKmX70mmJM9Qk3vbB8XrY/PTcKy4rqAa9pNS9uSzZ9o08io69C7gwACWpVn744I/
	 YWLZkg5X8t3G/Tux2yR+E8xmOwNfH6DfjXVGWfjC30QvI8btv6KHmykK5BALWl42tg
	 CPrXXHoRRbwroIxQo0z/zQpoJxcJyDcCP3Hb3/ikmn1wGja50cIKgRWX1IdeFjJ6Li
	 uchsQ/IcaSwEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C3C3927224;
	Wed,  8 Jul 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Close fd on unexpected success in
 signed loader
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178354080838.3087685.2398060071373540973.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 20:00:08 +0000
References: <20260708184107.369182-1-daniel@iogearbox.net>
In-Reply-To: <20260708184107.369182-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, ast@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 20:41:07 +0200 you wrote:
> The signature_enforced, signature_too_large, signature_zero_size and
> signature_bad_keyring subtests load a program that must be rejected,
> but leave the fd open if the kernel unexpectedly accepts the load:
> test_progs asserts record the failure and continue, so the fd would
> linger for the rest of the run. Just close it.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Close fd on unexpected success in signed loader
    https://git.kernel.org/bpf/bpf-next/c/43f129d21489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


