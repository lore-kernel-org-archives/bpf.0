Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D63CCA1E
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873660; cv=none; b=tpPiGBMXb8VodxXvu8KgU60KNeMGw8Q+lLFbC0F27nCVeEbOyNqed5c2gbi/Ujh3m7Pzx0IliNXHqvERvBNYH3qqyWgDb2s+KZ8cuxivajwSOb8wm8UcRnJ5278+cTeATzNnxmeYvCOA/O+hwYVE2f+pKIBqOHG3AHWVUhmJWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873660; c=relaxed/simple;
	bh=4TSP6jotEjz6ddJNf+erretS2tqpg9C2n2NAWuLP/As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTIW36o4VqXrJ6qSEuMSRiOJPwG8koesYI2aUSHz8NaCSF/grcTJeoda8W8RUOs565nJNIKEXWfh2ED7+buBp2ZDk6DVgLWDMSyRckLJmrZ33b5odcOHuE1/V/O1Ti740uVqSQlvbF0HMI5z7BbKLbUqKlDH9FkLEpRcBnTSfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkBbeTXC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkBbeTXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E936C4CEF7;
	Mon, 30 Mar 2026 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774873659;
	bh=4TSP6jotEjz6ddJNf+erretS2tqpg9C2n2NAWuLP/As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EkBbeTXC43WDrqXkh/6MoLwzdKcwQzboDrzjkyoLjatJ4j8ckZTO9QJpAGq8VU0yd
	 ypq7Jt7933NTRbzzpsFMtWhn7zU5wMcpUutBqOk9txRg7G3TRiUmCYPdtrlQm9kBRT
	 R26iNEu4ulw1x/gz1/FEaiIubxNC76XvMZuu62calniJjfzONo0U/9NLsRJvfdTX9x
	 PXX+rSOCR8UEekfiU68xhrZvhaLxaQQFIAQD4z9U9GfE+enr00H3xqcIIQ+UOAMwQh
	 ILxfszTgazl/8MHaAr/uFRjeAMbyej5qdzpDVLLtu56YGi8hf862Qo6j3FYf6tQMGI
	 b7sDeNrFpnl8Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Extract bpf_get_linfo_file_line
In-Reply-To: <20260329212534.3270005-2-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
 <20260329212534.3270005-2-memxor@gmail.com>
Date: Mon, 30 Mar 2026 13:27:35 +0100
Message-ID: <m2zf3pzemg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Extract bpf_get_linfo_file_line as its own function so that the logic to
> obtain the file, line, and line number for a given program can be shared
> in subsequent patches.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/core.c   | 32 +++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..2c4f92085d79 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3946,6 +3946,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>  	return prog->aux->func_idx != 0;
>  }
>  
> +int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
> +			    const char **filep, const char **linep, int *nump);
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>  			   const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1af5fb3f21d9..052dd78a2d81 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3313,6 +3313,28 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
>  
>  #ifdef CONFIG_BPF_SYSCALL
>  
> +int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
> +			    const char **filep, const char **linep, int *nump)
> +{
> +	/* Get base component of the file path. */
> +	if (filep) {
> +		*filep = btf_name_by_offset(btf, linfo->file_name_off);
> +		*filep = kbasename(*filep);
> +	}
> +
> +	/* Obtain the source line, and strip whitespace in prefix. */
> +	if (linep) {
> +		*linep = btf_name_by_offset(btf, linfo->line_off);
> +		while (isspace(**linep))
> +			*linep += 1;
> +	}
> +
> +	if (nump)
> +		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
> +
> +	return 0;
> +}
> +
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>  			   const char **linep, int *nump)
>  {
> @@ -3347,15 +3369,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
>  	if (idx == -1)
>  		return -ENOENT;
>  
> -	/* Get base component of the file path. */
> -	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
> -	*filep = kbasename(*filep);
> -	/* Obtain the source line, and strip whitespace in prefix. */
> -	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
> -	while (isspace(**linep))
> -		*linep += 1;
> -	*nump = BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> -	return 0;
> +	return bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
>  }
>  
>  struct walk_stack_ctx {
> -- 
> 2.52.0
