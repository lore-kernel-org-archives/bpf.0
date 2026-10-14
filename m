Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D223E325
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007490; cv=none; b=bv2JMgDJZ+BV+Zu0lsiBwYNG/O4xmVUkm/kM8fnFWzgm4ae0cai0LAjSaa0QHxAVtuahPcDlHoHUjM9Wo6vy6fxWGAjmhBtc5wmYXBqZSw+TdVO+R5xfMypWloDEpAVdGBpHm/0Hg3DlXVUjk4rKSr/Z3Qk5++/0is0nLu9cus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007490; c=relaxed/simple;
	bh=C4QdF0kfD5I7YkBEnXi8MMrfwuUCiXACZGR7/E2177Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Di3v54m/cHGKa3gOLIahrc3P50JzzUc6bkxTNvwDGLoPC/Wb4y2gNMBSgamy5koaXYTTGVSZ2REScaY/gKfxQIm2dWvcxh9ojLu/MhmnvYGHflDJBFcFEGOMjhbWXp7LPK/pQ2aanTDNPeP6VKT/ooyeWElHoK4Pm+iqlL5skgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vnwsjeH0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vnwsjeH0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd76b1361dso9699665ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792007488; x=1792612288; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hzofueAYnlurj6BhEZgw1n60GJllU6UFAaFK5QM85x4=;
        b=vnwsjeH0ud4Xcj59MsVrDXMvnx9aPp3zwZST2da6sxMyWEJTTHumk3twuFHtadTPZp
         +3gnNTnMbSLRlzGV7t7B3EjlzjyIZOwlth6nD6xmQ7KeSFT4dkSEbZ+4prkrfvqEP/Mb
         x6wdFxhvF4l560eTuxAj0SNJXojKn+5uI+mYY2DD65xPb3REEwO2KhtOWNAueGI+jxU7
         eRe2T7opGKoYHSPWuNhryLrnJsEtVzQDPtNrhf2gdcWRJUFkpIhQ4paLUdaAYsZnGdjV
         +Waz8LdVK0jVFyZfl3RfRXW+MBRe1RsR4vXFPy37DvjU6M/vRghPVXj+qk81514ViQX+
         RXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007488; x=1792612288;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzofueAYnlurj6BhEZgw1n60GJllU6UFAaFK5QM85x4=;
        b=MTzEQvhHfhafA+DSTwFg+bbcquKqplengrG8u7Qx00lxDoeJ1R7iIr6ZDsuzhdmdbz
         EToE8yLQLPa4wBEPioejuGkaWaYaqF0w2R+XBBstmPK04PF/gPtrms0iOywunumCFcuE
         rquaZpukUkoAlyMe6zZV5wllGmptYm13jcRNEE7168os8XcR19wH4zCVWJL12n8fyFKK
         xYAjR1hNGkB7ZBUNQFLkaqS94ilJ+6uOgJPV7wvgFVHBk1KQRJrGNGq6X8zIblTeNLW2
         KKjwMMKcAGZ4iG4k2jWP5ADqpGMQmYpvy5D8Lp4nZQhRIKvRNmO5/kIIYr4arQopJ0zP
         3mCQ==
X-Gm-Message-State: AFq9FYIdpytiRHQ0dfMmzc1FreCjAypQIeCTZdIB8f5MYuDrMna9+6nf
	HLlHHSOKvs0ojpjMTXjDQtY/sA6TJkMGAZocX+snsvF/M3dikGQjqKbUNfFbDBOaSeY=
X-Gm-Gg: AYBFou0yUG5gpI0fyR3tzHHGL9SvjdhkOSKrlSc5lDPat0Hvm4lvm0RZVSC8jgPcCO6
	2P2qph+r0OcJAqLxgKMsbr6fS6nhHIGq/+5IksJOfkEDMWM7JF/+zdSWxLn997dJXRUJGmh7nl0
	JSdl+rKKm1iggUpEgLStPWwxe+eaye+B2P3oakET5vZg1S0Ok2YcJUZUgzIajXp1w5tHpGwVBKN
	pgqgNf3s/zH+eBpesT72PmJWrq+bpxWdvXKPcBRK/bEiiDCsusW90li65dPIO762OZVt1YEJMi6
	r87v0ZI9T9mY0D347q/DXZhsv515m3jpkUeoAsVGDa5qWWfeViaPb4JsJ7SDrLa5mdd2GMtLuiV
	iHsxVwoffHj0VeTmbmZvpZfziZzWg8FdC71hEATkTp94qwVxNo1sm/908lOMX3e2n0/wGhIJjv3
	B3+vEaClC2ZVMEssyZGUEZ0ItGiHviLbjyY48aI0mju+JoqyVEoDR/Zd71cvxKXUbxyvn03zKd9
	EZYwrBUmTzl2Jd/HNSQnisQGmVj
X-Received: by 2002:a17:903:38c4:b0:2dd:c100:4257 with SMTP id d9443c01a7336-2e842f11875mr141177635ad.59.1792007488455;
        Wed, 14 Oct 2026 12:51:28 -0700 (PDT)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e8c9sm72720135ad.23.2026.10.14.12.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 19:51:26 +0000
Message-Id: <DM4TMYJX3BXY.15067Y489FKUR@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Skip libarena when arena
 spin locks are unsupported
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>
In-Reply-To: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>

On Fri Oct 9, 2026 at 1:49 AM UTC, Qiliang Yuan wrote:
> serial_test_libarena runs the test programs of libarena, whose buddy
> allocator serializes its operations with an arena spin lock.
>
> arena_spin_lock() fails with -EOPNOTSUPP on kernels built with more
> than 1024 possible CPUs, as distributions commonly configure them.
> buddy_init() reports that as -EINVAL, and every test then fails at
> arena_buddy_reset.
>
> Patch 1 makes buddy_init() return the error of the lock, patch 2 skips
> the tests when resetting the allocator fails with -EOPNOTSUPP.
>

If new kernels expect more than 1024 CPUs, we should update libarena and
arena_spin_lock() to support them instead of returning EOPNOTSUPP.

pw-bot: cr

> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> Qiliang Yuan (2):
>       selftests/bpf: Return the lock error from buddy_init() of libarena
>       selftests/bpf: Skip libarena on kernels with too many possible CPUs
>
>  tools/testing/selftests/bpf/libarena/src/buddy.bpf.c | 5 +++--
>  tools/testing/selftests/bpf/prog_tests/libarena.c    | 9 +++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> ---
> base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
> change-id: 20261009-selftests-bpf-libarena-nr-cpus-50fc5dd00fe2
>
> Best regards,

