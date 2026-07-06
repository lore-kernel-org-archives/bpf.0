Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F139901C
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328138; cv=none; b=Uffdxou8WUpc6yVOfSJlskhKSM8Iv0++uGhfltzgTwvGEiZN0FmxRza0tVGDxZwNvbAqQfZSHQ1gLNvE609mJjbSNLJ4yuqgtq09p80hF1tw3fmEEppVVIRrM8WKZBabxAwRrcpGgOXaORe6d02/XXwdk3A8NTYYQ669e7QDW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328138; c=relaxed/simple;
	bh=bpYuhahQxSh9LrOGKBTOyfmIRDnue+zLmdcwJtnlxQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYVQXFG3/oLuOBpJro/IRGwOizjED2tCMwEoYTFdQ4gOPB3ggpRUI+PXOhj5zJEpQKGKV94+JD6awx6oJKnqzuSyfS8xlkfb0CrMM8rQo90DW60+wRF2WV6XrHFKX/CA+1h7Y+krrKNhVboG5ddg6UiJjNm7ykPC1UeD2q+eUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffC0JBXm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffC0JBXm"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847a5528b33so1369085b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783328130; x=1783932930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3v+HDjcgZfmVu7uYp2p3M9sp3YfufYRorQ2bJY9UiY=;
        b=ffC0JBXmIMjuoiRWf+Skv4TgFQmmvfAkrrRJ7543e4VH0ZpzWA8l/tpOP6dkcdNPIx
         JJAYKGSzJvl49lXJgeabBJN5d7hUuSnBMuqQF3YpiRxdSfooCs+UeNrZ3Vvbwj3jAdKW
         3nfj1D9HmrR8QqLCHEudnDBCxKYozMp9C2Wvz8wrRAWgAKtxdLENyEDLyUpxIikb/LEY
         ma/p5ckGNljBcfIbh/hD3DVbLpIUCT9Lhr/xm9c/Bq7+/A2oQb+OyChJzdCAIXk8GM2E
         x8cWuQFQE66z95QNsXXqhifx3hHAGgcRmbs8V0XWXycGmZhfA6qwZ+0BBJELCFYa9K5o
         TJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328130; x=1783932930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E3v+HDjcgZfmVu7uYp2p3M9sp3YfufYRorQ2bJY9UiY=;
        b=GCXyGk2S38i/XX4rNKxgcAiToo55UylfS0UrJva62WhWT18/J8v2BBcCCkFKZ6PhLT
         Gm7alASGOx4ogppozKCOtxlUm9WkyXRtdNIZCEiTmkDmjE7mXxW7hdcBYHm5OQoWh9yQ
         YRTShlJJxL9cuujwqaPExQfImy3pV9mUMVHU00kJF+1cs1YhmeCLWHzk57pzJQ5q9EpK
         GbllfjkvIlqXpbXF5dF7cvNPiDeGZLuz1yxwVI3pe0jBUWh9P5WiWfFaqAOyoJaNhGsb
         bT3mGgmFmzUM0c4oLy3lp7sA5k6k/CPknfh3T9kEymyIwt04Eu5Ssx2hJWgNl/sjcNOr
         ZsFA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6HV4dlxj43r4aAPY90fxtJG5gVaAK2lxY5xdkDPnZIcceE3Wx/Sy267hgK/SvGpO5MuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPWOWnsOaSmOIb+fWbKdqP3XeATvTp4TMbUmoLm4K0l/iiHjs
	MqzZeVmg6TmdDAMwrULFIddJOeondogtuy2nyBO+iVPj7g4fuBzFU0Kv
X-Gm-Gg: AfdE7clnG4/ot+59d+zBogovU6AL2zPld3AktnTbp5p4xePMBLAfpWzQrEmpFG3jQGU
	sRStZCGNo0JbVIu0V0n0bRnY/JXxYLBCoTJGMlG7QlXrX9HQEm9kBpzmis3wxnd+jLXZzKzFOZa
	Kk0DLXJ7BG6hwjfBWcC+t7gU+ovI7Vpj5HUx0qEiKrWDP22z6qi0DyDshp2n0m7pKCwsZgVgvAQ
	aojMChUXcX1WiSfJO+49CklSGGgwmK43+ZfDiXfmf++ulT7+7VQaASxWvkChUDr8CBVRyHcPLTW
	DrLWRCnMhwjiyRhfPd8cdXTDuDszhMi8pF0MI4XPnifKjroJqjupH1rX6Rg2h5mk29ZtyVBHiK0
	1c+AVZltBrGweslX5Cp0UYCjF/6iOUeUteleGtzapGX2s1yvEWQgOPLWkgWcAMef79XKVU4fwGV
	TH6Oh9gNayVamQgXkbyDj9InarKFkQL393Bt6sfToguSDtBCRDRWwdkAuCSA==
X-Received: by 2002:a05:6a21:32a3:b0:3b4:b24e:27b4 with SMTP id adf61e73a8af0-3c03e1ff0b4mr11851439637.1.1783328130255;
        Mon, 06 Jul 2026 01:55:30 -0700 (PDT)
Received: from computer ([2405:201:d015:d26b:41c5:151e:6e02:36c7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm79992955c88.9.2026.07.06.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:55:29 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:25:19 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, pulehui@huawei.com,
	alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	puranjay@kernel.org, shuah@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] riscv, bpf: Remove BPF exceptions from
 BPF CI denylist
Message-ID: <akttdwZOqvgj4h39@computer>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
 <20260628081710.113333-4-varunrmallya@gmail.com>
 <878q7yy28o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q7yy28o.fsf@all.your.base.are.belong.to.us>

On Sun, Jun 28, 2026 at 11:00:07AM -0700, Björn Töpel wrote:
> Varun R Mallya <varunrmallya@gmail.com> writes:
> 
> > This patch removes BPF exceptions from riscv64 denylist on
> > BPF selftests since support for exceptions has been added now.
> >
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > Reviewed-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
> > index 4fc4dfdde293..9268351ce4c1 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.riscv64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
> > @@ -1,3 +1,2 @@
> >  # riscv64 deny list for BPF CI and local vmtest
> > -exceptions					# JIT does not support exceptions
> 
> Hmm, reading your cover the kselftest run still says "#113
> exceptions:FAIL", so from a CI perspective this is not much help. ;-)
> Can we restructure/split so that we're not bitten by the lack of
> BPF-to-BPF calls and tail calls?

Yeah, that was pretty foolish of me. My next version won't include a
denylist change, but if [1] lands, then we won't have to
worry about this anymore!

[1]: https://lore.kernel.org/bpf/bf647816-d292-419c-b79f-fc048122aebc@huaweicloud.com

> 
> Thanks,
> Björn
