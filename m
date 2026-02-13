Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4283BB48
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943525; cv=none; b=uaqbwuXIwy0ZQX/eqAm7EVkK8SZ2tiynu5GzMYg75FBBDKe4M2efVKkY9J6zIu5A6kqxe8zsHnlC0eLNOp7/WJsOjGdz7YFX04PbcEszb1OJcuDskTo+L0m6TlPZFYIqKl9IqGG1CIBXdBg7Y/Jn37SASk+7zlS8H6qOGBIWEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943525; c=relaxed/simple;
	bh=Ak8NZRmMWh/S73zUnGZcHNvDX7uvi7KMDvTG6IFownk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Co9uEHHD6yy1ElgemGZC+iHAcIFWjh30tI4dqqj+yhh4y9vIhfZ1AzkHLcvW59Nax0NqGhb/ET6TDNJz4TNl08Wx0VC7YlVE1ZylP/umAHKj5Bkf7ZZFTSdyU43FYtY9LTkiGUR+yy18QSDCmKcJwhqmvWb05oSPactXbmCmilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHblshg5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHblshg5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaecf9c325so2523585ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770943524; x=1771548324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SbNvfRVIMsuYFwVUGN+A3CzhBTKvVW4WK9rLQ9YjjD4=;
        b=MHblshg52Av080kkCUdPCSd0QhXd45Ys4C0ztAG/R1OTR5KCvxx4kAXw9lgjzTq9Ar
         huYJbgRVzpxlKUELU1YEk0fRL2pSDBEl8yq+dar8WaecuZomziWrr3OFYlCwm1Nob1WW
         l8rAkTwA7DxMJXpBjmhrEdoX7XPlse49l+ZdPhFAg+04ve/mTkVyZzaRvMvbMCdbT4Fj
         XNRIw5Ef9IjA2MgCC0V29o7ZWdKBLZbwfjWftg2+LKC0qgZaJfsjkcYO39UH7z4AvJ3a
         m4D3+DSX4If86bKDss3wif9OKrDk4bXqO7gRkr4an0hcVnO0bdoxxkbB0qWeG93jfYXF
         maOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770943524; x=1771548324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbNvfRVIMsuYFwVUGN+A3CzhBTKvVW4WK9rLQ9YjjD4=;
        b=NZNFH6ud82/xAE8V/WqLDeSWtR3Wlso7pMtYVEnlfM9PmQbAIJnVS3iPkbMk2LVyrx
         5SBt+YNGXn6DPsbGXlgVe0AZ3VHw+lmTIeozxXT5tjvWSFayV7CJcq9663Sd2KJsPKEF
         +fRK7Z5WSc5c9e3Sv7b0li1RT+HQk+dizpPgtr6f2UL+rW3LsdCXFrrITBAOsYe54XMd
         kmhpM5LLO74zpA+NjEMjcPYwKtsG+UpVIMxhrdRohqVV7DL6iQcW/f9I6FUXsQ8eBFc6
         VqK6o3KjM1OoTcsLOQML7UwMbIRPc4WDBRxedY4WQhL0KuDoCLZEtUntLxJ4K3Fq17h2
         ZRXw==
X-Forwarded-Encrypted: i=1; AJvYcCUb67+uWaw4yCtzNTh056JgWJMuiRUajMYwDN+atDS/axp28u3Uac7RRKxxA9CkUeRlQOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SY+KXXklCXyT0hA40t8ZhL9tysK3HSkrSDm3SXY91S93Ydru
	l+Vmx/gqpS/laZ+Ez+EkW/2uE0pvMzyoYsoMc8zZOeiJQ60oAy8o9Cxe
