Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185C33F59B
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318233; cv=none; b=MxgaHWPTB9Ug/B6kSTFhO//h7NBDsEgwVe0M/sp9I8VrW4TxKW8i4roojy8W1DUmErIF75Wqdarj077MnPkcdlqZjzNTm27PSLSe2Kz9djlj+U5f1cB2G+txXAb1TmHk084YQX5maNHYo8ZMLZTRuOxHqnyRsGGZx7nF81drD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318233; c=relaxed/simple;
	bh=rgnKUwrllWVBX8tdeyT++ukKf9FFYztY3aJGWCc53NA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbWeACk6Rzc+RAJiqlNY+2PfVOiVSZnzejWb27cFNdMtvlMNlbJf2iblUtXcxjn7D90VsC535PUGjEdRSfzSStWS5AHK8rAKwJNl+PtDVhBo9tBb3iAV6rg5C4kotT1z6/Dm2jsIDhtvmnrQ0AzFIFWVwO3vmPLQGlR3gcTFNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8GM8bJ7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8GM8bJ7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so8137750a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784318231; x=1784923031; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1drwqF9ISvvApOBqw7YZqj2vwJWSfVOtnjvFa7bDezs=;
        b=n8GM8bJ7DTqSheMEffaszUd7YTgjf3ug3cUmkREk/8260tGH5IEkbot3hOlBwIrPL5
         aiUs+1wem8xRxyUQ2TFZFwFULXdlVmO+yDh/l5AqnI06uDW/ztdTPKZHI7FZx/ruSI+9
         z+JkF9/RV9MLWJaKszXR6I5sH+3mvCCW8i8dBXNXcRuNv9s8kr0MvKg94jQ1HuH6Z+JI
         ghJOwFjkSHBLAT5oAxosAT1KqQD8iSze6vtSaC+Kz8KBc/LsLs+1QFktxG0GA+hKCBv7
         b2uGSPDMm9jFCK1F8fNTCG8OU0aJKuOmXWTt1z9i2HkTbKn7xdEFGNDf9ZZn6iJflPV7
         rciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318231; x=1784923031;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1drwqF9ISvvApOBqw7YZqj2vwJWSfVOtnjvFa7bDezs=;
        b=mMrdtcPlr4QTr22dTJSadU1AN2T6DxYi1uB1HsaPK+IrW09BJ0thIW1M1qMxO+w/Tj
         jbiLujneX3nADr5LtoXtpQLUo+DC8kefHPPwMol/Xef7ANW3nAwMkHhr7e4XsuEF2Ka/
         FXOJAqmu2kxTHYXVscV2Q7461svMcN6TNv3R8RxdTvv5azPBSvXB9F2BUlBBcoDUtlVN
         P1PGUJZCfpSlAMyVKfa1tcoTsXYqUqDzcfR18aV75rmloxF3yS49jbLltENAB/DNGRgO
         l40m0scKiT8I+Q5QqeWRulOgKJH1bGU5OE5vfQLzVU+UKvnPDbNdPxqnR1pv6rIemVT5
         q7hA==
X-Forwarded-Encrypted: i=1; AHgh+RpnSOk4BmLHmdpQb/7MWW5sSTA791Z6sBxuKagidpfitLDULo8RMlfKyAsQWfqU9C9Dxqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlnRQKwffwvBIByxaxMj4jQ94tfIcPFnKrWonL5NArqTNJJPA
	Kh1J5EXeSTxMKGN6wLRsMZiYaFJ2lL/2qzbGOQvSrkaAnhjpBQw0RavtVcZY4kFS
X-Gm-Gg: AfdE7clgmdVyXQglOGw2juLLJlB6EG9UhjzGf6qPvtC4v6+nboG2G829Znc6QFnaHB0
	gYiSPwW6j98i/3FWV/oXjwC9WxY6KLsUb9+VcIz+lnRSYyWM4iWcLlqoat8RD99FLK4MpBizGQk
	l7e54mDKZvBO8gavrKFZXfRbUBrY/x6/TCVNT/lPFoOBx+X9AQloCSQB/L7SmExePxum4ia5e/7
	r4tock5BR+nUZxguvFBkoflSm5JX0cVPXlGZj53ClOFCVltc5nvrwBTRrcousRriWDL//P4TF+t
	X4hY/xqLSDK0xwOTkTgqn3rBqfIQXz+LJbga1WobE7uPVZA7d0aE/UdwmmijTRo9hnZ2Rk4XWFC
	4zaquniSKWoZo34OPqj+bI7iEJ5A/vCjklKd9sEU10F+T1SHfYNMeoupVrotMAqVNaAyIvhKbau
	i2Px3IzzYQSWZHDZ1h9SuAgpnVhYRfIAiZ27m7j71oVVkb1TPEi+Eo2UvuGA==
X-Received: by 2002:a17:90b:52c4:b0:381:85c0:1d88 with SMTP id 98e67ed59e1d1-38e4b417454mr4428700a91.9.1784318231429;
        Fri, 17 Jul 2026 12:57:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:87e3:2c3:b68c:94ea? ([2620:10d:c090:500::1:14f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbda9sm9410657eec.19.2026.07.17.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:57:11 -0700 (PDT)
Message-ID: <0a7b6bab6aa1899b91435a4a1ab9c00deb756516.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add bpf_for() benchmark
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 17 Jul 2026 12:57:09 -0700
In-Reply-To: <20260717120215.2171057-5-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
	 <20260717120215.2171057-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-17 at 05:02 -0700, Puranjay Mohan wrote:

...

> diff --git a/tools/testing/selftests/bpf/progs/bpf_for_bench.c b/tools/te=
sting/selftests/bpf/progs/bpf_for_bench.c
> new file mode 100644
> index 0000000000000..920f8f188e864
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +u32 nr_loops;
> +long hits;
> +
> +static int outer_loop(__u32 index, void *data)
> +{
> +	int i;
> +
> +	/*
> +	 * Empty body: the work being measured is the open-coded numeric
> +	 * iterator itself (bpf_iter_num_new/next/destroy behind bpf_for()).
> +	 */
> +	bpf_for(i, 0, nr_loops)
> +		;

I wonder how does this compare with regular for loop that also reads
it's counter.

> +	__sync_add_and_fetch(&hits, nr_loops);
> +	return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +	bpf_loop(1000, outer_loop, NULL, 0);
> +	return 0;
> +}
