Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F783285050
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018718; cv=none; b=Zas5eFDBYPmhOD/EiFIqunLdsRXrwtPzTzIvL5cG3a8bRbgmP5de7yAk0GUULxsRmBfP8OT+kI+Fx/vV2gj2i4GbAnYJiXhDTadvfZ5G+b8gF01VRQRErexb4YaRID9SLEmyf2ffWOMtpQXl77N/cMnqlsyJwB+K3vJ4oI3v+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018718; c=relaxed/simple;
	bh=ofW8UE/nmqqHVRmRE5y10oc7ZeacERXFqOrdwloP598=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RlcxlarlM7gxqRKzeiPB4WcNHYj3RVHqslxWzio/X5RUWUZoU36GrCPTzzlypEHe+R6vnO/+gpLki1mzFp8l4HgD+Vq4hkZI5GvMKpuX+OR6XZkVGHSJVnbaDp/vtf0037RyGIoJpvsrc1eCh/FFbehVpFOQEPp3fPJ+b4fMQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KZe+K3ik; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KZe+K3ik"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2ab077e3f32so17364525ad.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776018716; x=1776623516; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIx6i71yeNM1IMwQFFjly0yWfnRogfZzFlmWKRFVtl0=;
        b=KZe+K3ik7nAYPdU7Nfkqa9CThFbMfv1yNNuqhiOwRQqkspgBQ/McwWMn9iURYEuVm5
         7ywxRjNTdwsf3gnQw6YKf9q36m8Pwm7lLm1zASa4PGDqxQox6QR3KUZOayfhnZ184fpV
         G8UM4bqHJnDFGimmQjof6f7EbQzzllddRnES2T0n4SO9AdvMkgmUgt30/qKLEgsecLtK
         6T8AvH073D0SuqtqjZqdAPyh8kIGMKT+cSJdPWSmX+/LhY01gv66gAR1phOG7+uhKNsk
         +TbVnygHsAl50UsjNQIkeuPAkztJDX0seY+8EaMeHnA5l+Kxodit4D+74i9fdmbqBoqK
         wmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776018716; x=1776623516;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIx6i71yeNM1IMwQFFjly0yWfnRogfZzFlmWKRFVtl0=;
        b=HjNmXyb6hKkyUevA8vVzTv+ns/BvqCd/opyoQC3LjuAkVrg+43BsRHUlpxq4w2Jpwq
         GiH/VkzLMcs5vqEGV0tmACB0QvFS+Y4sEU0ZBLp+CGkWi7VaIEbbZTpUlyIh8Um/bhol
         MEtiuuCffj0yAMNeOy5UOvZT5FDHNfOP/mT3Q51/z5DlIlWSEvgIbJhigPA/+VCPEBGi
         2NasLgd7SX0xOb7+SitGTQn9teAWCz7XyfAlZOUR+KXGm8xwBkmLXT2dKvm84JmJRX7Y
         Se6TqjdtLjEY70PqlBlQSwv7WjeDJIs5ixEbbLh01fU8Pzy16Rl5NOa6ApIz53IA7W4D
         QGBA==
X-Forwarded-Encrypted: i=1; AFNElJ907ctXgaYMM5GPpx/M4foM6pZAqFa2uoUVpAPO39Gvb65a8mfARKolrGCwSWkUiHIMHZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBaQYR2jKksTJIJMxzBRAibki+wrceeIE57sI9soAM7i8GgDQ
	zD6imK3SHABC9hs06+nPhzUAvPSMb2Md3bm8H/8CnlW2/uYUyWtMWVj+EAyp4lSDbBU=
X-Gm-Gg: AeBDietZYZoVVts4xglyBvSt+5ElgfXth9R7zu/UFO63TJx7V7tXGpQeyeBoN5Ev6Om
	pq9TNW3HvVyGfZPmlIPVzOf60gep1/YgKCwwimNvCbaIbW0k3A3XL78MBC4vHX0u6zvfuVwRGKI
	lzRnFUbdTbCm5JW2NNT1y8jv6PgVGEoDSINNT037qZMu8428sIETKlm6JaLyVFR7tBnATwUG9KI
	BUS5u0eiIxoH0OgD6phx8sGIw12QNbbEF8gPS6M899aYSVB9GqsoOK8DH/bwvAevP3glB6cJ7kY
	Ag+vFIjXC20syi6HKJpZY9gnTz/DJvU45BIlLHfjQfdnqx22aPGK8AWtmJFVyikSAX/fsPhHylK
	NGoDbBEB+B1Ybls2koYhkSeiPQqC28J++RLQyIOYOo3PHVAxwflE9R3Uyuh7mLhgU2utG6WjVcy
	QvyWHKh3c=
X-Received: by 2002:a17:903:40cf:b0:2b0:673a:7c90 with SMTP id d9443c01a7336-2b2d5a1c860mr108068335ad.28.1776018716332;
        Sun, 12 Apr 2026 11:31:56 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dde346sm87221595ad.29.2026.04.12.11.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 11:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 14:31:53 -0400
Message-Id: <DHRE39NPZMKX.TFKDU78DU6MO@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v7 5/9] selftests/bpf: Add basic libarena
 scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-6-emil@etsalapatis.com>
 <dc6ef7461ae9a8ac98f5cc4913100e5e6079ee2130869dfbe8d1b2181a6705ff@mail.kernel.org>
In-Reply-To: <dc6ef7461ae9a8ac98f5cc4913100e5e6079ee2130869dfbe8d1b2181a6705ff@mail.kernel.org>

On Sun Apr 12, 2026 at 2:28 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b=
/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> new file mode 100644
>> index 000000000000..c692e20ea7b1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>
> [ ... ]
>
>> +#include "../libarena.skel.h"
>> +typedef struct libarena selftest;
>> +#define selftest__open libarena__open
>> +#define selftest__open_and_load libarena__open_and_load
>> +#define selftest__load libarena__load
>> +#define selftest__attach libarena__attach
>> +#define selftest__destroy libarena__destroy
>
> Alexei raised this in v4 review:
>
>     https://lore.kernel.org/bpf/CAADnVQLCyP+NzO9-332JO+dBe=3DEDEOr+ax+-Zr=
vAqJ9yTNYyEA@mail.gmail.com/
>
> asking about the purpose of these #defines and calling them
> obfuscation. These aliases don't appear to have been removed or
> discussed in subsequent versions.
>
> Would it be simpler to use the libarena skeleton functions directly
> (libarena__open_and_load, libarena__attach, libarena__destroy, etc.)
> and drop the selftest typedef and alias macros?
>

This is resolved, the renaming is useful for patch 7.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/243130=
21445

