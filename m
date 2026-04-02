Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFA38AC73
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160623; cv=none; b=kZfwpz6YMBV/yoAfmF/NGi49PF/nrEYRQ+3J72vfumGYpYQqeWnaxSNH0zJAvrYI2VfK8ETJL/qGABzFfIBVoedtwpvIFNM2B9FHv4NnkvCpIHATzRFh1zqzMVaJzrau+aOzg6f7B2Snn+0HEA31mjVkOPvB60ms5jQRLu1iZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160623; c=relaxed/simple;
	bh=5l443vgf1Viij3qGQ6MUim/pcximpwEvvDd/in7oUm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SqRxkK2rUpXinJfXxz8m2sEw5BaHUL9xOwRhGzrjXrmhxbCjT+6iG9kV8q8ikey8EaT0h08kXShl1gJXBQGCK4Y9w0FqST61jJbOWVZWxEOtGkdES4ta5bCLy6+HYj2dDIPTJPw6PjPEXRzDwPWk0wPDvgjE5ug3cQ419zOVwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7vX+llA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7vX+llA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC76C116C6;
	Thu,  2 Apr 2026 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775160622;
	bh=5l443vgf1Viij3qGQ6MUim/pcximpwEvvDd/in7oUm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e7vX+llAKkQSZMPdJY4cKT8lZmH0llfOJEBUS0ZaVbnKFkhXPZspMWRRfncl76c0g
	 cXTdYdi4j4pvTVr6qoy8xyt3P3h5sjjM+XQ1nbf9IoR6B8JevchsAUokJU1uHNtDq6
	 0fqePRftMuj0nJ7w8oOX/6aLa8DiJRhaR4BDZXiYkSYt9qu8fekdcKpka1low31NyH
	 s+WUsofKSj5kx67piONPNSJOb6rk2u+ndGykF375xBFGB3ycOApoAptW0F272gEICy
	 i7HTGqtdb3OAWCNZ6oYgg8Ua1bh/ihzPowJO3tWtp3JUfWqPcpDRGWj0hsVOTcP+gn
	 kr1+XB11l6Ztg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF623809A09;
	Thu,  2 Apr 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Fix BTF handling in
 bpf_program__clone()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177516060505.600333.17051578920801291723.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 20:10:05 +0000
References: <20260401151640.356419-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260401151640.356419-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Apr 2026 16:16:40 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Align bpf_program__clone() with bpf_object_load_prog() by gating
> BTF func/line info on FEAT_BTF_FUNC kernel support, and resolve
> caller-provided prog_btf_fd before checking obj->btf so that callers
> with their own BTF can use clone() even when the object has no BTF
> loaded.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Fix BTF handling in bpf_program__clone()
    https://git.kernel.org/bpf/bpf-next/c/1cc96e0e2048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


