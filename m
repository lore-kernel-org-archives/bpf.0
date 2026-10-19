Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441983;
	b=wjkZsFXW5HBkXI+eXHX8otza8l4HVRvvQ08DZKYCv3gZQA7tmuO8dYMbCpz2q6OnVoj5
	 iLBNryVAH09Hvjp3oXFgzesDvCTikkbr5eaVinG3+CVOoCJMcEKHZMxKPOCWCSY3TdbmM
	 0hmbbTgmARMWggH3W6m0dzZXao/hi4DyN7dF976yBVQxP4IpeNXrSX2iOgJigQ1ZwGC+Y
	 OWWD9s2XtdovVgaGM6WTrFeM859HYbST9W2sGzGDI2MzDGNcwDK9MAuwgPU2v3huGnEqz
	 0x7wThk307l59DIY9t1b+JNkC55FG5+UVJ/zp+fYPO3EJW2R8q3hdBZZPHqbYnwqSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=qVFJ10bshnMMtbuFEBUfSyCytNNOLb/WpfvFWWyEY1s=;
	b=hPhQH+Q0kGqVY3+ixgDrWOPTvzK/4IG7xUbQgn2tOpzPnRtWWpaO990jS/7vOF8l305D
	 riXCFSTNG4z33lfMSaJyqjeHtmXdYGlhMsB7tuzb/2awyp4r5f1JB6XA+ka2pyQESdC9t
	 4IQtArwz21KFrSJ09rkFRa8F9byrO18CqRQn+16ekAM+2/ERRbTiByfZoYtvBp+j5+5WB
	 l34zC2TKjUd8DFrmKEPTT7ADyzPfzxHZi0RdNXRoD+oNFW5Bh6rG/siFfof/rfgm0Ty9a
	 i8ZahSnmSb7qs8N5HKlHkrRe2SEbaRYx+vCFCQPmOPanzT8QlGIZv2GtzhqE/SbU0pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NuDOqCzQ;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D2606A320
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143D2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NuDOqCzQ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e7e742a2c7so464045ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441982; x=1793046782; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qVFJ10bshnMMtbuFEBUfSyCytNNOLb/WpfvFWWyEY1s=;
        b=NuDOqCzQLRks/4SyqpG8bObFKwc3gh0FXt3z0VdFZFWLb+7p5ZEgR/tA4C5Gp1o/Ey
         IrtDEhnbheTe2IxTaUZUr9BsD06x6tubiUDJbVl4X9BAyYyiKnklN/Yt3Hbeot56aaQV
         xhnA92AePKlBCEUAYwOuPqA/F3CYANlarGNCK3dGIL4CeblYKQTfqN+QiYCuI8w2AKkt
         4havOST9yOFXzV+F7yIQ1meiUlqHk/y8Pyekxnner+X+OEo9WK4Jb21sf243fzMfUnMe
         8MvZ/sbxswo8qx3hH+VkEX0j5q9QHjf5KvvcByyWpWX6+u2tfx+y0DFOy/YZ7opStKBv
         rrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441982; x=1793046782;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVFJ10bshnMMtbuFEBUfSyCytNNOLb/WpfvFWWyEY1s=;
        b=FNy/F3zGKdudGFXE2HukTJqnFZAHRIU+F5v+8TdAfnkAUEVNFpcsxO+N7Vsk+5xypi
         41hIFCtFgzZCcBwy9i+9PlagAta31ylx3FBZvspj7s6W/yB2cwnpAPPFsbQL/qtKTt9F
         jjphEPo87W5rGSdtLR8fjO3HHeZWvjiulRbahnB/aNAeNhDzKIIds6AxkNzG/TMdpsLW
         R/jvCIaGBUzjJ7lHs327dvQNka37DuH/haXzSFiig48cZ9ekk+0GoIDur9/4It2ok3D/
         0pQlhagF0AwXzQX2cQlEQRsAr4GyMUbQThDdR+U4EKUNHN1Wa3WuPf14s+a/pmJ31iGD
         UNvA==
X-Forwarded-Encrypted: i=1; AKwUvBxeKwCq9fBaSSZyBFegQwCw+kdqk0UKs32Yrrd8eq0xmX484JQt4h1rB9Y+zDf81bDr8H8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYW1EosaX0jausTxKqCVAhb52eVTkWdlUMIvhUZXk6oAMegbsb
	ovkeITkpj5vECKs1ZuifcGPfJu/WlFhIpIM/i2JdZ65lk/5fMoALewFuaG45sQ==
