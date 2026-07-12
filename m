Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9A1B4F1F;
	Sun, 12 Jul 2026 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783837377; cv=none; b=G3GnQ7ozL+uKs4l/AWWd8047GV0E3r41duACSBXALygkA+5whHPhQRcO/eGstvL8YhTgGAlnF9PUJP8Ujd9+jyZIP7ntFVnMCQWj3JF7oUjo/wPz7nF6oD/mZKgdb3PF/+xGxgp2R6/6o6G8oCWwFM65dGv9ZHfxZOI8ZP9wfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783837377; c=relaxed/simple;
	bh=nVZCUYMeE1CKceU4sedwWi5nLMXgUoLe3MbEJgKYARY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jb9JgfUbFq6CqPWbFxZ0xq3abNzurfT1ciZLDetegFP3bohjWgXtJsG8oPqzHwWg3mXHVBz7qeuVl73zMjAJt55v3YhJT0SH66BEa2EXymFR2grTSQD1GdQTtxJJtokjPH6Cfy6uhnWO1B/b0Ig/9Kq7D5pFbjmOOTeUj5jDxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUNbjXDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUNbjXDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA1A1F000E9;
	Sun, 12 Jul 2026 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783837375;
	bh=Du+RKHBW4k/2tB0a8zd7brFE5K6n8pVgglgIqbDbnJo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dUNbjXDRRjonZmBlbUYCH34+uKYgdv/EGkQrUwfEJkj1cYiXAHGza2+licM8OpF0z
	 c4C2B6kKJ5CNf0r+0CaeBLy7LHs022JSK9uV1jeI2vBjom2kxf+FZlGm/AM4o/bjOP
	 n/hpcA/3Dhsuudh2vVT9aj1zKnfuDaS0YGoybYEYSgyK0UdJWvgE4OEHH0kemzDRt9
	 VJAQZ0kC8IvEhi6qiRn7sA3Py7A27st0c+/sgeuy63qibimbqgsG7VtILPoTsIYiqe
	 uU5QgSY3kCgQ3+QfCFzLvN50C8pdqWyIyvYVm3B8gv0g993ZPESvI8mZWtgOMOUU9P
	 1/od5QNIiPmDQ==
Content-Type: multipart/mixed; boundary="===============2396027106802413776=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d2f91cf7808493a8019b3beee814817421876d6a8602eba0a0f990823b16544@mail.kernel.org>
In-Reply-To: <20260710191932.120911-2-jmill@asu.edu>
References: <20260710191932.120911-2-jmill@asu.edu>
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default when x86_64 CFI is enabled
From: bot+bpf-ci@kernel.org
To: jmill@asu.edu,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kees@kernel.org,linux-hardening@vger.kernel.org
Cc: jmill@asu.edu,xmei5@asu.edu,samitolvanen@google.com,peterz@infradead.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Jul 2026 06:22:55 +0000 (UTC)

--===============2396027106802413776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Enable JIT hardening by default when x86_64 CFI is enabled
>
>     Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
>     misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
>     by enabling constant blinding for JITted BPF code from unprivileged
>     users.
>
>     Signed-off-by: Jennifer Miller <jmill@asu.edu>

This closes a hardening gap that only exists once x86_64 can enable CFI,
which came in with the x86_64 CFI support that added
'select ARCH_SUPPORTS_CFI_CLANG if X86_64'.  Should this carry a Fixes:
tag pointing at that commit, for example:

  Fixes: 3c516f89e17e ("x86: Add support for CONFIG_CFI_CLANG")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29118478293
--===============2396027106802413776==--
