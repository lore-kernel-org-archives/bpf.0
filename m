Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56C13635C
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421029; cv=none; b=J79+xtvpcrJk1LuYAo6E+hnkCixMOLGo7PIRpXg3U7/O5obseQ694qd2aw+zI7u1XmAMdPWoWpipU9BpyILk2KKai2w1O6/CyUP0C39tiGVqrvJanus+b2VFJnDFsSQZDpx8aQs2GUTNZ5gPUhu6XGLCOJqzrp1x/4WeL+laMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421029; c=relaxed/simple;
	bh=9cyb6OiBZBRxGGGc8sHy3Km4p8p4taXSQ7mtJeYPa/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/+PvlCvu5e74JYMAmmRhnh9m8KFZe+whAQiI0ENCHMAplJRgpxwANHvsRsIej5nA/tELYTtffikCb93aQXetOUb5KuRObRJFkd0Xj3BxFcV5PkQWqM1r5hbyXv7UXq94I0nie5CAT3yYY8i5D9I7QL24R28xWGSVWAghWKC4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0AX2CzT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0AX2CzT"
Message-ID: <03163163-fae9-4980-8526-a1353cdabcfc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774421016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwhc8PSS+2hKiZYt26VThXfB5guA2AYLd1UkTobn7Lw=;
	b=X0AX2CzTfTpHTUqbjgE63LGqzCyje8VJv1az6fbjgVRpuymEtR1uoaF1aCRdLCgKEZnxI2
	6qalCCqCMd3h2V5MSlM9SdpwShjA/eSKF9czrqllmPEi/Nvi4TmCmMEEPe1BOWSoF0AaSK
	feWEo6oh1DXj1jVjrm2bz7A1NSxd1Hg=
Date: Wed, 25 Mar 2026 14:43:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 13/25] bpf: Add support for tracing_multi link
 fdinfo
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-14-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260324081846.2334094-14-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/3/26 16:18, Jiri Olsa wrote:
> Adding tracing_multi link fdinfo support with following output:
> 
> pos:    0
> flags:  02000000
> mnt_id: 19
> ino:    3091
> link_type:      tracing_multi
> link_id:        382

Would better to add attach_type?

attach_type:	[fentry,fexit,fsession]_multi

Thanks,
Leon

> prog_tag:       62073a1123f07ef7
> prog_id:        715
> cnt:    10
> cookie   BTF-id  func
> 8        91203   bpf_fentry_test1+0x4/0x10
> 9        91205   bpf_fentry_test2+0x4/0x10
> 7        91206   bpf_fentry_test3+0x4/0x20
> 5        91207   bpf_fentry_test4+0x4/0x20
> 4        91208   bpf_fentry_test5+0x4/0x20
> 2        91209   bpf_fentry_test6+0x4/0x20
> 3        91210   bpf_fentry_test7+0x4/0x10
> 1        91211   bpf_fentry_test8+0x4/0x10
> 10       91212   bpf_fentry_test9+0x4/0x10
> 6        91204   bpf_fentry_test10+0x4/0x10
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 761501ce3a5f..41b691e83dc4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3618,9 +3618,35 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
>  	kvfree(tr_link);
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
> +					  struct seq_file *seq)
> +{
> +	struct bpf_tracing_multi_link *tr_link =
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +	bool has_cookies = !!tr_link->cookies;
> +
> +	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
> +
> +	seq_printf(seq, "%s\t %s\t %s\n", "cookie", "BTF-id", "func");
> +	for (int i = 0; i < tr_link->nodes_cnt; i++) {
> +		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
> +		u32 btf_id;
> +
> +		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
> +		seq_printf(seq, "%llu\t %u\t %pS\n",
> +			   has_cookies ? tr_link->cookies[i] : 0,
> +			   btf_id, (void *) mnode->trampoline->ip);
> +	}
> +}
> +#endif
> +
>  static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
>  	.release = bpf_tracing_multi_link_release,
>  	.dealloc_deferred = bpf_tracing_multi_link_dealloc,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = bpf_tracing_multi_show_fdinfo,
> +#endif
>  };
>  
>  int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)

