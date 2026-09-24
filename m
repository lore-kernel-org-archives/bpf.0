Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9453D093C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216311; cv=none; b=P5x+Jzwgeb/SrcUXlWjiRT5iGyWpgtsQRExO4qLjqSNCE1WNQfXOl8pOubU8U2H1rwigwyPfOLuEOGZqfgnsg43NYp8hzOlr5fdxVNsiaNDj1/d8h4cHUVSr1MoNSArupWIjJJpEkWhJpDUcANkEO5OOp3/oi5CZYakQ1RIQQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216311; c=relaxed/simple;
	bh=6eqLqdxdZnQfhuRFBuoUOMB3TvRuvwD19HIqai7vaFU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ybi9ZkPmLWl/pAWcXvTYDRr1cpFyKJpyn7+Uo/w+0y4N+ZazwMP/hlwlfi6xpXkRFnRiqH6ZVNVbzKArcG7gI4W8aFGtSzmoqtOxoPjVjtn0GOqdDqgxbxsxZ8gTLUV+c+q+7BejdawTbvFJQRYKs6InYfu/6/x7D4S1uu6JyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBs+OSVH; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBs+OSVH"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso7960005ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216309; x=1790821109; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0znCr+Z0mJneqMTm4htrgffhWJ/mVEoGgq/qNX6FvCM=;
        b=oBs+OSVHxNxb38Msbm3p2G7EgeF+62NFNBxr62TI17gSyV/R+Wf1XwkRmx7vc6PoWe
         qtCpLE9uoxohswbeccWEAaNDL+qV9V/PdU7eJG0Rr1ieCp/UHUD4BiwrISQi3a3LIae4
         1qoEG8hXuN7QWkNEn6gYHxTdgD8oRQceCXyxFV/DdSSARY3R5adU7AAGL5+6Rr1ZCAxn
         K27cD07hU4iYe+xkRepBQ9e6DWGF3Rt/lc1gzOtlcVq4tVzTJ0K3F8jmqPG52xEEBnHV
         guUMTYa9Yi9ChBG/G+Od8v5L5bvq3kdrv/DScBIZ12+pFPy9edu3vILH0IfYyg1vx7lj
         8S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216309; x=1790821109;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0znCr+Z0mJneqMTm4htrgffhWJ/mVEoGgq/qNX6FvCM=;
        b=wS0ORKd2EgJXbiyEVmUrH9IxKuf9GXK5lVQlTL9WiwW8uBNA85v4xUxaFyJ92ZCxj0
         K/ukCTNpTfduFYK/ov/jEWCPhQpgHUyipA5MXhuS9SCI66T82SiagGnDLHYI8PSie70K
         OBgqPdI69oQrLFQ285SgQuIcX4dKumnARnKFEER8kY18TAp4MO54fAOfJywLPPGCQvVS
         9v8ee8gMEO+A6NJdedGv+IcXnngtBlMztfmSe6gGWMqCanvfCvMWscf3PvBSbx9w1E1+
         0CSZEOlmLsCmFhyuDn3BaInCZt9wdwJwipNwWxLhkSHVZ3uGPDg53keATRAHpJXNi8PG
         5NFw==
X-Forwarded-Encrypted: i=1; AKwUvBxhDuNXwHQM0DuHhkwaGhUflU6X9YsCUEKDgLHjtEFxdUr23TGEH7bBtZlFU1SJkVw3pzs=@vger.kernel.org
X-Gm-Message-State: AFuF++nWYuEbssyR7aJfLZ6BUP6hmcvku9acq1gkG5P5gk+v39ZjhgGZ
	j90zHpl2pUTFpRECbX6qVpMOcQx39WnDSKElnXJVwe1JL4uQg5yOr8gl
X-Gm-Gg: AYBFou2ozkJgUg5YDxuErocWm900nIoH+GiI6QU8Sb9PxllRe/M7+PshIv8mW42rVXk
	0lH7DVOZjbPcc7m3oesLGCl/nbHeSsW7qhqn5uLnuhFhAtfpFdG/Wv7FnirlPX2DccCBMj1Cac/
	H3V3McPvQZPM3oDfnzzR0iafrDpc8M1vR4UcQGxPMcUZHhm59sNL58RafqzsGI5lKLnuApLE6P8
	PGleW25WxwWyV4wc61ZqZ0tnnWPx2OXLnWLG0jjvAsysAIplwTRojXDAiD3cVcJ2QVeltRcr6Au
	ZkbqcudkU9oZ0SMsNvxOMnWMb9xpalprRZVngntbh4NEb93zkY5Zw1BXrYKx2eooEJgmIwCuGJY
	cN0Y+bpEgFQbxl/EEbchQmywtt91ps5Ne4hjsSuJGQrXMQnwa0j3QweytIog90hoaHt4Lw4obeL
	4taF6wsbFn5jPkW7NywPADUuGOOeufaQTFv7rlhWmiHaP0k1Wa85yyoG9riwPOJ/TuJcGKBb9NP
	8cOtq4rLp6RZqzEG6jQB1fCCW9jQ2mlJpAyCEIsfn85o6Ni5+EBmRbQL+w9F/W3O41d7XZMqE1d
	YgE=
X-Received: by 2002:a17:903:1447:b0:2dd:c053:ec6d with SMTP id d9443c01a7336-2df7e11d07fmr8703805ad.32.1790216308788;
        Wed, 23 Sep 2026 19:18:28 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a5157sm19125315ad.14.2026.09.23.19.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:18:28 +0000
Message-Id: <DLN6PUF2FMLF.NU2U8L9V0XWH@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
 <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com> <20260923041124.GB42709@sol>
 <DLMEKP1LHU07.31JTP12GKADU8@gmail.com> <20260923042128.GC42709@sol>
 <DLMFF6THNB1F.260JQGVX0PO8Y@gmail.com> <20260923050134.GE42709@sol>
In-Reply-To: <20260923050134.GE42709@sol>

On Wed Sep 23, 2026 at 5:01 AM UTC, Eric Biggers wrote:
>
> Module code can only be called directly by module code, not built-in
> code.  So CONFIG_CRYPTO_LIB_AES=3Dm && CONFIG_BPF_CRYPTO=3Dy cannot work;
> you'd get a linker error.  For a module to offer these kfuncs they would
> either need to be their own module (e.g. bpf_crypto.ko), or else merged
> into the module of the underlying functions (libaes.ko, though again, in
> practice libaes is usually built-in anyway for other reasons).

ok. I feel it's better to go back to v1 approach:
select CRYPTO_LIB_AES_CBC
select CRYPTO_LIB_AES_ECB
with no prompt.
That will keep kfuncs on every BPF_SYSCALL kernel without a bpf_crypto.ko
and without moving the kfuncs into libaes.

Another alternative is:
depends on CRYPTO_LIB_AES=3Dy && CRYPTO_LIB_AES_CBC && CRYPTO_LIB_AES_ECB
but select is imo better.

