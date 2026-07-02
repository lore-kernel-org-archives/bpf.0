Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38A4BC019;
	Thu,  2 Jul 2026 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001101; cv=none; b=rztglzS+c3ZWW/jnPJl7YM9e3ZnrYB4t90mHKtgf3wfK++n+nsN5u5rFleq2FcmUCW3UeR45iQ2dydDLTnKT8P9OV2IG1RQnjvlsrYEGWUjtXRY4oyjam4I36AkXPUjRXUvz72ZooCI900AvtDQba4Mh+hMLMT0LYI3jlzlUNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001101; c=relaxed/simple;
	bh=AtnyyeRv4nq4SIJbNgmIDdSF2U3BWIQ9rT/ZMoJJzLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyldOW7AVjKWIL9aAdniILOm56Xjsykqv3qxAPhVa0IR2fLrXg1oYLT3PD5EuLs3jP3G7gkh5oVIialAQWFku/f9Ny+o4uFPg5IDjPLo1RvEgih7iysTm0FRHCWx08gxcx7gM+zJWxylkGBKRuHcrTKYpDqnPRfDgCD3Nf47YMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DA6BF1C3ACA;
	Thu,  2 Jul 2026 14:04:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id C025418;
	Thu,  2 Jul 2026 14:04:55 +0000 (UTC)
Date: Thu, 2 Jul 2026 10:04:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
Message-ID: <20260702100458.46c474b9@gandalf.local.home>
In-Reply-To: <CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
	<178291354144.1566898.14374948740441958770.stgit@devnote2>
	<DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
	<20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
	<CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C025418
X-Stat-Signature: queikjky76apzk5b8e1u88qbitu8yj74
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+aytJtn7SWc3YLhYQoDoYv/QA7vT9+pFw=
X-HE-Tag: 1783001095-298031
X-HE-Meta: U2FsdGVkX19y/Zm6kF21iOlpt1tGwqHfdDEZVnuX77Qq+HB+Mz7zmKScjCBRA9BghNYlLeX12lptyGW2798RBcwq/bGnnv23izoPFiM42UgWIPz9/hqywABbrlDgJmtzIE5jY2KoNpaKdvMmvxT8sKmWnny5gM+tHLRpinVkiKa9f4khcUOtK8TGGpesxNA89UcduffgUBo3Sp0kQ2jst++F12p9kaoMLk+iK67TqxjPU8BM8jNg2sMucG/B+RkAvd4CURFYCtt9ffJp0LpjWFF7qtkhA1YxSLmqN98ILv4ZlpD6MXzmEbCQiJ2rym5N3F1AdcMWLlUJvvhk+7ffpeLH+sUb4D0z

On Wed, 1 Jul 2026 17:01:01 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> The whole feature you're trying to do is imo reinvention of the wheel.
> bpf could do that kind of filtering years ago.
> I don't buy the excuse that embedded environments without any
> kind of user space needs this facility.

And what embedded environments do you work with?

Feel free to go to Embedded Recipes and talk with developers there.

-- Steve
