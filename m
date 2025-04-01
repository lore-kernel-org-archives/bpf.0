Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AC20F076;
	Tue,  1 Apr 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543197; cv=none; b=jWhphUAxR68oja+rswE7Q3Fa/Ym+a1RzRrtnvNfA5efIvSAKOkARcsf6KQ9d3jWo/GWeJ3KRdqJYAB9+FnAjc+pZBcNg8dNZDztZZKrTTxi2l2muEz4OkCZXw4BXJjZ35eCgCHERuCzc9sfBWLo2PKs+AjVENfwTh6hQRs+sELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543197; c=relaxed/simple;
	bh=kTSm0TvgXhQ2yyhmVqFkKcV9aTRY7zcrGSvLR1DWT8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwbCcKRU42UUhn7wuI1UwfjEgm9zu2hLNbJTnUVRJcxkVBHAm1c18QoRLM/wZf+KisDK8GX/HW312+DKhretP6U80pVcwdfbt7Be+AQ6GucJnto3avCYNuBzufUukA0l4a8WAavIeeXcYONd5Iuzy3KiCSYAMab772AXECh2lxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858EFC4CEE4;
	Tue,  1 Apr 2025 21:33:15 +0000 (UTC)
Date: Tue, 1 Apr 2025 17:34:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
 mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, oleg@redhat.com,
 brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <20250401173416.45a164c8@gandalf.local.home>
In-Reply-To: <20250401173249.42d43a28@gandalf.local.home>
References: <20250401184021.2591443-1-andrii@kernel.org>
	<20250401173249.42d43a28@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 17:32:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> static void exit_mm(void)
> {
> 	struct mm_struct *mm = current->mm;
> 
> 	exit_mm_release(current, mm);
> 	trace_exit_mm(mm);
> 
> ??

That should have been:

static void exit_mm(void)
{
	struct mm_struct *mm = current->mm;

	trace_exit_mm(mm);
	exit_mm_release(current, mm);

-- Steve
