Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF548164B;
	Tue, 14 Jul 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040153; cv=none; b=EYIOQ44973FT3PwI0osoO4hBwNZIj4TD8KUOcL0N7YAMv7TYXicxC/3AhD9MELMXcw+3jhQvJ4raBOxN+YZzfLIbJ5pprBATOo0e595Jhvni3qduFxuBSPYeQMgnl2o9XJO94fG5YtvQ3T7m8rs5EZ8w8NDyC5IDI4k2B5V5yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040153; c=relaxed/simple;
	bh=mHm9R3KOTwsFn1NdFLaHp5sbhcaeCCE81a+NDJfqI0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/Qz5fh7VS1hmpEOKv1IyahmHx6Qu1W2sO/Q6IPvgCGVXWFuAHY5ARGx01b7WID4mmaHwDsTXmuO6gzsFti+r9lAIa50hFNDbWhSCEHpgxoar/cpd2Ixs3RclUBc84HczStIpiW8nVYAD4uMtI7hXIEA1vvnRMvfU50aj13xDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 69010140393;
	Tue, 14 Jul 2026 14:42:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 78A9720026;
	Tue, 14 Jul 2026 14:42:07 +0000 (UTC)
Date: Tue, 14 Jul 2026 10:42:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add test case for a symbol in a
 module without module name
Message-ID: <20260714104210.28cc4c59@gandalf.local.home>
In-Reply-To: <169846405196.88147.17766692778800222203.stgit@devnote2>
References: <169846405196.88147.17766692778800222203.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 78A9720026
X-Stat-Signature: 6d884ojyqk6rb68sgkmt94tr7bgpx5sm
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194o1gPc5+dYaL72hUGj7l1mgnke7VMUIM=
X-HE-Tag: 1784040127-770510
X-HE-Meta: U2FsdGVkX1+LWBmAcrUo+Hpm0cLQeQLI6wfNgSK3PcANbYrsfu4IDsvrMWj+XcgREKav6L4oNkfTPX1xYtGOApfdgkvq+XLGRU7tm3GCTfQW78ti40n2zB9FpJY9fE943LBqOdXlZE2c1YgakHtIIOHGbYWXDG1y1s9baZiH4N4sc6JyNfP+0jcVdrHGf2852yBllV76YLgc3AbQmMxRBCmzqgF0AcmgFl/jpMVUD7YL9YvqWaxfO6d1zbACVobrkZfqbwg6oC5qhfxgDT+K3NcXuDSgY/J7pzSWeelQHgLufaN24NPrcvqB5n9hBE61P6WrB/fKIMZSJxJuKb0je6AERw+S+MUGLPOUe7sLKKuTJpMeDyh9iZvMvP3S1pw9


Is this still a think, or can we remove it from patchwork?

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/169846405196.88147.17766692778800222203.stgit@devnote2/

-- Steve


On Sat, 28 Oct 2023 12:34:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a test case for probing on a symbol in a module without module name.
> When probing on a symbol in a module, ftrace accepts both the syntax that
> <MODNAME>:<SYMBOL> and <SYMBOL>. Current test case only checks the former
> syntax. This adds a test for the latter one.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_module.tc          |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> index 7e74ee11edf9..4b32e1b9a8d3 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> @@ -13,6 +13,12 @@ fi
>  MOD=trace_printk
>  FUNC=trace_printk_irq_work
>  
> +:;: "Add an event on a module function without module name" ;:
> +
> +echo "p:event0 $FUNC" > kprobe_events
> +test -d events/kprobes/event0 || exit_failure
> +echo "-:kprobes/event0" >> kprobe_events
> +
>  :;: "Add an event on a module function without specifying event name" ;:
>  
>  echo "p $MOD:$FUNC" > kprobe_events

