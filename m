Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1DE3164B5
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626304; cv=pass; b=L4HQhQqZmAzRR6HAbHViXLQj+rFt4UrbVF1PeS3zrEXoNLox+AmhScwbjsIamZauB70HwG7Ji1M/RVdedU/9qs+TcHreTuTCb3ZhlJkPjn41haJOONwezXbpJyyZTXhx6Kpv6RIMlWwKIkT1kh+q6dTMxaDclgJvyZR15rQhG2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626304; c=relaxed/simple;
	bh=40mmVCv2uq+EcnxMirNhzQKqSJlZ6U/4w5ziU0gjUWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQQH0Q4gG+XStPOSl2yUzv3ZIjGgSIFoY6HyKKBu3BsYjsg+OEuS0J1Z2xHkdBcbRL3axlHTg1CJnofMTXPHqoNnK+zi1clFqTJUoV7otrHHs3GAtFe+/4pp88keSVCA8bdInzVW/eBtuSIvwaAZm3o86Y873Jf7noosgIvy3yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtXI4djA; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtXI4djA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b980c65b97aso347644566b.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 08:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774626301; cv=none;
        d=google.com; s=arc-20240605;
        b=O+IIsx4FEiPHXvTZWYpZO9+pD+exxnCxwCHI5O134qeOQGoRmuFhg/X4r3TILxzBNy
         /H85S+5IljffJjUGICCnMkpcWZcjXPrhs9CULckYyV7pknP5o3hZHVw/UfqyHqN13oTp
         vrKFaItT1vakBLLqz/m1jmSmt2RDdusIbat/xdvnWKYV01Lr3ws2i908bsBO/XYN9AKS
         iYZ0g2X9T3McEeiZGzSkgxZj64c6wbtE1w41j9nF2s/TS2/JbNoLXbCSwgLz8EqGya5T
         N4ZTAfbDElyz1TNXZ0ErZ1MYx8ufZrZ15lfH7uCjuO+OpWDArcaS8yO5fr3C0455nSbA
         JLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40mmVCv2uq+EcnxMirNhzQKqSJlZ6U/4w5ziU0gjUWs=;
        fh=nUpz0W5pdA9Tknbu9YUn1AVIkF/nHfSgl3CMP7Q4ClA=;
        b=aYlbmv6Cj2WHOZcRgA/ZuKrUKMccudLDUOQGEs5oYbgDldlLABAbd9q20WmY+vZmgI
         /ChqKJ+IAYiuEiAipOjHJZG1rmm+sQhluhDOjzUGWQiku9OHwIOJyE4VXeMwOvek8zYR
         kuB1K3JkpfyCNBWR2+4S/QNFRNzaW1HVMiS3dINRCzYMrXiaokGcC57708d/3czJSl4+
         oBgBo2C7zZLNdk2ZBHGh+TD/5ZhCe2I5uuV0JHy8GlpPZO+sFlKs3mnLhEJhP/QgUFFr
         /lYetVV54sKcWZxsokvBtmGO8I7P7usCQ/1CoCYUphqs6vY3Ael8iBN8mmuwqvwfr/cE
         iCww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774626301; x=1775231101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40mmVCv2uq+EcnxMirNhzQKqSJlZ6U/4w5ziU0gjUWs=;
        b=gtXI4djAhZlG73g19mjRy2/VFonqz+F7kL4RbUw1Z23MIIIPDpyAUI5vvxm0N4Cib8
         aas2ZU8xzt/Zt1IlbA1S1asgCC1nrifS51jIGs8TyLFnHRfBFTo8fRuAGeO0ZgGeICxE
         Aj74nqpeuHqPxr+Nc1D+WIgkjW0I79sKm0hMOlW5B2oUqF/vuFi4BJo9TwN2q2QlC/5B
         JjkVfaxKeU28tq2tqvhrRTDHxOCNnyPIGs3ZQ/naaCccFm73D012LwpGcCRTgyy6CVfN
         +MKBJox9bVfLj2FGDGnzq1Qt832GjbCi6OAQBAvui2iwfDs0XZ3Ljp56kmtu+7UtM7Tt
         +D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626301; x=1775231101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40mmVCv2uq+EcnxMirNhzQKqSJlZ6U/4w5ziU0gjUWs=;
        b=kBb3yTdWV/mtubveiap3wB5uzG983xkys5sSsDj6XFHF4qKEGTOInMjfLzYsMNNqU/
         dUVu0OfgWet93UK8j/tdZB4Wy50KV1hAr0bhH0zWHFYskuqprshyWGDcoD34Yov7Z8Tm
         I/15Nh4XdpkS1Lhv7Bjy2ZILdnjszyk/O9CroDuofX+N2r7/j0Ib46ib27RuqZTCV2FK
         tAM5LhpyO3EugDvHMWQ9KRq5n37v9xvOGPzXwXKb0GzKJj3MBeUdXw5r6sHnjkU1U/5G
         zltzX/ZvOPkIBtRVRJS2UaljwDeQysz0vWYo+Qt/46ndD4FF1xdUT7AqQ9PQMUlDwEVa
         FKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMzw0cFc+qSakg1vQ/gwgOqiVfr+ohKtcaDqcO4uOKBKwPMOcGvGiBfDWSnALRmRHCQWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLeaG/rckdtT4xVu06SGfntpyN3Wyoxo1p+ynWqDi1U6fDTLZ
	UzxedQaYz9OZfSlZKg5JWjC6g67sfCHuJX2D4HvXAcrMy5Ch+O3XMULRr5VuSlo4yFRg2/BPs8M
	pi0OPSZxwrDb8TURCHpnP/bYzesMUoLY=
