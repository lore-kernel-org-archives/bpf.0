Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D019E96D
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174392; cv=pass; b=bnrK0lv+poWAgXDAzZVzBug855JdXRBmr49H303ZW84U02i9bar63TEkqtSVl47NvppMtONHGjqjHkWt1D8IdWezhFKJQ4odUE2uhOIC+HtQ+0gKN+xusdrqa0rykB9IoyqKpvfzAf5jx2VPtV3yJ87Yb61ziWGr7k27hCYPu30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174392; c=relaxed/simple;
	bh=CQQ5uxI5LJywT10nnwzEUlbjvcuF9cqEPowouB9NJYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGdvfhj02Aljm7uMUOvuQWUaaoYB6X3LeEY3W0uoKLuxpWUNjrt9NjJekihzxWl7zq9VA8tT4MNYhN3ao630ETzhG2o7WKhZtAmx1Hf4Qy03rOouFu5XdVPdvAeYardIBugM5qy5BD75XxCRSdpUWioPb3mGD2mMR9znU8gfqKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6nXHCLg; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6nXHCLg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so207511566b.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789174389; cv=none;
        d=google.com; s=arc-20260327;
        b=mAn2YMdtImhrr7RLbPM8POdpdlfoeTs0i9nAg0DQVMTnnMbyIRI2UcCg0rTPVp9Ye2
         45Jfk3l9EzyP9u4Zkrw9ifi4B0k+lnAiB+NlQi9POzAcwR9UWmlTcFrivZ5V7jEzD3EV
         Ny2SlcCFjbxFH1+WtQdkAhHvJpE0wRRowYkNlc/kMuwVmA2c582NTZEt4U4fioYlOxUt
         Z9ZykD1+HP0W94KLkMkovjptAquLD8tVEd5nWiI5/mLru1HdUR3/zGTGu/WaalvVZnKc
         FaWDXShy5OBIeHgU9ZFKGaazCr6NiFtROljEc+AviW7NtiylTwic8OzEramQK26STR+u
         EFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CQQ5uxI5LJywT10nnwzEUlbjvcuF9cqEPowouB9NJYM=;
        fh=NjdiLFujb1zExMY585h6FjhiNWMLm+Mg6Cg/ZK47Hf8=;
        b=KlPLmBPu87f6fNMhN8NvCVUrY6gNWxp4xrOWTvFhd0Sv4spEymtBKzcjwlIPuBRjQ5
         mTadRKo2kOdj5x9IZtW0wsO+2BWuQrlQoY4AZ7Ruhb9JuanXMiKPa5h+Bke4C7phfxi6
         yM81LfnbAjntIBHCD7dKXjaKZfJ3Qx/xgEO3TD7nlcX9G4TQcNZE63vHPMiik//SUXJT
         9GhYCHCNvtDLLInYw7dSJQRf4fLv7RfbBQxgqsD3AKAV/vFqxSWK54VSdzNexWwJHdKz
         ePjgDM4QfRZWGvzucdbD46/EmRmVfcz4qR75dvcn/Q1XceRldrcqa/eagHLoQHJDtBEf
         mW5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789174389; x=1789779189; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQQ5uxI5LJywT10nnwzEUlbjvcuF9cqEPowouB9NJYM=;
        b=M6nXHCLgKnJz4RWXriSUPlzYrFaCIph0CapgEoDCVGumdGLXCy9dHgs5YIpz74mfrg
         b+yNKGpNJgLcRRtb8vi2BC215CfpFuabnyscg/ZCKSw1subIrni867Q56obS505FXtyO
         yXU/+XqdNsqHNL38TCFRE55ZF4DCGaLHPPBx2E2zKYInrcfNywFh1EBu4axQ32QmgTF8
         8gCJRwnwS2Qt/Pud4RFTXgZzCC7nF+EoJEXXA2TApZy0MCE0TfnJm87VbZo2fysfA7IV
         BZ3pjLWYGxHc727jFJRM3UC2twiFfjTaszCR35Gw4CHV05K+tlL9UQutozGzEFuWHhJf
         kA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174389; x=1789779189;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CQQ5uxI5LJywT10nnwzEUlbjvcuF9cqEPowouB9NJYM=;
        b=pGgR18oe0hlqCIwAOvWHJldXYmlo8+KvLSio+gC/QE4jJoetSnvkVndLQnZs+CFkRK
         pxgB8VDRlK5CVsCuOYBHjFIVzxlAps9cw/0bJX+fOAR34i8nRIRZ5ZwdVfgjxBQxLvuR
         rg3AD/ldPUGOpJeCtMabEhQaam94QYAyr5j520k9XhwEluP1gtZbfgtaSzMujgtGXFL+
         Ns9XXpiJn4O7C2oqSOdX/hPZfjysSn4A2Hw10X8zVMhBtyr7p4sVZStOCG3qgEmMGqXG
         GqTaREqEhyZKLe54S5bOIrOFIXB2LPf54e4dwXG8aYnJA9VG2hdW4SfCvn4lIxrKIRwU
         HX4A==
