Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68EB4AF16E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346577; cv=none; b=djTRnQ2b59jKI0xR6VqTopcX7kMboOkMZooIIn8FUWpkaGCUCXKPScA912+FjqQt7buZqYpwDuXr+ENtzfAZ8DlYd5WpG/nGu3og38WR4iRpQZ7NYRG5c6b0+OcUbJXOgD5nCCPX/kGJ7EBUWYGi7IgbZr7xcOGE/SzMKOJKuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346577; c=relaxed/simple;
	bh=e+pp7LXhqwXl4mH1H7SwlW3s0o0pigrR2/62brefR6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaf3NcQODx9QuYgNx4AX21oZZVR0JZeFlL66r/kG2lx/+K3kKCq1poynfTIlExewZGMNxT+7hcfFPyYPwiG7ahcF3CQUnUyM1yqPwLD/4SCxQB9kEWgx+6GhnW8c6MkP/QChjXr8HZCDHSjlKvzvfyrNFYCCNCE5HIciWXpXlwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=Eq7KC1df; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="Eq7KC1df"
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4hrtFS49SJz13y1;
	Fri, 25 Sep 2026 14:22:20 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4hrtFQ3Qnzz1f;
	Fri, 25 Sep 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=Eq7KC1df;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1790346140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDiXD5EP0xZxNDcjnGwznEFouzuueVdaHLsyOD/aCCU=;
	b=Eq7KC1dff7eR89yF8Cjq4NWCF9eEJLEIfsyTg5U/ldK/S1HwOjBwS5GWvMBFuTkn4P9L7G
	1T4Ec0jNXC7n5JPSFaZ8Mh2bpk6TvfAZjawQTpVvjsneDm4f41iifBjAbAZa+6AvnQe5Yd
	WqdKvD5hZbbJsNY0gCRnoqmqPvpTdlyb2Wi/XcJMLZoaQXE/J+x4id7JuwkFZ8lb7sdryH
	M7LgihFy6jHO8sDYO/OTFKDUEnnHt3S5w7DD0Oa2jzARsIFtIQ/0T2Vh+ffzzlkcG66X6G
	FY2d/+yAIA1VhtpzdYpUPxuWacGIIVh8aFYgTnLEn67lFuW8hwMed4z5TNZndg==
X-CM-Envelope: MS4xfDDlW/Egt80x/PS79vMUKIua7AJK+VmkjnEyA9ZvkqBLmHmoPaF5T5XIrq9ZHgz2ZQKEAy56tK6mG4TiTA7ZhxuRpqBb+UgtbyohsAHueMlCjbSkr9lV nm0DsBWaw6AQKy4oqGlqHV3mGrYtOBaXA+gt6TGq7a7PGatQIf1RAhnnCXeU4r0dxlGNULq7uAFhrO8ffD1WLPCQzhuPSLVnNdPFFDdxjIFjIo2yIomjTRNv 5lpyxLqIidxwMwW5My+wVL/DYGpqKTBxJ/up5rrOaLn7k2r1tLvJa3wfoUDvmn0vcHT3W/0vEC1P6F9VAyjDE+IYbBU4VgQ5FLa2TREnj3Npu5vVyN/SHwcF q0Sh7855sYTxLQt5cc+Cbtwad4BvF/oB2NwFXvYbgA07JCqkFf46FXCcPPjOlK809d9FD+vJiYtCZVfCvaY21nOFQaXvcX91vMkZRPsa8GE0xuDHqOeHZ13Y RDfTb608EZ5fEDrL35uUYye7W91N/DIH0XgxEHsZbQI4HhwYRWhubF2uCWDxl41ZN2uqbhIaFb4HpVNS
X-Soverin-Id: 01a0d8f2-1960-77c5-b1cb-4db5547e3702
Message-ID: <d64c6402-175f-4ea6-be6d-1a544a95c97c@qmon.net>
Date: Fri, 25 Sep 2026 15:22:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: Add option to wait for program
 stream output
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20260925045536.1480933-1-memxor@gmail.com>
 <20260925045536.1480933-5-memxor@gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20260925045536.1480933-5-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2026-09-25 06:55 UTC+0200 ~ Kumar Kartikeya Dwivedi <memxor@gmail.com>
