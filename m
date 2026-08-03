Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E152F1FED
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768780; cv=pass; b=qPjzKybDCcpV/P8mGQIaBICGjhoBlVI7srKNyaJr9EyTutDtFQT0FNzoRUvYtMWFUZXY25oN6KAgpaHlHKgaIzrJeEL8HL6nTcFsLIhj6KXdxnJFCRt9vfy4uWL+1o4AvCsYdjMp5Y8ygkYfK5MK7nbcuRTB518/sGOP6vwlRHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768780; c=relaxed/simple;
	bh=/s1sQ2l3V+Zh5c4gyB78SFEqAxnr/utg14r4UNS3vFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbknhzmpcytcRlNzMLGuw4tt2OcAJP7/8jE75BQOwbjI+yjTCElR0lVCdDQePHxVn0SqIKBVd3+WHAqW9W6ZezRC3lix46hECDPjeCqW1DHUamACfFYxKFqce9wQjktIlpetY4+CKxw6mAfJYJFC9rJk3az/GOpVuAc6szIVyDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAMnCYPX; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAMnCYPX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c169ae1cb26so795478966b.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 07:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785768777; cv=none;
        d=google.com; s=arc-20260327;
        b=h4Q+7d5Y4udcJS3O86PSpvrfYiHORrbT2JecJYlNpYu8OhNk9UilCLGd4Yw2CQA251
         P/IVX8lrJ3jiCTHUWV43GbwaWYtquVi/A+1lKggaAbWdlsniVQ56ugtTZZ1QF8qV6pW0
         AtCQh2S7Cr5oPwoe0aMjx3+U42e5BxhbjA6bDABbmW4rLDSLGCpPbHv5a4yFermwWjKC
         bKVz4kD5OTQg7jlo7l2a9TTGCDvygnpZM3tN3QFN6wNa/j8m2d4yLuG4lv+SYEIvcE13
         66TapDXr5jxl+3y+x8OFUzVok4tzfKNqPiy8QYmDJKqGAtO1Drcj2GExAs9NqGwO534C
         sAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        fh=W4zgvaciPvu+gyNBZoCQAqBlb+JTJZHKnm39esXowU8=;
        b=aPJ2Z2rdX22L2F+eH9aX73I5f6c4nIzRKb/wj016TKdAHl7QFf8rGA+ni36hW70U0p
         8R33Eoy4AcaO5Qz8JGJDAkHd8GYmXHG3MYHQex3VI2TbibCP3ZWHLpGBITv2pBOjqW6d
         eYAP88e2CqJal4e88YdINAZHeqondgxZGlCqJg37lL7LPCs7Ul8toOrzMAmqQzPmz/vr
         v/GUH3Gaqgf58iqjPNf+EAHYLgQ6QIFlmEkuu8fg2Ep8JKXIB5ggid4qbavGDtW+juhE
         oHQJ1ItBUwTplK7+j+FHJRQ/877J5RFwuTug1MPNFOjeFTE8GaqGjKxwFWQ1CrRuiar4
         WaKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768777; x=1786373577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        b=dAMnCYPXhWcOH5xbex6kByUJBiyZpP0vR4/rrMKWmUog7wnY42vxlqY2smG4cFZ6ZA
         oeTZD1ZvH6O98zS9+2YyxzjJHrTTGtx2If41IN36rdKX2z6Lo4MPOupuEE75It41oVe5
         IvqG47RJH0BKFvZGyOUpK5LWBTuADM3+vddRUzzA5jXkPuUICCdLCkji0PKzABmy4LJu
         6/VAITJsNsr5zI0f4GlAXpqV1TxZud2rIMv5yIckuBIeC/WiTlIiSIrHDraMMsNV2ARH
         U/m1ZJo/NUfE39dcle3xgq1lagvLDOLSVSmTckuFNrkW4PVYglaQdHn80E9L7LVA0SyF
         j4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768777; x=1786373577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        b=EeyZO4E1zkIosNkmjwUIYqJIh+R5OAu2QdsOp7U/0uPbrHiDJiLa137ze4fTYM/goJ
         kycw5jdhHf6EWrWmLMTlwNpNAQ905qkgXMiOIRFaSRBeB0qmdG4xyORWr24EDflCz7aJ
         aQb3ZMGz0R0A07xACR1/IquwZ1ZpuHHp0hKv+q+7huAZaCfBpLUgdD8o+svYFO8ZfbbD
         APvwiMDEtAv16ltKG0q+6namntrVZ7lfFNYFGtjh2N/hLIS5qghRh+21bysFS0YhEyFk
         W8kt1csS6rMfNQie7VZH7aeJtl54mXpzlAD3kd9EIB4o63LraotqFw72wUmJanKnkt5n
         yNrw==
