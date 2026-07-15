Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440A381B1F;
	Wed, 15 Jul 2026 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080730; cv=none; b=HqI0WHuIE/kn7VHgdu72P/1Bhfs16A28BYK2I00f1etUvyzxc4AWPXnU4DEVo36oxzh0QmRDnSdAspsOcEKMPTzku7KKZwlDHz+d7vD7Y0ScOIAnc0UAg5n44HnLKYi8lhz3UnqDXlBNU5GMbN9F0AtcLRVj/ENCHIeideqPEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080730; c=relaxed/simple;
	bh=YOtyiO7OxqSb0TGMBpRd4dRXDtEOFcTT312kAmCw42w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C5yKx7fbnN82xeVbUqthtD8LiVEtz6XMbhVbBFIuYKFjP1BiTr85jjcZQOCveBHswHi22gOtrsIsgzgpP+gOjuiOCRaPCUOXGlWWml9TUgzCyhCljkoTqblj7YgAHoAEMxZeS/8JR8dJ0nLs+40jH2j4TrUaE9eIT/erYAUCb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO76q4Ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO76q4Ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377A21F000E9;
	Wed, 15 Jul 2026 01:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080729;
	bh=cSLs5Kao3oKAx4FSyWlx7rK0pyi01ywYmA2Ww4Xd+3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nO76q4FfwycF46nmYRsH0+ctIgJp6gJ5icL/o8z3+HLSmp03/u9OA1vCLEHvHkhQv
	 CKZLgU7haefv8mxy9tZPqdoMd22kHJBDaquZTjQR6TxJug9dpT3M/GDNphv0UXUq9v
	 fjtacTX3NfGgdAs22kwHBjN8i8ecRDHFaeRarHPUOSnPGinj44PKjmVTBD8kYImof8
	 sDcYgYiAgIj8706pgVYC/bIGIJojvHxR+2g9Agbpi9mBk1ur7b0WL008L1egp4mQ8a
	 z1sGKwhVko2jKPdwoqav4OlofSdZZr4V7LzNoHVItG35fCfGg8/VBm5SGmd4puFSag
	 GtKjtdlIhqgwg==
Date: Wed, 15 Jul 2026 10:58:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add test case for a symbol in a
 module without module name
Message-Id: <20260715105844.9d2e139ece02aa86468b47c2@kernel.org>
In-Reply-To: <20260714104210.28cc4c59@gandalf.local.home>
References: <169846405196.88147.17766692778800222203.stgit@devnote2>
	<20260714104210.28cc4c59@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

OK, this seems good to me, and tested. Let me pick it to probes/for-next.

Thanks!

On Tue, 14 Jul 2026 10:42:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Is this still a think, or can we remove it from patchwork?
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/patch/169846405196.88147.17766692778800222203.stgit@devnote2/
> 
> -- Steve
> 
> 
> On Sat, 28 Oct 2023 12:34:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a test case for probing on a symbol in a module without module name.
> > When probing on a symbol in a module, ftrace accepts both the syntax that
> > <MODNAME>:<SYMBOL> and <SYMBOL>. Current test case only checks the former
> > syntax. This adds a test for the latter one.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  .../ftrace/test.d/kprobe/kprobe_module.tc          |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > index 7e74ee11edf9..4b32e1b9a8d3 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > @@ -13,6 +13,12 @@ fi
> >  MOD=trace_printk
> >  FUNC=trace_printk_irq_work
> >  
> > +:;: "Add an event on a module function without module name" ;:
> > +
> > +echo "p:event0 $FUNC" > kprobe_events
> > +test -d events/kprobes/event0 || exit_failure
> > +echo "-:kprobes/event0" >> kprobe_events
> > +
> >  :;: "Add an event on a module function without specifying event name" ;:
> >  
> >  echo "p $MOD:$FUNC" > kprobe_events
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
