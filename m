Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A743C04A
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104216; cv=none; b=lAo3SBAY/Ne3sWr79iyYqgnrpmgpbxOzolm3XldB3+6vcyFCaW6dtJ4682Ir+dkuy0Bobuss9es6UoxegUYe19OAb9VrwR61qijylQmgQpd1i83kGVSiqSXp8H7f3Vv8eMqWEbn3LPH1a2+s67YMiCnF2akBcUrDC5omi6hoi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104216; c=relaxed/simple;
	bh=bsjVzrmtyyUSGJljg1HC2pD4uhYCpGEkufnPFAYL4Rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VlbR22jVyzydn61GKelkfqDfNQhqty8y61E0dr8R+R5jQIsdSPxp2/VDS/Wz9IoyX+Ywxl08Y4bAb7muSVgn2nEefJzTOJb6xVFkVLu95nq1hPE5U1yVI0ClPPhjVjq3kEkmnaNWYkgnIP2pH3sWYreJvh6f25YXR9/ZG6GV66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAyy8F7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAyy8F7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039801F00893;
	Wed, 10 Jun 2026 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104215;
	bh=bZvGkxGmlkNDtKGhFqG54KusfvaB1Fizfno+cgK/Ehc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WAyy8F7CAXfutVZucX65b0Ib/E8R39E3ThyBrr1S+izusQ068UTNkQVjmqD6n+aCa
	 E8doHDxgXATxz+2MgBE9nO48oOIUc23xhhD1wrGw6n7AM224c704grGyRsajQZMO9v
	 ZWA91beUpzR61A/ZnYdxb5+cj8bmbc+6gH+0IgrUIzeqGcOYkGs6951qz0iom6ciJ6
	 LLFBlfQA4dcbeSSgwMXB2/oof0cNewIeo7AxQb+f7xQQ6MgeExZmWkl7Fa/Jppvg1X
	 4QMvic74rzdsQYvOt2WYHY60SFmFDs76+W8OP+93n9ltit3qlsnrgVwIpDSzEEl8ua
	 1Yx6gq/p5+tWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1979E3930D5F;
	Wed, 10 Jun 2026 15:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] Fix kptr dtor deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110421264.3082243.12632209176778813392.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:10:12 +0000
References: <20260609202548.3571690-1-memxor@gmail.com>
In-Reply-To: <20260609202548.3571690-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 utilityemal77@gmail.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 22:25:42 +0200 you wrote:
> Referenced kptr destruction can run from tracing/NMI contexts through
> bpf_obj_drop() and map value update/delete paths, reaching NMI-unsafe
> special field teardown and deadlocks. Justin reported the issue and
> iterated on fixes in [0]-[2], and also confirmed the bpf_obj_drop()
> reproducer in [3].
> 
> This series rejects unsafe obj drops from non-iterator tracing programs,
> limits map value recycle to NMI-safe field cancellation, and adds
> focused selftests for the obj_drop(), NMI delete, and recycle teardown
> cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: Reject bpf_obj_drop() from tracing progs
    https://git.kernel.org/bpf/bpf-next/c/94c8d1c21be4
  - [bpf-next,v3,2/4] bpf: Cancel special fields on map value recycle
    https://git.kernel.org/bpf/bpf-next/c/a3a81d247651
  - [bpf-next,v3,3/4] selftests/bpf: Exercise unsafe obj drops from tracing progs
    https://git.kernel.org/bpf/bpf-next/c/4b84518137ce
  - [bpf-next,v3,4/4] selftests/bpf: Exercise kptr map update lifetime
    https://git.kernel.org/bpf/bpf-next/c/2e7c6cb4d843

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


