Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084813D638
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733252; cv=none; b=DQujJEwDIMEEEoCUEdpzhZ+/TqVMB1wa0RdmOgQ0eJ6KES4Gvy1Iwghw110fXfVxQcgnXPJ18U1jP0u3N4bvPjSq9OFNKxgYL+lCScEtWvG/J7uojLNzKLrleIwKS8hJbynJBIIHAQUgisl7qaprUOOFHLF6KIs3OgwUARodDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733252; c=relaxed/simple;
	bh=jHgIi4WqIY6Ujx70JcyKN+JpO2S0oaEB4rZgbWIu6DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTXpBLHwPyqxca0nSgwW6fni4QngbjlwahECvsnbBpvyxBnG5k62U2aHdTu0DEQY9mTEx8EheLe2QtcYt67nNI2qCxJI1tOQcrwNJgfPrqpEeEzL3BKhS1xHRN/6xsZS570ujK0/d8SAyWN/yU12HdkKnyaG9S574nYYStDGrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl9DDfz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl9DDfz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F27C19425;
	Tue, 21 Apr 2026 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776733252;
	bh=jHgIi4WqIY6Ujx70JcyKN+JpO2S0oaEB4rZgbWIu6DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hl9DDfz2B/WdDBygrGEFB2GNMO+8z5G7+1f9QEnhJjhhznleQWcuVxPD5NI4zgJlP
	 xn3UD1/VXTBoqIhxwU4vyCK9nJ6YiWvgFrQuHXV7thWc132PO4AsDSWODCQZMFQWOi
	 2VqATIsT4nvzxLqpYMJh87cO0VvTQTkPA9VObm9z2+o4gt40r+UNcIBlMOgT2KtltI
	 RtR/UuCu/gYdSsRaKyEtwj17i/fFZI4oqAVVtKE0V9kci6+Rae03eIT+nHgLjd1gIL
	 KvtZK6ZF0Nz2zMVAYPlPYT5PYlCpkfQBAwHNhktSw45jl3JgTN5+IuuXd2N6xfSD6L
	 9edpNr1APmGfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE93930023;
	Tue, 21 Apr 2026 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Extend BTF UAPI vlen,
 kinds to use unused bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177673321629.2153798.733442419370711050.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 01:00:16 +0000
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
In-Reply-To: <20260417143023.1551481-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Apr 2026 15:30:17 +0100 you wrote:
> Currently BTF types can have a maximum of 65535 vlen-specified
> objects.  While this limit has not yet been surpassed for existing
> cases (struct/union fields, enum values, function arguments and
> datasec), upcoming BTF location information - specifically inline
> sites - will hit that limit.  Utilize unused BTF info bits in
> struct btf_type to increase limit to 24-bits (over 16 million).
> This is more than an order of magnitude greater than inline
> site counts for the kernel (~400,000) so should be enough for
> the near future at least.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/6] bpf: Extend BTF UAPI vlen, kinds to use unused bits
    https://git.kernel.org/bpf/bpf-next/c/f7a6b9eaff3e
  - [v3,bpf-next,2/6] libbpf: Adjust btf_vlen() to return a __u32
    https://git.kernel.org/bpf/bpf-next/c/cacd6729c092
  - [v3,bpf-next,3/6] bpftool: Support 24-bit vlen
    https://git.kernel.org/bpf/bpf-next/c/22b402457ee4
  - [v3,bpf-next,4/6] selftests/bpf: Fix up btf/invalid test for extended kind
    https://git.kernel.org/bpf/bpf-next/c/855af3e77567
  - [v3,bpf-next,5/6] selftests/bpf: Fix up __u16 vlen assumptions
    https://git.kernel.org/bpf/bpf-next/c/ad256554f106
  - [v3,bpf-next,6/6] Documentation/bpf: Update btf doc with updated vlen, kind sizes
    https://git.kernel.org/bpf/bpf-next/c/65350a0ecd41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


