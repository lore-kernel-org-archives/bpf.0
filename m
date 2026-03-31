Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387253D8110
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972957; cv=none; b=MovnoSb0gcwKhQcomT5DjQZMpH6fAFmhzC/IYje4KJ2oO13FjPTYckG7fA6ZhW3zsO2/C8fZlLFwzZ6Vbx1q3VxshHrOnSFBGirvM95NXZAe13rP+0xY6WCfxZrBVneSUlyZflOzO/bvuwA7uDGpGXKxsP3dbfXKxAP2CrjlAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972957; c=relaxed/simple;
	bh=5Exi6/wiN6Qw0I7iHFE9uh4IWrn7Zosgrx6QphP8+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH1LCyPcNIP7h1qwp1ny/0VNT9NLh9b/jnN85QErbvxcaU1BIQpclgRD6rczNTv5+INQZNO3HxJaJnA2adZH/ApYO+gTFuNer9ip20vyB3qvhlygKsqccrtvlZS3zmjQXeapV1Subd57W/IR7lHxX8X0jmMqZnhmZaXbYjuGf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E8B691B6E62;
	Tue, 31 Mar 2026 16:02:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 4F7552000D;
	Tue, 31 Mar 2026 16:02:31 +0000 (UTC)
Date: Tue, 31 Mar 2026 12:03:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 kkd@meta.com, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint
 bpf_link
Message-ID: <20260331120329.7126fe6a@gandalf.local.home>
In-Reply-To: <CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
References: <20260331005215.2813492-1-memxor@gmail.com>
	<20260331005215.2813492-2-memxor@gmail.com>
	<CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cr9gtnzwc6tcn91gx91qxxiimft3xpyx
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 4F7552000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lvY1iA2w/8d0/E3M/ZhaohT5lTuTs4zs=
X-HE-Tag: 1774972951-537434
X-HE-Meta: U2FsdGVkX1/YS16/rAS5rI0iUD+Fztpl+JQSEucs75hJlcJEdjNCYQl5hUfDd0mdifo51+AkPhE8sODKzfKEMTfvxf44TlL3vYo5m3BkU+4bwJKE45sLOogvoUKs3cKFwIxrn9bbPqFvObIgHOZ96fgsKYAppkIuFou0IXIFF6EecvTRtKaPOWLAB9jwgoXFRUFmPR/cBycsFdxRH2bvrSMmOcK49OhnLNLcomysyPQrOt1wCuEOR6ayBl2PYEPne8b1KOLzwg94vsvNkFOqSzmxs8jHQe4kodtJlXq/0K7n/J8a3FGRHlBbp0Mw1S161x/AtN+HiRL4s6xz11Fs1kKZ4yw2gV4p

On Tue, 31 Mar 2026 08:27:22 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 22ca1c8b54f3..8d6df1e7b5da 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -122,6 +122,11 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> >  {
> >         return tp->ext && tp->ext->faultable;
> >  }
> > +static inline void call_tracepoint_unregister_non_faultable(struct rcu_head *rcu,
> > +                                                           rcu_callback_t func)  
> 
> The name is too long. imo.

Don't like typing? ;-)

> call_tracepoint_srcu() ?

I don't want "srcu" involved in the API. That's the internal workings and
who knows, it may change in the future (like it did going from RCU to SRCU).

-- Steve

