Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5A3D9DD6
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939003; cv=none; b=d3ItAWZRL+FToIaDU85ZKb95VfLKdsX6q1ANq7dijkeGGTMjpAAE745DllutErF3WBTmWlTzESQu2qpqWQK/+c7LqFKK490raVAeiXlk6ZW9ZdxtpBvE9P19Jmh3YH+57jc1+cRtasVLSGbO+7Hf7V63uUWb/4lvGK8BrA66Nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939003; c=relaxed/simple;
	bh=5XMmevMSIcNo9g0z/IxDWkgjampt4lzWCduJCWAUXvs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T4llC9kQLrm99/V5sKPTaDZkkEofTN9WYT3ANGYwz0xbNzSylSD0MT1dfByRq9XQFndDE2dooaGgzBENoNEveG+1R+rajvq5iElyNBo0oxuS3li7Ta/jgYdvXY18C7o6FDiNl31EV4dnz74KLt/d9HYVqqvSfBLNyaAPgrc8fLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrhdkUz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrhdkUz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6B1F00A3D;
	Wed,  9 Sep 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938998;
	bh=uTdCmFU5et++NP+PtVgZV8B5wBbl1bMVBsx1QGLYuyE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QrhdkUz3vx8a9V1aaZLonUSyxhBAC7eM9CBAZ0sbDkAoSvERjlKCUEzzYCBb1AApj
	 1G4ijUMeJ79T/oQvAEF/AczAuHhauUG8EsgFisM3oGv//unZUIEqcKovKkOvmnC5dm
	 gTPnRm/dZ0bptGsXPvyLeKXwttx5kXc6qu2+3+BqfV1RJAwGg1iZcOS2y1tKR0ifmp
	 vn+lWOmOy6477hePgzgrm1tmlkG8604tlAMSDMGpCi97ozRguV5oW+qrQMQ/gpM7N1
	 87XWqdFI/19YQ55b9g6SzpXdYnMScUxZX2gahpCKOJHTsF0h/RIT8WbtZccyrgd6ep
	 B57Duld766nEA==
Content-Type: multipart/mixed; boundary="===============2361867519719627926=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69c3b97a109100393b692506d0926bbe1b7c13bf2e4ec7dfbac1586774efb766@mail.kernel.org>
In-Reply-To: <20260909062604.4008177-1-yonghong.song@linux.dev>
References: <20260909062604.4008177-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 08/12] bpf, x86: Move kfunc arguments into the x86-64 calling convention
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:29:58 +0000 (UTC)

--===============2361867519719627926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 7d2a9d78dc93fad535592157230f508d5bc54a7c
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Tue Sep 8 23:26:04 2026 -0700
>
>     bpf, x86: Move kfunc arguments into the x86-64 calling convention
>
>     Do proper move from bpf calling convention to x86_64 calling convention
>     to satisfy native requirement.
>
>     In addition, the arena argument walk counts eightbytes rather than
>     parameters, as an argument may take two registers.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for multi-slot kfunc argument handling. The fix
corrects emit_kfunc_arena_args() to count eightbytes (register slots) instead
of parameter indices when walking arena arguments, which would cause incorrect
register assignment when kfunc arguments take multiple registers (such as
__int128 or large structs).

Should this include a Fixes: tag for the commit that introduced
emit_kfunc_arena_args() with the parameter-index bug?

  Fixes: 34c3503cb29a ("bpf: Wire up JIT support for 16-byte kfunc returns")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============2361867519719627926==--
