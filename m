Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C671245031;
	Wed, 15 Jul 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076479; cv=none; b=rA0kv6H/g4ur/DzUK5hoa9WhA2+ZFMFAfVXtNtpeVjno5oDC3vFQ9L5eT8R4IV9TUJEtIW0E1P2hSgJ5uuXO2M4m1aFhMcd0xUfqYBaOFS0MQ8/ludnwNUrbVmcmUZNMlRovxYt/LF99/Ed8+DXBRH2QIH9siucHB6lBedEBDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076479; c=relaxed/simple;
	bh=CMWoIAlQe4026XLJXAknd45XqNVkuiHlvjw8b7o0aFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0Hp56zrjfs06ksQUP0fWexraiyb3Tn3lAveZQbyNcpgTVKcI2+GK+bVCbFSWoCBgQc0jw41faWt/dyKIotYtJMMEPl4xX8uskIXaUE/UxDx2xuo+6rcvsbxfaoLvwojKDeHViGz8NKW/TLmsEcUah9MtVCOjQI0vvh3bgB29QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FBG1bEGG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FBG1bEGG"
Message-ID: <bbbcbae7-a819-4f86-b116-6d5e31973a0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784076461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9b4kcf/MkCEqYe2P7LACEUaqcpaFs0ud1FC011M9A4=;
	b=FBG1bEGG78L1Hu4Drppib6EcinfhBJnghbSbhuTxL3vSteCSyPPrnx67f4WE2DZOskGXV/
	5b/HY63ajfPqZJQ5LNAU6zwyN3eH357itugDk6A/uvVt6AMUQtmOi3ZTsoRGZ81tPcuyqJ
	p0LKNi2caGLrKEw3yUezpI3nRfhc0/s=
Date: Tue, 14 Jul 2026 17:47:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 01/10] bpf: propagate original instruction
 offset when patching program
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> When the verifier patches an ebpf program with bpf_patch_insn_data, it
> then calls adjust_insn_aux_data to make sure that insn_aux_data takes
> into account the newly inserted patch. Some of the data offset is pretty
> straightforward to deduce, it is for example the case for
> indirect_target, as any patch affecting indirect calls will
> systematically move the original instruction to the end of the new
> patch.

I think an additional KASAN-specific argument to adjust_insn_aux_data()
is not a good idea. It's threaded through ~30 call sites, and it's
been error-prone too: you had to fix the offsets a few times already.

indirect_target needs no help from the callers, so it's not really the
same pattern. Similar for the other aux fields: seen is broadcast and
zext_dst is re-derived.

> 
> In order to introduce KASAN support for eBPF JIT, we need to mark any
> load/store instruction that accesses non-stack memory, but updating this
> new marking after a patch is not as straightforward as for indirect
> calls: the original BPF_ST/BPF_STX/BPF_LDX can be at the beginning, at
> the end or somewhere in the middle of the new patch: we then need some
> additional info to properly update this marking.

I don't think we need to track the exact offset here.

It looks like .non_stack_access is set to is_mem_insn(insn + off) in
every single case *except* for when a stack access happens to be in
the middle of a patch.

Given that the cost of getting the flag "wrong" is an unnecessary
kasan check only for that case, I think it'll be cleaner to just
unconditionally do:

    data[off].non_stack_access = is_mem_insn(insn + off);

in adjust_insn_aux_data()

And then the code change can be folded in patch #2

The only problem with this I can think of is that in reality *most*
stack accesses go trough that special case, which would defeat the
purpose of the .non_stack_access flag. This can be checked empirically
however.

Anything else I'm missing here?

> 
> Add a new parameter to bpf_patch_insn_data and adjust_insn_aux_data to
> convey the info about the new location in the patch of the original
> instruction. This info does not always make sense depending on the
> generated patch (eg, some bpf helpers being inlined by the verifier, and
> so turned into multiple new instructions without any remaining BPF_CALL),
> the parameter can then be set to -1. It will be used in next patches to
> properly handle insn_aux_data adjustment for the new KASAN
> instrumentation
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v5:
> - fix a few incorrect offset values
> 
> Changes in v4:
> - define insn_off_in_patch inside convert_ctx_accesses main loop to
>   avoid old value leakage
> 
> Changes in v3:
> - new patch
> ---
>  include/linux/filter.h |  10 +++--
>  kernel/bpf/core.c      |   2 +-
>  kernel/bpf/fixups.c    | 100 ++++++++++++++++++++++++++++++++-----------------
>  3 files changed, 74 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 14acb2455746..1ebcd247ef4e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1210,13 +1210,17 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>  
>  #ifdef CONFIG_BPF_SYSCALL
>  struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
> -				     const struct bpf_insn *patch, u32 len);
> +				     const struct bpf_insn *patch, u32 len,
> +				     s32 insn_off_in_patch);
>  struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env);
>  void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
>  			       struct bpf_insn_aux_data *orig_insn_aux);
>  #else
> -static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
> -						   const struct bpf_insn *patch, u32 len)
> +static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env,
> +						   u32 off,
> +						   const struct bpf_insn *patch,
> +						   u32 len,
> +						   s32 insn_off_in_patch)
>  {
>  	return ERR_PTR(-ENOTSUPP);
>  }
> [...]
>  
> 

