Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292324;
	b=axMKHzqX3F72j+RyT4gZEoSMuqdYREt+GFD60Y2Alrs95LkwIezf+CUIpbxDJ0rJs6X7
	 R8VfLi55hNxyoXMM+ACgTF0Ez7LuDtClNM916j0f8EDoMBLCgKMaqYel1j/ejg6MwHoo0
	 QbLKbRCxO+Tnv0KFpCUk3gocA1DkU5ye/rIDV+Wx5G62K/M8yZsRSg2A5sESLcUMa189Q
	 rDCq93NwYSfEh/w2IAdknGNzCGyMAsPFqaCgOTfcNmyfdTZqwYz9kXI274TkvZZds9zbt
	 6v6L+VXrRKVZhpSxbcVTE9McI/Og04ltS4oJqR11KlNHzdUN72wXqvUKWTNXFWuXs/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292324;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=jTL0Vn1vZcwRC6504YEz/5KSf6ShhFurO/agsa1xCzo=;
	b=AMFpvPp7czN7FZyel3q6VUWedpFieT5m4AceSNpWr1bHi+xxIU73SC1iJ/YxLIw7pMnY
	 IHyCGicg21YTvTiUROT4kqLxE+iWWZW5V/s4QAufXfoDgRQsUAuy9GVpocV38Tz2YCz7/
	 oJvlbs8gxAEiSTi+s7dvSNLIdLAb6bPqAYvHaVqyGO7vdNUJCtUrdCRxlcks/qsOIgQ8c
	 CNGHDZYjYaAEEcLUaRhimsS3xHwKrKjH5EfJm5pn+fvoJnc77dBZfZ+7Tq+2sTo0vgfW2
	 65Jw9aQqEZy4Xp0qQN9mCgnSYoV2baOz9CmyJp0Bd5QvnFZypwchlj/Sgp8mwy5u+Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OXEPlS1h;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEB606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BFEB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OXEPlS1h
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 9BC861A04D3;
	Thu, 29 Oct 2026 16:45:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id D42142F;
	Thu, 29 Oct 2026 16:45:19 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:45:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <jolsa@kernel.org>, "Menglong Dong"
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v3 1/2] x86/ftrace: Mark jmp mode by clearing bit 63
 of trampoline address
Message-ID: <20261029124518.1953fd57@gandalf.local.home>
In-Reply-To: <DMHGVE026N3I.1V3834R8WLSYB@gmail.com>
References: <20261028202345.1215859-1-daniel@iogearbox.net>
	<DMHGVE026N3I.1V3834R8WLSYB@gmail.com>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D42142F
X-Stat-Signature: uxc6fechprh9xex4cm34ui4m8ts5scer
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DwL4jwXjaJ95BavNzvUDIL95SULF3ajg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=jTL0Vn1vZcwRC6504YEz/5KSf6ShhFurO/agsa1xCzo=; b=OXEPlS1hpL4yTbB5NOA+Wl5nlBqcmi9JDYPFIzqfmu3SUKV/fE6lbIVsF37hOF46iB/3HIYtBnf2mQzC7vHc660tT1U7JdTtMU3oBmsXDd6MkGGVox4vvO/VlnxiGDN5kCDvCUOgkqoIXhq0lR1fAypyNrhsJmkFEydrbV4BGvk=
X-HE-Tag: 1793292319-381902
X-HE-Meta: U2FsdGVkX189lvmw6xSs0YAnkcBrhBO8y+Lvp+JNwGYhh5alivt+0OO/xSDkxSIQXlCNwa9KH0ThPC8PeBb2KfBn7gm4yxPxyL/5DyL7ZsaU5T9JtKlbdPo7JMWp3QprJ+IDy3UE0fKUCCHE1NAiq6eDJft8zLnKQSk6UX88CppcbxKV2oQH/DLb6y9zDXnIaboMmVpoqyyq6F48nVn0CccwpsI3GifLkmAe4NdmxO0Xk2lr+1IBHLT4zemDVXjuL4tAxrgpVBWrDlLBZDmww/t1+V4cVw1vcrlG2KUcSWi2TFY6VcPWD7mzMqZ14fmq2V4TjJD4yOGf9skVVlIP+F4bwhS7tQ/2v4GdcVjmxwzRcc+r26DfRj35ThTeweBenRuk7EEZEp/oEGb+C9IVUxgGY64/bROgWwr/ikdQmbSjTgnieHF3fNNrtWN0rAt7uP9W361hIWMfDRSZIKjL5A==

On Thu, 29 Oct 2026 16:35:52 +0000
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> On Wed, Oct 28, 2026 at 01:23 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> >  static inline unsigned long ftrace_jmp_set(unsigned long addr)
> >  {
> > -	return addr | 1UL;
> > +	return addr & ~FTRACE_JMP_BIT;
> >  }
> >
> >  static inline unsigned long ftrace_jmp_get(unsigned long addr)
> >  {
> > -	return addr & ~1UL;
> > +	return addr | FTRACE_JMP_BIT;
> >  }
> >  #else
> >  static inline bool ftrace_is_jmp(unsigned long addr)  
> 
> Steven,
> the code is the same as in v2. Only the Kconfig text is gone, as you asked.
> patch 2 is a bpf selftest.
> Mind if I take it via bpf tree?

Sure. Please add:

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
