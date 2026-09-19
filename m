Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409232DCF45
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796698; cv=pass; b=dcAeR///6O1JkGNhWU5wwo8fgPjtKJbS7Kpn2i9zHXcMWcbfspQBJCZuW6LzGcCA/6u+hf+R0ySlcTtiV+5Y44+IZcFgUI8CTQJQ6dJJwYN9VgSPiL1v0DXFwtYEDMz/6J9lkGVkHKfaIZTlFmg+jMzHKrU26pFp26RhPL2NkHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796698; c=relaxed/simple;
	bh=ic3wmoCCnpNHkoLUgFgDCvLUOEG/SacGXw7TtvYdhsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m22FS7P3Wsumj59fWfdWolnfKf8F2fYBgrVIdapVt+ZjiWHNSfk0cabi9hYENYFN7a7zwrjB3bTb5tyHvtusG8B2n0PuB7XvQUNberVPP/YsZsClYR74sxIkG2SlhrGOY1oh1jXv9Fc81CKKTHTcAgtbZZlFTFgSFsEmsnqE3VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrhRXREe; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrhRXREe"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85a4329731cso1165429b3a.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 22:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789796696; cv=none;
        d=google.com; s=arc-20260327;
        b=C5uoCRC6VcQxmlEoxGshPrZHlJOJCXLhszxbWZZea8jic2fSUHGulstUlCXNz2xDck
         dz+7IwUSJ/hWnwUz9U81b1fXaCo8fKYcjU47b3+ZIiYWIel74v8ZPylF14ehq779vwwR
         UvU9eD/R1l07FLgdGw1TrNBGUNrJEn9KRm37LLrf7X/WCgcNULO/7B4ul5e5ZwttVBOk
         r7ckD8ZJYbaKOytLhh5QWyFnfN9khDA0QJP8GV8bNJnyroj4Vg6w4yjJ4V+Lxpwm62Lk
         Am4E7AoqVEj5nCCvmC/AcSice1N36AUYqXKTabIKMfvP/8GdvnL/U7W8PYhe9KjWbI1J
         L9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TTSICFICYYV90/lo5t2/z441tnwq8yhovKqA2AQy4hU=;
        fh=EvoHFlDgCMxEP3ME7AEQ6Dl3bLccAjezN9teA2aJKdc=;
        b=aOlrMs/zrO8ciqYWXjzKk10HLQf0ySrSzO3PIn0rN6t2gN8VEyN/crIFUuiQXRNvUD
         TGva18NALUOWzVMTE2FYLiRh+m4Fsisdzg8pXhwLv8Y/21rxoRKoBgoOCIyP8pqQCy0G
         GQFvwqAThUel9Low0M2KGhQKoTeo6jxJfUPgcOZ8qUj8C3i3Ccqf7SvC6pTOFbyT+qtS
         4uat1on73ptcxKZR710OvoLFr/CxupxelgrboUp6lIXSHIzWGDo2ZIHF/h1i/XbAm53h
         yunbZf00eZWCgYoyaS+2SkE6LPSJRVeh72qQHuvEjIOEk0uTtfhVVi+TK7V6D4lKNfHE
         MRAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789796696; x=1790401496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TTSICFICYYV90/lo5t2/z441tnwq8yhovKqA2AQy4hU=;
        b=YrhRXREeDT9dZCfWnWKh5Dr2aeDu3z5NfuZKHZxj1/pCr+wREYUR54A2gyFcXwecVZ
         hgVZR8liJiZWw6F0Vhz1IQ6xT6x6i/zRi/g8/4KdER5WqZlcaeBsHrC4Jfhv6kzlnJ5s
         CtFPF+1+1UCfAZRTyLOx4WryZgIdAnz6AgVa2aGbLxTefF0AiS0G4GrvYDrpl/Psxi8f
         31Y7PCAo1npA7zBd+s1VpfQDjxYbT5lBtVGQdkXLzzwK1hSLrtyeijtwZY6Y7pbRft0X
         yJl+/8WwfPGv08V5wZqp28hKgdjMJpRkiQJSeSdoKhGlzFfxVTX6SzK6D/4AFq+Z6M2/
         XMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789796696; x=1790401496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTSICFICYYV90/lo5t2/z441tnwq8yhovKqA2AQy4hU=;
        b=L3yC31w1JnygeO8eoRQHKctmQmfcE378y/SQHwr6GITgTjPIplvHHYX8Lc5uzoVIHl
         IzqgJOhFdxjrB/FRM5O2S+g9t2frQS7N9Sd3/zBowsie0pUfYeDHfetAzqPuaNunfmWB
         HwWbVZnt8wAfr8JSyIzafhx1W91CmB+S6NU1OMoIZo297+tKvdBLK+tzZ0Ray857GWqS
         +doN+5nubNGjVSasLy1m+CDsdBtkj3PLK8sh2VIhrs3kyQoSA5k/jcu/7HPzqXKigflP
         2RPtIMurnTtQc4+W6iPs9m/qhzR3FOYNnDV3GdvQ/tQJK3tAEwLCBqYEQ0D+lA/41Tj3
         MITg==
