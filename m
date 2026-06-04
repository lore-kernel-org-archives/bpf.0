Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526034DB46
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591233; cv=pass; b=QanMZ047beQ+V+WTNfbwgZnxWCyr8WEK35NWpH9b92J2r46KrgoRBpHI8llnql0XrOgW06dSmzrCRw5wPKL5qhkFhkIeseAllZiAjvVK+aOiybaMEDlfMZe2RJmYv6uD8x6B2jxr1MJoOXpiuYbgjF+TJ5MdTSYKAH9tjcEHgFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591233; c=relaxed/simple;
	bh=dZvnNmThs/qXdfNwegcDifizXF/EcS0QjzjPKFMW/T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMeWy0nv4cbX25xr/fo94wI38iaiwGcQmkjxu/7D1+xVIRXKZoxAg8eacdrFycxLHq352wvCyAgeDkgCnO34TlyRgWTh9AhdaSXrCEkwLtupeCYD6oNNGaIPdLUWkwB7AX2HP54ucPRnxzSkPuiyCzs7byWxvWet+lbeX4nZQr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAfYAmMO; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAfYAmMO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso5297555e9.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780591230; cv=none;
        d=google.com; s=arc-20240605;
        b=Ebn4qZH72myU5L0tkm/BHbsmYM0huKf3plYn+rDHxpwEPJBChxvWPTXjAkm6Iusi2t
         JCm5p4obZs5W4iY9rYg/5PusJjz6xuWbiUMha+/C8cwKTT3j6IXrNpA63izWit1WIFzu
         EHWFBumfTmUXTHoKceEdASZlEUpjWu/+gM2uFW/mJVRJjkkhLwMc/1HR+luOwZo6yqV5
         n/l6basy5E7EkUmfHOm9czFassdYPO4PlAff7EiJ6+8Cv9pTcz6F5oioMYHPXnBkDnR1
         JvE020hUptutJjbXozpBQUAIv6wgYe66w7Nse2ePuoXMyFF3Qe6289msTV1zMDRHQ9Tz
         Y3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gqsqif96rYUgY5SC4+RNgcs6nqYFz5/DHQLpk1a5Po4=;
        fh=wNA/lHhyEMEmaTQxBK+WxaL+HFFsonx1C5dIrx7xg/o=;
        b=lflBRdWzFUNGYp+gXLW1SE9Kg2G32RBTCZ599bfhodIbTh5ZNOFA64ARuN9Mh8Sces
         SIAbi85OTwem3+fDt5WA5UWydAo4opLX0u7B5WkqNKFl0kbt36blw3BSqx9abqmjfaqX
         UJJNzIS5Y0tQkVutHnBJQm4AQECCiVymAAvglBaZ+uxLB12aRnXzrc/OC+0jRMmZlfTh
         uXyYMErqadJ574eLR/4eHFC2QUuR2oDypjxmYYv7DxWejdTnxQYCKBE6KGwTMW/wt9bN
         Lnp5RJ33HwdLvkLB3DesNZnoEnl1pEXlH1B4jXba8LhleOmrc+/KwJ+Vw0131YXBR2KI
         EPCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591230; x=1781196030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqsqif96rYUgY5SC4+RNgcs6nqYFz5/DHQLpk1a5Po4=;
        b=ZAfYAmMOZr99m5van8Q1CmSNL5DNoW3kIrrqWg3rbDeRHudywBqv87AFWuGCEsCvQM
         Vh+LV4INYvjWYJrYqzalD7MaLs4zmaNZm+UDY3c6TZ7pYtRLpwLLnoFFr0PFi0JTW61O
         upghIVC3zW6vDPmlcwzLvCbZCUgps9qXQYA7wYvXwPi+1r0Rxuq5DSOA5XJGW30CTNZd
         67S5eNAXF6W1z93OuTYFwmeQzhLpbuTdusa9Dr/ofc+/HtvuidBHB6yXhZqR8xATa4Jl
         w+TbZ7qzpwD0UbWbhYrRtl98NOnSaidP3UR1ueRUhMSMsAbmzOjSvAn0Lqkf9eXnXsWh
         PC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591230; x=1781196030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gqsqif96rYUgY5SC4+RNgcs6nqYFz5/DHQLpk1a5Po4=;
        b=LToJLyNRHMuWFGuImtgWL2MjEUgj9cOHLlF8HlZHhpCmgH2YBmjJL9mAvBgczDgr8P
         M0mAYamRsF1/vVTNZJ5qmrL/2kDiDd8L3MyO2W/DG6z3tG0OU9FgjsyDo4oNC4GqGDvE
         Jz0eeiT4ZF2DrmAcJrbyCY5QBXNc0lm/KzPoRTV+zmNVNyzdvOW6r8BwbHr/SD7qdNlm
         76z7CIuW72U4bl0U4Gh7yU4+vXeVKXYxI27yGLMZkvN0+zvVeKT0Zfn7TWsYpB4r5spM
         EPahYzNa4+bbPaQmaVVPpxI8HzvuYwVFCyKuC1QEZKK7GRhAc42T3V9kL772/cHM5mXp
         9Egg==
