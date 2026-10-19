Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54144F55D2;
	Mon, 19 Oct 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415645; cv=none; b=OoHG/ejGNoEVrO7v2exkDiTKCfiGRaKC+rOP5llFLK16Nmy8mHYrN1dwOrqxQFHiv9A9mNzzOtZZeMwrRuqpDum386vy6EXNKk7TksGqbpGWDIXGYx/l50O7dAG/MF2FU/93dGa3o6eqj2TMBM5vWFrgVvSiXlWiGzjtw6a7kPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415645; c=relaxed/simple;
	bh=N1QZ4XpJ1cU7TIFuX7BIMDd+isPTxoaEEXPTMdeRz14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMfQNKzzra76xsDmIkJo18F0FdPT0E76NPt2r5/2U7vjkW/9AzzwNB5QbCqMtrJwJP+asKE/C3xZVc8XzSJ/hwtgpt5YK6gsmFRwRSA0KHXWI5hmA6ur22+9FLwaROlrID8ttKCQG5nPTqelDND9T6iiGWPWSF1RRiugTt07sSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHoABmPG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bb5I3kYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHoABmPG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bb5I3kYU"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792415640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1QZ4XpJ1cU7TIFuX7BIMDd+isPTxoaEEXPTMdeRz14=;
	b=NHoABmPGlXj37fSWBME1pujW9edDFulSUwKEdjCIX0trxbyiM/txEgFmbGgcwgXLTKU94I
	VcR2orpb31VIAeflmb9TArU8FILC189MFVqLDJ4QB2WCFEY8Gh80TJ9Co9yy//88SkbTxi
	nbNuHqY0hU2spPO/YN1hK2oFMKp/1JGNNJ+VyvEoS9HpENxDIfMvuivkL6ZaXtXS+Wy+HU
	KqCNZzl1mSyMqY+kSqk/6VifnOuCQVdhFwKGLcCkak3YSvycuBh+pGURd3YUc6X6d9fKPS
	hA4Vg+rvFkjbinOOd8eNVzPL+Qsq6/aZAXpvz+mDMMSnIZrZjv1jryrbPCIcQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792415640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1QZ4XpJ1cU7TIFuX7BIMDd+isPTxoaEEXPTMdeRz14=;
	b=Bb5I3kYUyRj2e/ghpflxuUgZusYaLz2Lfkzizx5KJMNi7Xqd7FoAViY0+5DzDCMQPhSgFd
	DobvsZGbQ9lf5rBA==
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <87ld7trgzg.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
 <871p9mqcn2.fsf@jogness.linutronix.de> <87ld7trgzg.fsf@yellow.woof>
Date: Mon, 19 Oct 2026 15:20:00 +0206
Message-ID: <87mrs9q1d3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-19, Nam Cao <namcao@linutronix.de> wrote:
> John Ogness <john.ogness@linutronix.de> writes:
>> @namcao: Maybe you could chime in if you want the transitions as events.
>
> No. Those are only useful for debugging RV itself and do not need to be
> upstream.

Sure, but debugging RV itself _is_ a use case. Especially when RV moves
to eBPF and lots of people will start writing their own RV monitors.

John