X-Gm-Gg: ATEYQzy0EDfkFievbSb93tHnGkmXztCf7q6wZyrDG/7ZCD7EVkvZ4Nj+zEz0iiDZfZZ
	bZa88dnoy3k76jqu77oDw3tMVVXeFw04QPrkEF+c4n8XFHMZr76CbR3PnRbUc69OoE++thwPT7a
	0rx3wFe2wNrnr8ht9HHlcIg6PhJDV/eCz7Uu4BtD5p+Xlz0CdMqvbF3Eg2HOpGmxQMo0rsJXtMF
	mT9jC2dtq2/KBGh2dQp+53XeYz3+UW+XfWBtBUuW/tlERZw2wTP+7RuIQHZ8GHVHlYLPBycjAey
	QEgVhqH9jJCdDGIdeJji34YkFFwRivL0AvX/FCw=
X-Received: by 2002:a17:907:e11c:b0:b90:7fac:c668 with SMTP id
 a640c23a62f3a-b9b50312597mr151970766b.11.1774626301062; Fri, 27 Mar 2026
 08:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com> <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
In-Reply-To: <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 28 Mar 2026 00:44:49 +0900
X-Gm-Features: AQROBzDUZdbXu3NU8UK6OXVcQkaAEutR-Vuvd_IgNdNnVFG6OEs0gxLIHyQ4_NM
Message-ID: <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I was a bit surprised to read that this area ended up taking
months of follow-up work....

One thing I am still trying to understand is what the preferred
debuggability/observability direction would be for existing
tailcall-heavy BPF/XDP deployments.

Tail calls are already used in practice as a program decomposition
mechanism, especially in XDP pipelines, and that leaves tail-called leaf
programs harder to observe today.

If fentry on tail-called programs is not something you'd want upstream,
is there another direction you would recommend for improving
observability/debuggability of such existing deployments?

2026=E5=B9=B43=E6=9C=8828=E6=97=A5(=E5=9C=9F) 0:21 Alexei Starovoitov <alex=
ei.starovoitov@gmail.com>:
>
> On Fri, Mar 27, 2026 at 8:12=E2=80=AFAM Takeru Hayasaka <hayatake396@gmai=
l.com> wrote:
> >
> > Hi Alexei
> >
> > Thanks, and Sorry, I sent an older changelog from while I was still
> > iterating on this, and it described the issue incorrectly.
> >
> > My changelog made this sound like an IBT/non-IBT-specific issue, but
> > that was wrong. On current kernels, fentry on tail-called programs is
> > not supported in either case. Only the regular fentry patch site is
> > patched; there is no tail-call landing patching in either case, so
> > disabling IBT does not make it work.
> >
> > What this series was trying to do was add support for fentry on
> > tail-called x86 programs. The non-IBT part was only about a bug in my
> > initial implementation of that support, not the underlying motivation.
> >
> > The motivation is observability of existing tailcall-heavy BPF/XDP
> > programs, where tail-called leaf programs are currently a blind spot fo=
r
> > fentry-based debugging.
>
> I get that, but I'd rather not open this can of worms.
> We had enough headaches when tailcalls, fentry, subprogs are combined.
> Like this set:
> https://lore.kernel.org/all/20230912150442.2009-1-hffilwlqm@gmail.com/
> and the followups.
