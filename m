Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41884039
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313004; cv=none; b=D9p6L+B83yJw7+ek0blpp2yK1WyFmud3yixZZEZc/fRU3tLZnqjw5CYDzAugCy1lh5oG/q07pPgp2z7JeWl41DIDZR70klwNKp5xdY98cMpo8N0cmzSoLUI0FS1XfbMkTqrf/nA/GaXGp4wHnDJaLDQSDycwbHEDLA5EIQTh8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313004; c=relaxed/simple;
	bh=3IYf4nFqEuhKYAs0qSBdcbMMZB8b/ZMFbnevmr2S0aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8kiO5cUNvzfD3KpuTAejeNPCeahaLTC2t52kUy+E0anTCarVfRGZ/IZD1tPUVB+PbXmKMz9y4CdqfUWV/I2P8OtlwhsgOyJ1nUnNDzu2hP9ARcnNRcNF78uhMhAaBy9v7fFDbySLLJy3BX+Ssl4l4Jt56FkBQhTqC3jMDaZf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hbljm5Q0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hbljm5Q0"
Message-ID: <ec393874-c497-4943-86dd-3f9b5f93b49a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781312999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yqm6Ma13HVSNAEaBNT//aY4x0WUrJAMWPwAZIyMYak8=;
	b=hbljm5Q0pV5/uev/vLsZ5rG0G0KwwT5B4bv68MjvPm480DhbaJhXuh3+lYyAdLKdxH1CXU
	EaUGWu7oUOTEcfeFpIPnXVvNMKNOdImSgqcrPnOaJyWHvwtUlUUjVdcRyfj4TQ3TbiRtEV
	Z5dCVJP/jUpCDPICVZzNGmlPKecvof8=
Date: Fri, 12 Jun 2026 18:09:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/8] tools/bpf: build: Append extra cflags
To: Leo Yan <leo.yan@arm.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
 <20260602-tools_build_fix_zero_init_bpf_only-v2-5-c76e5250ea1c@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-5-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 7:47 AM, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index fd2585af1252669c59228af3a77320e449e1a1ab..9c19e81f3c274767c3b9b94c907cbbe3ce9fe78c 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -11,6 +11,7 @@ INSTALL ?= install
>  CFLAGS += -Wall -O2
>  CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/tools/include/uapi \
>  	  -I$(srctree)/tools/include
> +CFLAGS += $(EXTRA_CFLAGS)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  
>  # This will work when bpf is built in tools env. where srctree
>  # isn't set and when invoked from selftests build, where srctree
> 

