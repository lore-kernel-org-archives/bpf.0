Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56194DE72B
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775341; cv=none; b=BSfbC8jLwz9Llage77ppyhPE892pdQOK2eszsEdbz3vJLqOIDVucumRlx+yU7A6UV3NWsMS/RLzIOaqeF6ngnEAL7Vm+QB1qEd3fDBL/v4kLJvC+jnXoIAy2uT9gI76l27dHlSvbboyctG1DlwwNJoFmbS/V8KQEMs5SGuT30Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775341; c=relaxed/simple;
	bh=vMcvZ1PlnVDtUSDbarteF8gul9B4R2mF5p3vM3obUR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bei5SLoVzNWFSr1TKCHd/BWLWOygrg0rW5e0pJ3j0QfJcDcAkIGPoOKN+Sj00vJMh/MFTDSsERC0HxTHqdTxSQeIHaV7H0dJRz/6f/HGArSBPKisRsHR3Qt360sQnbb2LUTAV/KS3RAOepQ0ZtlLM4/Wzq8Lq2nW7yyVJavLrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/neoYHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/neoYHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA21F000FF;
	Wed, 30 Sep 2026 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775326;
	bh=R7/YSA5SPswMJ1/Z4wFIeAjXPjObq8GQM1cy4ZhtzLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/neoYHnXVDO5obqpLtVIKegzEVdxvB8K5ucpFG4PUqGumz+BDPzMFIZNLUbS1ucN
	 pb/fV+4alQs5ECd3G5K4ZzKJi9cna3A4vevufYM6b/ar/VA4o6h5e6wlE9dRQASf1p
	 GJnVcnh3AfYx7pSfAYPaqN8X7tMFo0QAcV6/xqGi1FxIi86mCZDTV2+LVHF6DZ8y6d
	 i7nrqCUjZyoIyCu+y2dt/G3qdpqZbLihyAKpLydB7LnPekOGJEEEZsKQqT/pRYMjpA
	 frZeR5GRTpUI4+8uHZhOFk9cc/zW+SR6Ayc6oFFoR77IyNGegNK1BGWAqs+z8jfunP
	 6c5WWJv6tXenQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] kallsyms: Optimise symbol name search
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930132109.260597-3-david.laight.linux@gmail.com>
References: <20260930132109.260597-1-david.laight.linux@gmail.com>
 <20260930132109.260597-3-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:35:25 +0000
Message-Id: <20260930133525.C8CA21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kallsyms: 32-bit offset truncation in scripts/kallsyms.c causes pa=
nic
- [Medium] kallsyms: off-by-one in get_name_address binary search bounds do=
ubles scan time
--

commit aa83959ffd157437ca56938c0da66225c5fc9aaf
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: Optimise symbol name search

Change the alphabetically ordered lookup table (kallsyms_seqs_of_names)
with one that indexes the table of compressed names rather than the
array of symbol values. This removes linear scans during the binary search
for the symbol name.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index d18d78e626db2..2f39fa850deae 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
[ ... ]
> @@ -177,6 +177,36 @@ static unsigned int get_symbol_offset(unsigned long =
pos)
>  	return name - kallsyms_names;
>  }
> =20
> +/*
> + * Find the value of a symbol givem the offset in the compressed stream.
> + */
> +static unsigned long get_name_address(unsigned int name_offset)
> +{
> +	unsigned int low, pos, high;
> +
> +	low =3D 0;
> +	high =3D kallsyms_num_syms >> 8;
> +
> +	while (high - low > 1) {

[Severity: Medium]
Since high acts as an exclusive upper bound here, doesn't this omit the fin=
al
lookup marker from the search space if kallsyms_num_syms is not an exact
multiple of 256?

Any kallsyms lookup for symbols in the last partial block (up to 255 symbol=
s)
might fall back to the second-to-last marker, unnecessarily doubling the
linear scan fallback duration.

> +		pos =3D low + (high - low) / 2;
> +		if (name_offset >=3D kallsyms_markers[pos])
> +			low =3D pos;
> +		else
> +			high =3D pos;
> +	}
[ ... ]
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 494852ade6d87..74264ead1efe1 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
[ ... ]
> @@ -448,13 +439,28 @@ static void write_src(void)
>  	printf("\n");
> =20
>  	sort_symbols_by_name();
> -	output_label("kallsyms_seqs_of_names");
> -	for (i =3D 0; i < table_cnt; i++)
> -		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
> -			(unsigned char)(table[i]->seq >> 16),
> -			(unsigned char)(table[i]->seq >> 8),
> -			(unsigned char)(table[i]->seq >> 0),
> -		       table[i]->sym);
> +	if (table_size < (1u << 24)) {
> +		output_label("kallsyms_off24_of_names");
> +		for (i =3D 0; i < table_cnt; i++) {
> +			printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +				(unsigned char)(table[i]->seq >> 16),
> +				(unsigned char)(table[i]->seq >> 8),
> +				(unsigned char)(table[i]->seq >> 0),
> +#else
> +				(unsigned char)(table[i]->seq >> 0),
> +				(unsigned char)(table[i]->seq >> 8),
> +				(unsigned char)(table[i]->seq >> 16),
> +#endif
> +			       table[i]->sym);
> +		}
> +	} else {
> +		output_label("kallsyms_off32_of_names");
> +		for (i =3D 0; i < table_cnt; i++) {
> +			printf("\t.long %#04x\t/* %s */\n",
> +				table[i]->seq >> 16, table[i]->sym);

[Severity: High]
Does this code inadvertently truncate the 32-bit offset?

When the compressed symbol table exceeds 16MB (such as in allyesconfig buil=
ds),
this code shifts table[i]->seq right by 16 bits. This unconditionally disca=
rds
the lower 16 bits of the sequence offset.

Could this corrupt the lookup table kallsyms_off32_of_names and lead to a
panic during boot when the kernel attempts to look up wild memory addresses?

> +		}
> +	}
>  	printf("\n");
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930132109.2605=
97-1-david.laight.linux@gmail.com?part=3D2
