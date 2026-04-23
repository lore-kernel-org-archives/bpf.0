Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B037702B
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984691; cv=none; b=cDqELwctsD8BIlNQWWu7w2NymCUhwzSdoPE5JeNn7MvD84nEc2g4BrC1uv7tipEsp4dI08uucwWGK5uIANrAyNg1eAPW+/AO48hqfOQneg6aXU2HtxymPSEfeIMyK1WT+ZlVdRVhCrQjv49Kj3cJ/isoaYB6i6HBzS5krgo1ZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984691; c=relaxed/simple;
	bh=e9MfDyXwYaJ/aO4M5Cb9Rn2CBNJ/FcZoKFJvLAZtXmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/hliYNskj0wizIciC6voTrdtaa+S4JgFQ6WBzo6aaGjakTen52UscRB13sPAFaMcQpe0kptyHavWabiCS1Td3avOUWtG+rMLdj404Hh1tjkjPtKjcojIf7Pt7v5fhENDd/3K+/BH3YmwnLZlVKPFU/Pjan6gVQmGslj9l1NkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqanBhxc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqanBhxc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so668571a91.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776984687; x=1777589487; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zRWMw5VSTAJILnLr0n8Ol9m5yWC5GJz5TAzV/Evk7Mg=;
        b=jqanBhxcC5COZ/3bWhA/OBIoC2oIgVu+9ayKpMyDN4jh2r0vHT5ydTMDnSI5StVuAc
         /QW/ArIcGhh59weh9TyU2RuzcxuviN+6OJQ6KyFYw7JgOAXPrbk+md3UpVM954yRPe3U
         q8osuS52muEARW55AcmlJ25gDtEwnwyiy38FSLn0r004LgfVi6/jAUCFslNfggB2UpJe
         JH0ZVBoPKH00BWTHr+vwXwgnDW5c2Ko5jQfntAh089pzKI1IRIx5WeN4L5T5qnTLbpAX
         tDQDsEGFEN24vbJZfuyrrCp6tBghy9TeuSDr/Pd5NEwqPDyWxd/a+s4aWybR1BqszYJQ
         tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984687; x=1777589487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRWMw5VSTAJILnLr0n8Ol9m5yWC5GJz5TAzV/Evk7Mg=;
        b=iJX4/ylcEtTwu4GHgH+LFs/vwW2BCEKsJz+fidefq2Q5W/LegI51MhqbqpEwgmOGmg
         J2QOCDSwf2xwg89AXICuy8ExZpACSPL9fWmkoj7SK5mi1QQ4dcR3BmuoelX5dSPEoHUu
         2OEYWfkKnLzchfzu7Q0Q6Ec/0Q7bozEEZhTO51/11qPbCiht2yMppDtgkM38wEIek/A2
         3voGJRtquipexcAlbzhvqN1J7T4mi+kv9s3FDm+Ape2v4B3aWPKc3usGdzD/Yrlf0uKl
         bOQPrALzvHDnunO3OIImDk/Gjl9iI7xu9Od1t4BJlW6SYPC+HMXaF8OzKy2Y0XpMzoV+
         bgTw==
X-Gm-Message-State: AOJu0YwgcHdhcBXbiCfl/RxgYAP/vMehu030jo6gquNCYAJq5BxMbnz6
	W93LTesKEhVGsIHAT638tiVN8ars6MCqITp8uj6YZVeTsXKvD49lu5zHPk34L8Oj
X-Gm-Gg: AeBDietwcilLMJHFsGqZhIrIdSSAbT/VkgE6vmxg7VEMdIXnnCzeizEOSCORbT92Jlj
	ehlBiKeZ9d4bxc/8mJVPxGHC3e1NjlrU/nDUBdg1ABCI+KQwxJwim0X5/8ci0DLaePK3KB7rsYO
	iBGYI/Ehzy9Fi+rat9FvOtVn/4ago/LORvJqGdUcLD02pmbqQ8LKBnxdXm9dnY6P00C9ndlScPD
	JD3lvOwVjdYaVhKAfe4TRgd5POE69605WxuNGkqNY86zIKQOUDSQIXybtw+cgowuXjCEDd2H/dt
	DdrAE99xtkmuF0wdAaNeaUVTceKx1zDovrTxRDQ7jJ0Z9JPrTU83cVf3jgt4RUUbTZYXPpQq5cu
	WiBUo6t70eZiSgDvloNNyURStiG5xjn+Wc5oNrciQP2kZ6a/PURvv3Y+ema+eJ/Dex+9H1LOKKn
	JLIwLGqWM8e4yoBcd5yojJSf0Rg37J6bpA8Lii4pUii0Ep++rvC7fiDks0y1ctAUg=
X-Received: by 2002:a17:90b:3d0f:b0:35f:b5df:463 with SMTP id 98e67ed59e1d1-36140469b62mr27636560a91.14.1776984687464;
        Thu, 23 Apr 2026 15:51:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410b998fsm21195718a91.13.2026.04.23.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:51:27 -0700 (PDT)
Message-ID: <0c47b0b7ea476647746806c46fded4353be885f7.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: representation and basic
 operations on circular numbers
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Thu, 23 Apr 2026 15:51:24 -0700
In-Reply-To: <20260421171830.3881BC2BCB5@smtp.kernel.org>
References: <20260421-cnums-everywhere-rfc-v1-v1-1-8f8e98537f48@gmail.com>
	 <20260421171830.3881BC2BCB5@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 17:18 +0000, sashiko-bot@kernel.org wrote:

[...]

> > diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> > new file mode 100644
> > index 0000000000000..28dcb79ba6950
> > --- /dev/null
> > +++ b/kernel/bpf/cnum_defs.h
> [ ... ]
> > +#if T =3D=3D 32
> > +#define ut2 u64
> > +#define st2 s64
> > +#define utt u32
> > +#define stt s32
> > +#define EMPTY CNUM32_EMPTY
> > +#elif T =3D=3D 64
> > +#define ut2 unsigned __int128
> > +#define st2 signed __int128
>
> Will the unconditional use of unsigned __int128 and signed __int128 break
> compilation on 32-bit architectures? Since the BPF subsystem and verifier
> are built on 32-bit kernels when CONFIG_BPF_SYSCALL is enabled, this
> might cause widespread build failures.

Forgoing __int128 would require something along the following lines:

  /* *result =3D c*d - a*b, if fits in u32; all operands unsigned */
  static bool check_mul_u32_u32_sub(u32 a, u32 b, u32 c, u32 d, u32 *result=
)
  {
          u64 size =3D (u64)c * d - (u64)a * b;

          if (size > U32_MAX)
                  return false;
          *result =3D size;
          return true;
  }

  /* *result =3D c*d - a*b, if fits in u32; all operands signed */
  static bool check_mul_s32_s32_sub(s32 a, s32 b, s32 c, s32 d, u32 *result=
)
  {
          s64 size =3D (s64)c * d - (s64)a * b;

          if (size > U32_MAX)
                  return false;
          *result =3D size;
          return true;
  }

  /* Return (s128)a * b >> shift */
  static s64 mul_s64_s64_shr(s64 a, s64 b, unsigned int shift)
  {
          return mul_s64_u64_shr(a, abs(b), shift) * (b < 0 ? -1 : 1);
  }

  /* *result =3D c*d - a*b, if fits in u64; all operands unsigned */
  static bool check_mul_u64_u64_sub(u64 a, u64 b, u64 c, u64 d, u64 *result=
)
  {
          u64 cd_hi =3D mul_u64_u64_shr(c, d, 64);
          u64 cd_lo =3D c * d;
          u64 ab_hi =3D mul_u64_u64_shr(a, b, 64);
          u64 ab_lo =3D a * b;
          u64 borrow =3D cd_lo < ab_lo;
          u64 hi =3D cd_hi - ab_hi - borrow;

          if (hi !=3D 0)
                  return false;
          *result =3D cd_lo - ab_lo;
          return true;
  }

  /* *result =3D c*d - a*b, if fits in u64; all operands signed */
  static bool check_mul_s64_s64_sub(s64 a, s64 b, s64 c, s64 d, u64 *result=
)
  {
          s64 cd_hi =3D mul_s64_s64_shr(c, d, 64);
          u64 cd_lo =3D (u64)c * (u64)d;
          s64 ab_hi =3D mul_s64_s64_shr(a, b, 64);
          u64 ab_lo =3D (u64)a * (u64)b;
          u64 borrow =3D cd_lo < ab_lo;
          s64 hi =3D cd_hi - ab_hi - borrow;

          if (hi !=3D 0)
                  return false;
          *result =3D cd_lo - ab_lo;
          return true;
  }

For use in mk_mul_{u,s}. This is on top of the following functions:
- cnum{32,64}_gap
- cnum{32,64}_extend
- cnum{32,64}_bigger
- cnum{32,64}_union
- cnum{32,64}_cut
- cnum{32,64}_mk_mul_{u,s}
- cnum{32,64}_mul_chunk
- cnum{32,64}_mul

Overall +230 lines of non-trivial code.
I did some work to consolidate existing checks in [1], and was unable
to get union, cut and mul_chunk verified for 32-bit and 64-bit domains,
cbmc does not converge to an answer. I'm a bit hesitant regarding
brute-force 8-bit domain verification: there were a few non-trivial
bugs in check_mul because of C implicit cast rules and 8-bit testing
did not reveal them. Looks like a theorem prover is needed indeed.

[1] https://github.com/eddyz87/cnum-verif/tree/consolidated-checks

I tried reinstating the old mul implementation:

  static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
                                  struct bpf_reg_state *src_reg)
  {
          s64 smin =3D reg_smin(dst_reg);
          s64 smax =3D reg_smax(dst_reg);
          u64 umin =3D reg_umin(dst_reg);
          u64 umax =3D reg_umax(dst_reg);
          s64 tmp_prod[4];
 =20
          if (check_mul_overflow(umax, reg_umax(src_reg), &umax) ||
              check_mul_overflow(umin, reg_umin(src_reg), &umin)) {
                  /* Overflow possible, we know nothing */
                  umin =3D 0;
                  umax =3D U64_MAX;
          }
          if (check_mul_overflow(smin, reg_smin(src_reg), &tmp_prod[0]) ||
              check_mul_overflow(smin, reg_smax(src_reg), &tmp_prod[1]) ||
              check_mul_overflow(smax, reg_smin(src_reg), &tmp_prod[2]) ||
              check_mul_overflow(smax, reg_smax(src_reg), &tmp_prod[3])) {
                  /* Overflow possible, we know nothing */
                  smin =3D S64_MIN;
                  smax =3D S64_MAX;
          } else {
                  smin =3D min_array(tmp_prod, 4);
                  smax =3D max_array(tmp_prod, 4);
          }
 =20
          dst_reg->r64 =3D cnum64_intersect(cnum64_from_urange(umin, umax),
                                          cnum64_from_srange(smin, smax));
  }

As it still handles cases like [+-a, +-b] x [+-b, +-d] reasonably well
for bounded a, b, c, d. As a result:
- no tests failed
- no difference in veristat results.

Therefore, for v2 I'll drop cnum{32,64}_mul completely and defer to
the old code (or move it inside cnum_defs.h to avoid code duplication).


[...]
