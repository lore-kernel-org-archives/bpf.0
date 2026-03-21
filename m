Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE9257825
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124439; cv=none; b=H/hlwn2TQAG+OKffCyWkkvdGrHsFWI0NAJ1HB3pTzmxEVEo19KtLunrnuyTdxwHr267sWmbQr3EURzqG7yZhTaXAuu+uBO9PEpothLEJxYedgG6c3+VI2xgLXz/5hIpKlYpJBDOD84rey452/uuHc/GMLfImINXGYztGxsx2QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124439; c=relaxed/simple;
	bh=mIDdGHwS0+lVvW3VKqKiy/2xV+8Z0FyAEsHML2BGcUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLWI7owzy1H3kZmf/moYJ3zs78u1XlQD+6nVQYl9CRdFgPdEtNOlvd/wYDSmdjq7QEOvMqSCO/9Xvp2+5BgeaLa8ADCvo9Vx6Lx8K9nGvDFj+MbLVLml+bCLLNj9clhHZZnzqVL2VxX1RPwAGS5fxASkg7k/OjdV/0mp5B6YDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjNImdVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjNImdVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3571FC19421;
	Sat, 21 Mar 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124439;
	bh=mIDdGHwS0+lVvW3VKqKiy/2xV+8Z0FyAEsHML2BGcUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RjNImdVhVbmN8iD9jEqcezeGf5hvlNoEyfAFkuwonuG0hDbE+0vJ9hkBgbxkh95/v
	 tAlwOPtemLHgOIEJItVIbc/yjKLBIa/yn7tawb/tNpmVamZPABhmK8mKPUC9EVsIDD
	 PHrtCsTWRb4qAUdenpek5FQ6PEqM5wZKQBaqHfG5BG+siOmd9kNmaP/fNIHIrwQOAe
	 GA9Vg/fszr+LEn+m0Iw2dFh1+YcRa5K6N1kzlyUDLwKjko2JCwROjYDho8Tfy1pEt2
	 ItwBZ5GI6LS+vutGNU7niwqHchrAsw0NOt9CpQxWCq5g50WYyalEAuZ5KkIlS9Hk9H
	 d9mZ3dw9SN4Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC63808200;
	Sat, 21 Mar 2026 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] libbpf: Add bpf_program__clone() for
 individual program loading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412442853.2951219.12560475166355057636.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:20:28 +0000
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Mar 2026 10:39:20 -0700 you wrote:
> This series adds bpf_program__clone() to libbpf and converts veristat to
> use it, replacing the costly per-program object re-opening pattern.
> 
> veristat needs to load each BPF program in isolation to collect
> per-program verification statistics. Previously it achieved this by
> opening a fresh bpf_object for every program, disabling autoload on all
> but the target, and loading the whole object. For object files with many
> programs this meant repeating ELF parsing and BTF processing N times.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: Introduce bpf_program__clone()
    https://git.kernel.org/bpf/bpf-next/c/970bd2dced35
  - [bpf-next,v4,2/3] selftests/bpf: Use bpf_program__clone() in veristat
    https://git.kernel.org/bpf/bpf-next/c/3be706b937f3
  - [bpf-next,v4,3/3] selftests/bpf: Test bpf_program__clone() attach_btf_id override
    https://git.kernel.org/bpf/bpf-next/c/ceebdeec6e8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


