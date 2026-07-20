Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3502D739B
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584821; cv=none; b=LjWukH47BWPW9gs/wCCNRMjknajwU5aOOd7w/i2fH3GxS/AB0Uz1aAkZ3JDJqY8q3OC6abzieXPoAaaHZOq6ZK4J4nJKNF9nZ6JGHccAAhuc9qS2molDzCzkLH9Og0Dd+xri7dELVWUhjXBu9QroIZQ7Ymaq6w7FOCqmHdtHcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584821; c=relaxed/simple;
	bh=M3AOKBC27snVGDOXJ3vT/8dlkvcBqonj+Ig/uPKhH9w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RigObGRfMdTiUdotYORi0BbPKRM00TtZZMOEnErGbaZgbzYeuVUhQhss+4eTjaOQtmIJkPj87PSarVcNM97bFxT7fD5uZ21MxEwT1sU4UwQdQOdRhpQDf6pes2EDATGFZeFB/FqsOxA3xTLEiH0pUBdEeEm8f4T8FQlQ87k69rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=FmFqJDNX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="FmFqJDNX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so4169728b3a.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784584820; x=1785189620; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3lAbJ4IhV88GF9seQafPlXiSyADaZ4lU5bSkNSNxT1g=;
        b=FmFqJDNXS7pW9YZrYaiV9rc7IVO4dmKyFCJatKUmNKeZzLvVdbFCuxCTdhxXhdpbak
         FpCNLVzfqB8N6SRvfKu6XwUjbu16h+jn2PdjMP967jlaTk2MHMcExEvi0EF49Mnlsz8C
         U/7NxrlQ72sZcn40ma0gvJQ/HwZw0PkYOGhjp2eanoOHC8y6ngQT2CfIZUAcbtFnpGDL
         PVUI3CnqmLZccSBRjbK37JQGU2BUyRpaAvw8XNo51r1Tg281lkrSdVhtBeo9RE9lXqIP
         A0gIs4blIlVgtD5qFVmBYXmibtis6dXw26RTs5MFTOOrTNxcx3YWnDPyFqLwLJJgdbl0
         Ds7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584820; x=1785189620;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lAbJ4IhV88GF9seQafPlXiSyADaZ4lU5bSkNSNxT1g=;
        b=eIa6agwv7gegmhEyrYgcpgR0UNg6aSWU8Bjpa2HA04N+NQ8pSTUbpy5Sk1IqcGgJ5D
         Ov/rD6QoANKXYp0cPR4MbZR/sNcQceb88LbOG1yflufgodUy/ipEN9mO5E6QicH/DQrs
         ztb3l989e8RopwUVBPyug2tkVhHyadS3LTWPi/3d2gKMFxvZMTtwKZHtdgvcxFclAuEp
         Xa4dfZu4jOaeeJwF9Ofro+dyuBaIf3xgK6+t8AdT7fhtTGJFFNxQ3iOaK5OwYYql9ZVb
         XXhmBOnxhr0Ya+6PjaOzrLSYCncISKO91rP8NhcbNzax/2Xe4OVKBj4UIh8jjG5tinQ+
         bqrA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/7QH60+bVmcRyumr8x4K3Sj6T3CcAfen1rdUub0KFwnnkmDpnDn///Rx2rslfvW3C7LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7o2gucUbMwKyLocWhpmFSJfymAiIGuUkXSUcsK6psrv8uPBs
	/iOTZsPumMZ/RNQV7ZyhuewiGEjBSWfKfFpvJ5pTDV2NLX7USxWv20iLb5tTD6zI/Qs=
X-Gm-Gg: AfdE7cl+JXd0UFbyga229UgMvqjNOzOasHp3icWlMxWUVDWWElVaJjoqT45Qa2n1vPE
	Al5EbkCyR6uaUP3i7+BTF9rMaaAkVJbmd4xQDcJIXk4lDvjrlG5P9LXgY0kpVRgzOiV1V2ujy4X
	DqHN+yzAs74IZHFRGpZY53WI3hzcrYIOn9sK1oFlh9x7CNStAY7+c/448NyoPvVzpk1GgAjxXqO
	XSR3K5UcAL4P7jU17s91w8Ru5L2q59Yt0dAF7qhOynuU/eBCh+c0LcnIAupYI5GsjnjtcIzNGt/
	5OPoqMT1H/hlZmueaDJ0CJJ4+8TfpNLGtp0JcY+xK25lCebnjPiIR7Ux86pi2ZePMu2hwh2OIIW
	4dsqh8QGe8s7yXWJueCAXPmfNinAfTCBq3QFLQ0Ej8pX1nmLAa5NfBsUXkxZ0O93hjmju1zn+M0
	itfpuGmrnFybgnE3Ufltxfc14C5l42WyI=
X-Received: by 2002:a05:6a00:391d:b0:848:2ef5:50df with SMTP id d2e1a72fcca58-84c28c97cf2mr14325314b3a.39.1784584819358;
        Mon, 20 Jul 2026 15:00:19 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30d0dsm6315458b3a.32.2026.07.20.15.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 15:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 18:00:17 -0400
Message-Id: <DK3QIRHTWRC9.3DGK77TTOSW2H@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all
 contexts
X-Mailer: aerc 0.20.1
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-2-memxor@gmail.com>
In-Reply-To: <20260719113551.1294284-2-memxor@gmail.com>

On Sun Jul 19, 2026 at 7:35 AM EDT, Kumar Kartikeya Dwivedi wrote:
> There is no particular reason to keep bpf_res_spin_lock() disabled in
> tracing programs, since it is safe against reentrancy and deadlocks.
> Remove the restriction for tracing programs covered by the predicate
> is_tracing_prog_type().
>
> This is a prerequisite before the definition of is_tracing_prog_type()
> is updated to include raw_tp, fentry, fexit, and fmod_ret. Existing
> tracing programs will be updated to use bpf_res_spin_lock() instead when
> it is available.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I assume we do not want to enable this for socket filter to avoid
additional testing, since there is currently no clear use case for
it?

> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4446f0bde88b..bb6e16668d0d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17815,7 +17815,9 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> +	}
> =20
> +	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>  		if (is_tracing_prog_type(prog_type)) {
>  			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;

