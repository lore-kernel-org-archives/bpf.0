Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAF363C61;
	Tue, 24 Mar 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369463; cv=none; b=U/TqGfVqHbdEkUIcTypD9ZqmcfOfX/bT9Vmn0VRqB0iL6UIjmzlcOzj+doPvxy2+MEvAOcl/JlAgnjwVJPvnCgh0qptT7f04QvuKNB1RlMEFN6JE1ZAYgLuZ5qFdyJn/QnmJ+2jiZbFqzrOvpzImCxJKxfHHA7OBYbGGlMe4jBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369463; c=relaxed/simple;
	bh=vhtw5WEnudabQc543MOrTZZ8gDkgdsEnLGdCOzNnOSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Le5VruxUr3UZ70KCLWb+dJawUEDWk2ifUbCVPRpdfS96Zcm0i1choF57ICu6AKZ37ZxUgIySNB1AlGwckTXhTQx6PDFWOvlJrekqjFUgVwwFyWbutOTyVzSlwtdpHoUS75qtt5wANqWDuNFe7Cm3iTMs+PyRHfp4UrBwMtqcdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxlhm+dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxlhm+dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C51C2BC87;
	Tue, 24 Mar 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369463;
	bh=vhtw5WEnudabQc543MOrTZZ8gDkgdsEnLGdCOzNnOSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pxlhm+dhIN7rMCRcw1SbtSNghqqkgHKYGYYFdNyO3JogUhtOdD23V+8k7fso4ocj/
	 F6cCl0hiA3B79GmAIyVMmOpdC9QuElUOT5Ppxhp4wJsxEL34UIHKHj/wcO4iuFkYDs
	 C/92qpGnikFn3E0SR51ZW+5tTfIM48uB/74eiWDlaD1Kf7Kn6JatXHfyiTZAiBw2ER
	 ndwrS5TIBmFf1jCScVGEBE0WhDkSjcI1XR8AfF2fgUqYr60zrzT9sFB/3wTGE6tDAb
	 mHKkA35EBft4LqCx/gvCX1S440h3bkAD42P3sr6M1e3qPp7jgXP+ocGfX+70pn1IA8
	 6t6+82H3QROzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DAE3808203;
	Tue, 24 Mar 2026 16:24:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: propagate kvmemdup_bpfptr errors from
 bpf_prog_verify_signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436945061.1152246.118300165179191472.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 16:24:10 +0000
References: <tencent_C9C5B2B28413D6303D505CD02BFEA4708C07@qq.com>
In-Reply-To: <tencent_C9C5B2B28413D6303D505CD02BFEA4708C07@qq.com>
To: Weixie Cui <523516579@qq.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, cuiweixie@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 21 Mar 2026 14:08:00 +0800 you wrote:
> From: Weixie Cui <cuiweixie@gmail.com>
> 
> kvmemdup_bpfptr() returns -EFAULT when the user pointer cannot be
> copied, and -ENOMEM on allocation failure. The error path always
> returned -ENOMEM, misreporting bad addresses as out-of-memory.
> 
> Return PTR_ERR(sig) so user space gets the correct errno.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: propagate kvmemdup_bpfptr errors from bpf_prog_verify_signature
    https://git.kernel.org/bpf/bpf-next/c/ad2f7ed0ee91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


