Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315073612ED;
	Tue,  7 Jul 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440049; cv=none; b=C8U0v/aEj74OrbaTXpSovIIdDlKveKMILOQkaRR+d95P41Q9vuFkSPbdymzKvhogHdRDdYU5laB2cXTnl2KOM53Yu+AIGtVLZs1r32mngFuw1Z3PSoDnIGJUAUduI+VkIqG3PmmatnOfWbduiuyAez1cBy0QcN8q98QfleNSwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440049; c=relaxed/simple;
	bh=1iLInY17sRnF1Bnlfy+Ib9X5BvBkkmir9bArxM2d1H4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/d83HYeP0c4GF0/j+65tQUzXggxl8oUIlvYs5gVYi3sTrJGrizviHfnJCl/5JsgJRPmHVPaGyrE2IR0FNzLaLV41xyH5j8UlgCSaAwf9enB+MAoNgWvTswt7qf3cX8mtrTJk8CnrbPj2hXlqm7xqQcx3J9scKmkkJVfzjnTjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1752D1C3A94;
	Tue,  7 Jul 2026 16:00:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6EAAF2000E;
	Tue,  7 Jul 2026 16:00:43 +0000 (UTC)
Date: Tue, 7 Jul 2026 12:00:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] tracing: Expose tracepoint BTF ids via
 tracefs
Message-ID: <20260707120046.31573548@gandalf.local.home>
In-Reply-To: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k87xr15tbwbuz4jtafu5ec3kdmfycrte
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6EAAF2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TssPEFq94GGqlz+p+9aRp8eeLIFlutH4=
X-HE-Tag: 1783440043-387885
X-HE-Meta: U2FsdGVkX1/Tx9nyManP9zwP+a3L82cJx81X4QDK9XWbb3e8XlhJm0qXPF1os5W79zy/LIkiAsEW8f27ieUKfLPdreBktAOtFsAg8ZPCAjErgfds4BgoppbOxbCr0+CxP3uiRUALSGhPR0xu72VIJiVuj07x7zpA3cFJ+t5VPzl9MG8PDXKAG+7ykiZu6A9DFgrHhwOFZacggrxph8MUe/IVa5QZHyhXD2TLA7aJgnrH9b6g9jiXy+0FRQHNksiQJl9ISNHjYBLuGtGBk8Cm74mhIeSvEEjG/esQkrh4rep5iAUnASGcIKnlmmDc87IKPa9PxRI0DrGF1/2t/AM5wkyLPPGYTDQ7

On Mon, 18 May 2026 08:23:14 -0700
Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:

> BPF and other consumers that want to attach to or decode a generic
> tracepoint need three pieces of BTF information for it:
> 
>   - the BTF of the object that owns the tracepoint's types
>   - the FUNC_PROTO describing the tracepoint arguments (with names),
>     consumed by raw_tp / tp_btf BPF programs
>   - the STRUCT id of trace_event_raw_<call>, the ring-buffer record
>     consumed by classic BPF_PROG_TYPE_TRACEPOINT programs
> 
> Today none of this is easily discoverable from userspace. The kernel
> knows the ids - resolve_btfids fills them in at link time - but
> consumers have to search them by the naming convention
> ("__bpf_trace_<name>", "trace_event_raw_<name>"), walking BTF for
> every tracepoint.

I'll pull this in even though it adds 100K to the kernel:

   text    data     bss     dec     hex filename
40506047        15709518        16661184        72876749        45802cd /tmp/vmlinux.new
40499064        15615294        16661184        72775542        4567776 /tmp/vmlinux.old

-- Steve
