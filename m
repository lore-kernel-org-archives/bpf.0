Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23E175A79
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950475; cv=pass; b=koDnjle+na9an7qXe10wju8n3YtuG16JTLiGetTG86Ly2fkqar+fu5XuMqlMJu4lxBfJwU633yYEbXxj5fc+ZnO3nf/CnJbJlJb0NJ2Lxl3+8iWTf2mshlWw7xHKdb9rfBenywRgAi4RcImKyZKieGcrK7NYBkVgW7v9DPcLwLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950475; c=relaxed/simple;
	bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T12vbgIlRXvTMcK9BSco9jn4JMVkhd5MSZ4EE5yTXIoY1MxkT9bLYU017UxMOwpLFuwS4z1YyGp+7b5zlM1Hg8NK4B3lWRjMWxKdvHMuLUfulFeRaSja+3lFSiceu5Bj9+8eMlLF0ZFdHUMiIGPa3YBV1P69zH+bp7eRSX2ifQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyoXQ1EE; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyoXQ1EE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845ea8924a2so767333b3a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 17:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782950473; cv=none;
        d=google.com; s=arc-20260327;
        b=UoWLoLIKx4ADRLHqqz8z2gvrzUvA/dcqwVy5O4v4JgxBM78wr05kl67/3QtfO+VPeM
         chDXnOz8Wy0D6ibgvu/Y4s4WGwSpSm1DJyyC/TghGCT3q/oL1MEoK+H4GF0QcpREauZ9
         4Rb63KPDtLLv/rcABsm5TX1aQVIyMXZIxddOJiKA/B+WVUEIJvWeUM1/7/NGPt/1qcIj
         I0e+imqh40RWQPwOgqNLUfkTbifOr+hqMvabes3l4JP7duQRxXYxlXllxAGAP10XFoAu
         Q9xb8t6w7hCfY1W2usMw5qPS12BO2s69k9q4xXyU7pReEYIWspDFcebHLR5tEl8UdVie
         jSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        fh=XTI62B6XuCqRI/JcZCzbxwe4bxIg7tGPnymTKZCpoB4=;
        b=nhe3C6kwBGwcFF4jBe9p67QY/GiKw7Tpv4Tqmqz/IMvvgcJk/roQGuLYk02mUtqeP4
         PRli8VV3aOabr1RcY3DbgcyE/ajs5hQP1IxCQc2NuajUzXYGJZvO78Pv++SlZYFqpPcf
         MkXoYp+/5i1PSPQFdbiwNYPjJReieGFcqngMeuXylVMQR43F1yub/Gb6TRV/RnQx/Orv
         dT1YHdjE+ptqKa2d1vYaCLDdTy0lB26gVUmURu6CQGZ38w3zJExn4vxloSywrvqoKiv3
         UsUgZE1KWcVqMaA1Y71YByQ/P9GOz/fmtS4olWhgBbUOZY1okCftOU0mkpXsiRlTqcD7
         b+wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950473; x=1783555273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        b=lyoXQ1EErjH7PjP3Ijggvk+B4EADZpMT4ykcRN6Eo7bLcgve7oHwh53RNh+YVSEUvd
         huK1Snljy7Drp51UsgxlrMyKd8lpnxAppnUnqVwDjsHfyyhE7/FDuKe6eFj1w9eTH2E+
         DRbeSNlwp6kat59q2oWWWXPQPUMlwkI7MB61So3K+GalUrsj8s2wlvkcVJ/XSFI8rsEs
         FtF029G1RE13rtcXrVqSW2BdRsYT6DPSj/zB95rhS1HohKdT05C+uxkvoTfh+FD05QcN
         Sop1OLHXBJykSsQkybEz13ixvi/b4+CqlgeSF7bfVpCRLR9cCfCzwv1IJXUUNK0CAdnm
         amww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950473; x=1783555273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        b=WqRi/r+R1gvMAtUcV5D2nh8xUalzRvJfUw26y1ND4Iaqb8XhRidSY/4Qvm+GIyUx4Q
         atEkmbwnNMqJvNl+6EtySnpiwCnKPYa238xt8wZ9bjxihQrzQ0PrmEOHlbcx+qcPxtTc
         ve0clgIgDVAQdisyPajyOoN+VE/eSNc3D6ysqhuOcwymJ11TXZUS6elrWsnWyJpTBA5U
         1o6MljU3N79S9ov94vIXLc0xRUl8H+s7O5TVEauG5mGg9ROd3Bdttajb3IjwtZYpEaa+
         oT8fd8Hasmk8eFnZNQBt+SxbwUlrKsKIxq+VgG/EWc3trJnMaAXnBhAmWgiQozrzQHQu
         Zu+w==
