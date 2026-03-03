Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1C38C433
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577791; cv=none; b=cNtq/whaRaWhp3bKK1cRdRgrsnaAoEWA3dVsoVQd7UqqOzmqNBv9vvGEJuKyswpvFBqGxjXYJnACpdZ9NljtoVdsbxxou6vrc7ZFSdn9QxkT8aY2YTWxxXR8Jd67r8ZaY2WEQ8k1tjCErA6gWVSkY8mdycwGEZN1MSsbCogl8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577791; c=relaxed/simple;
	bh=iRzTm4HZX6p9XF+OOGdafL6UcWV2KOdLvI4VUy9DbI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bicb0kH5SBhQ1TFGO0xIrNvH50Ge9hl0T80kMdVfBqpPvlbFPhoA61GOd0Do9WwdHC84/G88MR7hIlnFGxQk0dR9CbBu9p1jpM1q/20mFVwX5J3GdMmrQItZsOKwA5JgOrYj7vSdvCK0V34VNPq/vquyFQUkSU13ow87SBER1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/GOrEKL; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/GOrEKL"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be26842fd5so447833eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 14:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772577785; x=1773182585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+g++eAKNPgksF/0EobVZq+2vjzSAkpXPfK7PhSs7l5I=;
        b=Z/GOrEKLhYYDcpMAgAX0nCKHVWMfEjkVH/gJtOLCBuGGgzv3r+MncZE1SfOdwxqSf8
         EhgCwi0+A1/H7T2wsrypWCA+9357xB7UtkByf8WoKwLKvXTjRatSjqdFnZq6sBtqVHtV
         1AJHElA8+dtaHZV4+ch9/d8e0+69WhEndwymNikyv4T7PYinjw/v2db8xJ179zAMad/6
         aUJJWwl42oq99wsSFmtLzfbnKmlh+2rD12cI6LlqdCWHbbOxVAXs2x9Z8orPKXhX3L+r
         00ewyXgVSeO2XeOrS0P5yItlRt95mQ6bZWr1iRSv+voL2Q5ZjvA+ZG/Y5TRjw9NL65+6
         Rkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577785; x=1773182585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g++eAKNPgksF/0EobVZq+2vjzSAkpXPfK7PhSs7l5I=;
        b=C+90ia9vuwpJ1ono3XSDCILgrQZviIt2OD4XBQyG/wkY9xMQ4fpYDbNs/NGGsXrIs7
         DoT9jKtz7hBt/mGugfEWh8QYys2gNB5RkBZrRtJskp2m+xzh7EDPCH6MWWpYOHb7xlk8
         zDyS96o/oYHkaAKzFjAIDEwJ620xs7C4RgzEpAeCX4n9WNrt3LOVJJ5k9l3vlexPtmH5
         uv/m1L7ZgZu0+EV8uO6Yc55jfBTNNwXhAE+qsT4asXYxKX5djyhK3zhp0R9ktVYUbhtV
         Vk8f+qxTceHViV4+hiAADMse2ZeK5SWMnluRxoxfdynzuCOUYwlV/ZqZNL8L7NC0nQ98
         n78w==
X-Forwarded-Encrypted: i=1; AJvYcCUCYFJSIwdmgOXTIJERtunE5NkM13K2dF1PKe6uzKFkizSpSz2DCfsL1gzw0ljw1dPKmaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC34QiCPaUZlxE1of1KfXnvaF5blrnNGZ8RI+cUjMxqHaZLk+V
	yY2CeBGQGHXMTCFCr7azVf3GtfVZxWNXSJmOrTuT5t73ZkeFxhlxpM9o
X-Gm-Gg: ATEYQzwEsEN5C38T3RXUmiJkKv+mtL2wURWHs1JjV5FZC+N6feBxiWxgtltz/aiSK+/
	c3Od+DdfX7zgTpupNoMfTyM/w4SK+NDQeEDoEUQXw6QzP4hWe/2oKNgZOzS3uZTegNTW3hVnUsf
	90GRdlUQ9MYF3KsX8U/BM5SIGAjysGySxSzQkwtrZ07+TRUMAgwkwH713KoB/xJhnrAo1oLEyZy
	5V0wVrwunGcKicsMVJmVuveQTyLitRUXgUbV5qB6UgMCe5j1xaVFwTRpEG1a5zVR4H8gxAcBUF/
	RTKWtEFv9bv8y1ERpcRmh8H+FpGVDX6kaSD6EBdkn1yLfEu0/FqLsCbWC/BxJmUKfLIW2x+SYm5
	njbmEmiACnYzRyEUDMLTDMyWxPjNZ/bBgA0/yDL2uLugOA/oVaxMTzatKUHNMLlhsNiP6qE1PD7
	llQTXn6VIzd2Exmji2eheLWjnDz5yc/wQ5t4W9Bw6aEO5pylMUh4KMPl8+H0ll78KyRXYuG9Mjh
	F4pqsW/
