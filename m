Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AE241690;
	Fri, 22 May 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412239; cv=none; b=p/EBXeQy/Cu2FcEhlH1iC1LhQgLpi8Gw/ViydDRMfByg8wHpD4odHP2HOXRqADQL0Ou9KFMhw09QkX+Byo6RF3GrpdsQge94rW/x0806Qj7kvlkXrzX/2wqz3VO7NXbpQ4+Md1OPsM8HmK5myw3KPIwN4XRA3J5S+y1zOq1Ld+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412239; c=relaxed/simple;
	bh=BHDu1OgCDPQFaCFvicNPGBF46BcH1VZUjZXI8RvMnA8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nf+EPnhORk435KvfqxRoHk9/Me306W/ai+d2kaUs+JJtdAPK3+AENMrZ8wqPo1hQyUzyoN9OMY45LEJujVG+9srQhXcHCuOQLfyXLT23xxOjYHIYc5slXAxAw4iaQ8gSbNJfCL4uT9Z/NM5nHAyMU+VdsxFHfFJKhN9lAFUWDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnPy0L0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnPy0L0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4391F000E9;
	Fri, 22 May 2026 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779412237;
	bh=BHDu1OgCDPQFaCFvicNPGBF46BcH1VZUjZXI8RvMnA8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QnPy0L0ajPqMteQurJYBtRxWyQeo8mDLkFTfK68vmjzG27YIYdHakePSvAoKJBi0D
	 Xt7+eSv8XXQS12/M0pqMRxWk+m5v69SgROeg8o0wNTmmZpb1dtBTwWXIM5tGS7nKC3
	 C9sXefILtLjaanS4vCr32BX9UyaednTa/Wh9SxCmgF70qi110ydVyK9nd3QZaUkOXp
	 +7+4ihFda44GjyHwtO6vHIW7Ju6eMhW2CJ8f7GJhMAMgEDlv3MuGpxnwcahvo/Rx+I
	 fQlJMJlwTunzhCVuaJD1nDF/L567Lw27EVaBYXNluc6y/Q60n9580XF0dNj4Lyf3Nv
	 KcT2BUOVKf4bw==
Content-Type: multipart/mixed; boundary="===============8322153316570004852=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2738dc503b055e55c70d6e06a5529da9ec89763f4c8fe07430d2f4bf6d09a4c2@mail.kernel.org>
In-Reply-To: <20260522002901.3493661-1-michael.bommarito@gmail.com>
References: <20260522002901.3493661-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] libbpf: harden parse_vma_segs() path parsing
From: bot+bpf-ci@kernel.org
To: michael.bommarito@gmail.com,andrii@kernel.org,eddyz87@gmail.com
Cc: ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 01:10:37 +0000 (UTC)

--===============8322153316570004852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: harden parse_vma_segs() path parsing
>
> parse_vma_segs() in tools/lib/bpf/usdt.c parses /proc/<pid>/maps
> with two widthless scansets, "%s" into mode[16] and "%[^\n]"
> into line[PATH_MAX]. Both assume the kernel caps maps records to
> PATH_MAX; it does not.
>
> show_map_vma() emits the path via seq_path() against the seq buffer,
> which doubles on overflow (m->size <<= 1 in fs/seq_file.c), so a VMA
> whose backing path is a deeply nested directory tree produces a single
> maps record longer than PATH_MAX. scanf "%s" / "%[^\n]" without a
> width writes until the field terminator regardless of destination size,
> so a bpf_program__attach_usdt() consumer attaching against an
> attacker-controlled PID overflows its own stack inside parse_vma_segs().
>
> Bound both scansets to the declared buffer sizes ("%15s" for mode[16]
> and "%4095[^\n]" for line[PATH_MAX]) and drain any residue past
> line[4094] with "%*[^\n]" before the trailing "\n", matching the
> libbpf-local fscanf style. Without the drain the residue of an
> over-long record would stay in the stream and break the next "%zx-%zx"
> parse, so the loop would exit early and any maps records after the
> over-long entry would be silently skipped.
>
> Also stop using sscanf(..., "%s") to peel the /proc/<pid>/root prefix
> from lib_path. Build the exact prefix for the requested PID with
> snprintf(), check it directly, and copy the remainder with
> libbpf_strlcpy(). That removes a second unbounded stack write and
> preserves paths containing spaces.
>
> Fixes: 3e6fe5ce4d486 ("libbpf: Fix internal USDT address translation logic for shared libraries")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Should the Fixes: tag reference commit 74cc6311cec9 instead? The
vulnerable unbounded scanf patterns in parse_vma_segs() (originally
parse_lib_segs()) were present in the initial USDT implementation.

Commit 3e6fe5ce4d486 renamed the function and refactored address
translation logic without introducing the vulnerability. The original
implementation in 74cc6311cec9 ("libbpf: Add USDT notes parsing and
resolution logic") already contained the unbounded "%s" and "%[^\n]"
format specifiers.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26261732702
--===============8322153316570004852==--
