Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB154480DE9;
	Fri, 16 Oct 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158012; cv=none; b=HXYgZICUxGuACyicMIY4COrULPk9cQCjvJSHtTGzsZPrfxnGZHx0rXUKhb9jt2A8jTAmUy3ACPhc2qBidBUsPHkr014pk/SpCw8+qV5HFUdZ3CbHDtTNGRCCpi3o709Df5P+qqdv9BbSp8r1HdFHPHrtJZLzLBNY2qyoy/whSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158012; c=relaxed/simple;
	bh=WoEJFX5LfScTO/M47xw+wJ9Y3H9ZLYo2vGzWBxrFMBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqc6rR0D/axiGGYOIdUr7WTfKh6waizV1y7GGmnYSWA17LS+A/y7AkGmMRCLQzG5WiRLsvTIljaieDWvD9ZeogDJ1zQlBo3+uCerf+m4z4bjr47cYbEsRBfWsuJwENZ9uSIa0ga3H3ljh0ILD8/+tKaMKeAg6lt6WWLKdOzR7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORVDW+UW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORVDW+UW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54511F000C4;
	Fri, 16 Oct 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158011;
	bh=C/IUVK8DHOjit4GMkeRrGajEhcmovgoB82GVqSNM1zI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ORVDW+UWUiYrsQHp8o44PblSJjepVsFQ//KYSCsLm71lFF6kpmeNsohM4EPpw7jAr
	 qy2TZH/cxlpjqxnqN+B7yDP9P/8wPAR6607EnqNNA+vu0mOt/ZPO+b+MOSfo+2BXjv
	 o4XJcwAERRBJmzMvPDaMm6yKxcnWapB+ZEL1m1U9Tq4rq3GFdf20/aq0dxgHuAVwdB
	 j0vAzAxe07GsaLlbhaq650jVC2kb2Uhc9KwOnzQYRhBI1Z/DCOfOoKPjjw7ls8UEqD
	 S0yFGoAgSo0fEOPU96sIhQv5kiXkoshlnGRKc2yJ4i7Ll0wFIuKIvivn2twCQUxl++
	 wxQ5u6lEPh4Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6BCC380A95C;
	Fri, 16 Oct 2026 13:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix spelling mistakes in descr literal
 strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179215801028.300760.16314134678598570739.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 13:40:10 +0000
References: <20261012212334.183116-1-colin.i.king@gmail.com>
In-Reply-To: <20261012212334.183116-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, sdf@fomichev.me,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 12 Oct 2026 22:23:34 +0100 you wrote:
> There are spelling mistakes in the descr literal strings. Fix them.
> 
> Fixes: 095ddb501b39 ("selftests/bpf: Add sockopt case to verify prog_type")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - selftests/bpf: Fix spelling mistakes in descr literal strings
    https://git.kernel.org/bpf/bpf-next/c/760c953525ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


