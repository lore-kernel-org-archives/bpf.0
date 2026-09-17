Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B2331A66
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661167; cv=none; b=mV8JbvdW1OvFjXmxbqCgj63scRDug6ohnHG1tEOcWJ0i8H8+826xKlwY/xfrA0iY4QD8It+Dhxp8C5o6H5r+UpqZOmpJn5rKXhI2IBfpxBhirHPJ3wChX0K0qlN61qzaXfmSlBw+BbDrEUP3yaYEI3iLmeSF+cPYHiFe2mI+1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661167; c=relaxed/simple;
	bh=92MVM8FuUR8dgF4FinXUIpDBtOBI/xZhxZA5lwihY24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBQdhO/f0y0zmOD5gdrBN8cdfh4lRyteeGa8yz7hUpG1sDtRZw40IxgtMctokVzav4sx4X9y9jk8gO3X+EfAnDakwbzzmxuYc9OtKPPJdH6csCmgbk3bpFEI6s8bA68uxKTz/peJF5ZZHyXH+Qora59SURpSltY+i9i0CqU2Prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi6WGKmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi6WGKmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F6B1F000FF;
	Thu, 17 Sep 2026 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661166;
	bh=hewmPPin7Hu0jdJYSML0lPrT36s44Cey1VAj733pW4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vi6WGKmxfixcscNtJu4tZ8nrLmbKO3B5iDCFbE1bAbFlacqzlwrITmP4fgmt4wPmP
	 bzjM+W2cmItRhGlcrUWmHoE30SFKBNvqZCJpT3MKFLtkgoTGTeGnTz07OBMAIJE+iZ
	 xWFTVP6rg2TmxaKARdnDfdPmID8NZkJUWHTFNeO3QKqDf1m50DeBqU3WUii4WMAxC/
	 t6tdMaiNmCCv/+65LOLW4t7BQlapzCmklIQ1Z5vh8bROEQ8By/g9z8b55HNm+QDMVi
	 zrQWrP683Cj7QrbfqtbbB1eR+1tEIQY5L/2yunZGcTRtK/SPDlEvSxHQc9VWIVnJz3
	 R0WV/XD0Ffv0A==
Message-ID: <89767d7c-c622-42dc-a820-ead87ed3e2cf@kernel.org>
Date: Thu, 17 Sep 2026 17:06:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260916074118.1007116-10-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-16 08:41 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> In raw mode ensure we can dump new BTF kinds in normal/json format.
> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
> const value of 0x2a and a dereference of r10 + 0x20:
> 
>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
> 
> LOC_PROTOs render the associated values of each of their
> LOC_PARAMs for easier readability:
> 
>   [14] LOC_PROTO '(anon)' vlen=2
>   	type_id=12 value='r1'
>   	type_id=13 value='*(r2 + 0x10)'
> 
> and LOCSEC shows function name associated with site:
> 
>   [15] LOCSEC 'inline.text' vlen=1
>   	name=foo func_type_id=5 loc_proto_type_id=14 offset=64
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 169 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bbe8f9ea144f..5e0cb5862811 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -51,6 +51,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
>  	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
>  	[BTF_KIND_ENUM64]	= "ENUM64",
> +	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
> +	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
> +	[BTF_KIND_LOCSEC]	= "LOCSEC",
>  };
>  
>  struct sort_datum {
> @@ -117,6 +120,83 @@ static int btf_kind_safe(int kind)
>  	return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
>  }
>  
> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
> +{
> +	const struct btf_loc_param *p;
> +	__u32 i = 0, vlen;
> +	__u64 value;
> +	bool negative = false;
> +	char regs[32] = {};
> +	char num[32] = {};
> +	const char *op = "";
> +
> +	if (!t || !btf_is_loc_param(t)) {
> +		snprintf(str, sz, "<invalid>");
> +		return;
> +	}
> +
> +	p = btf_loc_param(t);
> +	vlen = btf_vlen(t);
> +
> +	if (p->flags & BTF_LOC_PARAM_REG) {
> +		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
> +
> +		if (nregs > vlen) {
> +			snprintf(str, sz, "?");
> +			return;
> +		}
> +
> +		switch (nregs) {
> +		case 2:
> +			snprintf(regs, sizeof(regs), "r%u, r%u",
> +				 p->values[0], p->values[1]);
> +			break;
> +		case 1:
> +			snprintf(regs, sizeof(regs), "r%u", p->values[0]);
> +			break;
> +		default:
> +			snprintf(regs, sizeof(regs), "?");
> +			break;
> +		}
> +		i += nregs;
> +	}
> +	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {
> +		switch (vlen - i) {
> +		case 1:
> +			value = p->values[i];
> +			break;
> +		case 2:
> +			value = ((__u64)p->values[i + 1] << 32) | p->values[i];
> +			break;
> +		default:
> +			snprintf(num, sizeof(num), "?");
> +			goto done;
> +		}
> +		if ((p->flags & BTF_LOC_PARAM_SIGNED) && t->size &&
> +		    t->size <= sizeof(value)) {
> +			__u32 bits = t->size * 8;


Hi Alan, thanks!

In the case of BTF_LOC_PARAM_OFFSET, what do we need "negative" for
exactly, is this supposed to be the sign for the parameter or for the
associated offset? My understanding is that "t->size" refers to the
parameter itself, not the offset, so we would pick the wrong bit if
trying to find the sign for the offset? But I'm not sure I read it
correctly.


> +
> +			if (t->size < sizeof(value))
> +				value &= (1ULL << bits) - 1;
> +			negative = value & (1ULL << (bits - 1));
> +			if (negative)
> +				value = t->size == sizeof(value) ? -value :
> +					(1ULL << bits) - value;
> +		}
> +		snprintf(num, sizeof(num), "0x%llx", (unsigned long long)value);


Looking at the different existing flags and their docs, I see:

"a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
normalized with respect to kernel/module base address."

But I don't see the output accounting for BTF_LOC_PARAM_ADDR, is this
expected or is that an omission?

[...]

Please also look at Sashiko and bpf-ci's reviews for patch 7.

Thanks,
Quentin
