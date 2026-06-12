Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8E324B22
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299744; cv=none; b=MyMhvOiNkoDoja2CnOTPUCGwDXH5ff9KqBvgsj4ph3JQF5oaknQJkFRhmndw3JNShee/5aSwrtXR+qMrnrnRm8PocwqD+GKpssbif0bMySKzp1us5KNCmia3QZA72HwCwySG/v+OWyf6Mxbz62wWaIcQyG4z7hKfb8ozKfDePQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299744; c=relaxed/simple;
	bh=E6EhAUOzj5dYFeOed0kTXgteLgJNh/fdB43NSf95XE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chpWhpNN/JRfYvNScUGffHjSO/jtMHUBr7aqYXljp6e/yt8wDc+X/SW+S+s8RhW1cdxkFdklrDLSTTP4jqJ01exik/aTEi8TDFOEzTiY3YjSS3n04JyiVMUvvY0MXKYVDzKm3YIudIzsReaI7XM3p4aJh8iaDdeLYs7y7oRCM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGW7vVgk; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGW7vVgk"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304ddfcf72cso1891948eec.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299743; x=1781904543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=loz+C+R5+QDLCCTJZjW1/6o0pLd6yUvVDakfW54ULTA=;
        b=DGW7vVgkdT3rY08uc0d1Hm5QBMaUeoA1Ee06eXNnT9pijXeH3YqYDRMQvPOskO5Teu
         WGPliEOh2rUUFRHcw4pkYiSpiH+qBNilw1xqVtKGuA9OlKaaLjsSXOA4A38RP/giaTI4
         U7BJF4UOv9iSv7Jo69kYjjIac10iEZ0aPzpaVGWMgna9YYYlqBezyNEYgeqfwE9d0OgY
         qLi9C04Bnokf0oiHuAtRSy37040VPtc6E7jHotD3sjq26x5O1BZ9yWeH/zGszr7VCidl
         ktvXO9OfcnEm/vy1M93zlHxQCfnye8+IGU8A4rDiaVt/rnk6s8QtmMJIhGsmF02dfF7u
         lYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299743; x=1781904543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loz+C+R5+QDLCCTJZjW1/6o0pLd6yUvVDakfW54ULTA=;
        b=HGD/TCbhULpytdtr1k+Ury9K+1cZ/sABLDiR3/rpH35pXUDCRGbyokGSuNEL7mthBU
         uJXcdIZWhPu1jdU3AxTMNE2+TIMb/7RJRLepV6oX21KanivPpV8QQ361Do4udiHc8iho
         OXa6AV9chqDT/5MDTynemDP3Gf4DgtBbKyk1IvBvDz00mDHTrCNbhZ1aGjipxyJrcXd0
         yqOsLLVx59fNwCd0IjasuQCfXEdXCVe38fo9KvjgiynFHy2YaoF5TnRbeOgdsci+VZ0I
         OLzV+VPhdWaK2BNwGY4kISKD4hDF6hL5li3b1JApChUGC6h/t5l/ARqKbFkLkA4KhkZh
         rEkw==
X-Forwarded-Encrypted: i=1; AFNElJ8hidOV3XjYlGo19N6hQv+PteD/CsOaC46SN3IrJ+PF6/Z570aVimLtwI49DB7APplm7CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ElIL4xbyjL4tINOrs+jj6ILjJlP0CceAAv2vckH4E6hp3sfe
	J6asey/sHQm/7zGoqEc1BbX/S/8eMRBfZRPI/gXJb4jaQNngIwZoXTSb
X-Gm-Gg: Acq92OF74QPFO635NWbgYKSqynF5AbugDH1jxMZxyd6wPoAPgRQ4NhgjUZm0mb6flUq
	CkKLx8Duiz9ED2b42MppMzkCopuIhED9J6rHm4sL0+tu58koYdg9tFnVkGjZNMHc7L6AJCx2Fsp
	DNHpqjWC1MpoYHrBtZBrcL/ckhKyHIzolD0QDnBI1N26LX6Z4fkt/5jJ+ni9OC4HEd/24w7YUf8
	vs+LAsMd/t6FpSgm8t3yJ/n3soanDOu2WLw70QHpZgQlgtlrtNeSRkrkUSCre+WNEqGtzjEANTe
	MtrBE8pWF/Eo+1NI7eLZvkR3MkbUmW6pzEt1kp6WRXtEITG5DI9kbiNAVFjozBwo8CkpteuTWK7
	JrrIVA5QHiZmUHeRkaJGGGLRkFpAEeODwPbk8eJ4/hfSt7yM95UGRqgvrmmfXAm7m54XeOadk3x
	ur8vo8IR9CSQ9JNhuX0OftUlvcfzM3qlFH81F2C/bI265Eg1ABk7NtQqlqSveioV3N/Nm2xSU+W
	PBxlvZu
X-Received: by 2002:a05:7300:2d2c:b0:2f3:c3d4:382f with SMTP id 5a478bee46e88-3081ff78752mr2812166eec.8.1781299742584;
        Fri, 12 Jun 2026 14:29:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9497:cf9d:9fc8:debe? ([2620:10d:c090:500::1:af9e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm5498624eec.10.2026.06.12.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:29:02 -0700 (PDT)
Message-ID: <2df8605762574ef5a3a93bbd7997649f00cc599c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for non-const src
 shift
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Fri, 12 Jun 2026 14:29:00 -0700
In-Reply-To: <20260612093818.18609-3-ziye@zju.edu.cn>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
	 <20260612093818.18609-3-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 17:38 +0800, Tianci Cao wrote:

[...]

> +SEC("socket")
> +__description("pure bounds check after non-const 32-bit arithmetic right=
 shift")
> +__success __log_level(2)
> +__msg("w1 s>>=3D w2 {{.*}}; R1=3Dscalar(smin=3Dumin=3Dumin32=3D0xfffffff=
c,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D-1,var_off=3D(0xfffffffc; 0=
x3)) R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3Du=
max32=3D4,var_off=3D(0x0; 0x7))")
> +__naked void shift_with_non_const_src_arsh_32(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	w2 =3D w0;					\
> +	w2 &=3D 3;					\
> +	w2 +=3D 1;					\
> +	w1 =3D -8;					\
> +	w1 s>>=3D w2;					\
> +	exit;						\
> +"	:: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

I think we need test cases exercising all three paths that can be taken for=
 arsh.
Also, I'd add a test case with non-const src register that hits overflow lo=
gic or lsh path.
