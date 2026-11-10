Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323282;
	b=NE+9hbm07IkGe5UzQ80rN8zSu2p6MYkkOlqiCApSz1IFv90ZIr/cykUhy5gn8TsPxC3n
	 hXIJidQmwYGyMrr3X5sWH8amOsb20jZWfXgOUXYgwjPMThPlYUVYgEryDgqa1htpZep0J
	 wDaAwEie31ZOeo+CEoko0fVuasFX3qN019QnB8beTBIhJuU/1YpjR2CX7SWWAKJ7YErlW
	 uFBxKw+arirHadGZxJxY/oNAAVHzVUpUsQX6yHzk1fwqiaHcxktOOvDH+BcDSqBm6M9cx
	 9HCnMx7Y61E6C0xbUONzOyAoi9tWn/xWxSXTl+UEiu9RQjkwCzpH0bGefU4RkO0eeqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Bk8Y4+BL8s+d95UH4gi81iT+RNas+yqthU8nmbpM9H0=;
	b=lx87yNGLIzW133p1cQxr1KMIPRzaaGiBfxakXPEuSDf2kM4bHiSxcRMV5jtNjsi7SuK0
	 0K96M2b0v0F8+gxoLR1xmBkkkHmq3qlxrFinmUB4RjcqNFkGAQZe3X24BMqI6JOecXvKl
	 Psiw2OoU+DfBvsVOnqD90k+WI0sG5wXeH4wpyU7afY/hxY/ZiUNd0LZwl69OkKCFJx5Jv
	 iwMIYHNgtdyeml22WqcilDd+JvtKXBKjT3tKQi/RcSaJQIjnQ7apvfFC8F2D0zIF0nRDY
	 +1kYbvRiAG84/u2NJOwtCYNDapm6XZiYok5GZs5xBR8LGUPEriq/lZZnDoMv7Ki3b4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X+KW2DVj;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3660A2631
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B3660A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X+KW2DVj
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4922523d1afso1264761f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323280; x=1794928080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bk8Y4+BL8s+d95UH4gi81iT+RNas+yqthU8nmbpM9H0=;
        b=X+KW2DVj2U4mmiEDdPK5c5Xk/qEkPTXC6T3VgRz1qhbQ1tJgtj3umWZ4PV/onOc/ko
         NahWteAa0L14xlDgvE7BWr5gZpDRMB1CyNbLXIsi4U2/JENLwD4v51n7GghDB5WZWosS
         QXlWtIhza4Ubd7Tybt0/OG8kAPWpPf5YhaEm0Z064LNekl8Z84Xbkm5n5ANBbFHaSDhV
         FkYMZItqpufbN+ZArYMhyPQf7061oHavlQqONQNA6gwNNBEI5Vl4lWIxmV97l8FSfsnq
         /W0vVtfm+dpFtIaePP9ibNCgUZXQQC/igr9rZPHP9feSqRplXnh7EwnFk7JUSx7LQQhY
         /7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323280; x=1794928080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bk8Y4+BL8s+d95UH4gi81iT+RNas+yqthU8nmbpM9H0=;
        b=v3zfo5nmec/WYswR2jZzp9b5d8G4MQeLA62iynKN7TxEwxh92iHWYpdVqIWP9Trlbc
         /qMLRLOqsuNARjR8W8OFisVElQ9VrKIhlNNdnrKziELl6VyI0sEPfQAEV+WBwxlU246R
         iMRMRobfzF0+8/I9sFs3vcEvAtyioO/96rmyK/KJiGYjXbIRMC7MBsI/acsW4NkJhddh
         gvqRUxP4wzxGEwYKM6dzCy7L9uNGo61ZmcQUVwigSZWKus/1ZOkwKSIG9Pa8lacgXMiw
         O9sa9O447aqATo5wVYyWUWMP7OoTDbZTn4xJBnuDs704bV/KHztGHvEtYrPqMjVFlFLD
         AQkg==
