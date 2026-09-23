Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129C37B015
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142737; cv=none; b=oYJPLqPxflOJlruSKDDdH0Wpr+n2dL8hEtJ3czG8qxctwNc9oACEK2/3ksCzZOcPIoZp80r5xxP+KfQs98Cggbmh+cPkZUlPFPmKTlXDYOzWFb9xyTZVT3DmeTyqpodbUjMHm7Yyr5D2Hla9RddvrYk3fKsYVo+4kW3UBI8C4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142737; c=relaxed/simple;
	bh=/JfKl4iscR3hdt29ssa3m+uHzhvqQKEGDYKWWbUUfv4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OpteGoUFVjq5DCMZR+bqCIwwqG6hSEmiqNFmoxUp+fo93kn0cCgmHGa4Qszqh0qhYPlyphzd/SZpDEY4tvNypEjQ+etGvTEtYT7a6ujYkn0hafw5ccGpVeYGsMLSnVAu8TnECiUZCvXbF2vidXcL4uLtJUmJ2VgXhcJBQWemUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhywzzkV; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhywzzkV"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so727965e9.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790142734; x=1790747534; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/JfKl4iscR3hdt29ssa3m+uHzhvqQKEGDYKWWbUUfv4=;
        b=YhywzzkVPbD5LX6UD9k+mPgzXv9nPP4/DwB+7Dt8AcyJpOqu/ZsaunLnAB9Z46COLE
         iiWogyZJhodVBpQ29AzOGSv/4FbQmo5BwztPQNui8OPOe3oq/3kccOgQd6dPFc/CXLNX
         1J0MxzZOppQO3gSXkoBbyLd0j8RWiYljVvLLoZqrJSVPGzOAkGBQgtaBfh/1bC0hV78/
         QJXfOx1QeIABKKSthhvCeeC33IP8aj9EYNdpQbVvuK3U3c+C4M/C08xanlwf49TaHlVR
         H8NAZgurulcek6BZF0k8/KUagZBmgcTPgpaN6RZLrx3b+PBtPAd/Td+yVdGPfYKStzCS
         cNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142734; x=1790747534;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JfKl4iscR3hdt29ssa3m+uHzhvqQKEGDYKWWbUUfv4=;
        b=yKpTi/1+kKTCBF9oYVzhKw+eFr6EV3w4BrXNzQI0CmAgMBFzc6zdFU18QwCEbQyHxx
         glpS0W4qSO4l1uyqBfB2CZDmn4yZQN1sFq0XT5HCwm/XXmZsf0Q/ACuZfKJwldXgd6VI
         7vyxLK+CcnU7aPUcnN7+YKnsDPvW/mXiNhgCoUAv+lGJdkhQhhZS2bLlnBohDVS9jP19
         wUmN28G+0ClVGWchPCF+zwP3f6wpPzrgfpjgXOFjyLloXZQErbqHRnobGF/1xjUbcHFx
         WFntWGTEuSk+NODDmKfjtNzuilomeNMCKRKAXAELv8Ye4r5Ju3fuA+aXrgGPaTGfAASv
         tmxg==
X-Forwarded-Encrypted: i=1; AKwUvBz/4/Z5VsLiziOxiQZ5FvGP5g+wQDicnqmQdfL8nG5mGg+v7oNcF4RSFiB6WSOPUzFRSaY=@vger.kernel.org
X-Gm-Message-State: AFuF++lWnMyokTwu4ihk0dgJCCxjiYIxx15yNAY5Cao/Uk0+UNqk+z3H
	5VyjiKKeMRVmLO+SP+NQLICfhjwdx/SHOCOYgWoQKLntzx3klam8dR/O
X-Gm-Gg: AYBFou11mWkEBNW44h4W/HUj+Vc+c728+vZL0GPa2R10yGiAHzqLQboh1Xhhv/rTaRB
	22y/HiiVt2U8hqxOI4LVLRPCvoG2nbeGQA9LYAoJ7VaODOj9tziB/RZr7HSIcHsa8aGFknWhJh2
	mk3pN1WfiIme8jy00IxacI0iLfNEr+IzVFiby6HaDx9Wmw0P3a3XtOVLw7EpztJg3JtSq14LXqp
	jrMsk3WgXv33pYAiMGcwcg4KVMk5TXtuYMaWy8WhH/3snlFQjHSRNRRdAMq1nmY+8mR4r/kEECC
	uOB443CxC03xEmr04kSODQTnvSwXRHu2GnoI2GNA/kmP/431HfKwGWK78BIg2ppF3paVb8IcgMA
	kWdQsbF9b0wBpV5fhppO1AWXo95xZ17ZeKQEHqrnb7T2oetn+Az8yyXQ4U6EIeWUMNcpxs5tAeB
	/UArGwPcXxGymhJIelvg3a+kk2h1hJPtJJfJXnMt4gkAtDZVUjzBO2hGMvMYqinEIPoK+q42a8R
	ugs3oy90RDRPpStgVShfOEJ/MyfeDwj+XRClaFly9MYQUnvq+oTatzIPnEjgtbLP3wBGkKeD1QR
	VRGU6QKNLVpIQK1J6BSEbsOfLllQR42j6ZMHwA==
X-Received: by 2002:a05:600c:4e44:b0:49d:174e:2a1e with SMTP id 5b1f17b1804b1-49fdf12f3d7mr17291245e9.19.1790142734275;
        Tue, 22 Sep 2026 22:52:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm47166335e9.15.2026.09.22.22.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 22:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 07:52:13 +0200
Message-Id: <DLMGMYOHSGFW.24JML4GSMTV2K@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 16/21] libbpf: Collect .bpf_cleanup records
 and pass them to the kernel
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923050008.2425961-1-yonghong.song@linux.dev>
In-Reply-To: <20260923050008.2425961-1-yonghong.song@linux.dev>

On Wed Sep 23, 2026 at 7:00 AM CEST, Yonghong Song wrote:
> Parse the compiler-emitted .bpf_cleanup section and hand the resulting
> table to BPF_PROG_LOAD.
>
> Each record is three 4-byte fields, and each field is a byte offset into
> some code section named by a matching .rel.bpf_cleanup relocation.
> bpf_object__init_cleanup_info() resolves both halves once at open time an=
d
> keeps (section, instruction index) pairs; it rejects a record whose field
> has no relocation, whose relocation is not one of the two 32-bit types th=
at
> spell a data reference to a code section -- R_BPF_64_NODYLD32 from LLVM,
> R_BPF_64_ABS32 from GNU as -- or whose offset is not instruction aligned.
>
> The records are sorted by begin_off once the offsets are final: the kerne=
l
> wants the table sorted with disjoint ranges so that it can find the recor=
d
> covering a call site with a binary search, and records arrive in
> .bpf_cleanup order, which says nothing about where the subprograms they
> describe were appended. Overlapping ranges are reported here, where the
> program name and both regions are still at hand.
>
> bpf_object_load_prog() then passes the per-program table through the
> bpf_prog_load() options added in the previous patch, with the record size
> carried on the program the way func_info and line_info carry theirs rathe=
r
> than taken from a sizeof() at the call site. bpf_program__clone() carries
> it too. That is a second load path -- the one veristat uses -- and withou=
t
> the table the kernel sees landing pads nothing reaches and refuses the
> program with "unreachable insn".
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Should we treat sh_entsize =3D=3D 0 as 12 (or change LLVM to set it), just =
so that
wider records, if necessary for any reason in the future, end up being easi=
er to
reject?

> [...]
