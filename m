Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153738E8D8
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551546; cv=none; b=i6B9v6Pjz32RMhckcZBJL0OHIeixYh3qDOsKCFuyhFsVGIa3tnqDH5prgNPWr43plgRoe9tJbiX5n81TO3RMdLYLtS6YEnv2lLOwSN3/UM3LliZE7NT4YVff6+ElWISWq8ow7zQcGWQlU3NV7slpcnYDIkKspDbKYJlXM27XCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551546; c=relaxed/simple;
	bh=fNnFTtVTIbl5zAxpPcCO+AoTPFPnCtaVf6V+VFJGHCE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU8I5r1zQNReua+dRGNIOnQRpe8gQTOCI025sYIL8DL0naN+KhjV+vxdTa3HAhZlRvO80dg6pjWW5K8YAOrXFAR5UonOmDhbAQ+XrWQ8SkyI6OExJy+kR4ugk0drG6f4wkGampEngC/WuaRz8PTCkycQXmX80GDNko8mPHLZnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su3O2bQb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su3O2bQb"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b0be347b8so3417460f8f.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791551544; x=1792156344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Dz5N+fpkp93xVi0luIxaL6+g9aD44lsghhKGiHbbMM=;
        b=Su3O2bQbLDbv40qR95sOPKSzsxWiaWnOT+zq565rX1nJrSEOnhiYZIso27pV1I08J0
         k3BZYPvLKYRKD8X20WwAWTeByP5MH3yS/uM8O7bfm7MtoauExnCCYTPv4+IwL/sX3+u6
         0I0oFNU007u4dzBKBenQxkFTgg4uQWZiIvtVgaEkAw11b2OSemOHIqBRWxiOSztPTbx0
         0rL+qkaz5AxYlrHCOOaJqf005gB6mplHOjMcl8Ym6YuymJHpQqcuy8myWa0Z4IXK8DOq
         zHRUJ1PMeJAiJ2ayKliW7gEHNB+Db1cW1HWccQlFjkv3I/7OdVPqq0WWGaRnNfSP0yQM
         vRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791551544; x=1792156344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Dz5N+fpkp93xVi0luIxaL6+g9aD44lsghhKGiHbbMM=;
        b=lYeFOcILtedrqt2F57sV0qJJY9gTyNwFEQ/nF4f4YneH39AYagIm+q6cuBR6YEcYrj
         sLWfmYLC86f6tkr4eGbm8uuOQ1uyRxv5Um2EG7V/Fg9FbpBYUMTn58ijJu2lnxAcukke
         NEJK6NIJTPS37Jgo04SkvcJGgm7IrY/dQj3o/hCTZZ85aJJ8HKHYhKOWeGaTvL8zelR0
         AUFnXjkOGi9r+gswKVBWszsOPFYR2fUJsx3ZcWtfFADmHmux4GFKRh+WVYtntwRXHoMG
         H4O6NbbDfu3Hg/ingpx+lRQDq4sTpnVs6TDd8LqbASJWYH1+pzOCBDG5/CWT1x394rUu
         5JOA==
X-Forwarded-Encrypted: i=1; AKwUvBxjZaqElOCP5LyDGR0CJ+Jd3vZolWS1n5VatVI+5bwunMThXlKuYUdipoZRvfAk7Hwbs/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl8FFCZlULeg9q4TgxWUiNEYtOkPF3944jhs5jdSyQsSn9g3dp
	SlYcUPwVx2yJC4U1oXi5ZGrfliyUYSmtmwjB/xfzs33CAOSpxpUr9w/J
X-Gm-Gg: AYBFou2qGsQYjq5Q/09C+g3ZUXsLovXdETkqTU0vUpYvjXIWz0uXVW4glN/sktv4Etx
	bog9htZHK9mUQs345cDAm9phs2OGLVH80gK3T6Kaiecyfktis54icdvKBUwyZ6Ij8XiNy8UMU+s
	+RUfUBFdG23tboOXLCKhPuTPyiwGP4RDObRj67sHJZbw7WyGW9NcdKMuc7Sp+49ezuEShMo41Qw
	un2ErF6goLD/CZyBS0rg/FkHw+wS1K3eA3LDDP6yEQz0iyfAQ82yoXnwg1BwD4ktW7eI99zGJ8E
	QCAEOH2rR3Tkd9SbmHW6D8FVkPonNMGsVWhqqAEH01B2qGRHKESaex7LnieZHsVcwsDvFCZW4iQ
	Rd5goAdjJJvdOCgRL4d2Ej4luP3nUbq3UIWacWCeFH0YsOOzI50s7D0yxjN4dGAqedX0yqKVDm8
	/lyjJvsT7YcvipBg8eQF8GGqPhXTtlL64JL6ktKjHYnLTHO4m8MxJTDlSPUnoYQjU2Gne7
X-Received: by 2002:a05:6000:4b05:b0:48b:60d:2b28 with SMTP id ffacd0b85a97d-48dbacdd339mr3235969f8f.39.1791551543436;
        Fri, 09 Oct 2026 06:12:23 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ab981asm3776784f8f.30.2026.10.09.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:12:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 Oct 2026 15:12:20 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v5 dwarves 05/10] pahole: Support inline BTF location
 encoding
Message-ID: <asjoNE3H9ZqL4rsR@krava>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
 <20261002174043.3823987-6-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002174043.3823987-6-alan.maguire@oracle.com>

On Fri, Oct 02, 2026 at 06:40:33PM +0100, Alan Maguire wrote:

SNIP

> +static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
> +					     struct inline_expansion *ie)
> +{
> +	struct ftype *ftype;
> +	struct loc *loc;
> +	struct parameter *param;
> +	uint32_t section_idx, section_offset;
> +	int err;
> +
> +	if (!ie->function || !ie->name ||
> +	    !btf_encoder__inline_addr_to_section(encoder, ie->ip.addr,
> +						 &section_idx, &section_offset))
> +		return 0;

hi,
we get inline locations also from .init.text, which then fail kprobe
address validation.. is there some usecase for keeping .init.text
locations?

I currently disable them in kprobe_multi change I have on top of this,
but I wonder we could just drop them completely in here with something
like:

	if (strstarts(encoder->secinfo[section_idx].name, ".init"))
		return 0;

thanks,
jirka


> +	ftype = &ie->function->proto;
> +	loc = calloc(1, sizeof(*loc));
> +	if (!loc)
> +		return -ENOMEM;
> +	loc->name = strdup(ie->name);
> +	if (!loc->name) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	loc->section_idx = section_idx;
> +	loc->section_offset = section_offset;
> +	loc->nparams = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> +	loc->params = calloc(loc->nparams ? loc->nparams : 1, sizeof(*loc->params));
> +	if (!loc->params) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	inline_expansion__for_each_parameter(ie, param) {
> +		if (param->idx < loc->nparams)
> +			btf_encoder__add_loc_param(param, encoder->addr_base,
> +						   &loc->params[param->idx]);
> +	}
> +	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
> +	loc = NULL; /* save_func owns loc after this point, including on error */
> +	if (!err)
> +		return 0;
> +out:
> +	loc__delete(loc);
> +	return err;
> +}
> +

SNIP
