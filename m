Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDA2E8DEC
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966808; cv=none; b=k1thMlSpLI3gKWoBySoLFSy/5vxfc/nm9luOBdmNvsmTI0OfHZ84qbuMA70XuY6kBJudugETXHq2lb1/87lr6Z2i7Adx4ppOeztg/t+7bSyRT7VVSQ0CpIUruR3be3lBDwQnAvAoKzBl4PJ/B5RGdWZ2vNSEpzZ9wkag87erUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966808; c=relaxed/simple;
	bh=R55Fx/z3fTEkIGW8AIsW4/L3d5Eq728JaXA1jmwl+vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGiSO7Dofxe1Z189BXNE2c2BxGtKlDaMnFxpIGlwHYrVJzB5YOEZrqPx7PzvLp8gKJf+HPxbVDVnpnMubfI9df9Tpfeb6Dl0yiaRLHZ6eN++j6ndrvzlCr5dYMx2PxcyO6PnSQ6HefRyd4IMbX4yOBErU7veXSCZpni3s9x+7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndB82BWp; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndB82BWp"
Message-ID: <9d3739e9-598c-4cd1-8a7a-1c9cf091e9c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780966795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSGRKHE4hCBjmrwwOhCI/bgkvh+CIaMD/BS78wPQ1pU=;
	b=ndB82BWpKdCh3T8mmGqHvX+SXzj0hycdSb77WsDdynb1uVPO0ylXr0c8oh7zAiigwKrPzQ
	U0X3QjMx0ReAwOsNwN9PMYLoIejFO74sTOM6AZKWc1dagHIce2SMy85fh1dmQosjJm43wo
	GRC+pgLoCRFwTK9xZ3DWzf2WiZQnAz8=
Date: Mon, 8 Jun 2026 17:59:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: strengthen
 bpf_kfunc_implicit_arg to verify aux injection
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
 <20260608142618.3064380-1-chenyuan_fl@163.com>
 <20260608142618.3064380-3-chenyuan_fl@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260608142618.3064380-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/8/26 7:26 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Verify that the KF_IMPLICIT_ARGS injection path correctly passes
> the bpf_prog_aux pointer by checking aux->name in
> bpf_kfunc_implicit_arg() for the expected program name prefix.
> If the verifier incorrectly skipped injection (as could happen
> with pahole 1.30's BTF mismatch), the stale register would not
> contain a valid aux pointer and the name check would fail.
> 
> This is a positive test exercised by the existing kfunc_implicit_args
> selftest, which calls bpf_kfunc_implicit_arg(5) and expects a return
> value of 5.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 30f1cd23093c..624d57a5c79a 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1906,7 +1906,11 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_pro
>  
>  int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
>  {
> -	if (aux && a > 0)
> +	/* Verify the kernel injected the correct bpf_prog_aux pointer
> +	 * rather than leaving a stale register value. */
> +	if (!aux || strncmp(aux->name, "test_kfunc", sizeof("test_kfunc") - 1))
> +		return -EINVAL;
> +	if (a > 0)
>  		return a;
>  	return -EINVAL;
>  }

