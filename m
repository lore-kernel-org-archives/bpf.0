Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201E3D75D0;
	Wed,  4 Mar 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647539; cv=none; b=Q7e1q4NurKL7T/Cgkt0Aq8uqN8bEd2R8JZHi8WOswcpK10KfSZN8KnvqAo8P5uiePyueWPVQrJnmxdcRVEAxDd9iTOU1wmqaN4jn8jCtRAqZcwli3AQCXLDs2rWFsxoXt1/RkPGZkDqxvmFt23+TL1tVzL0MhwCD1z7Zi9NuyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647539; c=relaxed/simple;
	bh=voEjdAsVr7S1fnWJGFW20uZXPtY1D1TtFiLsd+AhlqE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GUDBMBg7JWjc+bjhVJGnl5o8xpvL6rKa+8oU9GuKF3yZM0BHDnYdsCW1EFPdscx/3+GdpqGfxjIPGFUTwDHQCr9ufk7CvN+8g87mFVp9HPy4QtvPaKPC2B91wEmq00wJs49yGaHEUOp8CNlQ+yIpW6nkjFqWK4mhuWGpXuyuHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEC8NBWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEC8NBWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB10C4CEF7;
	Wed,  4 Mar 2026 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772647539;
	bh=voEjdAsVr7S1fnWJGFW20uZXPtY1D1TtFiLsd+AhlqE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QEC8NBWGW++3MQooe3Q9LhshPG+6xCQhhR4jn4aGFpH9+7NorZKvWvkDnoBJzpxAU
	 K48C0JzP+jGW/PFPYLUaCsd4sqPUmeoDC6Ysc4OM32Yt8eT88Qioxk/DGbj64fZlAV
	 DQGPemxX5VhGkmubeH35XudqqG/SUYaf1EQRNP7RUqHYS8hRItKVtVeEwSFOQh5OBn
	 k1sykuO2p4RYj5+SbgS4QN44L9mkpmpSZp62mQdbXjU0ibXpZhSWLJt27wa9Ent7ms
	 lk85+Z0x9bw3fue32LHEcqhy9fwZIXFF1E4N8JhEzt7gkIro7oVOrnAoXjGbnTstDX
	 l6hmB6ybYMQJg==
Date: Wed, 04 Mar 2026 10:05:37 -0800
From: Kees Cook <kees@kernel.org>
To: Max Ver <dudududumaxver@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
CC: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>
Subject: Re: Process killed by seccomp looks live by tracer
User-Agent: K-9 Mail for Android
In-Reply-To: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
Message-ID: <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 4, 2026 2:51:38 AM PST, Max Ver <dudududumaxver@gmail=2Ecom> wrot=
e:
>I was using ptrace to trace a tracee status, using
>`PTRACE_GET_SYSCALL_INFO` and `PTRACE_SYSCALL`
>to get its syscall arguments and results=2E When a tracee killed by its
>seccomp, the tracer can't know immediately,
>instead, the `PTRACE_GET_SYSCALL_INFO` tell tracer that tracee exit
>with no error=2E The syscall wasn't actually
>executed, it was captured by seccomp, even the tracee was killed by secco=
mp=2E
>
>Here is a poc explaining what I said=2E
>I was expecting to aware the death of tracee at the fourth
>`PTRACE_GET_SYSCALL_INFO`,
>at least `PTRACE_GET_SYSCALL_INFO` should tell that the syscall
>failed, or get some different message from waitpid=2E
>But the result are below=2E Tracer can only get the death of tracee at
>the fifth loop=2E

This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before secco=
mp filtering has run=2E

--=20
Kees Cook
