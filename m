Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A11CAAC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039316; cv=none; b=M8NA63Rs6/PNQD+cp34puM6M74vPC/h3iWdNxkzBuonuxkYyuDi+oRZoKsx/Fhga/IWeqcUc2NCe2ifUB4NHinwHXXg1onRIIezUUSMnx3fJmVVkvpkpwK0nAcqJP1WDy4FvPywINxhvDme5JhDRp3XI+5B5n0g+JQALiFmYizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039316; c=relaxed/simple;
	bh=ODL+GTRULnnAO5+L9Kjx8heSsNMRQ2DLiBDc4pljPCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMLPcj7GQDAaHmdNIbgXkxljxlnbyqXR57jZtD45Fk1aRtKpDpdDkktzvyCubzUfovYvL9ALL9Q+TOZjV88+xajzvPLdRlfIydrp/MU7qATkrt9cC/D0/vrOmRJ6BH0DpO6/nszEDR/UQZajub1CeBwWn9XXJg10sg0T9fTXFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOg3VWIN; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOg3VWIN"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86212a185dcso4144505b3a.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039314; x=1790644114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9iYbLgbawFHD0BYpmD/xj0rJyY/D5fJhjf6kF/y7mSo=;
        b=fOg3VWINlFUe+in2uH7Tb5PtM72HZFTr3AAKAxY7t8iUE+NeLN/onIxthSEOltpWSm
         DoF/VNuda7Jn5+feALEC9OgHzpolf9fe4OyX9LyZGqdcuiUnWcX8ru2FXGxibP1VpLer
         6XumHbHCWThad7TWbRPfa0IOTYVGO4XGfLfaGJLMS2suCkw7z6LkkPA2aEfEeCw89V32
         r2ii85cgl7TYEhTrrJaK3rVpK1pj3zvVVtyq1M2ucYDrvIL9MzG9Y0zixUed0a6xR+tA
         qDmst7eW/2My/Qyf3KaBHmydl2ktPaBWHpAbYxwKIxLy1KApUE/QRDSjnAQPNSO2H6vD
         pLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039314; x=1790644114;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iYbLgbawFHD0BYpmD/xj0rJyY/D5fJhjf6kF/y7mSo=;
        b=vwHfrcwtK2ABGSKserW84nWELwHiqwKL4+MYmwT3Jrh3rejBbDmSVqRaeZZGG5+bPS
         Azh74eeCAbVoc9lAUanlivWymfVpdyROQlwJPwJknzInuqKsgqa88YZg6osDTW0bMSOU
         +4L0lJbdURT2cNwpYuhYi31u+cOqGMm6AR4jvilVLj61hx3DuOX/BG4jtk0chOOosNm4
         hlwkGcPbYHXJKaUlzvx+K/ib0r0u1Ws9B2Wt81CMV92dDf2AZRyzTH7ieqbd5ob8xPdR
         1JV1mxuY4IRPy26/BZS6dtX1F+a92jCNjKIFeOPoZBntKy3LFb5LfGXENyeS5a9someJ
         Miow==
X-Forwarded-Encrypted: i=1; AKwUvBz+urE/c/mCfgv2pMdGZJ/R8d+fHxOgvEg7y8jq1P7YiK/mfvCpExOGxjYoyuHgo9q4pvA=@vger.kernel.org
X-Gm-Message-State: AFuF++k/Kw6tvHKJIos2MaCnSm0g65w0DtH6WzHKm/5Yw8DAoOiLQFsr
	0WNObFbPJDm6Nfedvr9rp5vVJyWtR2FHKA/aFlG2KvoPVlqVrGojaKKE
