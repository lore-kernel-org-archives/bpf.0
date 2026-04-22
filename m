Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206842737E3
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873510; cv=none; b=EbqkXB3P+e/u04JipW1JbHXqPOWMsu80K4Y7iauoDCAiHnmhxbCcpYapPSV9/zFRAuzINuHnWnO6IoYFhFujMqPw57zBFJ+WYMKs5nKZXPZI2SVWlIKiyAECr3xUrSrK02Js3payRCTklX/XFBNr65pA8ZVGIJyGI7JiiPtUE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873510; c=relaxed/simple;
	bh=CYYUE7sycUT9B5COCbdnWOw4VUWmbOq88Cn6CT2xcE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3phc+1EqVSJeBNe6zHA7/c6TaJ/0gIq0O2c6J0dR3zEzKFDYkXNPahGptoQv5yy/hMZuxcNbYe8vgMfYbTTbYLHj6Z0PAB1nGIbLEJiqlMPh9/CcGGEWygXf3XRfDbK6BbhM5iS0tyYIzkRYBLDBerh3O5iF3FPLhtZsEEkfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8F8431401CD;
	Wed, 22 Apr 2026 15:58:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 438D318;
	Wed, 22 Apr 2026 15:58:15 +0000 (UTC)
Date: Wed, 22 Apr 2026 11:58:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, Mykyta Yatsenko
 <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Message-ID: <20260422115816.22c7f39f@gandalf.local.home>
In-Reply-To: <20260421-sleepable_tracepoints-v11-3-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
	<20260421-sleepable_tracepoints-v11-3-d8ff138d6f05@meta.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8e5kno7f78xa311zbexgdicgi4kka59b
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 438D318
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+tIgrSDazaPhXcns2NDe6j+n5xqryQjMo=
X-HE-Tag: 1776873495-800091
X-HE-Meta: U2FsdGVkX18KNdqcAOnBRYe1YH3kX26hDznUukIyM4Jx3TQCGjdV2ThbtiER6BKb+jbYnPMeIHBD8PIp7nMjLzrkCc/46z7Ah4ZBtWldCj12n6DTvmW0HmBoTttvurBvbraKocObXIGDG2Y3Ief2YjcSqiscGc26gqGshwdFplRiQs1Z39TzMOi29eU2nRxgZOXI1Pg6STzqPnTxmSGW5SGJQnrRIEdagVYpUllIVTwwvia6mf+mhGKaKEAkT7CR1Yp2Xho20EA4EsPIFBx0YN7o2Q+V8Ankr710480ry72lPsCymgIyQdGP0vq78InHEaFneiZcIv5zXkix0UvDHQXJa+pcrIsP0+7vHVZjDurZM8mdOfxPvQNbWkVUWUlM7q7prHDtLycFXnnJTJjaIfz7kWvXe1RiNlRDYUq560cQxVVHcJTf+9EBCDAf5BEejyYcE4+p6qwouXnaKg4gzwNLZjGKvf5qzQpj3QW/LnKwVvq2DQ3MIAJBrg8j/AyiWrflKHDtY90=

On Tue, 21 Apr 2026 10:14:19 -0700
Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:

> To: Peter Zijlstra <peterz@infradead.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # for BPF bits
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/trace_events.h  |   6 +++
>  kernel/events/core.c          |   9 ++++
>  kernel/trace/bpf_trace.c      |  28 +++++++++++
>  kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------------
>  4 files changed, 101 insertions(+), 52 deletions(-)

This only touches the perf functions of trace_syscalls.c. If Peter et.al.
is fine with this change, then so am I.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

P.S. So strange not adding "(Google)" to my tags anymore ;-)
