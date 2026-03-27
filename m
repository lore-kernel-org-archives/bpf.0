Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDFE55A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648374; cv=none; b=kIxzJ6tP5+VlXo3sd3sD04mphqlP4fysbbZSfJjIQ+KKB/7whU+jEk+Zxl7y+NFTQ18B05v3qNPFesXATK8WOZSbg5Li6HHyI/6EZIMHVx1eL8KMGT0wL08toUaFjYRGyF2wK8iLPbYlOXGxbaA4oXpx7eGyrF+AuDVmKx/XM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648374; c=relaxed/simple;
	bh=Z0pxbvbcBhTnlAGaCjUdXFIU3MAGBEDBO444E48esEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIZHF9S1Kdt1Rm0lEn8nmvF+zKoJS7V3H/iyufmxRT6VaJIL6/P3dtnTAXYeyt2AdAFY3o94JuEe9q6+ESOYfVuLvaUMU9iDRI6uZeEcj53f6yH7Vkl8YUxYfJ1qa89kyVWXRd5mhlKqsWKuB6HZwjewq/zXv6edLP7BYSDORFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZZ4GgVlv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZZ4GgVlv"
Message-ID: <8f1a422c-d6e6-49ee-8673-432682d53b04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774648370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRfUeVij8izBsfdIfxHXwmfb/KcuA+kR9OgCUxQGnM0=;
	b=ZZ4GgVlvivbEzxGdRfHHXjurdvqUBxkr4hYrU5ERLTsyXkl8OCwa4nttrZmDygcN6/i7yM
	TXscceMgR4gS68en0qy731sGuqqUSuotIG+bj+X+yEDWuOb9ur7KUJccwOeOTCEmMn7wXP
	IfojDkzoKisUM9Sqy3eL+PL9dqGOXlc=
Date: Fri, 27 Mar 2026 14:52:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] selftests/bpf: fix __jited_unpriv tag name
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cupertino.miranda@oracle.com
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-1-5dd2ced5d9ad@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-1-5dd2ced5d9ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/26 10:39 AM, Eduard Zingerman wrote:
> __jited_unpriv was using "test_jited=" as its tag name, same as the
> priv variant __jited. Fix by using "test_jited_unpriv=".
> 
> Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 0904fe14ad1d45aba2f2c8a9a12881a0d248685e..52cf9f3cccd0ccd8034b9786d787e53992a4a6d8 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -140,7 +140,7 @@
>  #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
>  #define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
>  #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
> +#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
>  #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
>  #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
> 