X-Received: by 2002:a05:7300:dc83:b0:2b7:bc31:11ff with SMTP id 5a478bee46e88-2be2345bc93mr1332769eec.8.1772577784573;
        Tue, 03 Mar 2026 14:43:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm10054683eec.7.2026.03.03.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:43:03 -0800 (PST)
Message-ID: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Tue, 03 Mar 2026 14:43:01 -0800
In-Reply-To: <20260303214929.8208-1-slava.imameev@crowdstrike.com>
References: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
	 <20260303214929.8208-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
>=20
> > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bp=
f_access_type type,
> > >               }
> > >       }
> > >=20
> > > -     /*
> > > -      * If it's a pointer to void, it's the same as scalar from the =
verifier
> > > -      * safety POV. Either way, no futher pointer walking is allowed=
.
> > > -      */
> > > -     if (is_void_or_int_ptr(btf, t))
> > > +     if (is_ptr_treated_as_scalar(btf, t))
> > >               return true;
> >=20
> > I'm probably missing a point here, but what's wrong with Alexei's
> > suggestion to do this instead:
> >=20
> >         if (is_ptr_treated_as_scalar(btf, t))
> >                  return true;
> > ?

Uh-oh, I copy-pasted the wrong snippet, sorry.
The correct snippet is:

         if (btf_type_is_struct_ptr(btf, t))
                  return true;

With it the selftests pass (except for `float` tests noted earlier).
And regardless of selftests, the code below this point will
error out if `t` is not a pointer to struct.

> This reflects my belief in a cautious approach: adding support
> only for selected types with tests added for each new type. That said,
> I can add the suggested broader condition and make it pass the tests,
> but I cannot be sure it will be future-proof against conflicts.
>=20
> I think the broader check like
>=20
> 	/* skip modifiers */
> 	tt =3D t;
> 	while (btf_type_is_modifier(tt))
> 		tt =3D btf_type_by_id(btf, tt->type);
> 	if (!btf_type_is_struct(tt))
> 		return true;

btf_type_is_struct_ptr() is almost identical to the snippet above.

> might have some incompatibility with future changes, compared to
> explicit type checks for selected types. This condition is
> open-ended, including anything instead of selecting specific types.

What potential incompatibility do you expect?
Two things change:
- types other then `struct foo *` or `int` can be read:
  - do you expect we would want to deny reading some ctx
    fields in the future?
- the value read is marked as scalar:
  - not much can be done with a scalar, except for leaking it to
    e.g. some map or ring buffer. Do you expect this to problematic?

Note that the above are selected based on type, not on the
function/parameter combination, which is already not a very effective
filter if some parameters need to be hidden.

> This broader check also needs to be moved down closer to the exit
> from btf_ctx_access; otherwise, btf_ctx_access can exit early
> without executing the following code. In my case, this resulted in
> existing test failures if the above !btf_type_is_struct(tt) replaces
> current master's branch condition
>=20
> 	if (is_void_or_int_ptr(btf, t))
> 		return true;
>=20
> The result for:=20
>=20
> ./vmtest.sh -- ./test_progs
>=20
> was:
>=20
> 	Summary: 617/5770 PASSED, 80 SKIPPED, 82 FAILED
>=20
> with a lot of:
>=20
> 	unexpected_load_success
>=20
> Compared to:
>=20
> 	Summary: 692/6045 PASSED, 80 SKIPPED, 7 FAILED
>=20
> for the master branch.
>=20
> As I noted this diff, closer to the exit from btf_ctx_access,
> makes tests to pass:
>=20
>         if (!btf_type_is_struct(t)) {
> -               bpf_log(log,
> -                       "func '%s' arg%d type %s is not a struct\n",
> -                       tname, arg, btf_type_str(t));
> -               return false;
> +               info->reg_type =3D SCALAR_VALUE;
> +               return true;
>         }
>=20
>=20
> > Only two new tests fail:
> > - #554/62  verifier_ctx_ptr_param/fentry/pointer to float - invalid ctx=
 access:FAIL
> > - #554/63  verifier_ctx_ptr_param/fentry/double pointer to float - inva=
lid ctx access:FAIL
>=20
> > But I'd say this shouldn't matter.
> > This will also make selftests much simpler.
>=20
> Yes, I decided not to add support for pointers to float.
