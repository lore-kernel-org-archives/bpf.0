Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB82389E14
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081788; cv=none; b=rbqJr+I6qLejcqjC3RdHbKp508Xbs9VIsORhVOvMqK6D7lZ2c5tCmU+6xiEinuVNNdLbjHv+obwcCgM/UCPJvpBXPh3KEscGKhDZas+3bennzcQDtiKyIxlR5NtTwsb0mw4H79lyTAPbHKElcepfUNPf1T5Y2D5WBWJbl11HqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081788; c=relaxed/simple;
	bh=UN+hGjWu6Cwu2KJap8GLfrya8nEoOG1JtOaaEupa1Jw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJQ61/hp/OKdUmEJSYR6GrGkkXaPCA5tebDahtkr9Wv4ZyyrRjq3b5AWz587YhP0BgESQm50DgibLc3JradwZVl8NFHeRBHTrnIcZvDW6pIJ/V35Br+2SW5VD2G8Vhmo5JLxGuiRwkGZS2fJKqG0UFLJk0xKCLacYGPs+kvyYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrMezaa0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrMezaa0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adc1d9ec56so2687765ad.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772081786; x=1772686586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UN+hGjWu6Cwu2KJap8GLfrya8nEoOG1JtOaaEupa1Jw=;
        b=DrMezaa0w4pQzaRwsE66xF12xgVMiHAMPYt7WydoyQkmxVO8aHSHovt76XqVQwienr
         sw/pS3VTu6WYo7KGdaVzkjXSK+VDXlLSvmLiVKV1LNomCgsjR3o8u0DaDTpWp3dUMfoN
         CF4XCTKpX5az4Z3t/NdyvczJaeNJxDaewSCq70PH8X1jbA/Ucg1iJgChuF2YbAM18wF7
         k/vATZoJ8Fo0ZsIh7ahWqtJOngcLOShbx50+E1c40abmS9EG6hcLNpwcVYY3s9+Yy8J2
         IHz7u1M9/3AEIvMi47qwabwnRViFtw7W2GLMHbIEvcDr3crw4k0knX4yI1rJzfJ+NUt8
         k3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081786; x=1772686586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UN+hGjWu6Cwu2KJap8GLfrya8nEoOG1JtOaaEupa1Jw=;
        b=lhDIrLjtpDPM3djfTftsoPn/qbiH6Gs5e4Gip2pzTEYTT4n0PyGBA651laDxrASz0A
         3FYOpSP7CODY1KVHrtGwHEdJ3+MtqtdqsSfLSQRasp7wArYwLEMuBeJrLY9ojGOTetjV
         JWInjQ/SgJyNa5WWtbf7eJIbWlcMaxR7OceiTJdzJhjaDOsAneYtpOuL+vkiz174K6Br
         JiJ9Cyd5zxpFOZJKMKpVpbr6glKFwx30o2VZ/UTokKCrjD7itofS3x0dwPodyF3O4hgr
         TiBhuvmt3dFIVvDJBgz0w51iL6kPekanmdBf3taRvKr7nAYrfIGgedwpGtXXXsfnxijB
         ntAg==
X-Forwarded-Encrypted: i=1; AJvYcCU2PIlEH0i8ZLdMv6IqM1Km4re/ZdeflfuM3W2sMuK4970uZjQmJaCqGw6eQZuZG9Qh3aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMjpMepWqe2fyxOnS48vtabUjClfRL/NukpwQZwyWmiHD6ORF
	TAJkoYjl5S+0BhZs99ij5JFjxUdNW3NPZu8Acznft2ySQeq6XfyLYZ9j
X-Gm-Gg: ATEYQzymrCJ76bs4RDiWX0y33Rldu9LsYX6+oNIwQ6bju2EM+h/SpcqPzXbuKQVATDw
	ZlQJlD7iLQXEvNBzyqrFvqBc9mr/edMa5B9WCAgUNJZAG/+1FV/Tmga73WEYAHVMnvssAIEBq45
	GGxORgIhkYjcLJ8PgIuIbJifiLUqIXdWuRKItGK4CU7YdD7azOEhrGCiBc2aoPAEwdJIyA+ute1
	Kp6pIncYMbljvF1DW4J0pXCyQsD3RQkKk8uzUAYgnfXgF1ck4rfhX3NBSB2G7OQRcLSa6/FtCRy
	0IlvxH4uUmN2Zsy71wWFp3A/y62X3nPcNqbdzEBC1jt6QC3BzWz6qAUNknFa60uypPV/SZI6DrA
	Vx4vdq6SAMCG38ZgJvTfeOqGMBqCoGhE8OGTOFxyEgODEPd+xASFQ+fXly18z9mPdUrgrz0It2o
	ZCCzmlP6UPV8VBwVbMNEVal5HaabsXjwX5io079uGWrWN4ZmidB396+fZpL/MMsA==
X-Received: by 2002:a17:903:11cc:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2ad7453ae91mr169587235ad.39.1772081786276;
        Wed, 25 Feb 2026 20:56:26 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1ba9sm9939135ad.76.2026.02.25.20.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:56:25 -0800 (PST)
Message-ID: <9bbeeb42c5504ffa6de8a1a1fa02cf0432667242.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Separate bpf_throw() and
 bpf_exit() return value validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Wed, 25 Feb 2026 20:56:23 -0800
In-Reply-To: <20260225033356.518313-3-emil@etsalapatis.com>
References: <20260225033356.518313-1-emil@etsalapatis.com>
	 <20260225033356.518313-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 22:33 -0500, Emil Tsalapatis wrote:
> Both bpf_throw() and BPF_EXIT use the same return value validation
> function, even though their validation logic is slightly different.
> Using the same code path for both complicates the logic and makes
> it difficult to follow, so create a new check_throw_return_code()
> function just for bpf_throw()-based exits. Also factor code needed
> for both functions out of check_return_code().
>=20
> No functional changes.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

I think I suggested the wrong split.
A better border would be between checking return code for subprograms
and for programs. Wdyt about the following branch:
https://github.com/eddyz87/bpf/tree/check-subprogram-return-code
(fexit_bpf2bpf/freplace_void fails,
 but I think it could be fixed after some debugging).

[...]
