Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28D489FCC;
	Fri,  2 Oct 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941207; cv=none; b=Cupd86LY0Mdy0/KNy2GKneffl4k7aKIisn//MzyGTyKuEliCaVKtCmZKW1UFKyn4f133zlPd9BQoHISVeSKP4lVICmUUf25kTyjPETXlUBVP0yC/NZgQyrjK/sGWmGktiN3niJ81jmpFJ0VdtPfi6vffWWPALeUhYzuawe/Jhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941207; c=relaxed/simple;
	bh=p2N30MWfbkl7jEEhOJXdhsz4CZH0PQdPGky/0/CYK4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmMfrPdkVs0uDeayIJnueEDhO5Eoi2z4kvuFdtaMqCAiJOQayB1P+qcn4PuBPc55YRQ1SImt/U2Miejz8FC5GgrEK01W2ircKo8xsr4/lb2v9KqqLMUds52s64EFdOzE1k8IP6zafFRD4eFk17CftHX/0kscbpF7G5M/p0OAOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiLSTv8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiLSTv8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4429C1F000FF;
	Fri,  2 Oct 2026 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941206;
	bh=TsTCBabtQ2h572pP/gsmJej3ubVwDb5kiEJhHW05gmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YiLSTv8We6UqxWjHsvsvLc8qyNe8SE5w9acGld0HaVrqWdQpyadI4TiWfaJZ79dj9
	 aoKwmH7SluzFdxFowGLNfHcVjvzzDwNdPsy0rzodKq7JoAZsgTdsbGZD7kiDacy1hO
	 qPYyewKZR4hD/4FMq05MHqxIYaHxIa333PiRU2fZvjkxs6V/rVO27PIBY4kBSXmsWW
	 C0EeiJv4lqnz8fkgthi2ly+yo2CNjWI7/N3cM6vy644R3UEZ2ho1URzsXM+IPKWBe3
	 KxppiTSGnHWcqxfKqqwtlZNXlCgvNY83WIiYcuH/uyGHOZZr9659h+FFFZFzaROzN5
	 yUL9sVFlFrs0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A24C38119E9;
	Fri,  2 Oct 2026 11:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix missing migration protection in
 __rhtab_map_lookup_and_delete_batch()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179094120480.3373240.12156840155673905031.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 11:40:04 +0000
References: <20260929081609.557899-1-omermetekaya0@gmail.com>
In-Reply-To: <20260929081609.557899-1-omermetekaya0@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya_=3Comermetekaya0=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Sep 2026 11:10:34 +0300 you wrote:
> bpf_mem_cache_free_rcu() uses this_cpu_ptr() which requires migration
> to be disabled. All callers of rhtab_delete_elem() disable migration
> except __rhtab_map_lookup_and_delete_batch(), which calls it under
> rcu_read_lock() only.
> 
> On CONFIG_PREEMPT_RCU, rcu_read_lock() does not disable preemption or
> migration, so the task can migrate between CPUs during the delete loop,
> causing this_cpu_ptr() to trigger:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix missing migration protection in __rhtab_map_lookup_and_delete_batch()
    https://git.kernel.org/bpf/bpf/c/de020dc8049b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


