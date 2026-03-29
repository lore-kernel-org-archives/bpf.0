Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC97081F
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803624; cv=none; b=j5yjcoFZDBBmWMixH7LA+eP1jn/QYBP0uRsVKaAdmxVPbO1J9++MOFUi9azZxeeGdDmjP+9o0u9IfTzWWyCS+7vbH2CR4qoxcdc+0uK80dgIzqabZJaEQ1T4mtEI8Ft0+yiKzTpeFF14U+bhpd+Pjxpep+b3xod62Y+GGLzCIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803624; c=relaxed/simple;
	bh=C9PG3m73HkcGu4QIkcl4bUhncWiNxg4nnP/u+13CPcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5TKWF+keiPMKWv5FUgV9XMFwxRiiXu8z7s9uxdc2odN81LpcWBmBCAYSIduuIG30otX0Iej7xLHaGlNPrtrJy9WFUkdy81vVgjTbjKwOqteTleSX0EngLURT+liAX/7BUYG1ahdr/4NrJk427k7PHt6RSSJS+Vr4ofAUpb/IBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ3uiCof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ3uiCof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC601C116C6;
	Sun, 29 Mar 2026 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774803623;
	bh=C9PG3m73HkcGu4QIkcl4bUhncWiNxg4nnP/u+13CPcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJ3uiCofWh09+Ye+Tb/45+pXkNc8WWYNmPgLZOxHlP6Lxt56EkdvCurmpLRz3ghSY
	 vJcMxDXw7CrD2CdLPRkt0VtYMYA8N48J4K63AevvSMpDycCAh7SUwqUsp8qltN7QkE
	 SEsI5/zfafuUOGdRyA6UlQPeSW1elG55w2fCtLAhVrVlfYKAHQ4oMb1afntM3mf5Q+
	 INY6hjt/4FUWu2XJH8tfkZ00bswBDZjqqt91LzvH5dsnKyGkg6mOOd2Hdmt2FZD7nl
	 jltwRfSsr8khKMEGFetftqIsABcEFbVQLFKKfRejuqYUW0j7RelkQ84HgEYNp5NbCj
	 rrSNY5gfFdaBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E44393000F;
	Sun, 29 Mar 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177480360855.412443.9457220854814334016.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 17:00:08 +0000
References: <20260327203241.3365046-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260327203241.3365046-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, olsajiri@gmail.com, mykyta.yatsenko5@gmail.com,
 memxor@gmail.com, bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Mar 2026 13:32:40 -0700 you wrote:
> The following kfuncs currently accept void *meta__ign argument:
>   * bpf_obj_new_impl
>   * bpf_obj_drop_impl
>   * bpf_percpu_obj_new_impl
>   * bpf_percpu_obj_drop_impl
>   * bpf_refcount_acquire_impl
>   * bpf_list_push_back_impl
>   * bpf_list_push_front_impl
>   * bpf_rbtree_add_impl
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/d457072576a6
  - [bpf-next,v5,2/2] selftests/bpf: Update kfuncs using btf_struct_meta to new variants
    https://git.kernel.org/bpf/bpf-next/c/101a9d9df8e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


