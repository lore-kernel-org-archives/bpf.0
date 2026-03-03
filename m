Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D114EC73
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500124; cv=pass; b=rqLxRvoOP44Fk7/R9N2NKvcOKJQKJArp/pcIjFHw7baJGrkpLojoaFcOyDWg8wVDzxvSAGyFr1N8SGjkLK+C1nEr7i4hgKHj27e7X9U+OpGJqS1yxuHZQ1QF04GwFfE8xB9eCyeAXxJnwSHptt3NmsgLVHaI5gXAr3Vcsxj3tjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500124; c=relaxed/simple;
	bh=P8Y/lNipLQAIIWt0fc7XEsRhAEz8FCzcUHMhZhHtRms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DARhgmqNOGlHBEzWqAph4C2QtFYPgxRkw0lv8BP+lGxu7o+Wb93NaQOVfIQVdBgm8LKg6m2v1om4EZVu5QRJa1Dg7KKgIRtoBi2b4IQI6afQVexx4oDU1+lqVv8cCetw1jshWvVZKjsPfIwRBHf2NWK/tSqBlPjnjjeC6XTjkeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnIc3EjS; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnIc3EjS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so3940855f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 17:08:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772500122; cv=none;
        d=google.com; s=arc-20240605;
        b=Nh/4hBFcS3bficr1OyGErZkR1GQXY8yGJcL4sypz7sxIqtyWA3zVUlNFZ2k+AzzA4K
         /4WWKxoGoxF5qLeqMkTdWefStRvo9HOIzryj1xpserfXEZYJ3nUEPa/Xn6E59R/mZWnm
         QaCfJwiqoaHHwoW+piioU7ve0nL3CdQ9/YMN06bL4YB6SoMF1u1nQCSIlEGQm/xwgVft
         SpWqT8WqcZv6k6ucRv21X+OPLtShiVYBMjS37KRt+UGKGPSMgo3qXlY4c7GU6v2crt2+
         XKq69g+OlE78D+L7s+0Vg+G5/WNmtVShBPps7Dol2oESa/HU2R/Z2/QKhGE1lQKnoh9g
         KLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQcEAnCJTCuZC9xdY4TQkZIwdFumVGRmT4y2WjWo/wk=;
        fh=bNXofttmHoHLv8AJlIBNaCmPBDL9JEXWu+JT7UcahcA=;
        b=ZrKg6ljjJbpAvBtFFWvlk76xMwDIt8D8wQyHsyhCyc84rcJUD2rYvQjbwett6spmZ2
         LqSoquRCeKavuBLmT8XAUpnLNE6/HmWaBYbZ/Sr5huFR35iJTY7wnL4Oz6H3rLlOtPPt
         xtvFx8e+GOB1Gu2AnRJ1Gytd5PE9lMUOUBElUvnwaDKceYhLzXPt2vQBkU/uGpGqKiOb
         SxG4iTaAtMNytxwIJ9JaPb/IBJiqmn9AeZeIS1KxlU7vRARrgEXLvKa6HKaSuCLwczWj
         uv/pBNEn4+WZ6b5/SpCq2Oq6orNaKg+0KXQRCqF+5bzY58NOiZIT0lqLIiiFIozRzq1s
         o+mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500122; x=1773104922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQcEAnCJTCuZC9xdY4TQkZIwdFumVGRmT4y2WjWo/wk=;
        b=KnIc3EjSc8FbZmaNWefk3kFhFkTJhsdw66ApuzSgGqicJ95zWyyyJVxsk5yTuxUT8J
         BT0n8tMKyYNl0lyuVjHWoQSDVidO4lcz12nKB0OCKnoyVE040l7Ocbnq6flBsuLhBxV5
         BRzUtLT4X5zTZwcMk8QyMxo0ZcRS1SlpgxHLg2O6/hJOrALzfrS5O1mnTdt07xwIZfOr
         Ib3B+S55P/0plE6Z89zhT6FiwKAsgbviH2RazcBmiFdNQsMzYIG9em/F5WcTZOXTxvM2
         KOxdBr1CAazOXmu5wQdWqXiSz64fKKn/N0PXFfaHgO7hCGYdKTuxE0DDWPPB57/Kus7e
         xWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500122; x=1773104922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQcEAnCJTCuZC9xdY4TQkZIwdFumVGRmT4y2WjWo/wk=;
        b=K4gpeRUPF0Kx4FT/vMLWctyecEnzHAT7AbZ4rArucTbOqJIWcTUoTUCH0RITzeH6jE
         MyzXeQ+LVsGbiGhzfC0TQr/XJRlHUVFmZpJPXk5QHsXAj+UMGVn8LUYovKm95pOoJqMF
         sAHxj0lo/GZnhiipVcywgA8y/x61/i5Os8j/EQEx+jQ/MqwMCyXJIwGJN0JEr2Nrj5ri
         G9DOZTAwG6Kq0iZxhcI7ZbVi3jycR/++qIiMETox05OcSebVWUMPblcWci5RtId4hsmi
         Ke5k1KhMEuqstNIXRH9uQG4IzVMmIi/EhKXg8UrdFxgLDSgtdXGH4sVpliaF7Z3yRtQ5
         av9A==
