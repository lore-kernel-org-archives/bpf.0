Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F3599A28
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158281; cv=none; b=iQzBNwBzMtz/VHIELVLZXz8GgxeR1c0wMxwwSqBulEXvYdXMeImf5WRQK8qKT8FZ92FSq9lqaLTNqTk2cZTgaIG/nvHs5pLLBx8cagPTgZZAWXxkRuKz59x2TdR/te3rIvWb0Q5JPGQhWXJxcEfkfi7NqSb91YdPhUD/2XrUMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158281; c=relaxed/simple;
	bh=opXDhzhWx3YuSpYKdsgNd3wA8vkj4Z2GqyoqGFGWi1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wr3ADhWqUMaT8sJIOAFsUPX6Z4fLHCpfwBv5YTIF4Xqb3GO6FFe1obpQdde11VYcpbiyzGi5HteeQluLQOg/ZMFCGFSJ4QJjHmASEqlzs7+On+nBxiZOfVoei5mPi1kets8vCDZSSQpo1jkNpIzZ038RQH3y27Xpi2hMj3H5QKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq/FB693; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq/FB693"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1066026a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789158273; x=1789763073; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gyg4bhi0HgrKIi3/MhUwMNUrXcSsaRWq3czyD7XoEJ0=;
        b=Aq/FB693XIjPIhBFes51/Q7azMW4l6RGugBM39OYr5dpNoLxBXzRniN8pcjC+SHPfv
         9V9H1+LZFr3fYoz6qGZodLcSxkCQFxLx7m3GDnopXSmiSuiG9w1Bb5n7tkqLceoogTTv
         z6V2C/5eFdujE/S9oKEmQxDy6FT88CU2k6AiqsL9FVyB1vXs3OluwdixIP+3i62P7zY/
         6z2sfZ+yXDs51Lb6GYFmcIacaUmRoAmVxuZit6UyiMSgAKIPP7sctZGIp7KL9QHL5NV5
         JL5QHAAKhCqYGZNpZrda6+jK0c3fXkSMGyuSeAzvi8BRH/j6M+p43yKsXgdglY5jTQuB
         2cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789158273; x=1789763073;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyg4bhi0HgrKIi3/MhUwMNUrXcSsaRWq3czyD7XoEJ0=;
        b=bJzNyDupZks8U96Og8C7ev0ocIqTYTkgI6xoUdz/iQhs0Bjmeajxeh+s6f34Gojs9o
         CqGkE9tBOR+HWLNF/BM30rfwX2Kt8rEkZVvHGJ2k6sdoU8/Xsrmr7uDIv5j+bd0UOGMm
         q0l3oG8pHal/wubscaJa/jkkho/3llUVjH0KQD5HsLvZ3j1g6HGEv1aSpByTqaoy+PD2
         DQqi37gH7oAv3Iae+45r5+XReb7zX9EDIMRjhPQ/Dryt4vXB14zcwX2tPPsHLOomIYMr
         8i+CQtR8Is/iAQ8T0FMpdGWSbfxPtSpuEY+VlMlDdZw3spqGHsRyVKob/iGoLwhgJ8tJ
         Ozlw==
X-Forwarded-Encrypted: i=1; AKwUvBxmRj2bDvkDhul5dS8Sa7jM3L9b5sMPiv6OLGiZW4Oc+IiB4TV1EMIuI/OxUSBID0mlwWk=@vger.kernel.org
X-Gm-Message-State: AFuF++kf41BtJGTNTqUqViwhqpyB9n4YLm0IVCJjcBt1eSUiMmJJHcPB
	M5ksID17Y2P+g30rHbAl5d8JsMaNLLzT2ZBzaypSv/JloZ3CNvcgIi3E
X-Gm-Gg: AYBFou1wzyCpMcEKKn+GloZqzutBjRggpCt0HE3OxKQIN790JZpNoDcCV7QpFpwD7Yg
	u6BFHOs6jKoxTTAkq+/+PtQSaYbilhi1NLO3qZOXOgl0DaJZbs+0+e4oN38SkR0zrKj7OxYGDpA
	ECX6IWobjT5e99gPKnQxoDN8RV5pPxmIURETh37cGXInbUsi5m02alVJz6sGEe2Jbq4JWa+nNT9
	VjzWr4oq7q6o0vffTnofDiqvgi578Fl2KvyvPo0JBzATMRcWRSJDAu9/nOUE7bKdfajyvcw93rn
	x3W7cVKiF7MbFCqI9uoYXjTsXqKOXi7n0G8kDoyXaQS91Q1ud1Pq7/pYsz0PGV7TzXA2qXwpFCQ
	DkbzOo+nN54Itatdh7/RUl6MeGrkaHKkOIOCmuTMUIr1WVDwtH83v1dF3mJmHLybJH3xDc4tMOy
	a2GT5SjjLiH/ST5OKfnCCChq54poPmMpSP9JUePTzPIqX9UufLzdXcpSMlva30eKgONzpL4ys7S
	oHulHDN56hJtVk1vqVzuVJQKfpKdElpo1rb0rZ61DzQzCFXt5UYjhuPvw==
X-Received: by 2002:a05:6a21:113:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3daed31b875mr11656343637.17.1789158272624;
        Fri, 11 Sep 2026 13:24:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c52f:3686:673c:704a? ([2620:10d:c090:500::4:b9a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm8706794eec.22.2026.09.11.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:24:32 -0700 (PDT)
Message-ID: <c2235ade283e0258e7ab018bafcc99b32a63f586.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Tolerate libarena skeleton
 failures under BPF_STRICT_BUILD=0
From: Eduard Zingerman <eddyz87@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "Ricardo B ." =?ISO-8859-1?Q?Marli=E8re?=	
 <rbm@suse.com>, Emil Tsalapatis <emil@etsalapatis.com>, Mykola Lysenko	
 <nickolay.lysenko@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 13:24:30 -0700
In-Reply-To: <20260911141621.1944900-1-sammiee5311@gmail.com>
References: <20260911141621.1944900-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-11 at 23:16 +0900, HyeongJun An wrote:
> The Makefile documents BPF_STRICT_BUILD=3D0 as tolerating any BPF object,
> skeleton, test object or benchmark failure so that the remaining tests
> still build.  Every skeleton rule honours that through
> $(if $(PERMISSIVE),...), except the three that build the libarena
> skeletons.  Those invoke a sub-make with no guard, so a libarena failure
> is fatal even in permissive mode.
>=20
> With a libarena source that fails to compile, BPF_STRICT_BUILD=3D0 stops =
at
>=20
>   make: *** [libarena/libarena.skel.h] Error 2
>=20
> while an ordinary program failing the same way prints SKIP-BPF and the
> build carries on.
>=20
> Guard the three sub-makes the way the other skeleton rules are guarded.
> The build then prints SKIP-SKEL and continues, and test_progs,
> test_progs-no_alu32, test_progs-cpuv4 and bench all link.  Nothing
> downstream needs a change, because the missing skeleton drops out through
> the existing permissive paths and libarena.test.o is reported as
> SKIP-TEST.  The default BPF_STRICT_BUILD=3D1 still fails on the same inpu=
t.
>=20
> Fixes: a6850fa388f6 ("selftests/bpf: Add BPF_STRICT_BUILD toggle")
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> Assisted-by: Claude:claude-opus-5
> ---

Why is this change necessary?
The whole PERMISSIVE thing is quite ugly and I regret not being
involved in it's review.

...