X-Gm-Message-State: AOJu0YwaBOIcAnN90K+uW+ujUqyyWFpnzpFmRfu7lpaAQkql1iJxHfAC
	RgebRpZtRBUOpzc0pimQyUJD9Lb8/QV82Tgw6gn0BGSJhFB4/HiYJ8Pl37fN7vEdZMwb0S2vMBs
	9bWVGcRNXg6jwUPRNx1ayMaLkRT/fN5w=
X-Gm-Gg: AR+sD10mA/tU10nzOiFBY3crMVOUN+irQ0YG5jGhGEqdpamiEOZnDYbH4cLl9ZSeq5G
	icZ7DCrkgMO2OjnzkCH6kvK3wljxadNZia0X2i2ev4lhpdRwxIU6lFCFx0kjmXfmUESWskSgy/U
	Nm5GlKlOsZuXykY+DJ7vogkMe6dURGCJFXt2jn2pvGKRGPS06YFHcczgETokcivipLNUanwVAr2
	KBHPLU83z/mQDArRyi/UtG73QuoI8e5G4ECOqU+viPkFrQMHUu9pXegA7WETbC5zBAdVj3/K9bZ
	TF7mg6Z4JM7o4ER+W0rj/7I5zclZjOjfFSXZFdGLjwGIGGS+Q1XFdHzQrDlzCXyWb7AnHb8=
X-Received: by 2002:a17:907:1c18:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c1fe79cb8d4mr727328766b.11.1785768776864; Mon, 03 Aug 2026
 07:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134839.2103051-1-puranjay@kernel.org> <20260803135329.2327280-3-puranjay@kernel.org>
 <20260803144919.2D8C31F000E9@smtp.kernel.org>
In-Reply-To: <20260803144919.2D8C31F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 3 Aug 2026 15:52:42 +0100
X-Gm-Features: AUfX_mwMzyeDA_Llb19LD0lSRMTtOT-ohduGZiy-4600iqiO6ncPTdl5EcnNmtQ
Message-ID: <CANk7y0j12i-Ck9h=Lh-tVD2wv=rp-OKydnkX=tz0436Sgr2GdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Tiny SRCU's call_srcu() remains unsafe to call from NMI context,=
 leaving it vulnerable to list corruption.
> --
>
> --- Patch [3]: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from an=
y context ---
> commit e3be0303432c7c7afdd4ed014dae0987e25bf7d3
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> srcu: Make call_srcu() safe to call from any context
>
> This commit updates Tree SRCU to make call_srcu() safe to call from any
> context, including NMIs. It defers callbacks via a per-CPU irq_work when
> interrupts are already disabled to prevent list corruption and deadlocks.
>
> > srcu: Make call_srcu() safe to call from any context
> >
> > call_srcu() has the same constraint as call_rcu(): its callback list an=
d
> > locks are only touched with interrupts disabled.  srcu_gp_start_if_need=
ed()
> > enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,=
 as
> > do callback invocation and grace-period work.  A call_srcu() with
> > interrupts disabled can race a list operation in flight on this CPU and
> > corrupt the list or deadlock.  call_rcu_tasks_trace() is call_srcu() un=
der
> > the hood, so a sleepable BPF program freeing an object can reach this.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does Tiny SRCU also need a
> similar fix to safely handle NMI contexts?
>
> In kernel/rcu/srcutiny.c, call_srcu() relies solely on local_irq_save(),
> which does not mask NMIs:
>
>         local_irq_save(flags);
>         *ssp->srcu_cb_tail =3D rhp;
>         ssp->srcu_cb_tail =3D &rhp->next;
>         local_irq_restore(flags);
>
> If an NMI interrupts call_srcu() exactly between assigning the tail and
> updating the tail pointer, and the NMI handler invokes call_srcu()
> (e.g., via call_rcu_tasks_trace()) on the same srcu_struct, could this
> overwrite the tail pointer and permanently detach the list?

See next patch it fixed tiny srcu.
