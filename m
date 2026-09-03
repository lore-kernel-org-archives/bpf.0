Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA83478875
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430459; cv=none; b=s65/pRvmLlBTApSsdZu8Y0Q/2w7e0SvvSHeXZayvIIqzG1fzi1NdElzPEdp+ogjB7qyl2RMBzUVMgFirviN6ae8adIW6Pt/kV+xd6+sAG+07qIDVhTN5KEXxxv5bgrXwNIaO/eXMCzGIdlSeglo7bMlThR5I5uczLtpWNrW02pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430459; c=relaxed/simple;
	bh=+pWpo1/nYy4nb51iyyw/7uMbeBrawmjw48Ffnfopxc8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mqs7mYIf/0OHlstV7KCMSxc/nMb8jfmkkOGWQce0eKdM3VTWMZNLzNLCGHOmhJK95RiS7u7jj+NrSl5bK7gsLfT71VT/VJLbCGK2cxKOwrokCa1ZUafd34WzSZ/Evtv5yNcISjK+9g/a798R73DKlX+MBno57+J1hvtapkbMzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Rn2Zts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Rn2Zts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07DA1F000E9;
	Thu,  3 Sep 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788430449;
	bh=yQPrq9jtdx+CTMtooERupFe5B97GRzTDjfQZ0Of9M8Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z3Rn2ZtsI9OeSXz8O64+1Q+Xk9wrZlhIw+vL8S77Dy5V+axvGAADSUbqCClC953y1
	 IwBXgRadB4qYUzcD7t+Ak1ONn0Ep6s77mz8fEAMGtmYAlD41iPOEv4pFYvCdnSRK73
	 lv8wFDjOFXnmduWzonQpvSba1CcXGaJqkj0pMERFtFnAkQjkKA+EqSSSz+pCvYIxWN
	 MnvJ+Ts8ES3IBcTEZA2voVNMhiHde5JjW2AW523AFnPdOCAQdTo/oYOG3q7+++QXkK
	 rSGUuSVw9p14KET5vQBII+HPsRYFPRVnTszSJTFOIj2pd/1+t4KabuWlYp5EldZZKt
	 fg8L6v7EqhRig==
Content-Type: multipart/mixed; boundary="===============8821386129639344299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a6bc48f4709cad0e5f9782ff22f927f4d24a1655b1ab6f5cbd8ee3bf1d8ed477@mail.kernel.org>
In-Reply-To: <20260903092039.477827-2-jolsa@kernel.org>
References: <20260903092039.477827-2-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, x86: Split x86_call_depth_emit_accounting in two functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,rppt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 10:14:08 +0000 (UTC)

--===============8821386129639344299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 08af86ef090a8..2ef4937411860 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -83,7 +83,7 @@ extern void callthunks_patch_builtin_calls(void);
>  extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
>  					  struct module *mod);
>  extern void *callthunks_translate_call_dest(void *dest);
> -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip);
> +extern int x86_call_depth_emit_accounting(u8 *insn_buff, void *func, void *ip);

This isn't a bug, but would it be worth adding a size parameter or a
short comment on this prototype so callers know how large insn_buff has
to be, given SKL_TMPL_SIZE is not visible outside callthunks.c?

[ ... ]

> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index e37728f703227..15b221d06901c 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c

[ ... ]

> @@ -298,10 +296,9 @@ static bool is_callthunk(void *addr)
>  	return !bcmp(pad, insn_buff, tmpl_size);
>  }
>
> -int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
> +int x86_call_depth_emit_accounting(u8 *insn_buff, void *func, void *ip)
>  {
>  	unsigned int tmpl_size = SKL_TMPL_SIZE;
> -	u8 insn_buff[MAX_PATCH_LEN];

This isn't a bug, but now that this function only builds the thunk
template into a caller buffer, would a name that drops 'emit' (e.g.
x86_call_depth_accounting_insn()) read more clearly next to the new
bpf_call_depth_emit_accounting()?

>
>  	if (!thunks_initialized)
>  		return 0;
> @@ -313,8 +310,6 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
>  	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
>  	text_poke_apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
>
> -	memcpy(*pprog, insn_buff, tmpl_size);
> -	*pprog += tmpl_size;
>  	return tmpl_size;
>  }
>  #endif

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33739511576
--===============8821386129639344299==--