X-Forwarded-Encrypted: i=1; AKwUvBxz3cC2mhR1VfgNOBLvG5uOam18aZjfWmMKT9zU+19cNnOHpndKWfZoctQvhRLc3NZMfO0=@vger.kernel.org
X-Gm-Message-State: AFuF++kNTveC8ieSwECTVNqTNjgCnqG/NJzMXXUliBvYc6e8OnGAYmVd
	hnOfmsOqurgiCLx8At2v+E+wpd4pghEcAI6C3l5IJrUBbdUOQiunWJiXmqdSZjuNWTxYdqogoIT
	A0Mbr9yu7i3r2f87Wb0SvTlrY+wdK71o=
X-Gm-Gg: AYBFou3++6P+oyL3bCOf1t+K12xjjQoc8aNercQIvJDfdR3yj3VWuMYGoXHVhyimOiW
	rFe8nbj3ExchB8qix/5gdsSO3V01BvpuoFc8/WmX0Iju2NdZ06azcOicHBikh8J0T7VqXvqZxDz
	YrdC74EQ9ErJAzSF6njsIpoBU1J/uxa9p60Ouj00xJDccWFj8qXS1HISDn/SqX8VCRCsccP9Zbu
	ZVTd5gGNY0JDPy92fle36upoE6lziZvo7vrAZMpOQnU+p8THjlMuWj/1b57T/TWp3I4v3MRsvzy
	yKwb5KrKDfi+NAcQxzc7C2OxYFiuy+iXJ4jCKA1B02F6z5Qsr17A/X+sQy3RNwQy
X-Received: by 2002:a17:907:8b91:b0:c28:f9e4:836c with SMTP id
 a640c23a62f3a-c2966746c86mr293173366b.28.1789174388992; Fri, 11 Sep 2026
 17:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911213340.3767930-3-main.kalliope@gmail.com> <c440fa97680eae9966579d51586c2e6b9936bfc3157225269166e1c133515f8c@mail.kernel.org>
In-Reply-To: <c440fa97680eae9966579d51586c2e6b9936bfc3157225269166e1c133515f8c@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 11 Sep 2026 20:52:57 -0400
X-Gm-Features: AcwNN1Ur_WOJSfWbT1nTjTcNVZl3abwhTBIueEcresXiT5wFs3FL9dx_llrHL2k
Message-ID: <CAJZwKkgKjSOsHADdupd8cFdyUXKQeVzNmwLyX0jDorru1p1W7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] MIPS: uasm: Add signed div/mod and
 sign-extension emitters
To: bot+bpf-ci@kernel.org
Cc: tsbogend@alpha.franken.de, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	johan.almbladh@anyfinetworks.com, paulburton@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, philmd@oss.qualcomm.com, 
	martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This isn't a bug, but would it read better to add the SEB and SEH emitters
> together with their first caller in the BPF_MOVSX series?

I grouped the native-MIPS uasm additions for SDIV/SMOD and MOVSX in one
preparatory patch, with instruction selection handled by their respective
JIT changes. MOVSX v3 will declare this series as a dependency. Keeping
SEB/SEH with their first callers would also be a valid split.

Until those callers arrive, the emitters are unused. Their definitions
do not generate instructions, and the existing opcode encodings are
preserved.

> and CONFIG_CPU_MICROMIPS kernels would hit build_insn()'s panic for them
> since arch/mips/mm/uasm-micromips.c isn't updated with their encodings.

That requires a microMIPS caller. Neither this series nor the existing
kernel code calls these emitters, and the planned MOVSX callers cannot
be built for microMIPS: MIPS only selects HAVE_EBPF_JIT when
!CPU_MICROMIPS.

I checked this on the posted v4: olddefconfig removes the attempted BPF
JIT settings with CPU_MICROMIPS enabled, and the microMIPS uasm object
builds successfully. Compiled-table comparisons also confirm that every
existing native and microMIPS opcode entry is preserved.

I also ran test_bpf on the official base and standalone v4, without
MOVSX, under QEMU Malta on little-endian MIPS32 R2 and MIPS64 R2.
Both showed exactly 14 signed DIV/MOD failures becoming passes, with
no other test-status changes.

Nicholas
