Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D873C0A11
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666396; cv=none; b=JkaUHOAgQO8nwNm4X0XF2YBmjMyS/vgkOi679eowM71OGEZrd3wAiZucVUxM97l2l6UFNZkjYb1/iBOPERgb9MEDWVztlTCrYWVfCKtszuKOBSo0nuR62pXBHnPHE86JqL/Oa0MbbktMJG8x4oFk4fIAtM5mJeOc6jxFwdTIuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666396; c=relaxed/simple;
	bh=UyKWMmzzg8GxqFBrzF8rX8tYh+pMIXs3xUozC0m9Ydo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ctaq+/njK59D019QYG3NSnH4QvjRXXYaAFoulOayy1GKG7Gi0V9ljN5t1bHhdfWKY6Fb+FDPG9W03M1y1NhzmFlY9aer2rTl1tXS4CWZ6sI+BiSg5JyXAUOcXQETeUCIzW4eZlT0aS+p9NQp5bUO5UDDPkKo0EcrozOGyxCk/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHKpDc7w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHKpDc7w"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8fd3b729dso19326605ad.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666394; x=1789271194; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UyKWMmzzg8GxqFBrzF8rX8tYh+pMIXs3xUozC0m9Ydo=;
        b=LHKpDc7wGjdhDMZodOwAZfGUmEsh2AyUCdbA5XPJR/9FGsXOkV/UKK37oEJ8GYnlfw
         +ysLSHGiDCziswCFsuR803QepIdn8NUFRy77SpNXBmNN/vYFLhr7ULS92FLKrsIKDeEU
         2H+Jb0lmNI1k8NQtpPRdS3K1PB4wxXOaxINQIPw3N0Nk47/sdPs7KDAlddZyjz6IFN6z
         WHOSGlDWbS7ZOS3drL4exU2/85FluYAvOZ9R0NiRUFMfefoaNLMXLm+dN5ExsWLZSrW5
         oGRk0N8L26RnHUiIoiYsFSYC/OR0AsJ/R8hRQ1rRvRU6y1uTSlQsftCKKy9uxuqcFpP6
         +txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666394; x=1789271194;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyKWMmzzg8GxqFBrzF8rX8tYh+pMIXs3xUozC0m9Ydo=;
        b=SyHMtWBe2Oouia1wZAHtdmKZNEYsMzO/J9mDkuWpaGfP0lu9CrehmLNkOJ+ZDVA+QA
         B2Da9E7VMcHMDzk/KW0warkWpn7fguKAMY4J79xlWqR+ZfS+bFH4nXevfQdaJXBf6TbU
         aPJFk4pjIr+iiFMR4/smy7xkFbV4e0tVEnOO/rFC1ZjcTa31kuAwEPF7ir3NS2cadtLe
         w4Kga3kW9DZU2kiJIQwzJgf9F3gCyVFH3nrr2FEXE9WDcLedxPKcM1pgt+bvHJ3HzyLt
         /ZJQDnLvsI60boJAwVO2+RvHQKld5mHrMq8KquPRTTuU6I21YG4Tbd417MBrxSsp4tdh
         P4HQ==
X-Forwarded-Encrypted: i=1; AKwUvByKH7mcsFO4hf+xQuCDwHD0W4CbQXGMUmm6fnlaq5M2S63s4Yo0XyNYCzxSo1GofcJxWdM=@vger.kernel.org
X-Gm-Message-State: AFuF++lVaiiI8JIqolLW+ff39af1fdMepgsSsiP9VYuq6fPSK/PS3bTW
	r4CtRKABJyi15YS1PBf7YJfiU6nv4Yw6qBUTNL4k2xoS40WjZ59CwlbMllhz64kJ
X-Gm-Gg: AYBFou00MOuZFWlOwT962Or1+0YeIw6Y7wOYxNsL+LdT8mX6ABGxqDSL+JfiN05W70G
	lut0LEM2igEGc9fmzitXJJWVYS2xhyYBrIvGkZwtCRkmODtlBAcO+0SwxeB4njl4UZq2SOjTRMZ
	2oLQtZzDX8siWH0iaB4K4bjU+G/vJE+r2i6bll/y+2MZfzGtx+204bOXFfMlLvAdW1nRr3d9gsC
	ieZLHv9qzXbMnZi3YOhaYfeq3aismpf6VRGBFuQP7qJLlFjCLVilXJnij37ORiUI/WC5jpwMa+j
	wKpi6+Iibfm1qbciuquPbXxiAf1+1jCEZJ4FmzAayb0Bi1D6WFErzh8vtdVdaVpKVJumedUlDSM
	yIodCYM9qnKVUBqV8+SpS0Yo8CoGnnLzlbDVYBtlQd9xBTOKu0r3E/9sDhxF6rwBeEW4ZDmqJ32
	kgn3poGiujgZqamX+owGtIbOiROf0kB0Rg3jDpA4+E0G8BM47SE/Yxyz2H/KsyWNuIfy3zy5pfV
	cZ5Wrgu6KEbxNW+
X-Received: by 2002:a17:903:234d:b0:2da:c09d:b5d2 with SMTP id d9443c01a7336-2db1231eb81mr212080805ad.3.1788666394178;
        Sat, 05 Sep 2026 20:46:34 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149ccb2bsm27483785ad.71.2026.09.05.20.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:46:33 -0700 (PDT)
Message-ID: <ae51c26ca2a9a66c00a037d332ca0fa4da333a8e.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Reject non-scalar bpf_loop iteration
 counts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com, Alexei
 Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,
 kkd@meta.com, 	kernel-team@meta.com
Date: Sat, 05 Sep 2026 20:46:30 -0700
In-Reply-To: <20260905014735.1452988-2-memxor@gmail.com>
References: <20260905014735.1452988-1-memxor@gmail.com>
	 <20260905014735.1452988-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 03:47 +0200, Kumar Kartikeya Dwivedi wrote:
> bpf_loop() declares its nr_loops argument as ARG_ANYTHING. Privileged
> programs may pass pointer values to such arguments, so check_func_arg()
> lets a pointer-valued R1 reach the helper-specific checks.
>=20
> Since commit bb124da69c47 ("bpf: keep track of max number of bpf_loop
> callback iterations"), the verifier marks R1 precise and reads its upper
> bound to limit callback simulation. Precision backtracking only accepts
> scalar registers, so passing a pointer instead triggers the "backtracking
> misuse" verifier warning. Kernels with panic_on_warn enabled subsequently
> panic.
>=20
> Introduce ARG_SCALAR for helper arguments that only accept scalar values
> and use it for bpf_loop() nr_loops. Generic helper argument validation th=
en
> rejects pointers before loop inlining and precision processing.
>=20
> Fixes: bb124da69c47 ("bpf: keep track of max number of bpf_loop callback =
iterations")
> Reported-by: syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@goo=
gle.com/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Looks like there are no other instances of this bug.
