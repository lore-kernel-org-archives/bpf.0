Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D7313276
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365995; cv=none; b=BtSi//HaglHo/yFCzb6ztBIhkiRS6Ae+Tw3LkptrxgteuY0a61u3XZCQ+04V7mJpm3Yl2+IWtWmLKG888nXCXrB043ZyMFLMzmTBr8QXq+u0kbuFJ7eRgcGbk4+J1VgY9ELWUcCbgAfHLBUxVssnAsAB+soPgd34aTAAV8AdV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365995; c=relaxed/simple;
	bh=iLTKDJplIA/N///jP/I/KZCo2ro0S5DjKedkK5Fobbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng9cAG6R0dVrBRywdjz1UEvh7fi/u6dRwXKe6I5ReOqsPw0+53n/CFmV4MYmvEfgRhhp/mVaGyefeVHsNZ/NilV8YDmkv6pfi1ZR2ba8bhr7RIlq1XNFCng7LzoQ/UefRYkPSJixOWsvR0pikAZLV7FrBt/Cu7ROecCXSfHv6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejk7m19d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejk7m19d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435f177a8f7so5066960f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365993; x=1771970793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmhVVGtEtHd9klvOzSTi13AxHzcIE8WkfeurKmZjv0E=;
        b=ejk7m19d8rCt/IU17CSJ4CyLn9auidMN0jHphlhyHKLY9A6o4m82Y3yi0eVT6mbjqm
         8zvlMwZXjlFqCdoZYJ/vFYqndPxAAPiXDgz69jvsyccCjpgMXbvC4R3WvJSesgL5Y6Ei
         zkhXWDZhOC44d9KGk1Fs0YPKHYc2WvhWGN1yhPMPIiQ98NqXuHWlBq7OnInAwpR/5X7H
         m/poo0R6I437dGryn8Pg1qrbNPpBeA83H20VCME9rau2No2jqP7OOXTAmHc4OH74zJts
         emmSPLpis7DNkJ0vWUeHz6ByosSCpNM6hgi2fH68HjB6cnscMAKopUxNFGyQiXqO+Cxp
         hBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365993; x=1771970793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmhVVGtEtHd9klvOzSTi13AxHzcIE8WkfeurKmZjv0E=;
        b=NOmfYlA5skWz4aPhEIAUgvA82e9oBZOGdc5DHJ5iEYMQejwi/JiXAPC109bkIqCEnl
         baDe2wk7h3I4Q+y98r8ZzdzQNCpK6s3yvB1Ve62d5Arcr2qCbLPghf1qS2iSAGlNENw+
         +PZXTztk2Kn2wW715Thc7FJ/QzH+Fu3fec38lo87ivAeHxR0naFCCcGfBE0rfjagqkf8
         6YHxaWYXS8pQ9VTSAKcNww8zaLkQvDQBYUDia9pa3GZWYvR81pAxvybMRAvqQahZtfNM
         5aJmkrefkMGFrJJfC28OrcPjq3nJXNloVGEv2zQ/igtgsmEMUiWLsNndslXm6mXk4WQP
         Em2A==
X-Forwarded-Encrypted: i=1; AJvYcCUHISuE9atTc55K4Y24JJt187DrCRgA1KRtgrKbpyUZDSIig8X4ppyiYCvuvJyz92WfPL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYro2WC3rYX5ThHalhvljCnyESnxW7mFoIhLvfwhptGNzD8ssI
	zZRGL/KGfkWGJbyt0xoM4mJ7+CDbPeGujMdn3fieAG4l+W08lYVD7XXu
X-Gm-Gg: AZuq6aLXaung9W+tCSVxTJ/TAhftFVbOkyBJ02kN8tP+HbeYXuGX1tSv2q+WHtqC1YV
	5JUHrCwCj7HkAGo/L/qHQKCZmouqwdGpWEPQpoP1KorD0ip8HvUmz6nWpH/C92tjo51CC6D4C1g
	/zYeLZdwvO9Ebv+16HkIWY9KLC02Hm4SCQHsBIIunlmg3a15/0uyxt9ZoCw5C3N2wlSxU/iGzaG
	1xDEdVBel+AxLvH9+E36qb0iOfY1GIABZti+Wi8C1x5M2lZnVrN6NfhNRlfnoUl8GjNuOHOjERc
	auY001EDCjFwwTtj0E2Xhd62Rqnf3ITGP1C8P/oRKp1WDbnMHzjCgGPj8M3OGi0fbz7AbNp/aIx
	IELEj+/xY0Ij4Gmf+eZpuaQWAGeT/hkAPNApdZVYqtdR2vuH0NbPMOGtIQrdk/Jpdo4bnguAGSI
	i4G/VFFA4y8FyCBnwVqKYLEx5Bg53LpL0z
X-Received: by 2002:a05:6000:2508:b0:435:8e14:9877 with SMTP id ffacd0b85a97d-4379dbae484mr19903942f8f.60.1771365992585;
        Tue, 17 Feb 2026 14:06:32 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6b563sm36433461f8f.12.2026.02.17.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:06:25 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 10/12] selftests/bpf: Add fentry tracing multi
 func test
Message-ID: <aZTmYeL8wGpLP78g@krava>
References: <20260203093819.2105105-11-jolsa@kernel.org>
 <cd5126aaea4095fde41096caf553d7ab7c42efc42ee2bf8a5897be48a0e66a41@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5126aaea4095fde41096caf553d7ab7c42efc42ee2bf8a5897be48a0e66a41@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:55AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> > new file mode 100644
> > index 000000000..e5efa9884
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> 
> [ ... ]
> 
> > +	} else if (ip == &bpf_fentry_test3) {
> > +		char a, b;
>                       ^
> 
> The commit message states "We need to cast to real arguments types in
> multi_arg_check, because the checked value can be shorter than u64."
> 
> Should variable b be declared as int instead of char?
> 
> The kernel function signature is:
> 
>     noinline int bpf_fentry_test3(char a, int b, u64 c)
> 
> The second parameter is int, not char. While the test passes with the
> current test value of 5, this appears inconsistent with the stated goal
> of matching argument types.

yep, will fix


> 
> > +		__u64 c;
> 
> [ ... ]
> 
> > +	} else if (ip == &bpf_fentry_test6) {
> 
> [ ... ]
> 
> > +		e = (void*) value;;
> > +		if (bpf_get_func_arg(ctx, 5, &value))
> > +			return;
> > +		f = value;;
>                       ^^
> 
> This isn't a bug, but there are extra semicolons on these two lines.

ok, thnx

jirka
