Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FD18024
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674703; cv=none; b=OXHm4vHfL55VoN9VwGOpTYJ8v0xbi+E8cA686DKvxrdTlmokXmC05ootUnEmMd1UOU83QsC1rrkCSAUvODJzp0D/hk8n4Hp0PeRYJtHv80rgAheYIr5hSFy3PbrkQ9XlCZEaSDMdFR3ZzPFa8kRKFFuv5EGbiWdmIO2Ps58HnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674703; c=relaxed/simple;
	bh=2Rv0amrX5ZNYh6GyPXnqsrsqyvGCb7aS5VHg/F6R0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFPrcZX0/NGFF7+5IKa+Kw7u1Cd0QKpzz8WldsUfnKHqMPfmu3EhjmWqpxj13oo0qbPgapXLmX2X801Rc8XA8P1Lk4LOziZUaqthUIhdmZATlZ512M4krSRkJXWIYHgN0COgjRU5oOLLmAkxkpKI4GDnBITzXnLjNVOfH9bhviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqRV6Y6f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqRV6Y6f"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so21895ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 17:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772674702; x=1773279502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Aek6BjF/llfaayaCKaM8S/PWN/ZrFjCmjENXFVe9fo=;
        b=JqRV6Y6fkvH4SYtAZfcXnyxUyQyFLFZAgtDTGfV9crWKTsTxgUq1vnvSumIj3WTqNf
         cpsgqG4VYerYz+HLIGAstprZElMWjChoJnm6TbNOu/6isJcUKWxh44iNtfPj1ihbqS9+
         LoKF1jKsCN1BpSbfCpX5ez0CHzoadJvyZ+cz2ApROyN22w3w0xOg6phq/6ON3f77oP6u
         tqCBoS1m882zCS6DUm80BkxGlC9bAVcDcuazlGFgk0SyRYpfqo6xKyi5Voi4XUzBdS7e
         iggu2GQjmB8KZeP1pTH118dR0LHZkAkKPOLASkKkbokjHBeqqwoTVC+wtJLFcwCfF59O
         xnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772674702; x=1773279502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Aek6BjF/llfaayaCKaM8S/PWN/ZrFjCmjENXFVe9fo=;
        b=PcWJY5IyILfVP/TYvrhTYyvCftU9p2EQlTfvYYPf82FQDwcu2yqqXTvjeY5AzURrbw
         PzaqyETHKjbHC4XsxFiuN2N5SvOxn/eSB4shjxK9gb8NgZ5W7IZKK703tJyvDXoF6Orp
         b5xSYmHgrGf6IWVNrWrM1f1W72jTn6maiZh5Mw8LZjhnhWXjJ65QMeI2XmQsuIa7pcuy
         ygZAjI2x6x57coSDrriyXgCzCwD/PrT25wo2qLQvL27gljXOZwz1tUfEE8MkxyAqXyqX
         Wg4bKfkIAwWCLPk1YiD4E8ymLNFptorAGYkInK9JmEsW2jkzRIinifEeWa2aQ2dOlaLR
         jlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/e8CsbE/jrPFkJuMwfG1ppKV47Pxtry/zXsVNAAq82NiDiX9qJYXMCh73nt2/5JtYF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy830Z64ryQFwNhVgJbJxEf/f+e5wOBuYRisN/IuxOjDhbtab9c
	1z8+UjOX/VqUBkj8pteXOkgYQ4HAR5S+GucQ+fOr8cfIwKkcUdAEFhVY0jqk+E1vhA==
X-Gm-Gg: ATEYQzxNvN6FxtQcJ+CuSV1FZbUh3VuoZPkuhaeog6u6xXg/Gwx2J/mBdjBglXEBmuT
	ueJw0IoIcrf3onCQ/duXCmjqN8sESfa8zYEpFcj9UWkRlkiECB3MV8uzqFigT73gZmkYDPrDbum
	0vCvV6Muo8y/Jl6aumVpL9+gjrKnUXrE5DmXOMeOzBuG0kYBTVjv3fHLTRvwiWibR5R8qAQSYIZ
	oX8stGOkReNTbiQBiQckHtz6veRnowO3aKMz0AsyF2xRX8XGHCl8y7gQMRc3JZYECWCa0O46Uns
	EveJeGGzSrdS6oc70sIM3SJvpX9BbDUz3GmLt55chs3SCB8K1SUeQ5eJ70TxLncrgI9MRPvZ3pY
	J9nRQ2gvzsx5I6NUKAUwJrUUICFstb83BnVgH84MJd5jDjHNvZKpPEfMP35er33ttpfLBjowiOn
	JDpxW9SlHSxG71dwCawdQ1N8mUC+tvuyCrK0Ox+cRM3kROc0csj+kXBzh2YQ==
