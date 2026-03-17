Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87D2D5940
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767917; cv=none; b=deV/Pj2+gcCXWzPT+00LBzFwkrHeCqN7/dSVDWB1m3zhcYiWrN5O/EQbb6zmVm87to9uFyHVUFZ0ptvDTvLVfN6JNm7Tf3Qxr2fxh2ImfaToFeVOBS6hpViZoFl31nc2ljWF1igo7zs2kkOyNmJMJTtoPb6W2XMwtr3ScxFR9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767917; c=relaxed/simple;
	bh=JxFonNn25E7MJwXH2RFIoMLNotu2AvqxFyJi6Ff2fgI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeAe/yXv7HDM0pISSceJIhp8VKB+vRs3HZFKl3O+KpiyfFJ24JQwlD4pplai2yJU5vwmpQuO3aDNGO5reiD4+cukcQNgerTGpUqa+TdJKe3Z5dELPg0LKFwbXGbgp50smorNy8K4aHU7DYYHh4CSA+AHiEyBKmBxPcH8thRtHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtVXtJU0; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtVXtJU0"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509006c070eso52159021cf.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767915; x=1774372715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbEuxmyWYaI0lRAPrAH38Js2gsSq0wb5jUj0cHJDWRM=;
        b=GtVXtJU06eDqriix1TXQBUzsP1Cr27ZomOZ5nMwQ4qfpLiDxWmkAQ3NnADKEFiDqkC
         Ahb0dx4lsCtw33CRVjfLHpkR23h4O+o9CBfhJh5d9JWJQuuqoWOH0yVfgoT8y9yE6/6G
         /tgsaZgSsP1rXjMU3yLEg/XVIwjsLj507d9mIQ4AYpoc2xNSHVTRzJIOwJCvWAsN9We8
         +/Hs0wBm4BvFqE/xLkuh78C5gbZjBVGQzTeUmWD7PCYOvd2DH3OHA9tCh4e5Sw3c0+de
         cbyNAYeQrjRmMunNd4grmsIUHvlF3mZuRy1fM0KsHzjEK2uDnMk3EiLYqXjBvyaa2nsD
         VTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767915; x=1774372715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbEuxmyWYaI0lRAPrAH38Js2gsSq0wb5jUj0cHJDWRM=;
        b=HcsH1m/SixLLwK4nKiFKm4XxFj4Xo5112tDCWn+lT1mqFixckHFRGeMxXaDwkxYx6D
         J6MPzv5JNpNgsQNuEFaRxPq/1k8ex3GVni8bPP0D6fh/jCtIPO2qOAKsxjqzcm6H+cZ/
         +F2uFMxCad138OYA0gi7R3maAhBdHjQr9b0E1W4WdXCZRyURIozyF5ZDigy17A4BR3OW
         tH+CP1ia5y+h8CDjk6tS5oMkw4yxSlIfTt0fUvJPyzsCkMOV/iTIesXYaEbOv+Q30x9+
         BYo4WSC/xd+NrfNFb5f7/EiucHPfiByg/0jBHeoXKxJd0UGqtMyNoRbQgYYAkcCtfIX+
         FYbA==
X-Forwarded-Encrypted: i=1; AJvYcCWQttqODjOJLFJXWCRrHc1LTYKsn6alAY0818ObHsLAACg5+FHdJRydR81jMm8eAZyYW28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uq8syEd+qQSUvzLvNClBtDo0wOrOptDWziBmaHHniVLBDlkE
	AfIW0cIERR3e4H6YCPs5jI/aOjbzpAxt8RXptzYx9RofJZoTErY39Z70
X-Gm-Gg: ATEYQzxozd+AV/RhoaWTcmh5wAWDgLbbJ6ok/miaeh7CWAlluAzhm4E5fMin+ZsGUo7
	WpblkI1HNjIuyiKJAJmmuKj9N5xUFOF1esNwu8ySGhz7wVfCc63YirXp2chx8Bm561zyceABLYL
	yJcaQwgqvjABY+2zlLOwLBnQjKnWpRoibpnOHHDSOx4X8efXNo6yQKxW3dwvJBKbHWFABqECKBQ
	BRsUWdQPIqddKO38KxmB0gzFrUEkAcdFQf79qECfCoZ7NtGkujav2i33FyDrvGaly2w5YGEHei4
	XtZv1uRvXA+uBdXpodjFGsNqDne+QKnKoEtdEmrcGV8qiWj7p/7182TPUX+pEIkaM0j2m8hdhSZ
	zoq5xD6tBbp3ehbhKDEbjKJ1zRcSEzhrTpqLAgBBBBwqBshfeV+R5EsHoFJs1SownY4LOz9VIXk
	x3VTb8yvOT+u3pMhbnIKlF1g==
X-Received: by 2002:a05:622a:146:b0:509:2222:4202 with SMTP id d75a77b69052e-50b149046demr408331cf.71.1773767914098;
        Tue, 17 Mar 2026 10:18:34 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b13489f93sm4913381cf.4.2026.03.17.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:18:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:18:29 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 17/24] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <abmM5csLgQiQz3Xa@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-18-jolsa@kernel.org>
 <39113fe0-2e9f-4f11-afe9-efb676a48149@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39113fe0-2e9f-4f11-afe9-efb676a48149@linux.dev>

On Tue, Mar 17, 2026 at 11:04:57AM +0800, Leon Hwang wrote:

SNIP

> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> > +	struct btf *btf, *vmlinux_btf;
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
> > +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
> > +			return NULL;
>                         ^ vmlinux_btf does not get released.

right, needs to be 'goto out'

> 
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
> > +	for (i = 0; i < funcs_cnt; i++)
> > +		tsearch(&funcs[i], &root, compare);
>                 ^ tdestroy() is missing to free tree nodes?

right, will add, thanks

jirka
