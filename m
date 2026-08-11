Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BB283FCF
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408507; cv=pass; b=rCUMPt2Z1TVQoRAIDCxWSi46Jhr7AFogWPYgyjqzCUtJfOqI0NVeKi30UhMHfXZxXBHlMis9jXJuecB86fiDPTlV5e26+LTv4G0bo1Xib0H3W4vXiY28wlJBKoOz8c2qJlixKuLy6pjfaAigK1vCGpWaRlZHH6M/0/MfwfAEJ/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408507; c=relaxed/simple;
	bh=nEg+7kwJ1/E5QyhnpflWWqKv61gl3ZAE/pOg5Jf9yIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRdw9zog7wCvxRXGTZmR3USlIcJFU9NIF5jRlZseh7mUKt6oF6hKaB3Sj4gbOos6LNs7+ht5j9xTnJzDDSpiICXgg3WrkIF/np+rTqsjXeumX+JJL+xZetz3VqNV7xyHv80JQ5dkR4IiV8ALI/XLPYN/wvEIW1od8L5NM72/vZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMN8KgKx; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMN8KgKx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2074710751so341853966b.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 17:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786408504; cv=none;
        d=google.com; s=arc-20260327;
        b=jgmBaaUiLP8MNMZsJk9CHC2H99xOPPeXPgWqisEnYvhpwAL09OSFPAQYwf44Ro+TmG
         UOoxd11bUan5CA9BGSxB3QshfkG92yGMvgj+CLgMr9cZVlS2qc8b3RPJwc25SDKo204v
         VKAKR9+Lx0xpNoa+74x+j5F3E0ZpoXKZEnrj7jhFreWq9t2yelDrYvpGCShoBY8hRrU0
         zX4YMWgjJPRKtdUsFMyurvUC4B8uV/cKgjm4AAOUjgA7nq/a6Ncd4/G6pM3Vfp7JJVDi
         rEjQruignb1iKBJOy7InfZOJffcF5u24kLaU541zYqOPh3VwigI9ePsvWH3P1Lnu1U8G
         t5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nEg+7kwJ1/E5QyhnpflWWqKv61gl3ZAE/pOg5Jf9yIw=;
        fh=wdcya5ylzIrrzSyp5/SYu1loAtJC8XJeqi35MDmyIJY=;
        b=LeWaV2I5+f7NIDcpWcoU/R6EYF9LKYABGtzBobWVzCORG26CXxyA0jNKFVCKuCyjOb
         +aMntidBO7C0089Xdsd5dFRvohae4FWXbypwFiHZ1UIIeKk11SR5UNPFhEyPUIqNNNzh
         zqCow7nfYJqJXJq60ItgZewFAOPjZzPTI/QUf+tN2wfmSfkQ8VM5Do+l8et0OiuwFSPr
         Bwbwp8JBmLD+2QjiX4VbFEVWbzF83xzcTXNktEzHTQBGe7RpAVsp3qPkW8eEesC3/wSa
         X+sq1apN2cyQDoeHXXBcoIqF2deRNih7+nPDBqOke/EzWWP2i1iCruHp3f9eo+HvgHiI
         kAIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786408504; x=1787013304; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEg+7kwJ1/E5QyhnpflWWqKv61gl3ZAE/pOg5Jf9yIw=;
        b=jMN8KgKxkv6ZLl+cfX0CXk6qCoz7KT8j1q2b3c7yHKcjjxUQj8r3hHj8vGRVw3sRsd
         7L3kTK8FXs3+A3pN4wflRd3tbHW2y/sxrLdlwS2/FysZyfxJu4C+dztWDOCog/TgWqoD
         I1yJ3k4Sadiymfi3JGccnKxp6+XOYf3GubvY6sgCBYhQvUmT3X18SzlVMJTaI2MmTRGe
         fwIEdcXe9ezucieiO4Ut+OB4DHeDQfEHMYE06QmNaP/RpkAyeIgFBUSNk4Wq5QhV1n5a
         QPBSONpLeSUiPq/8+fThKPirog4qKuqkawv+gd6e9jCARqqBIBw8WsnYzI42we1bsGPF
         bdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408504; x=1787013304;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nEg+7kwJ1/E5QyhnpflWWqKv61gl3ZAE/pOg5Jf9yIw=;
        b=mMdrx/UKuxMVgA15VKpoRrKEqczaAu822UCcYjbBC003VrNSbElTLJhPMPzjSspA7D
         tEr2k00T+nwxyzFWLvYs830f472L7ZaeVY5gCtt6JFSA8fe1ekWMO8qeZcmu/zfSP1UW
         bojMy71+Ies/xwbZa3SIjzWY62CVH7dealqW7b/xHR8U3/+zhycxdqUjnXnjJ2KeB11Z
         O9ufSYpiNhbW581QBX+deBhUG4//qriMxh4pNwoY3pmehHD61Xkk7apCKz3/BCVA6wmw
         TFF5Y4StuZwhnONYDfuROXTQVx2G7fMzY9JNIn0gx61O2YjocOML7nHXzakY85t23WQl
         qt2A==
