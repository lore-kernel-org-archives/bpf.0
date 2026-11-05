Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868830;
	b=r0267S75VTa9IN2vUdP30c7lWQa0NPrhOVQt3FDoHC8+0Hq+d/Tv6zgBsMsXjTLfcS2C
	 dZUx4ucocm7b/FuuCNlhmw6dnCb2jesEXrj2oTmB4wdzg6zHVy/RYsPAWucnyz0xP6Hik
	 a54ShclXPw/0aexMfQaVO4KdWhz72EpQmou/y9gpXVB0ZoSAf9bd7w3jtrhZAHCfk2pO6
	 p0B2iuETEcwbJo5l8I7AoyUPANZ/ycXbG/eRAmyk9LbpDHEKoSr/vP+pI0bMSRdJjeDcF
	 Nf4ZYBfo9EXjzuZ8mc73Bur2r9ak7Fmsxpgm8Baty5AiBPRT3YqIY4VifAMMI9uFU2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868830;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JrlJYLj0mjRlDUy4l/FwTyaD1m6b5uikZMSnRp6dLRg=;
	b=zS3JoOe4rBSaWPTTZ3gX6q3Br2JxsQIeFYB+URE7noUbPHjeYwozHd0hzSjM4Lb9d9+q
	 lmYPZbR+4wV262z5lEFOwppUDeKJtlyrZG7/aOZmBCSSu2zwseWwwZnpwxrAReVwrOeDT
	 EVNaQv8YT6CdstM/9L8kZV6nbwV0M2b2uIKItUUnzXcjlkrrxkTKU6Y6STI6/B42iTgzH
	 ObILzkPe24Pzb9+NYNwwcyBqw1yMxUk/AZARGgHzhFkJYhsPJJ5SdymsQUFgMuuAgTf6j
	 Q1+U9A0Vbrk5Fw5vamyFI0bT7BB/gIdnCp3UWNKX1WsXz2FUsOGkqgVaXQlIgjUOh4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ktbaXEGE;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AB606A31B;
	Thu,  5 Nov 2026 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ktbaXEGE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JrlJYLj0mjRlDUy4l/FwTyaD1m6b5uikZMSnRp6dLRg=; b=ktbaXEGE9mkH5bmiZvjouRhv8L
	8PYZ4ZfQiWf02b8s2MnuG5FT8xXr9KYjP/EMIAJfTMTCKBHa7pGlXgSzVz5A1RnmsRL3m64kfQpaU
	H0YNyhkqbs8zfKn4L38d9qiNGlXlLyofYhpAQ/jG7ob4bDpgAjynM/vI5K4W0JHy5HRcjw6SdnqdF
	Ldxukar1VZ8zayMD5iBYwDG1NyfKIASnglyzSc2Nm5w0xKlFme0oG967uVZqxXXph7Y4WZJFSzVcD
	qjSo/IOaPquSGmADJZ48tweFW9Kxo/NWkB7haXmK8ZgmkAYe4HRuASYOx6Dq9TPo18ytgJh7EIHmo
	RU/lhqdw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOtE6-00000006RBa-42aY;
	Thu, 05 Nov 2026 08:53:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 873583002F0; Thu, 05 Nov 2026 09:53:42 +0100 (CET)
Date: Thu, 5 Nov 2026 09:53:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin Kelly <martin.kelly@crowdstrike.com>,
	Mike Bazov <mikeba@sentinelone.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let
 preemption cause false recursion drops in trampoline progs
Message-ID: <20261105085342.GQ2668804@noisy.programming.kicks-ass.net>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
 <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
 <DML75890DWIX.EYB690LPBM1O@gmail.com>
 <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
 <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
 <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
 <DMN0USP1E59A.34N710IJOO0PJ@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMN0USP1E59A.34N710IJOO0PJ@gmail.com>

On Thu, Nov 05, 2026 at 05:18:48AM +0000, Alexei Starovoitov wrote:

> pls try _no_resched() as I suggested in the other reply.

Please do not. The only point where you are allowed to use a
_no_resched() is if you then call schedule() right after. Any other use
is broken and *will* be fixed.
