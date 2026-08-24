Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7492DC792
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598254; cv=none; b=LYqOEwrBMRHeP3EgEZjLwV+PTsI5cBj+xi9VQWfP4s97ZsAf+MDdh4wvZNPE0lBqjTn6TeGS829XvSsqNZmpecROfEmWbNWodyaClK9YlQKgkLuCrClTX/qKoCQKOYgY+gxXVpKa+Md0JFPDh7wY+K3MzxFJYZVAJ0Gn6LjyONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598254; c=relaxed/simple;
	bh=ifS68cnf0mrdMKmmkO/kw+0T1B3tx/a6Z99c7ONM4kk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwBZSNUVmlROOHi8dFppNy/KOBJ1UMEOV7P7oeZNCfIWGbuZWr2uqnAwuRiONQrcbgAx5wd+6meVATQSif7Lnp6t8kkJZjexoEFxhu8yrZcQXzVKmTBMUAethnoOicIehZc+1LFacnQzXM9LTvbVAoMziBXBM3m2YqnKd+w302o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNB+LdiL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNB+LdiL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so35655515ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787598252; x=1788203052; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bMO3/wgDRsuK0U9i/6YGJKWPw3fkBuEqhVwFdxwfWJE=;
        b=hNB+LdiLIhsFQoY2gaBCW1HKXqdPemQEOrSpAVtYNFfU3sT0mM291PJn2Al5QvaBtO
         QzQt1rPQyM15bCd/My7AlBCLQG2ANPtZMPLTtkYpAobpHNO0n5IrFq7Eo/TBJz8oyp10
         ZiRn8Lx53wLyrMuaAok8u4j2yYuAYkCs+tiLLXMyLmJ/hHq0MLu+Mk4uNXRT96YDV65Z
         AhGMYCD4eNw5M7oY/+3Eef5OQ13g5wu241waG5JyZy9YQ94nmEKUPV1YAJEVVTjRZawa
         utT2RQKmHUaJHVfyQLdLVfcYBO59ldj4Qpg+fEZgvP6Pd0/k7yngPNH2nCXNTkvP6kZz
         bIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598252; x=1788203052;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMO3/wgDRsuK0U9i/6YGJKWPw3fkBuEqhVwFdxwfWJE=;
        b=oLHHcuv0irzKskpn4zQO3bsh8qkOwZWxYFpcTvO0py6PBTRZmxF/YNVORlCfgDn/ED
         z//m2RR7rc8FFFhUlgBHtgm/8Xtj6EHsIMeoRtoQ/0uxk6KbM6fVjMyxY8WRUcgPFpfn
         pNr0SL+NujEwgj6jj08yNOBMadv/5EGr6NUVHvU0qfvuaxahRDxbvzOOwExsugK2nZHe
         vDaO/F3JbGS2zbVsMGnYirkhxG/ZQ4DLdmJA5+SQs2nEdd0f1rHTM09gIyF5Hs/ODmQl
         GB+ZYA/luDjQru20vMwmc/Ruo8vH3AMvkY0XwL67/PRItWhRPODjw5hogoKx3C2kdEMN
         /AIQ==
X-Forwarded-Encrypted: i=1; AHgh+RplGMgo6P9RVGYNT33Fs5HGoe6b+VqvzbNQ7fugiOUTcQrFiEph5alMAmjul2k642uVnWE=@vger.kernel.org
X-Gm-Message-State: AFuF++k+25nPovhXBuSStbDODWb9XA2zxhNschwKk/qNnbJ5T0kR2aZt
	igimQsUscRP09dS3MNhbmkIY0fQuXgNwHgOQgPuXQNs7JBdTlpPI0FTj
