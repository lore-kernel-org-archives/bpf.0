Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A8387348;
	Wed, 15 Jul 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080510; cv=none; b=hfDmczNYu8cO+tVGRlOVCkQ1l5OyoAJWvgPZgESMRZsy90AlUYtu3HYIj2M47w/3lUs+hy7JYZ1kXDrs/XDns8Ni7scVMJHw0v65G4nvT8EriEEV73oDs7OU4LVzvNOgIFrnzRg4L1zd0jaISohZjrFD7kf+4CWjyAFzjVVHdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080510; c=relaxed/simple;
	bh=ZAFgEZSm0P2dS3532tmTHnyAoYVg+4XupTImuJXj3JA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kb687atgGTWzxTedUe0lYR06faeW1WtssC0kZYzBBphW7Lv/hb5GYcg9DzesRw18xiZgnAi2MVZLVKfxkq2roFiHaKLRmFLqnei/HQttCOyySMg6yR0z49kiOBzUPBv9rxMD/FA2Jd47PmsT/1TGIqUZiQXNbPvmvY4jmEICmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8MEP1Lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8MEP1Lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB6D1F000E9;
	Wed, 15 Jul 2026 01:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080509;
	bh=eFmbCdDlULb9hkByxB37nmiCBfWhMNDBwbxTccYr5vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j8MEP1LxGo9h9CDj5rd2vT44ekEyAJXM8R6uOdx+eBSHYhG3nIhWZxPhamJDQ86rq
	 ZpYTlSpRDn0wtQyQE0WkMepUP8qcEyEzlw8Mfk+AmS26CWjI2r+PlYcpdpE4ocwp2C
	 c1bKQkgaeZ1u83E4UyJS/aIwDir4OCRBXYhrWK1JhM97VmDhh3qcfw2DC0HIu3aVny
	 Q2DFaC/zSGX4ulwYEEU6LLAi4sBDirymxHsDol0c0MqFB3537gn0/gzWx9oVPqJoDT
	 wfQ1XgopJcyJL1UuWB3OtV9g856ST2oQ3m3c4qbmADRwKS6ggQJHOqDYU5aG56d0IB
	 7NOrsZubymUFw==
Date: Wed, 15 Jul 2026 10:55:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add test case for a symbol in a
 module without module name
Message-Id: <20260715105505.7fa8488621ec59c154edc082@kernel.org>
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

On Tue, 14 Jul 2026 10:42:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Is this still a think, or can we remove it from patchwork?
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/patch/169846405196.88147.17766692778800222203.stgit@devnote2/

Oops, thanks for reminding. Let me check.

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
