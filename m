Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041C410D2F;
	Thu, 14 May 2026 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770526; cv=none; b=SixCi0ubXYihHo4dCMvylhnTSkB1aXumBrj9zoY9DM2T1KtLymupnDHDrftRJZ8zA3UFlsz4cFfTBubNu1pEr3RYvvxpR9WI7tun7X8aeBx+7wA4nVZXuHhmHkykmK8YKJSyRc9sWrLcdojOffihgfGaJ9Dw2ASTeDMV+2URSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770526; c=relaxed/simple;
	bh=PlpGpU4p7MKly4lZ7xafc9/RwF3DoJxtZYGyFTGZh8Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BM5vSoYj67kxjLb+gXqE+4OqseuCG9dnm2Oj7HgJ6Qwi85VOzlD1FgLOYWrcv8GDpw0dGVEZBF67HHtyWzH2JvjA4eT4cAdF45AwM5GHEM/z2vJ20a/8fG6PUvmG+SZYzmzBA7TyB62nIFirnxrl4LMOEY1LsGg5BkcC3TpHEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFDCApnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFDCApnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77614C2BCC7;
	Thu, 14 May 2026 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770525;
	bh=PlpGpU4p7MKly4lZ7xafc9/RwF3DoJxtZYGyFTGZh8Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pFDCApnRcCJpdROcq/gJ+t+KQsMqeWCZT5cXl/25MwJb9c8NWr7qX6pzzS9xpNeZ3
	 saa8tuH9vFh+HZJHuIs4NWsLqODQvY1+tW2LvJZqei8LPn9hjWyON0lxG84P0K15Vf
	 G1UorcX0qtEg4t2Ti1lAzfsxW1Tfr9FnfUAwEb0jEaSotS+4cAYcKuuDqZfC+Ul7QV
	 d20Ba4ARoghRQmZQeOzitg8rnJNjfC6jiI85dLuFAvIuldKzOrwMn0SWY+nifeZvPx
	 dtrhNn67JVJf1klh6BGTTXdmEyzfuSuH1WG3+u0SRtdKdJLY5UDWJoeCko+UzQ7Gcj
	 nj0Vza2z0TR8g==
Content-Type: multipart/mixed; boundary="===============7266106224960299503=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <430564f1eb4e1fb284b40510811502671e4aa8ef59afadddd546e4286402f760@mail.kernel.org>
In-Reply-To: <20260514135342.22130-3-jolsa@kernel.org>
References: <20260514135342.22130-3-jolsa@kernel.org>
Subject: Re: [PATCH 2/7] libbpf: Change has_nop_combo to work on top of nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 14:55:25 +0000 (UTC)

--===============7266106224960299503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Change has_nop_combo to work on top of nop10
>
>     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
>     fixing has_nop_combo to reflect that.
>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This looks like a bug fix for kernel/libbpf integration. Should this
include:

  Fixes: 9734c3ac2f23 ("uprobes/x86: Move optimized uprobe from nop5 to nop10")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25864669093
--===============7266106224960299503==--
