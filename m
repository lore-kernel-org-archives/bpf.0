Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B42853FD
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910868; cv=none; b=QWEU5RG0kIfc3zK7jNnCrOKkEDL8MZ11lxf9qD5Iu2Vi1xXCNszCY4MprbtvZn2hjUTUHmOoPTgCUb3z6j7FFZU0wO6Gn2Zl8IGAxa1EY/fOpC92v83czuvBNdWhDny1iP+5KfMUaCKY0uTatUJrQDJg0NXpUIYQXEHF3Ms/N4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910868; c=relaxed/simple;
	bh=3zyPa/pPWo3PI5OjIKErDNmlRFkjCcr4rvM49Xw6MyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAqBrX5kNZgE5E1b7kssR6is/hJeelqsgykiUcHb3pAqXDuGYvV4H1uIWjfx3DDaRd7ClnFDMCV5uZOyc5galU8K5+FkaNymd4Vm3TKymKmFtsmqQT7kHIlqdIdrAigo/ZXfwqvv/HooqIaOc4mD+IWBjJwIlceaRsmEzsQ/kCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe+vC0XE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe+vC0XE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A31F00A3A;
	Tue,  8 Sep 2026 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910867;
	bh=z7TE3Q1Z04WtnyeH3+FzmrWnDa4+rDiAHzO4f0W0HfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fe+vC0XE2E6Pt0BkFw/+a+r03tgGJazaqzPYHbk+ewva7auQ5tep7yiMWnrdMEU+I
	 Bva8+SE9XY2+d78NKvvd9UwEJlcsL2TKSfs7AlEjt3O7cRP3dQI56a7f0TMtP67l/D
	 pYn+LjnuiLKurIvbX37yNw32rD2GE1EqYDDoHFdrwH+6hKMmBYDHFiPUD+kX5yi3UY
	 woKaNglQkCSydTrMXwTGWqP4/QU0KmegNaR81UXwWI0DiUtRipyXD0eYC8NaD4T0ww
	 b8Y3Ocwnao6vpeapfdMtY+A44gNBYD07l5IwBtD4av03OruBZTHeq+pDgNFQz52ah3
	 Bdhu//OwdVVkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938F1380820D;
	Tue,  8 Sep 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] libbpf: Fix array comparison in BTF dedup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891080539.64512.8091983797473568785.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 23:40:05 +0000
References: <20260908164920.108074-1-caomingpei@gmail.com>
In-Reply-To: <20260908164920.108074-1-caomingpei@gmail.com>
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 eddyz87@gmail.com, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  8 Sep 2026 16:49:18 +0000 you wrote:
> The recursive array comparison in BTF dedup reads both descriptors from
> the first type. This can merge distinct structures and corrupt CO-RE
> relocation metadata. Fix the comparison and add three regression cases to
> the existing BTF dedup tests.
> 
> Changes in v2:
> - Move the tests into prog_tests/btf.c using Alan Maguire's two cases.
> - Add a separate negative case with the same index type to isolate
>   element-type comparison.
> - Keep patch 1 unchanged.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] libbpf: Fix array comparison in BTF dedup
    https://git.kernel.org/bpf/bpf-next/c/e62c5b97d6c4
  - [bpf,v2,2/2] selftests/bpf: Test array element comparison in BTF dedup
    https://git.kernel.org/bpf/bpf-next/c/208637af0dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


