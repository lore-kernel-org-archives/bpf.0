Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD93B840E
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718634; cv=pass; b=onyg7BKIi2EF/vnWEzqlgq+AUx/eFkYUozSYR9eSnpEzhfCZI8FbaFCQk6QW8qDZY/yFHlwuoOTeZZXckUVCSifkKrL/S16719hZrsvG6wbee4ck8j532qBpxifiYQLOEeKHyS653FNtfPKLAQXi7LXxl7sSl1J9sbysaAQziIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718634; c=relaxed/simple;
	bh=ZffsXEKRzy6BPrYFDZBFjLeefjvojwkwyzHgCSgBeJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByDxLH79LjsL3vZX7sfmQDceWMgt+03FtVceCtYPqMwiozI4pKJM9DRoVyaOt8XFQGYuu3GYfNlXR0DYWwlZ8xOVYFUH1ijWMrCWfnU+UUnno6Dh4dJkf5DBJ7iaK5Q8c6CO0fR4+HPWgyWQIz6wUFht7ma0L1CHqsOR/beeKxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfiEZkVR; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfiEZkVR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38101f85591so1875695a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718632; cv=none;
        d=google.com; s=arc-20260327;
        b=LZJqg0lmu/BzToHpZ4ESxikH9nHakFMon5iP+SrdWtk3Yy5+fSoorAp65UKDvzGTCq
         bunPgw7yjjWQzGKGECcM7MAiOClqxNI6Ek2uvo0GPbROnkbIyoITfqCe057jXuSt2OfS
         Bovs78KnvNjT8YkUGuWVjEUPEhJQdjcEhbBH8blRKRHZ6kZdyX7lqEB2IoBBtKUx9s2F
         14xpsKh8zu54WLt9xe6Ddxbc5G2B40gSwo3keajdDgN9XLE0P/OvuB5Wb5VloDGcpc2w
         pEVswtgnVK0H0PKZxj4Sdz1ZK3kEv7Hsxx7EcvXnOUGjR/CBwMUozVTQmhkgXvGeTxN9
         bZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        fh=16zXCooJbldFWjG80Gpr1DVo0Lmk44gk4UkvJGtyy+s=;
        b=CT+QRDWvM3BpyRmGvTzGLU/eGqA0qGVxY2hY9myLMSupx/0//IgH9nxyG233dqrkko
         n1vuMcL1LteiwZQNCwLFSSTWs6JV/6WfXO8pPQVyNX+opxrIZbjmPdnyy/MFEqMo99Vv
         R3wyHF+EE6ZF6s8VVj30/7PJ8L6KJZrJcM3+Wfn00WVBDT4h9244fsbzICKifJQIRXWL
         OhY6WIT5QSSvGMwvxjhKI6PnK20/z7pPKR50BudaJ5fbmgqExXSdwzhhvqa3/emriQzZ
         4UBGQimlBfg8NQzaPseXAO3x1gXSGV0hTR+SHvYx7rDA4QSNlxpazwME4VYvOtF5xd/t
         8t7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718632; x=1784323432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=gfiEZkVRkxY3zvcQlPbas/3Cycw47n3fcFyJ5mfu46UrrgcTvkI0356jgCEZcaZafW
         X6cbSUJanZS0Mo6YOChyU/8CzukJyrdbK3RXgTB3KdWymKLh2qd67PwMA3WpUcZFIW10
         r6wgLSZ8WUnZACqQ8DlT2qkuqJSTPx1a/HQ0pI4+wbP48h1SofJJoDlHNaEiGr+1iRpp
         oSALXPlMh62CoSf+dubbQCWTGgAZMRWYEEfE+hs9vLnezx0k6tktUQL31TPkHk/465HC
         I7VEdO3fKkg/syWpwHvbBCjr2Ykni/j2Zgp9pmCrXJssapi1k2eceXGm5OYVZMRwLIcE
         ioQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718632; x=1784323432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=gdyPRjT0subYtT1DWRb3oDH342pFf0sa+zX/8BCWrPg/p7wHMBdn4QgidjrpLu6ONq
         Qfd77vtx75o489VOrz1zppKWMJsnga67KdPPH74AzyrQVne+VlbWu9vyY+Xw1DPjGuR5
         MN7lK2J7cQwyeUZRDpxi3Yje5NNRLKQhGE9uieaS8NDFuwPhY31wFmXNfyGNAadIQyc8
         S45A8MChyHs7gBckRcd31x32FosEAgGf5LDdAujNpT8ekJzy52DCbGQbEBiQ+8LQ1wn6
         n6ZHr6ulfuenuw9msoi1Ep0O4mQBRfkf4nI6W/3ygcLP5nuD9UpWlviwlUa4kBlOFqXO
         ciXg==