X-Gm-Gg: AZuq6aI8TRxRoXX3qiPuaAl/rFd+pEL+gAzAx887XoX+bo8kkHdXODRYGNTiRIfrFmy
	jeI2c7AXRKx57GghxPt9Az/YvvjoT/SGN1vhzjySPMtwV7Hv1re9TH9YABGctnFYXWsQF3XYtPs
	AzvIEP6GLdosNMR99LBGy4XfeibGm+mSj0JM4fMnFQDHcXW9W7bJfd0Fo2qyRzsVNw6+A3BJse5
	omBxggMG3OtBZnxB4sxHrf2/bHBmRmYrUt/jnvTTa2wjOX+3xRM2wAHTuUzUDuAt4X3T+LCFEd5
	dWn2bBSSMfHCk2aFpN/cTi9vPBE6Oh9nYrIpaGpZ1v4GKMmfByNfaF4RNma/beg2r5Q1iL93x0b
	ba3BwO2VU3wkPrwPGa7ZtvykbY8dKzuglA4kknN0OW4GE2LAeNveenJIwpEdMyG+66XyieHpLky
	mgMUn4+MNVPGCCGj/P001lmhBCTqh6Dp0dNPi6i6eqjXoUCv8fG20=
X-Received: by 2002:a17:903:3bcf:b0:2aa:e238:e20c with SMTP id d9443c01a7336-2ab4ffa4ecbmr1660345ad.19.1770943523797;
        Thu, 12 Feb 2026 16:45:23 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2997aebdsm63427175ad.66.2026.02.12.16.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 16:45:23 -0800 (PST)
Message-ID: <834d266c1bce8d08484780d825136c7f51caf52e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/14] selftests/bpf: Fix resource leaks
 caused by missing cleanups
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 16:45:20 -0800
In-Reply-To: <20260212011356.3266753-11-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-11-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> ASAN reported a number of resource leaks:
> =C2=A0 - Add missing=C2=A0 *__destroy(skel) calls
> =C2=A0 - Replace bpf_link__detach() with bpf_link__destroy() where approp=
riate
> =C2=A0 - cgrp_local_storage: Add bpf_link__destroy() when bpf_iter_create=
 fails
> =C2=A0 - dynptr: Add missing bpf_object__close()
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 256707e7d20d..ce010602a443 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

[...]

> @@ -763,12 +763,15 @@ static void test_sockmap_unconnected_unix(void)
> =C2=A0	map =3D bpf_map__fd(skel->maps.sock_map_rx);
> =C2=A0
> =C2=A0	stream =3D xsocket(AF_UNIX, SOCK_STREAM, 0);
> -	if (stream < 0)
> +	if (stream < 0) {
> +		test_sockmap_pass_prog__destroy(skel);
> =C2=A0		return;
> +	}
> =C2=A0
> =C2=A0	dgram =3D xsocket(AF_UNIX, SOCK_DGRAM, 0);
> =C2=A0	if (dgram < 0) {
> =C2=A0		close(stream);
> +		test_sockmap_pass_prog__destroy(skel);
> =C2=A0		return;
> =C2=A0	}

Nit: initialize `stream` and `dgram` as -1 and add an exit label?

> @@ -780,6 +783,7 @@ static void test_sockmap_unconnected_unix(void)
> =C2=A0
> =C2=A0	close(stream);
> =C2=A0	close(dgram);
> +	test_sockmap_pass_prog__destroy(skel);
> =C2=A0}

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_st=
ack.c
> b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index 4006879ca3fe..c36aa2354d2f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> @@ -56,6 +56,7 @@ static void test_private_stack_fail(void)
> =C2=A0	err =3D struct_ops_private_stack_fail__load(skel);
> =C2=A0	if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
> =C2=A0		goto cleanup;
> +	struct_ops_private_stack_fail__destroy(skel);
> =C2=A0	return;

Nit: just remove 'return' instead?
     `cleanup` already calls `destroy`.

> =C2=A0
> =C2=A0cleanup:
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> index dd7a138d8c3d..2a4fd367da0a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> @@ -1363,6 +1363,7 @@ static void test_tc_opts_dev_cleanup_target(int tar=
get)
> =C2=A0	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
> =C2=A0	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
> =C2=A0	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
> +	test_tc_link__destroy(skel);

Nit: this is exact copy of the `cleanup` label below.
     One can replace the three ASSERTs and the `destroy` call
     with `goto cleanup`.


[...]
