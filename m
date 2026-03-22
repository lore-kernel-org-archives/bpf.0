Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB0C8CE;
	Sun, 22 Mar 2026 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145663; cv=none; b=DZEOcBx91B5PIEzQuk5lpP4st8idGlCN0IXY6mtdV36d0Q1dn+SYNhGNrxBW6VGpKXaFAd/GBf4v28E0u+Ywecbn+MpL5UE0fNWMaWdX9gqrvkLoSZk6zPtCJdaAsUJoZpmowiAcZD5+Q8ZRNsFv/rkdwCJxS3Vt1Cd8mXHzAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145663; c=relaxed/simple;
	bh=ibkg0hUDaHSquvJiw9fLUlUJMQPpW5WvFb8EW0OtB8k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JLwffPJh6TJN2dzTisHe5XxyP/35QlE1ASBpzpsDR0Q8TsOGili1IRmnVTnuZN5SfTNivUavbwLIQLZJGQ8/7q2ce9BaI6KX8ot9mcK4S/MMcvrJas3CmQIiNMP6wbbTmAMi6ud5sFdapQ+hTQOMdNQRoTlXYmsYjppoiIu77Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6GUD+lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6GUD+lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95245C19421;
	Sun, 22 Mar 2026 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145663;
	bh=ibkg0hUDaHSquvJiw9fLUlUJMQPpW5WvFb8EW0OtB8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=T6GUD+ltgyRc5sZDn5A2J+iT7/tlrFelT47++ebMHB4mUSM8ZMI4R496cS1gVux5u
	 7nH06kAReNECcCV0FVZeqY4a11yhroZyhMmofgwqWYdSQ9cGNHcHDIG8JaXJ/A28hD
	 49ro6hm7eLZ8+PfiPM6HHhulEdotTzuOBjnkUDWpc1LPUgHuQeATyarER1lfUb65Oy
	 iA2LAhMDGHyAWMO+Vx8HAwIO+0khNyL98EoBD775zDzlqZMZiWf483UN0usEunoInK
	 WgZDG+9DsPOCaStCPo8cKxku/XhgqH4XFrAKaJ3GQx3LhNiIp7v0tA1PXkFvg7wMjI
	 KiMvUdl0eLKUA==
Content-Type: multipart/mixed; boundary="===============1586895263872930562=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63bd4ac4ee54ffef11b068d524e9b59c768ed2b4f7de313b509d8568c48da66e@mail.kernel.org>
In-Reply-To: <20260322014402.8815-9-piliu@redhat.com>
References: <20260322014402.8815-9-piliu@redhat.com>
Subject: Re: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol in ELF
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:22 +0000 (UTC)

--===============1586895263872930562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c

[ ... ]

> @@ -1221,6 +1266,22 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
> 	return ret;
>  }
>
> +/*
> + * kexec_purgatory_find_symbol - find a symbol in the purgatory
> + * @pi:		Purgatory to search in.
> + * @name:	Name of the symbol.
> + *
> + * Return: pointer to symbol in read-only symtab on success, NULL on error.
> + */
> +static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
> +						  const char *name)
> +{
> +	if (!pi->ehdr)
> +		return NULL;
> +
> +	return elf_find_symbol(pi->ehdr, name);
> +}

This adds a new wrapper kexec_purgatory_find_symbol() here, but the
original full implementation of kexec_purgatory_find_symbol() earlier
in the file was not removed:

kernel/kexec_file.c:kexec_purgatory_find_symbol() {
    ...
    ehdr = pi->ehdr;
    sechdrs = (void *)ehdr + ehdr->e_shoff;

    for (i = 0; i < ehdr->e_shnum; i++) {
        ...
    }

    return NULL;
}

Both definitions are static and live inside the same
#ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY block, so this will fail
to compile on any architecture that selects that config (x86, s390,
powerpc, riscv).

It looks like the old function body should have been replaced with
the new elf_find_symbol() wrapper, as was done in v5 of this series.
Was the deletion of the old body lost during a rebase?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============1586895263872930562==--
