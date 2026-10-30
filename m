Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395806;
	b=RdTuriDhvmt6WdeYRFQ0B4n4KE5qCSNHTaMipQAo8DNbRiA/CYlh2uOnZn8gzqvWuvfW
	 QGM6ERhqno9aHcg8ReauzFwmoCpDD0kZfJpa7EkBmlfN8luweFtfBAXasHLnYH7+C6LPR
	 O43vJT0UdaD0NCzmWGVgqIBGnF0i8ZHaFbFbJh7+pRAVE93VX2ZsUJNIJzW4HCpdjKOBq
	 PJHZlkvKgBl/239GX7J/jFzFiyIsdysDI+bG8/fEZwmE/Y+skKSV7MCN2IoAiSQWB3bhG
	 W6oMzqdJHVpuE5dnLvUXWV36chAJawBJym+2H/buLXHlo16FL8vtgClIN5orB+GTOLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YVUpwwdsptzyTTKvxrJx1edESxPD/7xFnYyZae/E5YY=;
	b=PYaxwzs0jKPjPGjMgd8Yy82T3jcZbJSNAzcp1vGw9iMww3JhAWbSSbgveR9ou8seOk6v
	 A0AmIGy8AZlfkbwkKrixl1mRCZpDdc3oRiHiZ36MX7LGWLLgtD3uEhCJhSVUJJFaRUoQ5
	 3ZwE050p+K3JLPsrrJn+J+exG/DsW2m9XBMA6wCLngNxtaJO7bCnmAbAAmYJMhSiILkqt
	 mRXZK50fTOaGvbGvTIC5kyW6sdLw4CXsbRpkic8gjo/0Vfrl+kMy6gOCbPCnVZEngfcWP
	 EtYa5C9ayVdfKLSKS4G/aTfpiRMJuTw7mqwZV7wq44rC4jGtpq3E1Nm8pDcfRP2HFyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmy4dVIU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE0606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmy4dVIU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3721F000C1;
	Fri, 30 Oct 2026 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395805;
	bh=YVUpwwdsptzyTTKvxrJx1edESxPD/7xFnYyZae/E5YY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hmy4dVIUQEhUr+qifo9wadpYVLNqmeSk4W5UQjqrtIW0WHgqXMiMUiwzztzJLhwdu
	 zfQlBWUUiFCF1ckecpuViqx5FH5nYQFn+gGJ6k5xRfSWHfIxsm6V8EOOewnnN2PM8N
	 564m/WUSpvdkQiPaEQx+Xm2JWB3ke+Usw3BayfNUaNgcYOIOgkJa2VUp0O3MF5Lg2w
	 3chN2w2Fu3gCCyhgjJnuL2KAL2sBrX8DID0+pLfkUDT5ZNYF+y9aUyGGOY999Jbaek
	 Hk4h8PHxJl+4d0/cFdlcO16BU1OSVykElZCMUDvlaA6UJMvbhNmwV5dbP5mj5/QIZz
	 6hPla+fCW5pDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D17E3800478;
	Fri, 30 Oct 2026 21:30:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3 1/2] x86/ftrace: Mark jmp mode by clearing bit 63
 of
 trampoline address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339580440.1780053.5199414869157565214.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 21:30:04 +0000
References: <20261028202345.1215859-1-daniel@iogearbox.net>
In-Reply-To: <20261028202345.1215859-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
 andrii@kernel.org, jolsa@kernel.org, dongml2@chinatelecom.cn

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Oct 2026 21:23:44 +0100 you wrote:
> Since commit 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
> ftrace_call_replace() emits a jmp instead of a call when bit 0 of the
> target is set, the mark of a direct trampoline that is entered by a jmp.
> ftrace_update_ftrace_func() and arch_ftrace_update_trampoline() use it
> too, for the call of the ftrace callback in ftrace_caller, ftrace_regs_caller
> and the ftrace trampolines, but a callback is a C function and can start
> at an odd address. It does with gcc13 and CONFIG_CC_OPTIMIZE_FOR_SIZE=y:
> gcc13 has no -fmin-function-alignment, so CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> is not set, and the -falign-functions=16 used in its place does not apply
> to functions optimized for size. Here ftrace_ops_list_func() starts at:
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] x86/ftrace: Mark jmp mode by clearing bit 63 of trampoline address
    https://git.kernel.org/bpf/bpf/c/31ac959c915c
  - [bpf,v3,2/2] selftests/bpf: Test kprobe and fentry/fexit programs on one function
    https://git.kernel.org/bpf/bpf/c/99681d9a384f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


