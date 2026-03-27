Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2833260E
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627806; cv=pass; b=rNVd4BpurY+Yp7QK3Wl1VSm+7hmnRH+AZtreF8Ga5fTROoG0utW7c2UnMww2NG7jlzrQGH/QKo/SI4MZ7xzxznfdcT5SRukx3wPRFaWu/K/6YyJ6FFcU7x9GwFIDJht3sOBpjJakJcB1V0IYB+x2OwM72tXlYZKdhSYADiKN7lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627806; c=relaxed/simple;
	bh=Q6TmnOpeExcSP68v1WBPeIpo2KznzbDRRsuXO3vOiv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZAFGrpizoB1bxf0F1LTjy8YV8AjkLq5XD38NP4mla1pdWqDUiVsJKPuPlUK4XdQhljniNIFdJe1+k7GWpdXeZLRLfhLAGmFJdqqLj05gusReasFdC4UMkBpqqz+wpYDPoWbdsluGcHdYrb9DCJFW9+tcUUvyyX3qIeKVDV1tJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh/NSuIJ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh/NSuIJ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97ed4ad579so373484266b.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627803; cv=none;
        d=google.com; s=arc-20240605;
        b=Jtxo5EN/xIc7Bg3RSdVoA935wQCzvEqoaMhTa9JV9yMS+2LFdHHvmLHCSYYEWeVHVe
         SDIrAyb2epxDqxQBrHBUO8wh0+JRK3mfuaD+OcAIbpzJWbocYj7C9EcrYahaGgZMzQwP
         qeBn/QWZ5gXBE7jHU85YJkSalr9+KV5Xaqd9WhMd1lMZ1GN/gkXKX29fovbd6S5GvI2B
         To79ZymweA/nABYBjZyWQ9gDxuNZDYF2nXOE6O+ZwSTJgOuM25VCJR06p+sIU1qZreUg
         KJ8C7P/LOyYk8JdIpZdUUNkCPE+lMvYyq9tJVvtRIK4337UW4qFZ8/AcGv4F+ra9AHF2
         xlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6TmnOpeExcSP68v1WBPeIpo2KznzbDRRsuXO3vOiv0=;
        fh=TuFtG2RZn4MMAD9Wo8wGzmb0gF1dRceNmdB5T3rpwQY=;
        b=XzVJOf1kbf4prDo85yilp5EYWzrMlpNYzC5eLx87pThmIF3QvlEHtEsBYVKCyxs3LR
         wC9FbM5N4X/vhtgGxJC554d65CFJMVvoNOcKLOF80X0fw8yrv5vYUsSIewpGvLHZKhdm
         mvbZur9hj+YbH9bbjr0Mzsh+yb8VR69r85GtH4eQVyfTn9EI/2GJwfyw81qwpYpxqKXM
         it7UO4JeLb+iMBFbnYzMxr7onElIh0dk3zj2E9msXkX241Ta4bi+nUsVHFt6KNUMYIdD
         0sY983haaxzFswAS/rhWWpE1i7dYSv505QfAhzjuPTYMTnoeWwvQER5YczWU6bEoIX9k
         FFYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627803; x=1775232603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6TmnOpeExcSP68v1WBPeIpo2KznzbDRRsuXO3vOiv0=;
        b=Kh/NSuIJF1TDloSkOyK1rUi5Uq7WuazEGTixR8EBquvk4Bv64flETq/iXOPEZSaHyM
         tS0EPMtoBCXxPfSOe5yifaBYkM5R7TCX72DsgBnERXJY/I2evxlvhm0oJHEAoAjHTx/y
         DfXdKpQBtfuW/8WkVFN+bzyFvdiH/8aPRLwySTRxvCoKwUqZCPF8TJdq9Imof+Qr3qLr
         00t+7iajwW2tgFDFPSPH8r8SYsLfUHpdDGmBvtoE2UkK+3zJj8LYXvbQni2yD/ap/w1d
         5cmp2pzj/crvIe2+ZUcDaAUYOOVFCE8D7pnfGuHvnTn/cXUbHJUQ2n92D9JYC0eLpGsg
         lhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627803; x=1775232603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6TmnOpeExcSP68v1WBPeIpo2KznzbDRRsuXO3vOiv0=;
        b=CFewN0a+qYoByDF1CckXlre4jGhPJqwgnfFVF0LxjajuhETg5Bo08cmm5orJnYoQyo
         6+XzBmnRpNEO/OuGQ9hcer9cQS7IxVV+/OT/BG4581912rES6e9xYyZvlcqxsQINPDUh
         pY6TNZ0i/78BLOiXspjjLm0qqBSUTpEe9Jp+2PklBeQvh/alsITHn76JGDIzSwwzeuXz
         rdpYi3n4IuRnELgow1cVi+E0BZgYJ0YxP5OhbCljpthBTTm/fdp6TkVqAZwu1BPg+RZf
         SOpZvTr61cwz1QsU/V4364j2G0Mri0EACq3Z2xqTwaYuk7sgwrvK9vhzSFB0qd1iUs9h
         uixA==
