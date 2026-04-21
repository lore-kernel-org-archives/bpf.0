Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B6222582
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795331; cv=pass; b=LZINMPDDbg2qiiwoE1sUCBsbdBPaVXNSlzIcrxPhhHHvloaGyo747CUKNuY2QVsSdHts36FJml/cey+l3IOunoQ4mwCXQookqkT3XPQbmV9N+ISomg3GpGVWN4lEmGd2zfpZSDqwDFWr7sLO/qWDw1xThPXnbU7YkDeZ11qbQYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795331; c=relaxed/simple;
	bh=QXuDfxl/Yyb92BVN4lNUtjkUl2s/I+9fGmZ6dNtwLuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1SQYqKW/tN0sQ33JXjUP1uqSb5GJyhiUWcjXsy3TXP8dkRCbjL7epKYk1twbbgGxiNN7PWcTcpZvd0fMy/1LttUzZLJDTXBGhD3ys0ugCsiqrunK1ng4rm2hUxA5SsUZBrnUxuYwahOttJTVYu/gnr2ELSHKUiiU1n3Ny69bA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2xNqE7r; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2xNqE7r"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so3725331f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776795328; cv=none;
        d=google.com; s=arc-20240605;
        b=hKADao2soajK6ooI79LPF3DP73VLHNEtddRKscIeDX/m7sppFNxDKireFJ4KwIFS4/
         waYpgS2FoIXBHwvD2z9hYaBYE6Os8Sr0c/qH5UqOGTiAEgCLuQqLawzepabC5FwBaMT0
         f8CS7nH/ycSahB9tAjcQa/wbMn4rKSnx7XhB15vPmgnzJ+wJxI3M7X4VxROr4RXvVwst
         SzPGkLNjQ6im8ue+czsh5BaJmNSnQmNxcZ/SpoaovRH5ukh+wikRhsLsGh79Hbb7rRM6
         yORSnPI8IArp9J+ZFz5zxbu2ChjsWJWC2q0JiVfX+AHJTYvmlsQhvVlHMrEvohc2sPyU
         aLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TuyWZZB7g2tSRGPTrsD7FH7Sar/vyQ0acCzQnBZeas=;
        fh=bVZKQ0C9zZCVFVT8EGwyYXaHS8v2OVAOOqZR2PKjS4k=;
        b=TxWo5vwderAlNcefaoWw2/pW5HOimQOhfmLzM3k2eT/quUmx/pUaYk0qWs31yIblZu
         Lw8XKQfs0sfGO5Y6w5w+RbKAxG1hcCcsWOE8ullO7/9BYeD08VTGC5omwnqPNN07VN4K
         b6VPd2L4tQ/0/LGJ/nT9TaHlGLqg/Q7jwwOyF0dY6kGpPwPGoZh5W5ycvL9D0QQUvxK5
         sZHlv1HtHbMOV3Cewsbo8GNFVtGhSt5XVONPjtX69OtqwMYX/EGpRB2SVKoBZVpHFDe8
         a3LSK6XbHS/rFIlgKO3G3UpzPpT3EzO6DxLbeKEpVlxxWLnCNbH5Ys6GD2kSvOOE5RqX
         giaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795328; x=1777400128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TuyWZZB7g2tSRGPTrsD7FH7Sar/vyQ0acCzQnBZeas=;
        b=c2xNqE7rOatyMMCH62BEARxuL2ExDx6bFC/HPtn0ExX4ROK48rrdgT6bjK9wJmdZ4A
         rS4p5ifmYyt7a2VJGtZ/oYif4vM6QlXjYlZNRoUawW0U81oxejLSJYcX6zwmqgYcckE+
         3beDnU1pp5C+SjzP98THS9+Q3ShLd2DDMbMFBEzz2O2JO+7ycssi5/0Qd6LDKGr3aeLw
         KHU/0quVHEINx6g9wLguV+tO3hHEWMLR18kPne5zb1KqBz6xcYg91L/sZkMN3T1om0QQ
         Q/bSdNMQHPl8sgiAReHSzMxdxUoWe+ZCJtMXNCLLYNJdlEekMmvzxNiYjVUVfkGaBH/U
         GNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795328; x=1777400128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TuyWZZB7g2tSRGPTrsD7FH7Sar/vyQ0acCzQnBZeas=;
        b=YtwcdLXw+YXhlo1oskjDa6aSNoWrtf/weeCDhhuwqEHTqUqKGWu4iwtwotZpkUfPYr
         YbM4tePgk65mGiQUqBBxgIUOfoHN33bO4m72cyltkPyLxetRPGkYcrzMrwK7G7UujRAu
         aVdDSuVf2bLR/g2Qgz7X6edVx5+I3hTy9lwLIAOj857ophwIeIdcRD0Sff9K+OrrEuax
         MG0uT3D5mJyvxZ+1Ap9iUHBf7Y/rGZi4YxSp8F6qcg7C/vlRXymymYVUNseCPHZg8ZeE
         bK0rpyeMm2lG4s8a4IvE0mulCkbwoL8bZ+n7y7zk7U648kynY0v1ClWlV771AsdMWCtY
         bwyg==
