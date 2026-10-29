Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293063;
	b=YFIUw7urNReQH0y+Fy82iBLq3GxubS9Iem6920as4VeoeoMQdIViUQQJ3ZlLY5r0qKGN
	 j9LwVL3WnDcL9ijs2JT/VD9N60iX7xFmIbTX8vXEbzlYgK45qvEFHxKQy6Qogw1giebRU
	 YEajcpB3JzfSxE3Rec42ceGfCMxvjkZhBqbT+cApmT+r0mXyGk68/8qq85eayU37xuUMq
	 ZjqPCFrXg3ZkCxDbMLbXG0W1/HNLRGP1t5MdXA1Q4z+DWIktgc5rC1NvpWsglcfQiXf+e
	 C4UHTg6L1J7rrVQDNkmwnllFXZfPdmA0B5/ODRDtMXm3szybzqdAEeDmuVFFwYl//OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293063;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=o9qVXnmYPWwEWL6vYT0sE4rqArVgEZmH/7qwJmZBvWo=;
	b=EeoBPIFjIDfLi+PLijMP3UZJCJ6SdwTxibp6teiII/cuTazq/fyhM8iafyLh8Bwtm0Ra
	 rVzb8i9ILfyR4AXkS4SgwYszECDu2KR1zZd5kf9tM8U95v+PhMVks70D6YGHF7rGajdZ/
	 mu5nlqU7e+EByMFtcUJIWk1r96v1LmlM3hyAauvhpWpzzgQQ1yfF6t6d/KObsWZFeY1LM
	 kiwkwyKEciEKdNLln9dg/7yu8uNBcQ07C/OoQLwPoI5xynYMeJb6qRBm50qgbI8XOBuyS
	 Iq3Ihcj+Ff+jg0Fgzz6PJZSo+gubxwDbozeuw1MZMYh8FXtr/ktqfq5Zn5mWGHp9JUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=O2XMX68m;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3660A261D;
	Thu, 29 Oct 2026 16:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED3660A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=O2XMX68m
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id F0AF6C0482;
	Thu, 29 Oct 2026 16:57:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id A233B2000E;
	Thu, 29 Oct 2026 16:57:34 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:57:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook
 <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Ben
 Cressey <ben@cressey.dev>, Florent Revest <florent.revest@linux.dev>, Bill
 Wendling <morbo@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/7] scripts/sorttable: Make the arm64 before_func
 offset configurable
Message-ID: <20261029125733.75e80eec@gandalf.local.home>
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-1-1b011ad5ddec@linux.dev>
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
	<20261029-b4-arm64-callops-kcfi-v3-1-1b011ad5ddec@linux.dev>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A233B2000E
X-Stat-Signature: 5754sd9cpbybo3dm5dhdrqmqhjwxwxuo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184EGAq7MiFwVvUPkOypaUue5Jo3FQ2e0k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=o9qVXnmYPWwEWL6vYT0sE4rqArVgEZmH/7qwJmZBvWo=; b=O2XMX68m845O3WDKi9BwaEt1caAlqa+gEtKsxmrIIXNytcUCtD3BLyldTS0/IqEKS+sM7VNwEUlYgK6umqv9OZFhwN3O6EcrWATSvs8oQY4SOY6qfWglzjOxnxrIIqI8aklfLUt5fgWJsPkh/9yXX3eCqzf2tdv2eG8c3TO57KM=
X-HE-Tag: 1793293054-777104
X-HE-Meta: U2FsdGVkX189UC0rZjNrMJ6F5e65lS1+Gv5SMF2ZBhu39yNWsJkFs5+b6b9Q7YHTZ0snpCrHrxfBnDULhMEot5zJLRVz16QoQvulVN2CjfPk/B4EESInm3Qu2xcMbOjvRUMSZRmcu7Dj0JBbZ2rVgfy2wQ2z3CVuhez61PkigHP9sX7MmtxCCC3hgT+XwqT65rAlL0cskuWuJAgOialQh17Xaia6U9QUQBR/v1+1u+dr/FCg5+MG7XBrcDyJ/uDV+BxJRnh7vFNPdsY5om5V62LCUzZqD7vQuuF2wpxe+IuJ0UzeFfIc/MT8nHjhRVBEEtcK9bRoft+1iCaWP9ubvWrJAZ3Q6yh4zFo5GQOjHX5aayr72SZvIX5uZJPXZ9sQu7Cr0vzyiAGwZ1F60kRIfg==

On Thu, 29 Oct 2026 16:53:58 +0000
"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev> wrote:

> sorttable hardcodes before_func to 8 bytes on arm64 (two prefix NOPs).
> Make it configurable from CONFIG_ARM64_FUNCTION_PREFIX_NOPS instead.
> kCFI kernels with CALL_OPS need three NOPs. The symbol does not exist
> yet, so no functional change.
> 
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> ---
>  scripts/Makefile    | 4 ++++
>  scripts/sorttable.c | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile b/scripts/Makefile
> index d7fbb7ca098b..7ef1c84cf79d 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -54,6 +54,10 @@ endif
>  
>  ifdef CONFIG_BUILDTIME_MCOUNT_SORT
>  HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
> +# 0 or unset (no prefix NOPs) leaves sorttable's built-in default in place.
> +ifneq ($(filter-out 0,$(CONFIG_ARM64_FUNCTION_PREFIX_NOPS)),)
> +HOSTCFLAGS_sorttable.o += -DFUNCTION_PREFIX_BYTES=$(shell expr 4 \* $(CONFIG_ARM64_FUNCTION_PREFIX_NOPS))
> +endif
>  endif
>  
>  hostprogs += gen_init_cpio
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 88e49a5c4251..2e951f2f60e8 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -281,6 +281,11 @@ static int add_field(uint64_t addr, uint64_t size)
>  /* Used for when mcount/fentry is before the function entry */
>  static int before_func;
>  
> +/* How far before the function entry a patchable entry may be recorded */
> +#ifndef FUNCTION_PREFIX_BYTES
> +#define FUNCTION_PREFIX_BYTES	8
> +#endif
> +
>  /* Only return match if the address lies inside the function size */
>  static int cmp_func_addr(const void *K, const void *A)
>  {
> @@ -912,7 +917,7 @@ static int do_file(char const *const fname, void *addr)
>  		/* fallthrough */
>  	case EM_RISCV:
>  		/* arm64 and RISC-V place patchable entries before the function. */
> -		before_func = 8;
> +		before_func = FUNCTION_PREFIX_BYTES;
>  #else
>  	case EM_AARCH64:
>  	case EM_RISCV:
> 