X-Forwarded-Encrypted: i=1; AKwUvBz0IqF9cOfHbuounIngZ0mzFBbC/+BxobSjJmv/TMINF2wuaZp/BI0ncBO3QxN57RURBt0=@vger.kernel.org
X-Gm-Message-State: AFuF++ntob90KKa2+L2syy3qJJm4wAR3YU7mh4kPWI+zkSly/wo8am9D
	wY7aRFwgLU23GaE6Bn2Dfjvw84XAiA+nmyx+v19mvB/I7wVoUumGBp13XNQITirvF6wsVKuqmxI
	e2XXBHOqTT3ZbIoP5bnxVxgGFgXnE/Js=
X-Gm-Gg: AYBFou05qtkYe8LbqM9uFANGKaHYdLX72R9WFfONNVdkwmK8qTaLm66cqtQGp7jvTJj
	HLbUIjikwq0p+tkoTzanyNTpCpnKQnNTRqPtCowuJZYK6Ml4lKy1puVxSNkUz6MbGg3EWlwksO+
	GYLSmzFZRKRcjJcVZMLx223srePCu1KSI0MycmHdg4+N1EKfTd5DUGlpLRi7ZNDDgD9i62YmiDK
	N/8gkvUcecr9wfEtDTmoN0KtA12d9dnWqslYvyxm99AUgWXbXDvZ+HG5CVHKci4jKbgJKw/mPnA
	QZnWklggG14b3rq5ALG9EnjOKYUbbofeN4cC7WerIOXLShNwvcTc8hCDI8nMUttnV8anZxewshk
	DmfllEf/HRvY3g8Hnjhh0kwD39I1pmMLGTgd0DI6PtqOIK1T2/t015xNvmsoX25WZaRv3fT98sQ
	==
X-Received: by 2002:a05:6a20:3d8d:b0:3da:6bdd:2308 with SMTP id
 adf61e73a8af0-3dd8c4ff25dmr8514188637.18.1789796696494; Fri, 18 Sep 2026
 22:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915021338.1520964-1-main.kalliope@gmail.com> <20260915021338.1520964-2-main.kalliope@gmail.com>
In-Reply-To: <20260915021338.1520964-2-main.kalliope@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 Sep 2026 22:44:44 -0700
X-Gm-Features: AcwNN1Vh-GA3y-jQOYzFbcyt-JLyUr5-tYXcOs23bIU7VIPtAK935mc0-3bwOM8
Message-ID: <CAADnVQK7PqU+VXgZFOLqDSs8m0-DXWmm5+_Lg4gddrwdvd3N0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf, x86: Add support for BPF_MOVSX in the
 i386 JIT
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Wang YanQing <udknight@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:14=E2=80=AFPM Nicholas Dudar <main.kalliope@gmail=
.com> wrote:
>
> The i386 JIT lowers register BPF_MOVSX as an ordinary move because
> do_jit() does not inspect insn->off. The generated code therefore copies
> the source instead of sign-extending the selected low bits. Context-acces=
s
> conversion can also introduce MOVSX while lowering signed loads, so
> rejecting BPF_MEMSX does not protect those paths.
>
> Stage the source low word in EAX and use the native byte and word
> sign-extension instructions. Derive the high word from the sign bit for
> ALU64 and retain verifier-managed zero extension for ALU32.
>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp32.c | 51 +++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c

I don't think anyone cares to spend their time or their tokens on the
dead platform.

pw-bot: cr
