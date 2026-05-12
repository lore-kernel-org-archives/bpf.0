Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28E368D42
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614036; cv=pass; b=mOH53v5XA0ZyfdCZeyc4Ox5lEL/Z1XK+rzp+P7HqjvODlTmRwIpzEM9rszlfp/ZAUSIGjLU16SaCVoLVPHguALRPJDX+yoQwcI/eZgfldCyr+l5HsDXVL/Yw4RBJa1TZNXoaUYO43RCKzZHwQNtabmpaDd57YOcZ3L7sNZ/xXyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614036; c=relaxed/simple;
	bh=QQzyFvehisNQbIcMvVSJU+1EurO5BpZKIZMWk7KTRzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f50Cx+TAfcfhI6tyVTOb5BFdLTF8vmk4hFhIR5w8rZ5ecpihG+ivF7c/gh3iisGwE0Vywd8lT9g0n8Vd+zTqFbpeJ+76NtOPt8vbzi5MYwOcn7NGeiAP9E+GHE4VIbr2T1mSEcJSKsWr++JEg52blubJX3IGp1v34r9RJmWN/2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6tuKFkP; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6tuKFkP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso4724424f8f.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614033; cv=none;
        d=google.com; s=arc-20240605;
        b=Dcmvzb2eRpolI64T2DgKaxuhCaVMA11Z3qQPKvkiS1b8turQBHEutdDcURBIWCpihO
         tdTBUkPwp7V3s3DPC5+FhGzm4UriN6VdAmc/3y2xEc6KS6bDls+au1+tNmOuGxxNSUqv
         7YEpEh5MFO42usbaOZ6B8+dbRw3lmEZcsExoCgnmShFPgO6R5z9r+xRpEADjaYlsdF73
         ViQ2+Sa1Rf4mucp0wNgrC+f7Z5sdUZeEwNFIQdvPAtbnDV4pa3JURqBT2/Ng8/e36lEC
         cNO6DpxodU4hpYP/WiMxjuBCtT8zRQZU4ydGPXmliC6ageYpeZ2xRTbotWdJI5vu3cC7
         5XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        fh=BC90mOdX4ziGkJmpd4F0l42/1t2lchIC667pHnSS038=;
        b=O4puLNlrsNXibk/isvgGBlffb4Z2UQOyAJqVBBMHmv5cKWRur+ZMaN7Qjcj3M6OOvH
         T1WvyRwcrzUKhBJMoFVDzydlzsGMdI70c1YTe69Ys+Le9YF/eMCW+ENvsY8D2qpTu2ul
         aqkQWkm76zs4gWw8t+suqFLnGtbXI9BEcjtWfIUK9MWQyP+kd/ptfjEYC4h0JGiEJuiF
         us1wR9Vv7oANpjh71MCq3RTkTGpPAXdFZccX5WVbkML+e3Ee7HfW2b7A1d1iQUvOUpa0
         iw+DbAG+Y9FBJ6yj63loDLu021hSTAG6LGP0XkEehcqELfIUCFIykyrLWAkTWN+4MhWG
         WKmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614033; x=1779218833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        b=F6tuKFkPFTP7R2bGH09y8K6A1uj+K84HxmsLVdqRDc2xutu7c6CxUYa3gplibqBVdt
         m8qEZfCYbI2Zt1CutLOLVo89Zqf7gqlIkDe7VVMC84NeqetuT/1RdFs34slDHbMdHrDT
         oY2UJkOuqb7myenFiGoRaiIffHD531NZtDGXUVeZWn3j8FfBw6BPi3IBxafvUkVwsjHb
         +PmhxFDA/HZotRRFbgSvlrrwYEs7+DOGPrcgcIpJBFGF8XqWI9auV3ClwUAQBpuFHEHv
         RaqWT3Je49ieHhSjGyAupa5Crhg6Q3DCTv6vkcfjUIDVcOJxNWs/r3Fh9WrVkoOTrUKA
         hilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614033; x=1779218833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        b=bjrgw5Jqo3MDheugzW3ER9Tax2kc5x2fSQpFhbYN6iC66wGVLFtYifiIxlNxkJ7Ri3
         JsYJqHmHvDNQlhlgdkg4yMTGfQMEE9WBHfMqrdPhD6uuielGpsFHRk+VTxJMTIHTC7GK
         X6z/VVuu8DTIcEtYMQAtMGk/+Zxh788ksR7beQcvmpZ4YWyajYFNnERsIg2xmj4eGZyR
         b5I9vMEEww4iIpxvimeqdGnw/vqk2nI/NBXB1D55Nf//QPXza9U1Ir7+JoUhc31UeE5G
         T6o7vdplCi8Sk45I1lycHGErmPrqzfyumVinXydtMEYhnqT0ZCpWxCBj6Fcf9yRwUBnl
         r6cA==
X-Forwarded-Encrypted: i=1; AFNElJ/SOeV+vw76UsdtQxffNHdkcIvDhC7COXpjOsi1bCKyyAuT46LYr5HrutZGR5EqVHjeSGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5R2oYDHTPDBGr5lRT27xWdGf5LSw3rXvxVJLvr3Gag73xqJHV
	fSjlSDn2xu2zDMIixzFH5oKyMAsxwBbXBKeLMlGd8z5hKwwHC0twJ53gxJ07vfEE/iSnxMLwsYP
	OvyUOVgtMsOmUd3r25YmDFkBBnrvoMtE=
X-Gm-Gg: Acq92OEyPxOmPX4Stq2NQ3pYDsiidtC5GefC8LGs+s+vblXjzfQiWsvguN7AkRnR7Ws
	15+n+74FzAxfVMuAOXKEsN3kNpsCMCM3bfqYTGGE0O654BXTv/khk3MwjQZiRZHsIoirVB5jHLl
	s6TJCrIcPZtkpJddssWXiaR4SdOxERzgbPTUwgEa0iWLuHsQrCUwz7nxxg+ME9vYLFySeGaeoPb
	3EUkZKA0CJj6W4GjAviXv6MacLPn6Z6o3cqV0oWtXuEdqGLJMiriewem4gYbPWPjoRsVYfvghaz
	dXXxVaqquegrp/EXn7btNG7ShIvDeaa6KgAWJjRNAuUeeZtqzRcBCHSzRxQUvS6pFFK7cAzEeqw
	piFKaKYQW5mgIpugB99DZc262pg==
X-Received: by 2002:a05:6000:2289:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-45c5859f1famr188352f8f.4.1778614033288; Tue, 12 May 2026
 12:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org> <agNeEzjiThzmJHiP@krava>
In-Reply-To: <agNeEzjiThzmJHiP@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 May 2026 12:27:00 -0700
X-Gm-Features: AVHnY4K4JaNMU6u0L4AjaCC23qpKLbG-yzy8GmglAF8f-r01jNkXpfSztamVT3o
Message-ID: <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> +       /*
> +        * We have nop10 (with first byte overwritten to int3),
> +        * change it to:
> +        *   lea 0x80(%rsp), %rsp
> +        *   call tramp
> +        *
> +        * The first lea instruction skips the stack redzone so the call
> +        * instruction can safely push return address on stack.
> +        */

typo: lea -128(%rsp), %rsp

you can also do:

add $-128, %rsp + call tramp =3D 4 + 5 =3D 9 bytes instead of 10.

Initially I didn't like this approach, since we just introduced
usdt nop5 and now need to recompile everything again,
but looking at the fix it's definitely simpler than alternatives
and doesn't have annoying limitations.
