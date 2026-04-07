Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B31FC0EA
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600046; cv=pass; b=Zw6h/p57jerHYXvCBgzE7n6BzmltmH8S2kgLrXpyP5zrE1zCKhXlndUlqrKLclj5G3ATFXNmFP0jQ8nCAPLk3BTD9yEqCAP6v0fs5aO/quMBkKdUdzXMOjmkmXdVVrmH6Ow6vnZvWKkVjS0BPQCUnmi0xVuErcYU9z3bMZEnpWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600046; c=relaxed/simple;
	bh=iaK6l0EdBauLQ3nTEzENIt+2mQg3t5tnQeAu7LUlX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXbcPGqN6SKw/z/26Koa5TmTo+q3th287VwoKPcUzTaBDrdQ7PzH2nFPgxdkWUU8TF0b6rHW+RkFkUVreLb/nMmNfV7bo1iaNpt2tmjTiX3gegUCuqyCkY09hs/UWw+krEMg7Z7ia6zHAK+Y9XckkPW6U+TNjvGIgY6OGtvcwuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JikpQ66A; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JikpQ66A"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso41947205e9.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 15:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775600043; cv=none;
        d=google.com; s=arc-20240605;
        b=HxqZW3AdpT7oFiFVk50IkbKjsW6LBUPnyL97XHWnXDKaXA12yfmd5iWlkJLGdIQFBr
         a1Pyb6vDa5bhzvWQitrwraqiwCZdEKRpkJO8dpHqzdxU5qPhIFurLh5Phhec955hFAaJ
         5Tn6DjYyi9G91f3enyQSbCFy4M+VSzChGhjMW2mpL188EkeW/hTvZQOwhgAQxlL6qeJo
         KGfObnzUsFKMfsh+ny03eLhf9HE8gxn+HaaWns3QLfgDoAaxaFCgY+1OPaCQb04yqir4
         Dtz+ZYtK+qX5X6L4VLZ1ZjR892gBv6kX30I7HP/uam9rn70InZyaWGqqazEoy4dQPWbK
         3Sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkJg2QWrRgji7lKDqipaGVZEawOkuFxxlijrZlKXzmo=;
        fh=h9i0AYhqScJNeWFSYB4NklZgWOr8s4aSjIrHWmm91p8=;
        b=b8euRszYe7oD126gZIYE08CDKMtOvmlASoumZbnNYJG2mxZnDuwhuG9N4EIsM7dXOz
         w84YkNyj+GuRwgTgNudSJ8GuaTs+h0G7CQaSv0TXxyCE04t/+CJDU5aKJ2qNKcS4R/EH
         jBxwUE2zB51Ailc/ceqO60N3KIkoMiXT49bUYba7O941O3y3w5xKmoyi4J1mEM3226VU
         SNDOOr/h1QGY6E07Uc2jy7DDnA6k3m2moB9AMgtBkQSrkCadPjkYmgjreRG6VB9fZA7g
         7335YVQCOd64w+6z++0PlZs7inqSD4y58pAKr5iJZd0aw70nCml3PB1pmhDkBqc229Kv
         j5wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775600043; x=1776204843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkJg2QWrRgji7lKDqipaGVZEawOkuFxxlijrZlKXzmo=;
        b=JikpQ66Aq4NVd74FkIWs5eKWDrNHxVxoj0oExzUmU1gi5TphB7H26U01mk1TC8AW1f
         XTvSxWtKzcJVgrr9qiyon08aIUrfyem3XQHoFJZzdm2QBkidqlCaN8dk/or1DU1ir7vj
         QxhzG4AniR+Z5UpsjH81iSarebW5EK3LvHwxy+/ejXyxhET3xB61WfK33N3mX0TWalZw
         f9E+txv8A4NYtnsW6PEHAZlnGkJK1Oh3RQteDt1FTiUtGnk/yBYJYwxolThFn2vtmNCz
         QKHRPU93mqeai3YqDQa/aOX9MYSPdrZEOYDMeXEt6bnBoqWI4UBOrI+fEncPPYc/NEe9
         IlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775600043; x=1776204843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nkJg2QWrRgji7lKDqipaGVZEawOkuFxxlijrZlKXzmo=;
        b=JYhQnDpUv3Wf5KP9R81u4vC4QY7iWitH1zwvutHkWHTcypi/r3w3a81Uc5goUuggjo
         4wFBjGPQ1PWPICqkCV2AZhEz1ZD47i0xoRp+/pb58yd/rFN9GoCMjBJHNAff2EFzMXNJ
         OCkHTkSCGoah5CLyHJUudOmwex+4cmvkksC6Di51dlDbagwIxiX+P8uU/lJ12itgFt5Q
         m8P0YLqklp4cw5cSIOHZl9syNC1zy24Dwztu5+I9WFKqF2rm4HJENwOunHL1tKEd2c5Q
         sKJtqy7J5IXla08ekkRlcXzUS0qGT07S39Gygwn6AxSldJtxd3jpKzovjZny9+5wsJIv
         uGNw==