X-Gm-Gg: AYBFou0cDfcVuwKvWy+u57hfDDEwsFaI8zclwruTT3p4j0XlfJR1hjin6asUfq8OG7V
	tSjs1bnXxzbBEe9ezYRQu6d2DvjkmAXhH3kK9Y+KJzofsO1SY93JLDCDzVo14RQsQhgRzCgx6Jo
	of1NiFZ/RPsbxrZsnZ1PIahxpeH2NyjlByxjYpHpkFREfwxzhMsRKwTx4spqrLN1I6U3iGC8/xd
	vjXoEc9tHj9oph8BQdSWGPWaNHd+PO2/jHfaAfswuaXhBM2K3WkLBzVfvAi/ExWiz4xLV/75z+l
	rCSHqglid4hkgJd6rgyx8OVHH0AcvOhATE25s9AqjJpxTjIi2psfcubxp216h5dpPq44wjgLoY8
	xDf/5Vzm7DSlS66iTxzaprO/J/LeL1UjSAL2Ci6CifbNFryNrrNG2Zw9N+3KASKGGGLDkC06s4S
	SRxHfxTAaODcgXEZnNo29oqI2BF+5/aFUBzf9dr/ozDBKEvOXfngkhBsJ56MFg3OeVapjbrh4yD
	BnKYXDlZwNfsusY5TJ1+Sf2ceMLF0BekgJ9Ew==
X-Received: by 2002:a17:902:ec88:b0:2e8:130d:4f6f with SMTP id d9443c01a7336-2ea1dace426mr1504985ad.19.1792441982140;
        Mon, 19 Oct 2026 13:33:02 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1502b4f0sm5179025ad.53.2026.10.19.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:33:01 -0700 (PDT)
Message-ID: <a54f8bb126343e4606dbc46f0dfc7c48f6a08c0e.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: Unwinding with unwind_goto and
 unwind_exit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Mon, 19 Oct 2026 13:32:59 -0700
In-Reply-To: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 05:18 +0000, Alexei Starovoitov wrote:

...

> 3. Is there a simpler way?
>=20
> [3] keeps the normal path free of unwind code. llvm emits a table, libbpf
> passes it to the kernel, bpf_unwind() walks the stack and rewrites return
> addresses, and the verifier models hidden edges from calls to pads. That'=
s
> 1400 lines in the kernel, with new uapi and two kfuncs, and 440 lines in
> libbpf.
>=20
> Here the edge from a call to its pad is an insn, and so is the other way
> to leave a frame [4]:
>=20
>   ret                            exit
>   invoke foo unwind pad          call foo; unwind_goto pad
>   resume                         r0 =3D 0; unwind_exit
>=20
> Pads are ordinary code. The verifier learns one bit: how the callee left.
> The normal path is free of unwind code too: JITs emit nothing for
> unwind_goto, and exit is what it was.
> 170 lines in patch 1 and 80 lines in each JIT.

As far as I understand, the main difference from what was discussed in [1]
is that for nested calls of functions that can unwind, each function
in a chain must be called as call/unwind_goto pair, right?

LLVM IR does not have such limitation: `call` and `invoke` calls can
be mixed in a chain. What the limitation buys is an ability to skip
the loop like [2] in the verifier.

Is it planned to add an LLVM pass that converts all `call`s to
`invoke`s for unwinding functions?

[1] https://lore.kernel.org/bpf/a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.ca=
mel@gmail.com/
[2] https://github.com/kernel-patches/bpf/blob/fbc89e90cacd207b4271da25ed7a=
380f6b56125e/kernel/bpf/verifier.c#L18564

---

Aside from that, one minor thing caught my attention (hate freplace program=
s).
Suppose there is a main program:

    caller:
        call foo
        unwind_goto pad
        ... normal continuation ...
    pad:
        ... unwind continuation ...

    foo:                 // global
        r0 =3D 0
        unwind_exit

And then there is an freplace program:

    foo-replacement:
        r0 =3D 0
        unwind_exit

If I read the series correctly before the replacement runtime control
flow would follow `unwind_goto pad`, but after the replacement it
would follow the normal continuation flow.
Is it intentional? Seem to be a surprising behavior.
Commit message says:

  > So is freplace: an extension leaves with exit and
  > the callers are ready for that.

But I'm not sure I understand that.
