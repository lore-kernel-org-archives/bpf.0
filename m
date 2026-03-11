Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C793B9D9C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245617; cv=none; b=qMEVY+HwofZwuEy4BK4bcxRgLIM7VWosfEynHhWAM17r39MsY7aVO6biWIGXuZlqs5FyowNVxlGvun+p0RjwJtg8h7nG3r65kP4BofvvyKtShcv3S4iExt/m7X7frlr/YUwn76lnOHM+TEHl/zx2ZaMX2O/gccOTTw7lHVW7OC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245617; c=relaxed/simple;
	bh=gh/2zF+GZngsA/vrBJJjr24YUrpGsOdq7tnmZizGJWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMEzkjmZfe5LswDIIcQQeIgISjHPqK7SQhpDoaLmDDK+vmdOJs5i4UFCEA1Nfb0eQl8S9OxojX5MAp7g8GdvoQ+0YIGCgazSPNxfqC9mLBPm1ChNwBEo+3aj+BI1aL3FNyvDMdqcrabo8Y4s2veyT7CyyggsVXZb93xcSNztpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO656Nvc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO656Nvc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485345e1013so9262765e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245615; x=1773850415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiVlNQOm1iWKBqBkvdKZ2iGbuTZBkTdRr/I+57FEuaM=;
        b=CO656NvcNLzH0OJz1H3e0huSOqwrPs6C32g7iAI7Da0jw0XmPPSoH5ZTZv2jN/yclL
         b4INMC+KJzS/JO59gBSSTb7ku+xoZrS9Mp44IhR25+4Z2xEW+NpsdZt6DgeZ2YJNmv0U
         LUgMIUtvXtfuft2E/cWbXJ8Es1x/kJJXpqpGTMkeDHxq1SpcajgY9jg0BLFBeDZXKkVa
         T9nupW9qPlYmEVM0dU3LejDgMPnOeCYaOy+NDgVhmykyYkoXLHPUevDMlL5b0aIazs1M
         x0SRHfEFhnHV9V9SjvcFHrzYjM9QoQ6lrSgWODMJqaHs9E/Vy4vZajjiWcCtxd0IUpl2
         ZDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245615; x=1773850415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiVlNQOm1iWKBqBkvdKZ2iGbuTZBkTdRr/I+57FEuaM=;
        b=s8yEg1mdtj0vbaT//fsch9REdCZ3wSE1SHhWpnf29yDz9COchCOyF0EX2JBtkggW2h
         HEAzfqE4lW6RfvAeVXYdeDZ44hIN43rJc0IAJ83Dkfa8JsUNlSXqPvtUL0ZYhK4f3zYi
         /1Ftze+vADLSd0yzp5EFKa9Ncrjk752oLc7TXPRZ5LNI6SrolPhAkvpCFWxo24KtAmcY
         w0FDVyONx+Q6+R5Yf+DqgUswJwZx30cKIWDGqi1seETa6Sgd77/8zgUWAOXT+h78FFlt
         tFHMKF1sdcbiSwz0GLC6oBPqZJ/dREC80iF4ZhQodI/vr73qqn7vCfaXmrvVGHL8yDY5
         7H7A==
X-Forwarded-Encrypted: i=1; AJvYcCWOMUonnUSS0nTIf7fzxZHb4QU9jWB4LJ+G/HG55mwbcjTQCDz2Zx1URFfZymFTvczW0g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OKJbvGOa4bAeWpJDCxGLCZPRxmbL/nHj8KfTW5bZhb0rd9Jl
	8hU7qG8pPotV0Fv7lZlVZC6+Wd5Z5pHfTN1I7TcVvWLCQJcqT3kNV1CW
X-Gm-Gg: ATEYQzwokbL3n//aesWmrp4NHtQHyxkMGU5xZBbbsoXZPhnfNgz4I4opksJULrSaMl/
	4FdwotMsjgp+XQW4ZZvQ6OLP+1zq7bdSk+HjEhYrO6mR5EWCsfyBS98V10Ykxj8Fh5aaZAKu9BY
	yZE55WvIADLi2mtGwBt1eAojWXPDJL8sOmPUbuFg4jiG/MSatgcvV49ncg/RT1+sLZ6oCUPi68Y
	DXo9URf1QMjbOpKazLxCM6OedykTj7qlo9hrFpc2balX5S2cBTNSaiMsR/442pm9S70kPJPnhbr
	mEB4R7pt4tr+K9l6WziA0m6/xxgkIYzbqSFP2QS7N3BswljjHv7wqRC5uXSkqifxmyLWmL0yoz5
	FdU8mVOUwOiM0GLOZeHlzkjfwYoaXX6+eLTa1cxjbrsfnOJJZlD5lO3TySAR94j29vxdbtjk8Uo
	icRVkGiImRwMUN2Fh/txXgXkRFY+CxHWJQsISNwzUjhnELte9RMdGTiwbAze+JRGUsniefjVBKd
	gc4Y7ZXxKxYEoitGULzmQngKVluyWrE6Qi72sLjeP/CwA9zBli5rQ/1cHE3pdIlmJQEyc48jxSn
	lvh0eT1FtjY=
X-Received: by 2002:a05:600c:310b:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4854f590efamr2633015e9.11.1773245614671;
        Wed, 11 Mar 2026 09:13:34 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0050f5e20850bbf776.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:50f5:e208:50bb:f776])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f406sm156122585e9.13.2026.03.11.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:13:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:13:31 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add alignment flag for
 test_verifier 190 testcase
Message-ID: <abGUq0yFfzUcY5Vh@mail.gmail.com>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310064507.4228-3-yangtiezhu@loongson.cn>

On Tue, Mar 10, 2026 at 02:45:07PM +0800, Tiezhu Yang wrote:
> There exists failure when executing the testcase "./test_verifier 190" if
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set on LoongArch.
> 
>   #190/p calls: two calls that return map_value with incorrect bool check FAIL
>   ...
>   misaligned access off (0x0; 0xffffffffffffffff)+0 size 8
>   ...
>   Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> 
> It means that the program has unaligned accesses, but the kernel sets
> CONFIG_ARCH_STRICT_ALIGN by default to enable -mstrict-align to prevent
> unaligned accesses, so add a flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS
> into the testcase to avoid the failure.
> 
> This is somehow similar with the commit ce1f289f541e ("selftests/bpf:
> Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests").
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/verifier/calls.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 86887130a0ef..29e57f0e56c3 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -1521,6 +1521,7 @@
>  	.errstr = "R0 invalid mem access 'scalar'",
>  	.result_unpriv = REJECT,
>  	.errstr_unpriv = "invalid read from stack R7 off=-16 size=8",
> +	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
>  },

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

>  {
>  	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
> -- 
> 2.42.0
> 
> 
