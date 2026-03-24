Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AF30595C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380836; cv=none; b=XNoJqSAllatWiVvOA4XSaUCTqNa/5tb5WqPm3Jpz2Kxk1g/uiMIEu3sM/r9MWvWkDRedUwtf8kULAzYt9sNKCCvnIXXjipyAs4koMRgfaq5USRZZ7Zgiz7A0KnMpRdi4Jx/4a5KkYPIhpZcIEEYb0HFUieL2y5VUFx+0jw0/5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380836; c=relaxed/simple;
	bh=YPa3OlHZQHQcse4VHD1bGWQSnkTfICpradR8dYdmznE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtG59o3KXYN9gZklzk6lRaXwmr53YOJgmeASZQtK5jsmLe9xdTMIx5vi9rwa9xKH4I1jffmZiLigWiEMfrsuOPL9KruQHDelBZL9EPKBbgdWRBQ+3J3mYNIZkqbFZDuqVJNsPh9PtYZT7GHJW1Jirh3iqkY7JentbX/xYomGPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4LRdmxA; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4LRdmxA"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0f754e756so2050850eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380835; x=1774985635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QCFGqUyXSc27G5VbKUMAxY0nregM0umwX0rgUYgLRMo=;
        b=e4LRdmxAttjF8i5L9vFcv7l/GeD7tcXtFiUqy9BrbHKMvt55wuo+Mv8+RNPgDELDJg
         qdvAUr/+stUmP58zn8rL9lQILaFKvXUZUR03+YoGu9dNVZBt7UrBj0vucBBx2h1etCIB
         4b8huNnvEZr3xChyq4ZzNd0FLS+6LLRUvDI1DYRrd/wu8g4HQj9NybO4N6e6XcdAnmhH
         sz0aZwBZtjL7tdS9VzC7Hwo9cej8OvPOPw9Yq8qRORKNlRjYqxcQnXYPSTN36NQrRVde
         XcGhX9FvuxQuJBNcpHCCqP7os4RrsYcIHQd4zOuranYDELqLqejQNXvQFb4un/E6HAzv
         l/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380835; x=1774985635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCFGqUyXSc27G5VbKUMAxY0nregM0umwX0rgUYgLRMo=;
        b=dUQ/CTa0JWZc/HBbxorNWBUIXnn6kL08QXl3qiSeClBbWhGa5/5DN/cf4epwUFoQ9G
         giMIavmIKXH5byZ1lKXeOpOlnkJLfrHsWnMDQPQW8jxxI+v9rPGmK2gwQCtelhACbcLk
         LkprbZZ8rsAj3L/ud2faR+u/PlopyY4VYrpIU3b0znxLtum6WW7ds7wD0I1sbEKmzpLJ
         2fKT4qgk4nNf03j/uIVmv1ztCxQT0lu9/q48nF5AGXwoeHKU4Ef7sN8YD9ajxNRLCclu
         gMrWpMZJ/gZfrmJNB4l2/izya05KBTi9A5cHQSjRK7B9lz5NTZ+xlwtfAh3I2krxyeFa
         NmXA==
X-Forwarded-Encrypted: i=1; AJvYcCX95ldqaXaJZt1QCuoNdRsqbUife79mQg8TG2ymKWkQVbMdY/QH/VQxiEwmraAGeps7j28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AHLbTn/mixLFlRmA44W/IQuel6ZEJWpUHkNRe+nbkNEwbrPh
	cXAiI8+0Jtr58xieHot4Jr7TCpxl0pQ3/1S/25zoMuvwUfWdrlaL6u3YcjLIZfcA
