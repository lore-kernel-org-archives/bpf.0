Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4470818
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775359608; cv=pass; b=ZN2f8iGo/XpS+IyyqC0n0QWBU6R4mzAK8rKjSREY241V5V0XImvItNjizxo/rvgpZYApvFRfhCb8ycmmuGKuGhi5Q1hqh0ozI99NCfq6Wlsbjv577TcQnV9+Fv3fX9j5ls/jk/8hoO1uPztjEobzaaQbkfE7T9zh/O9x8LJNx8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775359608; c=relaxed/simple;
	bh=l0VNa/jUABUpH/iP5ov/d1pqngwPkpajPPFwO/93Ydg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/iOwB/HHcWEPPOZc0ezt++ndhELFkwb+Z/75l0klNhMySKQLP7dPsiADpmTM0EwRaMlSzBX81NBcv0sGeMMWRWuDyhDi2DU4Z4IGshELvv8qur4yFldPGNdY73i8Da1g+7zWssvOtyYA0h7UI2Jo+/rdkGx1GokZ7c8MGYBAj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYwqnnvW; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYwqnnvW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so29271085e9.1
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 20:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775359605; cv=none;
        d=google.com; s=arc-20240605;
        b=HMoc8/tVZ7fCla73vnoz56umRXUy1n5X/stiMguqrVvDKgr5PtpREFwUFo7O8hmC/b
         sPr+GWg/w7SmTPW2lhp8xs5lW6wjcO8+OgsNQQMxVqXBvLRfZS1eUriXSORsp7hjaH0q
         OgIdVUQm5k4hTc41M+8Y8DIrODefBuYVEEIWdqx+1iuB3+lJUcwXdJQXySzULgWkVOKA
         DtwsjYJvhnbog2eDyl9Lm5RaZ4Ff4QNfmoQ5Op3C4SgaxPOifREP7Cgd5OwsElk0dfU9
         SduiEqX8C5wKNi7hJGjjCY6pFsVwHE2HdM1o7YUsii8Fy7OTFcblpSzOS21fA6AduaTG
         bBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5rQPljKAZXHOjzBIzOIZaguT5GkHm8NvsJhaAll3WtU=;
        fh=z+FAd+xZOmF57zxNNieIFDPVu/tkmh0wVB0LomYnje8=;
        b=KV+Xt1+7gXhP9Z/t3/TKuhtIfpGpnqO/Ey9tlUKpsz+VJM3pjWL12CFs9I/h2Zy49X
         bVFwj63aBOUiTC8IN/V6pz/xAiR+365gawIqQxbMr4O7ybmBGubbVoyfWz+zcOL0fTuU
         NjI7feIPIHAIXWiGTcyn0SzkWcGYPvgG/8xVyghfIP8w59fKnjyF4aSgZP4p0RM8Z1sr
         6B7HOUf/UY4ggWBJYdLrAys+H12z5Ux52m3dtiNewLfrgzrzKzAEmeyrpomKp1FpPczC
         /uKR5WdUpXC+B/mNtR9Xc/nbyV1i+TEjq3vZLXZJjCrl6CDCeWBk6QMG1J7Cdcg+tdPl
         bohA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775359605; x=1775964405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rQPljKAZXHOjzBIzOIZaguT5GkHm8NvsJhaAll3WtU=;
        b=JYwqnnvWTpz3R/KBhwqXBwMz6RwwtOiDXfUVApl4hEMRRxDv2D9SZF3Mp0UocuGsxr
         N/bXB+SHr2Bi3r4xX9a/aIywnDw4nFCEgZzUDZPV2zSKZUN50cVWuyQ+Ete2znusJmZp
         MPaJAHscGlWW4I2OjGwpzGbYeUrgJdPl7CsCBh7xqCuST8LXOlB6H6LxctqjkM9jlB8H
         qDSrE7p3eDMesKP91c+eAv3dsEqQSPBHLKzWVdmKzb3oywZoET7yoOMVPS7RePO68hOW
         Io0nPHmALVD6BmUcVDCm29Z6TvDmr/98jyOy1qcDRMuB22Zz6RxVHXaQ4WFvbYzJ8Tp5
         NaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775359605; x=1775964405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rQPljKAZXHOjzBIzOIZaguT5GkHm8NvsJhaAll3WtU=;
        b=NBrIXptcePSqjUdRMQHat5hiXsjE0mKsugR/VxqT+k0/UylaflewKQuQacPAX6dMN3
         W37GwaiMcvT1RNJRR7RnuonaO+9h0pkvHnxt72ECMP3bf2W4BbIHd7DVAzHBEHEQjPbQ
         tf1zGU2kISOAuopdFdtw7AQsLgEzbHAmT9qGX+3yGhpLfXbdf7vAMDHnTRC6E7kAWfa8
         iWv3Pvjjr4Th67ZwbGyd+SrPJ/IqYMzFEeMUNEtzOz0NDenmoD0ZkoaSKD3FdcWWE2lA
         0yljFWSnfZp9G1YoaIGY7dVJIRRmD15LxUTA8RjTxTtHCbzrHkmR+uZF1Qbdvl1vR0+n
         0u2A==