X-Gm-Gg: AYBFou1QByK474HEYngUdCiMlWFfkmoj8Rodk/m7L/ArCAfEMr2xiVdBycZWl5FzR/i
	wuOR3f2yxDX40U3Xd4IWxSS5aBolSEHR2yzJk0BGpACNYekzYTNHPXrl3Vvmb5BpSO9k1ZTLMGk
	8kIDWYAm16BW6I2F9TAL8yLXfsyAQtDiBkSuQOgPa9+xlIsVjZvBr3JGwDxLgF0xjx4TbFe06vt
	qovkI3YSlPLRvvgqXJ+4Cq6W+onhDzc+l2/S3pEseog0Tauh8TJ5uqKeyZVCsqIay7t3QaSFGM2
	lqAxa9L7jbMmAYV8phogBTcL0X1n54jBxu5ywjWtGsq/Uv7CEb+tjM3hemGKaA9f2kIEeIS3jGJ
	NvmdAy3bsnfQj7Z3U2aE4T9LNp89tx7eT+89U+fd/FqirPzLzByP/vc4f36aRk9Zq17kvE2x1a+
	Tgn0vTLuX6ZnGwPBmjnPQByZi7NZFrDYlYaLVxvbzKBpGlMNsJMJQ+g/EmLSZiu711D4jKFyHYb
	J6HgJ1eMRougdp63lpV31FcnDeuuHwy9q9VpJROSJdw5/7/XYuW3PkQ9w==
X-Received: by 2002:a05:6a20:c68e:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3dd8c58df13mr21281060637.28.1790039314260;
        Mon, 21 Sep 2026 18:08:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f26b1509sm561515c88.0.2026.09.21.18.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:08:33 -0700 (PDT)
Message-ID: <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 21 Sep 2026 18:08:32 -0700
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:

...

> Design
> =3D=3D=3D=3D=3D=3D
>
> A pad is run, not lowered. bpf_throw() already walks the frames with
> arch_bpf_stack_walk(); it now looks each frame's return address up in
> that (sub)program's table and calls the pad as a subroutine of the walker=
,
> with the unwinding frame's frame pointer and its callee-saved registers
> restored from the spill its callee's prologue left. The pad therefore see=
s
> its own frame but runs on the walker's stack, far below it, so nothing it
> calls can disturb the frame it is cleaning up after. The JIT turns its
> bpf_unwind_resume() into the way back to the walker.
>
> The verifier walks the same thing, step for step, so the resource rules
> are unchanged: whatever a pad releases is released in the verifier state
> too, and check_resource_leak() simply moves from "a throw was seen" to th=
e
> end of the walk.

I have two high-level questions.

1) The tables handling mechanics adds quite a lot of code to the
   libbpf and initial verification phases, while at the IR level
   it is basically an encoding for the invoke instruction:

     invoke <target-function>
         to label <where-to-go-on-return>
     unwind label <where-to-go-on-unwind>

   For the sake of discussion, wouldn't it be simpler for us to
   just add a 16-byte invoke instruction:

    word #0:
      code     INVOKE
      dst_reg  0
      src_reg  BPF_PSEUDO_CALL or BPF_PSEUDO_KFUNC_CALL
      off      existing call meaning, including kfunc BTF fd index
      imm      existing call-target encoding

    word #1:
      code, dst_reg, src_reg, off =3D 0
      imm      signed unwind displacement, measured in 8-byte slots

   With an assumption that during normal execution (not unwinding)
   upon return from invoke the control flow goes to a fallthrough
   instruction.

   The pros are:
   - much less frontend code
   - if in the future we would like to manipulate BPF program
     byte code, it would be significantly simpler to do in such form.

   [1] https://llvm.org/docs/LangRef.html#i-invoke

2) The final goal of the BPF/Rust project is to consume whatever code
   rustc generates. Ultimately, this would require supporting a way
   to introduce runtime checks at arbitrary locations, whenever the
   verifier can't infer that the program is safe. Such checks won't
   necessarily have associated landing pads. Meaning that the unwinding
   logic will have to be dynamic as in exceptions part #2 sense discussed
   way back (2022?).

   The argument against exceptions part #2 back then was that the code
   is complex. Given the current environment, I don't think the argument
   still holds.

   Hence, given that dynamic abort would be necessary, and that the kernel'=
s
   rust code is already compiled with -Cpanic=3Dabort, do we need this stat=
ic
   form of exceptions handling at all?

...
