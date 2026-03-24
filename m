Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54B359A9A;
	Tue, 24 Mar 2026 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384830; cv=none; b=VbD+k1UkuV6vcmDC+ghRRxHZqum5Y7C+/2qJ8OM7fz9pWZpoIE3RAtQ6Zxxl46aSsx1n1wJQAsq1BrKtmHOoJ+ABT5rPzJoL/AKUkTeLKbTSYgjmsI6sHZa/WdYjBRN0lf06rmjT47FvXiqTnpdEV9HjuV6uVcq4/ROZPdtWOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384830; c=relaxed/simple;
	bh=URPMaOTXsYfMNiyMZXQtMJUAGtp5qTPjF52FOYVsAZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FzHXe3R8fUWseyNHO04o3UN7+MM199ursv0WSa5lMQxzLRS9dg2II1j99UEHuB30DOm2MbgSOI1KwP0HKwsDAPe1geZfAVlUbBsm6+VBikrFCeslHixhmkWrKYGa9a/THf4Wm4dRiddjLOpQXMD1fd2HXYpiGvE3yKKInUK53XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvFex9Mn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvFex9Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C223AC2BCB2;
	Tue, 24 Mar 2026 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384829;
	bh=URPMaOTXsYfMNiyMZXQtMJUAGtp5qTPjF52FOYVsAZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DvFex9Mnu/Gu4ktODRTEbyw7k4zY4Bv3UJ0YxUSWfzxcTkW7eP4RKwOsOiUt1jRaY
	 ziPUiyK1lmB6zeL05v5W+ISjZHCQDDZbZ/HcQVKv87YEu+N06CnQ49JPtFwxFi6m12
	 AcvG163fBDdUCiuYI+33EggfuimxF+q77SfPQzC26G3X/Vy1KSKv266yq49rmdIJMo
	 aZ5TwU+37BOXojsU6PSsmKaQUWsNIfLv6gnxpNl3zMYol8BhL2LvdYuDZfitIFfHn2
	 z7tXKyzUq624S87vaRZbspJ5cWEH2ufF2eAIsEa83aEvzzK6t4qHqPFa8dwobAfwWh
	 0AnO1UrAFgi5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F403808203;
	Tue, 24 Mar 2026 20:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: update outdated comment for refactored
 btf_check_kfunc_arg_match()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438481754.1297770.5595980549386227407.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 20:40:17 +0000
References: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 21 Mar 2026 18:56:58 +0800 you wrote:
> The function btf_check_kfunc_arg_match() was refactored into
> check_kfunc_args() by commit 00b85860feb8 ("bpf: Rewrite kfunc
> argument handling").  Update the comment accordingly.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - bpf: update outdated comment for refactored btf_check_kfunc_arg_match()
    https://git.kernel.org/bpf/bpf-next/c/70b5f3f7822a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


