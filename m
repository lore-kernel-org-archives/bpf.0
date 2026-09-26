Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F9372EE2
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452794; cv=none; b=h1JKsq+YS65rUbqa8sEWmikcXauXSjq6xEkg81HV7cCC/bZoqtT/CBZ0Lu8bxWdEFZZt/UdibWPnBgfIZBkKQ8zDZZj1Z0QT9blxJkxeuww5JOAxKYzk1hXyAato5NM4SH1PthAhpp5OR9w652WpkkEMSS3qFzXVbO6BIUE2HwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452794; c=relaxed/simple;
	bh=HzNmH8R9uYX5EFWSG6TcW0x9M/6HxIqHAAxtZ8YmT1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgsnVRs/vk0QUtaKig7MyPxVb/qeAwZFGdmJaXcHn4S3JMTerWQB+LLkbg9VRShyOM/XSWOxPVpaG/lHVoHe6Qe4WWcxNvnumWES+X5U6/DwGtinNP1VD8TM/+OuUez3i8CYzDdzgvti3yyMfWTu87tB/8+zg8EOXr7ddcuFQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFmERzFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFmERzFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137CF1F000FF;
	Sat, 26 Sep 2026 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790452792;
	bh=Ylfd2zgz6GoR7nF0XQYIVfzRHvnv2BWrzlkCfNXY4Vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LFmERzFXh8o7Ho8yQU425jYu9YgDbLQcczVLBFEPjJvsDiVncE2MOcUj3gQBUPhh8
	 mV6/+5erpqarXs1yiKuf6J1Odb1c+rmjGU+NEOiCVu3FU5F12A0zmWGEYroNzLID8D
	 CI9ryoeDr9cbOUrqoZGr7p+o8eEEqg5eibnAA8FY4T1fhgWmqPNbZrB+yg2PQowNZt
	 hfI9Zs3miH0+OA0HyGJymVyUqSh7wlKaI8SHe+MOfJ8tGmYIazyaqdGd1BL3WfUcd9
	 GHpyG/UwmDqlH0g/FMblYK9Q18V5dBtNTvLzE9tEIVrr4Q4bAGEMjFFvweQxxsNPYP
	 lTucs00nn82pw==
Message-ID: <1adb4619-4855-480a-9739-851eab36f900@kernel.org>
Date: Sat, 26 Sep 2026 20:59:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Exit from the stream wait signal
 handler with _exit()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260926154515.191689-1-memxor@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260926154515.191689-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-26 17:45 UTC+0200 ~ Kumar Kartikeya Dwivedi <memxor@gmail.com>
> bpftool prog tracelog -w ends from its SIGINT, SIGHUP and SIGTERM handler,
> which calls exit(). exit() is not async-signal-safe: it runs atexit
> handlers and flushes stdio streams, and the signal may land while the read
> loop is inside fwrite() or fflush() on the stream being flushed. Whether
> that deadlocks or flushes a half-updated buffer depends on the C library.
> 
> Call _exit() instead. The loop flushes every chunk as soon as it is
> printed, so the stdio buffer is empty except while a chunk is being
> written, and skipping the exit-time flush loses nothing.
> 
> While here, note in the manual page that opening a stream as a file
> descriptor arrives in Linux 7.4, and restrict the -w/--wait description to
> the stdout/stderr form of the tracelog command, since the trace pipe form
> does not take the option.
> 
> Link: https://lore.kernel.org/bpf/d64c6402-175f-4ea6-be6d-1a544a95c97c@qmon.net
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks for the follow-up!

Acked-by: Quentin Monnet <qmo@kernel.org>
