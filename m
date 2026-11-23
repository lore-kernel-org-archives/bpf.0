Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457261;
	b=gDmq+Ph2P0noNJ9ckX+fGvJHp2dFVixnEWYupYiw2voU/4aFXDy8hnpqarlipXKyf9W1
	 H76tEZC39Wq/buBDBn3hC7LhzDSXSnqG0hEiE8N9VHP/KeUk2HtwG5BJnH5mJD6beep4B
	 XnTFAEYt0GWup+jfJGSlYzxp1iz9JJ4OUSytKkMVR5KkvNUT3w1WUzYs6/iuWzH9Wz3nq
	 FGKF9qAWKnUDVroRvew4VBWaJmSLUpFQ9zHpe8TlgTLl6B5mGxgfJvx5GIxYgNWcSSV3a
	 m6d7idLb+IB9sDkNacq3NgjAUw66IpZY6DWU4DLNZvxhk+0VexmEStYcneAYrqIPtKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457261;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=O1sGPyXUc9bPDWnQAdr+MIOIAp5+yAtJPc4tls2ompc=;
	b=dOYkNbHqierleMr6HNTgzPwWQT0N0hNH9U0Kh9aITk2OCRwhplpsoHaqRtTFHpnSM9Z/
	 rb6ASOtpT62pdzWQI7SNV2iEzHaaApz8FM24obQpGq3d9aTlQXfyYGWJ//GAjbK15kgIS
	 al/9w+ikmWuGbSJTsk4HPJR0bJ8RIEXOV3KbqBWGm+lWbNJHsTcDLIEhBDgWHdjEnFE6y
	 Xygzr8QiQAf2S6u8USOJZhXCk5kdb4XHWcsfi9NBa8SY+YX2m0NQJXWWWEyrkebqSnXNQ
	 9ArVPfxlWnCb7OI6z06WIopiHzZOMz2WJgbw4DWvj5Dz8Y7NJiqjz4vbrI9YIm76+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aI1cIg5x;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B36606A31F;
	Mon, 23 Nov 2026 18:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B36606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aI1cIg5x
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 3A57616095D;
	Mon, 23 Nov 2026 18:07:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id EFF0F17;
	Mon, 23 Nov 2026 18:07:29 +0000 (UTC)
Date: Mon, 23 Nov 2026 13:07:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao
 <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCHv2 2/2] x86/kprobes: Use ftrace_location_range in
 __recover_probed_insn
Message-ID: <20261123130728.6e1e9f89@gandalf.local.home>
In-Reply-To: <20261122200239.1481088-3-jolsa@kernel.org>
References: <20261122200239.1481088-1-jolsa@kernel.org>
	<20261122200239.1481088-3-jolsa@kernel.org>
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
X-Rspamd-Queue-Id: EFF0F17
X-Stat-Signature: bdygsegicskjsrpjed81ijwfaryinbt5
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3S8xkynlWy2q1CYyyaQCibAXZKXMbUHk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=O1sGPyXUc9bPDWnQAdr+MIOIAp5+yAtJPc4tls2ompc=; b=aI1cIg5xIlw902dfRoCNkqPGqMRPa2mglps1azEb7Vr4HzCZzqK0/liUmaFN6cvbRVtqG7rom1ET+e6tPPVoe2vbhf6TJjOJS7DFaZWy1pRqGKwQ9r/mrzwmaXuK/6nj7Wdj+laWFNy6HLQBCsMowZFvBtNDpjqfjO/T8lPL/Ro=
X-HE-Tag: 1795457249-925218
X-HE-Meta: U2FsdGVkX1/4Id+e+sAZuY/BDz6Eq3nMflt+ZgbBhYvYjKnUKdCYiUMq5fcu/TuqtqlbSyNZs/RSajICqJlOrVv6moeGFcA9nZRjOPbEThEDOG10Nk4oFyTSBEYf2c44XzfrzAVsdp+T8TOkxkhpjJOfGAEsiKQUAcWchpzvssAv9NL3v1Lynq3jxZXNiFRbjmtGFseKCBJfcz+bP4GPMQ8gsCZdD8QCp6ydg43vxcGj/8qxWnwztGwqUVaQW2Ni9TlEaCRjq3I8L+LvLlLnb8GAvP51fuPNSP1iBEaMtTTAnhKNBvcl8IaeVglo+6a/r0RH6yZ0W+pYNDW3IHrOksrkCikaw8haPjkhutCdIfZBe90C+DRRf0FOwO8NbbNm0VjURbGhee5oITirfqn6rQ==

On Sun, 22 Nov 2026 21:02:39 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> The __recover_probed_insn function is called for every instruction
> decoded on the way to the probed address and it uses ftrace_location
> to find out whether the instruction is the ftrace location.
> 
> When the address is not ftrace location, ftrace_location does also
> the symbol lookup to map the sym+0 address to its ftrace location.
> But __recover_probed_insn only checks if the returned location is
> the address itself, and that can't be the result of the mapping
> after the lookup of the address failed, so the symbol lookup is
> done for nothing for almost every decoded instruction.
> 
> Using ftrace_location_range for the address instead, which does
> just the lookup of the address.
> 
> Adding the missing ftrace_location_range stub for the config
> without dynamic ftrace.
> 
> Registering 20587 kprobes (as disabled) with the kprobe_many_example
> sample module [1] in qemu with 8 CPUs goes from 4.02s to 3.70s.
> 
> The sample module was posted as the last patch of the kprobes
> lookup cost series [1] only to demonstrate the testing, it is not
> merged and is not going to be.
> 
> [1] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/
> 

Hmm, we probably should create a bool ftrace_location_addr() helper
function that does this internally. But that could come later as a clean up.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c | 6 +++++-
>  include/linux/ftrace.h         | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 133ff20caccd..34d71907e6d1 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -207,7 +207,11 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>  	bool faddr;
>  
>  	kp = get_kprobe((void *)addr);
> -	faddr = ftrace_location(addr) == addr;
> +	/*
> +	 * Only the exact ftrace location matters, so skip the symbol
> +	 * lookup ftrace_location() does to map sym+0 to its location.
> +	 */
> +	faddr = ftrace_location_range(addr, addr) == addr;
>  	/*
>  	 * Use the current code if it is not modified by Kprobe
>  	 * and it cannot be modified by ftrace.
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1c2056a1a68b..255751899682 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1075,6 +1075,10 @@ static inline unsigned long ftrace_location(unsigned long ip)
>  {
>  	return 0;
>  }
> +static inline unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +{
> +	return 0;
> +}
>  
>  /*
>   * Again users of functions that have ftrace_ops may not

