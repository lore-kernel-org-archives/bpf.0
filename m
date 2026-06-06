Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40327E076
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780717216; cv=none; b=E/RgUrS4oJgyndBA/VE0fusgranR2UIHmjSADNC4bD5g6I5mS7Sv7ojAIVDdR4ggpAgGtZCp4njpaR2sZj2y6UT+PIWU/rK/Pv0L4wD6mFQmUledV+cuOxbjTN1EwKjJXhBj14n8wBX9edgxOgbTQkamt9r24VmYihWCK1VTQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780717216; c=relaxed/simple;
	bh=lewxwLGR4p0UJwukNrVVD+cB4edc7Z3T/19yyLshGgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u13L9/XBgbmMuiykMYt1PDf7+ODdGN8M/1k4aQkk/UsFx4uWMgcTQs7eEFiC2qhptPIL+Z5V/PBYMp1oc3E/UkRSBzowRGJNLmLsd8Vm3XqiY5yWNH8m6lN25tu6dTHD0tVKqKjyxOoVIz7J2WHqhgrmO4jI8hDUZolW9r+wYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMhhI7zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMhhI7zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC071F00893;
	Sat,  6 Jun 2026 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780717214;
	bh=kkZ5KKdoBUCR9RH4pGZRmfCB3yZ/E0xqcU/+EEtUHRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMhhI7zxMG74xsxzPqIHW6OqCEsEIBgsk/SJbrJzS1IiNpwJPSsuOtEDNNK8uI5rc
	 fCjXm1jIaIlZ6S7sHs03w6N87H37PnCQrARrysGyqVjY+Die0Q/uTYsf5r+nzsdRYd
	 Mea9+oDYRoX1nY3UxiUlq32PGupPL6GFEmIgBbPjV4o6Lk5H5E9hcR6Cb+ghMe7qCh
	 gQSQkrKsl+P+GwtqrrsfbJvLw7wOZ92HR1WK4+Vh8wPmYZqhffcsE+JT55oIFWIDdw
	 T9gym59rQbqqmXvBtv8HBKtwMyJVDVskKUjSQcbcsoS9Q7M9H+FeICDUgM3gkBa49f
	 nczsCHApOv/YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988C3930A9C;
	Sat,  6 Jun 2026 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Expose signature verdict via
 bpf_prog_aux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071721464.4008217.11342369781653595071.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 03:40:14 +0000
References: <20260605213518.544262-1-daniel@iogearbox.net>
In-Reply-To: <20260605213518.544262-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 23:35:17 +0200 you wrote:
> From: KP Singh <kpsingh@kernel.org>
> 
> BPF_PROG_LOAD verifies the loader signature but does not record the
> outcome on the BPF program. [BPF] LSMs and audit can read attr->signature
> and attr->keyring_id to infer "was this signed, and if so, against which
> keyring".
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Expose signature verdict via bpf_prog_aux
    https://git.kernel.org/bpf/bpf-next/c/63a673e8a411
  - [bpf-next,2/2] selftests/bpf: Inspect the signature verdict exposed to BPF LSM
    https://git.kernel.org/bpf/bpf-next/c/8ddce416797b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


