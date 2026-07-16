Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD039656C
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236338; cv=none; b=J3iSNN9G1dUL5gDbUhaPDVzw8anPUy0z1jRKlEKjGUZdEBTCIRReMEOaiEIfDfO/qePZ+JEl0XkQeKIzAXKRV9SZ6ayzyMeRLpbevTaENzpt+cXCFrl378b6L+c7pBySCI43693vroARSavAs8fLZgLGOStCOUTUP27aA8RtiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236338; c=relaxed/simple;
	bh=OAfuTQuZNdbhaFEEdyuBkllBsEQNJsB+dU3NH5bQFo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWOz5YjeeH/UBjUdNKse2Wwfewga03UYJilTuuPN5dO3BS/JrYDPoJ/ZzHgUrTC8v6TmuNwZLHnaokgut8jEwBADHJbYU+AmNxBWw2jpxXBBy7syyaQiPJsxKpP9J5Ks+oLaCEmu9m5YqMeQ7ZDIj+gI1ou40zFvY8u/Iots/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mjx6IQhB; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mjx6IQhB"
Message-ID: <963657f1-dccc-4d31-8b00-0c291eb2b6a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784236334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YtCTfnohGfsA1Zyh4Jx/5RVGYssXFweofaXUd2oxgQ=;
	b=Mjx6IQhB7hqV8alVTRbcd6sMczNBEZjLoR0HM+O+Oo6CcHyzkEo1wOWbx1Il8YWjfrx5g2
	w3BscOBHCcxg/CM55S2vTWAJn0dNGjsvpshEcNqM5IclWjH+dlLkbp5IvhKgYye6B96py3
	mNNpHiZruW+pO6DtKx38kbDKVdnToQ8=
Date: Thu, 16 Jul 2026 14:12:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] libbpf: Search /lib64 and /lib in resolve_full_path()
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-4-aa24dfd6f4f9@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-4-aa24dfd6f4f9@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 3:09 PM, Ricardo B. Marlière wrote:
> attach_probe/uprobe-lib and uprobe_autoattach selftests fail with "failed
> to resolve full path for libc.so.6" on older non-usrmerged distros, where
> libc.so.6 lives under a top-level /lib64 or /lib rather than /usr/lib64 or
> /usr/lib. Add /lib64:/lib to the search paths, alongside the existing
> /usr/lib64:/usr/lib and Debian multiarch entries.
> 
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1368752aa13c..1ab939dfb7f0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12973,13 +12973,14 @@ static const char *arch_specific_lib_paths(void)
>  /* Get full path to program/shared library. */
>  static int resolve_full_path(const char *file, char *result, size_t result_sz)
>  {
> -	const char *search_paths[3] = {};
> +	const char *search_paths[4] = {};
>  	int i, perm;
>  
>  	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
>  		search_paths[0] = getenv("LD_LIBRARY_PATH");
>  		search_paths[1] = "/usr/lib64:/usr/lib";
>  		search_paths[2] = arch_specific_lib_paths();
> +		search_paths[3] = "/lib64:/lib";

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  		perm = R_OK;
>  	} else {
>  		search_paths[0] = getenv("PATH");
> 

