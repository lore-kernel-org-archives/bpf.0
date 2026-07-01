Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB248164E;
	Wed,  1 Jul 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910712; cv=none; b=eTrmCPAT+U8KS0HTGVbG5L8jf3Aos3K/wIVk/fbEZwVVaAzIxp+g2c5T+G7qcWUtlb+Daoxb+AuHm/lOt+C/VAv0Uk7lXNHHjrWZ8yDMJcMX60zbgfs0SO5+ydtHgMYTk38fJkP6FVPHSqpGST4rFlflZge4p8Tamd5h5g10W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910712; c=relaxed/simple;
	bh=X6+Ed/rEBsM0mhD5765NizcuMwfcFMRRKO084L6xu5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iExhyZDlQerY51kVd5eM69DA1qoZb/YFEjsNKrwx/UMneH18PC0V+ILp45M189xbal2YEBJm36NdQJx6TeIfyPMhs23HbVRH4xiLeXgkD1RLVeBSz+X1jPnnpWttMRlP5GLeyaRG362XeiJpCXzuH7essPl5nBqL21lPOZhZnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICB0MHFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICB0MHFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88921F000E9;
	Wed,  1 Jul 2026 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782910711;
	bh=cb3O/VyxDadr6oiJCDw23h1PjynN9DETCw14go+j4kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ICB0MHFpt70FvaAHO4tDPy/YdWgz4PnboNPnKWBZYdObbzY9cG3c29SvifSKxTd0z
	 D+tKqsf2aiM+ffkp96WsBXg4f0/mWNzBPxZMJy3HGx3KbhfdbAHFOPZvLAMTZIccbr
	 +h6yRw3D6by8nD3vhjryZ6YcoNgtK3OIghiXt4PFwrj69dc1/C6d3nOO9nCuX2E03a
	 tIcv2qynHmQfiluSNVuDWulh8cJqzQnyg5k8xj8XGkBjY085gaO9f2JL1+UA6x2Z0j
	 zFnQJ2x/D2klrRsNRpkSlAu44eaLn05u8v6qzW50NgXDC0ac6k351SxMst/zWA7rbP
	 tqgBkbB1HhR1A==
Message-ID: <281ab70a-aaf1-41b6-8930-c346ee938250@kernel.org>
Date: Wed, 1 Jul 2026 13:58:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers
 consistently
To: luoliang@kylinos.cn
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260701062541.704792-1-luoliang@kylinos.cn>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260701062541.704792-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2026 07:25, luoliang@kylinos.cn wrote:
> From: luoliang <luoliang@kylinos.cn>
> 
> The btf_vlen(), btf_kind() and btf_kflag() inline helpers defined in
> tools/lib/bpf/btf.h are thin wrappers around the BTF_INFO_VLEN(),
> BTF_INFO_KIND() and BTF_INFO_KFLAG() UAPI macros - each one simply
> returns the corresponding macro applied to t->info.
> 
> bpftool already uses these helpers in most places, but 13 call sites
> in btf.c and btf_dumper.c still open-code the raw macros. Use the
> helpers consistently, matching the rest of bpftool as well as libbpf.
> 
> No functional change.
> 
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you
