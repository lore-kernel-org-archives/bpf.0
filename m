Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FD364EB0
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452705; cv=pass; b=RD9tRHRYYQHLmnfplUcxxjDNu5G0Xot1r50h3nCUw9tHmSapy4OoI5RH1mKHexnr6FUAJZx9pub8/Mdmqsm0cAln50+es41P61teVs2ZHRDOCe/Q+IBIhQjhE0jT44egJReuAK4/Owm6GozUQggazvF1CxjNXR/3IZx1sKPkrzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452705; c=relaxed/simple;
	bh=+RCvzX3O/zZVOe06+QEUzmxxLt4XHCNKPDCKitF87/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThMwOdW0zzZw02/IyDWO7DYXb/sxqiLnmnudNm5QD3jvFHS6bGRur/LWnV8jYY5ExNQgL4sl52He9vwS6JFnjZRmc0cBe4lOl0GaIoGViyA04E14pxBelitI9Iby7D3Xd37hPz4UuNXtywkt7NK4Niber0zBSiXhmeFC8bAXIkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0cOHOzj; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0cOHOzj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-452169ae568so2838959f8f.3
        for <bpf@vger.kernel.org>; Sun, 10 May 2026 15:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778452699; cv=none;
        d=google.com; s=arc-20240605;
        b=Am893Hkytw01Cc0RPVHsknQX7LptKGKAC7ApPa5OozAohXOYG5BiRk1/443EO3fJBF
         HjwIQ9wVQ+vs5kT6QTKm7PXDtgzGvvS9DX7A1KK9ZOv+snK22i5xtFVgbQFRqMObG912
         VUBzGtUNZz8P3uGagsAmNBKr/4hXcjNiwmAxYh4OIt3/JarSQizZc2m+00QLKtMz+gV/
         DmpnBwqit1NcJAUTrLYn4uW4bzf1Rd2ntmYZBBjYSYWdbnGovD1yZ9Yrk5xWh6Uqejpb
         rDCNzxcK5+EWp9RgWC9fR9HRb6EB4G31rf1CtjoLU+cfCCW+MVRlW+stk5MGlQRwX9IE
         CtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q742UBUVfHxlrrxIFoluJHcHiucEjbpkj0zuBBjRUjA=;
        fh=+2ZgCftoiHBZyy7A1Aleo8/eefr9WGBz4L25NWN5RFk=;
        b=Vg0fFJeGEC5j7VVAXlFwqzHSb/OiXqWeIT30pUbWTVl0JKu3s+BwDke3HNFQ//eEUT
         isD3Orfjfj8FXVx/9iTALsP93DHZvaQsO01zJ44VGR/UbLdWSW48hlbEa9n6AA1ivSqV
         NYC3yaswIrXVdPGAaVF/blDsstivlFWH1SjuIj4QA/+XvHLElkkF1aL8emdP/JhyyOdo
         gxcPYVGEpjHgJSifwZbWtJfgTEolHbdhrDRPFQhKYHZMMZ0D6SI4offXUfa4gRzgtsAY
         MpQGjF0WW1g7RlWDZbwI6SGGqUB6cbVNzOz9HgzkBPyirHionvV8A/ZNknXX0xTZ6LHp
         RSwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778452699; x=1779057499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q742UBUVfHxlrrxIFoluJHcHiucEjbpkj0zuBBjRUjA=;
        b=e0cOHOzjfzdXjKYYA6X20/z5Qz4fjrSY5dSxZ31rQTfisd+s8+VB4KZoXDy/7VyFCW
         3r4LWCD3oub3z7uTXTCnvyxj96AiT/jRQ8tOTx+6YAtUVYc/EB/AUBnhC3SQUOA0jCws
         nkuW72WtXiON520F9SyButzWz+w8lvOxDpFWJP02SX8P2AbziokRDHCb8AtK5K5DYmGl
         HbuVmQWMeTONTTScJNyVBZdnco4g1kleXuZiTQQEw7otUfm+RH3dNWP0DfTlMfOsI90f
         zbUIOzGP/eRqmfx2BUdzYP8LghwY2k3xvg/BKYEsf8YY6vERFUEw2V9V2nIs5BCoNBDU
         nVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452699; x=1779057499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q742UBUVfHxlrrxIFoluJHcHiucEjbpkj0zuBBjRUjA=;
        b=paN68of1EZlJq3zBqux2QOgqO1yt84pGMZqw62vpyNp6wwXf9iBoBx/k2d53FxN1DL
         FVv+qNekFz3HeH5LNPJkqtNs/mb6YojKFO+iuC56ek6wZ0j3+36HaIcopAybdh5rfQjH
         AobqOjIqXRqqiARZ13H9tsRL3V6FG8V4m06jPbNtPucSrtYzN9cKppdmaKiRuv3hD51A
         6oVqfudBONkhk01kyJFaDQyTXQcK3ExeGsTOpGe7Ff9fIe7f+NZ4aOn5mP6Epdm4o7S8
         qMQmv1PzvGBj2zL4oy2mbjN4ZdBIwmAf/mHvIznOPG6YG535crNuYb29Xvja23TNcLvq
         TwWw==
