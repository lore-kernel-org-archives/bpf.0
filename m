Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30692F8E8B;
	Sun,  6 Sep 2026 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788724924; cv=none; b=nQKwOr3MlcUF5cU1Fk10OdjP95XutWBuPUl0bIvx4twwU3u3C7XKYlvPpqtryu1JoeWenoK80s447SVzjFR/3Q1rrVvzXYPQrqK5AFG5u96pDvS90+SjAcgQjCmU/DJrVexulSWwH16MkK4Szq9KkXj05u2UauwNhgCJ4etSh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788724924; c=relaxed/simple;
	bh=maWYUBR7boBnTmN0Rw9nL0O/EWGJ8nlcJ3NTW0yEph4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka6tKwD8qnxgoDIGgLHRwhacmFOKQk0m/kIMWpxl8lPGjMgEgnvNPlm6FHexSL3BtCXowL2x5dgYYS+lp/rrFMJ1KpHQIgP/H7bXVsnWgyOa2c4jJ1cJ9Ec/d4mrHSDmJvUydF2E3gabMRZFAKFw+0sitvH8NFjBaGaLAfWvQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K8n4wl5v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8n4wl5v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LrJ+wJeK48FFPYraHpngTsAxv2pVqxk4iZmUGzOy3So=; b=K8n4wl5vaBUoBpJ+aFGglZ1iI6
	G9OEv0nfeWaTklbDxwRDFskXZw6qPpGy3lFrh3F3BALQKuUG5qGtEgta2QmtLPAzYokAJ3f4lFUjD
	5n+DYaA44fohzedV+AqObN5pVltshxOE3z4wjTo4acH9MOSfESHziS/e1VCbHDmxzxKbRJ8EXThK9
	tn0B7DTgHJNMUhs+MxFIxGTjghkwXMAb8QvZ0xmDcJlE7aB027MMuD1OjWe1M4mTBpHXLrT7xTNgz
	XyNYao+XRdv9qglxvUNtKWn/DTgFh6n5AzNtTk2h08G/dXAHlEejZX5kL77uaHxRtg+IzJO+MfzWM
	a3nOpRJQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3J3s-00000005XJt-1Tha;
	Sun, 06 Sep 2026 20:01:58 +0000
Message-ID: <2bd2506c-c39a-4a30-8f9d-29e4a57cab26@infradead.org>
Date: Sun, 6 Sep 2026 13:01:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, docs: Fix the struct bpf_cpumask name in
 kfuncs.rst
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 David Vernet <void@manifault.com>
References: <20260905095527.42261-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905095527.42261-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 2:55 AM, Karl Mehltretter wrote:
> struct bpf_cpmuask does not exist; the name is struct bpf_cpumask.
> 
> Use it.
> 
> Fixes: 027bdec89364 ("bpf/docs: Document the nocast aliasing behavior of ___init")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/bpf/kfuncs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 85f73e0bbd0f..57831eda0a33 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -536,7 +536,7 @@ For example, for the following type definition:
>  
>  The verifier would allow a ``struct bpf_cpumask *`` to be passed to a kfunc
>  taking a ``cpumask_t *`` (which is a typedef of ``struct cpumask *``). For
> -instance, both ``struct cpumask *`` and ``struct bpf_cpmuask *`` can be passed
> +instance, both ``struct cpumask *`` and ``struct bpf_cpumask *`` can be passed
>  to bpf_cpumask_test_cpu().
>  
>  In some cases, this type-aliasing behavior is not desired. ``struct

-- 
~Randy
