Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C24AF9FA;
	Wed, 14 Oct 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972173; cv=none; b=re141h25LTadLpBWot7uwrM4MUniXCDPdfwjqk6vdq4BQC0pkSFMoTexoJLRbyoJ6poNPVcpzBFOPLUx7bUZS2vUuVl+rBcohkkX0sHMvsnLLbBxVwPxZFOp0zuNEUFdy174znhPYCEeaL5zQqB9yhzVOqgrWEohGxaWChEZmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972173; c=relaxed/simple;
	bh=vzaXcNhw8+Gx1k+e3i/Jgdix5iSurEh0Fb9pToA7tIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P9aU5rSb/W9Iuoe/tLoJHkOw/is+GM4bu5Y/89wRDX1rsK+Pa8ZrBm4mzrrjwSJVd8jBQYkszkDYnBJpE1tbEbNv87fNxmxOG7nOtkbyPQDjzIslNc5QaWMseoGe6UoSs6SY9LGN+kA4NDXf2qkvA4Q8sshO0JeRH7+QdsWVu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYHzKS2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=92GZLb/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYHzKS2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="92GZLb/c"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791972170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ii6X4Q86Nezai669ve/W9qj04iqzWpDX+DkbLve2zYE=;
	b=uYHzKS2Ns7yeF9qAVxylQCsS9CNblN8ONrY/KxP58nF86TRJZPIFwuffj5lsWJc6gzmt8g
	ilRUP6DD0tbg1V7WS07GhuIMIdOlqbelcwjnAxHJLlbksZB2MUtFik+lmSggJPYTrmprOm
	kTJuQSHnh62BDU/Kc6kTUfM1v/vsrVZ2j02kgZCy2BXj5qYQC4g/ceIE9AiBaC7HGHnXF4
	LpOLSp2jdlkX3nDq6SI9JutsH9mTAeNuSGOhKrTqNcer86ljHDfGm1kxtsRa45iILDPH8O
	rPDkUaBlPTcuV5bq7E5MkDeGsvDZvTlLUAR/ztWOgnLCq4LTa+ljyRRtvLUZ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791972170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ii6X4Q86Nezai669ve/W9qj04iqzWpDX+DkbLve2zYE=;
	b=92GZLb/c8P4+tKdxuzUFMrC4q/pYHAkPhM6w40TguwK0D49LAU73K96Y40IEe+t3/KNtBS
	pn+uAxXJD/EJfqCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 04/15] rv: Cast result of model_get_*_name()
In-Reply-To: <1ff1999324ecbbfe9a36f8c088d7d4122ae59177.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-5-gmonaco@redhat.com> <87jynmgm94.fsf@yellow.woof>
 <1ff1999324ecbbfe9a36f8c088d7d4122ae59177.camel@redhat.com>
Date: Wed, 14 Oct 2026 12:02:48 +0200
Message-ID: <87v77461mf.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The reason I initially didn't do this was that some lines get beyond 100
> characters adding the const, so I'd need to break them and make rvgen even more
> complicated to generate things (TL;DR still laziness).

There is also coccinelle which can automate this and can handle the 100
column limit. Just FYI.

> I'm actually taking a different approach and storing everything in macros like:
>
> #define DEFINE_DA_EVENT(name)						\
> 	DEFINE_EVENT(event_da_monitor, name,				\
> 		TP_PROTO(char *state, char *event,			\
> 			 char *next_state, bool final_state),		\
> 		TP_ARGS(state, event, next_state, final_state))
>
> So both per-monitor trace headers and rvgen get simpler and if we ever need to
> change something again, it comes for free.

Sounds good.

Nam