X-Received: by 2002:a17:902:f609:b0:2ae:57e6:616a with SMTP id d9443c01a7336-2ae74fd4148mr932365ad.2.1772674701356;
        Wed, 04 Mar 2026 17:38:21 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm122684645ad.23.2026.03.04.17.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:38:20 -0800 (PST)
Date: Thu, 5 Mar 2026 01:38:16 +0000
From: Jordan Rife <jrife@google.com>
To: Qing Wang <wangqing7171@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] bpf: Fix use-after-free in __bpf_trace_run()
Message-ID: <xt2wdltgcksndmsizbzhyedshr4qaadmn6pgto76x4kiv7kczh@cobpljlcjttp>
References: <20260304092345.233522-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304092345.233522-1-wangqing7171@gmail.com>

On Wed, Mar 04, 2026 at 05:23:45PM +0800, Qing Wang wrote:
> A use-after-free issue reported from syzbot exists in __bpf_trace_run().
> 
> BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
>     -> struct bpf_prog *prog = link->link.prog;
> 
> The link(struct bpf_raw_tp_link) was freed before accessing
> link->link.prog.
> 
> The root cause is that: When bpf_probe_unregister() is called, tasks may
> have already entered the old tp_probes array (RCU read-side section)
> before rcu_assign_pointer() updates tp->funcs. These tasks can access the
> link through the old array. Without synchronization, the link can be freed
> via call_rcu() after bpf_probe_unregister() in bpf_link_free(), leading to
> use-after-free in __bpf_trace_run().
> 
> CPU 0 (free link)                    CPU 1 (enter old tp probe)
> ─────────────────                    ────────────────────────
> 
>                                      rcu_read_lock()
>                                      old_funcs = tp->funcs
> bpf_raw_tp_link_release()
> bpf_probe_unregister()
> rcu_assign_pointer(tp->funcs, new)
> call_srcu/call_rcu_tasks_trace(old_tp)
> ...
> call_rcu/call_rcu_tasks_trace(&link->rcu, ...)

If CPU 1 is in an RCU read-side section, then call_rcu would wait for
the RCU GP anyway before freeing the link in question.

> (RCU grace period)
> kfree(link)
>                                      __bpf_trace_run(link, ...)
>                                      access link->link.prog
>                                      UAF!
> 
> Fix by calling tracepoint_synchronize_unregister() to ensure all
> in-flight tracepoint callbacks have completed, so the link is no
> longer reachable before it is freed.

It looks like tracepoint_synchronize_unregister() just calls
synchronize_rcu_tasks_trace() and synchronize_rcu(), but it should also
be sufficient to use call_rcu() or call_rcu_tasks_trace() to ensure that
the appopriate grace period elapses for that tracepoint. Is the extra
delay just masking the problem instead of fixing the root cause?

> The issue was introduced by commit d4dfc5700e86 ("bpf:
> pass whole link instead of prog when triggering raw tracepoint"),
> which changed tracepoint callbacks to receive bpf_raw_tp_link pointers
> instead of bpf_prog pointers.

Did you run a bisect?

> Prior to this commit, this issue did not occur because the bpf_prog was
> directly used and protected by reference counting.
> 
> Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")
> Reported-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc
> Tested-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
> Changes in v2:
> - Modified commit message from bpf-ci AI reviewed.
> - Link to v1: https://lore.kernel.org/all/20260304070927.178464-1-wangqing7171@gmail.com/T/
> 
>  kernel/bpf/syscall.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0378e83b4099..dd491bc35027 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3783,6 +3783,13 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
>  
>  	bpf_probe_unregister(raw_tp->btp, raw_tp);
>  	bpf_put_raw_tracepoint(raw_tp->btp);
> +
> +	/*
> +	 * Wait for all in-flight tracepoint callbacks to complete so the
> +	 * link is no longer reachable through tp_probes. This prevents
> +	 * use-after-free in __bpf_trace_run() when a tracepoint fires.
> +	 */
> +	tracepoint_synchronize_unregister();
>  }
>  
>  static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
> -- 
> 2.34.1
> 

Jordan
