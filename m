Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740811;
	b=xt3WVxoE8v4C33HUuwed4bjGr3O0kpiZvvNRzta0GyQPtZEXsq3PSGFm1NRPs6ySJfeq
	 05NG5gJiuWKtItWUi1bjQNAAvh543Hp2X111QEWL8amntosYnrvmFA2ko+T63P37pZCIv
	 HmUelRiATL8ke1irYbjb8LBh9h2jsq62eW7E2RrMevI+rHKP9SPbmMp4JnDxlPr+sM5nX
	 BkZ7ElyWdz/AoV/AiHFI+ihwfB3I/vkEviC01CUYZ0Ik54PsKO5N/OR1fKDSgD6qFkB8N
	 OZ15ijtUbbUTpUHs1OHZxfkbdiB/dG5SGNOMrQfqJeg8/TDSWnaopZOLT89qf9kJ/Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZyPK20KOp8+G6RcMlMhtqHt6i6AKVBGN72ubBHm6PXQ=;
	b=ImNU6AFt4NVPE9ZCtoTBY1ioqEC7XNRckW7OSWBA9LCqgcOxjcoMLpmKwW9KQmUBPQog
	 Mj2STJl4vnMvJQlx9ox1nV0FYUiC2SIlqlMrRvti6YJCRfpP1lFXUngOT4gnrQDg2hjbj
	 9jETck1V37T/AF4Ddc9Ah4blI5+qmsZJX0HoFC44NSJW6O6zoKQkoBHZr5A4Mf0DkUdc1
	 WNsqjp03A3ONCWFAstTYFvG1fspoVg77TVkE4cOvno85xXFLZunUMLIPAfX3zArUygdPR
	 7WXExkrE7n23RK2y1UMiXTcQNBVAEWbJ0E2MMo2boXgCsYhqaQaZq1Gwm6JdBuzyVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QN3IyaO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC789606A329;
	Tue,  3 Nov 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QN3IyaO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483091F000C1;
	Tue,  3 Nov 2026 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740810;
	bh=ZyPK20KOp8+G6RcMlMhtqHt6i6AKVBGN72ubBHm6PXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QN3IyaO91ZZCKUD7t1v+Q/LsQflhMr47ktj78CKqZr72vplU68OwUHJI1Kf25Sg2s
	 3BD4ddRhUzv9zG0roFnNLbIdt3pwS7PGFbVEZDnjc5VV784ZlWzoRKel382ikcuhG5
	 ydu3BeXxHIXQQPx1aRlGth1q8pSCctTPCfCwjfBCa5BhkveMRgwc53TD7WrS83xA0O
	 bSFKxC5dXOglS/YYL+pc3tX9L0L86BcB3Nok/EmJKHBXfhF1Kqx8Iy7wGIghaD2gM2
	 FItFmGtL7KzK05tzaOb+LZKTmw5FvJZuuAWv7sjjSYToo31PRtnbOaP6biy0GUV8mr
	 QWaFK5jlhTW2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4024F391B0A1;
	Tue,  3 Nov 2026 21:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 lsm: Fix cgroup shim selection for socket hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374080880.1885738.1778795471883427227.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:20:08 +0000
References: <20261103165541.291744-1-parri.andrea@gmail.com>
In-Reply-To: <20261103165541.291744-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: kpsingh@kernel.org, matt@bobrowski.net, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 17:55:40 +0100 you wrote:
> bpf_lsm_find_cgroup_shim() picks the shim that runs a BPF_LSM_CGROUP
> program from the first argument of the attached hook. It compares
> args[0].type, the BTF id of the argument's pointer type, against
> btf_sock_ids[], which holds the struct ids of struct socket and struct
> sock. A pointer id is never equal to a struct id, so neither branch is
> taken and every cgroup LSM program runs through
> __cgroup_bpf_run_lsm_current().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, lsm: Fix cgroup shim selection for socket hooks
    https://git.kernel.org/bpf/bpf-next/c/7b8b803c3ce6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


