Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA753A0B28
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761835; cv=none; b=VwUpjq/7TsYqBZLuFn5doko0QuXmtty0SjqrDPyrB5jtTLupi31Q2M5cmxF/ErFxMy6h3Ov67Hp5wqQzp+yq4zleRkRlvj/pFnGfindo3HUei0l5UXpLB816tqmxitM5+qF2HiwiYp9PW+N7LbGE7MPzRYVQRZeKLawOW6A+yYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761835; c=relaxed/simple;
	bh=eTLzMI7yWfeA7FpJW6pduFsu39gZsW1lezkyNZLf2Tg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOAHPlQ4Rf+eXDG9wODoOXOE9MI6ZiEf+VzYanMSZqBhFTKofa5ULFcdW1oFphr3IZD181GW2R1rYGj9XXy7S70S/UHRr2Wzm3YAkAkQX/rU1ShpCRY65SQO9C/iRN6PmI1Sa37AEc6CcO33iAHPgFuVP3a+aFVoKAHkJxtTZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqhT3SPK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqhT3SPK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so4243538f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761833; x=1777366633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MXLb7hix0ehudvrz1Mhjelpsv8ZbBwlfk6T0/b/pdk=;
        b=eqhT3SPKGU0Pl4+yFrTTbo9v24eAaUK/9/vr1AVez8zVpOtOYFznNQbpYxBQw6fxfe
         hCMmOe6C9sOenT0RPBFetkT4fRxvZRF5IgKH2TBL1l/ThNQtJf4qJm7NCt9DwnJ8f3Gg
         8RZ8DVsFyW2D2bcV0o3rSUm0eXdvnPv4Z2k52jb6Tsi1aXN85aviKU04QVF+hxAvn/Ud
         UU6adlYBrwJkJtKGkaus8vjopjxverjAG9wfzexuzX2Fug3cCOmG1fFVcCuvKuIl1l1S
         MWxbnMmPHic3+qy6zHrwPMrFcoy8K0LGwsT2ol8r3uUXgITJ6UXeh80Jy7aJhu6KnjQK
         PBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761833; x=1777366633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MXLb7hix0ehudvrz1Mhjelpsv8ZbBwlfk6T0/b/pdk=;
        b=lpy2f1zDsjRUl2W1Cttwy590FuUd7RYxqXl1Da3wja7OERSt+R/5CcXXDiXwAQpRJ0
         Xc1GJKA3az8g8YafqX2RTXjJFas70AB45W9p+waRdENH4pdVlDi6n6DbrLnm9BGT27uR
         851T9Sn4wja1T6iP1ks3UNN4ZXDmNO7AJpdKDXhWYotYfWfB1f1/YcrnSmssD8UzxlBV
         ZQ1iIrbqUDZR75I9y14ZGXbkNXToD5xTcnlGiYwZMFrejdJ2iw2QbNzw81z8h5KVX3xx
         AufwWnXtW9lNlxuT8SuNlRuoGuoNGxpa/mDPXysoSHO1S59PZpF5BeYWs/7I0zytVmZo
         /gqA==
X-Gm-Message-State: AOJu0YyTP7sL2qS9THUiGwZ1747W/n4ucD8jt6H768fk200lW4/7wTjr
	sDX7B15BL1SPhM4dB4nKCiyRZE1UmeYH+rJZp5h8a5/3Wq8UId+1WRky
X-Gm-Gg: AeBDiesFeAaHH6xjQ0UY7m2dpowCPi0jptSDAjkDUfyeviOxTZE0k7wTHnsbhHKaW9l
	PxUocB5X74tL4JX5b2wjP4oNnO7D9XkC3ixajotISXpwc9Vql7J9LYfJLEJ6Xb1OVl+FqEk+1al
	SU8poo3uC0XljtamLIkWSvz5JLwAsM5q17IBFlvNPJchUYTtUPTz/yncYMicRY+UzKq7MzEI+Xw
	a2gKnBiE/WYxpp9uf1kMhW54aLpwg7tDQUc0UlOOxmgEI/w3/iywtHQgiwrd/FALZ+gEHt8GLxj
	96bUzI936R5ckq5mtE/lOs62bnevEv+azWTdAltZTMwUVoGqHO61jBQi6iCKUOm6CMxtACkITmq
	WWEOb1b0Ccy3rCBOBoauCql2Y9HkCV6D6VcgdzVImN1Ew72+x4fC+SMm4ARDEPOIf16cQD9Vfqu
	bIJ+Gv3VI=
X-Received: by 2002:a05:6000:401f:b0:441:1e8e:d8f7 with SMTP id ffacd0b85a97d-4411e8ed9bamr3596913f8f.29.1776761832542;
        Tue, 21 Apr 2026 01:57:12 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a166sm34965481f8f.19.2026.04.21.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:57:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:57:10 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <aec75votcgmzrWI8@krava>
References: <20260417192502.194548-22-jolsa@kernel.org>
 <20260418033438.03847C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418033438.03847C19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 03:34:37AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Medium] Double free of `vmlinux_btf` in the error path of `get_ids()`.
> - [Medium] Missing error state assignment in `get_ids()` leads to returning a partially or fully zero-initialized array instead of failing.
> --
> 
> commit 44b619347c03e0f87cfb994ba8b14346b293edcc
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Add tracing multi skel/pattern/ids attach tests
> 
> Adding tests for tracing_multi link attachment via all possible
> libbpf apis - skeleton, function pattern and btf ids.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > new file mode 100644
> > index 0000000000000..52d3339b430a5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> 
> [ ... ]
> 
> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> > +	struct btf *btf, *vmlinux_btf = NULL;
> > +	__u32 nr, type_id, cnt = 0;
> > +	void *root = NULL;
> > +	__u32 *ids = NULL;
> > +	int i, err = 0;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return NULL;
> > +
> > +	if (mod) {
> > +		vmlinux_btf = btf;
> > +		btf = btf__load_module_btf(mod, vmlinux_btf);
> > +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> > +			btf__free(vmlinux_btf);
> > +			goto out;
> 
> Can this result in a double free of vmlinux_btf? If btf__load_module_btf()
> fails, we call btf__free(vmlinux_btf) here, and then goto out, where
> btf__free(vmlinux_btf) is called again.

replied for this one in other email

> 
> > +		}
> > +	}
> > +
> > +	ids = calloc(funcs_cnt, sizeof(ids[0]));
> > +	if (!ids)
> > +		goto out;
> > +
> > +	/*
> > +	 * We sort function names by name and search them
> > +	 * below for each function.
> > +	 */
> > +	for (i = 0; i < funcs_cnt; i++) {
> > +		if (!tsearch(&funcs[i], &root, compare)) {
> > +			ASSERT_FAIL("tsearch failed");
> > +			goto out;
> 
> Does this code return an invalid array if tsearch() fails? When tsearch()
> fails, we jump to out, but err is still 0. Because err is 0, the cleanup
> block below won't free ids and will instead return the partially or fully
> zero-initialized array.
> 
> Also, if the BTF type loop that follows this completes without finding all
> expected functions (cnt < funcs_cnt), err also remains 0.
> 
> Should err be set to a non-zero value before the goto and when
> cnt < funcs_cnt?

yep, I need to set err properly

jirka
