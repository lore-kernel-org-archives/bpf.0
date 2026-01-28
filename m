Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1845238159;
	Wed, 28 Jan 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611694; cv=none; b=Nho+2kazduiu0UW6UQ6RKrQbILG0oepRQzMl7ww5YwXikYjukypmrQxK90iFJvODlxiWpWAEzsHyuU8xvU2h5qibtvhVmrO5pjSgPT6V8Ep8Y0GLdu1gbmAPQFn9YEiI4BBk3t0cKK7g3pXcEd0zCenJeRoYzCOF2qZsS+bs4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611694; c=relaxed/simple;
	bh=m2NFIt+B2FSUkKuThAjS+VA07lWrNORrRSvzgZb2hA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1UVtGwHhG3BdZl1G2CkIB9opafKLSDqmkLjIS9fq5nf8aoF3iuil+v1vY7mNS0XpMwPjiQ0FVIfWqelJVkovlLY0utue0FQocBiu6wRdanqcLZiXAIdD6hR4ElJznznSNWdWSrPEdnDVkQmdACSBxo6AMaQNZXiOoQvcooAg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbNKi0oa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbNKi0oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7825DC4CEF1;
	Wed, 28 Jan 2026 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769611693;
	bh=m2NFIt+B2FSUkKuThAjS+VA07lWrNORrRSvzgZb2hA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VbNKi0oaGSSePL5TN6ePUN/kffAfuRRguuyN+pbWGQtCtjAzyeLM6rscyDA7d/vZO
	 giZnyq5mTVpKBQBXA2VfOZXlpbj2NL3aYhPeBP9rnPYlg1zarjIa2RC4pC6+cnWGiu
	 EgT3OqsG5qnPpsFih+kXjdvFxYxvIsDFfNciQYI22Q6HAj8r43hp5qq3aRxe4oeM2R
	 Dn5kbfgM0PDWfIQFTdL/RlmfmdJdEYsE8GJ2bbtBOfvKlRfIb7OLaJDeT1LMxsmw0H
	 akVEdFzAcOTfDMf1RjWsuDTVhP6VZFR4tnA+RSo5Vv+MUGBBR8k5mO2GtN0mGoAMmE
	 XBRPVtcy62mIw==
Date: Wed, 28 Jan 2026 09:48:20 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for
 bpf trampolines
Message-ID: <20260128094820.0d32327f@gandalf.local.home>
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 15:50:01 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Jiri Olsa (9):
>       ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
>       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
>       ftrace: Export some of hash related functions
>       ftrace: Add update_ftrace_direct_add function
>       ftrace: Add update_ftrace_direct_del function
>       ftrace: Add update_ftrace_direct_mod function
>       bpf: Add trampoline ip hash table
>       ftrace: Factor ftrace_ops ops_func interface
>       bpf,x86: Use single ftrace_ops for direct calls

I reviewed all the above patches with the exception of patch 7 (which was
BPF only). I even ran the entire set through my internal tests and they
passed.

I don't have anything for this merge window that will conflict with this
series, so if you want to push it through the BPF tree, feel free to do so.

For patches 1-6,8,9:

  Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