X-Forwarded-Encrypted: i=1; AHgh+Rpvmr3aXzB1WyBz9o53GhjHBY7JXcEMIuTGA8PlZ5XN8RY96SKpoyI8C61TRzrW4m/uMfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxNrsHHHpXpgJlXjlZp6AKQP/LK9iEycRygTiiurya2/OlP/w
	MgR7mP3NLTELi/DvgwKE3z6v12llfkVI5meJCBzu/JKCStKwUNIeQ7UDOTh/z0QOAgaSPM0VorT
	FWcpVQ9zmBvxuT+4Yi1v+bElgF7ySU1U=
X-Gm-Gg: AfdE7cn2JDupQC4wKABRDdbeRWXem3/Ht/NZCVhcSKJ5TTv3E5xAO5csGQByLM+ayaJ
	bFxVmTZFxqvjJCMAdrV9eJDxlDabJ4PUgK5+Qu6rwWUNu0iUx3S+vps1xjFupZwprgWTf7r93At
	/5G/39TNaeD5I68xhPlzikpt8pYPQ3KTMAjwSd1TfYyY7hVA3cAX8aRSwb64aeHG1M2VqF2zKOP
	Cvi0qQqVCEhkcO29WUZq1KPUYzaZm/XJabaH+dIEVbiQkfF0K4hNu/AeuOgWPfZFIo5UNJXK5Y2
	rKmeEFppDWwO43y3cy3qYd86kqRNSz9fGYPI2PAZ3t36eMEKLTd5FQ==
X-Received: by 2002:a17:90b:5903:b0:37f:9e21:91d8 with SMTP id
 98e67ed59e1d1-38dc834de8fmr359486a91.15.1783718632544; Fri, 10 Jul 2026
 14:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:23:39 -0700
X-Gm-Features: AVVi8CeESE7KrO4SofyyKXRIq0UuNC-RWDudhRYzrwkmSGZKKMPllM8AreG8cCk
Message-ID: <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> uretprobes_srcu currently uses normal SRCU, which issues
> two smp_mb() per read lock/unlock pair. This overhead is
> paid on every uretprobe hit.
>
> Switch to SRCU-fast-updown, which eliminates the per-reader
> memory barriers by moving the ordering cost to the
> grace-period side (synchronize_rcu() instead of smp_mb()).
> This is acceptable because grace periods (uprobe
> unregistration) are infrequent compared to reader-side
> uretprobe hits.
>
> The updown flavor is required because the SRCU read lock is
> taken in prepare_uretprobe() when a return instance is
> created and is held until that return instance is finalized.
> The traced thread returns to user space in between, so the
> lock is inherently released in a different context from
> where it was acquired: on the normal return path via
> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> ri_timer() (expiry) or dup_utask() (fork) via
> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> are designed for this acquire-here / release-elsewhere
> pattern and, unlike the same-context srcu_read_lock_fast()
> variant, do not carry the lockdep read-side tracking that
> would warn on it.
>
> The short, same-context SRCU sections in ri_timer() and
> dup_utask() (which guard the uprobe against reuse across the
> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> for proper lockdep coverage.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++--
>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>

Very straightforward replacement and will improve performance, thanks!
LGTM. Peter or Mingo, I assume you guys will want to route this
through your tip tree, right?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
