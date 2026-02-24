Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19031DA0E1
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892678; cv=none; b=Yt3U+ugi+buLuPBSWKWU5ohf5oyycIgCqcZVr4veAkRdae9/TC7e8rjheHDYrXd2OUnknyFmvuiYMiIq6MH+WWQ9LYD/yeC13SXWCUXBokp67KUgMtu2JP2f5+hSc7o2Vm8SLE23qaJZ2COs592vSCWfQJM2Leqi+eMxB+Pcc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892678; c=relaxed/simple;
	bh=q8n7CA50UuucBqU9fN6QVQrDf/GTALWdCJqtvUHixXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGBzSjDYGPFVmEeuqemOkvrfe9cyImTROCtKTDKBWV5s/n+jxKVYsE7mSej/uXKYDfg2SPNmS3tVFhI78+VnwfBNYAOyPXF2EmEb9XDm85g5ALkzum+dJyeBZB3igu3aIgverng2XYGOeesgRjqqvBgGwrsXvTyl+ZxcptcNibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj90vWKk; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj90vWKk"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4b77adso5943471c88.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771892677; x=1772497477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RiQjCS08myCjqQv2m5uEJAVd4NW+I0cmFJHv7X18dj4=;
        b=Nj90vWKktw9lV7lN5jLV3L5piDU7zeMdTPA/SbG7xXx0Mk9dQpuvQITAXRCCRGk3c8
         SQFlqn3u0zDaeWbpFIhTxTH5iOT3XT3BAvtSAnWPfM7BcaWIXu9yvSgQ8pt4nZ7h2Ogp
         AJ4egCf5/MgAVbkFeT96zh1MBbquYDkqei37OJm/b+eonO59cq5l8DgXoK8rqTh4J3Ux
         krpA/kR5o6We4VfkFX8Vpzp588lXLiPiAwNeczDRMS+2xgTS+AzfAqZFSjsBejkxWXa5
         mEv5P7uLCRdAmz1JAAQ2btxrehCzfiEV7bf22Myy24QVcOCzcb/SwJABMIJC4smKZEOG
         nATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771892677; x=1772497477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiQjCS08myCjqQv2m5uEJAVd4NW+I0cmFJHv7X18dj4=;
        b=pKNdI+uS+6ObITAWitO1xm9ToL6/Ft333haIjlBhaszjQ1cmK5w69KL9e/x4r43jD0
         swcQB1WHU6hI3bSN9wsOl/WP7TTgGOgwErKY/B2uYLuzBeW4w4hI+PA0cACVBS6f0rtF
         8TwTAu/ylLcmwDOxHiIiCBIwJA7yxwhj9hp4YpMpFKiJIsDqSSd8uMTDfA/WGTXuybEO
         Vsj360OHFjS/L1y4O4e0Nw3yeffPpfeSYj8ar83G0KVVGMMHTIGTqGCGC0SAn/5uGoCt
         SvJJNeCMLHJ+KnZJJ6+kZO99h3460eMg2lzOzA/PRZLeZ1XF5ZtO9dWkYn1hNZAGq2C2
         Cxpw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Tt5vQGUUBiXQzkdVH+INtrdYoi+3ior/6pAonzQWTJKleS8JW8miB71ijhAXwHpSZeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hpPk9hWR6K1VHY5Mc9F0lbvRDTsh5cdjXpd3lM2yTxN85iAu
	EdcqJimrYtL4DID+lDD2gp7xAgCuE4KilZkgHQZPVWXAaR8/Ymwa0bpG
X-Gm-Gg: AZuq6aLgobRD5v2pg1c6EHvqL1KxVrEXhHE14H1ZoxfU29K3AGfRKfGF4mwGeFjUl0b
	g4KPdp5v5IScTWTmxmR7vwWcu3gVvR3Nj1J/hG51QSHA4dUQdiz0YflS3DyzkaaZ+ikQ/qg2DxL
	T+SqBd0NCkPPSNwOhuNdwEJlaQX5eQGUwJWmmuce4RvCc+RVuFi3qWEZamXrY2afGT6qNLOlLwn
	FoGjW7DZELK6ZnYxkG98oAcWxklMX2eB1Qt5zi7BHX5Z5+my9RgrrKmosu11R8Kd6LIGzoSMA/r
	64LJucgvqqnTaTJqhzSc0M8YKAJ6EMle/jnu1M/ILFs/7xcuKb5WVyb4pY6QbOU67x9hD5eMpq4
	Kj2HewzLyGsSI8eLkis+/co/vw19AxIlPZEdeyyQV3ZdqezLAdcFwoUn0UjHHTRY37+J6LAMpQv
	KAAPJ0UuZ9xJ3ZVpcows8S+nGo8/HoFBcOAkwUl5Tgi5e9BroHWdHBfbs5AA6OFj9MU9+6ijnPH
	VGgiiWe6/dEROUJLRM=
X-Received: by 2002:a05:7022:160c:b0:127:5c70:3523 with SMTP id a92af1059eb24-1276ad188c3mr4057068c88.26.1771892676786;
        Mon, 23 Feb 2026 16:24:36 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8ac3fsm9137060c88.13.2026.02.23.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 16:24:36 -0800 (PST)
Message-ID: <107f5fd6beb9f561cc759754c1724f7d0ed7ddb4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests: bpf: Add tests for void
 global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Mon, 23 Feb 2026 16:24:34 -0800
In-Reply-To: <20260223215046.1706110-3-emil@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
	 <20260223215046.1706110-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/freplace_void.c b/tools/te=
sting/selftests/bpf/progs/freplace_void.c
> new file mode 100644
> index 000000000000..76707b29dc6a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/freplace_void.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +volatile int data;
> +
> +SEC("freplace/foo")
> +__weak

Nit: __weak not needed here.

> +void test_freplace_void(struct __sk_buff *skb)
> +{
> +	data =3D 1;

Nit: 'data' is never validated, so there is no point in 'data'
     definition and this statement.

> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func18.c b/too=
ls/testing/selftests/bpf/progs/test_global_func18.c
> new file mode 100644
> index 000000000000..3dafb0dc2342
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func18.c

Nit: I'd put this to verifier_global_subprogs.c

> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +__weak
> +void foo(void)
> +{
> +}
> +
> +SEC("tc")
> +__failure __msg("!read_ok")
> +int global_func18(struct __sk_buff *skb)
> +{
> +	foo();
> +
> +	asm volatile(
> +		"r1 =3D r0;"
> +		:::
> +	);
> +
> +	return 0;
> +}
