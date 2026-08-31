Received: from mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E538888C
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210413; cv=none; b=eyXlo1Dx6/l/nayXTSvwJc9RhDi2ZUTttNhhu7fkHYzrOufsrhQ8z6hY4UCu4Bnz2CrEGvuZqcnDQV3pGMaSGQzbCpPBFACsI8qdpK4dwS4QZagkJa4s9kICHNRIyvWJcOJUfc6V/RZ/PxA928os/MUqcjHyxTgBddUDB/EdkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210413; c=relaxed/simple;
	bh=wNd8QboWKht0yztSP4Sbpt6U2NkJV8XlHDJXK515WTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8xxqgaEetn3DTiSKpILZovaVT/4HZdAlyGjhYI9WLaQ2Z2+I+l72IsyA7WP75uUdK9GusfxQ8q5RASSnrpATYvgfUFVZVzqUPG3wbQAQlGhaw2BCXA/VyCOHKOh5ruQbSFNttsj+ulzOLOg/RQI6dVnsBSUYuAK8ap5b4vtH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjVGE9Xc; arc=none smtp.client-ip=95.215.58.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjVGE9Xc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wNd8QboWKht0yztSP4Sbpt6U2NkJV8XlHDJXK515WTg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788210409; v=1; x=1788815209;
 b=NjVGE9XceHDTA32GvIHNSjEPQ3yJtaopNo0M97Lm6a0S5j3/RsmyTtIcOL0y4ZVrjQjon6At
 ykYl6kXJKCOGIewQXZ02j8/ICnGdZ/MqaWBduWw44SL1+GHvuX7j7NWd5GIt4Gfr+Gn2zcyo+Z2
 Izv/GOqGdtcsI+n7k8OqBInc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4daa89fecb40d3f3;
	Mon, 31 Aug 2026 21:06:49 +0000
X-Mizu-Trace-ID: 4daa89fecb40d3f3
X-Migadu-Flow: FLOW_OUT
Message-ID: <99f0921c-0cf9-48a8-a84f-3b888988eb33@linux.dev>
Date: Mon, 31 Aug 2026 14:06:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void
 BTF type
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Alan Maguire <alan.maguire@oracle.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
 <20260831110314.150870-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260831110314.150870-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 4:01 AM, Jiayuan Chen wrote:
> btf_modifier_show() resolves the modifier and then calls
> btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
> BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.
> 
> The map dump path cannot reach a void type (a map key/value must have a
> size and void has none), but bpf_snprintf_btf() takes a type_id straight
> from the BPF program, and a "const void" (a modifier that resolves to
> void, present in the vmlinux BTF) NULL-derefs there:
> 
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> RIP: 0010:btf_modifier_show (kernel/bpf/btf.c:2914)
> Call Trace:
>  <TASK>
>  btf_type_show (kernel/bpf/btf.c:8251)
>  btf_type_snprintf_show (kernel/bpf/btf.c:8321)
>  bpf_snprintf_btf (kernel/trace/bpf_trace.c:1047)
>  bpf_prog_test_run_raw_tp (net/bpf/test_run.c:829)
>  __sys_bpf (kernel/bpf/syscall.c:4804)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>
> 
> void has no size, so there is nothing to render - not even a byte length
> to fall back to dumping as raw hex. btf_df_show() is already the ->show
> for the other kinds that carry no value to print - FWD, FUNC, FUNC_PROTO,
> FLOAT and DECL_TAG - and emits an "<unsupported kind:N>" placeholder;
> void belongs to the same group and only lacks a show op because it has
> no kind_ops[] entry at all. Fall back to btf_df_show() in
> btf_modifier_show() when the resolved type has no show op, so a void type
> prints that placeholder instead of crashing; bpf_snprintf_btf() then
> returns the length as usual.

nit: The explanation is a bit too verbose, I'd try simplifying. And the
comment in the code as well.

> 
> Fixes: c4d0bfb45068 ("bpf: Add bpf_snprintf_btf helper")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/btf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 91b8ce77f699..6e267c4c4e1f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *btf,
>  	else
>  		t = btf_type_skip_modifiers(btf, type_id, NULL);
>  
> -	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
> +	/*
> +	 * A modifier can resolve to the void type (e.g. "const void"), which
> +	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
> +	 * instead of dereferencing NULL.
> +	 */
> +	if (!btf_type_ops(t))
> +		btf_df_show(btf, t, type_id, data, bits_offset, show);
> +	else
> +		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  }
>  
>  static void btf_var_show(const struct btf *btf, const struct btf_type *t,

