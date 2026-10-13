Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4623C7DEB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882250; cv=none; b=jYqPVITpoS5COxDnrte8ny+GesdNXu/O5TgBwfG5moeJqKVle352yHR9bt452TrBECyi/VuZ+Ty1wHclyjpUv9+Uy1QXJW8MBps8Bdaxsx/QplB12/gG4EfEMXDlarixXzVxHsaQtAhiFxYm2O5hwLv0tVVeyfDGmJIz8zkUfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882250; c=relaxed/simple;
	bh=g1p+zAy1iZ6RT9ZlpLSHr9kEl3rWZ14LW8FY8NILhg0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=D2dH8xrroUnHiuYbAiFSXvahE4ZLAsCEhlt3u+yYR7uguUzgTyhdL3gdJdaw881aFpJ06ufsEbTM3hB4QRCcBaOjGkf4dSu9pCDPsLs61swfOnUIQDFohDCBVzFhLoMnN8ibKr2XksXE1QSVb66XOHnqkRX2jv4UWrqFv3qT8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REEovAlg; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REEovAlg"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6dd3bb640bcso130791eaf.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882248; x=1792487048; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjprIaDEn9HW0P0dRvXW2ikq7vmQoIq2YgOT0FGdOqs=;
        b=REEovAlgwfAJ/dqoGsPQ7OAGT6y9MArabb8HZJie0ptORy2Kq9wi0en7OnUsorRq+I
         3QU7vwPSZxZ3gVqXvPtrpaBgdJp9iQV4JneNvAgEa09M448kRwGpTNHBNpxCX2nxij0o
         1kp5N3CXnaFknOlI9VYzEu3aCDGP51PrvkaXtcKMLbWY4I0x9jb+MPj060ZbgoP9QD8M
         us2gN7rB6+GoSjOpaKMfHbi4k2d2Lx7q7ThJk/E3g9647/X+3MziufP9UYnOsDaTA5RY
         rwGUGm7e7PgOdrOIpv25eNY0XQ7Y7ZyCtj6D0qsiaH+1MjxLo2SJfmaV3piX7CorFYL5
         /JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882248; x=1792487048;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjprIaDEn9HW0P0dRvXW2ikq7vmQoIq2YgOT0FGdOqs=;
        b=ALWJ11YNgrki7n7gq2/XFxO/xcPFU5+f6PpH9GiBBcotXRs26jzI+MVggRKy1GWTR2
         gGm3fVd5l5xW/67TKVHF/3IJV5ORSv7j/XJSfD20siNH2TmGAF71mYR6tXuAsnDWhaEp
         +0GW1qod1boOOmgnPVzC0P+yd97ctxVmyGKcCVUQGd+jjmZ5UNks9kVJAWOfmtXaVMCt
         Qyj0x6PVR19kWJYSKJZQNstx0Vnli1O5zzgtYo8yT1joEg7O3kV01A5x/V21F1yW+U6K
         EQ0ZAEHwEBDG5ZpHrfSNCdWAz9zXzIDv/bZNCe3nCtyOsYwxWWGKSn3WB2POx13ZXil5
         HhtA==
X-Forwarded-Encrypted: i=1; AKwUvBywgEfnNOqqR6QIVnBWY07uWBM/uiSAD05aA/3NIhgvf1tw9ZbqXA/XYIwhHhxnsUmRSy0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfrnb72MOWZ/d8rFqOnBdNiJQVUaHt5JfiqFGM9fXHdV6oJlLg
	rHMwENeASC15EU5SJI2XaqTL6AhiNVR1sav8SON6RTytEylPAW5yMTGKiklPUUdJAZA=
