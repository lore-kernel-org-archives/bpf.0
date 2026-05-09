Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1C3D6CDA;
	Sat,  9 May 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778368861; cv=none; b=nE3VExpUXohbGjamw7IdvMj5SGo/N8NIBKcMKE+ip5CctDrqb+iwjMRJvAyMnsfaVdRs0V4Vd2VbaQMxsmO8vBU4hzacBxY/T9v2F+kxTZyjuHUpOpu9ir4kK7zYpbZI6/RQZZ7H1b3YLGtFktbKszVy4LKHhkBihG7Jdd3sMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778368861; c=relaxed/simple;
	bh=wWZeMYwsqEvDA7PMlccFsaY96+YJMwE1z6o84K3OZ9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c4rioIoXsfdJmRr4gM7LbvuUZQUro8ggAyVlCkpzwIGBYkn5PvTFlKK5S5uCehdEIr8RFtI5S7PxtT6x7hn9Taz6/m8mbM+iZnp32mChk38gNieso/Yoh9sXzaLVCx27BxEUl1Os8T69TgdzPpBxJ/0eeajl2qsrIYRklxiEiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWNSRIqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWNSRIqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8E3C2BCC7;
	Sat,  9 May 2026 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778368861;
	bh=wWZeMYwsqEvDA7PMlccFsaY96+YJMwE1z6o84K3OZ9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWNSRIqddcNZaCIlH+Q8pEO0YXoz0tvbIjjePA+kwofAiMYwH8Fp4q06wGUGFpgGH
	 mjGLqjsfii70X+7OAZsiUsZaCFXFqU2ilumiMEfB2RP1abZ+/2RCjDtA3DA4LCj4bK
	 c3RXKyYfIK4O/EKp89w+FBqlxV4odnCTSUpDaFlvJACceF8uSxhNCHjTCnI1IMNtMc
	 fpRbg3tvF+2EUR+XnLKlPSuVxHqzhz8DYe176vvCIvxpkysNM2RlWBqL2Tu4Tfbrcf
	 ZuQJhXqPeaVj9/k5eFJ51YqROkyf3/q9RnaTeUu2bju6S55NV+7iJy3W/9FT8Cnoeh
	 GesHIvzt5nA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB33811A7B;
	Sat,  9 May 2026 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena
 direct-value access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177836880856.1203938.3770231489587618588.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 23:20:08 +0000
References: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
In-Reply-To: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, greg@kroah.com, security@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Apr 2026 02:25:05 +0900 you wrote:
> BPF_MAP_TYPE_ARENA accepts BPF_PSEUDO_MAP_VALUE offsets at exactly
> the end of the arena mapping (off == arena_size). The boundary check
> in arena_map_direct_value_addr() uses `>` instead of `>=`, which
> incorrectly allows a one-past-end pointer to be accepted.
> 
> Change the condition to `>=` to correctly reject offsets that fall
> outside the valid arena user_vm range.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix off-by-one boundary validation in arena direct-value access
    https://git.kernel.org/bpf/bpf/c/3ac1a467e376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


