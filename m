Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831E3FD132;
	Wed, 29 Apr 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468412; cv=none; b=NH2blVLv8zJkjGIYccef+ojEbj1fqVyoa6IK1QxDrxt/Oqvl0xgBBRK6my218GSSLOLgthIT0uCfYt8HS4sZZ3LiavA021QSVeoLMEd950sGvtZGqkVNvh9J+6MDe2zmgA+qZNkipR9WybVFj+SHvyFyhyTYdB3OVXIEg+ix4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468412; c=relaxed/simple;
	bh=1QiXFlK+cpUi4hqcr+prvsYsDeRL2Jw9GFYpMpl0ggs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BaponQzdgKJSVXdYicQW0M3F2wkSGKkweoqYjnRCkoR/mpsGLA2HkPRyOAXmQ6GzB8LH+OnPImBRtMm4A5i5fKe1mgm3K9QoDPshVKb615Ga+LKiFxkBc0eW9tTqI0PnDQSuV5r1ywd1ikG5giACjSe7oXsXXSvD5E/w4PXR+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHAHa6Nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHAHa6Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF25C2BCC4;
	Wed, 29 Apr 2026 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468411;
	bh=1QiXFlK+cpUi4hqcr+prvsYsDeRL2Jw9GFYpMpl0ggs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iHAHa6NjReXFG7NYULW0GLGfg/1Z1d/JajpuAtIsfL3XUVSDU2dGiQCCIparxFIMG
	 VWpiMpGFfiKaIPc8KhriGvfUdvZSi3g52M+3gELC5YbnE71FQxBEd3ABOTZt9JbR2A
	 z4EILQhNIzInTG1oewkDNYD93I+sWre7PjYXpOX5CkegHsqAMqQ1KpqfLZi7iWXkSq
	 XuN2T7WO63tWsdXfdv35XddrKnfs7uqgTemu1KhUYl2NJuVMRx5319hvYE6QLNUA+k
	 JYsjyDJ0+MicjPzMxExnKYKfdCfAMo6/XDS8qX/H9I8cSCAJ3BD/YTt1es0jElqWVJ
	 9NCdvPPUH9/Sw==
Content-Type: multipart/mixed; boundary="===============5654916101703750974=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c02284fa950e2f658cc297e94abac1154c7c22b242cd9cb8fd1096fedf27624c@mail.kernel.org>
In-Reply-To: <20260429123513.3477780-3-visitorckw@gmail.com>
References: <20260429123513.3477780-3-visitorckw@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luke.r.nels@gmail.com,xi.wang@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,alex@ghiti.fr,jserv@ccns.ncku.edu.tw,eleanor15x@gmail.com,marscheng@google.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 13:13:31 +0000 (UTC)

--===============5654916101703750974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT

The subject indicates this is a fix, but there's no Fixes: tag in the
commit message. Should this include:

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")

The RV32 BPF JIT never implemented support for BPF_MOVSX instructions,
which were added to the BPF instruction set in commit 8100928c8814.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25109627626
--===============5654916101703750974==--
