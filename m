Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11B2765E2
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586954; cv=none; b=EFw2BkrSQfeAe27rTcgYOteXjJUhMO/Xu9Wr06ZWwbdIUAKAVqVPL/cyNKMX0V0wpapG0TyUGQb4XAznD5aovKIXeKLH6HH/AWxfvL1zuIfMUJ0TqVzaVVZQHKAuQqVd55UIiUSd8TPqLlN1zZ2l+xh77XSvlqGEMOu+mrUT1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586954; c=relaxed/simple;
	bh=7z+fWgKDW1F6Wv99qwQ7uAL5RTohovk0e9Iqrz25H0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcQE9UjAaXHx8ZFq7KsMaKOZH2+nKkQhPaNyofGtjg4AYI1Adfif0Gc6exTqmDta286XzCYo6QXXVSS8wTP27l3sgqACbkYZ7M2YnrrjjD8HuA9xHy0O4EJsoE+HuC9EuhBysnxiJ7luyv2JN8ZBnV9AqnJBi7tgjIrJc/mZ7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWUnhKO2; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWUnhKO2"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9694so998975c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 17:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772586953; x=1773191753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wq225EOkYLXpZrCTMQpubuuSENmqFA5fwiUlY0kCVWc=;
        b=mWUnhKO2r0iho/aJC1foVT34dC8kOmqdRJt7U54+om9LCN2UhMCFsMBzboA23tR0A2
         omBZZyFe8RI1uvjuk/Jqp/9pikIC2ZjBott3Pd1tYww4N6Fx7xGppOv/XVkrYSsf9Hfr
         JRvMjIucn3QpbGGOlDDr1zl3xlSlFQK2n62nMY81CCXafCsYNsoN6grx1IIWTN5itpX6
         w0ypORDSR5odhJQ3i4aJvL9sfUwbQ+67bugSABH/LKbEjh6LXDbd+SN9D/rqmCTZ/TUo
         6Dk3FJIGLhcVX7XUSA3XO1c/1BKZsyLOLIs+TXYnyeECv8vChdw/MNkxJu1++EC/qWIs
         0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772586953; x=1773191753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq225EOkYLXpZrCTMQpubuuSENmqFA5fwiUlY0kCVWc=;
        b=f9eJpcUwl6kwHmQ7Pkf3pvWeiuNx2sjTEH8SQ34186xdeX4/aZ+LQl2gVjiP+dnG0l
         KzKvNOuJeHUQETzDt/EG2VBK1QbMGynKwxEPT7YzNmpiDpHgNpcGUn6COmujIP/Rolye
         ZvnAAKIwj9R+UU2X63yPQRdtVkosbZ7bV5DVIaK8GnTkMpOWAqka+5NLXpY4ifmiau7Q
         YLH8cPnDgOySIpntt0Bhl+v+IOPQhRrEogc42HZFm6h3PSp4phuMSEOamw8elqGZmGcp
         6kJXKBXtmkXBaje3U/mLfmm85j0ahUKPgpxQh1T2lNnjvH//wDsDO6a8FtNgaGplj8HA
         TCuw==
X-Forwarded-Encrypted: i=1; AJvYcCXAWfgb7s1wzr3P7KVQr102bbqyPThipZ+EA+NQcd/AR4EfnbbxyYw9Jnt9uiO0/g9s3Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYBu3Gb0WNXQ9gJESesA3i9fmljsNuLFVllCfox7fQsMwbvJM
	dcGT3LARLb4t5t9PUlo0ICBwuPVcjOUYX188Q3ZiHG9/PqQn7oOxax/s
X-Gm-Gg: ATEYQzw7yXUywv0Lq5CaxgXG5UWQYpAgZZk+4MjfJPMcKI/yxzNs/CCCVATEzlaagUa
	NX38Gvbc15HQTZQ7HYvPvCZj02SsXRcfqFQ+14zSfNeosgl06QE6VQNQp8T3b5hKaTca6FPR0Xo
	YR9fXw4l1dDz9R9XzNlyEenxk5yZg3ZNRfxBVOrO/5C7JsjOKi8xk0WMLYVQ2oaW+UfDFHHccGs
	o3Va0/p+to952r/N376l2T9q7JXGurPqhijEiu5SYdX6j3SIFzO/BFEicQOOuTRoy8EVEqRdCXl
	t33X9kNsY8PMZLUNwC8+hxxBxlblKWgkFnPbyt6yhd7/hXsoySRBB57ntiuZKAjKtJ/Y7plLi8b
	nrLr4UipA3Jhjhbji8ldsaaS3A1fOJ57l1w/rDkDxd4kzH4NizUaTHLqRE4XPrUPv1H35jDKWCa
	uFBVKckbIu3jOt6q+6/rC0ZhLZIdI6gLO1KkevVTdNbvaLR7ojbJcsT3Uy0ESGeZFkz7RWY1lVz
	D8DXlX4
X-Received: by 2002:a05:7022:ea48:10b0:127:33e0:ea33 with SMTP id a92af1059eb24-128b70d1422mr74806c88.22.1772586952582;
        Tue, 03 Mar 2026 17:15:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm17666099c88.4.2026.03.03.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:15:52 -0800 (PST)
Message-ID: <f7a9492407aafa4482addaa6a8879cc9441eecbd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add deep call stack selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Tue, 03 Mar 2026 17:15:49 -0800
In-Reply-To: <20260303043106.406099-3-emil@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
	 <20260303043106.406099-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 23:31 -0500, Emil Tsalapatis wrote:
> Add tests that demonstrate the verifier support for deep call stacks
> while still enforcing maximum stack size limits.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +/* Check we actually honor stack limits (33 * 16 =3D 528 > 512 =3D MAX_S=
TACK_DEPTH). */

Nit: I was wondering why stack usage per func is 16, as each one only
     consumes one slot. Turns out round_up_stack_depth() rounds things
     up to 16. Could you please either add a comment here, or just add
     a second long in each function?

> +SEC("syscall")
> +__failure __msg("combined stack size of 34 calls")
> +int global_func_deep_stack_fail(struct __sk_buff *skb)
> +{
> +	return f32(123);
> +}
