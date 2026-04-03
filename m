Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E3D6CD6
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247866; cv=pass; b=ERBKuFRuY9b6dKS/f86J8i0u2ja+2AeTP6nM/CVd3rS3QICkfrtC15S0dl0HW3ovcvexrImDOgjf1FO9Ovgf3U64sSYbxSv+FpQtutgFaKZim/mcJIeAqVbeN2MD4uNGvAQAg1ZuVIHQL3PUmmFuDDyVHL8IvmHjAXS/lbBpSh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247866; c=relaxed/simple;
	bh=V92ZPqJqDBQ0xnSLIPNpZMASHfh7wbWG0dd90teR75Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df+UkFRAR+6oNHmphH9lwO08sz1ns4YF42SbhE2yBpy28CHQ0/+j+nJcFjKnB79Xm8sKC77hRaHbBt1DcN90uZqixH44brhwP+FDVaWcVTElFiV15Ve5k2KEXY1BGEes45OpPW5wvIb3cAmMwq8iDhrfyR5BFVQKfAY9dy0RG/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSFQxEke; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSFQxEke"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4888375f735so19222685e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 13:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775247863; cv=none;
        d=google.com; s=arc-20240605;
        b=Q7OW/SCRFsN8mu8cXGu0d1sijKeP6XecSQrGu6qiSnYCuRd7Gg3A/TimsneFX0SmS8
         SXLoLVsxWtXWX+sfeyVNeSFvzgGMxriOIuV7Yv54ns3uiOR2uOyAvA36FcJ/PbsMmzvz
         3NTg2M41bBy76awXuI7H7ggfK4+kpaRMnZi3d00VDgh2oxoxNkTKg/Cbh6d+EkCf2rGa
         7fHi5CN+6MLn9QgbQmFijEB9YdARzX7ag7YbisGHFSvOZUADcHBF4bJB3B0PWXJF4Kf6
         5vCj7nLGvShF/iMs0Agj11ozBVjUo3MRmlTPrCD9bLG2N8MSkNRh0gs0IE1Fz9ke56Qz
         Dabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNndhLRlT2gK63B0m2RN/EiNuTYsbegko2TS2FDDyjU=;
        fh=5K7LlmBDhJRYJ+zNVkHjN8Qzx0sx61+mt+UfNHVnWCo=;
        b=d6b+jcZ3gLChD+msjOUNvZr7BFc2C5UeEh3FvGlAVTmPqXcUYKDHX/REu9zB9qaXH1
         1/Mp46KtZMN5U5Isgd8ObQ/iQLyDrDyxvxFiZDQSCNQ2lA2Oz0DXeOuxeS7kFl6fP1fD
         kYKUCrWki5HkczLSUe3k7O4aI8ejbVJy9dazJLw/nA2ae9V533p5UJmr/Yp99pPzdO2s
         bhQ0BnPWOPKaf3qtNI6rM+OHbKSC3RDva+KHaNaByuGR0WswVVVeYU/swLqf0cnX51g5
         6aBnhNUwBfo0fKI4ADA3VLyTlv1f0+ghLlGZ2afl8rPFw0HRAd3fad8cGJdTx06sfkMX
         /QMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775247863; x=1775852663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNndhLRlT2gK63B0m2RN/EiNuTYsbegko2TS2FDDyjU=;
        b=pSFQxEkeanU2YN40KjQjL5W1Di9BRaqG5tyXm6/793yX2lJ78TByd7nvvEDx2fhzNp
         mYXAMr1Z/qObwG2/7YrXPJKmkWklFDP9DKfgnepO35uQ1tnKdpUm6PuH1bGcQQJGjsga
         uST2jNNcdSDJCf6yDKqU5OmvkJu011W24eg03Be2lhuP9gH2dAsJqppPx2XecIDyNxd4
         oazvMfcOGFGRWd27BMZ0+WT7wR1dhs8aDXssrlUUwAB8swaChQIht6Tba6G9PRhYRgWL
         Rpru9n3tvcUaI0gjqBDCfXLgekusIcehZGnRaOdjMTZ0zDSns0+ssiXNn0rclrUQWTp8
         xkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247863; x=1775852663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dNndhLRlT2gK63B0m2RN/EiNuTYsbegko2TS2FDDyjU=;
        b=gGU1y8uRv6KnOlZOVLJeIlUm8W0iFFdKkoAJyIL3xDdGWuVdEcABcx1IKqlF9rpD2U
         6vw98rXIvBe4YLIG0P48ijPS9pOMeqgtT88J5NdOQG0hdd4L66CvnmxH12SEYsWfM8gJ
         6dIsfJ27ktu+xW9VjLPqagaCBDv14gG3tRJ2n0v8K4/DOZEI4gEkRvN+OYRznxDUaena
         IpiWr79gAALZEvHPJLLm39PB4cD4yMjfheLGuvowV3JHtSRdV5G1v+9wN2q4+B8Md8W9
         /02BsBUGePTGZjcrAbCG5FtVQ772kywppPSPrCi+X0F8vVTEeBa8CsXPUwR9CHHFoGU4
         KJoQ==