X-Forwarded-Encrypted: i=1; AJvYcCX3OYdlMQhrkyLtUOsdGgifU2tp/v7YQ8Ss2/BT68xSUnGeCWGsmcScaDT4XB97qyK2nVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO36nqQ1NiqfJHq/9D6z35iuGlbKsT057E6stogEySCeZrLkoz
	7nvJrEysgFz9T3uCH4Vs2tUY8x4B+2Z64eA2xSk3A+4LThOnqqujeGfqqak1V88wLC5xK04dgzP
	3k9Mwc265wifMe72uXl8XGFE63TdVQsA=
X-Gm-Gg: ATEYQzy3uK5eNkYA5HKnT7gU8sN3DHsSANF2lwP4mAoWgQs06ino/KeCN6NIZmYftv4
	Uqf7jMcjKqhWYEN0+vqGgqxvgaVEvzmFbFTFO6pGrkc52IjwTaTRrY3czK48zofBaqoh1zYCyH4
	prgfUo1/UNLedmIgUowH5OZQp7e6gzcJBilxwgEyUqpOWky4ujuZByM2zt7utq5c8F8kVQRld40
	+d4pHdLTgynABjWXOwN9zwcuXh0x5VvfTssNJsw+296FkWUMr+5sc44N6z1BbYvyduAwpXS3KAM
	1Z4L7ymDbHkHy07G7DiMQFiSxtlFPOlQKG7qLPUvfS/a1tpiRxCqm5QTLpscNtfwn07Vk2XI9al
	C/Wthd3r5ZpgVKdcRMzxpYfO+hQ==
X-Received: by 2002:a17:907:3cc7:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b9b507a5dd5mr212383266b.30.1774627803420; Fri, 27 Mar 2026
 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
 <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
 <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com> <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com>
In-Reply-To: <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 09:09:52 -0700
X-Gm-Features: AQROBzC83d7M3ywFEBHgpYKvreBOkrl4uhLAWBsTwhT1G3q975_gL7m2eQX0iKg
Message-ID: <CAADnVQJmqKVZC1gkvAaAmO9V=cnYPO0UYB6Wyp6Shko4tZeUQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 9:06=E2=80=AFAM Takeru Hayasaka <hayatake396@gmail.=
com> wrote:
>
> Sorry about the top-posting.

yet you're still top posting :(

> That makes sense, thanks. I agree perf can provide visibility into which
> BPF programs are running, including tail-called ones.
>
> What I am still unsure about is packet-level / structured-data
> observability. My use case is closer to xdpdump-style debugging, where I
> want to inspect packet-related context from specific XDP leaf programs
> in a live pipeline.

see how cilium did it. with pwru tool, etc.
