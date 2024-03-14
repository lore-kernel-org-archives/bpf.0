Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4173196
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450032; cv=none; b=hVR2ZZ9OanA3D2T6pww780xaDXW6Y2WXWbkXkCBT1zYT1OxuIiEyaTLwPj4d9O+A4xU33i/ptoBNfu9lrBAbSZPF6FxqS6bfHUSBr9S2lF6nL+/0qpy8Lg5lC/J6i/dBXEbgomX29vi/DyjldPV5XbAhLLxSx40RIXspcOlV4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450032; c=relaxed/simple;
	bh=Wn7/uBbu5ajDxW0AILxRxkR+nmJ6iJbvE+z64cgoIEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jho0KFAxoTWBht9dp8+BjnKVNAlntLMj4Vg8pHI3f8V9sOBa2vHp9bz0dhRMpdiiasucv0KmKHvKH7dA7DW7UvzcShKSnlULwupEawFpruBJGmXr9h+RmALwqhl5YlrkwaTVnBr1w1TXAbyOP8MLZJ8mvPdsLZQOuCtCBnTOiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GniTtzQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GniTtzQl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A481EC43390;
	Thu, 14 Mar 2024 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710450031;
	bh=Wn7/uBbu5ajDxW0AILxRxkR+nmJ6iJbvE+z64cgoIEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GniTtzQlCHFF1RghAXSO2PwDywn8/Z49z6RLoy4eS3IPguAfWJXZwWPgdssIf2N8P
	 iiR2XDwhzUzCnFjxwpNiAZ1Jh7MWGweBr+zXFNrdEutBbp0VboVcuwh7qFYJbC+9uG
	 +FYGu0yC0/3IceCrUUu3WWVTk3QalUCxE+KInyNUsScpFsLuUdF0eWmHI50QeWHK6K
	 otoZG/GppgbC5Acom1Er768tLMqjYWSI9O6e8A/qfYSj8O9VXymaRfMP5UuPsJTBJz
	 LsgFN+dguYbf3KYcElDQYxh+68hQRmRpmZbx9NsBaLH4yQ4VPBztJNfePR5O8McsI9
	 YZSCxVU3rRQ0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A38D84BB4;
	Thu, 14 Mar 2024 21:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Ignore additional fields in the struct_ops
 maps in an updated version.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171045003158.27753.767457664957549262.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 21:00:31 +0000
References: <20240313214139.685112-1-thinker.li@gmail.com>
In-Reply-To: <20240313214139.685112-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 13 Mar 2024 14:41:36 -0700 you wrote:
> According to an offline discussion, it would be beneficial to
> implement a backward-compatible method for struct_ops types with
> additional fields that are not present in older kernels.
> 
> This patchset accepts additional fields of a struct_ops map with all
> zero values even if these fields are not in the corresponding type in
> the kernel. This provides a way to be backward compatible. User space
> programs can use the same map on a machine running an old kernel by
> clearing fields that do not exist in the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] libbpf: Skip zeroed or null fields if not found in the kernel type.
    https://git.kernel.org/bpf/bpf-next/c/c911fc61a7ce
  - [bpf-next,v2,2/3] selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
    https://git.kernel.org/bpf/bpf-next/c/26a7cf2bbea6
  - [bpf-next,v2,3/3] selftests/bpf: Accept extra arguments if they are not used.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


