Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C73AAF56
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397917; cv=none; b=DxXhWjDpAd7RjUQ6RGg1xOAfr4HquUDKWyvlPfR4Vn71EiG4E6UZpDZ9kSC1qmsiu1e3JdXUFiPO4XIy1ySz50ASEX3C0Fht18veNbLRRL+dcz1rSwtr1w0VID88eeA+fiiCivI7oo6gsMPCVN0CWM8mjOxfobDnzScULppHTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397917; c=relaxed/simple;
	bh=SzV3R0Wcwyh2FU/lVOgTg5DG+vDRhxhYWHjHJ6y5zQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oe/p31SGsiMsi6rmJB7UrY6CBeOjVRLiVxXlXFCVGxsShDygLv+q4MKW0glNEyXXlSJCthaL+K0Yd7DmMaJ7RlZmZ0mIVD6ef3/C8i9yLroKsvmU+mzUljdXFYrvdZ8eiP9fdbSimSJ0jrfZJng6Va88eiO4mxwrPqo/grFSSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/F0ayQo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/F0ayQo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2338167a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786397916; x=1787002716; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SzV3R0Wcwyh2FU/lVOgTg5DG+vDRhxhYWHjHJ6y5zQc=;
        b=V/F0ayQoYUmPpwXSIG0/f8/seNpdyccp8EUezNQY2l/PxepvqjI2F/XpRnT7VIJkwh
         WOO3puGTQwg2a8FWoDYJ/s/aJqzd5gs0v8XQ9LBJEAWjhHDvmp2skg00bPnVr+1q7ubm
         Ku74ZJ7iWwzM+qaFut4UGev7dv5gRVO9KxBgjPRY4wyDwbiFQBPjBMWXfCoFdnJ6dco6
         On587JOWAcG68u92ItLMA6Ped91ojnDI/5duT3KZ2+WYhpgWDaIb7RhL6sy4BoaBUVOH
         Eac7x1aw+h6HtujUsWx1i/tsSGtF6mP3uutVKtEr0Ks1/k4IMi9gHdENoP8MKgr3UWC9
         VykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786397916; x=1787002716;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzV3R0Wcwyh2FU/lVOgTg5DG+vDRhxhYWHjHJ6y5zQc=;
        b=U5BCRL/VScsQ+3O0av+dbMRZwdmM/f5NZcEbt5Srvih6DaEYek0iGNUtFCd449EamK
         nnf4w12zBIJx0lpMX2n25qIppT3oDPq4V6hKysiaa4GGqNqy4xXKKZDT2ekj7laV8GFI
         sm8cLrUzF/zrejFqv9uyFMa0nM8I0GvtTlF4+Py//x2kjCiFhKBJgxpSBfJnSiSsXco5
         d79O/C+DdoUDVnLtr3stTZNamarRxsEVp0+E99r8iUPekoZA5Ih4o67va4Z/REqpQLwf
         p50lzeWFfNSzNvzJC5uZ7pGW4pdeM5GI+Mn74EEFmGKY09ksCeqZ+m3H4y/X95JjfjE1
         4Dhg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8NMeR0a3zC49I+pXkZVB9MiTqHDvYZefsv5oqB5YCK4/U4P+lhBxXU/ddPdU/uFXLZP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HuZSk9ior8uA3RPRfP8qW9ElN8fnKc+gjgEAlk6tbssDvQbv
	j55XHyIRWsFLOS8W47mC7Eec0tIlo9l8BHEcyP7IWwXoE5Qgau8iqevM
X-Gm-Gg: AR+sD12Uw0s/YMgdexo6qxj+w36djz1u5I/jkvqIvAqR8izJ90m2tFLkPnIUMwSPcLe
	S0MvHp9lU8xshMJwsfil+khJa33+eBWmraXD7KDMthFGdyx0V5czkXifUdRvZXlvuwuLDPMFi5D
	RmmlfDXj5qCFA5WCfVD7VWXcVcJD/vkhwt7OqcMiDcLayqrNUbRzZ/EeYwccVHZMf693stMUoyF
	+3uyazPdvGuFt8RlILK+RBMkUC31pY1l3IwAiVamljrSucGjWmjXU8FK0Lqa+hddHw2uMIsCQR4
	bUhB8EgmKmPnFq1khO82Rs/PecgK0VlfDi1wq1QUPNlH021HbToLkM91tjyLXqa99xYxmRClF14
	9JnrjmGZdde7ndCwVW7kf3KWM0HsTf9qX1tyRxVog1+1lbPr3tfcBRPxt7dl3ojzUxc8djev26K
	c92mczma4DiLysNTMKuPxGqyO5cMf9TZ9sr6XhMJfR2whHrA5+mtOGs6A7OgGetBXZnTTB1lgbY
	MzpsZOqQp79Fbl+4g==
X-Received: by 2002:a17:90b:4c8d:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-392cc9f4517mr4072782a91.10.1786397916001;
        Mon, 10 Aug 2026 14:38:36 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d53b873asm997472a91.17.2026.08.10.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:38:35 -0700 (PDT)
Message-ID: <fe4f216b5712bdd3212e049098d574314ff02e27.camel@gmail.com>
Subject: Re: [PATCH bpf-next v11 02/10] bpf: Factor out check_map_mem_read
 helper in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan	 <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
Date: Mon, 10 Aug 2026 14:38:31 -0700
In-Reply-To: <20260806163125.11172-3-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
	 <20260806163125.11172-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-07 at 00:31 +0800, Leon Hwang wrote:
> In the next commit, percpu_array map will add map_direct_value_addr
> support.
>=20
> IOW, it will add a map_type check in the iff condition of the
> bpf_map_direct_read() code block, which will reduce the code block
> readability.
>=20
> Hence, factor out check_map_mem_read helper to improve the readability,
> and the maintainability for the percpu_array map case.
>=20
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
