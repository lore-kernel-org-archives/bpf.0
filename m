Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F137F8BC;
	Wed,  1 Apr 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031790; cv=none; b=dsrFbXYxGD0USZTPGCORVUT2Ejafx70PHGcYGSbMyYLGgfsva9Xs3jak9xaqIqpvEhpk6J7GB+/YqyTglHw7iYyM8bTvyS5o0DjQuwO7uZ171+C+J+I6dGlC2iPY+d1xmMMCgtCaUTETVWLiYzjE1l7N7cQ0vxQwdYbnz6dNz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031790; c=relaxed/simple;
	bh=1MXMDfNdk7Hz26TTWUJ/zsdT44M/kmNRS/DRr3GCGWA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c51nUM8LKO/BlLygQvfXSlXz/rgsWYGA0RvYZ5mEyA6AC3SSpFrVSQbw5kX1hhZtxtxljx/kChtFzWxa/gjMuI/CImZ1Nhw/Rf/iYqJTTOZkkghUIZIGZOo9r4mCWvp1Yo8C9BHCr8E9A7yfItP84tQgNAo9YgrISwcTqx6kk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8gd6MVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8gd6MVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B8C2BC9E;
	Wed,  1 Apr 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775031789;
	bh=1MXMDfNdk7Hz26TTWUJ/zsdT44M/kmNRS/DRr3GCGWA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=a8gd6MVXqP16Oa52tAhiUyFU6gYJUZfjVnoowJY3FD9oDNKK5pWiZ/drhbw5GT3uS
	 4G3RBjwyfab5zQHm+P3rKlMgBSuI8YKBftuqcE3MtAb+P1/PNgI7m5aUrEnkdCVnuW
	 QeMszPgLYuYOkC1/F1+cIR9N4mXagi6EWBM20gBBm5/tSi74tmiQDpOGbsXw185O+Y
	 RPPQ/mulOESjxKXZCSqWdRyAg8yXphpIoTPbNT8RCK4+6Yt59lKOPpvmUm4r9OlxiG
	 gMdnJfZKBG3RH0eyPzCgXoWlFDH+7euNUWIdqKrHTgJocYUqJ3dUZ48iBcG1Cqirns
	 YT2t5BMV9dXAw==
Content-Type: multipart/mixed; boundary="===============3404421223121513812=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6089c3c90bd2f2cf2848a39fc0d30219d0f3f95f9c74257a19d01de053eb1c44@mail.kernel.org>
In-Reply-To: <20260401071206.5506-2-yangtiezhu@loongson.cn>
References: <20260401071206.5506-2-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 1/5] LoongArch: Define format for AM{SWAP/ADD}.{B/H}, DBAR and BSTRINS.D
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 08:23:09 +0000 (UTC)

--===============3404421223121513812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
> index 657bbae6c1c7..93466fc7d33d 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -177,6 +177,10 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>  		c->options |= LOONGARCH_CPU_LAM;
>  		elf_hwcap |= HWCAP_LOONGARCH_LAM;
>  	}
> +	if (config & CPUCFG2_LAM_BH) {
> +		c->options |= LOONGARCH_CPU_LAM_BH;
> +		elf_hwcap |= HWCAP_LOONGARCH_LAM_BH;
> +	}

Should there be a corresponding entry in the "Features" line of
/proc/cpuinfo for the new lam_bh capability?

Every other feature that sets elf_hwcap in cpu_probe_common() also
has a matching seq_puts() in show_cpuinfo() in proc.c:

arch/loongarch/kernel/proc.c:show_cpuinfo() {
    ...
    if (cpu_has_lam)
            seq_puts(m, " lam");
    if (cpu_has_scq)
            seq_puts(m, " scq");
    ...
}

The new cpu_has_lam_bh is missing from this list.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23837099549
--===============3404421223121513812==--
