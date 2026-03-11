Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5F372EEB
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244623; cv=none; b=mQuglIYyqCn8nTHlLwp2SjepVSMMYLai7Hgcc85pd8l7YbLFPSGEbKvz1viQa8LMMH6pQSz4l5fSusw/zSzSY9H4MYn/8mlcjqaUSmhij9MBWtfWltHB4FpTQb8eD+uFMjeKdjnNjcJLjc/A/MaTNrH2YW6nkK2zRGEDklxdb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244623; c=relaxed/simple;
	bh=f5g5NWN4qwwYTPK6cTHmK6+E5XPwTlNKpTtoNyYOZ6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lDD01gZNVz1V3wIYkII3GKxliLd35LwsGZciIWCOER8LGsI6Cz4gPJEmMJqePs1wc5vj20WN3LG+Y5EkkP0WnIRHolyrxMkq2axLiX36St26c/8AgArlMv2h2Wz5lyI4mYXxFDLEV8l17zrTdqLJxVH7eKhmaZsC9JkvlJJCiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=oYsWVuVw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="oYsWVuVw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd7284782dso316851285a.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773244619; x=1773849419; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqjnrikQXGH3suAtnbwio+Ftux9br8uF4UCOSbRtEbc=;
        b=oYsWVuVw39jn2YsZLlgwZigEHW2s1IdkRUoY0naeZLTycc739PuWiK95O8cVoJDTCI
         33PvYxaPKuKNEQOLAjadkNVHiSBcvW2OJjk0NFoOOr98UyhXf7l9YX+QoqJlIhGBZqbe
         q4pJUPdKght7VulkDN+kLF9MBrTqLKvNNh8gLpc/bKnAhIGGEsGL8csCVcdCk6/c0Ev0
         7UqKcntv++vhLKP7l1qxzUPqSpNuqsKLJrDXMVxmiYRd19u+GJdMUsvbpO9ERomEeyYg
         mwrJZ/xovsos4Wuec9EnrdJe0dFJdaFcvuotW2nOyPIbk98jCNAF3ejDcy1Hakp3jTx9
         9fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244619; x=1773849419;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqjnrikQXGH3suAtnbwio+Ftux9br8uF4UCOSbRtEbc=;
        b=KNKfeu6CYAS950GUiMqlOtaBn94ul5NTvwNVUaGaxi06FdyTevv3hq3LbWORSAILR3
         fYv8yqCNmR3hFq/QEbuBZlfaOpcQYaFx8NuM8wrcbCKeiFycbrm9RtC2L15KYC6gMonK
         dKRDsKGrGuW1ddKerMfdGuWIScq7odvio4R3spNPQoDz0EVu1OF3b4qJlev6Gv21kFlv
         i0S4pFdrPKsKUg6tziRYeocxGBhBD6E95FTJ7z8deRN3TIjenZtO+yOONrD4jGFUv0Mn
         izGHLajIsvinsIcpsy8731NLwySryNRJtn0ZC6JZAyaXKCCxX+nqWHAuhjXF6vYxw4Hr
         i9og==
X-Forwarded-Encrypted: i=1; AJvYcCUoLbMYgr4CtKN8YxJcGp33qju2PRdbX25oOJH4vNUvc5aOFzrYGF1NHqettvNF4QnWebw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAS1zeTDzmI4UzQNG7gVGL58iZ4B3FRT07CVWBUcc2pYZAutJ
	DIbSdZE7N0ck3oYbKIJrKLRwOV4/nWJ/xj26THymESKK0YvdfZhAwqhOW74uIFumLDA=
X-Gm-Gg: ATEYQzymuGr67t0O+UQukBfo/jggj/WBlwPHcWxs5X/3SZC3F3YpVyKvDoOxmF3zwo2
	yw8kdiU4pKtpntfP1CkH9jkuDmukhJzoaCHnkllslK8H4g6W+1PTCrTvaxlOZrKv0+fvfjAWakW
	BOBViHomPem0ab95iXt8Xz85eIxMJawDaHrbjYfEscpCcppu9DyJb2tLEUtmAy/vVH92zwslb2M
	5bIlTupR+naSMBycr9Xi2NISaCv+4PfhexVBtC1nc8pVFDYsjLLPSBamO4jMIezZnpqRqbx+Wfh
	aEneA/+SHvkaOg6pAHQflFMWKeBu8C0qMagmsUhHHsU4wkM5Fmm0hUc4j71y6LgwwGThD9wvfnI
	WHoHL8gdPasXvDSVANgGwCJreNUbJ5UXuvz5jfC9N66RbUiCMShrRyETD9UdYl3FDFpZ/+/x2zj
	0AZoLbuMhBSL2OWjPZlOlXbkY=
X-Received: by 2002:a05:620a:6cc5:b0:8cb:4ba9:ccec with SMTP id af79cd13be357-8cda1a7ceb0mr365476285a.72.1773244619117;
        Wed, 11 Mar 2026 08:56:59 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fda2c6sm157668785a.13.2026.03.11.08.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 08:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 11:56:57 -0400
Message-Id: <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Hengqi Chen" <hengqi.chen@gmail.com>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260310064507.4228-2-yangtiezhu@loongson.cn>

On Tue Mar 10, 2026 at 2:45 AM EDT, Tiezhu Yang wrote:
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unconditionally for the
> most archs such as x86_64, aarch64, ppc64el and s390x, but this config
> may be not set by users for riscv64 and loongarch64.
>
> If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set, the BPF verifier
> detects if a program has unaligned access and then rejects them. So it
> should also check the flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS if the
> expected result is REJECT and set alignment_prevented_execution as 1,
> then the message "(NOTE: not executed due to unknown alignment)" can
> be printed for some testcases of test_verifier to reflect the reality.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index a8ae03c57bba..a1ae2f044e96 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1640,6 +1640,11 @@ static void do_test_single(struct bpf_test *test, =
bool unpriv,
>  			printf("FAIL\nUnexpected success to load!\n");
>  			goto fail_log;
>  		}
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +		if (fd_prog < 0 &&
> +		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
> +			alignment_prevented_execution =3D 1;
> +#endif

This doesn't look like it's breaking anything, but it will cause all=20
tests with F_NEEDS_EFFICIENT_UNALIGNED ACCESS to be reported as failing=20
due to unaligned accesses even if they actually failed due to expected=20
errors at load time.=20

Which test programs is this fix targeted towards? Can't we just skip
those tests for riscv/loongarch instead of adding this workaround?

>  		if (!expected_err || !cmp_str_seq(bpf_vlog, expected_err)) {
>  			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
>  			      expected_err, bpf_vlog);

