Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E843C872F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994712; cv=pass; b=UPLAKHcLw23Ga+ekaHz0pG2qNts0z0sNqkq3dVVEcNkB7bQVwPDKuwcuIAfT/zLP5vuIFCpW91MAx2AUn6FjLWn/HArvKaMw7gj7/h8MtXwLCtoTsX4u0zrAONHnmk7GIRm1n5IVMNnLMfc/hHf1PYWhDo87rd39UqHSVHaXTRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994712; c=relaxed/simple;
	bh=aVIpPJDxtVjGTfUw8kQm/EJ+Xr7PeRLNbyuFyTTwN3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJU7HWdOovKc3dE8e8OgXu4h821ANR+BPSH8FxTGx2acjb+fnL2xYH53Ayp/v18wg9u0Z3HEhzRhESWnkivMyz1nN0ljEw5FEDccx3rLJAFRNOdXCk89/Cm45epajessOWOkpBQCxihCu5UQSKuRXnWrlRllIvDw3TnLFDNNZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cK700kJE; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cK700kJE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso3053881a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994710; cv=none;
        d=google.com; s=arc-20240605;
        b=TQCR///mkJNMlmqoCoOlJMMi2h6g1ORPPFiPq1q6q3vlQVUevBFvXvRFpwR3FybTMQ
         goKFOlELIWH74SfhlEOP8UoTVYPPq6ZoX6HOkFoGubcDI3xYWyUg3q1ucoWbd6iBED9W
         DJHwiG22FNkJfjFpu8hit4dgG7FTTN8svtOCeeRe+D9dF69BXk30ds9xXro/YA/wKzmA
         JagFmENYnS2EUc/KwNhYnMS9gLvz9mkD8VCO0RR94ZRmDiFq6J+9nsPNbc0GXMGeJjII
         SwQFeJL/IzlA6FYNIsKtRRXSYz04Zj4FmBwFH+ELQwUapK0+99Cx+plw6PAgwSCNK450
         5LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        fh=PrhBGfhRuyPzwihEcQNZzrXJ9s2AFk4rH3YSBKNGEgU=;
        b=MOWZsoxM1WSFqXt3+Bp7htLGCCkYOpyxujsVntllCkuaogBG4kEN8Q2WxkXQnUMNMd
         s+o1Byb/nQH4WnF1NLmL/3WqQ/bIy62X6kx6btY3lHOzPbnG5wrDT51G/ViIzYw0uU9c
         LAt+l3FolxPSeYzT/IcRnr1pf/N+EwEd5Z0w+GJ3GAcsI94ujVEGs/fnYVAslNn0ztFw
         nVYjJdiyufIciu+0A70cbx7dPGCsLTK8Wwb7fwG2lp1jD71V7fBTBVzKJ1KuidtOi1kX
         p3TDIW+nJ2KM2Lnrk3Ig6asDn9TL7cE2+W5Q8pqfl/szMRk3DRvCGamCQ9R1EPJDZxkb
         1nBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774994710; x=1775599510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        b=cK700kJErZ3XTR83YmrvrOIJGcQRkoNv5CKJH03tF81ANmsX/hERPsaUZd/aKmgsDL
         pXZhznvHmYvHhAVhXorUiZMVGhSlfyWwn1eKv0qm3GNal9RN5hdxQaRNL4JUp3QK3/In
         drPXv3+7h46+XLrbBuy9lMF1nivoEDVg2fKoOD3fjeIHVeNkC6eWlsSJDyotKhU8fh81
         YubMJa0ZRLHhSe87QBGXDQcJO0CMIAp5THH7AYNeAoAD8Yd4hvh+d1BGUdD+hVkZOW6D
         Zhd9DR3VXp3FClSrgOLhDXovflqcNSQyCLZ1/uao7PC1B/EdMq4WMC7hShMWZ9bBG4+s
         yvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994710; x=1775599510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ep4GCTgxX8JIYhXvMhkjfxUN+0Y0dj6DzLbtLvfj93U=;
        b=V1ZGL9Xk/JAPCPwZ34Ho4DTyneIkxocEofssVMa2/bqwCpteFLmV3tADxR8pBy/wQQ
         V0Z2Gee+MBnZjxLzBLZWYfqxsz0TvsiFl7/qJZIIGMBW7bqdhiFmxKyOyfX3kqffNeHa
         QyIYADcmErtdI3zHju1iJXVrPn2N/uLJmgXLQC3eKDAgWeai8Vy5tP2rwzTb4WRtvW4+
         5bp4iO4vc90TPNl3qPSLqyYiXYBopcwyMFKQH1KHbfI6TdLf23W4+m/eJ3wOCp0VhRAM
         MJ301TLmUiVBcRdoFi3HPzYb4nLMCqciFBXJiEtIqoTetxVtNCrnansRBIlmnvt1MPnO
         wAig==
