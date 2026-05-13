Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBB3A6EF5;
	Wed, 13 May 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695452; cv=none; b=J4ViBe5kSHUKK1OD+feFgYQd4z7IlFp1FIjVFdG0d9oMk34L+yqvp2TXgMBUlZrjX0R5CUPYMJCzXIadvDJ6lau39v8G/N8iTwfPxzkQxQzp5G92TF6U1byTxoQ/LEHn8tYBPBoBvafMKBVqYRptP7Xm9cnpQHcSzFl7Rsv4XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695452; c=relaxed/simple;
	bh=w4q4aVzm+RT1F+RED5fGLWx0qqvUCGtSgNrulFtmX88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMkTphdpGtJ2INaCOis7Nxzgehj9/B/N2/4k2fStJ0K3xe0yJ+MJR1V/wGlqsKGd4MzcuV+obcOm4w6zA+qwk2z0rHa0G5YCv+nGctPXJqMR0ruhGHAoqCP2baUlGCzqd+YLR1pFJzNeKDXhfpKHyRT30z0jcgYQSTF4V2uEXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggKCVMJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggKCVMJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32395C19425;
	Wed, 13 May 2026 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778695452;
	bh=w4q4aVzm+RT1F+RED5fGLWx0qqvUCGtSgNrulFtmX88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggKCVMJm94Ny628gJO1nJA7iCGeb3t+GcM7RrAvtdylyh7733OJJHjaJkVZfqlsuL
	 /uWTUkrRpyMlZaT9K4l5ERBxKYAZq2rv8VcWDCndnxozMZghUv+EJV89dTXbAfydFN
	 cqOfDWkMP0TYsW2JKdc6YuQec2QYCgnYNNC90COuIzt1ksKwsTl/o4zTrW4pYrIwvX
	 UCIpa+uJg9S+vlov6AaeJDFQg2SBO66e5DqfLCZU/+imMYBF+JKEHEPsDKMOXQ0Wzi
	 eUQFStjYmwVjL/jKwsO7dRfvVMCBa1wcHIO1x9qxTn8kTY4EM+mYjo3b3szAzsNZHT
	 xk4rbER8Pi7Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA14E39302CE;
	Wed, 13 May 2026 18:03:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] libbpf: Use strscpy() in kernel code for
 skel_map_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177869539730.3760421.10737423823737743835.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 18:03:17 +0000
References: <20260513050806.do.620-kees@kernel.org>
In-Reply-To: <20260513050806.do.620-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: ast@kernel.org, jolsa@kernel.org, sun.jian.kdev@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, memxor@gmail.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 May 2026 22:08:07 -0700 you wrote:
> Linux has deprecated[1] strncpy(), and the use in skel_map_create()
> is best replaced with strscpy(). Since we still need to build this
> file in userspace, leave the strncpy() in place in that case. This
> is the last use of strncpy() in the kernel.
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v5] libbpf: Use strscpy() in kernel code for skel_map_create()
    https://git.kernel.org/bpf/bpf-next/c/74a9bb761a43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