X-Gm-Gg: AYBFou0QukBQaAxmYujWuoEnKqcVUKD7Vp/yCB2EDDfmUTI6y5o/UuXRVN5jb8OViHo
	yZ1/+uSXuNlinxmQM+vv7GELP5+6/052sE4ygxued0A3NpFgP0o64cyyI9nfWGJ0Ml/K7+AODWR
	G3YmhPAJTnjzV/SJcyrG5+LBiv+uxekaRDtosWjWJnkQ4MDNsCUittjolDtAUd+ciQqYgsYsaGc
	ZlEbdZFnDTUIFguVl2Ogz0epbGWdLditj7Gh1N3XfWUiNV1mU2ueRyyOzoW7O6WbrLcaR8E15Qy
	Oog0pbx8hxE1Rxe8f5F0FE8NbTAOVTkhmML5f8xJFah4OluwXXyshRpZPreQZAli+ULOfgBisi1
	u845MpYq/7Jz/iCP3RTUDgxGpIA+qkul43XO2q8Lqnl6kUUbm5FempqO0tVK2EY59Njl/LhFGG1
	ZeYnk7jH08LPFslzwn2EXlDtV5zbc9VAI9XBL5QRE9xJ7KGw20MXdWOkuK4YaGelBtG2dGEaKX9
	OErzmpdtOeXTGkHVBrna/8/6uWbPO39wh9tZATPtqGzWiTlGpvG2GW1CU8FtqJiC7gQ4C66Jv95
	WPPxPg==
X-Received: by 2002:a05:6820:6ae2:b0:6df:d73a:1265 with SMTP id 006d021491bc7-6ef10b787efmr6358863eaf.44.1791882248016;
        Tue, 13 Oct 2026 02:04:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f4a1303572sm5938802eaf.12.2026.10.13.02.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 11:04:04 +0200
Message-Id: <DM3L8R7ZAIZ9.178PBQ9677C6C@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 05/13] bpf: Turn loads of __arena pointer
 members into arena pointers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261013082012.1107446-1-memxor@gmail.com>
 <20261013082012.1107446-6-memxor@gmail.com>
 <sashiko-outbox-169266@kernel.org>
In-Reply-To: <sashiko-outbox-169266@kernel.org>

On Tue Oct 13, 2026 at 10:40 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: PROBE_MEM fault bypass via non-nullable __arena pointers
> --
>
> commit fdb573c7b91be34110bf569fb46f6159ad42b9b8
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Turn loads of __arena pointer members into arena pointers
>
> This commit translates the loads of __arena tagged pointer members in
> kernel structs into arena pointers during verification. If the member
> is also tagged as __nullable, a NULL test is kept before subtracting
> the arena base address.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index b2fa7e8bedf3a..3c95b6c8bbbc5 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>> @@ -870,6 +870,36 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ve=
rifier_env *env,
>>   *     struct __sk_buff    -> struct sk_buff
>>   *     struct bpf_sock_ops -> struct sock
>>   */
>> +/*
>> + * A load through an __arena pointer member of a kernel struct reads th=
e kernel
>> + * address of arena memory. Append the conversion to the arena pointer =
form,
> [ ... ]
>> +static int arena_member_fixup(struct bpf_verifier_env *env, int idx, st=
ruct bpf_insn *insn,
>> +			      struct bpf_insn *buf)
>> +{
>> +	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[idx];
>> +	int cnt =3D 0;
>> +	u32 base;
>> +
>> +	if (!aux->arena_member)
>> +		return 0;
>> +	if (aux->non_arena_load) {
>> +		verbose(env, "an insn loads an arena pointer member on one path and s=
omething else on another\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	base =3D bpf_arena_get_kern_vm_start(env->prog->aux->arena);
>> +	buf[cnt++] =3D *insn;
>> +	if (aux->arena_member_nullable)
>> +		buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
>> +	buf[cnt++] =3D BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);
>
> [Severity: High]
> Could this allow a bypass of the PROBE_MEM zeroing mechanism when a fault
> occurs on a non-nullable arena pointer?
>
> If a PROBE_MEM read of a non-nullable __arena pointer faults, the excepti=
on
> handler zeroes the destination register and resumes execution at the next
> instruction. Because the pointer lacks __nullable, the zero-check branch
> is omitted and the BPF_SUB instruction executes unconditionally.
>
> This executes on the zeroed register, changing its value to -(u32)base.
> Since base (kern_vm_start) is page-aligned but shifted by GUARD_SZ / 2 (3=
2KB),
> the truncated 32-bit offset calculates to 4GB - (base % 4GB). This
> consistently points to the next 4GB-aligned address in the kernel.
>
> Because base % 4GB is at least 32KB, this mathematically guarantees the
> address falls strictly within the 4GB valid, user-mapped bounds of the ar=
ena.
> Could an attacker map this arena offset, populate it with a malicious
> payload, and spoof the BPF program into using attacker-controlled data?
>

Valid, fixed and added a small test case.

>> +	return cnt;
>> +}
>> +


