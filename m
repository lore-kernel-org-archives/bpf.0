Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621573;
	b=y9Jn/TWbg1TxOYnA12W1Jj8jIeEGFbKyabngDaJlKXXm7gBBZkqhB2XmXqQ09NHgZzBI
	 D/vjWQCpor+cP0Ee2ZqjZVJUck9824A5MZVaVjud8nIS8/R1XFF7SulFETuu7HTAHmYkp
	 H19/fHdyQI1jGh59zrcASO1fsrJ94tfn2d7GHZS4Kvg5ITblNGYsyinnnGFoy68SEwgry
	 ppv7ROvNfbazquRRxct0pL71sxQ2TbPbUeQtibZhcVQJes3H5RKpoJuGfeX/slB1yYbkd
	 dHGJCNAW61B8I9K6ub6gJ4dyDoHYfwuCGxismF2p96FX+GGVmaJq3zxe4Q745hOP2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621573;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Status:
	 X-Rspamd-Server:X-Stat-Signature:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=8MIZWno2npoMUIlLN3kS7mGO/9uJ/IFSOHAZr4ADfQE=;
	b=06du/IRXy1GyIzuWeC0/ufwY5Jtjo2HN4+blqE2Z5rlIWEr+Jmccb4wh7VfU8tMLqm/d
	 pgYE16xZp2XbuuF7UUXa1Q8PbikXrmkAkJby4ppFAy3k5lKrnb++sruQOZ1WX0y3SgAtu
	 4CzUM6qE4oGpMYu6hHebvFSyKx0b9fXviCRSsMzvG6vvNbKMLcxI6Et5SjskTfCpHTjUQ
	 nQmU3T4Icfw7setO7xTpnN93aF68nt+fv8bR0uPYHMRhND+RrRZLBYnNvMI+YZaQOq7l3
	 zVZiKdAZP0PLcr8tm7rz11cnS+NucQK7MAO5Kffe0MEC7gssDtTG0E/Fcoun++gH0qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OavIN4WE;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE52606A31E;
	Wed, 25 Nov 2026 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE52606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OavIN4WE
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DFD4A140DD1;
	Wed, 25 Nov 2026 15:46:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 397FE2002E;
	Wed, 25 Nov 2026 15:45:59 +0000 (UTC)
Date: Wed, 25 Nov 2026 10:45:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, KP Singh <kpsingh@kernel.org>, Matt
 Bobrowski <matt@bobrowski.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add log support for tracing_multi
 link_create
Message-ID: <20261125104557.1f0fb120@gandalf.local.home>
In-Reply-To: <20261125143138.47174-3-leon.hwang@linux.dev>
References: <20261125143138.47174-1-leon.hwang@linux.dev>
	<20261125143138.47174-3-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: 397FE2002E
X-Rspamd-Server: rspamout08
X-Stat-Signature: bakjba3n8hiay8ri5ncytaycwy31fqbq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/A9ii1UvUhkDfPAVQ+ewQptk1Gg2iKK30=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8MIZWno2npoMUIlLN3kS7mGO/9uJ/IFSOHAZr4ADfQE=; b=OavIN4WEfnNtug+3I6hEwZWTSLkq1bzW4MTbfS2GFmzt4Y8DV8PPAAvppseBfP9aHQD45kU+F/kRyzmrb1u94PGq9lZ0S3lnwkm0QpIQqMyMaIONaGiJTONVKuRnIXPIB+mgfD5XQvpMk72J2jw+4ygH8U/E+OcZJz5a6GUVl2I=
X-HE-Tag: 1795621559-927810
X-HE-Meta: U2FsdGVkX1/QsWFimWrlcmB8dh0NeoeGxBpXwOM3wRsvnP7Oyi0I/tsdmP5eWFht6ZXfsbL4SFtlKwz2QCkilFkCyLb5tNazmsifniUKP0ZfZaGwS4eCksT3LYK/2zK1kRct0rUE3NFlczQKLY/S4mLAZrM0h6stM08t8qlEl8ldk6RBuHqzqk1/RwmZLuzrt8UnfCx1K/NRwqf6wQ0dg7PClJhhwUSIA/9iYGDwOrFNmAxz421QDWBsQ90bs4eTDLbVn1gv0525W4zXx6BxZd7uChhkK1fHK8OMGDazZSiBVMvHjsoyRUSNNU0AQAMQPkCCTFw2SB31S6rurHCRAu70CBdPoLCkeOiX25mgqbOUOjSrN+wKB7UNoF6bTnJc

On Wed, 25 Nov 2026 22:31:34 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 321f2f3a6c8e..bb825ea5d09c 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -16,6 +16,7 @@ struct tracer;
>  struct dentry;
>  struct bpf_prog;
>  union bpf_attr;
> +struct bpf_verifier_log;
>  
>  /* Used for event string fields when they are NULL */
>  #define EVENT_NULL_STR		"(null)"
> @@ -796,7 +797,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>  			    unsigned long *missed);
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> -int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
> +			     struct bpf_verifier_log *log);
>  #else
>  static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  {
> @@ -855,7 +857,8 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	return -EOPNOTSUPP;
>  }
>  static inline int
> -bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
> +			 struct bpf_verifier_log *log)
>  {
>  	return -EOPNOTSUPP;
>  }

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
