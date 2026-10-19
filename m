Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DF4E3241;
	Mon, 19 Oct 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414283; cv=none; b=EWdzRVNKwkvHpkcAN+PGTkYoVQT277TCtkRNs3IJbdFBa7+hs5zNUCA3FADye1RuqpoT1IGXbfi2kIX5fCpq+jZ9Km2fVcmBwSCcE93K6e8btrS1JoPT3glbg2+EE1VgpkkyWVlhw0FwOPxEQp1HfFF1e75cUpvlZV9V1IH09TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414283; c=relaxed/simple;
	bh=XoshIT4Yk4/+L4hPu7UGN3v0X7efLSGXlzYYsxhxI94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0oEtA1ekB3RbwkgeueyJPgFIQS7aX8XAknApXWZ9gihcOBVuqAoNlDyvswWvxJoPylkTeQnUvJbDKutmUez7VmcyGepiQdJVZ/+hXBV0cNdD2YbvrcvQlH4GjzItOyFh0+ZpSgxVTZSK21XmWgVhepSLLIQitlVOYRDpB5RVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QvKejIiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJk40+i2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QvKejIiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJk40+i2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792414277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoshIT4Yk4/+L4hPu7UGN3v0X7efLSGXlzYYsxhxI94=;
	b=QvKejIiq8ol5xZJAeoYurGN4c/qcdbHaPn2Iy1ujoEnvLndWq/AcGusMFw9e3AWIDlmDd7
	RrlcbHyfVFIiHLXYPjZ86tirtl+IMKXlmgBiKuwLTj5Of8C2JG3nLg+Bca6bVvSA5BYKDk
	pGOREtbOOGo0vIWcmlJlwIzqdKkcSiNj3ngR5PJAGPrJEwt100JZUdIev9OjiD7c7TMAT4
	+QmwDc8XLZv4uhsvbV0OYBO3qh4i9u19rdYAQ88ROvdetRTX6ZjM31sSbBkHol2JJ73Q35
	zwVMxoMisaSNWKimzW35NX1bUwDG7fqOpGGokvaoZnaCj1/SnJRvC+ncRUogtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792414277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoshIT4Yk4/+L4hPu7UGN3v0X7efLSGXlzYYsxhxI94=;
	b=FJk40+i2llwR8Tz/teaLjzJSZOdd7HSfIfKbJCD7EzAypOzwhlOACc4AnjOm1PEK6Mjqx/
	smAhjrA1+XsCiWDw==
To: John Ogness <john.ogness@linutronix.de>, Gabriele Monaco
 <gmonaco@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <871p9mqcn2.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
 <871p9mqcn2.fsf@jogness.linutronix.de>
Date: Mon, 19 Oct 2026 14:51:15 +0200
Message-ID: <87ld7trgzg.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Ogness <john.ogness@linutronix.de> writes:
> @namcao: Maybe you could chime in if you want the transitions as events.

No. Those are only useful for debugging RV itself and do not need to be
upstream.

Nam
