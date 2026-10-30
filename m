Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398812;
	b=Kr87PLmtzgAfm3OEI+8eiMbne1k2thLaHf4fBTwKTTjWXAYh5qVQqGYDDiySBKf53FDl
	 CWO1OuA7SZv+nNP+65DkW7Sw0N49DsEIvRJFocy4AHzRjFZR2pyf4wjl1ReIiihm6Pp0Y
	 R7OOtBsbMApMUVORmW5fsOM3Cng53LWNrEBSzkbIV0o0XAe6CnUvCUjfB6thTkeegXuAE
	 4rRV/MqkjA1zeBX+XIYE/na5e0M1JNtu8L/LxAgE2DpTaMuaaL4o96UmQVg1N6QPSWnxv
	 GvW32PY7Mw/rMOlKIzNQ+uLkG8DSOM7lkiszLjsH65QowWNXP/lKIfXK+XhMGOq7MuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nUVPX0u/PLHL1nNI57wXFC7m1B0qXRoAffN0CL7YQRM=;
	b=m37mpT6JbC9gIHkH5G8kJvI7R4GqjvltR5GbgbeiUqWpWro/XgWfmeJfriXOg7znDXCH
	 nRffZeJNh+U03jL+TOucAfSFFPQc5dxIamIl4A7niSP87FRWBOlAweTlXuE3RpLKlZhNo
	 JG5Ir81bRndkCL7JSz3rW+7+0N5c1Rjc/wbdpXbJRPH25lnaPpcsmSF4C4AMECnwjleqC
	 +yOLUILWaEKCFU5COzEPEtC3MbzaaC7+uhLVXDxr4JfZaVsATPKMcN6q/ctjK41QGLHQl
	 DDmyJcaP3cw3P6kya/Re430zmvrzd99tSCDNoaoVasLMkmG8G4ZKowkrdrCvg8cEMlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfSi2rAe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E6606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfSi2rAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE2E1F000C1;
	Fri, 30 Oct 2026 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398811;
	bh=nUVPX0u/PLHL1nNI57wXFC7m1B0qXRoAffN0CL7YQRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VfSi2rAeca9GWN5+K/uT7ATg82IYqvFzQvZQfrkq7NJz6havnjI35SDH0ja2Y3ZMm
	 H0eedZ6FM2hhhFkYeuits2QmORy3BWhZ2wbsQtL7zeHb60c3yZndaDvIHednMl7TBo
	 nL9SbAtlLQnZLcJYLiv5LZn9smAURkNh6OO5h9gAsEjCccf0SDSYs1YmAR5LkAr4n6
	 HHi78HfmnOmJO78fn1OctnAHlGYtV1cTdmNtuGAzQcOd9pmyBUeFAhoOmQVS7MkL2N
	 PHBlaeSG+spn+G1k/9AJOLgrM2UzGafF7h+qHDhpGeQoex1sI0fWS+OO9X2sj0Mwv/
	 5bGaQrnL2jKhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 405083800478;
	Fri, 30 Oct 2026 22:20:11 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] bpf: Drop percpu_counter from the htab
 element
 count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339880981.1802147.12535140173060798885.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:20:09 +0000
References: <20261021185117.650403-1-puranjay@kernel.org>
In-Reply-To: <20261021185117.650403-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Oct 2026 11:51:16 -0700 you wrote:
> The element count of a large non-preallocated hash map is a
> percpu_counter, whose slow path takes fbc->lock with
> raw_spin_lock_irqsave(). That is not safe against BPF programs that run
> while the lock is held or contended: NMI programs and, as
> queued_spin_lock_slowpath() calls trace_contention_end() with the lock
> already held, programs attached to the contention_end tracepoint. If such
> a program updates the same map it spins on the lock its own CPU holds:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Drop percpu_counter from the htab element count
    https://git.kernel.org/bpf/bpf/c/1cd28b5354ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


