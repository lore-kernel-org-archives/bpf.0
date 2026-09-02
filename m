Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E04370ACC;
	Wed,  2 Sep 2026 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335182; cv=none; b=EIyqLIx1QIZsTQRmZU9Im/Exnm+bOf7oykek3dnUcRkDl7NkgvmMASd5oLq2j2caTTRVZDLLb8OhMkYdYV5v1zWKM8HBeJMGkFHVgiKAjvw1VUYrFOy7H7YzB1zSOLAB+RVjATUClRjg078EiV+BhBEDHZ+AtJMFKcdonUnUTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335182; c=relaxed/simple;
	bh=29czV3fjjxBVQbNXJgxEZMzYgZW1biCPklSbU1r9VFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMrJ3SSibZwJEy69wtA2y4mdf3h0ccWbOTI21/csZoDRXPQDSkp333ixZeSTXPZjFNFasmcvKGHl8ai1rnKDTZnz6K8XXQQ4qDfbS21eSc2Sg/A10KN1DvUchTW+/PATe3/2nz3qP3V1RiZw7AYBcErW1uCwJmoMi+LkJrvSO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Do35rUN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7XGseWt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Do35rUN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7XGseWt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788335178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29czV3fjjxBVQbNXJgxEZMzYgZW1biCPklSbU1r9VFU=;
	b=Do35rUN1QqwaRhpAx6tTLLF9UE2JChbAdvhVfGYDAMbMcKcY6hcoZ3n08k2h5PqH6cbSTE
	iOYaz1TQEF016iyZag5zi8yBnZzdz/fDFNVTWe+cD15T0SVXrRT8EGvvR0/LLWDwsk9YGN
	Ag/V+ftFNkdsAxR72nv+zqFk8g2qAHgPxhEdu6FoSyVCSAt2NEhTlKnKVBdMsoqwurvJph
	NvQGbIoWfOe55EgGxbUYbEAakDm7OAaCkzMXdh/k6+KoFFP5j2yhgFgZyX4ZNmy+SJpdRP
	XGa8kLAPH6kIGD9UfXUV0cTUi5FDxJOQpOiz5FVH7Gh57U19czXmyfRTNirBgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788335178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29czV3fjjxBVQbNXJgxEZMzYgZW1biCPklSbU1r9VFU=;
	b=a7XGseWtGRSYJDkNDkn2iqJSSLEAeTU7RbPPZ84zWJsrP5ylW7MHFCI8zUwh6Ym886g1ys
	AZX52ao/WlUmHlCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
In-Reply-To: <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
Date: Wed, 02 Sep 2026 09:46:17 +0200
Message-ID: <8733vsw0xi.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> I should definitely have included it in the cover letter.. I'm writing it
> everywhere (will present at LPC) but forgot it here.
>
> Essentially BPF monitors can be pluggable, folks writing their own monitors
> won't need to submit a patch or maintain a separate tree, which is useful for
> domain-specific models.
> By being pluggable you also don't need to reboot to use a new/updated monitor.
>
> Think of being able to distribute a more granular set of rules for RTapp, I
> remember we had conversation along those lines, not all rules apply to all
> contexts and what you send upstream has to be general, what you keep for
> yourself doesn't.
>
> Having monitors in BPF brings also other perks over kernel modules: a whole
> bunch of readily available probe types (uprobes, fprobes, all unexported
> tracepoints that are cumbersome for modules), the map infrastructure for
> allocation is arguably easier and the code is verified when loaded against
> common issues (NULL pointer access, unbound loops, etc.).
>
> That said, I try to mimic as much as possible the in-kernel functionality, but
> some things are not the same (event/error tracepoints).
>
> These support DA only because BPF loading needs a userspace component and the RV
> tool doesn't support LTL and HA yet, there shouldn't be any technical reason not
> to extend to those in the future.

Cool. I also wanted to do something like this, for these exact same
reasons. Let me look at your patches..

Nam
