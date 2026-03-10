Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7D3D812E
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180418; cv=pass; b=JN9nybsxYblbWXP+dgTIoSPiT8Js2JwZ0ko3l25hEftyXO98t0WRT0c5pGGTYgrsKtqgtOxQM451xeGsj/1Rn9ig2glRx2f/ujrTiOfeGXVd9TGf0L8sE4OtMYzg8mg+eIPu4kBd2fQ4cWgjc1k/EXu7XuRj8jkB0+QwPif7LVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180418; c=relaxed/simple;
	bh=ndidRG6JP1v9u5cMhjoRebo4Xp3f+BKq41sQRtRBwZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQdmeOUPHfHGhhJzgrwJ+aIPtRpK1wLEZz3ifr/yOTPsCgRfF8M8TF9FCPIdqO4Ex/LXhc4ToiutEP8jVrfXfONNPinYqeW934Pekj0eedthJJnHsmjjG4m4q9CMrOyr4pK6l/WQ8Tc26DFD1XaJKT1PpGd2cG8IK4IJ/t0Ea6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpBm9YtP; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpBm9YtP"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so28797135e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 15:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773180414; cv=none;
        d=google.com; s=arc-20240605;
        b=beUPG/+1SNHRT1fzohFTslJJHqF2l2opaSotLyooZzIhur/YhZHHySQ9Uu4YNt23E+
         g0cwD201rOtbdLn111/7ezaYcy+18SQaV/rX0knS3IHSmUj1o2d99+ZjgtTyEDRmPm1h
         WGMvJvpmOnhuY75pVqgKRAFHa24K5W9AgLV60/9dhzyN8VIXpw0Z3RisyJd7A2gJ/TGl
         TY8hKDFxzb+P9R1g7Ku9EhLO0VXbwMclNfj+T824h2bO2wDgNXtn8OLyLNyy+PiRk8zi
         L1HtjMUir1AayxZ7J88vVUl9DIJ9v14bDGDKLyC4RDitR7/2CoCYsMIVMCdkRjbhsPeN
         lS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rL4jDVVmx/+VPNOhteteSokIjmvy1xU2JiFgOfo5UPs=;
        fh=5JFlNE9GcprIeH/Ak6UBkUoBFyr2L18x9v/IsvcM4D0=;
        b=kGJCdd4LecNJjQ7isMBjB+u62PPA+3ZvwoctNlhmw9d0tTmX5+zjljQcA9NDgf6HQS
         BysjrumoPBCBc3mQwl96FSkcRnx/JASxjMPJWw2rjXTDlLLOxolLXMsSIObc+7wyVK/8
         UnQLaZLDbm0WSUWkOWJIyiNWPLsElA1+TNGtX5swqhQnyytpQQov3qBl9cW+dcP28kv4
         /WRkb5NEkyccjXeyLnvJdt63UFoO7ylty5RWONOPZ6+/DRrwaftVeh6gs+Q2+XtcqtzW
         sNGRRxhPZm+DbgX7y6H2xPopdzNsCcZDh9XKY7zzkgm8VCwuuXBMeh8RLsVAVx862Dab
         hoGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773180414; x=1773785214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rL4jDVVmx/+VPNOhteteSokIjmvy1xU2JiFgOfo5UPs=;
        b=SpBm9YtP69LJPACpQB/Li/fjzau3t0PNlzjkOhuBEgtdcwQ/7zmhSkTLn6GxGRgqK5
         lh2D5N2a4531WHXyn5CEIt0m+BguJ2257V1gQCwHSFPnIT8nmkXG0V/razUdr3TefQNj
         B+fmD8qoHYuCK8wAaCBsuA5rIt0YNBnBCj2QaKwARfNcEY32/TxdXS3YNroflrV5H7Zk
         IVoAWzEbaXIE7d0q3U/g7CGqOI0Zx5fnuOw4N2mNVKYaBsTHtfe8ttKXWHY6tSxEIElx
         P7nOKjeZCUhneOQt8IFW2r28Y/dNdTHUsgnJh3wlOIXzVninfMzla9txb07kBrSPf+15
         DTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180414; x=1773785214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL4jDVVmx/+VPNOhteteSokIjmvy1xU2JiFgOfo5UPs=;
        b=AGqYRZsTlOG1km7gyo2s5wVE5HY1HBkiEyNnw85sQ/nsma+UjXol9YWVNdcfzPSZTM
         615CkCBWklqoVORNNBABEqxRwoMRW9CnOrzC0VhM/eASsKW7qoR3E8n4eyhO8n2W25FQ
         OdJT8uHkjlf+2O3Mu9eGMkp/SywQS2NcMqX/C/J0Yv+19Xo9VH0Xo/WnFXpuLgn8sjgE
         zf2YpOPKN0zM+0xBGtpwDcsDn5Q2lJYjINRuM/DpBWMO440MNEasuT7laU5Quft8rNx8
         7Wz+1WvfS7iGxZHwQ7vS63vmmM2OSrMxh7bRMhd9oI1I1q7Wc4MAcUAJQDTUpq/VVjoQ
         1BjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpCdf8TGpiYawTLASym4hcMpwatByTI5dm5sl25iiOtYeCbgJF4/0cFWOxSiQI0ddHNHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMlGUlr6dSdGQjdRnJwBVzMVAuEkxy8zRCXdoun7xCRwYhZWZ
	XyL1wdoSzCc5n2rlFZjNSBERDVVHcdzz/Jey4lS6FySvV9GLoWyvlZ+TiqcR6eE9M1emFr3n47v
	aKEqkqMUWE8NpxnhDTYbyVXquKEGECuM=
