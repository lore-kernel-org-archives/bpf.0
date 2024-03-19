Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD360ED8
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891951; cv=none; b=fQay1PDXUpbFgD47Z8tW7PQSAEAvHeqIXszrgLM89nhqLGGiUIm+Ncp1wGbMs0XTjExgJ0kaV3wgqAP1YLwQQGS9RF209KMgzPjiUcjawX5EQcm9VjbGiLGwQ/WFsIluLy2BeoZBx6y9kSEuhP7FiogpSAwgSR9HpwW7qyUGbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891951; c=relaxed/simple;
	bh=5tUyyreFbv5s0H/eGJF9szUYYkP20OpD9GTjw9ga1XY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HavCvM90px3Jp29SNMCNPmpnJHVa/x+9X4wdLFBSy1JVM2cJd4j3HfdG3AItVgXvKstbPsA15r2JSQQwKRGv4Mjy1CZW1gRxMBYmbuKy5hhmkz3MbzbO63nvJjmux4nDPDDK4ZCYWdZs45DxErlIkgG/4CBZk6RdYf9k0ZcIODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZISd1NF8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZISd1NF8"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so38022011fa.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710891948; x=1711496748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tUyyreFbv5s0H/eGJF9szUYYkP20OpD9GTjw9ga1XY=;
        b=ZISd1NF8q+f19jFL/jJBYFsF+AdxGFPnXMqBWciBwpLMiQrzHvxQVN9a6KrHaloN7a
         DvYs/op9x51Gzzp8dz77dM+cEJEm39svKUHDNb06BLy/kLAJia3Z7OfHz9DCUAn9QMxa
         unTm8Lj6CUt8edqoMLSNiwR6FffGW/MReq0F3sGVCd5flw2l0RHRrVqnaz8Mj+Rgdmma
         LHBPn0P4Z9czJFsVv1d/C0Av2QMXBvx+oo+IxpUPbYtSOlz82fu3Y0j6X/A17tHf294V
         tm/moKr6yTqwzL3ASHaMgBY6WeQjWF2ur1MLTHb6gNW/9WqFRt9qaATzSr163lLubQXs
         JflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710891948; x=1711496748;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tUyyreFbv5s0H/eGJF9szUYYkP20OpD9GTjw9ga1XY=;
        b=a+k6Bn2D1zPv9t1Apl+VA1G54/jtV3qFkvLdG+N5NIIcp/+5gKloCIFDWnTVa+d6u/
         hX+Y45JJ0ZoHiUNkeodM4QpOqICexRuglh4ipOwnsn6uKP9HTuLZJUFndpZQLan3wQzQ
         lbV6Dbk7hkOa+tZBnX3zitbXQW//BNfRS0RWg6YiC5vvPAUTp6ZGafDT3VEwBAWsSkiI
         paqF2biWqH/Y04TAkBwKu1UAj8f3XVdJ63xVtHvk3MX2MvJ+PV+wrcw0izlXRUtSj2ud
         yPSi7sSwAAvsUUj/QpwHpcMLX9hfCkWUd6SSGv9PZec9ODuhrUMd6kE7bAeTuscdIsrY
         tGqA==
X-Forwarded-Encrypted: i=1; AJvYcCWDfqp64JvDhrsIslLsXJFneOxsqsmjOGCKyDntFkt5An4Vq90LOtqnEPOoMdOQCUsiG4fXs0Y2bXGOi5zvohfJolcS
X-Gm-Message-State: AOJu0YxG8xWiz9qnIymunRRyRG0KPHVbq/8Pi8Gnff726GnYByxp+HP2
	T20pCJNL6ZktO7zzBdBZ8s9ZTkRvorFJtV9/K3BI4/p2sJv7ekPT
X-Google-Smtp-Source: AGHT+IF489mfJ+hy9BI8aVZNUMkTWY5XfDiBqPWCLwgkA+7t6uhHI8cxUdTbOPrbig6nnPKH4qq0xQ==
X-Received: by 2002:a2e:86d4:0:b0:2d4:678d:34ae with SMTP id n20-20020a2e86d4000000b002d4678d34aemr10533649ljj.20.1710891947671;
        Tue, 19 Mar 2024 16:45:47 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00414038b4d64sm329569wmo.27.2024.03.19.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 16:45:47 -0700 (PDT)
Message-ID: <1eb0769ad06904238159e51aa24d018d79021d5f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Date: Wed, 20 Mar 2024 01:45:46 +0200
In-Reply-To: <20240319233852.1977493-5-andrii@kernel.org>
References: <20240319233852.1977493-1-andrii@kernel.org>
	 <20240319233852.1977493-5-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 16:38 -0700, Andrii Nakryiko wrote:
[...]

> +LIBBPF_API int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_=
tp_opts *opts);

Thank you!
