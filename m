Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CA3DA7C3
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405371; cv=none; b=Q+cokEaRn/PL+8T0YpO8jaln4WuSocElEZYkGEmPliJFtJ5rvZ8cgorOibUedMap+wT1XjjaBfSspSNa4PtxNDpqiBudpvW7DKChr7gWVJmkfIR9K3UZLxerR0WYcvwp4ZsxmSu6xnN6YA/5j5YeRVJxZymF5Ztw8hd107nE090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405371; c=relaxed/simple;
	bh=JE9BsHwCXebesj3gPEonc8Cp+dgSTslh4pusv9zboyY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPnmnFhrG4EwsfNpRPktWaVSRmCdiQ9lzbHC+PM1XiuVn8c7PObUwwxie0rkifCCunXeQHHbzfX+a14r3auG/ch2tC8WsHykoQ2cUN+Kc1C8xa2I67wBmXBTJTrqPrqrQJMLKA0xW5GlIOz/gMcE3j2WnpTn8huOWuendGZLzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzZmFWUG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzZmFWUG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so9782855e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405369; x=1781010169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5031zl6vzmgMYXl4CWCm+EUkp03qXJKw3CP4zw8608o=;
        b=bzZmFWUGK9PFNcYnlvBOBFkRz2emdpvLJAsUMRIADhCsTAqwhX+aAg2Qkd1lkTEZq+
         agGoGuDVocL9INM742ICIOWhvcpPShaBL0Fb9+Oe8O34p8sxY5DtvI4IXhUsgVuq0bKh
         igDAOpOEk9WffD+mPLjoqmtaLNQKDft98IyJ1ER0LKxwzIpfepVlX/BexqwQ7zwGl5Zk
         7EJFFCZxI5ACPeag7GbJDKIqbvnH4YtalrdR1BmeygNqLaihSpmfS76x6ph73eA3UwwL
         r/DsfAfgd4uBC8pX9aWd7d2AEo1PnNOt535pWWGSFIS9Lc0mVZ4t+ZE+45aaxFJ8F4UJ
         2ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405369; x=1781010169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5031zl6vzmgMYXl4CWCm+EUkp03qXJKw3CP4zw8608o=;
        b=mrxm4z6161I2YGhk97TGuXL1L3ZzWb8zX2k+MDwnV1o37WZg0PO2PKdHX18hoCB9ud
         CLppc0r9FPI8WU3FUG4wDGCh3PqxYyQdBX+Nfs8/EZvQrTqGlpoJepcUCD+fd9c7pAov
         vXwPx/KleeJzoRPTiRPvt57HyXPvEFfU1KFxB31J31EIWrGUhoUPl77X2M8S7SlL6DNk
         3goxDfN1SfAyfSRiWie9HUts7BPNi1WahcyYm9GbQzppQyEdJ2d2zC56I0thIkpGjkWr
         dHCx9UO7gXyO36s0CDmxYMVGAZFtJZB3pT67fMsYfOs9JSDn5+8iJ4tVy5PGyePR2wpp
         9ZXw==
X-Forwarded-Encrypted: i=1; AFNElJ8C35lwXSl2Kzgh/GSmmjfyMHzUQ3c6hGJH4ELAj5ggfLw28nqXuL2z1NbcTR5ZI0fl6NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbfrEJR01zK8k2LVsb5x79LKfzlpKECaAjCHJiphWsua4gFJ/
	RW21H5P9aaSYCS/wpiqctjlnft4nsn4BaAqYeS4cPF/vD/ZmSYcXvOMVUFP93Q==
X-Gm-Gg: Acq92OFfnUXM+l197xr4ZhzetvSnm4vlyJUvvOpYTvRe3rLpJ9KjR/HYeSVo9ynxyVE
	d7cWlphzsSYuwX8IY74FtqSi3xWke+42KqVvGus/tMZpB8oT4DwPiNp4aXMSnNdNDueV7s0SXYG
	EonNr/wzbGCQiResnlTuXEgWOyEsotrAtuCLh6dEVtoGnL7cV+usZPdYJi475TvxQUuveqm5+UZ
	octKlm25+VsXxKofLq/SITnOP85psYEjsOtcmrSfpatuE0bbw96IKteVdmCDvbqe0CX9uZL5i1C
	l12RP6fPTdb5M732ssTdLLvwk2fQchv9n4ldAIXSupT1+e76/PXOUoVNrkiM+iQl8tM/2ZnDmzK
	5+Wkj5Ou0lBjCZsNTbZOD2k1IXLiSMcoHOOAWJxAqej0jkwLzCH4hJgBy1hjjW1fy083h7TP+4/
	DEHzUZ8Zonv0ypxJ5x6zNiopCT9UI=
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr292038265e9.26.1780405368565;
        Tue, 02 Jun 2026 06:02:48 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3563cb9sm34280753f8f.29.2026.06.02.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:02:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jun 2026 15:02:45 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Add kfunc set test to
 resolve_btfids
Message-ID: <ah7UdYz8Kv-Sekc4@krava>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-5-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601221805.821394-5-ihor.solodrai@linux.dev>

On Mon, Jun 01, 2026 at 03:17:55PM -0700, Ihor Solodrai wrote:

SNIP

>  static int
>  __resolve_symbol(struct btf *btf, int type_id)
>  {
> @@ -108,6 +129,18 @@ __resolve_symbol(struct btf *btf, int type_id)
>  			test_symbols[i].id = type_id;
>  	}
>  
> +	if (BTF_INFO_KIND(type->info) == BTF_KIND_FUNC) {
> +		str = btf__name_by_offset(btf, type->name_off);
> +		if (str) {
> +			for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +				if (kfunc_symbols[i].id >= 0)
> +					continue;
> +				if (!strcmp(str, kfunc_symbols[i].name))
> +					kfunc_symbols[i].id = type_id;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -162,6 +195,29 @@ void test_resolve_btfids(void)
>  			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
>  	}
>  
> +	/* Check BTF_KFUNCS_START(test_kfunc_set) */
> +	ASSERT_EQ(test_kfunc_set.flags, BTF_SET8_KFUNCS, "kfunc_set_flags");
> +	ASSERT_EQ(test_kfunc_set.cnt, ARRAY_SIZE(kfunc_symbols), "kfunc_set_cnt");
> +
> +	for (i = 0; i < test_kfunc_set.cnt; i++) {
> +		bool found = false;
> +
> +		for (j = 0; j < ARRAY_SIZE(kfunc_symbols); j++) {
> +			if (kfunc_symbols[j].id != (s32)test_kfunc_set.pairs[i].id)
> +				continue;
> +			found = true;
> +			ASSERT_EQ(test_kfunc_set.pairs[i].flags,
> +				  kfunc_symbols[j].flags, "kfunc_flags_check");
> +			break;

nit, we could reverse the logic 
			if (match) {
				....
				break
			}

then found is equal to "i < ARRAY_SIZE(kfunc_symbols)"

> +		}
> +
> +		ASSERT_TRUE(found, "kfunc_id_found");
> +
> +		if (i > 0)
> +			ASSERT_LE(test_kfunc_set.pairs[i - 1].id,
> +				  test_kfunc_set.pairs[i].id, "kfunc_sort_check");

nit, should have { .. } braces 

jirka