X-Gm-Gg: ATEYQzxoQXFtpDGzQiNut2JTbKY+44g5mobm/8PZsj9IfVLmZ7ZZhkgwNq+hRpDJKTG
	EE2HT2x3N8c/5INhYaSjO9UoNGU3quLruT403ApJS1EZafh+5tPXVdL5egj76tAU2qlvSFucCPm
	xdOkegfsmByn8B5I3KhEbpLdG2RKuLj0Xevuj5G1XTZizSwPtg66hY2MGbhD0ByaM6NOo6bnh4L
	Q3fI3RiTP8HKl60FeyV7sJH6yQjKJucGyXzCCjP79wQRF2yjhATpa3TQ9PbfBl/uXO5BlgVNKYX
	GbaB+9K2z/aXlGtH70EgaVw2XyUnBVK3oSlZW4p1FBUWk4CLCZoeg71uYrED
X-Received: by 2002:a05:600c:444e:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-4854b0c0cdamr7289455e9.12.1773180413717; Tue, 10 Mar 2026
 15:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310111330.601765-1-alan.maguire@oracle.com>
In-Reply-To: <20260310111330.601765-1-alan.maguire@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 23:06:17 +0100
X-Gm-Features: AaiRm50p-Ec0QT-ThJkQavMC0jJ_c3h6Rl8h_eBX5gXMOHi-rPj1L8K41Cr9B7s
Message-ID: <CAP01T752KW1tiAT0RSP6cEXWAPv2P0zBqAR94xVRd-6zujjSwA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, alibuda@linux.alibaba.com, 
	yanjun.zhu@linux.dev, bpf@vger.kernel.org, 
	Colm Harrington <colm.harrington@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:27, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Currently BPF selftests will fail to compile if CONFIG_SMC
> is not set.
>
> Use BPF CO-RE to work around the case where CONFIG_SMC is
> not set; use ___local variants of relevant structures and
> utilize bpf_core_field_exists() for net->smc.
>
> The test continues to pass where
>
>   CONFIG_SMC=y
>   CONFIG_SMC_HS_CTRL_BPF=y
>
> but these changes allow the selftests to build in the absence
> of CONFIG_SMC=y.
>
> Also ensure that we get a pure skip rather than a skip+fail
> by removing the SMC is unsupported part from the ASSERT_FALSE()
> in get_smc_nl_family(); doing this means we get a skip without
> a fail when CONFIG_SMC is not set:
>
> $ sudo ./test_progs -t bpf_smc
> Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>
> Reported-by: Colm Harrington <colm.harrington@oracle.com>
> Fixes: beb3c67297d9 ("bpf/selftests: Add selftest for bpf_smc_hs_ctrl")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Tested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
