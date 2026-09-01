Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F52483BF6
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284542; cv=pass; b=Jb7zdN44sKQpF3ij/ju/eKkPQ0z1/+5lr26K8nUsDWVq3r+/D9LVf9CmRX3qO09SdB2Yb9sTYFyBUMWyd7e8+cE0B3eBTa9xWqSBFoaH5pYIpr/FvwidaXLe7ywsZNkfn+osMwGWvo/Tllo0ktL9L0QQ7l0Tjx3IP4MpMLu7RdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284542; c=relaxed/simple;
	bh=p1uQsN9T7xX3H3/reDzJNofZ+Td1vmF68o1s3Y6e9RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLTRl5mGz+2E+C84Appu8srXCS7/FJBxIJ1VfKco1cRaDOtX2/9tdX6aBubt5F0WwsX9AGqytMhOECewCgmZiKCB/377l+lXxr6NrCHkGqqrQ8rnrf9SJn1vApQamhmFbCu1fQ2fRR1KBKV9Igi9IuMGO7NP9JgUebzdDRCQUlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl+S9szz; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl+S9szz"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-857ff9fef54so2563487b3.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788284540; cv=none;
        d=google.com; s=arc-20260327;
        b=omfR4j1NoG4htvlYqgw9KOVHLsvjyKhnkcxySJpuX5PTZnI1WAdK8ngDncY64ry4o1
         C5Oh3VpPfpcF7G2tbAN5t3wetWlY+ZMHxxSERMD0xPIey6Urt5+vh91fQqwY5mL9doAS
         bSKx/qFJE3/aFZDkAmfz2vdns3CP4enJCZ4FO8bGoqoAXBoXC+cL/qBK1q99dLvainy1
         +ltkR6AfjmiDBVIg7vAI0wp2X4TjyNvCrG8z/ynkljdO//jCD1Mch0ZkpcT9Rh4ohWx0
         zL6h69nKBvoNu4f3e/YTT9QwHxleA43ov4bZdiD8/NOuV6xe7L3R8idHp+xkYXOahiwf
         Bztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1uQsN9T7xX3H3/reDzJNofZ+Td1vmF68o1s3Y6e9RU=;
        fh=AWeuiN7VmU2cIO/BWYfrjTRwjTocBhsivqF3rcWnO00=;
        b=JuC1lRRTJ/qN1GqcNaxrcFLDnAmK64UtdEarMhAVK2X3gGMUmT2+xDFO4L4qTngn6R
         dgw6FCxBRIARW1AECujmJpr4gdwYsAd6jDEu7ctVsBTu6Fd80DfmJFjiFJlZotddJTGi
         332StpMBAEKyih66HYNo/W7wgOqYBcio+rvTNQNKfOwK8A+VdJQmPMEvZY9eEL/3VIXa
         SRWPdsQDQbR9+NPGzbkWdQMdkrXh8cXaaz9e5IBmwJ7Qg6ATSuQTlh5Paq1/iTrE9zHF
         cDIjTthOhaPErFoAI3CNBh0VRJySU8fIf2yok8CTFzVp5LBe5//PA+OkpFnTG0OQmRbG
         hqvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788284540; x=1788889340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p1uQsN9T7xX3H3/reDzJNofZ+Td1vmF68o1s3Y6e9RU=;
        b=Nl+S9szzBfeQyOuqeKeWpMguE4V6e3VtkK2YJgpzhLMZY+eVfAJLKmOeLLIHYUgJdA
         DYL3ePtveP99SnZTgrMdrE6W2FtxFGiQBvVXCPaK4BexzlqWmIT0hvr14ERjzklCFyEB
         fe/UNUq+5k3tWo2jWEB9hvn5Rc+qc1I2sDlkQm4aKWCzgXSLyZ3Tau54o8c3VwZCOiMd
         H/V/s9eG7WAi3/5JmBE+dk/9gRI45ODoMKkGpVaoHz3kb7AXGPfL+iWEfKuniChRjnEQ
         Uw5joEosc4RikECE0xj0fcCldI/klQvyCTTgdSZ2nfMshuJae6oIsySKxYk9n8A2jIEJ
         1xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788284540; x=1788889340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1uQsN9T7xX3H3/reDzJNofZ+Td1vmF68o1s3Y6e9RU=;
        b=T7Zyo8SuKyQ5SG6k6UQ479LnVUetX4z+2P7/BsUTneN5027Ouyt2c4WBNovNQFOFNH
         0nsqPBWIpXz7atSnLHpllv/VHyKmwXFK3EeRHXltAjvITYHTiVqsdPi306Lpdf+0gHTx
         n8jZFWoLDLMzsGZq86sQrkCYPTZFDL52a1bNftlbiBDtrFFqvT15NbEF9ldschLsmoKh
         M2EuefR1vT9kIJdD+aKu0771RT5FOAz/xUHce3MjQJGN/6EWBQdxm6q+mI9XSB9IJUm6
         CP0ElaWecDNGT9SaMn9uL6Ix9mFPIKgsAivEx4xJpKdPkcW2qWS1u56KBShBUenqclJO
         xZSg==