X-Forwarded-Encrypted: i=1; AFNElJ9huuEks3rouOnnHriVmR5IpZ9VWlEDOY1ZQOjwe5iCBu9iOYRiMtBgPJy2OgLX0MtpzAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cCbWCfGI69oHpM0ulbigxojdUrJghtCy7MHh4yI0P2uPzsvW
	Np0PWlht3sAkdLvgoVCcE+sFC0MDwWI/hRgqjBaLhSBx13umTs/Y+g5AqrFf/kLqnqUFffSox0y
	bma6HOJTagKItBFfPM4V3FtWht7q/WDE=
X-Gm-Gg: Acq92OGrHzriTwhLbQgQBNithKVp6YroxJHT3xXJRig24hzcpvsHrtOjXZEXUHjQeNW
	9qnkHCwfmVyLgSMgOuWpzJTSAHnvfqTj/5GAaffmQf+3705g4snjAMXDLkowzhtJ0DLB3Tc6wdT
	2y4YuW1oRGvnkEkvwZJvp2g/ey3t3eivXKurbIm/JQx3H656Q3myHQ6jdPTIu1QcDs63DOZoqYg
	LyqgUs/SieJ2qssfiQV2aq6NS9/3Nr7SyvLnT3u6UWQ9va6H/4ubr0Tao0tZldnbL0mxlH166i0
	i/Es/ZszZMXkWyaadnapGHMCN3x4iHwjI3l0t2LVOlrr79f14AUwRNjU4Owjr4X9VLQkxDpdD6S
	WDgAXm5FM5i2WgRiFEginEk3YAP9SF7YeJA==
X-Received: by 2002:a05:600c:34d3:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490bc4cf867mr70365435e9.5.1780591230268; Thu, 04 Jun 2026
 09:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
In-Reply-To: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 09:40:19 -0700
X-Gm-Features: AVVi8CcvDLvN-DAcraFmgwYR38m9ACOrSiC5mkCojEQQXX3g_1pg9XQB2xsdrw8
Message-ID: <CAADnVQJCXbZ27oZRYcd6=9WdaKvkMc4-PAK2ocd1hmRU=1C2rA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS
 constant-offset OOB
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:08=E2=80=AFAM Nuiqi Gui <gnq25@mails.tsinghua.edu.=
cn> wrote:
>
> A constant offset added to a PTR_TO_FLOW_KEYS register lands in
> reg->var_off, but check_flow_keys_access() bounds-checks only insn->off
> and never folds reg->var_off.value.  A BPF_PROG_TYPE_FLOW_DISSECTOR
> program can therefore do "flow_keys +=3D 0x1000; *(flow_keys + 0)" and ha=
ve
> it accepted, then read/write kernel stack past struct bpf_flow_keys at
> runtime.  Patch 1 folds reg->var_off.value into the offset (and rejects
> non-constant offsets), mirroring check_ctx_access(); patch 2 adds verifie=
r
> selftests.
>
> This is a regression introduced in the 7.1 development cycle by commit
> 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers"),
> which moved the constant offset from reg->off (folded generically before
> 022ac0750883) into reg->var_off without updating the flow_keys path.  No
> released kernel is affected: v7.0.x rejects the program above, and the bu=
g
> reproduces only on v7.1-rc1..rc5, so no stable backport is needed.
>
> It was first reported privately to security@kernel.org; per their guidanc=
e
> it is handled in the open as a normal regression fix.

Right and the fix should target bpf-next.
It's not a security issue.

pw-bot: cr
