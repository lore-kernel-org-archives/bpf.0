Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82333A6EB;
	Sun,  9 Aug 2026 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296636; cv=none; b=GU/0oGh4f1v5SwRf6t9JQelnysR9/HJF/a31MqcmU0/s7aR7kvLtxz/XPProF1DLAp56ukGODlbrBsrYuMum38Ot7vqU/EahiZ106yJGbA1dcS+oEcVJsbQ778h5k0uKb0YPxWBNsj1MmdLMZNI/k9S/QlGFElOWidrFrrL2RSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296636; c=relaxed/simple;
	bh=NICr5QmX30ck+7BD0Cx0PuN++WcxYq+6Ab2hYwoRDCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VENLaCoplvRBq7Fw6NfA7y3MuE8+O1vtr0MuuNPHe3ILUfy6AW9Kew6w/dxO8iwLMltFSHyOkPLrvVBqO+5/800aHgLXin6JgE4uujWhLxXZxLMB79KLXyAtiSCetk44x7r+LZxNKxSmJyU0NV+vkx+oUc4peKwc07zXpYCYxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKkkDifI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKkkDifI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F31F000E9;
	Sun,  9 Aug 2026 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786296635;
	bh=e/dkSkuUfFPWpw3s3HMREZ3tzNX93NzauuIlgcI5h5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKkkDifIMHEwEs9wz/NtBUjj5m35ZUoLt4yUcCe0fOvE6jIrwg0UaBWBzXNSetLhC
	 oY4OERXmr4DC8fQ56l4378fnYNidjK/puJ5EhspwTmrAG15UV1PSHSX45JxKGc+FBu
	 W09YRszahTSy3vqOciwIErijTkjc91ATjk0TVdfqxAlPrrnIZmgN8diuKF1Oqh88uG
	 N5Nx41zmUtNspDz0gW12dfYVnL3Rg9uOuabluoNvsNeALkULdu9PPRA4x0TEGz3iUf
	 vZ3CJ/Dz7LI/n4usn3nUDBmpH44qnNh/s7T4K0YWUZthR3PRiLCsWfjYVfLklct4pY
	 aZfsb4MfqXKYQ==
Date: Sun, 9 Aug 2026 10:30:35 -0700
From: Kees Cook <kees@kernel.org>
To: Jennifer Miller <jmill@asu.edu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com,
	linux-hardening@vger.kernel.org, xmei5@asu.edu,
	samitolvanen@google.com, peterz@infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default
 when x86_64 CFI is enabled
Message-ID: <202608091030.C69278022@keescook>
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710191932.120911-2-jmill@asu.edu>

On Fri, Jul 10, 2026 at 12:19:32PM -0700, Jennifer Miller wrote:
> Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
> misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
> by enabling constant blinding for JITted BPF code from unprivileged
> users.
> 
> Signed-off-by: Jennifer Miller <jmill@asu.edu>
> ---
>  kernel/bpf/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 47fe047ad30b..ed22b90c6e4e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>  /* All BPF JIT sysctl knobs here. */
>  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
>  int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> -int bpf_jit_harden   __read_mostly;
> +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
> + * hashes and endbr64 instructions from being crafted.
> + */
> +int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
> +					IS_ENABLED(CONFIG_CFI);

Why not just do this for all CONFIG_CFI?

-Kees

>  long bpf_jit_limit   __read_mostly;
>  long bpf_jit_limit_max __read_mostly;
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook
