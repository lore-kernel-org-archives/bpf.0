Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB736921B
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221997; cv=none; b=FCD9EjKRfjD1imd/Xgiqo0na0655jUCTqg19IFa2toYI5xLwH5bZzrSVuRDIH53wdVmRsB+VMZQ8FzIrrNcCRkCjtsqhLTEd6xEF4lqOynu2DILdv2dvww0FiH4QirPOiN2NF5wfixF+IpAKc+L90TElqwNz12erwnrCfqspgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221997; c=relaxed/simple;
	bh=pZgmLOsy2veMsKnU5rjvrR4V70o/joHC+D2JuaqHmoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiYXzMSkr3fCr5sNE7TffnztKPjyJDAnORdUgcF89zn7BR6EISfpHEAzkfPRPAsPImCeEMLlEv60i1I9hqSGRKl0LPlWOhGWrvQ8Mp5VrPNPx2Xr/hc2zGqty4OJu1iUjh0x+h3rPdfzlkn7vo2N8vfdrIqoS0ETnFmk9cITXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAZpBdWn; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAZpBdWn"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2448084eec.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772221996; x=1772826796; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hWt5DSAy2O9L0HCpGxxQZ98QvgNnywnPi47JnXiaEM=;
        b=UAZpBdWn1n52g4gzyAcKQCcUlXQyhl+kgKDoZLlU4VDsS7njqwTx0csqav6JbKGXwx
         lTqi/BJFkfzMNSbDKtnh7wtHlASz/1KSlyb5KpS9KHkz3XNzkLP9AHpB6aaClqfTfJgp
         qBiO3yTJjnQv2+afgO1UBTrQGDAWt0Kp7EJguN6l6R5LZWmzrMNpa07BdzvNn1eIz5mv
         fnpbj+D7nIt1RJZq+s1sZP9i255uEwZogJH2ECyhq9VS9xvEZ6lbUewGcjH+4X9d+MHO
         Hw45iwqfgGvcdM563xl3IYo2D/TKro5ceuH28qv3vuZSbivivsAs2C8kffYr6uFyk5vG
         aRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772221996; x=1772826796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hWt5DSAy2O9L0HCpGxxQZ98QvgNnywnPi47JnXiaEM=;
        b=fLYz8ZTTV1P1U5U34cyDQNiUUYktTmzaghae6f7lB4jovmBK5DOTZTlSNhvjTnYAeP
         Pa6scCr2/3++DTCxn+djfwJHY1AN6nviaV5igB/reGEUnHAM1CXaCp1hCfPR4UWLzsjV
         KbtS6swjaUZ50/MHMYA4bDyTn0yXLiMBCPW9fqDOzWdjSW5JJyjvu5b/UdMerhNOw7VZ
         KqjKuEAhTwIEBhXzXAmpcI9rFYQ9qVIyLw1woDtISpWLTDIeDmc/wW5biG4OC1E4Zs91
         UsUumQrl2RCOFrWTZA9y684fOYyWc1LBC29B0kYnOAUUJeXbFmDpUtzLBkyg6cUC/Arg
         C1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVVhR2dtKQHHkNzJmZrrhY6ByCk1uMfxf7wS9ZsyLNWaRd7SQzQMSAaHL8YC0Ol172Cx2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzoCOegGRAuwZ5oXGNbkb2qfuT5J364lV0Ey8jIasa49Kj/fj
	AL3ntpuUp78eII3pzs/KaTNToVqxE2nvtjSkM3kAknX1fvKmP98kUL/t
X-Gm-Gg: ATEYQzwuGAjau3oiy0zwoh1v5iB/VUxV/ZDmka42EwRecUxrA9g0BV1hIDKYdZqDU8c
	qW8BuioL+mcVZUdCQkq6HF0NdK2NVLN0tPgUY2ZR7U13brHfR/aGxODrmz5FUSi6PevZULahRMU
	tKlu6m2urNETTYLuWq3k+PC3Bt5oluMiJkOwCP6uwNYBiwy8Z0ItiifscVqUq9xxF1UWDUjWdPB
	EOenbrYCg9WwpNTn3KgExv4wVBcxceE6yfOvAGBfCCPouZb6TjN9H9sxcmkoqiAe8Ean4EDRHQY
	RsFJpxX6jI5qPAWQVoXsel++xVJK0RAuE80LbhBzmBFljN1a4Wo35K+ey3PqZxyXM40GqjX3BAo
	JdciU2/E9NH9EUGlXjippL+lTQ7XGmG4Ww7pItvYGvrAdPcvpkx3Or6VhN1TKRlSXajp1Z25ANM
	1P2WvLiMqs5FmJfpglOnac6xdCk+/uyjfw/y+kYYeYOWlgojg1Ij+j0HUPSG6Df3wVX7/gQJZOI
	5xF9LFp
X-Received: by 2002:a05:7300:ed18:b0:2ba:8aa8:9bd4 with SMTP id 5a478bee46e88-2bde1b5068amr1743354eec.5.1772221995591;
        Fri, 27 Feb 2026 11:53:15 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dacf:39ea:b35b:a26e? ([2620:10d:c090:500::1:1089])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1e02f95sm4501410eec.13.2026.02.27.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:53:15 -0800 (PST)
Message-ID: <3b9d736ab4b73ba79b237163d31b86bd50c34508.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] selftests: bpf: Add tests for void
 global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Fri, 27 Feb 2026 11:53:13 -0800
In-Reply-To: <20260227154616.6846-6-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
	 <20260227154616.6846-6-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
> Add additional testing for void global functions. The tests
> ensure that calls to void global functions properly keep
> R0 invalid. Also make sure that exception callbacks still
> require a return value.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/freplace_int_with_void.c b=
/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
> new file mode 100644
> index 000000000000..8b6f5776cf0f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <linux/pkt_cls.h>
> +#include <bpf/bpf_helpers.h>
> +
> +volatile int data;
> +
> +SEC("freplace/global_func2")
> +void test_freplace_int_with_void(struct __sk_buff *skb)
> +{
> +	data =3D 1;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/freplace_void.c b/tools/te=
sting/selftests/bpf/progs/freplace_void.c
> new file mode 100644
> index 000000000000..cfa4af00991d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/freplace_void.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +volatile int data;
> +
> +SEC("freplace/foo")
> +void test_freplace_void(struct __sk_buff *skb)
> +{
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

Nit: still think that 'data' is not necessary in the above two hunks.

[...]
