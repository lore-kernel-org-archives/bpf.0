Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EA3F23D0
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899412; cv=none; b=XwtbCFQ1oDlZF+N4MI6Hk6ABsvdJ9ssUkFiojPvnXJ9jhl445BjsKcR/RXXmnXtHUXdDduCWU1m9sdt4T+8vtMN4GVC8Or2AAyNifjeDAxtnXGq1zB81EKE0UqPRZCQVCnpjmqYwrJlQQuVqXt4ixR8DIzJ57+/4Ng92pRmybGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899412; c=relaxed/simple;
	bh=cELsiEBr7OmMWcQb53L052shok4w4P+3yEPnJemUll4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HB5QYXD0BgcopG40Kwoz786pC7Qfhp141zBqx4jJEqUl8rt008iSW17pVw3ImHLHElXw0fBqN/PTH8ga/2HLKKDRPtPdVr+WL+Kbfdh9yRNLVJVouK6lqdCqw51wj39hRD38u6rSqz8wxwQYJ2ShnVb8hfcNU8Rm7Cs/RtO8ySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2r35sps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2r35sps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873A61F00893;
	Tue, 13 Oct 2026 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899411;
	bh=/KptY8RfV80DUvcc7Ke38FD204sTTmjW0UKUIpbFqi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y2r35sps34KGj3N6IFld/RQVLHSQCmJ6wDLEWKpjakfLbAzjNyq1w483OPk6Dl00Q
	 vnyGUq+6qt3Kkpk8E0W9YZLQIzD74XujHslp2OlDSQg9iLvSj68RerY6HjMggGDoPn
	 Z5wAtboWrYMHLldPeQxL1WmZ4aj+QKdwwiNBv4iIU13+M2kaUsbj/yel5knP3TEBBJ
	 4gl9hbmF2krcJp+ysk5GsD1ZdOf13Y+V4W8ItcbSzvKt09JxSFx8VzRKxxc0i+nWQR
	 yyMLraI+di7j7nTDtjf0PfkTJKqOyyUeJJimihjoGHFrWCTu+QaD2t4iXwXdBIYd59
	 U28g62899Regw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 784B7392720A;
	Tue, 13 Oct 2026 13:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Inline BTF followups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179189941001.316800.993293424260737331.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 13:50:10 +0000
References: <20261012140640.2932195-1-alan.maguire@oracle.com>
In-Reply-To: <20261012140640.2932195-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, emil@etsalapatis.com, puranjay@kernel.org,
 yatsenko@meta.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Oct 2026 15:06:37 +0100 you wrote:
> This series addresses lingering issues after BTF inline
> series landed.
> 
> Patch 1 fixes validation issue on loading BTF inline info.
> 
> Patch 2 corrects the base address calculation for BTF inline
> data in LOCSEC to use the ELF section base rather than module
> base.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
    https://git.kernel.org/bpf/bpf-next/c/f6b6c87262da
  - [bpf-next,2/3] selftests/bpf: Fix btf_inline to use .text section as base
    https://git.kernel.org/bpf/bpf-next/c/35369ca4954c
  - [bpf-next,3/3] selftests/bpf: Enable CONFIG_DEBUG_INFO_BTF_INLINE for CI
    https://git.kernel.org/bpf/bpf-next/c/add69af5068d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


