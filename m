Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207744;
	b=sBsMbHGvfdJChhzhtuEV9EOAMkWJkS0NUPA6ok/+f4x/EzcfxIkOQ+PuFnD1DVn/p6Hj
	 Ka+m184vyp3OQVl+v0dEO72S0+ClzQxOFTGn9Z2KnLIPU2IjSxL0M1RzJdzDBXz5rN4dL
	 1eB8BQ68/n/zsXJ/sb0eZ1VO+06sM1nW6Po6SvCrNibVCPNsZwp7kOzAZpQGcbReahjic
	 3k8X+rvVaKgbCOOdGdz5k5QxlkkQur1YDIx++1w3kJV6YMxX2JfkOFdCU0dO9EJ7D9uPT
	 BzdB9k9IkNDjyPzw4srB04bZ8dLacCv33J6YyZy805U85InBlv5WPCBS7QOzGayCMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207744;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DorFOItP+EUoiJnzqSbB7jGSrPubs5iSNcNKA/G+mpo=;
	b=3AvN8Ca3rJqgEjhuKhWe5ustKSZijjKjuBo/W+2Q4q7ddxy4edesV7B/zqvUbnqfhixF
	 ZR+nxUoQOz9Rk6pk69khYHIOJ/QG4gYx54C1XedohKCp361C0eZsy9BHZHHIHiTkbWR92
	 nbKpHUVsq4Fh1BhgtJGTZPtXDGgdyIpqFxTBqmsW7qOn4FLeX8bPLqa8W98iXOxAh5CJa
	 6g/fVgpg+iZu7sehdG/oHkqZj7tyPn3mbQA881XMrLIeFbNmS0KiKCLEfg5QdP/1INrgD
	 j8viIMb6DUdbRU9A/YPdqAKwWM+xIa2xL9XmREyckGFGgrjH6sEN+QUV0qPeZ/xsJ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YJWGwbHA;
	arc=none smtp.remote-ip=91.218.175.90
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA9606A6B4
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30AA9606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YJWGwbHA
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pm5O0ND+/Cmn5iYP+9i7p4wVaho6P4NKmAOEgWgu7jM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795207739; v=1; x=1795812539;
 b=YJWGwbHAhVO2N22D/f5AvB3gbwtGutnUiB1QmsGfDbBkBH1k1nIV0LOdq3HNCrh9CPpWQ77X
 usYf6iSwSAWJLD+Mwtr6dGti1hV0S/PflyO1traAH8klLcmv3IgoAnJxyRc0dL98K3f8QWI4Xlp
 PwjTLstXqUVK1ZnM1XUS5svU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e7b9ce845187f3e;
	Fri, 20 Nov 2026 20:48:59 +0000
X-Mizu-Trace-ID: 5e7b9ce845187f3e
X-Migadu-Flow: FLOW_OUT
Message-ID: <b3d75779-ac46-4182-ab22-a74e2010073e@linux.dev>
Date: Fri, 20 Nov 2026 12:48:56 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: Fix CO-RE relocations of unsigned
 32-bit enum values
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261120165540.2074139-1-yonghong.song@linux.dev>
 <20261120165545.2074537-1-yonghong.song@linux.dev>
 <DN0ABWWQD6EE.3K5F7Q9N05BCL@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DN0ABWWQD6EE.3K5F7Q9N05BCL@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/26 11:28 AM, Alexei Starovoitov wrote:
> On Fri, Nov 20, 2026 at 08:55 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The local enum has the kflag 1, so the original value matches the
>> ld_imm64, and nothing would warn. So if the target enum has the kflag 0
>> but the local enum is signed, take the 32-bit target value as signed
>> too. A target value is then zero-extended only if neither enum is
>> signed.
> That rule is one 'if', but new_val gets there in three steps:
>
>    step                                 new_val
>    -----------------------------------  --------------------------------
>    1 bpf_core_enumval()                 extended by the target kflag
>    2 bpf_core_enumval_targ_is_signed()  sign-extended by the local kflag
>    3 bpf_core_enumval_is_sext()         sign-extended by the insn
>
> Another idea...
> Keep the sign extension in bpf_core_calc_enumval_relo() as it is today.
> Zero-extend once in bpf_core_calc_relo() when neither enum is signed.
> Steps 1 and 2 become one function.
> BTF_INFO_KFLAG() works in libbpf and in the kernel.
> bpf_core_format_spec() uses it already.
> The table in the commit log stays the same.
> Then no need for btf_enum_value() in include/linux/btf.h, btf_kflag(),
> bpf_core_enumval(), bpf_core_enumval_targ_is_signed(), etc.
>
> Instead of patch 1. kernel/bpf/relo_core.o builds with it, no test
> was run:
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 2672623..3f37a08 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -887,6 +887,28 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>   	return 0;
>   }
>
> +/*
> + * btf_enum->val is __s32, so both values are sign-extended at this point.
> + * clang zero-extends the value of an unsigned enum.
> + * kflag == 0 is an unsigned enum or BTF without signedness (kernel before
> + * v6.0, pahole before v1.24), so new_val needs kflag == 0 on both sides.
> + */
> +static void bpf_core_zext_enumval(const struct bpf_core_spec *local_spec,
> +				  const struct bpf_core_spec *targ_spec,
> +				  struct bpf_core_relo_res *res)
> +{
> +	const struct btf_type *local_t, *targ_t;
> +
> +	local_t = btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id);
> +	targ_t = btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
> +	if (BTF_INFO_KFLAG(local_t->info))
> +		return;
> +	if (btf_is_enum(local_t))
> +		res->orig_val = (__u32)res->orig_val;
> +	if (btf_is_enum(targ_t) && !BTF_INFO_KFLAG(targ_t->info))
> +		res->new_val = (__u32)res->new_val;
> +}
> +
>   /* Calculate original and target relocation values, given local and target
>    * specs and relocation kind. These values are calculated for each candidate.
>    * If there are multiple candidates, resulting values should all be consistent
> @@ -962,6 +984,8 @@ static int bpf_core_calc_relo(const char *prog_name,
>   	} else if (core_relo_is_enumval_based(relo->kind)) {
>   		err = bpf_core_calc_enumval_relo(relo, local_spec, &res->orig_val);
>   		err = err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_val);
> +		if (!err && relo->kind == BPF_CORE_ENUMVAL_VALUE)
> +			bpf_core_zext_enumval(local_spec, targ_spec, res);
>   	}
>
>   done:
> @@ -1144,6 +1168,13 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>   			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
>
>   		imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
> +		/* GCC sign-extends the value of an unsigned enum. Keep its form. */
> +		if (relo->kind == BPF_CORE_ENUMVAL_VALUE && orig_val <= UINT_MAX &&
> +		    imm != orig_val && imm == (__u64)(__s32)orig_val) {
> +			orig_val = imm;
> +			if (new_val <= UINT_MAX)
> +				new_val = (__s32)new_val;
> +		}
>   		if (res->validate && imm != orig_val) {
>   			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>   				prog_name, relo_idx,
>
> pw-bot: cr

Yes, your code is much simpler than mine with the same functionality.
I will use your code then. Thanks!