X-Gm-Gg: AR+sD11HUf+lewZYwCCYbhlk0SIw/abdcv1iWpwG4W73ArJChOTgXOu3nKqi41nZC+5
	6TjhMBDNq/FherhRibKdTGmr/+62qxJLr8186is2se4lgCuSjEvBvfHXw7aJz7ZvdAH870L2vCU
	VGoIqzFZj0eJAvx7rlIY5DSxYvY2micxP+VnAKJyWlSOMjILwRixtEMfbiacto5nkCSJwrBWyTI
	vHrPxobXY/SWqRagLsIVwawlf24RC42fXS2AJ2emnoRRCNxY9+pHDEs6AnAAaTiMnXxLstR+GSp
	Mjmn4YBBVLkphl9JHPcnSmhEYvsFPAKTgyFYq1PlsxeP6HbI3CauC0Vr5+kGv7I461r/clJhOOI
	vz8uqmHlHhPTL0LJK8YrU/VecKI0B9/swpRZKxoNspm6Qf3IthpY7owdWMXJs1nOItiPLwz7Hfu
	N+u5tJIxYxA6eQp3kWvquiXzjCm8ApnXKRH9/j6ManU/xi03qPLmSvVRrIXqD6mKgPwllmYHlhd
	UqQqRXnqFfrOLnCJ8QhGYLIi+Va5BYNHwqFdjKR82Waug==
X-Received: by 2002:a17:902:f790:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d6dc6487a7mr30162885ad.0.1787598252000;
        Mon, 24 Aug 2026 12:04:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909adc8sm30907866eec.2.2026.08.24.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:04:11 -0700 (PDT)
Message-ID: <08e71a3a64aa07fa1b10802502875fbfea483f5d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the blocked
 cpuv4 instruction tests for bpf-gcc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Date: Mon, 24 Aug 2026 12:04:10 -0700
In-Reply-To: <20260821201316.1059129-4-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
	 <20260821201316.1059129-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-21 at 13:13 -0700, Vineet Gupta wrote:
> A bunch of tests are gated behind clang only __clang_major__ and thus
> fail to build under BPF_GCC. What's worse is, before the prev patch they
> were also declared as passing/OK.
>=20
> This need not be because (a) bpf-gcc does support the feature in codegen
> and (b) also advertises correctly with feature support preprocessor macro=
s:
>=20
>   __BPF_FEATURE_BSWAP, __BPF_FEATURE_GOTOL, __BPF_FEATURE_LDSX,
>   __BPF_FEATURE_MOVSX, __BPF_FEATURE_SDIV_SMOD, __BPF_FEATURE_ST
>=20
> So loosen up the gates to also add specific feature check.
> clang >=3D18 has to stay, despite it being true for so long: clang only
> defines __BPF_FEATURE_MOVSX and friends at -mcpu=3Dv4, but assembles the
> inline asm at -mcpu=3Dv3 too, and dropping it would remove these tests fr=
om
> the default test_progs flavour where they run today.

Huh, that's unfortunate.

>=20
> Since bpf-gcc doesn't support addr_space_cast, wrap the corresponding
> tests under __BPF_FEATURE_ADDR_SPACE_CAST to skip under it.
> And also move the map under that guard so that a bpf-gcc object does not
> declare an arena map that no program in it references.
>=20
> Recovered under BPF_GCC (programs per object, was 1 dummy each):
>=20
>   verifier_sdiv    80
>   verifier_movsx   17
>   verifier_ldsx    14   (20 under clang; 5 arena tests,
>                        kfunc_root and the arena map stay clang-only)
>   verifier_bswap   13
>=20
> CAN_USE_GOTOL and CAN_USE_BPF_ST only gate parts of a file, so those were
> not dummies to begin with:
>=20
>   compute_live_registers        17 -> 19  (21 under clang)
>   verifier_gotol                 1 -> 2
>   verifier_iterating_callbacks  34 -> 35
>=20
> The clang builds are unchanged: verifier_ldsx still emits 20 programs und=
er
> the cpuv4 flavour.
>=20
> One thing left alone: verifier_load_acquire.c and verifier_store_release.=
c
> stay clang-only, and their gates are correct as gas doesn't implement
> those (experimental -mxbpf not implemented at all). FWIW LLVM groups
> those under -mcpu=3Dv4 and defines __BPF_FEATURE_LOAD_ACQ_STORE_REL there=
.
>=20
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I'll wait for v2 and apply.

...
