Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2A33F5B3
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162690; cv=none; b=TWtnqkXy0D90aJf4WOWpNPWgNftGYGZwI6qjyMyXUKFFR3rDr36L1G9bliHXS/nV0YCrQVY8x82VuSsWQAzTSqKCHWgXGp8O7Ov/hHGiXHAFnOHmT7rIoFjbugmbbHqJpiCIwKRkgPWiWUM5RNYE7fHm0GykhdTKgbgTh8nxMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162690; c=relaxed/simple;
	bh=5SNh/uGvNGVjEqj2LQxejglNP3RLCHa+qX2MIbBP6Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obmHUEnILxBqJ8KeslR6SKN1Df5PsMoIiZA1kn5oFICH6588Vv/9n+3QuFYMLf+IlqVeBitWaMa3DN9S/zYL66ct+/Ue/3WdLiaGdb7fdBlW8b7QiCcEqnbaNyJvhahG0pnyIzonTzS46tWQ4UG7dKPhiVp9P4cy0wC4vINGJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPw93izA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPw93izA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso4833145e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775162687; x=1775767487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTGXQBjXFLpryPY8+0yQpJpKFXA84v3ocDTQ3PH6W9Q=;
        b=aPw93izAdfJvAcJNDCjnNZDnI9a+m/xI12tr77r2N+As/HTFJhKHDiNcwCHHLNbo3r
         oXg8EqXGuupID/Hjtu23ngY8GjSBQFmiRaA7OLCnp+quehLPtD2OlF9JUj2dD73sjmZU
         z7gx7atC4Tc9Dqq7IwACGrPbeN87buAO+Q9zTxFPp7L4PyFjz4nCpKr6zhObjVgwXSem
         F+9Y4b5yOU+skVYpuwqBeRG3Owedlgz4ZOpoa8YMCOxBDfm+alOEzx9CJfgNsS8g775i
         bUYdG01tvhAdilbVuJdzrEG+5vL/JqkLh/0YjPWiGTuDhT6AXZ6bxCk4qOgl0js3UIP0
         EMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162687; x=1775767487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTGXQBjXFLpryPY8+0yQpJpKFXA84v3ocDTQ3PH6W9Q=;
        b=AFm+r61Dk4l1C6YOQErWYIbno9LTlHosx8hhevjiBg2k0yY+Ct1WpvG/jzKSXg34Fu
         empckDmox49Z46tA9w1af4qzAcFcz2dSyTbSnCHXxIsncRvVlgnocDEynBepkIXTuRl+
         WfIxXyQIl1ajF4nJzE6jcYNmq2pNSFKu0FqjWBFMV9sTdL0/D+RLSB/k/kuj8xiwSB93
         hccqS6tGsmOiikMSawskuVV9riSyB/tqm6LZRbHtQ1DC9vz/NN/la2sLpzOxLyap08gP
         +ghxQnlqJATkHwXbH2dm0AfQuwVSDYmU61ttLhZgsJ+Ww5QmOeB7b5u0hLyf+SPa7BS9
         /gjw==
X-Gm-Message-State: AOJu0YyYZucHau7iDdsKDsOqmF5ZlR3KEjDdyvtzMeTsrfIyPPqu2b6k
	4cVa7rooscNu/Zjwwo668RerDzR070Qpacw/KG/WupKciXVkRXF/yDtY7uANzg==
X-Gm-Gg: ATEYQzxxdMEUa90ifcEKhHhXFFcvlKPyO+vhc6aRGwZZtWZebRCwkWN3hU66HVxWfoB
	TgRJUWP0IPd4CyIzs/2oSxMjn4K+YwxiqvwOOOqZZQlz4vs8Rg8g5xf9O2MDcZyZUx2OWoVLlAK
	bXS365u8TGv5jVBh0et94YhuMDgURVSOy9YI6TQMdwTNj1cmYCc0Aqg7XU8nX5db5amFjRYTQTc
	lZ5iLyTzh7B5yYvlBv085MfsrGa5offR0qVJKXqegzAn2w3GyIBuoPZWdz8SQP/aiIRI0QcXnRA
	fEvnfSWbhj55i3fHSxwENdwNuN3ltccaAnUUjsvAdrYkTyVLP8f2khGBfXE9Floh0ovaeUIgGgH
	qyhGGQvwYtIRTWiWZ5pq/vUQQPAPcgk/APN4bqpMI0tfNbAh+O/6HvbxvMUDKZAhZ8iSoJcItJv
	GsokLChs+zGfWIzB1sHrKwqwVL7Fvl/0UiixQMA+AwyOM=
X-Received: by 2002:a05:600c:638e:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-488997b21f4mr7710905e9.16.1775162687002;
        Thu, 02 Apr 2026 13:44:47 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm89312145e9.15.2026.04.02.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:44:46 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:53:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads
 from insn_arrays
Message-ID: <ac7XSg6AsJq99WvT@mail.gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com>
 <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>

On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 11:38 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > specify an offset inside the load instruction. This is a bug,
> > because while the verifier ignores the field, JITs are not.
> > So, patch the verifier to not ignore this field.
> 
> This is too terse to understand.
> In 2nd patch you're saying:
> 
>    r1 = &map + offset1
>    r1 += offset2
>    r1 = *(r1 + offset3)
>    gotox r1
> 
> Here offset3 is, normally, equal to zero; but this is not guaranteed.
> 
> What is this 'offset3'? Where did it come from?

The offset3 is the .off field of the BPF_LDX_MEM instruction.
The BPF assembler will correctly work with non-zero offsets:

    r1 = &map;
    r1 = *(r1 + offset)

> What do you mean JIT handles it?

JIT will issue a memory load with this offset,
but verifier will ignore it (before this patch).

> can llvm ever generate such code?
> if not, reject it early ?

LLVM can generate code with non-zero offset in BPF_LDX_MEM,
say, if one jumps to a structure field, like in `goto *p->j`
(see CurDAG->isBaseWithConstantOffset(Addr) check in
BPFDAGToDAGISel::SelectAddr). Realistically, for now
this doesn't make too much sense (looks like switches and goto *jt[i]
will not emit such code), but one future use-case might be
smth like a function pointer in a struct.
