Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAD2EAB72
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638502; cv=none; b=hCRKDfETJFhEGSlMcM/3KB5r1ux3sCLqRE1yOwA5uU6jjRUdkt4fPk6vUqotJTh0ex1YRhlhv5iBuWXMejaQC4L6yCnJOz4dhtp/1luZA2sIx12e44IYdJgIGKTiIHIggEGUaT0ziJv0xwxZJqLnKZ49UUMKyr7ebx8KPhjWUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638502; c=relaxed/simple;
	bh=Kwy/lIZG4jZPLnwWCC4JuzR48BZR7MoWws+ux2PyiVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ao1rPzIqfTJyA0a4T3l5O51IsloAt1AbF3sWfMY8KPI5lAzvXQWBxrCn28NassZAwdbpA9Ri2cYzrfwgxuGCk68pSQ+lN+kobht3+/YsX+9e52UZGX28kXHIdeFneAEW1lTxC1tQN2j0ho2ZUIg0PiosBDm13DX9fmJ6ja9wzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R68qvFvH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R68qvFvH"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so249486a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638500; x=1784243300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kwy/lIZG4jZPLnwWCC4JuzR48BZR7MoWws+ux2PyiVc=;
        b=R68qvFvHS/MTkWfuH6gk4mdgCeKhoKDh1Z1ZsNBuRHtUkN7kOpj9EZy1JdFYfr6ni5
         yv6NFtUW/Jr87cAEHCFzCHcIzdtM/ZbrlT9JryOytv418HFdi4BsrqXnX5tcRMGaGsyj
         L5OrHX9xb3joCvStTcoLqXKgAtgVVghnLEzGpWbiTHiBHEM20TzeIx+p3a0b+CzNJipU
         XQyjuffj3zqvtMgULAaMHVR/Ajgg9X+3ca/Kba21sYPRdvrmKhRkDzrLau9xPpmJloPU
         XQ4UbqozeszAVlCggTRT3u5GIdgxXk6mfV6LUCJzt4EC6JcLtYluHG/y7ytEIXJFqAsN
         jSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638500; x=1784243300;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kwy/lIZG4jZPLnwWCC4JuzR48BZR7MoWws+ux2PyiVc=;
        b=BQlpyxZFd6wu4CuCJCWmQM2jA/fNPOwF4MldVHTfZoXu0E5MucGf9r4BoFHdUED1Xn
         4oSUvRZynEcnqw7Y1w53ECvnnNi0He9D7ZeEo9kh0kG+hYYmq0ujvDXpKnhFfxxCL2l4
         Ca0xaLpoOOc4868x1tbNRIY+yjV9MJ3ufTc3qEZ8EWqBOg7G8UpJrDc8XUwV26vUEEOQ
         WKNO369Co92kyezWjnJMCFRsw1/kEIkilAGp/TV61xYOGbIElEEobwvkEvagqGd9J9ew
         ENYa14WRPJHCdR16WEHy79j4zJr/9cm7/zAn7v/I69YavML0Ws7dJ6LA+mvcU8hIOgkv
         UdRw==
X-Forwarded-Encrypted: i=1; AHgh+RqHdbpCRcIE98KMm4BqkAyk5y0vxJgGFzeDfJqlROjMqQSfDTekwlVXxwNus+1QOfawA20=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTQAkhBM+rqGka1GEs/GkvtRa9xo38HnaflhH6h4fBY4OFF19
	B/WzujgqFUwbkZ2ss2TWRJooapmFkEGOTnErJk/7hrJurg0BzgonnKQ4
X-Gm-Gg: AfdE7ckxENI3aJQ84J8Gjm54tfw7biSrDoLRodbpuXAFntqGq2xtV4/8x4mDQlC/5II
	ZSPt/YmhBRGTrHHP+g4WexsS4oqUpwmJAbKpxl5xDwDVjI6kNqz+da/VUCdMzZWd5r6YvSVFYrA
	JUNGXHyN/YhbAFUttw7XpOtUWJXHdIydmHP0xxgX1TVs0nDMjQbf0qSgsl4LtDeApwivMunW935
	Iz9rTHm6driSR/uYuG/doRgik17PEhxjCgwlTksR4ECj+Rn6U5X8HYEr6eZXNUaXkS5Uu945pu6
	7Sfa9iaw3rrs9G5ZxnXO/87R4JAUcGdQXzorR5PLnWm25XPp4bY1lHoSX73u0Lrx0dS2SLqb3Tb
	/J0xx7GCYSXywVAm9FpkdT4jQimVxhBam/OWLVHx9kbIVxPt+Y15y4movutOjhw4YXSzss3oC6m
	BNnwbcuDAgp+diC7fUwkDfO84w+qBmDVCJz27odTGK
X-Received: by 2002:a05:6a21:496:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3c0bcc6a209mr11205185637.23.1783638499871;
        Thu, 09 Jul 2026 16:08:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162d56sm4297903a12.20.2026.07.09.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:08:19 -0700 (PDT)
Message-ID: <b571171588e42e40e9bed69fb3f1bc9021573445.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on
 return-reading trampoline paths
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 16:08:16 -0700
In-Reply-To: <20260708201015.2159760-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201015.2159760-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
> btf_distill_func_proto() builds the function model used for kfunc calls,
> the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A followin=
g
> patch relaxes it to accept a >8 and <=3D16 byte return value, which for t=
he
> BPF target is passed back in the R0:R2 register pair.
>=20
> But the BPF trampoline cannot preserve such a return. It saves and restor=
es
> only 8 bytes of the return value (RAX on x86, i.e. R0), so the second hal=
f
> (RDX / R2) is not preserved across a program that observes the return
> value. A program attached to a function returning a 16-byte value (e.g.
> current_time() or ns_to_timespec64(), which return struct timespec64)
> would corrupt the value seen by the real caller and read a partial return
> value itself. struct_ops trampolines have the same limitation.
>=20
> This only matters for the attach types that actually read the target's
> return value: fexit, fmod_ret and fsession (plus the _multi variants of
> fexit and fsession). fentry and fentry_multi run before the target return=
s
> and never touch the return value, so they can attach to a >8 byte-returni=
ng
> function safely.
>=20
> Reject a >8 byte return value for the return-reading attach types in
> bpf_check_attach_target() and bpf_check_attach_btf_id_multi(), and for
> struct_ops in bpf_struct_ops_desc_init(), ahead of the following patch th=
at
> would otherwise let such a return through. kfunc and BPF-to-BPF subprogra=
m
> calls, which the JIT does handle, are unaffected.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Maybe post this independently from the current patch-set?
Seem to be a standalone fix.