X-Forwarded-Encrypted: i=1; AJvYcCVQp13NkIYJMGGdkpFHAl2USYRf0P0swhdoDMk4C3Z1TEeimSfTU5GQIV83VY/ocuwGnl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaVEoXT7mrWs1/5hQc6LxP1WlRcplRGp+1uMdxzNw0M981g4e
	IMiEs9dppBjMkns97GQUscOFBNbaxFraBmzFEtXuKnNAU8VA8xr5iwChjIxeWNWOUU/lH1I34cZ
	loUTFk8kTozQzTP49gTzzv3jwGC5dReI=
X-Gm-Gg: AeBDievOnLP+wPXMMfkqbUwknEL6XwGyv5LGOyNqRj8WGhaBeXRDkHeCLPos9yIXlVA
	SBILYKwQlB1n/7Ea04q9z/SKLcfgh3HE6CnBIcDjWh7xO1aXUOgSPNutG0c4m9Y1jp7nz1qljDs
	xWFJSjTyxI+cUgsOtPZinbtpjXvdSVz+QhSACXPcDHIjJy6UdHDmawVWSQ0hEilolbcow9tmxuc
	FPGvWnxGmMfvtup8C/GUOSVx49ge21W8s4jfX6XyJta+AIufT9h7bm0378Y2m2bINVxPuvbhTxz
	YZ1bS4R0ATYf2yftFL8JqEYMSHq9ThPbeqNQhbQ20vraYNpH9gVs3PH5QGllvolTk+6e7Kas
X-Received: by 2002:a5d:5f48:0:b0:43c:f40f:6c91 with SMTP id
 ffacd0b85a97d-43d29285606mr27805671f8f.10.1775600043381; Tue, 07 Apr 2026
 15:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406150548.1354271-1-ameryhung@gmail.com> <20260406150548.1354271-2-ameryhung@gmail.com>
 <CAADnVQKgKkyRfoFNSsCi3ykquzsO+-bZnvRO=V2LqyOMiB0ydQ@mail.gmail.com> <CAMB2axM=ocGBkJ=UB0kcE+4MfYLUroR8G=ehr+00215aeG3EOQ@mail.gmail.com>
In-Reply-To: <CAMB2axM=ocGBkJ=UB0kcE+4MfYLUroR8G=ehr+00215aeG3EOQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Apr 2026 00:13:27 +0200
X-Gm-Features: AQROBzB1Pt5IAX123HngRh08i70yLOH0_T7hgOYAizDM9QmczXy3kDZMuXO7hio
Message-ID: <CAP01T753d27xGfvow6G_DQq1nQS969NpQLeGbqeE_zwCD0XH0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow overwriting referenced dynptr
 when refcnt > 1
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Apr 2026 at 00:05, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Tue, Apr 7, 2026 at 2:27=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 6, 2026 at 8:05=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > The verifier currently does not allow overwriting a referenced dynptr=
's
> > > stack slot to prevent resource leak. This is because referenced dynpt=
r
> > > holds additional resources that requires calling specific helpers to
> > > release. This limitation can be relaxed when there are multiple copie=
s
> > > of the same dynptr. Whether it is the orignial dynptr or one of its
> > > clones, as long as there exists at least one other dynptr with the sa=
me
> > > ref_obj_id (to be used to release the reference), its stack slot shou=
ld
> > > be allowed to be overwritten.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > Why ?
> > I understand that it's ok to allow, but the features
> > adds more verifier complexity and more things to worry
> > about in the future?
> > What's wrong with disallowing?
>
> The current limitation seems a bit arbitrary and adds more complexity
> to the mental model of dynptr object relation (some dynptr slots can
> be overwritten but some cannot).
>
> Actually I think about it again, the check here may not be necessary
> at all (like below). Even if a referenced dynptr and all its clones'
> stack slots are overwritten, the verifier should still reject the
> program and report reference leak.
>

That's true, but when we last addressed this, the message was kept
here early to make the error easier for the user to comprehend.
Keeping it here was preferable to showing "Unreleased reference" at
the end of the program, which is inevitable once all references are
overwritten.


> -        if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.=
type))
> {
> -               verbose(env, "cannot overwrite referenced dynptr\n");
> -               return -EINVAL;
> -        }