X-Forwarded-Encrypted: i=1; AKwUvBw4+AD6LK3gImX0YH8yVVNDY9hNnwcYtRQsGmURaHzLeRHmp7wEPjai4SNe881IRN7WhJU=@vger.kernel.org
X-Gm-Message-State: AFuF++n1n4eg9vc22y1hr4dekzjZxrSkxtBwmO/SgZ2ahLDpSxt3dHg7
	23Z3E++uDpKY7ReyvzMxLeztmx5VXpY3Q/W9AmjvGLMsJEkvCPF2ByKe9v6s/m9XT+/xGJ0qGQb
	JtMEXtG60FIpjqOcc8U0HJ/HBSLYl7A0=
X-Gm-Gg: AYBFou3Jzzou15Ts09J78oVvVktAOHFkM4TTGH3ZEDJuFuxLW37zg0zb8IhbKcJ00J0
	mWyZFgGy8gUCCtku6sHbVNmmj3Ei/h10yr2yZJ+9nNOrQV+jgH/rcylL4/ez7ipjCGRwLeFY6QM
	jbhtw0ZI3D6A3j3Giv7WQAyRtDDpYETRx/u71hD8003njwjvs0wY6C/KyTUupZsL0xzsCbE2MT/
	u+cwMYOPl4CzqzAcUTEmRtHPAT+XjB591OBv2gm/GdnVbmJ/ZIHen2K2FGBn9OzxgP4ANBrPf4r
	TRvYFEUoGHjMuMTb1B/DBrMHGFaTUth8n3HLJ8QMu1REG+sexWFTBqhlhCdWU9QodCHwwytpR5p
	rOsQTRD95MJPOCQsgJEZCS7I2vEtP7yvN9tXZtfUn39pidtRUmtaprMuqpMnW6D4l8UHmtZIa4y
	cTAuGFSs8H8rel
X-Received: by 2002:a05:690c:e159:20b0:855:37f6:a73f with SMTP id
 00721157ae682-85d69f00d89mr107947447b3.13.1788284540080; Tue, 01 Sep 2026
 10:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com> <CAE5sdEiGA+chRkkNGOWL89AFDNXor1RKHMEmouCNoCXVd4fc-g@mail.gmail.com>
 <d4e2ae332a9505cc2cee5a236ff86efb@oss.cyber.gouv.fr>
In-Reply-To: <d4e2ae332a9505cc2cee5a236ff86efb@oss.cyber.gouv.fr>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 1 Sep 2026 10:42:08 -0700
X-Gm-Features: AcwNN1Uea0qvxpbJnC7W6Ed8TeX-njpcgs2h1B6X2fQu1FbWfEcGHVsgCajGxzs
Message-ID: <CAE5sdEg1eMs1Rip2mbCV570p0==2gj7ZtH8CttPfsqcM2CrB0Q@mail.gmail.com>
Subject: Re: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, 
	rlmenge@gmail.com, hargar@microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Sept 2026 at 00:11, J=C3=A9r=C3=A9my Jean <jeremy.jean@oss.cyber.=
gouv.fr> wrote:
>
> On 2026-09-01 00:57, Siddharth Chintamaneni wrote:
> > On Tue, 25 Aug 2026 at 18:10, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon Aug 24, 2026 at 2:31 PM PDT, J=C3=A9r=C3=A9my Jean wrote:
> >> > Hello,
> >> >
> >> > With the help of AI models, I found a bug in the x86 timed may_goto =
path that
> >> > leads to a verifier/JIT state mismatch on private-stack programs.
> >> >
> >> > The root cause is that timed may_goto fixups pass a stack offset in =
BPF_REG_AX
> >> > and the x86 trampoline reconstructs the counter pointer from native =
%rbp. That
> >> > is incorrect once private-stack JIT mode is enabled: ordinary BPF fr=
ame pointer
> >> > accesses are remapped from %rbp to %r9, but arch_bpf_timed_may_goto(=
) still
> >> > uses %rbp and ends up reading and writing the native JIT frame inste=
ad of the
> >> > private BPF stack.
> >> >
> >> > The bug was introduced by 2fb761823ead ("bpf, x86: Add x86 JIT suppo=
rt for timed
> >> > may_goto"). I reproduced it on a KASAN-enabled x86_64 kernel based o=
n v7.2,
> >> > however KASAN does not trigger because the bad write stays inside th=
e native
> >> > JIT frame. Yet, the saved-register corruption is observable.
> >> >
> >> > I have not included a patch here because the fix seems subtle to me =
and would
> >> > likely touch many files for different arch.
> >> >
> >> > I can share the minimal reproducer and other details privately with =
maintainers
> >> > if useful.
> >>
> >> Just send a fix and a selftest to the list.
> >>
> >
> > Jeremy,
> >
> > I just wanted to check whether you're working on a patch for this. if
> > not, I'd be happy to take a look.
>
> Hello,
>
> No, not at the moment.
> Feel free to ask if I can be of some help
>

Let me playaorund with it. I'll let you know if I have more questions. Than=
ks!

> Regards,
> J=C3=A9r=C3=A9my