X-Gm-Gg: ATEYQzz6BHuREOnOFslp8IzOjLG4lIVR3H8bpKuAKIBzOWQedU2Va5Xd+ZisSYejI8s
	0NTpjowMrXfsYchnqA/2GcyVpdPBlPg/DZX5WkPCGP4RBdIWVzT6UC1D+FlvaNX2tlqSIqMWozs
	iytYUooohIbutG6L0WABL3NYvT+znNgxmhpEPp7zkXsfd7WQPdiFD9MeHXkAvpjEe7k1psjm0sM
	0n+EuCoX4a20xgf3vdfntVwSdTCR1nJM4w9wVRV5QwILL5Jr/PU8MyB5Qq6onB4Ne/bRFXGq2QC
	tuEUv2JBuyTSXEy2ATmeSUnQmhuqk2exWNUA+cz9YoS4+Sts58L+1VaKmbxVCgkc7GBS2/MrDAx
	Nj9/eO8lrEtwrrlvnpqZDXHXmy1ig98asU2mSUPE6ujHOOlZmsotGVWy+E2ilbpAiB4hj/QYGiD
	S1ZD14jLQLd6DVdz/+drlFe4SH6w11QAgKXQr9+SSX/vfOKVvoXUe8VSBesE7eYqp/loEzjh0S/
	Q8TClD8Vnihs/+C
X-Received: by 2002:a05:7300:dc04:b0:2bd:cfce:4c4b with SMTP id 5a478bee46e88-2c15d32b6acmr275370eec.2.1774380834781;
        Tue, 24 Mar 2026 12:33:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17d1ddsm15827159eec.11.2026.03.24.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:33:53 -0700 (PDT)
Message-ID: <54d5347331905486d367542613b71b09fd81134c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Tue, 24 Mar 2026 12:33:51 -0700
In-Reply-To: <CAM=Ch053GkzkXGxNbfE6Xo=bcR0di_DraDPLP-6y+YJ2rQ3DDg@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
	 <ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com>
	 <CAM=Ch053GkzkXGxNbfE6Xo=bcR0di_DraDPLP-6y+YJ2rQ3DDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-24 at 15:28 -0400, Harishankar Vishwanathan wrote:
> On Mon, Mar 23, 2026 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> >=20
> > [...]
> >=20
> > > @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_=
state *reg)
> > >       reg->var_off =3D tnum_or(tnum_clear_subreg(var64_off), var32_of=
f);
> > >  }
> > >=20
> > > +static bool range_bounds_violation(struct bpf_reg_state *reg);
> > > +
> > >  static void reg_bounds_sync(struct bpf_reg_state *reg)
> > >  {
> > > +     /* If the input reg_state is invalid, we can exit early */
> > > +     if (range_bounds_violation(reg))
> > > +             return;
> > >       /* We might have learned new bounds from the var_off. */
> > >       __update_reg_bounds(reg);
> > >       /* We might have learned something about the sign bit. */
> >=20
> > Is it possible for the invariants violation to manifest after
> > __update_reg{32,64}_bounds() calls, once cross domain boundaries are
> > propagated?
>=20
> The short answer is yes.
>=20
> The sub-sync functions, i.e. __update_reg_bounds, __reg_deduce_bounds,
> __reg_bound_offset are individually sound (checked by Agni).
> This means that they preserve any concrete value x that is contained in a=
ll
> the range bounds and tnum inputs, after refinement.
>=20
> But if in the input, there is no concrete value x that is contained in
> ALL the range bounds and tnum, then an invariant violation can
> manifest. Note that this can happen in the presence
> of the current early exit commit, i.e., even if
> range_bounds_violation(reg) is false.
>=20
> For example,
>=20
> before reg_bounds_sync: s64=3D[1, 1], tnum=3D0
> after reg_bounds_sync: s64=3D[1, 0] tnum=3D0
>=20
> Could you elaborate on your concern? Did you perhaps imply that we should
> be checking for reg_bounds_violation in
> simulate_both_branches_taken after each sub-sync function?

My main concern is that we might loose useful signal.
It would be nice to adjust reg_bounds_sync() such
that it would stop (e.g. return false, as you suggested previously)
if it hits invariant violation mid-step.
