Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA23363086;
	Wed, 20 May 2026 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295698; cv=none; b=o6ZdzJHAmuij6MWJyRgzvQpEAH2BTWIlTymzca/9Xik578AsXuTG+8fSVflETEqZh4vtKMCvopsSm28DYESY5qhzlOTzJL2w/j/A+Rsw+yEul0FrhKpZH2zcPFdMXTLQgLLvjxGzuyRFXsgMEWEDcr/NnEDNO2mJ6M2oRQbRrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295698; c=relaxed/simple;
	bh=gpBj82KBmP6C+DoIwvG66wIri8RUqdtqxB19mzF5hPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC3ne6+HxY2vGOxug66At6IDFv7qHeg1Ksomxlui/jaRmklSA6TEiQicOQbdgdSzwC00TgtU3bs0EeTvLZhfjR89FZGKk1YIo4P2sdXyTw95eyb/7GGhI5Bg+c4ajkoL0oZdOsCcx8vQ8ypOk2aopTZl2wiKmPc+g1UQJY965J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 519F08C1BA;
	Wed, 20 May 2026 16:48:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6D24B20028;
	Wed, 20 May 2026 16:48:13 +0000 (UTC)
Date: Wed, 20 May 2026 12:48:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260520124832.737a946a@gandalf.local.home>
In-Reply-To: <20260520152021.350e7017551ef202aace4cd5@kernel.org>
References: <20260519130144.40e71a00@fedora>
	<20260519174848.176A6C2BCB3@smtp.kernel.org>
	<20260519141726.613e2e54@fedora>
	<20260520152021.350e7017551ef202aace4cd5@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zz981ywhoysp6pww378nz1893umc9k6b
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6D24B20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ijJlSeSGUcoiAkF3L30McnQi8x4YzK3w=
X-HE-Tag: 1779295693-719144
X-HE-Meta: U2FsdGVkX18npd+AkGtbigyVYrf7qvD1rbKUE3Tw3NOkRqtn6j+yXyNLXwKEwBUwvU6ArRkJrCjnThZr3nX7uDTPcXV2aRyz3SeCQM2HJTEXVtNRGVOVP2fL0Apdghbw1MCbWk6vlUMMtquoDxg/147w1GuEzLlDsf3z/BhH9KeQBD3YWgEnVVRp7XszBRVwdRftIDOXjBKLhtbJZIliSyxhPyCrXQlsjHoGxyz+w/I/j4J28/XMKR/tNrxY8xukuz/OpsF9ZG2Tiie/Wf6eibFrG9+MOKdH2fi4ipQhCnMhgwxeq0ro/mu/f48SbEwAVuxXCocePn/g+YlZe/Lf1RLxwG8z9oHE

On Wed, 20 May 2026 15:20:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > > @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> > > >  		ctx->params = NULL;
> > > >  		ctx->nr_params = 0;
> > > >  	}
> > > > +	if (ctx->struct_btf) {
> > > > +		btf_put(ctx->struct_btf);
> > > > +		ctx->last_struct = NULL;    
> > > 
> > > [Severity: Low]
> > > Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
> > > the reference?  
> > 
> > I'm thinking of dropping it in the '(' switch case.  
> 
> Can you consider making the '(' switch case part as a helper
> function because it depends on CONFIG_DEBUG_INFO_BTF?

Should we just encapsulate that entire case statement with:

#ifdef CONFIG_DEBUG_INFO_BTF
[..]
#endif

 ?

-- Steve

