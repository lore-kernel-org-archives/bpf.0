Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0038D6A8
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160357; cv=none; b=eZ7f5lW/1C9YnhbAeVur0nZjt3BoaUOK/YgwKMC90y2kErY5Aaxhel4ChvCSW4/Yo90EnoGtwE1kMGrgNPK2XdzE/qHOZ+6NC0nRhWp0LT6WBiHOUGUF52TL7tZRHk+1jiwR20PtfNGiPUcnAVgscvFv0cWk+tn51hRUf0+HzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160357; c=relaxed/simple;
	bh=qK7E/VQIaj50OPqk/z2E841MKsC+Ohcp80+feWqEM7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYgKWbrobjpfyHc//lkrTNaQE82E7qPl2PDcEX+Aiazr+xEHzgCEXRxhvxUFVvfV8mC1PEZOXGEcS3h9HqlIZc16OMPqtC9t4vnxOVLIsSLLy3YVeH8selhUdg6tIzz8YHzP9IyFJ+LnTlvS9ZD1EelG/DsHq4ninzr0ODfzdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lb+2AWPB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lb+2AWPB"
Message-ID: <f4a30d7f-0bfb-4882-8702-fc33f6cf23da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773160354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDJGGQicU7ypTn0pTCaFCHimhNhC41ESGW1Etv6Wn4Q=;
	b=lb+2AWPBoOCosPcLkGDDqg1z/dktsIqTwrZuTCIDLaWuZ+2wmGCLERWyNf4F1HBgHQFbPV
	z4lnvsAhkCd1CHsr3VUx3HXyB98zGFKCAzc6v6Uh+IDsEjzgBfVkZVuU7ERXWyBKpWypvi
	Wo2liJHx06PfenEh2NbwMS92jTevhgw=
Date: Tue, 10 Mar 2026 09:32:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Fix pkg-config call on static builds
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <abADBwn_ykblpABE@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <abADBwn_ykblpABE@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/10/26 4:39 AM, Paul Chaignon wrote:
> For commit b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection"),
> I suggested setting HOSTPKG_CONFIG to $PKG_CONFIG when compiling
> resolve_btfids, but I forgot the quotes around that variable.
> 
> As a result, when running vmtest.sh with static linking, it fails as
> follows:
> 
>     $ LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>     [...]
>     make: unrecognized option '--static'
>     Usage: make [options] [target] ...
>     [...]
> 
> This worked when I tested it because HOSTPKG_CONFIG didn't have a
> default value in the resolve_btfids Makefile, but once it does, the
> quotes aren't preserved and it fails on the next make call.
> 
> Fixes: b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index d5acbeba0383..65485967c968 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -409,7 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
>  		CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
>  		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
>  		EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
> -		HOSTPKG_CONFIG=$(PKG_CONFIG) \
> +		HOSTPKG_CONFIG='$(PKG_CONFIG)' \

That's an oopsie... Thanks for fixing.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
>  
>  # Get Clang's default includes on this system, as opposed to those seen by

