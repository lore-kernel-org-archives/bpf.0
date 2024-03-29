Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A486101D0
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725890; cv=none; b=P7kuiV4Ta4zeBNMehqP3QMGn/aWFrImUKdU4XBhnw4vHortu6lAZ2g6ZTExtFZcdGFNIOkTzMkkJrqEwliyhWqypkn7hCm8on+JZNWXNNeP8LexkxrorAded5NzsFC6jQVNj9RBOvuKI+W6E8vNYh2JputTsgN8NVHVatW810cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725890; c=relaxed/simple;
	bh=VEy3fYo9Vf3Q8twOFOmT4/3+47in3yCIVBJjp+ZU+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7Jcr5FyFSapaFJ4VEZzxl+1aIr6yCvAD0wcyVEAkCyqKtABhCGoon1ENvI33RoSViLfmvch2MJpJDkvChCo+QVBx9fWZ0PRyvR/yY9yxNP+ihaZAd9NDMJhSV4cqvKNRz7BVYdwezie6sna4PMt80YUfbcno3QtrsCHR5y8xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RR3zyWGt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RR3zyWGt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso283004766b.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711725887; x=1712330687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni/i7P5ED8HyT9z4QPlleLZS/5AvuItyMQEbyI5EX5E=;
        b=RR3zyWGt9sO4U1dV3NRgxAhtatuyIRDm8RmPKTmyXylUkbWeSozFzzBxiN56OI8XH8
         vp4d0g/KAXP9LIRXXJzgsX2zFk2hFGy+Mz5ZrevHw3QdDiJFvgTBwr+AWdJKkeRSg1H2
         +WCQVaHRTzouNchKoHOLHa7GrY0PPQRK64xAEmpADYpgzlkClG5EYbiGDeGW2F2QNfqV
         AveEr0ZVjzIT+lsAQLhTbhlfEp3Enma9S7vTtAbW5ABBRWq5yergYqoACTI8f0CTJiem
         9LBOKbFG0vGegkAVvSJTRmO8Yqi5mHHYJqygfDkZRnBir60FL7bH9gxxF7cDa5AfB9i8
         QGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711725887; x=1712330687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni/i7P5ED8HyT9z4QPlleLZS/5AvuItyMQEbyI5EX5E=;
        b=Igqv2z3r1DjjIbjE1p0dJ5zBupS6KBdiAGvqkZKrU09mChgTvgh6USqwMcPBChdaYt
         DNUfJCuBg3hb5/ivRWziJ6fBdBVCdHPVHWuTVyumBe7ZBqnYPEEhbM5QMaOGMHNkgClS
         1142ykpxq0HJ8+YxC/TICxnOB4Co3eLOOdtdvK9FPAzNdr7H86btAw0lG80Lf19fTanc
         hMoDrVeRH+X7HomQAR2HAJfsPIqNZ8/JwA6Shci3MdrAbR1plkCGhDywaBXyxkC1beTe
         /bxn9PNSdb63zC37Y+mmbSerllg6TNNIyf6mJ/Ko3qE6L1ddJZ9MmH/fySiCyY8/0xo9
         NE9w==
X-Forwarded-Encrypted: i=1; AJvYcCX6DgOabQIcznH9n2e7aOPIdmK/1SydUJbX9tDzD7lwX0slnhGD1UiWc6vQqdIULn6kFLv7GJ1hm2kPb/BajrU2VWsF
X-Gm-Message-State: AOJu0Ywgg0BnQ+keKM7Ng4DpgUb+9lFIjE/DXl2GJSt7d8m8WHmAnZ3T
	7vDYDdZ5u5PaUt0rKYxPsoFYDlgFG7CNR6G8L3GIMikNcqwXb85LPQtcp+P0XwI=
X-Google-Smtp-Source: AGHT+IGnRvXYyJSndjF4GpamTLF3qLn2OMLND8aSig4bSExIqZKdpcuyfY/DVujE4sL5uXuxdiesqg==
X-Received: by 2002:a17:906:f10c:b0:a4e:3a09:4854 with SMTP id gv12-20020a170906f10c00b00a4e3a094854mr1030284ejb.61.1711725887046;
        Fri, 29 Mar 2024 08:24:47 -0700 (PDT)
Received: from u94a (27-51-1-75.adsl.fetnet.net. [27.51.1.75])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm2031562ejp.2.2024.03.29.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:24:46 -0700 (PDT)
Date: Fri, 29 Mar 2024 23:24:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: fix possible file descriptor leaks in
 verifier
Message-ID: <kehz34vf6x7jxevw5eomccydd3wdf7t265dgsrxmgqoipuczyv@nvcm74bxto2w>
References: <20240329071106.67968-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329071106.67968-1-aspsk@isovalent.com>

On Fri, Mar 29, 2024 at 07:11:06AM +0000, Anton Protopopov wrote:
> The resolve_pseudo_ldimm64() function might have leaked file
> descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
> error paths missed a corresponding fdput). Add missing fdputs.
> 
> v2:
>   remove unrelated changes from the fix
> 
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
