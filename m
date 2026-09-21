Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39752BEC5E
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951876; cv=none; b=j3FTGTg6cRxemAnnuZJoP0rGjFcGcce9dLvVLA0UpE21JBMJiTmvmOfvxrL7JEcKx2NaL8OFEOqQxq6rg+ZPCFTczpJZgH/Z8DGjFtNTbeE2VYtskMYz6nHYGSoKsa3gZxFzQ4KV4I9ncgsGnEh8TN4q7MYUH5nu3pDTCoONSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951876; c=relaxed/simple;
	bh=kD4NNDfWBxjdHOUMWMPy/ZqiqBpF9OTHDoRWefWFDhw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=CsTUkB1YurvWCHDapaLlX91WbyfnGdSK+xwkAD5p3cJu44SlstwBGHyMVLh3w1/b+01A7JQZXIdQvyXx8A53mdPxdihMr4SmYlhGQ4gGi50NpKM4Wx9MSND8sHoHwB72tUtZ/CBlrVBajzLeWQMFgPzzc2mPaMZjmBwoxXOzhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl7Bnloo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl7Bnloo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso23263075ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789951874; x=1790556674; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rx47Jcw1toqcZofLN66BMlpuvvnyDfBPiFFok9YKbzc=;
        b=Hl7Bnloo3hTSlp5DKApi6O6/khP0fUto2sGGIfzg6yFIezNhKI/tbcbyg2QSd8TL7U
         B910mR5z68z8VwPDVEdUA1Ku0Pm8fJxE0ZPPCvD6h8OGy+0RAKV4EgeUqFFQlagIVIlk
         awDpo4F1hOJoYNoQTD12pH5uOI+DoC1pYlnm5MJt0KT87c6e+IWx04T5JFxhZauJ/W/Z
         nkgSr+9AURDns1hjZR8aTGgbESqha9HSmKC/a4gcM1G0iVwyzXYKP7LR4eE5+RP35PfS
         Z5WTSmaST5ny2kStpXuGUM8PqiSQq4Qdy0JsH3qjEMoR4sbJT90MykGDVGjS4XDI5CpE
         8v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951874; x=1790556674;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rx47Jcw1toqcZofLN66BMlpuvvnyDfBPiFFok9YKbzc=;
        b=gUBCxDVeJyYCqZp6ViONmJlRlBhxUQzCg9FI2Igrf2ryfvxEv/0KqfoY1gJ6g4X7bf
         OJkhUTZkwjxYcofQSyoxuAI0XuNuwn+qfIPqfZKTqAJI8iPeZ7PSeGuRcz+BzwK+ocHJ
         B7eHTkpykcoOfW1R8dmnNOzsueRCxh/F0zqhOG86HwGNwSwc63bjpxVglWA667wBU3Sh
         gEGT03zwAF7hsusPWTGv1EAHICCwuq+wnpC/GIpOUinJ3idnpeiJK/pWENJJ1dEuv+Ve
         Qzo9ByCAto3D5TCL3V/xBy18cXa0x7SqMoPFf5iispzSYDTag5kYsa72S6n67sIVWtqe
         atXg==
X-Gm-Message-State: AFuF++kd3fmX4dMsuMTaUE1XCpFE739QzUuHzSH2BO61tRoU2YNwDXEl
	ivCVHAz/j9BZc8jzEs6BoKt/QpBTm4lhScj8y8uDOy+M6Wzk/jFXNoKS
X-Gm-Gg: AYBFou1VU+fkHdCcJRyUvbDU5W4LStRuB/TdWWLAtTspRoE/2izho+4IB0sq3bR4DeE
	4utsKRhDp2GxJCP3eDkzKxMkbU7l/1jyUGrIRTL8HzGyJ5CGP8ilX/8fSm7FeG/hkioJ8WACmTS
	CvhodwjFuNOqdsRqUFgBhUVWmXZwxv5L3TkH45yjSnUNirtODXDF7lxqCj8xrgu7dArWuXNgRw+
	zBs9T9BrSmctCHketnu16B2jdeC7IuqTza6auuLKDbjV6RUHO8phV1qFhAITG/PUqcLFKlvmLFN
	GRKNAkzOqelnmhg7ex0elUfYE2DYsbk5/y0jbJ1zGz8aPWB///WQLnS5cYH1+M1Lu69HOSpTLFe
	wiDx1L/0OivL4aORXaV8417B2ZwMTJyMHFARQOjQUIcD5xTDakBgJ70fLzLgHShdjecIuVJBL28
	z/3m+5bTFTC07Lww9Gb2BwhbK0A4fWXqEfLuUhKwparRtFj7pdySu/A2KI7p3pOOSHccMHA6iWh
	5xUzX/X3z6ZkAPRlW+dWfnWpeKL6oI/TH/T5vOYCoWV6tMyTBvxiwz/9DrliSqO+85oJD12ECZl
	9YI=
X-Received: by 2002:a17:90b:134f:b0:39d:febe:7460 with SMTP id 98e67ed59e1d1-39e54d3651cmr14054624a91.22.1789951874205;
        Sun, 20 Sep 2026 17:51:14 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c379c4bsm11558903a91.7.2026.09.20.17.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 17:51:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 00:51:12 +0000
Message-Id: <DLKKZEHWGP2Y.2C0DPQW74COKW@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <mykyta.yatsenko5@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260921002206.184660-2-tjmercier@google.com>
References: <20260921002206.184660-1-tjmercier@google.com> <20260921002206.184660-2-tjmercier@google.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 20, 2026 at 05:22 PM T.J. Mercier <tjmercier@google.com> wrote:
> -	if ((u64)attr->key_size + attr->value_size >= KMALLOC_MAX_SIZE -
> -	   sizeof(struct htab_elem))
> +	if (round_up((u64)attr->key_size, 8) + round_up((u64)attr->value_size, 8) >=
> +	    KMALLOC_MAX_SIZE - sizeof(union htab_elem_all))

sizeof(union htab_elem_all) is the same 48 bytes as before.
The round_up() part is an unrelated change in what map_create accepts.
Drop it from this patch.

[...]

> +	if (htab_is_lru(htab))
> +		elem_offset = offsetof(struct htab_elem_lru, elem);
> +	else if (percpu && !prealloc)
> +		elem_offset = offsetof(struct htab_elem_pcpu, elem);
> +
> +	BUILD_BUG_ON(elem_offset + sizeof(struct htab_elem) >
> +		     sizeof(union htab_elem_all));

elem_offset is a run-time value. BUILD_BUG_ON() works here only when
the compiler manages to fold it, and it cannot trigger by construction
of the union. Drop it.
