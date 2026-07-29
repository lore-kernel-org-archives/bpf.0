Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59F27D786
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289146; cv=none; b=KK/MBwaVpcbi/ztOWTy/6AP4SamuAv2h/oA5xkOAWsjhekvoToGPPkCQFkNdiaCONu8+eKdark6tnah2IGKsinkP5adE14/DgIok4c+xYKmj6nJHexQRnuL9Gyz8LOLJpGZ6wdvp7/SlKQSsWz+Bt2+8pELTIF4ku0Qp4TVoHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289146; c=relaxed/simple;
	bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2Xih0erk7EOC/Vhl5yV4QZ6wvFe3zAEX3qakhRJtgXQVn0i4ScyavUF+4lk+QuLZphjVD580FFfHhdqMF805J7Cfk/XU5JZ0NOZMzeyzeDWg5egUD405qkTz8CglXQA3+e7Ok7ieNz/DNF0eoNYUBxY92kgKOk1FBVao4Qo0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev6H/Uy0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev6H/Uy0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso500093b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785289144; x=1785893944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
        b=ev6H/Uy0+liZgABgp7hkz9FiueeYaWtGxjHTCyaU8Ji9T+dBxMDwmHtI8jIJI4/vl8
         559QB7CV436QbGytLpVjTzBhDIW0EryFY8yH3YfyRabQUh252g+RpIqKqYQ/nfdo9uBR
         oOjEuV/+km2uapamPxnWhq07gBKNECEnZzIavMA91/Kg4052J26mgp6Wf7XmpK/IYiT6
         0O312EnL+ZIUq/C1pYI9F/JyUBP0w9AiFiC8j5754FQd3up1hzzV/lDWu5pp7vE6t8sS
         PrmWo4s+R3RMzjKUiszLYqjXH3DBgN8VkDLs8XVaN7Nh5MsnW+wniVCwElJwOLAiyLJL
         urUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785289144; x=1785893944;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
        b=ZumZdWetPjrH5tVIwYih5ngf+b5Vyt9dmdmvw3TBdMJJqU0ZWG20mTSU11HVZvUir+
         cr7tH+CX0W4pZ6uMtRry4rvlyaGmAMU1ltvma5u8X4NEff7uyDe92pVboYHr2r3dJykA
         e9l5aROyZHEJo4AvqfIk/DHK/VnVfwPTwj3vGHWuJ4nenb7YAVc5IImOhQ9T2KALQ96h
         InqLLrFU+9EMkG1FH1Ml8w+Zoty8F42u+sHM3PjHL2ThYOvFUMyFE8eyJzhkRPHZ/VqC
         homgX5Hie/DpPOEK2c3N0YxZF7JqWaq+b/vCQSFbStWP3h7lsW9MZymTMumKvaWGwsPE
         P3RQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJpJ8OpaW/egS49jJNpzs1ssJhdfFvqHA9xIzY3kANwt1wummiOMfEGJlHZF/4a7cp+r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCy3eYOw7/u9IDrP9kE714PHD/MoOGicF0m7DtZ7WEwOQUYCxD
	LvR9R7hZeG4nJdxA4Rq0HiSLU9+sYfks+CX8FlMotsDX19E9UzOQpekd
X-Gm-Gg: AR+sD13+HYRhShO7bWc1eVYGjD6O2RUCJeynQpy0Dm5xkxKWACXFjiNq78RyrgFJfg2
	e+4U1HiB64EFUlpBG7cDtXA4WcjxpmNBwCumJ1dN5r6sUs+fdvYRRRKuM1XKOXSTzgX8re26dO3
	ix+wZ4MIq814XBnA3z1yCPRIFV6MZQ350su95mB/8NtHm76c9mN23JXuSxMS5MBYxnwPOXtAhQK
	zJBCQVHZ5idxdnUHAs/e0PzX3Xyp7akIX1cHxP5sVwNGkBuelWjfrIPUyeQ35URMvwaOsv0nZOU
	o/KYCDWsjBoxNovuk3IdOg2qbjL8//0Z1R4+MWWdmGQF1Zk21k3zyTFAtLUF0L3dKCvRVzewyqI
	izdI4qb9JKdTkTnYyPmsGzb1qPdiQwA8YIsyTu3OPv31jLGImspu0hPIzfBRoiexgIuDBq0fI0M
	hqsUbQaY+Y0IvAbmnGfFRGJeRo1TO8cyTncoKDzhkOdt6s/DwtX8c5X8T8PthW6Yly+yfs0TRG6
	PNxWfphaPPMLB2D56ORZA7XmQA5A0xYtSkh8Xdwx3JsNm5mVRT3iHRKGoDMiiQ=
X-Received: by 2002:a05:6a00:1396:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84e93198bf1mr4947632b3a.3.1785289144366;
        Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
Received: from ?IPv6:2605:8d80:58a5:c474:f5cf:239:70ad:a743? ([2605:8d80:58a5:c474:f5cf:239:70ad:a743])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm615408b3a.19.2026.07.28.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
Message-ID: <fcd03de340be36340b293d393b731f0173749627.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] resolve_btfids: Discover kfuncs from
 BTF ID sets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org,  linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 18:39:02 -0700
In-Reply-To: <20260722233518.778854-8-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> collect_kfuncs() currently uses bpf_kfunc decl tags to identify the
> list of kfuncs. The decl tags are generated by pahole, which makes
> current implementation implicitly rely on those tags being generated.
>=20
> The authoritative source, used by the the BPF verifier for kfunc
> registration, of functions being BPF kfuncs are
> BTF_KFUNCS_START()/END() declarations. These are BTF_ID_SET8 under the
> hood. Currently resolve_btfids reads kfunc flags from these sets, and
> populates them with BTF IDs.
>=20
> Implement kfunc discovery from BTF_ID_SET8 symbols in resolve_btfids,
> removing the dependency on pahole's emmission of decl tags.
>=20
> Walk BTF_ID_KIND_SET8 sets, and use the address-to-symbol index to
> look up set entry's BTF_ID symbol name (before .BTF_ids is patched),
> recording the paired flags directly. This makes find_kfunc_flags()
> helper unnecessary, so it's removed.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
