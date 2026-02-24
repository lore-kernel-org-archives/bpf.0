Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005D23C8AE;
	Tue, 24 Feb 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897807; cv=none; b=UJQo9Oqo1aptRpCBhFwmW7OGWRNygmqvDbesxs/CMlkcxJtZTbj5GrIL0DlgJ0UIBv5LB2h3mRZa6Q3SP/K4Xpk7pQ136biNZMO/vg9IwKL2y6YgYOgOWlVgqfv7F1jPy2nJyec0j6FmcOOUE48FZ3sEpjWys/TyTWExLngI2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897807; c=relaxed/simple;
	bh=mCXv0ot5+07qrC12j9YNdK7j5ywNAVyr2ZBKGkvLhbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rs6B7TJ5Gxw6FIGQogpQPiL2cmqjDfDa51etB+snbBd9ZXge8iFUD06uBgkgxn55vjgN4NJ3GOtd8M9n8onvVfeIrPS30Dlm4v51JHEpSX/4eKhJkl+JsD/bkvjIPp3x/VSTdk4brQcu2ocnxca6ysxdfRmb6TwehzliaRTf0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHAzelQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHAzelQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801ECC116C6;
	Tue, 24 Feb 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897806;
	bh=mCXv0ot5+07qrC12j9YNdK7j5ywNAVyr2ZBKGkvLhbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VHAzelQR7+spe5xvRTZj5tnlH5AkfyN5FT178EHenB/hKl53aQsntlgrl9UHLPF7S
	 o4QLgYswqUU1SUpUdCAyt6lLpJv7oWMBsWfse4oqaHyiy2zLRTTRkDAIZghkg9zvKP
	 xHAa6zcFzccKMLOGFr2dJF7kEFVGeszeKfoTKUdhkjrrXR3N1nt/L+TMVkGVLmEp+O
	 VFkEZ0SG4Gnv4firREiciHPVcVy5SFiEcbB2I301AUGg0/GVtJPrdQJK0cTWs9DPTw
	 ziKSbKg0EQcTngy6I0cEKuZrhD5+NWmG+34afz2OzGeQQvKAp+kxzhIpMusBX/uEIx
	 kXoLR9KGKRZwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0333808200;
	Tue, 24 Feb 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v7 0/5] bpf: Expand the usage scenarios of
 bpf_kptr_xchg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189781254.3271663.4849399653338044310.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:50:12 +0000
References: <20260214124042.62229-1-pilgrimtao@gmail.com>
In-Reply-To: <20260214124042.62229-1-pilgrimtao@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yangfeng@kylinos.cn,
 alexei.starovoitov@gmail.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, chengkaitao@kylinos.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Feb 2026 20:40:37 +0800 you wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> When using bpf_kptr_xchg, we triggered the following error:
>     31: (85) call bpf_kptr_xchg#194
>     function calls are not allowed while holding a lock
> bpf_kptr_xchg can now be used in lock-held contexts, so we extended
> its usage scope in [patch 1/5].
> 
> [...]

Here is the summary with links:
  - [RESEND,v7,1/5] bpf: allow calling bpf_kptr_xchg while holding a lock
    https://git.kernel.org/bpf/bpf-next/c/964c0747686a
  - [RESEND,v7,2/5] bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
    https://git.kernel.org/bpf/bpf-next/c/ee9886c40aae
  - [RESEND,v7,3/5] selftests/bpf: Add supplementary tests for bpf_kptr_xchg
    https://git.kernel.org/bpf/bpf-next/c/580fa3430b5d
  - [RESEND,v7,4/5] bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
    https://git.kernel.org/bpf/bpf-next/c/fb1590448ff7
  - [RESEND,v7,5/5] selftests/bpf: Add test case for rbtree nodes that contain both bpf_refcount and kptr fields.
    https://git.kernel.org/bpf/bpf-next/c/ed8fa4b8894f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


