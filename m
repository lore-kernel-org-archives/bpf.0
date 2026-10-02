Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC030C617;
	Fri,  2 Oct 2026 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901784; cv=none; b=cpTu64rWZ9s4JNwhklJ9jLCaSOuYHYyJg2lwDFFWnLWgS8QmgSXyGIQHVpFM/uuc/8q8Cfi9ThBHHg1mKT5zf8q+WcBsSvY4EtZimx72DYQPxNnLaq7843xVkQDiWpG2fOCSWibG2z+U7HiL6aUJp9OrCyjRZJvjL1Hr8CgMKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901784; c=relaxed/simple;
	bh=abQ+JO9hruGWn6WaF1OiSdjhYYc9dFsLWxfOLDtBe/4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qCH/j2ccMQheWNfyvALWSXuLaBUZJxFEA27fih7c2u+XeuPoU/TMZicgcrLhH2Ysv8vVDynoZ6sM3SJb5NbRP5JIgsGEerTcYWDDKawbuTNuok5DzNTjn1LwDu6RaP+67kLbslkxU7hz0n7M3XJ9XBXBPDa8NL1GE5vHi9kmGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a72UDrm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a72UDrm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6411F00893;
	Fri,  2 Oct 2026 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901780;
	bh=+IVQat6jMa0Qb32XqDWrtVJ0Z4xKJddQ/YKBar6myOo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a72UDrm8jV5IT7cr7OLdW/C3tKv28jvFT5+GnQdZmIsObEqXGUznmisw7XaIB2DL7
	 QjBQSNfRNDoIomO1nlRmDON8NpjrJ3A3Jb78NrxEzpkRSNPJmO7C8f8Kl+fQ5EceNz
	 XOpZI001TZKCwNcmCA0044b0SDU89ObTVaJPxiJuiuf2KWEpwDKOL6rGoIMUU2TxkR
	 5yFJqiKFlYDIN4E5QhD3JNXYQL18gl2tETruuTKqgFAft2jeVJiU4Qw/DkXVIbhmx3
	 vZ+Y38UbnkgKaWzC7g+pxV05fANoDxvHD2tgYGaKPBQ7A+Lb3jdOc6tauj0t7+hLhX
	 4xM3XUjOLgmVA==
Content-Type: multipart/mixed; boundary="===============4267361010074826107=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc804b8da940cc0dab648ec1bec497c3e1097999c1a7a2cea204896c3cd7fd3d@mail.kernel.org>
In-Reply-To: <20261001152042.124445-2-gmonaco@redhat.com>
References: <20261001152042.124445-2-gmonaco@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mingo@redhat.com,peterz@infradead.org
Cc: namcao@linutronix.de,kprateek.nayak@amd.com,gmonaco@redhat.com,alexei.starovoitov@gmail.com,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:42:59 +0000 (UTC)

--===============4267361010074826107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched: Add task enqueue/dequeue trace points

TL;DR: Commit message only: the changelog just restates the diff and doesn't
explain why the new sched_enqueue/sched_dequeue tracepoints are needed, a
question Peter Zijlstra raised on v2 that went unanswered.

>     sched: Add task enqueue/dequeue trace points
>
>     Add trace points into enqueue_task() and dequeue_task().
>
>     Signed-off-by: Nam Cao <namcao@linutronix.de>
>     Suggested-by: Peter Zijlstra <peterz@infradead.org>
>     Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>     Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
>     Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Peter Zijlstra asked about the rationale for these tracepoints in the v2
thread:

  "As is I'm clueless as to why we want this, since the Changelog also
  offers none."

  https://lore.kernel.org/all/20261001154934.GT88198@noisy.programming.kicks-ass.net/

No reply was found in the archive, and the changelog above still consists of
the single sentence restating the diff.

Could the changelog explain why the sched_enqueue and sched_dequeue
tracepoints are needed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============4267361010074826107==--