X-Gm-Message-State: APuU4Z87+ybuXCYVCyMtWcOQxOuofvt8fvOr48fu+3dcTzozV6lnOmjT
	/lfOErkze1XB4Zky5KH9kYeLAELnF75ggqgsoBqso2A25Hk115nH4OIZ
X-Gm-Gg: AYBFou1n24I0nVOlnD730FywixLIm4NXp1HHDGHmiD1ccmLFYcDU0PfKhwRvoFhVW0f
	I2a2TLoVUxL60hGxWYLTX7pVQwmrksSXjBwiMS23B4xDhEJkFbRG7UNusckUF/dOX+2EHt0eSf+
	q8qe9pMlrPPgGaQHvDN4rNd2T1vhL9b88uOD3Kr5QroA1+ZZSzzEAf9Rgff20zWeuSDeDxr0GUJ
	uxulw7k8ns5U+oYdeXAluaeErBV80ja3CSTGdZm0uFSYc1Ad24Tk3x5ZywZrsjaBbl9i1nk5uaO
	pGyz/JriH58uEew7U79eXrTLJ6uKriMKJKOyYNgNO8C947GudR3O37Y4xyhob4Fhmc9A7gcSK0e
	7c/svX0FYiqq/7e+MnmsOoMVkmKUmkcHVF/PrXzGVNKZWrt65VrbC41sHpNTYBlLxXKPXDk0T3e
	Ku2BuaHV4+w/Y3eMU3jVh9TzWCu8JnFcH52pRrFpLgxMR40V9L8yu2pzbz/GEFL3X+LMZqPRZek
	Csv+uuMsMICUg8Nv8NijvTmSU66O5dIrRjsZDf/daOIBw2LUQ49Wru7ElcNzCN9zduZmdxg8Q07
	rtf2UJSEb9T3KlO0CGdr37osDXxdZcqYrq6Z6g==
X-Received: by 2002:adf:e009:0:20b0:48d:f3a4:a6aa with SMTP id ffacd0b85a97d-49830c8ccf6mr3946905f8f.35.1794323280060;
        Tue, 10 Nov 2026 07:08:00 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835858f26sm5477228f8f.18.2026.11.10.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:07:59 -0800 (PST)
Date: Tue, 10 Nov 2026 15:19:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Message-ID: <avM2ArYor7B6-g63@mail.gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
 <20261109170550.141443-16-a.s.protopopov@gmail.com>
 <sashiko-outbox-205381@kernel.org>
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
In-Reply-To: <sashiko-outbox-205381@kernel.org>

On 26/11/09 06:13PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] resolve_btfids: skipped duplicate-named functions in
>   choose_functions()
> --
> 
> commit 51f98882bd7c33a728dede77756350958f73cb62
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> resolve_btfids: Tag fmod_ret candidates as targets
> 
> This commit teaches resolve_btfids to parse .BTF_fmodret_candidates
> records emitted by the bpf_scan_ir plugin and tag eligible functions in
> BTF with bpf_fmodret and bpf_fmodret_retval:<values>.
> 
> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> > new file mode 100644
> > index 0000000000000..df44b93eea734
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
> Does advancing i = j while only inspecting functions->functions[i] skip
> candidate records on functions->functions[i + 1 .. j - 1] when multiple
> static functions share a name?
> 
> collect_elf_functions() gathers all defined STT_FUNC symbols regardless
> of whether they have an fmodret record.  If functions->functions[i] has no
> record (or zero values) while a later function with the same name in
> [i + 1, j) has a record with values, the continue statement jumps to j
> without counting the remaining functions in stats (such as
> stats->with_values and stats->ambiguous_name) or logging the
> ambiguous-name rejection when verbose > 1.

Yes, you're pointing to this the second time,
so it will be fixed in v3.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109170550.141443-1-a.s.protopopov@gmail.com?part=15
