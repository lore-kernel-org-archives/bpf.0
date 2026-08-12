Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49A345ED1
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573473; cv=none; b=hevZaOVi7wqW0f89lFhdlPVAoJYxZdJj4KD52/MZmGYKsLHKzwdguT4H1IltQHkeQRIyU34XfpyO/qKOZfHXxOazy6IH9gViI14pFTedC7x4LmdqPtROPpWwHGwXlDK+0RoQ0xaEpySOfRLGjKNkQkm8nigvMibK+MLJEltKEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573473; c=relaxed/simple;
	bh=yEiyhIY1Yt7N9GG+R6R5do1HfP0eXzvgZwxu4RJb6DQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eObPRbV2yfSuIcYM4JbkO9QZuk6K88Ia/oSa5f7N6nqXDKi2So9pSh0Pvd+wNBc3P45RMsG18uhQeagw2JYm256cee4Rptu5a/lx/7UbpE1gwhhF+mAFsDKt8iTzVJG7QtPkXSwirmnDa7ZnWCc4okTKcFPXHbBTx8wLiRFaeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUOjolB/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUOjolB/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2014431a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573471; x=1787178271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yEiyhIY1Yt7N9GG+R6R5do1HfP0eXzvgZwxu4RJb6DQ=;
        b=iUOjolB/RZ0Wg5LqgnfQoXgG8gLsNsIp9SEFgMXQ6lo4PNlJKZGL5QvNxmWCrAsUz7
         QzIqUMio/GL5l5oq08D8eGZVuOcUthnnaSx5LJuldkxegsV2OwYEjpubFfIViCD9XuSm
         d8kOXSmxyM7kC7/i457DrfKrk4BMA9C/1y/tDX8dR/feYMvLBKVaEcfQmAL5IZGZxUmv
         353JnjiMtSVkxLeOT+CPwelXVriTj73OZN/x/+HCIy5AvGEKoCTaYKS9zFhK4uBPvUPj
         kR16lXuVkpGN4gXLjJDkQUknGAqCuNcRvAccTD2jh+QWMDK2ByvIqu9vLeGwfSRiuJo8
         ni4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573471; x=1787178271;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEiyhIY1Yt7N9GG+R6R5do1HfP0eXzvgZwxu4RJb6DQ=;
        b=BUVT35+DFAOHAWPuMvDdkpXs8oI4ADbV+sNaYbS/IzvmPErFfcD24G8j8vv7sEwjoY
         Ku55fY9hY1sC15W2dsuFsg2fKA9ORVCDQqivzCgTmW3aCIU4fpFFb2TymjYx/27YMn7s
         DuMgATTQEvwm8HSJQu+zTxlFqDo/KBoIKi1e/XwSOJfvYRoWgYuGb5bRTQk6Fr6FpLHg
         5/vAFvVFrDJhLnKFd2WugryfH2VcFfKxK/F739kqRcRZ2xoKaumgyU5uJ/oKKN500/70
         YpkqKu5LC3CEJGnFrgZreP9PiCtN2ijwb1TxddzxRhaPcI4LxLYvpiYvjw2JzXSEHBsB
         lOFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq86V+P5sVRgGMvjwFH7noXvolmF2fzSpJislyUItXxY8srny3FQg0ZdIJVsvJ6CpHbkgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQftt6t7Zl2Jnoj43Sq0ilt6Dc8t+5lP1Fh9M/XiL9WTBUsCI
	S9C/mhGkmOM/+ygD560EjMV48FloO383kPPngKV/6Ren0mmPcbZ0EWRk3L4/MQ==
X-Gm-Gg: AR+sD13tlVNcyqSCDbk3rBGyGHzLKPEHbbmGCYzfIuBK5VKL4w4xFoKV8uF/HfMLwZP
	FlgohFZP2w2DileKpwvZXLxpyfLDTZm8Bvl41ZExYHrVVfwqIWfsCfeO6tvpC8kGax4URjuSjOM
	6CJfUMsqmwkIAAKMziFeVCk3PDbFrEw3IZWBhOilhTPBIdblYON5oZFPFuZLXakE+XHet+opbjh
	yD+woHx4wEYSaeMNknKgz/BRlrmeh1/9z+nt3Uh2U0mQD+WL+B63S8T883H/9Lu4WcrqVKemBy7
	VImDxEDD388+uif2fWNZw9yK9iakxiCCi347+QzaoCOvsT5sfg3rNh7GXsBLXt0rCNQ/hlPnyAT
	r1Im3FllJIcKob2u+Z7f7WDsAuo/Bh+WUod5tBlEwMxfK/yxH1QdjCYwOwUWNK+P2Hj+Q9EIABL
	fiz5DE0gGRv1tiiqT39PTcSuac5xe2Rma+6zhlP7fCmeOoQcBDTBuOk88dr1DhSjgj/jJAJaN/c
	qCKQVnVx5KUKqaQ
X-Received: by 2002:a17:90b:1d4e:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3931de3131dmr1818456a91.0.1786573471440;
        Wed, 12 Aug 2026 15:24:31 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931db44aabsm254398a91.2.2026.08.12.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:24:30 -0700 (PDT)
Message-ID: <2dba3a4228d2d19e8865421d564bdc687d801c1d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/13] bpf: Reject register-pair returns
 when the subprog BTF is unreliable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 15:24:27 -0700
In-Reply-To: <20260811000952.2382568-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000952.2382568-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> The R0:R2 return convention is derived from the BTF function prototype:
> bpf_compute_subprog_ret_regs() inspects the return type of every
> subprogram and records whether its value comes back in a register pair.
>=20
> btf_check_subprog_call() can decide, at a call site, that this BTF is
> not to be trusted and mark the subprogram unreliable, which happens when
> compiler optimizations remove arguments from a static function or when a
> mismatched type is passed to a global one. From that point on the
> verifier falls back to conservative, R0-only, semantics for the
> subprogram, while the compiled code keeps returning a pair and leaves
> the upper half in R2 behind the verifier's back.
>=20
> Rather than silently mistracking R2, reject a return value larger than
> 8 bytes as soon as the prototype it was derived from becomes unreliable.
> Add subprog_ret_pair_unreliable() and test it at the two places that can
> observe the flag: check_func_call(), for the call itself, and
> prepare_func_exit(), for the return from an inlined static subprogram.
>=20
> Note that the main program needs no such check: a >8 byte return from
> subprog 0 is rejected at BPF_EXIT regardless of whether its BTF is
> reliable. Callbacks need none either: a callback address only becomes a
> PTR_TO_FUNC through check_ld_imm(), which already rejects any callback
> returning more than 8 bytes.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

I think this is a good example on why r0:r2 has to be inferred from
register liveness. The user has not real control over reliability of
BTF for static functions. Hence, this limitation might be quite
inconvenient in practice.

Another option is to assume that static subprograms always return two
registers. Then if for some of them static liveness analysis shows
that second register is never used -- skip the register move in jit.
This latter option seem appealing to me, as it appears to simplify
the patch-set.

...