X-Gm-Message-State: AOJu0Yx4pjR+3QMQQA6kVIJQqcjQGNLtiMqPPileikdA5ZCMy3IJM84B
	fbAI0tKoB4qRa++NELGgXpnk0o73bKKQpmCvCGOWHmiIBJ5/xXJHejJkBBlQo9As723lYQdsqlW
	cn+PMoSbxvnGGECnw1r0sW/Jp3s8wpng=
X-Gm-Gg: ATEYQzzX0oFpMitLfUn9vEgQmchgnJDLjOUXOgtQgU6nahPFiP/J7z80V0N52onQi2K
	wdje0jPmiWNTFQ1lGYa7ghBsxHjDanDY2uTC+Uh4XCmPmZYHiQrmb+NqYAZeUm7PzWdONn1xNbO
	wgL7GKHBtSwqX3TLp6e3n056gOBKSenUFjirjD2sNyvkqrkmsPVDKgslFGsQMAN/APT2ltmErMB
	8jDIDRl+cgAaO/fj9JOSQVhi/OjTwLh+ueM4MHsQ8LOukmmdffBDfaUNTwydDnBMF4T6FhserDy
	wJMkBy6iJ4O2oEH8ntsJVZZzx2g/PbjQx4riETaD6quZcIMIvD8JjYOg2CXbi2bwN/faTo2usiX
	sm86CKiiKOnIxCg0lqWio4PdeybyGPB/mdd4n
X-Received: by 2002:a05:600c:4ecd:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-488996e0c5emr69159575e9.1.1775247862665; Fri, 03 Apr 2026
 13:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-2-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 13:24:11 -0700
X-Gm-Features: AQROBzDoFaT-QUOkZ_NizdC5FU_fqKTWjr4fO-OLT3kTLBKVo96ZXpICwcWxaNI
Message-ID: <CAADnVQ+3WG0ed8Redsn0wbZ+kwHYH-pz2G9bmzVH5MRX-kp02g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:27=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
> addition into the scalar register rather than the pointer register.
> Handle this case by upgrading the destination scalar register to
> PTR_TO_ARENA, matching the existing handling when the destination is
> already PTR_TO_ARENA.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..583121b9aa7e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16333,6 +16333,24 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>                                         bpf_alu_string[opcode >> 4]);
>                                 return -EACCES;
>                         } else {
> +                               /*
> +                                * The compiler sometimes stores the resu=
lt of
> +                                * PTR_TO_ARENA + SCALAR addition to the =
scalar
> +                                * register. Upgrade it to a PTR_TO_ARENA=
.
> +                                */
> +                               if (src_reg->type =3D=3D PTR_TO_ARENA && =
opcode =3D=3D BPF_ADD) {

This is too specific and doesn't fully address the issue.
How about something like this:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84699a428077..457ac555da72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16572,11 +16572,16 @@ static int adjust_reg_min_max_vals(struct
bpf_verifier_env *env,
        int err;

        dst_reg =3D &regs[insn->dst_reg];
-       src_reg =3D NULL;
+       if (BPF_SRC(insn->code) =3D=3D BPF_X)
+               src_reg =3D &regs[insn->src_reg];
+       else
+               src_reg =3D NULL;

-       if (dst_reg->type =3D=3D PTR_TO_ARENA) {
+       if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->type
=3D=3D PTR_TO_ARENA)) {
                struct bpf_insn_aux_data *aux =3D cur_aux(env);

+               if (dst_reg->type !=3D PTR_TO_ARENA)
+                       *dst_reg =3D *src_reg;
                if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
                        /*
                         * 32-bit operations zero upper bits automatically.
@@ -16592,7 +16597,6 @@ static int adjust_reg_min_max_vals(struct
bpf_verifier_env *env,
                ptr_reg =3D dst_reg;

        if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-               src_reg =3D &regs[insn->src_reg];
                if (src_reg->type !=3D SCALAR_VALUE) {
                        if (dst_reg->type !=3D SCALAR_VALUE) {
                                /* Combining two pointers by any ALU op yie=
lds
