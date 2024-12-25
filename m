Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374942F56
	for <bpf@vger.kernel.org>; Wed, 25 Dec 2024 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735097138; cv=none; b=esCQU39mJTWUwDRSw+PljcR7e1/GYONb/xGzbPr/pXazN8PHYpnSUX6YlQr2htvZQw6wZQNnU+hYUebSgvjjodgaoDNdZ9DXIXErtxGeBbQC+cmIHV3banHpO1Oh2oCvSkC3BpnJ823jv0q8NbXZI6SUnYOzb93874vTgWW4Usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735097138; c=relaxed/simple;
	bh=NqXk+IGk/JfWHhg8SlGyvzYgkslv8WntR4niWs3MEG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYWid0IUKXGMjcl8j+KJU2qlIMqZa2DXqmcNVazL6XrA/lp9Ec5Sl3hBAITgb+1CYlyvxtqvRqR9JU0gZWA8AEYEl27pICYMuBrFA2Blcyn6GY6Zfzk9zuQYekXivsKkt6c+Tq5N2IIAqypr+2M5bc9YS+k80u2Unz+iCFgVRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNTucuTJ; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNTucuTJ"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso5742885276.3
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 19:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735097136; x=1735701936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqXk+IGk/JfWHhg8SlGyvzYgkslv8WntR4niWs3MEG4=;
        b=jNTucuTJ0y6AZK1JXAxCFY+ykbND54hEYbceuEm57dFqcVbQr8iqLmQvaJ1O1Zo7dU
         /qMzVaTXHYBQAvB/iWkRkBtOamWPEAhAOYEoyQlxmd/NvVX2IhSEd3uV6mFiDAHGgK+K
         EGKSMyQt5A2B1ZStebBWVAiWZY06vPB8C/uY9BZ2XeTuiLwBsgn7G26zEQnoijzTzUha
         Q5Yhr4GD5EClkIAFKo9W1ohnwXf6JJLuYa4JcT+OFwZQkA+oUJdugONDdU7tz0VuIO3Z
         vnoOwYwVA09aaTcMXwnFkMKYhrucTodP13heaBry5/EVTyF2JB61TXnYQrxPBY29KnCs
         ZUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735097136; x=1735701936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqXk+IGk/JfWHhg8SlGyvzYgkslv8WntR4niWs3MEG4=;
        b=ksAmGgrxXpDEHGzWucURPkGdSmlqvLVn1L7aebtjiMAJh859S/CIUiT61A0WW9SmAB
         JgwbbRzeO8iVtV19Cqqz5KCsMmCpZtZCLguZWClnbhlQh4R1vl2UNfD+X3funIy8G0nL
         r8k60nyqBVLbiMelmYBgLjzS8CPkaJ4O00jckSmmf+zqzS8oS1f6OrPj7wlouQKhuD9u
         vcL3YEM/t2e1p4OB/Y3llT0Hh5KYr5sLPBnVhSDu8oszQa52363iPqltmuCM87knJb4w
         7udz0Y+45dAnnLtiwPOHSAry0NJUTyheQ2oO/MjIISj1pM3EhJAmXRcejv9/cnILKBZB
         ZCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYeYW06SFYshTBXHJwSccILBwsY2VQc6uVcdlg3OJhOY17uUAxP3aKm0fUotgNEh8B79o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMFr3IXMKqbI3hiCS5QDSAAhkG1NW3m9u/xvMELiiqUPJzMGX
	9a8UG90Hbp5A2/5IQLiFyZeTw2I3w9D8KzWgwyUOkPEy8dlRHPEX47xR7ePFtuMsp/8kUjGPagk
	4AN/fYQUG5QruYqq0dpyynau+rbY=
X-Gm-Gg: ASbGnctB4BmHhPG2xns9zu0Qf/DhozkibYmUMibHdBk7cZr1Cy6CqsRMpAXhNDULxh3
	YGOOZW77Mur6v5ExZAzEDMKllzQRxB/PGMLJ7OA==
X-Google-Smtp-Source: AGHT+IH7M4Fgy7jihRJp8AUh0/JElJcQYbQ37T0xF7nikKtLicmPV8GYZKw4NVlWzgtuchH3idwxfs4k9mprmeu5ENc=
X-Received: by 2002:a05:690c:6f92:b0:6ef:7c45:84cc with SMTP id
 00721157ae682-6f3f812626cmr134872207b3.18.1735097136046; Tue, 24 Dec 2024
 19:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
 <20241220140058.GE17537@noisy.programming.kicks-ass.net>
In-Reply-To: <20241220140058.GE17537@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 25 Dec 2024 11:26:35 +0800
Message-ID: <CADxym3Z5GKJB_+m4iyw-Ycy98usMvwHr6jBwW_zBiwX+mdPW5Q@mail.gmail.com>
Subject: Re: Idea for "function meta"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:01=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Dec 20, 2024 at 09:57:22PM +0800, Menglong Dong wrote:
>
> > However, the other 5-bytes will be consumed if CFI_CLANG is
> > enabled, and the space is not enough anymore in this case, and
> > the insn will be like this:
> >
> > __cfi_do_test:
> > mov (5byte)
> > nop nop (2 bytes)
> > sarq (9 bytes)
> > do_test:
> > xxx
> >
>
> FineIBT will fully consume those 16 bytes.
>
> Also, text is ROX, you cannot easily write there. Furthermore, writing
> non-instructions there will destroy disassemblers ability to make sense
> of the memory.

Thanks for the reply. Your words make sense, and it
seems to be dangerous too.

Thanks!
Menglong Dong

>
> So no, don't do this.
