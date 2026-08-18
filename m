Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A62376A16
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083533; cv=none; b=eZ6w7hoKPzEXdo4TSoMisvCQl00tCvux1Fa3j0k59R1CXfzBYq0L5YL8qbDUe/MnY266jUIqLqN4axSALyFOpQl6xEtYbit2GvnkW93dwpZzWDlSLd/4D5cD25dQf1RdzdZ5gljhEQR3hqhf3nuvL8DdWmx11J+NlreiRAmDclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083533; c=relaxed/simple;
	bh=dKPJhUx+10vKn7uaMJXqPXPMihpzsew2EQTiqPX9QEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdkSPEV9YrRCmE/hAZdfRxi2PAOMM3Fqu5zQRAjCyUpP7LTcS6MeymP+7DcnCsLZBLX5k8ZRAyyiUyVnKT8u1ywiohgxbmE7BBntX8cbYQOCEnLk1N9kUZJZ+rc0bV+DtNQqnjPODXeTnuXZNHY/qYgjj0CFzrZvY6wB4eje8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afbCEuop; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afbCEuop"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso408200a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787083532; x=1787688332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dKPJhUx+10vKn7uaMJXqPXPMihpzsew2EQTiqPX9QEk=;
        b=afbCEuopmlUmUCaI8K2LlIkiXUrSelfGIJyojUFjq1jZ2jVck7JoDEfpm5laFDAaMN
         UdqjVSCBLRhOEVYEXpeVGOPVKIuAEUBTPAVRqTnCA0LKRmaxNFmhiE6+UK8swTghjyKW
         Dg+mzqHEgDIibNEZyp3qhYwCd81UdSjcWyfuxCsQiVEWCdZYAqMGfpzA4CbcfbWEhIj8
         KJanjnTZ+UO54zD9TU8+J7JnGsTIcaz0vSpGaCRrA01YlNoq839Opqxu8/Sb2JNz+GC4
         vjJ1h0tflj67cwU4GnNhkAWqlCZ3UZu+t4H8k7BlLbkCmnfyX5YtjZRNZHCm5kFM9h6l
         P92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787083532; x=1787688332;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKPJhUx+10vKn7uaMJXqPXPMihpzsew2EQTiqPX9QEk=;
        b=MNoe+ZsqUZhBfss1lSFNf936ajiN1VRQyDK0TR4XVcSOx5KdT0c3wcph6SgwesG6m2
         ZOY1MoNWI/Fz73NJNqx6bAZDSOrSauhELDO70r3UoCYLP8T8+1pYqWTEp6G7wFAQeIUF
         xOqpnXwgOZ5tgb1gl3D3IBwiB3vuJA77u36+oixRuKFuzVwGCXAjJYZ+5UKsveRwXQWJ
         ih9MqJ91IukhfxkPevBTlv7oSE4hrCiX8vQY9BuLBhoW1ht+VEXetMYJ/6ziQBU/3zbc
         3eXmDr06xq+6fSL0ivTxZF0HNbW/SJVTNwYaBEbLuFcKJauDtqiyUyonCbFbCh0nyGiu
         qk9w==
X-Forwarded-Encrypted: i=1; AHgh+Rp8y8ke35POFarYzL7t4ACLFyef8N5ZHhRPMrXtRRE+D6FsSEahe9yEiQKD8DdUdndEFLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5DMuIK9SUEw3VC3S1905YwRm/AWzmYpG91w97RzHCWF25GDy
	cIugdpVYepuKlYH3ERxlMZbX4ert9OBopDk0uwN9ukAdqGIBTR0/UvOB
X-Gm-Gg: AR+sD137z6fREk01pCNTSl7VVkyWQbNJwAvjEh6WVTSXEsVlw6GjyxVONgxvw78LHzq
	yxgtfmi6D0JwnhGJkcmeAdMmZGZ9ScSTxI13jGHjnlH+lIhtOnUB2PahZJF59/o1XojC/GW1BJ/
	1RX8FmBQRDb7SoBazwv4VJ4OhPYzPqh4nT1IWZG20MfjPK6Lyd6u4UZEce7MVfCsW/4Yaoe8864
	wIg2yHaHn0R3rRDKKdR0GmZwWJ43yDQawcdHy9JUYhqtHipWebccGyTFLgypVHLabNgc4tBmDvn
	uT2ttmzw8HVNirRqHS7SEZSAukala2DyZjLRJ6IZgO3mQcdgyQ857XE8ZiHGl/5aDJAdyKTPFOw
	MI5tJvJINQfev6TggDmwf8LplxUWudFMeapDl3yGQBYhn955yR0Fht5lBXxHp0agF+yVD6zQ++G
	XtEqkWt0Pxaw80/JsWVbzgSit98Qexz/jakxoaBdOtw/ULyvta5Kvw0F1nTgrUViutfKQ/PYKxx
	Yk/xb/5UfZEQD25
X-Received: by 2002:a17:90a:e710:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-3957bd5d21cmr323853a91.13.1787083531985;
        Tue, 18 Aug 2026 13:05:31 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbc08bsm9586472a91.12.2026.08.18.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:05:31 -0700 (PDT)
Message-ID: <33065694711b925e8af3c6a446c3ece15b4cae64.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 18 Aug 2026 13:05:28 -0700
In-Reply-To: <20260817042227.2296079-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
	 <20260817042227.2296079-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 21:22 -0700, Yonghong Song wrote:
> Add inline-asm tests covering what the C tests cannot reach, since they
> need a callee that violates the convention on purpose.
>=20
> The coverage includes BPF-to-BPF returns, kfunc calls, backtracking and
> liveness. In addition, a negative freplace test checks that an extension
> cannot replace a function returning R0:R2.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
