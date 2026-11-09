Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230101;
	b=xzEJQI/JFsEyloXu2HFyUjXkIEnRuBNcWWPnb0mBvIhlq5iYhit+Di9Wk8g24XQ5y2pF
	 8g8btHOWra852LInVE7jJWzsxbKSAAxqjR7uHsPN0vWZIoFO4HjITYO1UYDPi6ghX1zZ2
	 N/Mh8Z02yWk/aaCPLuMwlLaWgH6Cz0SQ4id5gq0rO68By7qxE/Z4Ah9kMoDlpCTUrQbFf
	 06yfxWHYvyj/8LErQuA6mNKssqvkhmhuTSwsAWc1hvzveqrdUlFmztAKJ5V0wWeaUMuuU
	 SWK5yqb90I/H//IrLTKjvmShlkWay4dqmEDlmcH7pBkh5x5JQzdrEKETYVVvqUKTVhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=qGVRi8XeHmRiRp7mXvZ/UI22QQobRMG4w7o25Ae4/kA=;
	b=FKM/oUzFwMF9UVgt+tu50aMOVw+rG+/6Rd41tzpVO2oyXc2k7jsR23SRpJ7HZJt32NQU
	 UZnatL0ysESrwSfvP+KgEzAOckBzSPImTX3AGJupQINxBMChanC1fSWfeReciZN4LzGas
	 Ng7FDuZuilbimt7M+eJwd8cgtZPiBVFvZ7wBItM2OqdgRA7BAJANzn47Re5EP941DKeIU
	 f8I+9x2Hn6YV9jAHACUdUiVzCOD+3VPgwiVZKafINIxBnd+orPqAVby5gq17FcZIAwvq5
	 4dtFimoHKTOqLY5nife3YplZuqAgmpfyqFDh4B7PZLjY5SaooxEVFN/Q8CGmVG7c+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW7Yp+eZ;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D2606A325
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C8D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW7Yp+eZ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso118810966b.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230099; x=1794834899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGVRi8XeHmRiRp7mXvZ/UI22QQobRMG4w7o25Ae4/kA=;
        b=cW7Yp+eZIVyPdLs1uTeR5AeRDoFwS4NWZjz5fS4Rgqe5BnWQ06trNitzBJtphALTj+
         bGQlMOF/znp6P46FhRR8yRnIxY2MCIvE9U+unKPSPqbce3MjOh2Yb+A2XAZbWk3ZMKmT
         9rVIJJq1qC7kuFSHLRpg0rUHp66e28zTROnPBUq8qoasjor5+eKatVdOYmaFF9dwYymG
         3y8fa8a/qENoGH+W093npRAZ0cIXyK2E7PJHPtjmqyH2Mph6JcunwkF93aTIqbspzOlJ
         jV0KNGxcx4ybhcPq07drMoas7Uy7mJPrnabc72qxTZ47hthbchjHjmWj4IIF4DrI6WGF
         LyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230099; x=1794834899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qGVRi8XeHmRiRp7mXvZ/UI22QQobRMG4w7o25Ae4/kA=;
        b=XespGCwMyC6ERqtGZ1Gv8X06izmjM4WQUC2aXuKRVmhLLPK/wNuLkM146ttuF7YnCs
         JqcqBBMYPC0E5I66AhsodMkqoENaM9E9f+r0Xs9T+6F0NvyqqBSLRy2b6KPtdTQFXTDI
         OhEhMnicedSFMq5Bw6Kk/pKR9RE0k3cFchsH7U3t55N8unmV+DBFCosBXnezMp1KFVud
         K1i3DNQh89BOAW7IxnFkB9XNlXagvl5DQJA4H9KNzSECpukQ17tP/dI7AavS0yNZXLU0
         RioWtWuFzBPO3fUZD0z8n0HcJZ2Ne2F+e0aJKeNZIQ2+7We3Xsh1LedhD1dcsMOEHr4H
         z42Q==
X-Gm-Message-State: APuU4Z/LdTOkU2TWtHXggm+lMnNrAz/k0XxmyTvHSgzLYpjBJdTV6bE0
	eaY3urse5ZoR+JbiuqOyAs/HXLkGYEfqST170eq/djEDc4M5XDU26mjya3UtFw==
