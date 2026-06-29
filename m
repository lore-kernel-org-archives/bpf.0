Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8460EEC0
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757395; cv=none; b=DW75YHebZb856ocGZc2oVeciUBet0BDxJPfgnPy1uF/7r9pP9bA9savZT3ATBFmBU/Wo603Jqj0ODyfMF4/0E2PJgQshJEci/LXBU4FSSZv0GEp8GQvIyoRpz7DSh90u0JXU0Upr0aXXq/nAqo6otAhB71s/Pk9AzvtozoErFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757395; c=relaxed/simple;
	bh=HXKJzIqlMkeTj4xiirjv27JIyF2dlQ72OwPiqWiOiyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pKu4o7RAInAPLZbcz17qnApH+a0JUYWnbBAYuznTCM7UQgMx7TEkZ94eGJ0Nvo7vODxURxMSb4x9U7D54CwgLhSlnEDNZLOMtqk3S1chRi+cAvN8Bhj4P3GkGxjGE+Q+NTIkPQdYPwwH50qx45nMVp1fXnhsKHTKbD/EmyVSl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUA9v8KN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUA9v8KN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9797ec365so3305084a34.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757393; x=1783362193; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK1T0wSHarnQtYH+n6cy2fmoPGE8uk9AK5oxs53jWwg=;
        b=sUA9v8KNoR7WgR1FWyg6v82mRsXtcH+RVvP5Gi2gf4pj98+8hl9cz8WqekmIBu1jHb
         P5cPZsltK/1oxG9rb4x9vMNhIS5NnBaezjoZzGs+TyA2DJTUhzdsXOXTVqFF6+Le18NE
         rjchYQpvGD8k+1WCtLgvpXDlGqwx3/ZiFdyQksf6x8I9CFAoYWe3LSp58nsdvFLE64J/
         wWFn+zCuj6GpNHNLm+UPXOt6J7RZaYvLbWdhZcP36E6uAxnO2AldJdQqqdJXVZak500O
         UhZoGzedODBkDH/bngIlrfj7/eVXpn/gYRxrg2BlT3q8oFB+5Xyxhpzk6FONxmWVqJjo
         Az+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757393; x=1783362193;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LK1T0wSHarnQtYH+n6cy2fmoPGE8uk9AK5oxs53jWwg=;
        b=r8wRC1+kv/I+wCLTDIgQmQBmqu5IUtJD0cz9LF7HOPOpsASvw7v8Ob2HBmt75/bEfx
         /XrBABqJ9cYiVuH4Ts0WwSEAZb8t7yXifV9lnMRq8tkI17XHEeKhkkMYLlzgrOad0pU7
         GU7Aik3frGPuD2/bACi1R2R7MwVxUTB/i6nPiYnqTNpt46Q75zVTGAJCdkXwIkNVhi9u
         7XXfUEGXyVlsJkVfq5LsCKR1GwgWjZomqz9a5VLyziMOIa+E/mY5LilTQ7651IxKSMDJ
         2Oo1GQsGhsFrLU0Xe8L8Fhaodayz0ByOlyYw0xUn6V6V8cZt46awbF5KaBFi14PS6kPP
         ea9w==
X-Forwarded-Encrypted: i=1; AFNElJ+S9ms9MxUEF9V1vGkT9PUFuLhV3NB2ghLakr7eKcjaNkvGS0znRhZMzLV+3oJfXtoPdZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cYGyqkVQ1ksU18kazPUg+6WJZzJttDSlxIg4vspD1P9xlQFM
	xRlTgMZHtEkUPTZtCMAPPc2d3kWXB/4JEzmH9fOa2OIhKlEt4XulZzgh
X-Gm-Gg: AfdE7ckJF1TnN5n3ZvwYegnBZJnIDfMWYvLmtkYIPAe1W2udQH2ZLTTquQtrh2CSrBL
	SK401NVVaYEuCH8RjCQh5fCNLWkJm02ZK5PIN+tCYnjndPlVHCjOkgkTl/+5WxH/L/bruXWMN7w
	I/pZBThspxozzDZeg1plGT8nSZ2MtnQk0UcMVv/xYK4N9DECKL2QCvEHmCYYHyfibOyr96OLfwS
	7wsE4samj+gCWx3s8QBvJ7ulRB6+YfLsyFZFwu8yWKfhF6+RSEQSS6cwMlAQKLrO1FGzsSlMq3g
	H6JZ5QkAY4lQNG3+v8L7R8IoLaek/1hhwZ8ghp5ldIA2lImIVN5ijLLFWk2HrwijTQoxrcqvO7B
	OqcjOK+y1DybJNSt4toPEH0L2PHUaZM3yRQeOWTXUiKvYuDKdZKbbgFagSjybTdsmCEdk2XqxY1
	h3LNVgDty/3JhJQBUskO8qneGrYlxgR4EkP88aqMfQGWrkXNnYXHYyxMFYDYqY0xz6AUnQfl2yS
	SMmoQ==
X-Received: by 2002:a05:6830:6af0:b0:7e9:c735:dfc9 with SMTP id 46e09a7af769-7e9ec5eabe1mr470006a34.8.1782757393461;
        Mon, 29 Jun 2026 11:23:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec31293fsm358721a34.23.2026.06.29.11.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 11:23:11 -0700
Message-Id: <DJLQR3M9S62V.2FYC7QDSTU3DJ@gmail.com>
To: "Masoud Aghasi" <maghasi@disroot.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>
Subject: Re: [PATCH] libbpf: Add length checks for path parameters before
 memory allocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260629122559.3828469-1-maghasi@disroot.org>
In-Reply-To: <20260629122559.3828469-1-maghasi@disroot.org>

On Mon Jun 29, 2026 at 5:25 AM PDT, Masoud Aghasi wrote:
> Several libbpf API functions such as bpf_object__open_file() and
> bpf_program__pin() allocate memory based on user-provided paths without
> first validating input length.
>
> This can result in out-of-memory errors or different error codes
> (ENAMETOOLONG, ENOMEM) being returned.
>
> This patch adds missing path length checks to ensure all affected APIs
> return a consistent error code (ENAMETOOLONG) for invalid path lengths,
> preventing potential memory allocation failures.
>
> Additionally, adds some missing NULL pointer checks to prevent
> potential segmentation faults.
>
> Best regards,
>
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
> ---
>  tools/lib/bpf/libbpf.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a8..bb3f1dd0663e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8536,6 +8536,9 @@ bpf_object__open_file(const char *path, const struc=
t bpf_object_open_opts *opts)
>  	if (!path)
>  		return libbpf_err_ptr(-EINVAL);
> =20
> +	if (strlen(path) >=3D PATH_MAX)
> +		return libbpf_err_ptr(-ENAMETOOLONG);
> +

The code is fine as-is. We don't add defensive checks.

pw-bot: cr
