Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654040F731
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684277; cv=none; b=aP4CnZ/nVu0tA2ri9GxblN9rUb0lXiGfvr+TJuXgiqXSQNE+Ocwx17Jvd5OzUVtJiQfGhG3vtvb90aHcUOU8oVYvR6AuMVYNx3EHuZwM78N/VgkosVB7//14fCzBP7DxSmWiLVX25uXqmk11/RBNAYoggyLYan+q6tbRTeehGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684277; c=relaxed/simple;
	bh=mgropaNiCorEU6uXqx4Ruz454Iogyq4BCq88C6zS4gY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fi41mMEzA/cesTiO65c4qw/obV4bBZpLTf5qkBuWJPKmosZ+EuPjCfDp9TfhiCxojKQUafDDuPcga4WoDms3YqUkBWIZxv8GL1FW2YZLTW19MBTFzWfpXLA0+prRQgesiB/m6TiMY+qlUQ/5UhwUXFlimrX3y/9xvVQzH6ywTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1CkRDvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1CkRDvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29BD1F000FF;
	Thu, 17 Sep 2026 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684274;
	bh=a1lkxBNzyn4qDFboPGWy/S/ySpmmzVYq0Q67aeWblxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b1CkRDvPeCyyyIxV80kZ+dKkvTaUeGOknCBYZCKY+Nyfq5fuiZRYGIuLSU8/Ern8z
	 rXroTTPs+EH6Mp8TS4oPyBCGTg8BcHzLEWKu5kfxE0gimOxiWwNNMc3Xztel7Ovtqq
	 8fymH4CjR36wndn3t0zkl0cz+S8hZITaFjr4ZnZ1nMHrRNQloo8vcNGleZEgZvHy4d
	 7JNmwKTPsDC/6LdlNVGnSvq42aqFKBw26UThSy49643ph6Y0e4HzP11D+QipQcznX0
	 /+fmCOVKb5ve7vRjCK1OAvQ3TJtSdxsmboSyfxGOGAdyx1TSxRqebNiOFxjgxHpvd7
	 rtzfUwrz59Tkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392B3811974;
	Thu, 17 Sep 2026 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] libbpf: Reject local struct_ops bitfields
 before
 data access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968420812.152767.15748849825891235642.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 22:30:08 +0000
References: <20260915162252.473044-1-caomingpei@gmail.com>
In-Reply-To: <20260915162252.473044-1-caomingpei@gmail.com>
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ameryhung@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Sep 2026 16:22:35 +0000 you wrote:
> A local struct_ops type can contain a bitfield absent from the
> corresponding kernel BTF type. libbpf calculated the member data pointer
> from the encoded BTF member offset before rejecting the bitfield. The
> absent member zero check could then read outside the local struct_ops data
> and crash libbpf.
> 
> Patch 1 rejects local bitfields before calculating the member data pointer.
> Patch 2 adds a negative test for a local bitfield absent from the kernel
> BTF type.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] libbpf: Reject local struct_ops bitfields before data access
    https://git.kernel.org/bpf/bpf-next/c/961b8946acb4
  - [bpf,v3,2/2] selftests/bpf: Test local struct_ops bitfield rejection
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