X-Forwarded-Encrypted: i=1; AJvYcCWdSBcppbZ1gryJ+xWUmo3VrnSyHh8EbdNZ5HZSLfJlnsxz7nRI9i2EYnGaFbNA1SWn9zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1Q6xGn+998uKsFPu+9tqTqVSWXWcj0prBue51kGLmKl5ZVTx
	N8ghZeUWDCqI2cYxHDZgyEAntvlclJl2kmF59eE2r9l2X7+sOJqAfaVYR9F9orhCDiRKR873jXN
	moPjT2HClTEs9WUBN9vGSuXeDWXwlfSs8mNpt
X-Gm-Gg: ATEYQzyO2bpXy2BaZsfhyvcjA4hlz/5omdp1kt/8SNVL3jNWlpUknWs8hUrN5qJsxHP
	B5nVPGDkSi1EUctU57dIG8Fk8phAs9GtW3tBppmpklvrr+HgbS+XU4BHS9jf/Zoepi7qNDuLU+X
	23bpUvbVsBPJW0uluht1bwkZdJphxjoIjcuX9nMRBd4u1KE3oJ+OeEdLzH1fmL6SvH14WeExpBV
	XFnmPhq1iX6Mz4LUBO0h+29JlTcKi2t/ZGGC7gjCdJqTvbF3QWvzCF8gkHmcfiXrBau1FcBVl3u
	kU7iymM7DcIP0IAK49txIrUgT9aBGS3JW4mEKNpm1GF38MCBJCCAV/hNPTcgosZg6bYGPvKq0ZF
	n3GSGcqxrZMZhJHnJqlngdlKKhw==
X-Received: by 2002:a05:6000:4305:b0:439:bcdb:95af with SMTP id
 ffacd0b85a97d-439bcdba1f4mr6014095f8f.0.1772500121578; Mon, 02 Mar 2026
 17:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com>
In-Reply-To: <AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 17:08:30 -0800
X-Gm-Features: AaiRm50cqBjpYdrSlzEm1rs4EQ82OA69oTfUJPkX6IA3CotyPEWt9FkRmNZWJRM
Message-ID: <CAADnVQJQhOkyPxFSrr_qoyDZUYdaT88g2xZa5+0UCvV4Ufb79w@mail.gmail.com>
Subject: Re: PROBLEM: verifier.c - invalid scalar IDs after byte swaps
To: Guillaume Laporte <glapt.pro@outlook.com>, Tianci Cao <ziye@zju.edu.cn>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>
Cc: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tianci,

please take a look.

On Mon, Mar 2, 2026 at 10:11=E2=80=AFAM Guillaume Laporte <glapt.pro@outloo=
k.com> wrote:
>
> Hi BPF maintainers,
>
> I believe there is a verifier bug that manifests when a program performs =
a
> byte-swap (BPF_ALU | BPF_END | BPF_TO_BE) on a value that was previously =
copied
> elsewhere. In such a scenario, the verifier can incorrectly assume the tw=
o
> values are the same (share the same ID), and can then narrow the value of=
 the
> untouched copy in a way that does not make sense after the byte-swap.
>
> I can reliably reproduce the issue starting with commit 9d21199 "bpf: Add
> bitwise tracking for BPF_END", so only the 7.0 release candidates seem to=
 be
> affected; not kernel 6.19.
>
> Below is a minimal reproducer program that demonstrates the issue:
>
> struct bpf_insn prog[] =3D {
>     /* call bpf_ktime_get_ns */
>     { .code =3D BPF_JMP | BPF_CALL,
>       .imm =3D BPF_FUNC_ktime_get_ns },
>
>     /* r1 =3D r0 */
>     { .code =3D BPF_ALU64 | BPF_MOV | BPF_X,
>       .dst_reg =3D BPF_REG_1, .src_reg =3D BPF_REG_0 },
>
>     /* r0 =3D be16 r0 <- the bug is triggered here */
>     { .code =3D BPF_ALU | BPF_END | BPF_TO_BE,
>       .dst_reg =3D BPF_REG_0, .imm =3D 16 },
>
>     /* if r0 !=3D 0x1 goto pc+0 */
>     { .code =3D BPF_JMP | BPF_JNE | BPF_K,
>       .dst_reg =3D BPF_REG_0, .imm =3D 1, .off =3D 0 },
>
>     /* exit */
>     { .code =3D BPF_JMP | BPF_EXIT,
>       .imm =3D 0 },
> };
>
> When I load this program (as a BPF_PROG_TYPE_SOCKET_FILTER), the verifier
> appears to keep the original scalar ID for the destination register, whic=
h can
> lead to incorrect verification (R1 is assumed to be 0x1 when its actual v=
alue is
> 0x100). Here is the relevant part of the associated verifier log:
>
> 0: R1=3Dctx() R10=3Dfp0
> 0: (85) call bpf_ktime_get_ns#5       ; R0=3Dscalar()
> 1: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1) R1=3Dscalar=
(id=3D1)
> 2: (dc) r0 =3D be16 r0                  ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))
> 3: (55) if r0 !=3D 0x1 goto pc+0        ; R0=3D1 R1=3D1
> 4: (95) exit
>
> from 3 to 4: R0=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3D=
umax32=3D0xffff,var_off=3D(0x0; 0xffff)) R1=3Dscalar(id=3D1,smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff)) R10=3D=
fp0
> 4: R0=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0=
xffff,var_off=3D(0x0; 0xffff)) R1=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3D=
umax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff)) R10=3Dfp0
> 4: (95) exit
>
> Thank you for your time and for your work on the BPF subsystem.
>
> Best regards,
>
> Guillaume Laporte