X-Gm-Gg: AYBFou1nnPRE+Jx7/sorz7bTaCDj73P5iI7Daiia+3F14p2XErnenmU0HYfgzeEEX4C
	XbiztoVsn7qImyZz7ybk+I1S7ux7a8NemKlVCn0XmrybXLYMIPbAZOy0Th2lfQB//YpWwliD8Fn
	uMepGbke60WRBPBQ5igKyJotQdG13NYBh7kvUGULmQRzwxYNDzMW2nAEsfocDxKv4/jIeX1v+UM
	AYiuFAkSTMaUjtt57Tf7LXy+76vpsnq4FdNbAvNsBeTFh46HGrtQuuJmjCtq+9S+Aklyy917g8o
	0jO+wbii0LoKGkGnFcUi+M/yRYut+1TVnRLCqod71VGX3Gi4C0nVD8hTxun6DdRE37t6NXBwVlf
	2DT4VDDdjCc9q/UWE6IsDCHFFDtGy+0nz2mFAF8DTxzd/iHKpdl259khxvbYGehhDr7e0sVeIZN
	p3PXOHHHnppcUyuxIczuJasIaZAXY6md01vmw847cujD0oFC4hTr9bQycE8WCKiyJ0N3fY6OvbB
	fTNyiRGDX70giJDq+ol3zh0iWVoALrvT6ZvYsQirkl2wwdXaQ6LthCUtDtvu7k2oX7C4mqXWI7X
	ilv9/3Io9uoY7trCDlzA3IKS4vO7vGkOV1aS
X-Received: by 2002:a17:907:daa:b0:c48:1977:e1c3 with SMTP id a640c23a62f3a-c4d6db217acmr336983066b.21.1794230099175;
        Mon, 09 Nov 2026 05:14:59 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d53b9bsm173722966b.10.2026.11.09.05.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:14:58 -0800 (PST)
Date: Mon, 9 Nov 2026 13:26:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Message-ID: <avHKCIvezIs8YjWJ@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-15-a.s.protopopov@gmail.com>
 <sashiko-outbox-202290@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202290@kernel.org>

On 26/11/06 09:14PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: resolve_btfids: choose_functions() skips records on
>   duplicate names
> --
> 
> commit 592223df16723596e1694e3167578ff1cfdd0320
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> resolve_btfids: Tag fmod_ret candidates as targets
> 
> This commit reads candidate records from .BTF_fmodret_candidates in
> resolve_btfids, filters eligible traceable functions, and emits
> bpf_fmodret and bpf_fmodret_retval: BTF declaration tags for them.
> 
> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> > new file mode 100644
> > index 0000000000000..1c29ab9a8616a
> > --- /dev/null
> > +++ b/tools/bpf/resolve_btfids/fmodret.c
> 
> [ ... ]
> 
> > +/* Choose the targets among the functions and describe them in RESULT */
> > +static int choose_functions(struct elf_function_list *functions, const struct btf *btf,
> > +			    const struct btf_func *btf_funcs, size_t nr_btf_funcs,
> > +			    const unsigned char *buf, size_t ptr_size,
> > +			    unsigned int encoding, struct fmodret_retvals *result,
> > +			    struct fmodret_stats *stats, int verbose)
> > +{
> > +	size_t i = 0, j;
> > +
> > +	qsort(functions->functions, functions->nr, sizeof(*functions->functions),
> > +	      cmp_elf_function_name);
> > +	for (i = 0; i < functions->nr; i = j) {
> > +		const struct elf_function *f = &functions->functions[i];
> > +		size_t record = chosen_record(f);
> > +		const char *reason = NULL;
> > +		unsigned int flags = 0;
> > +		struct fmodret_retval *r;
> > +		__u32 size;
> > +		int id = 0;
> > +
> > +		for (j = i + 1; j < functions->nr; j++)
> > +			if (strcmp(f->name, functions->functions[j].name))
> > +				break;
> > +
> > +		if (!f->nr_strong && !f->nr_weak)
> > +			continue;
> > +		if (record == NO_FUNCTION) {
> > +			stats->ambiguous_body++;
> > +			reason = "ambiguous-body";
> > +			goto rejected;
> > +		}
> > +		/*
> > +		 * A strong definition without values has no record. If it
> > +		 * replaced a weak one, only the record of the weak one points
> > +		 * to its body.
> > +		 */
> > +		if (!f->nr_strong && !f->weak_symbol) {
> > +			stats->overridden++;
> > +			reason = "overridden-weak";
> > +			goto rejected;
> > +		}
> > +		if (!read_elf_value(buf + record + 16 + ptr_size, 4, encoding))
> > +			continue;
> > +		stats->with_values++;
> > +		flags = read_elf_value(buf + record + 12, 4, encoding);
> > +		if (j - i != 1) {
> > +			stats->ambiguous_name++;
> > +			reason = "ambiguous-name";
> > +			goto rejected;
> > +		}
> 
> [Severity: Low]
> Does choose_functions() skip candidate records on functions[i + 1 .. j - 1]
> when multiple ELF functions share the same name?
> 
> add_record() attaches each record only to the functions at that specific
> location, and choose_functions() then groups all functions with the same
> name into [i, j) and advances with i = j.  If functions[i] (the lowest
> address instance, such as a static helper in another translation unit) has
> no record or zero values, the continue statements skip the rest of the
> group before reaching the j - i != 1 check, leaving stats->with_values and
> stats->ambiguous_name undercounted and omitting the verbose rejection log
> for records on functions[i + 1 .. j - 1].

It's not a functional bug, stats may be 1 off,
but this is not verifiable on practice

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261106205523.1765622-1-a.s.protopopov@gmail.com?part=15
