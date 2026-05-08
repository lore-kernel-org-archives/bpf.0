Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726E33F59B
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263576; cv=none; b=pT6XjoJGLs5JkmjnKyuIEzzI+/VzEvyq7+ciLAjyJ2PXuCSguQZ+ImE/x6naoG+FZ4Gl4aFu3IZxvFlUaqY8b1ebtP9Cxy+qSwvX61uFGCoJMkQjgF3n6BcL1MbVFhZ48ezzrnqvDw0TkiqKHzVa+Mgvd+dm01wV/qtDVLf/B+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263576; c=relaxed/simple;
	bh=k+uy8m3x8cnKxKFe/ndwK36aMSJxP5LxTkjXhKRjOUQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bAi+7Gt+/WWRGANYh2bzVuo84nP/suHPuCo4z6Yc0ZZNq7mbLj/L9Ma7eiJ39LDowUGDaxstx7lrpSY6t7MNll84EBIvjCzaOC47HKFeAFRmEpA6E4Kq2almwgS7X9QRIPD8W3cvyEZaxrdwJw27InAeSksBBazvctj27jUscz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlBmKXrI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlBmKXrI"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423dbe98bso1246753fac.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778263574; x=1778868374; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYHyfV3jTRyqgx6psnXENw+DSkse1NYNYRgsjKcbgoE=;
        b=TlBmKXrI2j4t4TWCxBlKcjcbZDRSnfGw8YQV4k88c5OlZpcjXaomVbMu6PEZiQ/2iD
         lZo7SPFukMGWgToypJWMhIzidHuQI0GtNFT5JU411G9xBWflpx3bL97Bi9A+4ASTlIjD
         whViLjaVCSLSNSKce4sxNyKCsEbWoryNZXSjBGq+86zAgvcKdplxh7JPQ802LcAx037Q
         RPOpD2nuuV9lIw6U499ax7U37fW0W0+2C7G1oIUlAjPmAd1O9tiJm4Xd9K7EGpRjG/vL
         7rAG3uRYH3lh/XO5Wh0Af0M1AxGOAtd+AhiIdJr3IZepw9oicQItX+3mnAXkmvgByW77
         +YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263574; x=1778868374;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYHyfV3jTRyqgx6psnXENw+DSkse1NYNYRgsjKcbgoE=;
        b=lJ4P4jNxIzwjlXoJrPuCYr33DmtuXf124o6vD2Gsq6wH9FmZIN2iIRMoQAAkdaLHh7
         D7mQp8XR8L1FbQB4m8BqhBkYDQZU5DlbmJMA2RgTJtzdoaBMKq+shY62EsL263DzNSIA
         ublibCIcLhLkGctX8hdmyTDuYy0tAbB4LT5+YygBc+lvgitnMun8Hc0rLBxUN23Zt+Xl
         k3aUxVpp8s7yxNHW3Cr9D8vf+xCgOYzbBTJig4N01Ky8p+/n2Qw0E7T9ICHmwCIJ5xBa
         p4IWIh4sxHH2pxrZaSmlb2uQxVzZ0pirWb1/KmQAD9W10Dc2+L+Ve247RTyl0KIAEjHG
         C5jA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZfEErbLExXnONhrAZzZkPPSJ5DMKyc/6eUYlcXJeOuTCbaz32JDn6ziSSC0xe/AYf66A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSF8bc7+zzaNojQnQ8suAw8wm4NYH6iiJzOy37fPMlPrgEwcf
	yvQi7Q1sU2XlOGbkvFS+GvENEt9LPPzGzjibL0l87c2dEDG2I9u701Gz
X-Gm-Gg: AeBDieviRyKjkM2CVDovJPCO2zNm/YeambG2yu2MSxugNTO0soGzjfv5U3N76y0LVei
	Gfyq0HBdzQE9Kypcuy7ljhUJWqGA2IwY+PhXdQuNr4PZ5l/yI1MoVoQ+7ZTm3Wimvhdz4DbegI1
	h2C55h2k/pbnXiRVSGP3HyObjM9fNaLbKABLvMQIuV4wx98vxgkJVnGQ6iOurmYwtemyzCDWcMh
	SfTylvGtFVHfsv61vj+1OPCawNdnQiVCrQu9/+ghdbYrSPAT/WRZhSRi6fm5bdNy24qed19az9u
	5T6mOmjR3JgDJjfkRf9SuSm6fklUdeYP+ABWPAzT+tRLwEyjXbV2VReCwSg1BI+ndO6tirv5Wpo
	Vv9KDjrPOVl0wizrXLTNVwPaoNtqzA544JeRsMl4Z7HV+oEOhUoqbWKOdug/dDTtSUjRgPsf6JD
	ls2I3ylBWwu5osYLVe4lNP2oN3sZCmhEtwOskBE5fD7WWso/2i7GcwavxSCDCIsieYT+HMVJxnC
	rBrCl7w3eDaMaMFdw==
X-Received: by 2002:a05:6808:690b:b0:47b:c2a2:1c89 with SMTP id 5614622812f47-480422aa03cmr8193135b6e.21.1778263573939;
        Fri, 08 May 2026 11:06:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c7640069csm14994533b6e.8.2026.05.08.11.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 11:06:12 -0700
Message-Id: <DIDHTRIE6MGC.2SQ974UZ2EQG1@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 00/23] bpf: Support stack arguments for BPF
 functions and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>

On Thu May 7, 2026 at 2:29 PM PDT, Yonghong Song wrote:
> This patch set lifts the 5-argument limit by introducing stack-based
> argument passing for BPF functions and kfunc's, coordinated with
> compiler support in LLVM [1]. The compiler emits loads/stores through
...
>
>   [1] https://github.com/llvm/llvm-project/pull/189060

Please land llvm bits.

