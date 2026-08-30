Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6263914FF
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086152; cv=none; b=Mpnxbs5Lypw9Mm5bR4wqXtcaLQvQBk8UZhO6eiW5WFht+5weoSvuvwbn8s73UQem/k+7ZK1y6zjp5CSpGBxbpRo8Gn5bNtBLAmdejZD0J1Aegnpz8ef9wgS/271CxYJSYhtkMfY/LAs1Jek0QAwQPrx7m0MFM5UTM7IkqwwQ+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086152; c=relaxed/simple;
	bh=mwcZsLuMYci9PKbmBJMAaQC9ja30VTEQr7/HoNw89So=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T3onIpWEIL1+XnFRe2ZjbrVbw9Jss4sUeW41gsgL7LrckW30zdBW73rJqhbwBy6OoNpE6o+JWMJbQ/MrdHH8SpMoZguE8PHAlxaJ8FznthhPTL01lsJvsmGvPnqOfRciL7H2K/O3WoSjEiSWxqJlCJEcbA0oaizN4U8mVP0mAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brgYDwi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brgYDwi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CFE1F000E9;
	Sun, 30 Aug 2026 10:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788086151;
	bh=DR+7N/PCjsDrpQXp36li3eU502A4UHVYut7Nb6ypZqU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=brgYDwi+Q5i3YbgFrTGxxpIoO8X9z2UGMZH6qP6Blukp+cNIQkkEdiZdnbhY19xzg
	 zvXXNnhmmQcoeWAEhDfr4paAY9mASOwMH1zuehTUJEd5Ye87f7m0DiIEtgvzqyUUr4
	 01a/Ze++lhEJ+45VJDheUvGamfeJQI+/RosWuaqsZWCmQgk5XBZKkxxlNs/R2Yhf/F
	 gtanpMMdTY0McWFWaiSW1QI5MljDlAFsdnqzNWdYo2aFom4C+/KsvaEb8J2gA+jy1H
	 Rg9uTyYVUUXLSHphfH/m/Jf1rZfX9xRgUs0SphqnUEvWZmXZpBARPg2HirhtBDFgUP
	 3AtrLB+zBhJWA==
Content-Type: multipart/mixed; boundary="===============2394421880690157074=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cad8278d8ce58c68a22229dbc945c5e458e9c7a8588d5acde2381bfd598096f2@mail.kernel.org>
In-Reply-To: <20260830093514.4105972-6-memxor@gmail.com>
References: <20260830093514.4105972-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpftool: Read program streams through file descriptors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 10:35:50 +0000 (UTC)

--===============2394421880690157074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a92..6b43cb43b27ed 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1125,14 +1125,27 @@ prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
>  	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
>  	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
>  	char buf[512];
> -	int ret;
> -
> -	ret = 0;
> -	do {
> -		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
> -		if (ret > 0)
> -			fwrite(buf, sizeof(buf[0]), ret, file);
> -	} while (ret > 0);
> +	int fd, ret;
> +
> +	fd = bpf_prog_stream_open(prog_fd, stream_id, NULL);
> +	if (fd == -EINVAL) {

[ ... ]

> +	} else {
> +		if (fd < 0)
> +			return -1;
> +		do {
> +			ret = read(fd, buf, sizeof(buf));
> +			if (ret > 0) {
> +				fwrite(buf, sizeof(buf[0]), ret, file);
> +				fflush(file);
> +			}
> +		} while (ret > 0);
> +		close(fd);
> +	}
>
>  	fflush(file);
>  	return ret ? -1 : 0;

Can bpftool prog tracelog stdout|stderr PROG terminate normally under
the new blocking descriptor path?

The loop exits when read(fd, ...) returns <= 0. Looking at
kernel/bpf/stream.c in bpf_stream_file_read(), read() returns 0 only
when READ_ONCE(stream->dead) is true:

    ret = bpf_stream_read(stream, buf, len);
    if (ret)
            return ret;
    if (READ_ONCE(stream->dead))
            return 0;
    if (file->f_flags & O_NONBLOCK)
            return -EAGAIN;
    ret = wait_event_interruptible(stream->waitq, ...);

stream->dead is set only by bpf_prog_stream_free(), which is reached
from __bpf_prog_free() when the last program reference is dropped.

prog_tracelog_stream() is called from do_tracelog_any(), which obtains
prog_fd = prog_parse_fd(&argc, &argv) and passes it without ever
closing it. This means bpftool holds the program reference for the
entire call, so the program cannot be freed while
prog_tracelog_stream() is running.

Consequently read() never returns 0 and the do/while loop has no
reachable normal exit. The close(fd) and return are only reachable via
a read() error (like EINTR), in which case the command exits with
failure (-1) instead of 0.

Before this commit, the same command drained the buffered bytes with
BPF_PROG_STREAM_READ_BY_FD and exited 0. After it, on any kernel that
implements BPF_PROG_STREAM_OPEN, the command blocks indefinitely and
must be killed by a signal. This breaks scripts and CI jobs that expect
the command to exit after draining current output. The behavior change
is also undocumented in tools/bpf/bpftool/Documentation/bpftool-prog.rst.

Should the follow behavior be opt-in (e.g. a --follow flag that passes
BPF_F_STREAM_NONBLOCK by default), so the existing invocation keeps
working? If the blocking behavior is intended, should
prog_tracelog_stream() install signal handlers that exit cleanly, like
do_tracelog() does in tools/bpf/bpftool/tracelog.c?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33304989971
--===============2394421880690157074==--
