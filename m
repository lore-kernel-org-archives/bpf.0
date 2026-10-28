Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212456;
	b=39k8KNZ81FIFujE6jN9W2KLuWNZv+K9bj3W+ShfDtJ8xJmn+6r0XOLUwh+4ilLdXRj3M
	 KyF5/B1ygGESTsdwYKNSGV+cxvwr86McDj9XagnFdRHuPiCjDNypmA6Lzk3B+SodMuonC
	 cKpioto6xefJNbzOpROXIqEBRTf5z6/YgLOO9T8qWejzoZDPwL3hVD53LRFZPLAnfR7jC
	 GTDtHiDHFIOVjggtislnmHsRNnSMnI69poTcZgLYSzDMaZ1xtEJa5eH0fGeTNsXDM+Txh
	 dgvUYo0lfvaOTBzrr/AqoMcuWReZTqrncH5hop7yKR6cXi2B9JNA6E+V+5QD+CMpFNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212456;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5tjaJD63ehrQckLPxpHxn/TdycVsGLXT5QibM4ML/c8=;
	b=lEX+lySy9jAcx5oGHGRw6dqLs3TCJ2HmF3lu3BZkvbxCMijLRerNP08JUvr/KW6Za5Qn
	 2TVEeDKEcwghMA9oWp6+r0KVB/FnU7aER4iA5KL26HkR8P71krx41u55Yw3dFMNJhuP9B
	 xbObNkHAfT+IVs1CIf2ib29Za9v1vtCQPtdvWtJG7+gl1TcgqXEv6v97z/ngOAENcmNOe
	 casZaLK8W+f9bnqzrUDVj0by1YwJGZwoQMqw+RtIyiUqdPbsDrw9JQQUU5Mnui/DiqPO0
	 PavzwiSwGJnCZkkHG03JmL6FUndZtmQRc6ZpJhFz9JfoKQW1XB1k2Fw+5GDKA3Zyx1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR4z9Jnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE150606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR4z9Jnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547861F01828;
	Wed, 28 Oct 2026 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212455;
	bh=5tjaJD63ehrQckLPxpHxn/TdycVsGLXT5QibM4ML/c8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DR4z9JncDLAyRPzhtoTfu9E22WGwNqJCa1roerINUGal9mO0+9a2Y5Fqiw1Koj/Pr
	 ecxsbdtBTrGkcGCmlxJXEmNyv68h5VQZ3VYMX8ao3Q9JcuVVlAm2JqncCsQOO2+Xai
	 nVMEFfoVB2kDUjRdBzzwnJhU3Tx/++QKL+OVu7+s1sTy/0RikBvNQc/KSb2Rqc3wFn
	 /Ae634R9VhY+FPXGEXeW+UA6eoeeNSqkqGZ6xvvIxXGZzIsJq2aYw1usLkpnltT3sv
	 uR+2DhUDp8bZPk3OtBmD2cEOS643NP05/y2PsReZpQ8pOpZJe+lysmf8TwMV0T86EP
	 0L17iyHEZNK1w==
Content-Type: multipart/mixed; boundary="===============0091060735852154991=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <46be9f5e956f05a9cdb4049d576ff254054f5bbcbccd2c48d2ca1711bba31c14@mail.kernel.org>
In-Reply-To: <20261028173805.1212039-1-daniel@iogearbox.net>
References: <20261028173805.1212039-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 1/2] x86/ftrace: Mark jmp mode by clearing bit 63 of trampoline address
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,bpf@vger.kernel.org
Cc: rostedt@goodmis.org,ast@kernel.org,andrii@kernel.org,jolsa@kernel.org,dongml2@chinatelecom.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 18:34:15 +0000 (UTC)

--===============0091060735852154991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> x86/ftrace: Mark jmp mode by clearing bit 63 of trampoline address

TL;DR: Nit only: the Kconfig help text added for HAVE_DYNAMIC_FTRACE_WITH_JMP
describes an x86-specific address bit in a generic option; Steven Rostedt
asked for its removal on v2, but it is still there.

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d8faeb659cfc..69892375648c 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -87,7 +87,8 @@ config HAVE_DYNAMIC_FTRACE_WITH_JMP
>  	bool
>  	help
>  	  If the architecture supports to replace the __fentry__ with a
> -	  "jmp" instruction.
> +	  "jmp" instruction. The top bit of its kernel text addresses must
> +	  be set, as clearing it marks a direct trampoline to jmp to.

Should this added sentence be dropped from the help text?

HAVE_DYNAMIC_FTRACE_WITH_JMP is a generic Kconfig option, and the sentence
describes an architecture specific implementation detail, namely which
address bit marks jmp mode.

Steven Rostedt raised this on v2 and suggested removing the addition:

  https://lore.kernel.org/all/20261028135536.200905d2@gandalf.local.home/

The hunk is still present in this commit, and I did not find a reply on the
list addressing it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40740152888
--===============0091060735852154991==--