X-Forwarded-Encrypted: i=1; AHgh+Ro4katHWkj1R1azdNm55tHRwnEH/XFKSOdsthyoM5/RnF3cxPOSEpjV+1YfW2sdGaDHTJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEsWPpGcwho0fY445ilsHMq6gvcaQuTlF618hl41dx0JQOihb
	1BuqQlB5QQ6LTKqAlrBF6ocoUDrmko5RT596ro7V9ZfxZ+e28zkC+byZnpfKI4PcHhL3Kf8Dr68
	nkWau8eWtEPkn44Vsb/58XeuYAkfGITM=
X-Gm-Gg: AR+sD13ClGDxVyySvqG4PyfRk3NeRvn+9+myqM6uD7ZJvNuNTaQubF4SW9kX8PQNSBI
	cV5jp8e55z7wPrV9ff79mOwlHFeddLGyfkr0b2NMiVgkMr9VsKiapnPCZgH4tNUgJB/mAb+bLqT
	n7plFGAIilprNBT88X70/ev9ig9n9W6Wn6Yq/aZLXCJ65Y8GwGbOUWiYbgSaVrC8KgNFGvoGt4i
	BO7ozxR58TllOGYqLXDRe3hm3tJkIF1TCh1m/M6EhiwNvV+dMR7qim2BrxBlMLHa2N8pEAUQ6FA
	zKyMO1OGFpwO8oUqM9uOdn81MloZHRFmUmcdirXunopA
X-Received: by 2002:a17:907:b04b:20b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c20d90b5305mr59494266b.0.1786408503619; Mon, 10 Aug 2026
 17:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810194215.3754591-3-main.kalliope@gmail.com> <a0a3e37e41b717349aa88e1216d9e821ed47a60a3780f2b0fc2844ec3d1bf1a3@mail.kernel.org>
In-Reply-To: <a0a3e37e41b717349aa88e1216d9e821ed47a60a3780f2b0fc2844ec3d1bf1a3@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Mon, 10 Aug 2026 20:34:51 -0400
X-Gm-Features: AUfX_mwlA5WcONpnezH1uyYNSfUbdkPm5xzpFyRq0hYCnNdnJG-g64jwliLc-Jo
Message-ID: <CAJZwKkhTTWq2uPSWEMYz6zAPVMtbyGfAyHd97Uv98rYj1YCvFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] MIPS: uasm: Add signed div/mod emitters
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, johan.almbladh@anyfinetworks.com, 
	paulburton@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, philmd@oss.qualcomm.com, bpf@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 10, 2026 at 09:05:17PM +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but the rewrap of the enum opcode list leaves two lines
> considerably shorter than the surrounding ones. Would carrying the
> reflow through to maintain consistent line density help keep the diff
> tighter?

The short lines are where the insertion-induced reflow stops. Filling them
would move otherwise unchanged enum entries onto earlier lines and carry the
diff farther into the list. Since the resulting lines remain within 80
columns, I prefer to keep the reflow bounded to the new opcode additions.

Thanks,
Nicholas
