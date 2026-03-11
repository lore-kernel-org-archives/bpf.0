Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16D2836BE
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245528; cv=none; b=ckfX0ScAHoDP2NXaVQf3eLV1OLIjQVmIrYcHl/Mk+1uGSdEYmt9wzWa/oAQWzG+lYyK7JsJVI1vpOGzO23u/eQKS2WZVk9GOqi6vjlzd9ngGQHOB5J/opqk2PkEqwoMYhAeI6cD+yRlTHrzgCj+l5qwbT+wnv7x2vW8xRnwYuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245528; c=relaxed/simple;
	bh=sIyQNwqOjKVpIIiV25yy7lDLknlNRxzQ9aI/FW1l/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUcx5fwG8NtwteaiibXwApEdb5lYWNS10K8nhTphVwHm74GLQd474mV0vHR+FKqzUsFnVG/gYXtlIdWwp/6UUY+EMqqtJhmpQpJfqaNTRQ6ytk4iWUSTe7Ufr+j65kkXD6mEcbEAlVXmiytFgTAH1olNcbgpqaR0wlMNp9OemWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejEsmN/L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejEsmN/L"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439af7d77f0so59135f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245525; x=1773850325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K53abmcm+HGCYf9w3e1yImH3op/t1XPxWRmPDq4zpG8=;
        b=ejEsmN/LsIoqLRrXoxvx4YHtjU2jpGw7LknrC5SpT4J+Llikoo8ML6pvijWThjsoB9
         tYkeE05nNAGlugJG0P2fw0bZ89cgj1qGw/wEiIEOSXDerc/jQ2wK5NJ4bPM/jY1gwkQt
         91Mz6fDxEeMI1M+U9AmpS3bU2DXs6nDg7r8yhg9pl5BeNIs+ZmAZfHLG7syNF4b0DUT9
         P55REasWqa/qzm/7c1XOPmmdIq4koknTH5MtMuLzN/mllX8iXTGogJOP+kR8sIl0j7km
         O9kXUcIWEpdROQHM/ZHcs1GlFXhYfqrngIGHQ+TNiPN73MXGeOY1DhHFPPpOj9nce/7B
         nvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245525; x=1773850325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K53abmcm+HGCYf9w3e1yImH3op/t1XPxWRmPDq4zpG8=;
        b=qtaqgeiMtt3NB+xQtxCza25eJCQgLMHRPAEhoswFceuiu6ysDuMoXys3udW/JBaepR
         8XRcAilb0F/yqLN/8S6CEqWllvyCYYMBXh+xzoUK6qpNpVhBq+vDVujj1+4M4Zgi46G+
         B2RbFgz55eeSL+Q4kuASAtDfbQ54y+I/RwsQRMuCvWD63rmzeXcNNbCztZ6kymu9CD9J
         BN9tDoRN15j8s3GOTazeLVR4d8CztWoxmb4gkwx6vDhyML4uI7SGkvCkUzzZFU74qEIN
         xx+VwanfgM9ywV2arvxIULe/6rK7nM375VQJ0q/Hod9bMklZ5nv6dJ0u/L2omReJ2dly
         NZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVlGx+FYsek6XY81xVLLZz5YoMJmuQ+ZgpuHAwEhgUILa10FIB6nB3nH7eZqy3B/yeNg/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxMbwI496rxYUx8zRpQ1Y8jLKH5KE6jXmYJJeTuKwWeIzL55u
	yHDjd/CmvuWgreUBNXsxs4d17xYocGieOWW+XrQp8AVOX5NKz/4oXpRJ
X-Gm-Gg: ATEYQzxRM3eGYNKzBhqT+CrEUDgyyfI+8QjB8ZUALdMh1ndXwwtUT+aLBBXsNkxzrPS
	bwMrinZlisrnKmaNye6xVpBk+l+t+Ppxu0gZjLTiOlS3973SBEGtIGv9VVRObR0sj0XAd6tsXwP
	3jvh6YJC8OeMw2ntaK+IlCdAF+kagNRzzxRcshJ3fW3p1vrGuV23ub8aNQlgYbBCTV08tfQ15dC
	8smCMsqsNGTkICqphzjXaCcqAB1xR1Ewpm0HHtR8x2410xDgwbUmH99EQpl+4AlkUK4jCTlTECd
	MUZxlF+VXXycW4tJb3f+42yWhEBH9qKpXDOYLlfAh+fnusEcN1upZbF8wFr5vnrg3wo0ceDHb0Y
	tpUBwJq3HTJz6PMA/RMvFMdLPoXCACwCiqRDqwcOUyvOEtc+l9HqeCCd17aruD5DTnXJhJ9tcor
	LhB6l0ou7oCmNBngnGJoBJ0DV7cn7GvcH7lziFRqGcvVSqIz/G12wqrt35MahKWC7QjTJCBECYS
	UEi8/YZ1NeS52DFN7gIOebsDgP44XMD60f1+cmubPmVElgqR8iCX9fVdwase2JyZzxOnerCn5sE
	mf9x73OXTkk=
X-Received: by 2002:a05:6000:430b:b0:439:d242:e8f4 with SMTP id ffacd0b85a97d-439f84342bfmr5875208f8f.47.1773245524858;
        Wed, 11 Mar 2026 09:12:04 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0050f5e20850bbf776.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:50f5:e208:50bb:f776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm254462f8f.4.2026.03.11.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:12:01 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:11:59 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
Message-ID: <abGUT1GcbmZJzGqq@mail.gmail.com>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310064507.4228-2-yangtiezhu@loongson.cn>

On Tue, Mar 10, 2026 at 02:45:06PM +0800, Tiezhu Yang wrote:
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

I don't think we should print this message for those rejected tests. It
doesn't reflect the reality: these tests were not executed because they
were rejected, not because of unknown alignment. And we know they were
rejected not because of an unknown alignment since we've set
BPF_F_ANY_ALIGNMENT.

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index a8ae03c57bba..a1ae2f044e96 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1640,6 +1640,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  			printf("FAIL\nUnexpected success to load!\n");
>  			goto fail_log;
>  		}
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +		if (fd_prog < 0 &&
> +		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
> +			alignment_prevented_execution = 1;
> +#endif
>  		if (!expected_err || !cmp_str_seq(bpf_vlog, expected_err)) {
>  			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
>  			      expected_err, bpf_vlog);
> -- 
> 2.42.0
> 
> 
