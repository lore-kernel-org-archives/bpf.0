Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58234A76F;
	Mon, 24 Aug 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590946; cv=none; b=QZgATaQtp27i7YyhaX5c6JZS3crStl/MlDlkTsMlmII7aslCWYXpg6a6k27UdiOzDvB8VuzAWym1X7f8sdp/u38BZg51dsFDROPwxDjB1CnWr2PwdIeyJhV0FRHWj1qbDKspqsGSnniGLLuFu1mUTqA8GPDsO1jnnBJ9Qx68H6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590946; c=relaxed/simple;
	bh=0tuxVMZTH96XP6FIpItXmNlPICI/Q5bWAFAVL7O6iwQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YnW1IDfOGVQ33oEZ8uL4IYFEdKiCB6OihVo1ZUR/Fo8G+domllGWhgA1Uqbx0/3ZkTNzY5bhTcW9LiIMHn7RH7BeH76bi/AO1dz2r2NEsVbfZPAL3cQt1SNPXMXTyWBF0Ilvp5vVuo3tDauuTSeBrIZTtlhwAKPWm0Fhtmd8X/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKHNCGhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKHNCGhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8951F000E9;
	Mon, 24 Aug 2026 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590944;
	bh=0tuxVMZTH96XP6FIpItXmNlPICI/Q5bWAFAVL7O6iwQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QKHNCGhk2nwOGhuntoAkgT+Z1TfNxCaqfv0DJqeMmQybpXDer+dv1BlG386XWX99T
	 BkylOf9y6Z4Tzx1bskYSDIGeGcp1wAhF48HMa652N/8T9y2BfJ2hsNyjnecRTu3yy+
	 y5UhATyH3lgjBsCkM8RbyUIfXNAedhYKJvMamf9Y7mbyEwSqILoXXD3Wig32ki8KcE
	 ei7uKjZ3BK+q+1oG67GodMDt91daxIHAbXsSRAsieCoXjY3HStm75iDEQfrO5T8PkR
	 4Z74XNMZd38WoQtD1nvg85M4LmGYBrT30Tl9x9f55Om9RFL2nWlocAwgDDoYKWBh+0
	 tgLpfCa3IGNpA==
Content-Type: multipart/mixed; boundary="===============0322628108546578997=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4310125e5984331a686a7319ec57a92796571f4b7b1780345652726f717e41c8@mail.kernel.org>
In-Reply-To: <20260824160523.3907021-4-usama.anjum@arm.com>
References: <20260824160523.3907021-4-usama.anjum@arm.com>
Subject: Re: [PATCH 3/7] maccess: Skip setup for zero-sized kernel nofault copies
From: bot+bpf-ci@kernel.org
To: usama.anjum@arm.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,liam@infradead.org,vbabka@kernel.org,rppt@kernel.org,surenb@google.com,mhocko@suse.com,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org
Cc: usama.anjum@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 17:02:24 +0000 (UTC)

--===============0322628108546578997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A zero-sized kernel nofault copy does not enter an access loop, but it
> still disables and re-enables page faults.
>
> Zero sizes are valid. BPF probe-read helpers accept them, and KGDB memory
> packets may carry a zero length.
>
> Return before changing page-fault state when there is nothing to copy.
> For reads, keep architecture-specific address validation before the fast
> path so its behavior is unchanged.

This isn't a bug, but would it help to say in the changelog that a later
patch in the series wraps these loops in a bare nofault (TCO) region and
relies on the operation never being empty, rather than framing this purely
as skipping the page-fault state change?

The current description focuses on the mechanical effect (skip
pagefault_disable/enable when there is nothing to copy), but on its own the
change appears to be a no-op: pagefault_disable and pagefault_enable only
increment and decrement current->pagefault_disabled, so a zero-size copy
already returned 0 without touching memory.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32751368606
--===============0322628108546578997==--
