Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423065;
	b=FAWcArd0gAQcGm1bvSnK2F3Vr9awIPQ1r+XHHxPpnNae8YJQUhtvk+IX8rxcVCf5usLt
	 LKKo6wcTfHDumAnvU7MJdIFD8YSO2czxEn5iygpJpWuAmBNWzpYoAqZbJb3rMcXFFWdFH
	 j7WGODmKt3qp857CI10qKpcgoTR1KL1fJop5uSA8xHcRK2YisEMR6B4k3kv6FlmBIxiYU
	 f4okVHRorw5uB+ztX5dntZcns3aBoX5z1lbt4Vuu46mv19DXC1Yu5uiqIv+lizpt+O5zQ
	 KGHIn0Y0KUEOZKX9KDZDw+wPqvP99sGLwFqCPTtZcSY7zKDun0yrN02cWrTustJn+WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
	b=qfjIP70Xv6QJYQIxWWwKgVwN9pR4VYcF7hOmBeVrjZsnVA3GEKx6m91ZO3u4A1TxtRe7
	 8gKtO9GASyojQXYjdMG3VFxta+XjvTsu7nqHVmfN3utWuZvZctMaRxrbhodd77xVEJ+M9
	 tDdA/AEAr96ThA2YYibdmfYop7FzW5rYG3iYpvDum5joffmd7jmHIc6x6n2G8wfuy77Lk
	 HVL2bVGPd7g6eOXtGaERbEZ4Hy3bqMyx0rGTHH/C2mRbPzNVPolU1Rz2Tv5Dkcn4pO8jb
	 Nx8KS5TqCUc3M9uGWgxddslzE58i1iYkZzdJXn7XFU/L4bQKD9wx93luScpP35MDfkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIPoNmO5;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639B606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8639B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIPoNmO5
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a058315c79so728566b3a.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423065; x=1794027865; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
        b=VIPoNmO5V1OQxB4l6O1dkqLBmvX+zk2rhrYb8YTB7BWlVPpY81tN5t3t1DZiqLjFZ3
         +jeZKnhEBsyjy5VX+QPsS1QM129K2JXu4wMaKpXOa3lhG+igKhCAW5CLOzcmYa3ghAN3
         jNHlbsl02hZIA9OwBOFNCX9fI/ASYXdY48JZK4jkOJELBUZbxdMpHuyGL5xgE729QJ0f
         1MtlMDWWCB5Nm8iA0D88MdqEnpEVv92cqvw4+cHvmI1SAg3nPzsxYzAd7g7KfpZpl1Km
         5Hnosy+BXODAwLuxyYatdlfKNlDzzmarjAJJagEndOf9EIA7uUm+vTybobJiNwnRavPW
         wfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423065; x=1794027865;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
        b=PW4iQtz9Wdp9N0Pm75a7I+3O63xdxpXd/GDhK946aqoA4ZklTC3iArjrSZRh8mb2TN
         sAHLorPSISPo7THrG78k61gWJ5xIL+9Rn9N7qWqwpbrts9cDprDCwgQCBvMMTBhU70On
         TxyRzZsrz0a/3t/+sOB6KURHuwOZKlx+Mcxo4Nk9NFDaybDwdaPXVte8atqQWaQ8ciN9
         TiQbTHOaVwEsTivAJ7JZzzLM8ablke/2zj9OtZmg+ZiBsVB5/0AsvlJr7OLRtZVYagqz
         PWrHuTR3pv6yJns/SptlO3u/98Mmu1InAuyvU91ggmD7/+TvdQnjN0MFNPMnkltH+apP
         SFQw==
X-Gm-Message-State: AFq9FYJjyxzfSTkw1TCkkOulXQ1YTLJAHe2PoNV0V5sUeEE3x0R9Bxup
	/FwiQaLgdrns8T06PNNL4C5cEq5RuplDsPQdp+nlbeUvh6wQPwQZlRHq
X-Gm-Gg: AYBFou3pTkENTgS9YcMyfYI4SlvCNoPbekKAjbSEhKCnysSfc61urS48oGl+zD9Ralg
	J13jxhw4CGOQg944rL+b/PCFajkbxZ9FR5Q53tyGUN0IZviVeLFkszRbiS092XaztYglMx2jRzg
	5RG6/m0bM0YA/N9pBL7WswSNn4k6EOPSLDEBKwJbf1tg7C+lE3kUnnSVM2aGmQvn/Z9QVhYVo5s
	etZwCm+wN1DH/eBswKQtLYr33G7MLMaST+V1LSLFGIlEYphIILhaojnSNh/uo5957MCeek/GPfE
	n0LY5sBK+Wg+0V/LOLFsGglG3YSoBxHCXFbc6jNYRLetjjajmRKlyzdyVLCHirl9cRWFq80DktB
	hPfUCijqDNXEb+YKuaMaNyzojDlvsdsukikXMgNkxAdf9CijoV/wGGxTZRsZ7IBhV+xqa6kmUOt
	24TtcIUWPZnHOMFNpofWvzdXdcrVpQWpQHNqqwExi4HnS23IOzIGSIPPvUJ1wObEoRz3+ypa4Gy
	66iulFnCfgJURJVoUnGGbhqDDyirmwUTjr2e5xrGFKptK60sbuQM996oJIY56xstEas7eq3eeNZ
	XYgvTAvQtqxe5bGUf85nycMvE8YHn0kpgOar4rMb/0dXiC/fTeIEuigqPje/N3CeCtQtCbadYdM
	U8FpLQ5yrzh6yx0Oph65cEk1BGaLmUKKB2A==
X-Received: by 2002:a05:6a00:2408:b0:89d:f19f:5dd1 with SMTP id d2e1a72fcca58-8a9bdbd069amr3521224b3a.33.1793423064583;
        Fri, 30 Oct 2026 22:04:24 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada9ad592sm502093b3a.50.2026.10.30.22.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 22:04:23 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 05:04:22 +0000
Message-Id: <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "HyeongJun An" <sammiee5311@gmail.com>, <olsajiri@gmail.com>
Cc: <bpf@vger.kernel.org>, <simon@swine.de>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <tj@kernel.org>, <yonghong.song@linux.dev>, <stable@vger.kernel.org>,
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260822225444.2774461-2-simon@swine.de>
 <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
 <apC6-9YqBpOjFLGr@krava> <20261030012258.3005240-1-sammiee5311@gmail.com>
 <auUhrnOOUWY3Mb9y@krava> <20261031011900.1355507-1-sammiee5311@gmail.com>
In-Reply-To: <20261031011900.1355507-1-sammiee5311@gmail.com>

On Sat Oct 31, 2026 at 1:19 AM UTC, HyeongJun An wrote:
>  		if (!prog->sleepable)
>  			rcu_read_lock();
> +		if (no_preempt)
> +			preempt_disable();

nack.
The models are sending the same broken thing.
Pls teach them to read lore for nacks.
