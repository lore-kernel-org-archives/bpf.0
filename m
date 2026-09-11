Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70213D3339;
	Fri, 11 Sep 2026 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165819; cv=none; b=Bp/goz8PRRBI1tDoUK/AVyhUJNF0NE8+PXV21xy0zwo2s268D7b2X4BWJcubB8qBH0oRLLNbFNAkbijo0uGXUISCzoj0lT5D7cQqHs7gVIozPJylMERm6SY9Hj8Pl6F8YMkr/TlM38fW2zQ7BreDeQWJntnN+O6KCIlbIofra6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165819; c=relaxed/simple;
	bh=e8yVe9qIqjoioS5C7h20iphB56OPQ6veH4x4Pj5/lAQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f+aI6O2MbBWynSSZw9KFzakEIa5R2X5cZWbLX7ZXlUyjRB65xQ7qmsac4QYlsXPkJ9FnyA+CpZWAE15ruZPfUi+Fcebo9URI5iwy4xGp5UiTwRCBJG4Y/u0yuCfS32/aXg3rG0hEn0Vo2MIW4n/vYAGd6jHcKFaasZMbd8tv3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sva3XPKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sva3XPKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA351F000FF;
	Fri, 11 Sep 2026 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165817;
	bh=jSlyNHdS9fii1fOyMnpNZJZSuNeAq37ngDR+QTaHy2Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sva3XPKRX9HlRA/K2voQSsV3oTveqMaHFcapkkCHCD9IJqVZNgpjaUkBoOAWk/Lud
	 p6QWTv7ZttCaY62xBfTdfAEnJzvjknSdsSOfIYbp3pNl0j+7+/QVKlfADxRLlAfZp/
	 AQvsOj6nXqmyX4+XNTL8F+ifeTXELjNlx1sy9M0XURuROHAa6kcOWIB16RgnU0a725
	 FrCpanuXt2Q3PozVuKLJP33pBZiKNDigUnEQRwfQc2Nwdmq+08sHuCn4EkzBRpojha
	 vGs9z834IDPHTL9uQ1HVGFv9F7pnUa2ZDOUEjA8sVuq4yU8w8r1R+htM8Pqu97hI4a
	 51UtZr6FvslMQ==
Content-Type: multipart/mixed; boundary="===============8230321728291267727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c440fa97680eae9966579d51586c2e6b9936bfc3157225269166e1c133515f8c@mail.kernel.org>
In-Reply-To: <20260911213340.3767930-3-main.kalliope@gmail.com>
References: <20260911213340.3767930-3-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] MIPS: uasm: Add signed div/mod and sign-extension emitters
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,tsbogend@alpha.franken.de,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-mips@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,philmd@oss.qualcomm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 22:30:16 +0000 (UTC)

--===============8230321728291267727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
> index b43bfd445252..adea35df0f8d 100644
> --- a/arch/mips/include/asm/uasm.h
> +++ b/arch/mips/include/asm/uasm.h
> @@ -85,15 +85,20 @@ Ip_u1u2(_ctc1);
>  Ip_u2u1(_ctcmsa);
>  Ip_u2u1s3(_daddiu);
>  Ip_u3u1u2(_daddu);
> +Ip_u1u2(_ddiv);
> +Ip_u3u1u2(_ddiv_r6);
>  Ip_u1u2(_ddivu);
>  Ip_u3u1u2(_ddivu_r6);

[ ... ]

> @@ -156,6 +162,8 @@ Ip_u2s3u1(_sb);
>  Ip_u2s3u1(_sc);
>  Ip_u2s3u1(_scd);
>  Ip_u2s3u1(_sd);
> +Ip_u2u1(_seb);
> +Ip_u2u1(_seh);
>  Ip_u3u1u2(_seleqz);
>  Ip_u3u1u2(_selnez);
>  Ip_u2s3u1(_sh);

[ ... ]

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 125140979d62..139afb0e14cd 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -49,19 +49,21 @@ enum opcode {

[ ... ]

>  	insn_sb, insn_sc, insn_scd, insn_seb, insn_seh,
>  	insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,

[ ... ]

> @@ -353,6 +361,8 @@ I_u2s3u1(_sb)
>  I_u2s3u1(_sc)
>  I_u2s3u1(_scd)
>  I_u2s3u1(_sd)
> +I_u2u1(_seb)
> +I_u2u1(_seh)
>  I_u3u1u2(_seleqz)
>  I_u3u1u2(_selnez)
>  I_u2s3u1(_sh)

This isn't a bug, but would it read better to add the SEB and SEH emitters
together with their first caller in the BPF_MOVSX series?

A tree-wide search at series end shows uasm_i_seb() and uasm_i_seh() have
no callers yet. The six division emitters (div, div_r6, mod, ddiv, ddiv_r6,
dmod) added alongside them do get used by the final patch in this series.
The commit message notes SEB/SEH are for a different follow-on series,
and CONFIG_CPU_MICROMIPS kernels would hit build_insn()'s panic for them
since arch/mips/mm/uasm-micromips.c isn't updated with their encodings.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34651585043
--===============8230321728291267727==--