X-Gm-Message-State: AOJu0YymAxif8dAnyNzYnngzl3xhfAOLhIdK7zNM6CeruQ+PxjvbU7iy
	AfbjzEf81QbB5HHiGNosIkvvl1iNXrlWM6KAZUFi74DCoR9+ISK48/5XC4wQF2emdoEfkdOanpe
	UbCsGL+78+FZzbKsSmMEP+eSjIUqunsU=
X-Gm-Gg: AeBDieuCr8pkBGitmEugSzeA1jwIPyYdLdYom9l/+2LTYklKCwU5Y5MLRNCwk3yb1mD
	CCSu/RLKGud6044cWQ96JHpHKmkr8Fd8dIZ6bDABwffz4PaZGU5VfJ+3iGQjtBbU550BpSuyjeR
	nlt6Sfub/ix1/CO4OHmGy3fjAWX2ehz1VHWFCSVjNfsoaRzLMTKTiCRTPaojzg2eos4Uns/Q72m
	ZofTKxajH8ac0gUpepLrwrg6Gb6DZ8gDrlBZTsVe+mgMkg5iKUhEgbM/ns/70t+5cwsJzfq9uK2
	B7GV/6Fw545I4HbiqdeU45W29Ci7nsQSuu5QD0NYY9pJxdOabiTIb2C6KZFP+GxQplTnC+/De2+
	SyKOSrHyzFfBBx0UpdFStswxS6Jz9QxNPIc8g
X-Received: by 2002:a05:600c:3546:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-488996da17bmr116006465e9.1.1775359605234; Sat, 04 Apr 2026
 20:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403164040.73269-1-vineet.gupta@linux.dev> <20260403164040.73269-2-vineet.gupta@linux.dev>
In-Reply-To: <20260403164040.73269-2-vineet.gupta@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Apr 2026 20:26:34 -0700
X-Gm-Features: AQROBzDL6uF883IeUDAu7nBpy-pMmr_lcqOftKFYBdZ7cI9cHn6ooMSXSB5323I
Message-ID: <CAADnVQJMjXotSxAFMkocEGp==+usqZ7Z2Q35anMn4g=oopnb-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf, doc: Clarify Pseudo-C notation and w vs r
 register usage
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, bpf@gcc.gnu.org, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:41=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.dev=
> wrote:
>
> As a newcomer to BPF ecosystem I was confused with Pseudo-C being the
> actual assembly. And while it's obvious now that w and r forms represent
> 32-bit and 64-bit regs respectively, it's better to call this out in
> documentation explicitly and make it more newbie-proof.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> No changes since v2
> ---
>  .../bpf/standardization/instruction-set.rst        | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 39c74611752b..96181565906f 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -315,13 +315,21 @@ For arithmetic and jump instructions (``ALU``, ``AL=
U64``, ``JMP`` and
>  Arithmetic instructions
>  -----------------------
>
> -``ALU`` uses 32-bit wide operands while ``ALU64`` uses 64-bit wide opera=
nds for
> -otherwise identical operations. ``ALU64`` instructions belong to the
> +``ALU`` uses 32-bit wide operands ('w' registers in assembly) while
> +``ALU64`` uses 64-bit wide operands ('r' registers) for otherwise
> +identical operations. ``ALU64`` instructions belong to the
>  base64 conformance group unless noted otherwise.
> -The 'code' field encodes the operation as below, where 'src' refers to t=
he
> +The 'code' field encodes the operation as below, where 'src' refers to
>  the source operand and 'dst' refers to the value of the destination
>  register.

This is fine.

>
> +.. note:: BPF ISA is unique as it uses "Pseudo-C" notation for the assem=
bly
> +          instructions. In the table below, the column "name" specifies =
the
> +          encoding names. Assembly instructions (as generated by compile=
rs)
> +          are specified in the description column for some cases. Descri=
ption
> +          of ``DIV/SDIV``, ``MOD/SMOD`` includes additional semantic log=
ic,
> +          not actual assembly.

but I don't understand the point of this paragraph.
It reads quite subjective and doesn't really explain anything.
With or without it the document is still the same.
