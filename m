Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE32D73A6
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440253; cv=none; b=YteJxojyuyi2VMyw0LNB/E9Flp9CKG8y8nBMZIcCrR9c5XDV53p1CRS8GDjGxGw0BH1vo7cY/deW4HTE+F2QIeswhowZT1lk62spNJ5di4ffTcXOxzG+VhdyYKaOCKdKjb5f6FqQ7vNTcYCQ4qhoAMvpnlP4D3ReuC2KxtJTu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440253; c=relaxed/simple;
	bh=qJOYykg3k4eC3ir51FgGbNxAxtkdW5wHBhJlHVMeZ+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FcHUUjlmpxI2F70FdvNtectfYvK+CO/wqFN9O/kECt8O7f0YI37dn4g6Kd3VN1lJEpjK4rI1J3RR/DOqQ8/6cVetf034hw6/L9al87czv/keHdvBDT3zWAVPiA73v1eJvDkuFEn3ahivXOhsMD+A266TZkqlNvsaXto1EU19oVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uYwf30vL; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uYwf30vL"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2e221a71e19so764516eec.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776440251; x=1777045051; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+zX0d52woQ+ViFsb1fpfCdNLYH7GuhjXHpJH1r8Tuw=;
        b=uYwf30vLHaK2nEPT18AHQZBf7PotohwYfBd/Cbf81UxjWX0Uk28NxHugQX7eLRC47Q
         dD21jaRtv0JAntAiwIhojOsyEKLn/3gAA55C3sEALs4PKR5IeiiHRFC+uYINWIkKidki
         Subzy14VpMAccP/loH8z2LP/0N7eNR4v7cqXtzKDX5qKI0Mpmk7q0sl3OsadbC8Vmbpo
         mZDEgKA/LoPZFISfbBuGsJTpygnpcAM8iQXWKMmeobcKydWjAjr7eORFNRkj5KffSmeG
         ka6dBhT2Wz1pZIbc5zlYF7wUEidTRSMrNnRTBVgWHm/3VrlnZTaK/xeX61MMUyXxsoKf
         B75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440251; x=1777045051;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+zX0d52woQ+ViFsb1fpfCdNLYH7GuhjXHpJH1r8Tuw=;
        b=SKCEYhkC5PfONqIakVMXHqdpVMxAUk4duV6GECbuks5HJvPop1xDginAbG55dmLe0w
         jw/lKG9bMIhp3TrnF7zICSmwV7qX28iiTTAoDtPiCsCWpjgO3H1DMPA/E902szl/oEPW
         XJm7HVTuCwbD7q+CoWNl+fmzOXhBiUrXRppyrURDHdBuGwEOM9xdfj7B8SUD0RmBI10r
         Qzuk5Pt8cOQOAOaFGAXBu+J5Pbx4Jy6tav6jqnXIm2qSxVOFiOm2p/aEQQirG2lEWttR
         mPF3p25218/let5/kurU3pdzjsxSdjxACYSatZZNuQzEuFidQ5ms2kXlAw5scePvPEDl
         siIA==
X-Forwarded-Encrypted: i=1; AFNElJ8Fujom7+GJdW+FsV5MbA0zoxqL9izsezLyGlkGAlxlZ6KdGuNl1ZvpbJFTGaxHMMnyDts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWr/tvVRIP9uymqI/KRVCK0oHarwqrAqKTCO70enWBir09aWVK
	KmVZ2TPUmw/3cnwPVcGG8uhQ7/qeD5F5jVZ8BM5qMafz1rd8eru6yUJp9tLA/dp3Oa4=
X-Gm-Gg: AeBDieuStuGaPnsXb0mDX7tp3EvvvjzObl/KBbE90m0nnuMJ7nfrk6UyMo9beq6IOW+
	UWVjm0C1roKYhCf2pIigQ/+MuMAfmoKTH1MfzhC8E+rRFq0t8DHuqO/SPewpmnG81UmtrCBbm7J
	YTzDnEXtskfNb5KYlz1ihQGcZeEWwGdBpl2Fg21+MRVSMHHrS0Gk3v9tfydbX/RbfG7ebI2RTNY
	90rrsPPWGr/3U9FHAgPFFa2KQO8K/kWTxmHGeM0LRkTfEQRqPAjM2zbLoGcjpxdrBi5bvRcyqbq
	GPTnmfD3VTmm6u2RGWLpRiDQLnTYf66/o92XwQZ/JIeaSgpMh5DMi2ib/X5JENq4+xvEubuvDt9
	NekxWSbDEQNE8EcNLj8xoycVJMXRc3THmQYxEicQ/6eoFQm5/CimAPpI/Erm0IKAHIcJ4iN4toJ
	69qJA2fCeMDbsucl0=
X-Received: by 2002:a05:7300:641a:b0:2dd:6937:79d6 with SMTP id 5a478bee46e88-2e46c48a9cfmr1224775eec.7.1776440251013;
        Fri, 17 Apr 2026 08:37:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm3044626eec.1.2026.04.17.08.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:37:28 -0400
Message-Id: <DHVJIG5WP7TI.2BAMIULKKWRDP@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf] bpf: Validate node_id in arena_alloc_pages()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260417152135.1383754-1-puranjay@kernel.org>
In-Reply-To: <20260417152135.1383754-1-puranjay@kernel.org>

On Fri Apr 17, 2026 at 11:21 AM EDT, Puranjay Mohan wrote:
> arena_alloc_pages() accepts a plain int node_id and forwards it through
> the entire allocation chain without any bounds checking.
>
> Validate node_id before passing it down the allocation chain in
> arena_alloc_pages().

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Without this, out of bounds node ids trigger VM_BUG_ON() down the allocatio=
n path.

>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/arena.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 9c68c9b0b24a..523c3a61063b 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -562,6 +562,10 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>  	u32 uaddr32;
>  	int ret, i;
> =20
> +	if (node_id !=3D NUMA_NO_NODE &&
> +	    ((unsigned int)node_id >=3D nr_node_ids || !node_online(node_id)))
> +		return 0;
> +
>  	if (page_cnt > page_cnt_max)
>  		return 0;
> =20
>
> base-commit: 380044c40b1636a72fd8f188b5806be6ae564279

