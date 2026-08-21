Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC73F9F22;
	Fri, 21 Aug 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339469; cv=none; b=fWYSe5NrYL0zy6u+Lv1bMOhvflkoV1gteAzjC4ufDeutqx8cHppBcI9dq6s2zMw+24D7d2lUGUIfSsRC3kRrfDMxey4Hs4xfVZxoQFY+Xmm2QTkdUHTEDzBXDngHlrBbQmEuMvE40hMPdOxBt+yARFhBboXfNxiu5F+vGElEsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339469; c=relaxed/simple;
	bh=VjsSsXe4VLvNU0VAbrkdJe2ptAswzKYX/d3zDzeOyp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i6Iao13pInB70j9rcmtZZjRga5oKQj2z8ubmVFalLOVkxNKigmLavwiEfH8VW3yEbouaU+6kcI1PBaa1l389l/exrS8V7RxO89avIbR3RY4Yywd8s2eTyxKwT08CgmAn/s+af91FhGVJdqy8mBYyWXTsH6bLZdlYcVPVceykcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljYEmrwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljYEmrwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789941F0156B;
	Fri, 21 Aug 2026 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339456;
	bh=WMKD9RFxRKf8ZLJ3vbZadXPCrAuYUlSn6vmL7hzgpZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ljYEmrwJgdYC0vQZYHGDTwnhp826FoNV3N8R0S+0YxpU4WTm/1zs0yJHs5yIwA83M
	 Tc7cbwq8/3xKMzosh2jiuzsak5qztVSVMLTvKszLJpcHwB4yusTtERDoa5uDU/5Y46
	 PI2zY8CFlMHHWfA0F+BnM7WxDepTIbKW3A1jWc6l1eOO7DWa9PwgwJEwZrItwEjkF1
	 ABa1tWop5ILf2FPnlU2+OOk7VMD/AJRX1ddzGi04mEE9O7rT3ekN2xHfvSVc0MrrCH
	 rY80dBfRQwdBgP95NcZ3nySOB30ClgQ1OjnWrs47kz1RQopCKqhJQatrk4wjQ0gYyE
	 gOBX0d5Vqu7CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4077D380CEC4;
	Fri, 21 Aug 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] libbpf: avoid overflow in BTF.ext bounds
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178733940595.1438259.8687604873011266338.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 19:10:05 +0000
References: <20260813-b4-libbpf-v6-send-20260813-v6-1-56be61c52758@gmail.com>
In-Reply-To: <20260813-b4-libbpf-v6-send-20260813-v6-1-56be61c52758@gmail.com>
To: Darren Carreras <carrerasdarren@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, linux-kernel@vger.kernel.org, jolsa@kernel.org,
 andrii.nakryiko@gmail.com, ast@kernel.org, eddyz87@gmail.com,
 emil@etsalapatis.com, andrii@kernel.org, memxor@gmail.com,
 ihor.solodrai@linux.dev, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Aug 2026 20:43:18 -0400 you wrote:
> From: Darren Carreras <carrerasdarren@gmail.com>
> 
> A malformed BTF.ext subsection length in an ELF input can wrap the
> pointer addition used by btf_ext_parse_sec_info() on 32-bit builds. The
> wrapped pointer passes the bounds check and parsing then reads beyond the
> copied BTF.ext data.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] libbpf: avoid overflow in BTF.ext bounds check
    https://git.kernel.org/bpf/bpf-next/c/e40f61a31688

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


