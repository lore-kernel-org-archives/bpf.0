Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BB39CCE2
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210489; cv=none; b=RZR7Q0qipJJRhevvxRu8mZVd77XYTrobqDRlM6iOaPawj3XEelB9rxvVsdqvSNakTF3hZ2m5So4QQeSd4byQasxhl/DIOIgwaQCpHNgRadtBKvDQ+KWADv50UkIn/C1ibGXa4y3DZc4zrcVvw5CZRRO77tuayP++c48Awirf/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210489; c=relaxed/simple;
	bh=K8NahBEYh1brxnrkMP4IG+rge/2nFoiPUVjj3MLym/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTgrnXlCMXmydb33DymNXTQ5fWk4k8T34bcP/wWL57e6tsPt36sus7kCOFa2PRBALnROtFP5pnDd6Q8gbMJewMboa7ubaejOCPbCbegWRwiv6px7SEKTFl9DMJCjq0TY84KbwuaMw03D9wZe89Dew7sGf735ZXanqIy5xFYI8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VWpQ412f; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VWpQ412f"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=K8NahBEYh1brxnrkMP4IG+rge/2nFoiPUVjj3MLym/I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788210485; v=1; x=1788815285;
 b=VWpQ412fJRK1MjQbVgA12g+tI5+McxaXj1wPlwojNTH0NAtkFqv8Ru8q6iEYO1RmUede+XHE
 KE/8aWZnp1fbnq+hVbW6Y6Ab0fhh3h60zemkfJZUDdfpUC0B7RvhxQOixcDxcDOFSF/vt8Ck/jO
 bcOCd6kRwdevQFLFyCWzqM7o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 668783f646d3672b;
	Mon, 31 Aug 2026 21:08:05 +0000
X-Mizu-Trace-ID: 668783f646d3672b
X-Migadu-Flow: FLOW_OUT
Message-ID: <79ee722c-fbb3-4a28-bdba-65e74f2239f2@linux.dev>
Date: Mon, 31 Aug 2026 14:08:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/5] bpf: Fix NULL-ptr-deref in btf_var_show()
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
 <20260831110314.150870-4-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260831110314.150870-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 4:01 AM, Jiayuan Chen wrote:
> btf_var_show() calls btf_type_id_resolve() unconditionally, which
> dereferences btf->resolved_ids. That is NULL for a base BTF - e.g. the
> vmlinux BTF that bpf_snprintf_btf() renders against - since base BTF is
> not resolved during parsing. btf_modifier_show() guards this with
> 'if (btf->resolved_ids)', but btf_var_show() does not.
> 
> A BPF program that passes the type_id of a BTF_KIND_VAR from the vmlinux
> BTF to bpf_snprintf_btf() thus NULL-derefs:
> 
> KASAN: probably user-memory-access in range [0x46638-0x4663f]
> RIP: 0010:btf_var_show (kernel/bpf/btf.c:2929)
> Call Trace:
>  <TASK>
>  btf_type_show (kernel/bpf/btf.c:8259)
>  btf_type_snprintf_show (kernel/bpf/btf.c:8329)
>  bpf_snprintf_btf (kernel/trace/bpf_trace.c:1047)
>  bpf_prog_test_run_raw_tp (net/bpf/test_run.c:829)
>  __sys_bpf (kernel/bpf/syscall.c:4804)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>
> 
> Resolve the var's type directly with btf_type_skip_modifiers() when
> resolved_ids is NULL, mirroring btf_modifier_show().
> 
> Fixes: c4d0bfb45068 ("bpf: Add bpf_snprintf_btf helper")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/btf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6e267c4c4e1f..3cf35ee49c10 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2926,7 +2926,15 @@ static void btf_var_show(const struct btf *btf, const struct btf_type *t,
>  			 u32 type_id, void *data, u8 bits_offset,
>  			 struct btf_show *show)
>  {
> -	t = btf_type_id_resolve(btf, &type_id);
> +	/*
> +	 * btf_type_id_resolve() dereferences btf->resolved_ids, which is NULL
> +	 * for a base BTF (e.g. the vmlinux BTF that bpf_snprintf_btf() uses).
> +	 * Resolve the var's type directly in that case.
> +	 */
> +	if (btf->resolved_ids)
> +		t = btf_type_id_resolve(btf, &type_id);
> +	else
> +		t = btf_type_skip_modifiers(btf, t->type, &type_id);

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  
>  	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>  }