> bpftool prog tracelog { stdout | stderr } PROG dumps the output buffered
> in a program stream and exits, which is all BPF_PROG_STREAM_READ_BY_FD
> allows. Waiting for further output means rerunning the command.
> 
> Add a -w/--wait option that opens the stream with bpf_prog_stream_open()
> in its default blocking mode and keeps printing output as the program
> produces it. Flush each chunk as it arrives so redirected output is not
> held in stdio buffers while the next read blocks. Waiting is opt-in: the
> default dump keeps using BPF_PROG_STREAM_READ_BY_FD and exits once the
> buffered output is drained, so existing scripts behave the same on old and
> new kernels.
> 
> A stream descriptor does not keep its program alive, so bpftool drops the
> program descriptor once the stream is open. Waiting then ends with EOF
> when the program is unloaded and otherwise runs until interrupted, as
> bpftool prog tracelog already does for the trace pipe. Exit from the
> SIGINT, SIGHUP and SIGTERM handlers like that command does. A flag set by
> the handler and checked before each read would miss a signal that lands
> between the check and the blocking read(), leaving bpftool asleep until the
> next print.
> 
> Waiting requires BPF_PROG_STREAM_OPEN. The bpf() syscall fails with EINVAL
> for an unknown command, which bpftool reports as missing kernel support
> rather than degrading into a dump. Document the option and offer it in the
> bash completion.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-prog.rst    | 12 +++-
>  tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
>  tools/bpf/bpftool/main.c                      |  7 ++-
>  tools/bpf/bpftool/main.h                      |  1 +
>  tools/bpf/bpftool/prog.c                      | 62 ++++++++++++++++---
>  5 files changed, 73 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 90fe8c61bf42..17aa0d560e32 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -18,7 +18,8 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| |
>  { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
> -{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] }
> +{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] |
> +{ **-w** | **--wait** } }
>  
>  *COMMANDS* :=
>  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
> @@ -186,6 +187,11 @@ bpftool prog tracelog { stdout | stderr } *PROG*
>      error messages to the standard error stream. This facility should be used
>      only for debugging purposes.
>  
> +    By default, bpftool prints the output buffered so far and exits. With
> +    **-w** or **--wait**, it keeps printing new output as the program produces
> +    it, until the program is unloaded or <Ctrl+C> is hit. Waiting requires a
> +    kernel that supports opening a stream as a file descriptor.


If you do come back for a follow-up (looking at your reply to Sashiko,
regarding _exit(0)): it would be good to mention the mainline kernel
version that brings support for the feature, here.


> +
>  bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
>      Run BPF program *PROG* in the kernel testing infrastructure for BPF,
>      meaning that the program works on the data and context provided by the
> @@ -267,6 +273,10 @@ OPTIONS
>      Path to the X.509 certificate file in PEM or DER format, required when
>      signing.
>  
> +-w, --wait
> +    When dumping a program stream with **bpftool prog tracelog**, wait for new


Nit: **bpftool prog tracelog { stderr | stdout }**

I think it doesn't apply otherwise?


> +    output instead of exiting once the buffered output has been printed.
> +
>  EXAMPLES
>  ========
>  **# bpftool prog show**
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 9d9ced270685..a28af31937ad 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -269,7 +269,7 @@ _bpftool()
>      # Deal with options
>      if [[ ${words[cword]} == -* ]]; then
>          local c='--version --json --pretty --bpffs --mapcompat --debug \
> -            --use-loader --base-btf --sign -i -k'
> +            --use-loader --base-btf --sign -i -k --wait'
>          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
>          return 0
>      fi
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 83884b21e708..d15fec71b64e 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -31,6 +31,7 @@ bool block_mount;
>  bool verifier_logs;
>  bool relaxed_maps;
>  bool use_loader;
> +bool wait_output;
>  struct btf *base_btf;
>  struct hashmap *refs_table;
>  bool sign_progs;
> @@ -462,6 +463,7 @@ int main(int argc, char **argv)
>  		{ "nomount",	no_argument,	NULL,	'n' },
>  		{ "debug",	no_argument,	NULL,	'd' },
>  		{ "use-loader",	no_argument,	NULL,	'L' },
> +		{ "wait",	no_argument,	NULL,	'w' },
>  		{ "sign",	no_argument,	NULL,	'S' },
>  		{ "base-btf",	required_argument, NULL, 'B' },
>  		{ 0 }
> @@ -480,7 +482,7 @@ int main(int argc, char **argv)
>  	bin_name = "bpftool";
>  
>  	opterr = 0;
> -	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
> +	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:lw",
>  				  options, NULL)) >= 0) {
>  		switch (opt) {
>  		case 'V':
> @@ -530,6 +532,9 @@ int main(int argc, char **argv)
>  		case 'L':
>  			use_loader = true;
>  			break;
> +		case 'w':
> +			wait_output = true;
> +			break;
>  		case 'S':
>  			sign_progs = true;
>  			use_loader = true;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 48eedcb9f6c0..fa2c877a3cbf 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -89,6 +89,7 @@ extern bool block_mount;
>  extern bool verifier_logs;
>  extern bool relaxed_maps;
>  extern bool use_loader;
> +extern bool wait_output;
>  extern struct btf *base_btf;
>  extern struct hashmap *refs_table;
>  extern bool sign_progs;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 24e40dfab469..5e27b22444f2 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1119,21 +1119,66 @@ enum prog_tracelog_mode {
>  	TRACE_STDERR,
>  };
>  
> +static void exit_stream(int signo)
> +{
> +	exit(0);


I'm not sure the deadlock Sashiko mentions can really happen, but given
that the loop already flushes, the suggestion to use _exit(0) here
instead makes sense. Fine by me as a follow-up.

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks,
Quentin
