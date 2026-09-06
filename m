Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D545000;
	Sun,  6 Sep 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725070; cv=none; b=clZHnT+Z8NuL8aZXPTB8vnDMNOWuERPwSFnHkYFmY7DwcFViG6sHxUWhpJuPkGKfapxRxaxGGewl/DpxXeJWctffSb3oP7WLT9UREglK20H5moZZuRSVwUzz4FKWnWlU36RXyNqwQQ5x3YEMlmOLkpOncoorg7piS+lmLJQzpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725070; c=relaxed/simple;
	bh=JPVOvrk3hQ+VcFj2vO1rQD4G3yjwIR4j76Ueb2ba0AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um9ucg1sx1OUuAjYubM51aLehBerjE14cJ1XO2Sxiqkc4lRJZiUsBA/zeFE0SBC/5QTTliHZUPx4hzlKz86qqrd/C8UUL/0Hej63O6dPS8ixRVnPJnXlRlSmkHcxyeQM8/5x1F7zzc813ERSZ6DJ2dvawEv0tPFSX022xlsOJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dS8iVYWT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dS8iVYWT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4QHEr5RNnX/B8Ycyp9lDz+5+6OyK0L0/ftWJKQxZ4UQ=; b=dS8iVYWTvY5/7ayG6uCT9OhCNV
	iS++VVuxTaQwfI7eSxWQDGVstV4AaDh9k/goXsEqp5D4Kr44ieZKJ74L0wtQWZKbAzEptJR8m5/uc
	+gF4fB4dJhht7aRIwSULaFkPz1EKUS+Mpi8O/hRyuQ47nOHFni1bg47nFGYI2vbMN7EfggIKTcd2A
	67jV2yzDDciTJ0kt7qC5CrIOg4PEYMeIj9luyJHi2/pjeRExg8dpCK10uZplG9GsVTxBUg/GSC4Jg
	X1TM4qcY2E0frT22+eIvzr++96ZISf/Nr/4nrzeczj1VyGLt9/ab+5fvwrVmmAdREDoSAaCHL2V/4
	kTdDdmtg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3J6J-00000005XMA-0ryD;
	Sun, 06 Sep 2026 20:04:27 +0000
Message-ID: <cf79ec23-8c36-4c79-b4c9-a00a8a09e82d@infradead.org>
Date: Sun, 6 Sep 2026 13:04:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, docs: Fix the struct btf_var name in
 btf.rst
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905095649.42351-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905095649.42351-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 2:56 AM, Karl Mehltretter wrote:
> struct btf_variable does not exist; the name is struct btf_var.
> 
> Use it.
> 
> Fixes: f063c889c945 ("bpf: add specification for BTF Var and DataSec kinds")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/bpf/btf.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 3f05f17990ad..004aa1058d85 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -416,7 +416,7 @@ If the function has variable arguments, the last parameter is encoded with
>    * ``info.vlen``: 0
>    * ``type``: the type of the variable
>  
> -``btf_type`` is followed by a single ``struct btf_variable`` with the
> +``btf_type`` is followed by a single ``struct btf_var`` with the
>  following data::
>  
>      struct btf_var {

-- 
~Randy
