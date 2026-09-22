Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEA2F5324
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050129; cv=none; b=dnLuD34etbl1sQbYs8wk5L9raWE78oL9FzKJsIemadTbV45sTN7W4duN+zHOoeUVKgnfD2i+LxpqwwyOeBTp0KZR6uLnqTFY8ZWgGtMn79kKFzsUtuBSnZiDmiVQY/r9jyzyrsOkZxNTO27+iBXaV06S3rivIla89gx3d8NKVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050129; c=relaxed/simple;
	bh=ajFp2neD9Y7Wg+Ob0XIAWQ2KvKh8hPvlVKn54rPpuO0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DW70Dpmd/QJnfJdo7lmAx4VqQw+/n6VNWvZYubaTgxrxWOHj711nFXn65i1eZUy9nmy1Oj2WF8t2R0+NV1fGmX6pA1zAMmeevQA4IeSgBn+GLVmei5R8ycookpouwNOZuY7TsBPeu0qFiX5xJr1vdT733RGlNCj8xwH5g1Q5qhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRcrBU1h; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRcrBU1h"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so33378135ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790050127; x=1790654927; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NT46/qDEDy7HVpg0Mb2EXHCaPocetk2cXdQv+Ksx6kM=;
        b=pRcrBU1hfEH0E1tVW1fbp/XfYLLYtrs9fcH6EyDcJV7gx+wM7/s6UeubFeMSAfiaVh
         YeUkcMo6Hg57FGiq6ZWQ9B37vvjkNb2XhNgczq+SrtfPzgdAks5MJguKLp2jVDcofhFj
         8ClTNM1We7G/vp/1KPS3GCnYk6VO6naftT0XZKO6odXQxgPeFHBXdVPNYanECN4TX4+x
         UNhGvhpTGyh/LN/YGWCqHF4Q3d0CF+TY+Y62tOnkQpfwWIF/3vUH38eEOqfdD6JXyNMv
         SBDArdGqvvT/QbaPmi212ccPaJpQ/I/X6ZMhebFPLS0XUaDHc4lrLcMxyeOuD9MwnSLu
         6eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790050127; x=1790654927;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT46/qDEDy7HVpg0Mb2EXHCaPocetk2cXdQv+Ksx6kM=;
        b=SqBtv0YXKD1ONtz0kVl1u6eKAIc41dDHd3M/pZScT7HBg5vqNqjCZZB/0TZEmNughn
         FtHZFZ4+JmhRKzEL1Qrg/2v5HL6twhr9ayj0CwxOUwmvBUowicZ+luPt8dGYRYw7aJXh
         bBPwM8KSoUHQknrPjZmzMr0j4uhV5wt3Qy5vxxoKM2FzihuJxcIsr8qp7YVaI7LES41j
         0JNCrTkp4nHCsBpUI2midmJLBMbLJUJYcOUXQwmi80almEXcP1Mfva2ld/S9XJi9EH2V
         gisVOqEnDm5+v19+ZGMXGrRRPOZhX4w11zDl7YgplS0F4e9tJ3PNU4rdIwgjHjILCC4Y
         xCiw==
X-Forwarded-Encrypted: i=1; AKwUvByJXeKZtyYBDbY2y9qLufqD4t3FSaH49Kmx/CB75uJWE7hnRLKhDSGSxPFy1HmkKZzepB4=@vger.kernel.org
X-Gm-Message-State: AFuF++lKHnYk5IqOhKzbUP9cpuGyJ7qTELX7UpJ3S4M61PdJ519KgirS
	gm1auyNH6AH24PAa++UMS2bTV5IuglFtCl2J7lNgVHBTanHkp+WHZS4E
X-Gm-Gg: AYBFou0qwHgzzeFgLwltguNaPUiYa0+IQvBndQglSKAT3sZGm+SflVg9WgE3nzh3SxF
	4ILgpuKl6o5MGQDUD08rfnzU1wUsserNcxW+fj3o5o+lvTfHX7k0H7ZFwYLLyAO7t2cM73EgJyg
	UORoewU/YBd4LI5vpnfwQVsk0NdwQNc0oF3CWOyfaWTSLD7PwAEzvhyQ6ym22U1e6zbPyQyh8Vn
	5Y6MKmlebbIZjRD8VP1T1/RBm2K1FmrYNEPTTTrMGB6nKDYoePGET8DglmlZ3twyA1SgileiLNI
	qXkZQ/7z9SnUeL9o3eXT73gYLMCzcoRMITTxFwK6jp8037bURAqAUeOOjgs/JzD2M0a5zLPa0cf
	vhxr/IUJ9i0hv5EK3PJSJ/rb2T8asNymiERrnlad3n1W5cIHI41wtfhKfhCSuAKy3slBCevwxXV
	YRVV+yxM3Z2+cLTidtk0yQ7VJuWHBtLh5uBEFX1sLYITYyNqoKDZtKlHhw74xfj4fHdkFcDLvkt
	/cxpBPaw5INj6/CrEqsstwMqfe2QwcnrqYoDs/FemKDvb2YXL/qW1XYeosLJ+CcuyPcnbAyxCk7
	aoc=
X-Received: by 2002:a17:902:e810:b0:2dd:c100:7cc7 with SMTP id d9443c01a7336-2ddc1007e2cmr134090635ad.67.1790050127351;
        Mon, 21 Sep 2026 21:08:47 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d047c35sm2419065ad.53.2026.09.21.21.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 21:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:08:46 +0000
Message-Id: <DLLJT7NBMC67.1MIBGY9CC99CA@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
In-Reply-To: <20260921210114.1720196-1-yonghong.song@linux.dev>

On Mon Sep 21, 2026 at 9:01 PM UTC, Yonghong Song wrote:
> --- /dev/null
> +++ b/include/linux/bpf_cleanup_abi.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#ifndef _LINUX_BPF_CLEANUP_ABI_H
> +#define _LINUX_BPF_CLEANUP_ABI_H
> +
> +/*
> + * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a landi=
ng pad.
> + * It has to be a constant the verifier knows: LLVM names r0 as both the
> + * exception pointer and the exception selector register, so every pad r=
eads it
> + * before anything else and is free to store what it read. It gets a hea=
der of
> + * its own because the two sides that have to agree on it are the verifi=
er and
> + * the arch dispatchers, which are assembly.
> + */
> +#define BPF_PAD_ENTRY_R0	1
> +
> +#endif /* _LINUX_BPF_CLEANUP_ABI_H */

I'm not going to read the AI reasons in commit log that it came up with
to justify new .h.
I bet it doesn't need new .h. If it does, please spell it out with human vo=
ice.
And, in general, pls tell AI to be terse. and remember it forever.

I told my clanker to be like me. Terse and to the point.

