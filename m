Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F59410D14
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272988; cv=none; b=Hwx4iBJm/SFht/4YoyB0sIp99HtcwonID+MzpoZ60YkzetoldbJPGrsxCB1iL++I2J3GtT4tlivPFsWC4vs9imyhrqEu42JzDc70JVjhr5PB4jmg82Y7z41ZglEwjj93pVRBEoCoNSklWW7NCOwX3PBTs28StJkp6zctvfqYp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272988; c=relaxed/simple;
	bh=ivXT9953qRXUnNR72EFfc69TUCwH3DgIaPQqYHoZ9/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4ONLD9jy5heDWTfaIjE3iOXkyX+dOiyWJAi092pZMFnoMuuFIt93YKzD9zzq+LOt/QVHOALbYtu6MoRUBItfdS8CLVnBCWFylpL4nRdhbGm14h/0korIWeks/2jp//qbMD3M6aYB97V6Lh62XZyC/clSEuKTJHjMaMYRQhl2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgs5Ts13; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgs5Ts13"
Date: Fri, 8 May 2026 13:42:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778272975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uph/LdlKI3jMM/IrNxJnJdlf8a6sDaMEU9S1D5To3Iw=;
	b=xgs5Ts13CVKbiFWIzLK6dGbJGfgg7RcsjabV1QQ0kMwv2/ESBC0vxRgYmyWanHmWxvQARk
	xStlcBE0qhp8VvJyCZjCoT2iqQPzJPv3KmJP3k9kwjU6v0hVsTFSKm8CSYq5D250zN5KWn
	uAR6XToFDnRJlH3NfuWJcbE7PhT5tsw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>
Subject: Re: [PATCH v2 bpf] bpf: Free reuseport cBPF prog after RCU grace
 period.
Message-ID: <20265820377.lHsx.martin.lau@linux.dev>
References: <20260426012647.3233119-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426012647.3233119-1-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 26, 2026 at 01:26:43AM +0000, Kuniyuki Iwashima wrote:
> +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
> +	struct bpf_prog *prog = aux->prog;
> +
> +	bpf_release_orig_filter(prog);
> +	bpf_prog_free(prog);

afaict, __bpf_prog_release() is the canonical way to free a classic prog.
How about __bpf_prog_release(aux->prog)?

If it makes sense to you, I can make the change before applying.
