Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473434;
	b=PnpQ1Ouc8Cwa91UGRAcePCj7NB1RGCXt3kNaxXUD+jP1FqVVacdG4jz/aDDohdaGC8N7
	 ocu32QePJt2mVJfKlR/84B8lEUJiNfHfVGnfpwRTnXMH4Rd6tbln2gyB/f3tHqBo5RO2O
	 CPnXXKypCpOjaoW6OZW8fqMX502krFSG3nrnlAW2WMHxJ2J+rzAxD77Xp0ZDO5Ko/kh4Q
	 dFe3VtiyDMJuypzqcmi4NSKpxzeKr0Pxh4BL9IgCPaTwHJroHdfM/h991C1PD/5m6iNkV
	 2a2KQ1zKZn34wTNLQfpIpPQ98AbvqNi3bEQvEUGcBZBahYeN2W1gidzSmYXOT2LtBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473434;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gZlHEGAkiA3aSI6vvQcwGeSxtcrkyd/SxdRwzYrp61c=;
	b=pOpro5H6zBgYeisRccuqKhGRvW0LfIe0FhxUsmcQvZSFZhbBm8TQtcbSVmf3NuZlEdUH
	 4Lkjx9rKn26n3SH4fa9yJDKiKCVRJx/mK8etZtXza8NhdDChtvQmU1B7gJ07Nt71LOyJN
	 RjEfRIYjaWQ+/XoeGYLxWac8qI2qft2G3zAIxMlcFPQik7kY7e3fxMpFpJTaeonN8hCPr
	 fyop4KAmNylCXaISB6o2Qw8FK8YisNtkIdQfuXSXae0AtZUf5bm8Y+OTwNUiVxvaQeYGR
	 IVvNjYO413lvbDazU7URys0krFtExAdIhYoGaGLrnk1W5Pdbb5hn0zaINR/kc0IouTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mAV4VJfb;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C8606A323;
	Thu, 12 Nov 2026 08:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097C8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mAV4VJfb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gZlHEGAkiA3aSI6vvQcwGeSxtcrkyd/SxdRwzYrp61c=; b=mAV4VJfbyjcbaHfIGNGASfGWnp
	Z3uR3/UYX/1apdwDSFpjOEbwtlS/Cu3fo2gK/vmqZVpi4H/+HXt9Ffaqg5Uli1TnlkijO4ow9Kd68
	yTYZVcPDD2LkvFfnKo5CbuFJI4LR4o39XyjshMUAT65FJHITeFpeCWw6V8q7CG/a6CxDSyBKN9QPa
	Ksm3UgH0lY/XwqxWDaJpaGSqwRFarSgoOoZgyCChREpcUsjrVUjZFuxvVci1V6Ouose7KVok+7X6I
	IISqN519mFRG9HhC9qiSohSrSjp7lgOsm0zjPG9c12GTAb6vWZUcIQKTTg4NpaXmD6HyjivBF/qjF
	J5N3rr4Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQVo-0000000A5Rh-2kyG;
	Thu, 12 Nov 2026 08:50:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8178E300400; Thu, 12 Nov 2026 09:50:27 +0100 (CET)
Date: Thu, 12 Nov 2026 09:50:27 +0100
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
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Message-ID: <20261112085027.GG2668804@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195517.1090787-1-jolsa@kernel.org>
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
In-Reply-To: <20261109195517.1090787-1-jolsa@kernel.org>

On Mon, Nov 09, 2026 at 08:55:17PM +0100, Jiri Olsa wrote:

> +static void kprobe_tree_insert(struct kprobe *p)
> +{
> +	struct rb_node **link = &kprobe_tree.rb_node, *parent = NULL;
> +	unsigned long addr = (unsigned long)p->addr;
> +
> +	lockdep_assert_held(&kprobe_mutex);
> +	while (*link) {
> +		struct kprobe *kp = rb_entry(*link, struct kprobe, rb_node);
> +		unsigned long kp_addr = (unsigned long)kp->addr;
> +
> +		parent = *link;
> +		if (addr < kp_addr)
> +			link = &(*link)->rb_left;
> +		else if (addr > kp_addr)
> +			link = &(*link)->rb_right;
> +		else {
> +			WARN_ON_ONCE(1);
> +			return;
> +		}
> +	}
> +
> +	rb_link_node(&p->rb_node, parent, link);
> +	rb_insert_color(&p->rb_node, &kprobe_tree);
> +}

You probably want to use rb_add() here.
