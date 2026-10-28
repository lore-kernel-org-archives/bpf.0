Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210141;
	b=y72YKHFDYxJFePUx1UdlsLFteYSEJu/EuSqQSbN9aZopmBDdTF2q4HTd3Wfpmpq7vi9P
	 83OOFgxC6UC3vrzURwC3N6hcIs7/c/6QEXKesAKxOPLfJ7Gx4pxyDE93HJvRRobmbAhGM
	 7PHsed2lJSIr1V7gUVaz/jVTL1nypmVus/Ao02zVzRidb77uck0la4IX49FBnFPC8eSDD
	 6LssQf4ASnrhxihOfidDLj37KlLbKPSna6exn2ARpacBcB3Efk4htyA2fFyNhpkVyFZf9
	 6Ks67TOkYjIdrI6/f/SEX4FJxv39W5sPesMKRwspY1tqG/cWrT3FZYKh+SHQK3kCjAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210141;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=myrOMX+piehb+aemSiz55jlPV1w5pr2M1c/YVwdnCUw=;
	b=2Bj+ysEj19Wk5xXPKpqdPKw/PIniC5WrSF0xo9INEJsRMfa/IQGHdNIBPv0HWqCSsWtS
	 vfN+quNpt/P8FYo/HZxpvICH4t0FSOehecugiCsSkcQHVLZI7qEviLFtLaF7ZncAm0PzE
	 8fFOM4syLxCY5nzfsLAnYl+JEet6xoi9lx0b0FJQ/xDBPrV8zlEB3vIi6Yj5XyTIlj8rb
	 qYQKiZsHTJhwleZ3A5P9wR8DZXw514QUzmQDBXH4Q128y3UBTAi4LeTNkb7qLhh7xP1cA
	 7L0Cz8C2IlegQwBlyi8tFaesindhfDrlz/jN9pilYN2hBOp4tKrn2pd/tOrcxQ+Yibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=LjLYbMRj;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE62606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=LjLYbMRj
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 56402401D6;
	Wed, 28 Oct 2026 17:55:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 8C52720025;
	Wed, 28 Oct 2026 17:55:37 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:55:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 jolsa@kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v2 1/2] x86/ftrace: Mark jmp mode by clearing bit 63
 of trampoline address
Message-ID: <20261028135536.200905d2@gandalf.local.home>
In-Reply-To: <20261028173805.1212039-1-daniel@iogearbox.net>
References: <20261028173805.1212039-1-daniel@iogearbox.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5h1mnytzyee4nut166beubeemr76c1s8
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8C52720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+wMBenu0HA+7iUyeaGPlo8uFC6rSCTR30=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=myrOMX+piehb+aemSiz55jlPV1w5pr2M1c/YVwdnCUw=; b=LjLYbMRjsCNwMXiBgaRE3IQ9IpWgBpNKwkC/KpNwRoCIiDN3z4fHTE2af4cCZHRgXbPg2NiywILyPthzytxdLk247yxexD1Aw93n48dVwfWPoCRmW8hNxeQGUbpePT4yCr5KJxbskVPpSDfT7uhjWzFqJHdmtL6z1iAlZEESX2o=
X-HE-Tag: 1793210137-589350
X-HE-Meta: U2FsdGVkX1/qOyuEatwyxNLQGShqTO6wyIkM0CrCn5ZuvIzeb+Mrmkip3ek/kwoAqWrOa6oAcIzb+hsge1nMRLkYAw/Q+aWZlv7nHPrlAeEDxI7mjW7BH5Bk+S6115kS8QUs4K4I64yDgHENdWTfwgn3WEsWpx2+1xmo6GPsZ9rLQxYizbtTeewk4b1ACiajz6jtXpBByF7einyFsSd30uFUuUaUmgqufv4hZSziL25eUxU12GJEbaAji18GRzqAdXc6a+z1A88HT+EEdZFtNLzea+pbJcB6/CNP3hzoZ+SNfu7QbDacgA8PZwhQ2rMKiuNEwjHiJZ+QUlMszSAAY4JaNTvMa/36gdJ63OpHTr7kHQNDf2TkfKgB89jwcoBI

On Wed, 28 Oct 2026 18:38:04 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 62c1c93aa1c6..4b20673a3395 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -286,9 +286,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
>  	RET
>  
>  1:
> -	testb	$1, %al
> -	jz	2f
> -	andq $0xfffffffffffffffe, %rax
> +	/* See ftrace_jmp_set(), jmp to the trampoline */
> +	btsq	$63, %rax
> +	jc	2f
>  	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
>  	restore_mcount_regs
>  	/* Restore flags */
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b041d9142d2b..1c2056a1a68b 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -618,19 +618,21 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> +#define FTRACE_JMP_BIT	BIT(BITS_PER_LONG - 1)
> +
>  static inline bool ftrace_is_jmp(unsigned long addr)
>  {
> -	return addr & 1;
> +	return !(addr & FTRACE_JMP_BIT);
>  }
>  
>  static inline unsigned long ftrace_jmp_set(unsigned long addr)
>  {
> -	return addr | 1UL;
> +	return addr & ~FTRACE_JMP_BIT;
>  }
>  
>  static inline unsigned long ftrace_jmp_get(unsigned long addr)
>  {
> -	return addr & ~1UL;
> +	return addr | FTRACE_JMP_BIT;
>  }
>  #else
>  static inline bool ftrace_is_jmp(unsigned long addr)
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
>  
>  config HAVE_SYSCALL_TRACEPOINTS
>  	bool

LGTM. The only thing I'm worried about is that architectures like s390 will
need their own functions for these, as the kernel code there is still in
the positive. At least my understanding is that for all supported
architectures, the top bit is either always set or always clear for kernel
code. So this will still work but the architecture may need to invert the
test.

If anything, I would remove that last addition to the Kconfig, as that is
an architecture specific implementation and shouldn't be expressed in a
generic kconfig option.

-- Steve