X-Gm-Message-State: AOJu0YzUyUw5i4i2KgSs7zwLHPfkL1echMAc8i4+m8zV3ysmurSm1CZN
	KHRDdgsTvV8N3zmQ4aT01Boetfb1XeXwtR4p99CT5qITiE2IHWD0yfdy7kW/9BshtzWfaf/l+nx
	anfcTSSTE+XwNyt3EFcsCC4xozvP9MGE=
X-Gm-Gg: AeBDievESXtBhXn2bcmKLxe31EiyzMwxUKBjThSHlt0M973RsP2aeSlcExIN4zDrGob
	SVvK/Sl3AQO7BcmKjkW3t41aDlha4ixLh2/mGPcZQrNhp31yoYzkV8nYZadCE1hpB9RVaBoBYvh
	MF8sNcPDx1jwnTnCkoKFFjfOz24eVRXKXGSeu79JkunIKefgEvnI7VOl0UiyVv5b4JKZeC0Qhy2
	f0YyMt1NwYTZ+qgHeQTSIn/YQ1EHpC22v2GeCWxGb0ClnRhEcX6vm9Hsvp9MgaDnNOuW1erMVox
	bpnYGCGWaGvwHuZPmrkfixfMy9pNAJ2zPmEBjhK3dwTAvHW7iPQgniXWNCTKuWsOl360CnlPhUx
	wyi39YPwD6sR7in0255OvnhZ5F9gxA6H+jQ0e
X-Received: by 2002:a05:6000:2dc3:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-43fe3de2bf5mr29179098f8f.21.1776795327735; Tue, 21 Apr 2026
 11:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421175507.2396332-1-jmeng@fb.com>
In-Reply-To: <20260421175507.2396332-1-jmeng@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 11:15:16 -0700
X-Gm-Features: AQROBzCMSPgTSNa9PkH4oI7Ztul2MWtkoUjEwdzMdoqkOJgL_EoX478O0tTgGag
Message-ID: <CAADnVQKB0Z6fSMTQqu3Wd2t4eFrfLNQoQy2vaKNWLDhQw++VCw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf, x86: Granlund-Montgomery optimization
 for 64-bit div/mod by immediate
To: Jie Meng <jmeng@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:55=E2=80=AFAM Jie Meng <jmeng@fb.com> wrote:
>
> Replace slow 64-bit div/idiv instructions (10-20 cycles on latest x86,
> even slower with older models) with fast multiply-and-shift sequences
> (~4-5 cycles) for BPF_K div/mod operations, using the
> Granlund-Montgomery algorithm.
>
> For each 64-bit BPF_ALU64_{DIV,MOD}_K instruction with a non-zero
> immediate divisor, the JIT computes a magic multiplier and shift at
> JIT compile time via choose_multiplier_64(), then emits:
>
>   Unsigned: floor(n/d) =3D mulhi(n, m) >> s
>   Signed:   trunc(n/d) =3D mulhi_signed(n, m) >> s + sign_correction
>
> Both unsigned (mul + wide correction) and signed (imul + add-n
> correction) variants are implemented. Remainder is computed as
> r =3D n - q * d. The optimization targets 64-bit operations only, as
> LLVM already optimizes 32-bit cases at the compiler level.
>
> The change doesn't put much effort in optimizing cases expected to
> be handled by LLVM, such as 32-bit division by an immediate, or
> power-of-2 divisors, which produce correct but suboptimal code sequence
> (still faster than div/idiv). BPF LLVM cannot apply the optimization for
> 64-bit division because it would need an instruction that can do 128-bit
> by 64-bit division (like x86's DIV and IDIV)

Sorry. Adding this to JIT is not an option.
We would rather add i128 support in llvm.

pw-bot: cr
