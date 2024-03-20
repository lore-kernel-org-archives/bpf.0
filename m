Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8A11712
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906469; cv=none; b=ILyz2YvYP7CfRjjylwViPtOPsg9Y6SgVwTh5ax0EsgcBor6ZMccto2Mk2ynkfr3MKc/CQ9HKyopuzhFhwcxQQpdkEsK712vGmE4k0es1Ld9SGnvpVXizdlX6Nb4mxBBLNpWAfQwi/q0gtJUImdaAPGdP32IQuuTF405HfnpE+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906469; c=relaxed/simple;
	bh=+DQQdj/kNsX9HObb+sHPm0lHmfIq8arihGWeKEmlAeU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jgXP4gC4TENJcgu+thq9fub6ECc2qDtaTkFWsSVWkgtdDsVEl9ufWFeIFpaYi/JnC9bLcHEV1kvQ5G4k/MPalfvyxCv2AQ+5B6OF7Iu52DUYERxtfm6NbE6X6n+arrD/3UeQB3qeACTfFjz4dYkDO6+H4BQ8znMZeTcKCzh4swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxMwANku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxMwANku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C37C433C7;
	Wed, 20 Mar 2024 03:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710906468;
	bh=+DQQdj/kNsX9HObb+sHPm0lHmfIq8arihGWeKEmlAeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GxMwANkuqerKzhuMnry93qGDLy9/J9PgAR1JoW5bQvlvNmXFGB8Me3LqjakEGHkSz
	 /6trYSN1D3sP2eBCflz4pDaxpw+hT9Us+YMpCOcv2fGtNzIOAybkFIMofX8gF3Qzbz
	 egS21zaEV7l982pdJBSHwk6E1oaHa19ZpmMIOw+ZQtdsM/EgHWezV+rvdH4G+5JWiw
	 Ov7Wt56IOdlr95LJdylXkPjnd4HjSbyMXsT/TD8IV1w8ZCDXE6nihtmgFROpmQeQ1w
	 F5Z7dp6wKC5ewsdOEf945u7aYZEMoGkxxPJBB9zqdvg3E5uFURfLi3xS6SriP2Kici
	 tWt0h7/qZOL7Q==
Date: Wed, 20 Mar 2024 12:47:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch
 kprobe entry IP
Message-Id: <20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>
In-Reply-To: <20240319212013.1046779-1-andrii@kernel.org>
References: <20240319212013.1046779-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 14:20:13 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault())
> is not free and it does pop up in performance profiles when
> kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=y config.
> 
> Let's avoid using it if we know that fentry_ip - 4 can't cross page
> boundary. We do that by masking lowest 12 bits and checking if they are
> >= 4, in which case we can do direct memory read.
> 
> Another benefit (and actually what caused a closer look at this part of
> code) is that now LBR record is (typically) not wasted on
> copy_from_kernel_nofault() call and code, which helps tools like
> retsnoop that grab LBR records from inside BPF code in kretprobes.

Hmm, we may better to have this function in kprobe side and
store a flag which such architecture dependent offset is added.
That is more natural.

Thanks!

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0a5c4efc73c3..f81adabda38c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
>  {
>  	u32 instr;
>  
> -	/* Being extra safe in here in case entry ip is on the page-edge. */
> -	if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
> -		return fentry_ip;
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> +			return fentry_ip;
> +	} else {
> +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> +	}
>  	if (is_endbr(instr))
>  		fentry_ip -= ENDBR_INSN_SIZE;
>  	return fentry_ip;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
