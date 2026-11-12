Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472791;
	b=iPl37P97i2Kzb1bIB5BeZ1cbcWkm5ifBdRIMzMmZpaqjNVrjmvHGxyZxGcyvMElsb7o3
	 0CYGvyRaqTbvKXYMwvaoHMXBHmzsZ8gxIvzWpSvrPeJFUT/pcE3gEIaOHSIZDmR5B3eNP
	 L3nWo4HZVZtIqZp2t0MYpbhDosspoG9Xn5GMawgTrdID08SG7krIsHzrGsY6BMtkA041O
	 w1OjUtM7b4Gl+ol/y7cNJLzlPjrwEhwvmM5HUGGquFgPn7gs2TLMIsSrucxkElmsiKBj8
	 K7eulqRY3zmxG20l5aHpKVhNlqGN+/H6YeL++6Ii5gj3gv8Tj/w20W00bncgKQY/ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472791;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HoCxZnqDwVt70RG0ruGtLMnZF1f0PVlcRbSPjTQhqSY=;
	b=F6v78JlzFpMimaOokKRJ9zah3Tuak2G7vqK399Y1rfcAzXRoMZ03IiFnM09/o4412xbK
	 Ud1rNECsLsnM64Cy3J+a+c0BUp5qeAl35Mbdd/RlUDiAZ1vyCAZJMheDRW/ZohRKrnNbr
	 nf1uEYy4Y7rRRndmaD548z4MwjtRmpjWysKbjkFqxfbjE+PV+bEUZAF/hykc+zKyv+t1o
	 usQlFw0kzvM2k6KvFf2+pHFyU4qxYSs8DmAWOTbmfvKqkYUB1AoSQgF07CX65L7iSIXxE
	 +RYl/oTHhLr5xDqUfd+/cxCThTTAxvNBJFWh9ZPxzoTlkDNE2oQ66KOyT6kqHrcJqSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Mc1d85U7;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1067606B385;
	Thu, 12 Nov 2026 08:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1067606B385
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Mc1d85U7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HoCxZnqDwVt70RG0ruGtLMnZF1f0PVlcRbSPjTQhqSY=; b=Mc1d85U7R3WLHU95WhUzdkZxgV
	ozTHQCkjclHt9UTS4prS3VMsVNmWfjlvc7XhqH+HFB6+nasvs8/itX1bdWbFw2NpY6MUTl6+pkWMR
	hDAM6b19sQ5gp49s72iO5FSmiyPQCftKbLx6OhVskS8hYWRXhNEydcsHXuZi3A9mnYYvRIjpNfGS2
	sTT3icVYicDyuc+q8SD1kIlYQyoZ9OV0ZuX5EE2SnaJ/UMgFKfNgoeY+mxAVZXCEXhKpsBV+eMNLr
	GvSrompn4wAl/mqMFdufyaPz0NqdPQuLd7FBGOLmKjraaBLFFDKKKP5zPSSrxu7qp12T8QIL4FssF
	2vq4j43A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQLS-0000000A4TG-2N2H;
	Thu, 12 Nov 2026 08:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7506E30066A; Thu, 12 Nov 2026 09:39:45 +0100 (CET)
Date: Thu, 12 Nov 2026 09:39:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/13] jump_label/x86: Avoid decoding instructions for
 jump entry size
Message-ID: <20261112083945.GF2668804@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-4-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109194916.1089703-4-jolsa@kernel.org>

On Mon, Nov 09, 2026 at 08:49:06PM +0100, Jiri Olsa wrote:

>  int arch_jump_entry_size(struct jump_entry *entry)
>  {
> +	const u8 *code = (void *)jump_entry_code(entry);
>  
> +	if (code[0] == JMP8_INSN_OPCODE ||
> +	    !memcmp(code, x86_nops[JMP8_INSN_SIZE], JMP8_INSN_SIZE))
> +		return JMP8_INSN_SIZE;
>  
> +	if (code[0] == JMP32_INSN_OPCODE ||
> +	    !memcmp(code, x86_nops[JMP32_INSN_SIZE], JMP32_INSN_SIZE))
> +		return JMP32_INSN_SIZE;
> +
> +	BUG();
>  }

Does this actually generate sane code and checks code[0] first for both
values before it goes and does memcmp() ? The naive translation would
suggest it does not.

