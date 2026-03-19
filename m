Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102034C80D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941900; cv=none; b=F5oNkz949H/6JhuAZMtvvSq5ss9LO+m+PWrdp81/3vHz7TYGIFoPWtUWDRGaXdSYBLfe1Mi5kCfUvOqSRle1q1hgzzP+3Zp+l8V5LE1yCqVHLEzH1PIM6VjC/S3gpK5PsVg93KX7wpVAzm/t0HwNj9tqm9N6WnZvcWCCJnYZSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941900; c=relaxed/simple;
	bh=iOKQxxTaVePDDINtdEVNa2vXNsDA0MBl/13v1fipV+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6YdPKhDw18UKQy2bbfvkiCK2TSSNHwqQ0RS+vjWJAdGkGz4xvEZzRQyLhbWKxISxsZqBumAKA2hCP+/BD1h6/cLorX1u/5ZIvdKGsxGPfo6ZSl8GSsa8gPZdTtA1yr3GSoHKa9vtz9llQD4zTBPD5Baiu+9hx4WyY4jDSgWVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkq7stBO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkq7stBO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c742bc88d87so455278a12.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773941896; x=1774546696; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iOKQxxTaVePDDINtdEVNa2vXNsDA0MBl/13v1fipV+c=;
        b=nkq7stBOxp1p+dwZZROvJpWlDyx+lYxGZkzaZ9GBZQDfUAZ8ekfJwgvh+MHYKPucG4
         vTR16Ur1oOJpFgnxlyxIlc0d8ojeklkfHgjV55bvvAeJQDRNje7w4nVcUwYudtptffYc
         7nIzcDwLEvMqEVOcJjaG6FMSirjsMWGNACE7/qZrjWrGMoH92E6h8db6NwVQiLenuXXn
         lkL0c9HUAYnO7cdhMeMesd4pOqQJCb7jQwfcREOCRs1sgNovLng5W7s5otewjorYyRpV
         UpTFytwDBIU3VO5Ai/x7N15R2xccQQ9q6JZyDr3/Nq2sUdFpiQdL1h7vDyD5mMM6rAaH
         vFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941896; x=1774546696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOKQxxTaVePDDINtdEVNa2vXNsDA0MBl/13v1fipV+c=;
        b=NTC0a29N89xMAE4q0GfCb0CUOhRYD5SdG6jL8vMc5pA9OA6ByEnGmHztDCAIZmHyuy
         D/vYauqHEsrLnxgy0uubLRYJhI3g6fOepAohLnrxnXWLp+L03YEZkv7aTEPENQasBPN1
         MUqKdobY+airtG8panzkUFxb1WBBcgcrzcymAKl91m+xXnKlVOyHYVDKykNwHjJOoeq+
         RevWhLG/TL2JCr6uj3eHDOOmoRV5dSbu3tIYGcqbBe9Pdvgwe1fmoYuAs+arBKNrS5A7
         /kJThJasc0rjLrhBE5jG34UCUfnr+S3tWmCMDcHogRz+uy/9SQc73wGw5kDIFlcY8Y1e
         P8zw==
X-Gm-Message-State: AOJu0YxBeACKklothJz8pM6PXCcnzKyXweayoDnUE0oAjNQmyF7dLgv2
	S8em4i6WFvWIsyBx5prpa7arfiKiyVLOS3vEBO7tQCsWeY+hZBU429SAj9IdRQ==
X-Gm-Gg: ATEYQzyR+io+mmPaDbFSGXwmiciXoMNVZnt6GQkRxHLUd2t3pSXUgNcfjQ0tCQpZKxg
	8LiMiRSxCiR8O5uzdvgyTJQ7jEw7kstqaoIEveyAUSGlPY0oiOlhcycX1HutdA5FnKPIuUPrT7a
	86sYo58RSaH4D4xb9ZtLgYcgehAVP6T5fwll/jx89jcc5Y0Gh8+ZQTjue5QTlYeyhxUGoXUszVm
	I/DmgUmFrfOhsBfpTfjrT7l+1XZkriwuhtUJY9X44OgyOhDrHci7uwvjdckjj6J7dKfhwwLqJOd
	9i8/cmf8aOfAauSvi9+5izxHYo+X3IkIsljboGDc/w5LiJZClA6ambybU6GIVLKUfNlNiBvh76Y
	SHx7fAt71BPd+jIf9Xm7MzwPgzGcOLKl4++PdqZ3MyAtLYCe4eVLnpaNLY3qLiCIjjlHcLuNltb
	Hn/jK0sqn1Q4A4ttxG1cZQ+omASE84r+1ssBGnBM5FcAPv3X03Py8yarTXCQQSTw==
X-Received: by 2002:a05:6a20:d6c8:b0:398:79dc:eb59 with SMTP id adf61e73a8af0-39bcec302b7mr155374637.67.1773941895717;
        Thu, 19 Mar 2026 10:38:15 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74453295a8sm33852a12.28.2026.03.19.10.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:38:15 -0700 (PDT)
Message-ID: <432750df75b5ce808f6b9ae9cd7ab3288a653b13.camel@gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	john.fastabend@gmail.com, martin.lau@linux.dev,
 linux-kernel@vger.kernel.org
Date: Thu, 19 Mar 2026 10:38:12 -0700
In-Reply-To: <CACkBjsb4tNgiVKR02R=dkqd6kNWfnyHyFgPMuNwx5f2EUL7tJw@mail.gmail.com>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
	 <CAP01T76ZazpBriekA+82aAFHKSoa+XvnvOOnQRz3XBTvBErygg@mail.gmail.com>
	 <CACkBjsb4tNgiVKR02R=dkqd6kNWfnyHyFgPMuNwx5f2EUL7tJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-19 at 10:06 +0100, Hao Sun wrote:
> On Thu, Mar 19, 2026 at 9:18=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >=20
> > On Wed, 18 Mar 2026 at 19:21, Hao Sun <sunhao.th@gmail.com> wrote:
> > > [...]
> > > in case anyone is interested:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1] https://pastebin.com/r=
aw/czHKiyY0
> >=20
> > IMO it is worth it to include this proof inline in the commit log,
> > since links are fragile.
> > It's not that big, and I think it's more useful to have it inline than =
not.
> >=20
>=20
> The only concern is that the proof mainly uses `bv_decide`, which does no=
t
> provide much insight. But it's not big, I will inline it.

I agree with you, not sure it would provide much signal, tbh.
As far as I understand `bv_decide` means: SAT-solver, please do the magic :=
)

A more interesting discussion would be to have some model-checker
based tests in the selftests, but Alexei was not excited last time we
talked about that.

If we have enough interested people, we can pick a checker and
maintain a "shadow copy" of relevant functions and data structures in
some repo e.g. on github + current proofs/tests. To have a starting
point for future changes.
