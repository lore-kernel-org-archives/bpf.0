Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9377549E141
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416586; cv=none; b=n/+LhgDlNddsdZh7yPD8vVtyvaLTUrVxZRDNYHq2r1F5MlE/UXzDqcbQppJLJbQfalvN10r9vt8HKx7+QSJikk0AnSMT5fiBzQ95KgajucXgIMVRTr1f0RC1g5cfu+XgNJHGDdKQZNAf3flks04cV+/kcdIavjSsjSmXp3cwEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416586; c=relaxed/simple;
	bh=J9K7XHs6jLH0An39Mb7nhURXxNOJFQd1nAWSoQf4ha0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ye/AubBqN/mh6rT12NxtLSmHFtQdbB67C43kYgbTiIlwjkNkiM4LKpzOimqTpQsYpfcGBC1fQ45BpJlu4+HPmnbgsAHLpEciTSiHV5BI8/y98nZ1XpjuyKcTKBx55uahgt8gJne0tQYVKu7EGKsq98Neq581o4S0HbV2xURA9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n75f+zkV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n75f+zkV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so16695645ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789416579; x=1790021379; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J9K7XHs6jLH0An39Mb7nhURXxNOJFQd1nAWSoQf4ha0=;
        b=n75f+zkVFhsh2CIB5se0JRJRlkHiNB/S51SNVREy2yxlKWE6GHBK/YyTC2zuwMHslC
         XjFJcfs646l6r41GC1wVZezqYzSGI44sKzOXtLF7zB2En8WUFi3hgsl1Z0Z6PalauZa6
         SRYhgMVYjDByRl/h9347IoYFQxhCsN0F7oTj50yHc1hflCvQyI3MIlDMa1AFMOia8g1b
         g4Mch9gFb5ayPFjMTvj0jHFEz3Tek86XGjX7ZXNFcnlZCSeQ862L1KnP4Ax1Co+WkQKk
         AF1ZLrFaWJYzJ9kOrq0MPBOyYNaRqvb2M2X4juNOcbsC8hu/LW/dsTOr3WAj5qGzwLJt
         zsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416579; x=1790021379;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9K7XHs6jLH0An39Mb7nhURXxNOJFQd1nAWSoQf4ha0=;
        b=q5PSxYrn5jzirJzwKNmXWoFjCl+FJclQDst+bodjkKiLRFkZRmUpdnd9Fg+/fIPKLp
         OVzxbzCBaPgnQVyNKl0bby3Mdk+maAY+xPmwS0dTTy6fMbGXyO+TCFS6f7njZastpBLx
         P063pWp2cQ67FHMESqexoqgRLHriIWk0KY3JFCZspdS2zkpGC94ZcA9jXD3Oig31Xlks
         yv63kQ5K0jMd/YGwBAms9yXBvagQMfTuuWC/SfiDqoRBVQXh5igv//eZqD82b2/qFt9/
         4ug1rl9AvhMJ8MHWTc/v5NigdTkfC1JAly4p/N1NoZQibqTGZz9DcnI/k9GNoIfEcdb1
         vYLg==
X-Forwarded-Encrypted: i=1; AKwUvBzMDql4cA/1+UDNKJKwGLO+avDruMvY45de0Ay+baHwL8IKZ9bjN6i+0ZV9QioRaVw62LQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nwm8aaMHyRqqJBhPb6G941BTiOy5Rv3myYxGXbOO4RGl3zsgLm
	EU+O678g0gcXBNJKaNIPyIUJ9TnafS1nFRR0Atkc4KJ0yqoJUaz/h4YB
X-Gm-Gg: AYBFou3pjrKdNpNv2J8uvGoai+aFoLlbjcEPyZa2HNKJ0yLn8cmvkMDdS2pcWDEi11U
	YRIp5H203kbt7u1mQalXTscl+yiyVS95F7MvzuU8gqIkBbEFwx2WXwNrCJkKM7Qyil+dyJE8onL
	xhL1EuvJ2dkgo398n9GcSFW+fiJktAUZjiLiwD8DB+IaAYA0gfNIxzU3aUKWYWkyKll2TGJp89Y
	QmuPYgtY1BwR6pj8qrJ6YyNfDwzaStXVPrOxmb81a7SZYDmKNOv25JjVT4veOXYCJgtgV2NH7WK
	+8ib0+Ejn+yhdznA3xanWJots1ldEAKW0hoQKTY62Qs5dcIizjoUVIxtfw23GqiCi3tJVRt6UBg
	P9V6uZYxUxYFo1hFVMXekCstv/Bs3nvwMYdQj/ilO24BHSwvhekJAvk7dHVR72ovEsu/AiA2bpp
	1wuDY92yFeKbliwONkNw3rZibNBsIOE643H+d32f7DR0nXFyQ0WoKxRvi8EcMIaou+w1FTEm0f3
	dWH9TvAx16vqQYfBOOUkvol564=
X-Received: by 2002:a17:903:1b47:b0:2dd:7549:39d0 with SMTP id d9443c01a7336-2dd75493c43mr37004725ad.18.1789416579012;
        Mon, 14 Sep 2026 13:09:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc4403sm55181415ad.52.2026.09.14.13.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:09:37 -0700 (PDT)
Message-ID: <33cf9d2c1925225d19a20c7bdb1f1527a7893953.camel@gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable
 instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 13:09:34 -0700
In-Reply-To: <20260914131701.2529725-5-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
	 <20260914131701.2529725-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:16 +0200, Kumar Kartikeya Dwivedi wrote:
> check_subprogs() verifies that each subprogram ends in an exit or an
> unconditional jump before in-kernel CO-RE relocations are applied.
> An unresolved relocation can then replace that terminal instruction with
> an invalid helper call. The resulting fall-through into another subprogra=
m
> breaks the CFG invariant used by postorder and stack liveness analysis,
> which can write past their per-subprogram arrays.
>=20
> Handle instruction poisoning after the instruction has passed the same
> class and operand-form checks used for a resolved relocation. This reject=
s
> relocations targeting jumps, calls, exits, register-source arithmetic, or
> non-immediate loads before they can alter the control flow. Keep poisonin=
g
> supported instructions, including both halves of a plain ldimm64, so an
> unresolved relocation in dead code remains valid.
>=20
> The shared relocation code applies this restriction to both libbpf and
> in-kernel CO-RE.
>=20
> Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram"=
)
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I think this commit is fine.
The error code is returned and the diagnostics is show if instruction
cannot be patched.