X-Forwarded-Encrypted: i=1; AFNElJ+oCsVceUHFAWKjXL0Hi4vEkvDuXvbVHELz9abJcJmu9/B3QleE8jiKVQP6Xvj4EuLT6B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLe7XvOgdjjOt01GyFS7V+KlP88uD4J3t/6sAGj/tKufFhRzW8
	5V/1rdB0fxMnNzM77j5vqtTLm8Tw/3QuBDT5elRrIQ00PEaWcO6nYEcXl0TAxkMiOxH7/Ys5sAL
	4xgHcY3o5V4MZrJcrpeCDZmewpO0ArUA=
X-Gm-Gg: AfdE7cl+8IF1CiHM5DQ6Oq8WKUDSu3dFf0khQhgvWgffhpIk/+eFSh2ehLSmRb8J8hs
	uAS9fdNPKdMdh8ibOkEijOWz5iikUzDcaamxSSCzwKSNjAGMiSDP2dxam/7QoLh7hGGN2UjjIr2
	aby6wahJoizP2g2N1eUXFpbUsXKkuluQcCcGvjEfIaX8YrLwv1Vh52z3m7CcjAWRnGMUoDcZcJE
	a8Bmkl52ze4mCAqfEqUtHwc8KQp2IE6LofiTImZJ39XZ6HY595dZ6XvAtiJEuhucZN/zFu2CKS/
	G39F+SFMqhR8oUXAJJcpGK5FFkouzCCmOym7lpyvOwNffUydZ3SjNnFLOQr6CDUMnAh59KieTGV
	s+/HEzJwd04c/4g==
X-Received: by 2002:a05:6a21:6f8b:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3bfed15c303mr4004694637.13.1782950473171; Wed, 01 Jul 2026
 17:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
 <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com> <20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
In-Reply-To: <20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 17:01:01 -0700
X-Gm-Features: AVVi8CeNxG3GffX-OwXo6mb147DD5vMthLu_C49lWR5Of1AKIMhyjJfW9B4eScU
Message-ID: <CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:40=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 01 Jul 2026 11:41:26 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
> >
> > Nack.
> > I really don't like it.
> > There were days in the past when the kernel generating bpf directly was=
 appealing.
> > These days are gone. Performance improvements for fetchargs is not a go=
od reason
> > to add all this complexity and bypass verifier checks.
> > bpf insns should come from user space.
>
> Thanks for your comment!
> OK, I don't mind because this is a kind of investigation project. And som=
e
> people had asked me about the same idea, now I can tell them the result.
>
> I'm satisfied with the current outcome, as this development process gave =
me
> insight into the implementation of BPF and demonstrated the potential for
> optimization via JIT. :)
>
> And also, as noted in the cover letter, the current performance of fetcha=
rg
> is better than I thought, and is good enough for debugging. :)
>
> BTW, I'm also interested in calling the verifier on this generated code.
> Even it it is not merged, I think showing the correct way to implement it
> will be useful in the future.

The whole feature you're trying to do is imo reinvention of the wheel.
bpf could do that kind of filtering years ago.
I don't buy the excuse that embedded environments without any
kind of user space needs this facility.
