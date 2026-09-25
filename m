Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6878368941
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302997; cv=none; b=AtUVQXl0A1peLXTeR8DDNb+FKdFb0K9y6ZqM6vahDaCEQuWxzwAoP1IK1lXO7Xed9b1YHMd85Gr0vKs1Rj4gfpKrodLll6XrKG+x/HMtBl8nqs5ZSuuiIZ4uZaBMSYkDDkG4shdThNCc4MmpPXc5yI4CL7SLZZxKnhke6NOXJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302997; c=relaxed/simple;
	bh=vXiV3jy5w3qgVUXsQsxmgz4IfEb5vnFHR8U9u0Wdco4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jZ5HFNAnP3NL8kKM9UtAK+Sv/LdctI0jGuam4Q94O6myMKBv7R/NWRnbV5YMsVa96sQkfNSmtB8aeCy6StpVUNZM4DWLEgIYKEQWy2k+BUq3oHyXgaGDWPxGCqgmBDTrR0c10NialSD6K5flyRuJ0PkWOYC6SYmjEgLDx1ESMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+2CwgoZ; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+2CwgoZ"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887b799104so104704f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790302992; x=1790907792; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f+WONXoagrhEGdtvUED0BFMEGh9z3VNJUJWpE5LwVkc=;
        b=B+2CwgoZiAgy2IV0sF8aYGhFpeoEOvXzYF0JhucT8dN0vap7OMCkVpdiX+7yHkHH2S
         zqkRxW3gK34CbrJEbNZRlbZFI0be9DK2r4S3YMSQpkFG1DXEJH+hy3/qqVKwdLanP4yL
         +LP46nezdAZ5roOqEUtz1pBWpSMg1R3y2x4rGcJ8vnMIHlRlz+KTC/CkMA9zRvX46cyT
         t4DLcWsevd7gy99ivCkGfVe1BwNGa914r9hk9/N7T1ieye2nIp4cnLIDyhkO+kTtd4vV
         2ZQMwSR6ABJU40eFFPCvKln2J9TvjtWo3PlCA5gbd9pvfswx5fLUyLHsYKnJ5oAmRkFu
         Uwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790302992; x=1790907792;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+WONXoagrhEGdtvUED0BFMEGh9z3VNJUJWpE5LwVkc=;
        b=FhQgQ3oiYENPV4Ll4+PDtO9B/ArWYQ6QrY/ooj4RwLVAdphbplnr8UseEDOCp1N7qJ
         pEhq23a3ATTAuba5DkpK3XJ6FKmoqHdnMkrpNmn/axo6k0MeOlLlXvYJphw4CEATQVyb
         DEvuC4KRPi/fIZjax6QVSNzFxrP8jHroehojX3DAjOUVxfNS9Fom18BrLdrOpt6RrWKf
         qCKHMboAhP6sUZxNey9UvF/QPGFC28zQdDbYGySyWZ0Wfl3IB7fVPcWQKn75rT9bfuhF
         rwpuqa8XfvzPiMnzdC7yyiVIgxoCEmKWx7wdBQkMJ/YjM2HmZk+1mMzq61MCuOAtpsuf
         SdKw==
X-Forwarded-Encrypted: i=1; AKwUvBy0syVehN+rhg64XzRSq8eEfUPEqNV4IDddg7K1KlWobvitq1AF4lMrTYtlh/FSZPiFgiU=@vger.kernel.org
X-Gm-Message-State: AFuF++ndOQPQI2XGMGip8Hmd1gZ+FS5HJDpatM/nMIPdstLadK7d9cyZ
	YPTk8vRnSdsW75pLUCbi6omT/NYoJzBo61ds3w2+QQESruyV3eWfA6Gc
X-Gm-Gg: AYBFou1m9xh7cHDIEwzX09YUIZ+VBBl4sIbdTejoYdCDB5dnxttpXktz6Bpv008BUSE
	Zt8mqL1nKRhNRjc3uUpBJ4QZIiHp7BZ1r5mjK8FJVrNy29c4XndCfPpLJNqHqxICTLJ9yp9SJja
	4wQSPafh45JXeYRtKQhEUPN7YapFqSoWJr5tjd8cnv5bXAIc0GRae3W6IK2IMLFKSa+lIlk3QSw
	oOLXR15ao5gV2nflk0Icjbqgix+7JcNytzA++8+Y6QyWm2V9kack+FjtVIJgzCsztucPIfKJ3Ng
	YOEEWCFJQF1UivJZa8KV1K23un9nP5+Q+rACdRgV0Mn3kUwRCvV+oZzVkucvJYwo4bvAahoiCLf
	y3VL71iYm1l3UiWNYv7neoQBM9YBOMoizZk6AFqIuaOhCmKMP9zcj9ewxpgE70/0kqTq0N6pEho
	GDaBBDlOqqiMmyaOIMAIdrSA1JegfRPVYYvEo4REG06B3AKXuKeWXzxRs8U4C3I3HPDbVcws2D/
	6KfQb11ByKhPCN5NBoQ1AoICl3IaF2VuSI5fFbjOAFdpgeMbIjZQJe2xhvwEDeMTyMqfAuDLdaL
	12MQVQjK1CReMB0eH867I8shyYXLB6Uy6G49Eg==