X-Forwarded-Encrypted: i=1; AFNElJ/mr6viSng1iV0BicdFNvHcMB+Xmpej7cc256WO5iMtMSH6N6/pZr9AuMIEls72tTjqzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcbGkqbn98EYCrmbBasYV7MBCY++hj5X4oseDaJw3Sk51zOgW
	a1Ap6n8+NDDYKRU5IEab/W2t1rAgsXYraht8Qkk735tX+8RdwcY/0+oVvGMdMZqr7hTuTE59Omw
	mzHNPpoiV916BS2FDSmNPaA/+gxEV3BYOjwXG
X-Gm-Gg: Acq92OGjzQump42/l1gJOQz9oUBiuXoMt6IOX9Dpugl6Wq4GJAxkLIFtgeLhZ42G9gC
	FL5MakUlujzVkSjCLVxtHFoJiObMh0Zu9NviGkuInQ1S8tTo+gcwNbGaKu7wj8zZh20gZMjOBpJ
	lodU+vdLXeH+EuJOxfC24FCmMO/Diwc7AcQRuuVnaHVM/sXWBxJPtfTQuf/dN8kUSdVLii9Dtzr
	kc6adZ5fWcdCpbgckSMgpxDhI6EGxbDa1+8bDCwJVkmwIrXQhPHj+G/43QgVwXyDcKtT4i1WO7W
	8JoU5JTtH5KMIJDfOGxwgVvSvpdp2YtciV2+BIpz2S1oeEcE0geUoamVttjgPJ9fz4+GDtfupVv
	AZgO8Nk74Oen/b44r50hlaCTpKlzFsIGYgjZ1j2zj1c99X6s=
X-Received: by 2002:a05:6000:144b:b0:43d:714:34e5 with SMTP id
 ffacd0b85a97d-4515ce1bd58mr33450874f8f.24.1778452699023; Sun, 10 May 2026
 15:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
In-Reply-To: <agCXEJKJh-JGMhjG@zenbox>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 10 May 2026 15:38:08 -0700
X-Gm-Features: AVHnY4JtWp5-wHurTbGbNe4pndwrP5XL9-KsYnPlCg2TVbgg5WbvM4DrSuh5aYM
Message-ID: <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Justin Suess <utilityemal77@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 8:14=E2=80=AFAM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
>
> Any help or guidance on this would be appreciated!

sorry for the delay. Everyone was at lsfmmbpf for a week+.

All of the solutions so far are way too complicated.
bpf_kptr_xchg() has to remain inlined as single atomic xchg
without slowpath otherwise it ruins the concept
and makes usage unpredictable.

Let's step back.
What is the issue you're trying to solve?

the commit log say:

> A BPF program attached to tp_btf/nmi_handler can delete map entries or
> swap out referenced kptrs from NMI context. Today that runs the kptr
> destructor inline. Destructors such as bpf_cpumask_release() can take
> RCU-related locks, so running them from NMI can deadlock the system.

and looking at selftest from patch 2 you do:

old =3D bpf_kptr_xchg(&value->mask, old);
if (old)
  bpf_cpumask_release(old);

so?
bpf_cpumask_release() is fine to call from any context,
because bpf_mem_cache_free_rcu() is safe everywhere including NMI.

hashtab introduced dtor in bpf_mem_alloc,
so bpf_obj_free_fields() and corresponding dtor's of kptr-s
are called from valid context.

What is the problematic sequence?