X-Forwarded-Encrypted: i=1; AJvYcCWF/cW8YHLTsd3GEjw8HAbRDkvH5BBONPfOrlNM8/z2qtic35ognww+4UV8Xd2zyk3K9KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7SABvyFHbhczNv8n1l4Nn81WzHdZHXZ8qZotJsYpJbCaIabD
	q9vvjKZXGqlFvJDKZl7LhDK/NNzUMEV9sb3yJXhsdDe6VQjxMymOEI+/ppYhudvhq1D3UcTI9qR
	HSEuIbWfTqtqoRRpWdFqqA2GyPqUYc7jeWYk/f2Ep
X-Gm-Gg: ATEYQzzL59ywe7yEbps672BfSD9sOwoJL+v/Ajslbt6c6GXt9l3WRI4lwvQqaCtMBsm
	A3fHylBUyA7v2J9/liQ1d2dy12KWwOYcwQbfaX4Sl3qhh4OZ4hN7mvUBen9zfYs78JRdEC1aYCc
	T20rkFhalH2t+hM9tgJY/ft9g1cC5w4e9aTjRCTD3Zo52wAGo/WRQLXu9ntJSh5M8/694Q4Qgdo
	TM2d14AGoD9B6An0pV7205LjANn2xjsloXH7QObIXdCylU0THBRwAnu5IlMA50dqv3T3hF8OOo8
	463raZ4=
X-Received: by 2002:a17:90b:3e4e:b0:35b:a170:f266 with SMTP id
 98e67ed59e1d1-35dc6e6d5d9mr852192a91.13.1774994710597; Tue, 31 Mar 2026
 15:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
 <20260326060655.2550595-5-bboscaccy@linux.microsoft.com> <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
 <871ph5f99z.fsf@microsoft.com> <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
In-Reply-To: <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 31 Mar 2026 18:04:59 -0400
X-Gm-Features: AQROBzCUIiXEj4VIIcZZGbFprLIdepai1hqVM7-_X8-rSxluuSgqIzTNSpqHed0
Message-ID: <CAHC9VhSeRuQ0t+bU29o2z1xeC+g+6h9e+RWnfEKqpzT7rv2Vcg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] lsm: framework for BPF integrity verification
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:25=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Fri, Mar 27, 2026 at 10:54=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > Song Liu <song@kernel.org> writes:
> >
> > > On Wed, Mar 25, 2026 at 11:07=E2=80=AFPM Blaise Boscaccy
> > > <bboscaccy@linux.microsoft.com> wrote:
> > > [...]
> > >> The first new callback, bpf_prog_load_integrity(), located within th=
e
> > >> security_bpf_prog_load() hook, is necessary to ensure that the integ=
rity
> > >> verification callbacks are executed before any of the existing LSMs
> > >> are executed via the bpf_prog_load() callback.  Reusing the existing
> > >> bpf_prog_load() callback for integrity verification could result in =
LSMs
> > >> not having access to the integrity verification results when asked t=
o
> > >> authorize the BPF program load in the bpf_prog_load() callback.
> > >>
> > >> The new LSM hook, security_bpf_prog_load_post_integrity(), is intend=
ed
> > >> to be called from within LSMs performing BPF program integrity
> > >> verification.  It is used to report the verdict of the integrity
> > >> verification to other LSMs enforcing access control policy on BPF
> > >> program loads.  LSMs enforcing such access controls should register =
a
> > >> bpf_prog_load_post_integrity() callback to receive integrity verdict=
s.
> > >
> > > bpf_prog_load_post_integrity() is weird. Some questions about it:
> > >
> > > 1. Is it possible to call it from other LSMs (not hornet)? Specifical=
ly, is it
> > >    possible to call it from BPF LSM?
> >
> > There is nothing hornet exclusive about that security hook. If the BPF
> > LSM folks wanted to use it they would probably need to implement a
> > kfunc to invoke it.
>
> Please also include the kfunc in v4.

Blaise is welcome to provide a kfunc for
bpf_prog_load_post_integrity(), but I don't see that as a requirement
for Hornet's acceptance.  If a developer wanted to write a service
LSM, like Hornet, in BPF to verify a BPF program's integrity, that
developer would be responsible for implementing the kfunc.  If you are
interested in doing that, I suggest you talk with KP as he is the BPF
LSM maintainer and I suspect he may have some concerns around
supporting that (see prior discussions around BPF signature
verification and his own implementation of BPF signature
verification).

As a reminder, if you want to apply security policy to a BPF program
load operation without considering the program's integrity or
provenance, you can do that today with the
security_bpf_prog_load()/bpf_prog_load hook/callback combination.

However, as you pointed out, we ultimately need to see at least one
LSM providing a callback for the bpf_prog_load_post_integrity
callback.  I wrote a toy SELinux implementation when I was playing
with Hornet a couple of revisions ago, which could serve as the basis
for a proper patch if needed, but my understanding is that Blaise has
been working with Fan on an IPE implementation.

--=20
paul-moore.com
