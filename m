Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDE2F3C3D
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154570; cv=none; b=QvIg9+Nkmom+GItKa+2kmqspKLEk8R/KCvSuCK9qqspHdhPP47ltryFp7SzHsCAWLngVLEzpOolV8XlbCfgxXhGDhVY3DSQRpOKMUJBHuQ3liuxIQ1fk9yBICdYWeNgo4g0foLH+mULIoj1I6BEApcogQMZzbch7jcE0I2XyHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154570; c=relaxed/simple;
	bh=DFREJ4zs5NXQLCBUVmhNATB1oSbx/O3dnFWIdxmnr1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTsFxR9VBPRl8Y8t/ee7jxYDa48oNVJg35jj5Co2NY9Tb9cVRj99Dp8IO/h3KAuGjjJx9FX4551laOlRhao4kXLzgIN1SAmwELtitynUJ/TsckQQ8VBOHM/ekov+POpocmghD4cvHYCNxWmMNf5FX8CEo84IJb1Ruo2PhdlVPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIsVS45b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIsVS45b"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso36762645e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773154568; x=1773759368; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeVHAcfKahCkaZbWLuWaDkkbMm/dLBfYNvDg2aFDXC0=;
        b=UIsVS45bPNcILEELm85MG84RXokEgFNZqQVQALhfBgdXyqaAxgx0xmmLc7DW+cM7B+
         gc353298curgNkiQRMirpXVS4zsuF/cZ/MvMOi30RVrEvUvqYsQkUU/ciLZxiY8KnMPP
         aGFpiqexI8KzoFcJiWWhON+76HlFeC5PgNGkxYTGiSX3Mh9cvycch4pTBsX+t+dV37nF
         z9hU2sp4NmNKPq5+d8hHIRy9Z5+Tx0RXHYhEBh6E9yKBjO4hxVaBdIHSCAOd71ozGvut
         Fvr+WNs56l1b0dGryPndWhkExqCatkqfxJjdmOOSconEDPkwrKAmQeyy1IwtPwnfbQBV
         TdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154568; x=1773759368;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeVHAcfKahCkaZbWLuWaDkkbMm/dLBfYNvDg2aFDXC0=;
        b=fkM9CxZKIurnRdWoCwlcVEUmEfslyw1BHsFrev5wt/+6ytdAlj+y/GSTB0Vg08HuJY
         TEotgWnnlKlPVkh711rnX/0LQCTyrKn5Te/RKZ2x1+vStS/p3RQsupprmn5FpxktIn5b
         bP6FOiK5/8xytruKxOapz72GX9+GRMYrb2ZBzStWKnHG8G6OCkxTeUU/Br+oPvV181px
         x1nkfmu+Z+ILdmEeBFLOtKsZ1GQYpI4hbjB2TYUxBDC0dUZ97zZ5yFw2HJeScF09H7Mm
         dNk2SV/rCXuHEWNTyGOQOu7MZ5ePM/vkg8SL1+DEOzv4y3elzGSFFaYVbd/k7ia2cJFJ
         BJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVlMrxOh/plx+MJhnFxazyzEd/wRk246v4Q8UmH1JMfqqN18GkQfrYVnu6o22KvxrbgGD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROrB/rb6/58p3zYW3MSfldlKWc1oiIrPyXoSN6MeknsEFFOnt
	OO3i5A9mpFVo1opdpyxthQfS4Uk1lVdNDtcagG7mBKDJAVf1DO2WhxYL
X-Gm-Gg: ATEYQzxn5Gv4VeRUEWpMDcvLxF0XgHe0dm1hsVIko9JtUwHajTQmEF9J6fRLgwXqoIc
	D9zYNMbtPgp56HDo34aRl0Q79FBbdck2ggmrMwDtudEa2KBIbEdagzSm/F/t4AzxDBBY0LrSF9B
	QpjCuyuJwtyWNlQWCMpa8KXCbmV+RCylPUTEqxiHXbHU8OMbdfkmyz7fC4JlxMmoKAFavns1Zdo
	Lq/XnGU5CJ1F/C2SFZqU8XbVpbojEOM35qTeHxRQMpxgJpuMafelYuVwkfCOM63ye6Z54zlVo5F
	rkEwfKJzE3CwtRLRK3fMeH2fdSn2dp7egvYMgfhFjm90gyMQYjLedEo2cAWTlbKyRbdmzMbVyxc
	rY8pALqb+dUQG3OzArpY8hqj6x3sgjc5c+H0Rckl4O9apNQ7pU4pZ19MeR1FU5A4CMPxPQza6ik
	/ruSCN6AMRN3Zl8x16vcPMJ9cx3mEavrGJkODTlQ==
X-Received: by 2002:a05:600c:a111:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-4853b00fb11mr107656265e9.2.1773154567334;
        Tue, 10 Mar 2026 07:56:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a7f182sm112304735e9.5.2026.03.10.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:56:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf] selftests/bpf: Fix pkg-config call on static builds
In-Reply-To: <abADBwn_ykblpABE@mail.gmail.com>
References: <abADBwn_ykblpABE@mail.gmail.com>
Date: Tue, 10 Mar 2026 14:56:06 +0000
Message-ID: <87qzpru41l.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> For commit b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection"),
> I suggested setting HOSTPKG_CONFIG to $PKG_CONFIG when compiling
> resolve_btfids, but I forgot the quotes around that variable.
>
> As a result, when running vmtest.sh with static linking, it fails as
> follows:
>
>     $ LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
>     [...]
>     make: unrecognized option '--static'
>     Usage: make [options] [target] ...
>     [...]
>
> This worked when I tested it because HOSTPKG_CONFIG didn't have a
> default value in the resolve_btfids Makefile, but once it does, the
> quotes aren't preserved and it fails on the next make call.
>
> Fixes: b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index d5acbeba0383..65485967c968 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -409,7 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
>  		CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
>  		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
>  		EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
> -		HOSTPKG_CONFIG=$(PKG_CONFIG) \
> +		HOSTPKG_CONFIG='$(PKG_CONFIG)' \
>  		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
>  
>  # Get Clang's default includes on this system, as opposed to those seen by
> -- 
> 2.43.0