X-Received: by 2002:a05:6000:992:b0:487:8ef:2fcf with SMTP id ffacd0b85a97d-48871759745mr7494860f8f.38.1790302991951;
        Thu, 24 Sep 2026 19:23:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30c43asm3421648f8f.3.2026.09.24.19.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 19:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 04:23:10 +0200
Message-Id: <DLO1FZU14J3C.1SLTCMVTS8DD5@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] bpf: Fix uninit read for non-fetch atomics on
 partially spilled slots
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Hao Sun" <sunhao.th@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924131342.934290-1-sunhao.th@gmail.com>
In-Reply-To: <20260924131342.934290-1-sunhao.th@gmail.com>

On Thu Sep 24, 2026 at 3:13 PM CEST, Hao Sun wrote:
> check_stack_read_fixed_off() skips partial spill checks for non-fetch
> atomics; the following prog can be loaded:
>
> 0: (b7) r1 =3D 1                        ; R1=3D1
> 1: (63) *(u32 *)(r10 -8) =3D r1         ; R1=3D1 R10=3Dfp0 fp-8=3D????1
> 2: (db) lock *(u64 *)(r10 -8) +=3D r1   ; R1=3D1 R10=3Dfp0 fp-8=3Dmmmmmmm=
m
> 3: (79) r0 =3D *(u64 *)(r10 -8)         ; R0=3Dscalar() R10=3Dfp0 fp-8=3D=
mmmmmmmm
> 4: (77) r0 >>=3D 32                     ; R0=3Dscalar(smin=3D0,smax=3Duma=
x=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> 5: (95) exit
>
> When test run:
> 	retval=3D4294967295
>
> Note fp-8 is ????1 at #1, yet it becomes fp-8=3Dmmmmmmmm after the
> non-fetching atomic add at #2; hence the high 32 bits are leaked.
>
> Fix by applying the partial load check; after the patch, the
> prog is rejected:
>
> Verification failed: Memory Safety: Uninitialized stack read
>
> Reason:
>   This rejected read uses 8 bytes at stack offset -8, but byte 4 in that =
range is uninitialized on
>   this path. Programs loaded with CAP_PERFMON can be allowed to read unin=
itialized stack bytes, but
>   this program is being rejected without that allowance.
>
> At:
>   ...
>       0 | (b7) r1 =3D 1
>       1 | (63) *(u32 *)(r10 -8) =3D r1
>   >>> 2 | (db) lock *(u64 *)(r10 -8) +=3D r1
>       3 | (79) r0 =3D *(u64 *)(r10 -8)
>       4 | (77) r0 >>=3D 32
>
> This affects CAP_BPF only.
>
> Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>
> ---

The same root cause is also reachable through check_stack_range_initialized=
().
It takes the spilled register path for every byte of a slot holding a spill=
ed
scalar, without looking at the byte's own slot_type, so a helper or kfunc m=
emory
argument spanning a narrow spill still reads the uninitialized half without
CAP_PERFMON:

  r1 =3D 1;
  *(u32 *)(r10 - 8) =3D r1;
  r1 =3D map_ringbuf ll;
  r2 =3D r10;
  r2 +=3D -8;
  r3 =3D 8;
  r4 =3D 0;
  call bpf_ringbuf_output;

loads with CAP_BPF alone and copies four uninitialized bytes of kernel stac=
k to
user space. The fix is to only take that path when *stype =3D=3D STACK_SPIL=
L, so the
rest of the slot goes through the usual MISC/ZERO/INVALID checks like any o=
ther
slot. Could you add that to v2 with a matching test (same Fixes: tag), sinc=
e
it's the same bug on the helper path?

Locally I tried something like this and it addressed the problem.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 200ec0f71617..9166dccef95a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7481,7 +7481,12 @@ static int check_stack_range_initialized(
                        goto mark;
                }

-               if (bpf_is_spilled_reg(ss) &&
+               /*
+                * Only the bytes marked STACK_SPILL hold the spilled regis=
ter.
+                * The rest of a narrowly spilled slot keeps its previous t=
ype
+                * and must be initialized on its own.
+                */
+               if (*stype =3D=3D STACK_SPILL &&
                    (ss->spilled_ptr.type =3D=3D SCALAR_VALUE ||
                     env->allow_ptr_leaks)) {
                        if (clobber) {

Please also target bpf-next in next revision.

pw-bot: cr
