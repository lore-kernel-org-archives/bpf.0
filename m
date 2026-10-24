Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858435;
	b=gnDdHvaNHpNcPG+0zGkcrEgPjQ96uDl9374LlQCJ0Ht9xBdUQ9LZqX53hHysxxfz68tG
	 +SuNvMXRidwSISp1aiEwQ1yY/L74HpuSSBCL2cAklgSCTqBQScCEGCS88MXpyUwW9m1uJ
	 0dQboX2nOl6PuwarILffDpNuhaXJ7QyZwyUx9DfOUf5NKTGNJBetTaDOT7SwhQfi8c1I5
	 8GQiKbYhi0viuE87QcyHn4qrMU+nFyeCgugfMoeovcDP38fZIIi1Dlpwhct4YV2z8hMZd
	 BKg2BUI1aClyeMoWW4cWfAm80xujcRtH5ITDgjLF3KMoG+dnp1KnmyJilYhtI2dMwDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858435;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eeGNDc7Gp5QkYFlacZc3KSHWEUMO5Xnrm8+LooKEisU=;
	b=H+7KIQpyPbz+5xby3OpOEpEXRoKXIc3A9krO+Xa+3KcEe0aX4NNCY/eLYBdCDNNGgSb8
	 8Bd48X8Dp0Qn/l2sCR5y7UTdNyxH94NxwRcxbrU+c8p6hdBAbJwQgy68jVT8g/LKd1KZs
	 ZeMNf5AORM8taKVy8ZVr/Bglb+9nYy77MZitFC2hvH1ykJthAVsrWdm+InnPPKS9sNjBe
	 8X1Im1SlNvPENHAxKyg7YRkk6dXxpjLMq1L/BuqDRjTPNrWfLK5xmmKYfl4XL5reVYBE8
	 28ES77GxnTsRKwXu7R4/DGbv9rKxDpLvWdDSxB1ByIzkS442tTzSOmIJEIHnrDl93+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xma7QGBQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A0606A324;
	Sat, 24 Oct 2026 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xma7QGBQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334FC1F031E4;
	Sat, 24 Oct 2026 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792858434;
	bh=eeGNDc7Gp5QkYFlacZc3KSHWEUMO5Xnrm8+LooKEisU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xma7QGBQyAgwHWDYWV3+P8zOSxsxqKHKR9c4Vt6q5XxZ6ASA4361JvuRcLdgL2CWV
	 jS4ScjMm4DIeWbuagC66YxIPPt9O6/7DVcDmpGZTxBQ11X139mhVLDA0aAHPczXh2q
	 Y48eBIxOte8U+ePaMIrgsKHbx7HZHDCGHQqxkePJ1bo58KC/AMctbrEFg3Cor+pKDK
	 YZzUVikWmxKq7FU1U3g4eeTj1Lf4P04flAFhEB4yOYsYmmD87bNCYbzOm7tpNXmB+3
	 u7uX6w7GDQogDZ8QhXQ6njzRobARW1ZRvFDQZDr/I0VFh687g22FeWsLhwIc67UgIU
	 50V0VzIs332oQ==
Content-Type: multipart/mixed; boundary="===============8854511339365467035=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c6da6df95673d3a5ab5c4e757500658821e9e9e8d0652f737eca82690765a9a8@mail.kernel.org>
In-Reply-To: <20261024153608.58569-6-leon.hwang@linux.dev>
References: <20261024153608.58569-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 5/6] libbpf: Add log_opts support for bpf_link_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 16:13:54 +0000 (UTC)

--===============8854511339365467035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add log_opts support for bpf_link_create

TL;DR: In bpf_link_create(), the shared iter_info/log_opts slot is keyed only
on iter_info_len, so an iter_info pointer with len 0 may be misread as
log_opts, possibly causing out-of-bounds reads/writes in libbpf.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9a2107d4f6d8..00efa90a6ed9 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>  	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
>  	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
>  
> +	if (iter_info_len && attach_type != BPF_TRACE_ITER)
> +		return libbpf_err(-EINVAL);
> +
> +	if (iter_info_len)
> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
> +	else
> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
> +
>  	/* validate we don't have unexpected combinations of non-zero fields */
>  	if (iter_info_len || target_btf_id) {
>  		if (iter_info_len && target_btf_id)

For BPF_TRACE_ITER, iter_info_len is now the only thing that decides whether
the shared iter_info/log_opts slot holds a union bpf_iter_link_info pointer
or a struct bpf_log_opts pointer.

Can a caller that sets opts->iter_info but leaves opts->iter_info_len at 0
end up with its union bpf_iter_link_info being read as a struct
bpf_log_opts here?

bpf_program__attach_iter() copies opts->link_info into
link_create_opts.iter_info and opts->link_info_len into iter_info_len
without checking that they agree, and nothing in bpf.h or libbpf.h says
log_opts is only used when iter_info_len == 0, or that iter_info needs
iter_info_len.

Before this patch the pointer went to the kernel, and bpf_iter_link_attach()
rejected the mismatch cleanly:

    if (bpfptr_is_null(ulinfo) ^ !linfo_len)
        return -EINVAL;

With this patch, __sys_bpf_fd() runs OPTS_VALID(log_opts, bpf_log_opts) on
the 16-byte union bpf_iter_link_info.  The first 8 bytes of that union
(map.map_fd, or task.tid/pid, or cgroup.order/cgroup_fd) become
log_opts->sz:

- If map_fd or tid is in the range 8..27, sz passes validation, and size and
  level are read from bytes 16..24, which lie past the end of the 16-byte
  object.

- If sz is 28 to 31, OPTS_HAS(log_opts, true_size) is true, so
  OPTS_SET(log_opts, true_size, ...) writes 4 bytes at offset 24, which is 8
  bytes past the end of the caller's object.  Can this corrupt the caller's
  stack or heap?

- If sz is larger (a typical tid, or a cgroup fd shifted into the high 32
  bits), libbpf_is_mem_zeroed() scans caller memory from offset 28 up to sz.
  It usually stops with a "bpf_log_opts has non-zero extra bytes" warning,
  but it reads out of bounds first.

In addition, attr.link_create.iter_info is now NULL with iter_info_len of 0,
which the kernel accepts.  If validation does pass, could a task iterator
attach to all tasks instead of the requested tid, and a map iterator fail
with -EBADF instead of -EINVAL?

The commit message says log_opts support for iter links is future work.
Would it be better to treat the slot as iter_info whenever
attach_type == BPF_TRACE_ITER, and read log_opts only for other attach
types, instead of keying only on iter_info_len?  That would keep the old
behaviour for iter links exactly.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40108748084
--===============8854511339365467035==--
