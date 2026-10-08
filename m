Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A837701A
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476452; cv=none; b=OBWv4oC5WHO/Hi471ivzRiFd3qyRZdu15uoPHi7TDOw6lnVjY4cVFbJPeptXawCJOXYTtmt/GnUegqbDS2qaqc3mhJzyOmlAyjA2+/atuuCJwOwY/VEtUlOmYGn6kehnCGFNjFX2mUvWbJjEZ2D7bfixMBnw0CBR1H7B1anHqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476452; c=relaxed/simple;
	bh=oiOvQrLrDsFAYSYqzszc4vNV5GzkvTPljnqg6ScHE7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfcB3Gj42+cCkJCQbLqdEOf/cDxHwYsfB7ACscEbQhYY2nWCQmjpoOTvenRyTkLrzRnecbJ43CjCoe+FsZ+l9Uv0pn44a9HJtJquEjmsEaEZ/+KKa7vYSPJrJX+VJeuPGKehbESlVL+kEhx8Wj5yLTG4qYd23SuI+7fSUYjM1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATg5R08g; arc=none smtp.client-ip=91.218.175.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATg5R08g"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oiOvQrLrDsFAYSYqzszc4vNV5GzkvTPljnqg6ScHE7A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791476448; v=1; x=1792081248;
 b=ATg5R08gvXyF/He4U8mOZ9ifEULID1WoAYTJF7syO2GheNP+PADLLAK+015TtICrQQbN5d/g
 mXsBLaoqYt2MR6xok0+PcxrAhxRdv6Q3sfe+wK/uUgFiR31sCFb8zRDjhB/u0K2W/2t3ngHPnY/
 DczhAkGiCeXRmOycDMIiK2tw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c88f780bbe21711;
	Thu, 08 Oct 2026 16:20:48 +0000
X-Mizu-Trace-ID: 2c88f780bbe21711
X-Migadu-Flow: FLOW_OUT
Message-ID: <6fced0e8-8101-4665-a15e-8adb8615a186@linux.dev>
Date: Thu, 8 Oct 2026 09:20:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resolve_btfids: Fix the --fatal_warnings exit status
To: Petr Pavlu <petr.pavlu@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261008-resolve_btfids-warnings-v1-1-0d4e613ffa6e@suse.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261008-resolve_btfids-warnings-v1-1-0d4e613ffa6e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 8:03 AM, Petr Pavlu wrote:
> The resolve_btfids --fatal_warnings option is intended to make the tool
> exit with a non-zero status if any warnings are reported. main()
> initializes err to -1 and uses 'goto out' to return this status when
> a sub-operation fails. If no error occurs,
> 'if (!(fatal_warnings && warnings)) err = 0;' modifies the final status
> depending on whether any warnings have been reported.
> 
> Commit 522397d05e7d ("resolve_btfids: Change in-place update with raw
> binary output") broke this logic by assigning the return values of newly
> added sub-operations to err. As a result, successful sub-operations
> overwrite the initial err value of -1 with 0, causing the tool to exit
> successfully even when --fatal_warnings is enabled and warnings have been
> reported.
> 
> Fix the issue by setting the final value of err unconditionally, so the
> code doesn't depend on its previous value.
> 
> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> ---
>  tools/bpf/resolve_btfids/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 37d7e7224207..2a93517ca9ec 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1842,8 +1842,7 @@ int main(int argc, const char **argv)
>  			goto out;
>  	}
>  
> -	if (!(fatal_warnings && warnings))
> -		err = 0;
> +	err = fatal_warnings && warnings ? -1 : 0;
>  out:
>  	btf__free(obj.base_btf);
>  	btf__free(obj.btf);
> 
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261008-resolve_btfids-warnings-a356edc7a5c6

