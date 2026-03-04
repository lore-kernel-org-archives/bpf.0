Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CA23BD1B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772584743; cv=none; b=T5BKPLQAljXcsMXjJA0GjgPxe+ApA6iSvDyS/K2wAPpvOkW+6Wbl5yMmhLrxJUDwiJE8ont5KiiQByZtT9fhcOX6g376LLk7BvHrlN1EDFLvg5xvmR/zHITwXAh9LwL8aK3HJt4fL2Yxtiox9JxgMa70XlLX5JvzLO++b+EkKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772584743; c=relaxed/simple;
	bh=J9/w+GV109IEcn1Q+0SdEFxbwYJRkVeVL/l+ILzuzio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mveEX/6vt2sQln2y+Rv/TjO6NrIQ4sIveMCjfF2u2/mPMn3kdbKdNWQx2ad5mxkt/xWe5yG1UlnxPo6ntBmdIBaHBeCdatJDrDy+XeioIVYxl38nSe97W4wwJS9dy/KVHK5KMdaVQGeK2XWjtOGDMfKvjnwKQCfcjS80SM0F/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDr12r/5; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDr12r/5"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be1d9c356cso3457277eec.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772584741; x=1773189541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=stECg2pbCtjFcE+bnNiaYSS9evhqc17B1DW1uTxR+o8=;
        b=bDr12r/5mUbgnorNLOflO+Eglp059pPtKNvr5h2Gd4ivamKxPFmiQUqxKoEYGEu0/x
         5nNdrPsW4WSyytKuP/r+9NHobz45IRuoCeH9t4LWzuqhXU3QZRy9MNqOdyzViNexxTo3
         lmiJRu6lboPBgLmyRLBWeWKdwNLAUitUp72i7/LY3iz5viZ3SzGbom86RMBmG41plqER
         dmBhb8b909peqfqPby0cwd9JVdvNnoJvsyrY2wRsrv/E+teDzyjBzvZgJ2xoxIef8wD5
         vgMv0VCNwP6w5n3zzTxkELll0POge4G1F5JAV3fEhbwEwQeUbYbdZGe7Zf7GPsGywz1a
         FKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772584741; x=1773189541;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stECg2pbCtjFcE+bnNiaYSS9evhqc17B1DW1uTxR+o8=;
        b=RQMFVMCZBrOzNr9qK78l5o8tuN3j1uSdxU5p7YqMyWa8IA2UCdyTL9irWsK9ptXmTT
         9IJGf7aurwsBdzRa4ikeAC0nrZyKnEchSvIXEZwtKaQsDgSi+pts645ov0i8WIUo967m
         xFfhT+jrj3ZJm5kMTqBjG+1F0EjP3UlLAcxy9sQJsSyYQj+LVFj0/rKiMgODmh4rOdIG
         2pr/6YCvXHxCf13/y7Vo9daxfXSsrTKgUDdzHyj3eAp0+2R1ySB7o8Qi6ai/UBjJhY1v
         Ly+AwzCsAsuRDDx44fqSTUuENGpVFHlm80Y9nUj2fkfPyPlqKCrw1MPKyi4Tl4Dk+8Xw
         ALgg==
X-Forwarded-Encrypted: i=1; AJvYcCXJk/C+PHP8sYVSy8RcePgsoSKma6L/Dc59w4sJYWOHn4NV9fj7k0GmWhShgfKgBvrZVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPs0Ukzmxuberokzz8wD62wgwT70wfyr76Trq1kl1Yzh9QK1p
	HS7oV05sBkFEcOtsLu4mOdIZqJI101Ld9BS/rVyw+QEwR4scDG3EJjsD5gdtaw21
X-Gm-Gg: ATEYQzwVPcoWD6vBQ6CZVvC0YuHS3Qw5pjqqq421HJUI9g2cWWLLAvS55NTWDXTxkCZ
	jDZTYqvDuToHlbD3iETOPhcyu0Yv4EldxLvKN0M1labQd4qzp5uGT0PXwt12dUSKnhNtIpOLBVp
	3CTGczFHbA2oM7EEn1tFNZIQs4DNvVsVlBEtTsthB3oQOKaiPzYYGyG4OlGEUBRdHgo8g8lLgLo
	nDxWeezf+IOtYPBS+wxD0dR4oK+bX0FBUyOt4voIvgrojZUFj22PjHbpPyVvUrlu/W+QIBbcEDo
	inzH0N4eqXNCRiFSnq9TuV4CRvVY2gRzeZpegQw0+uiK0RE8hdPDd8NfKojAW5K9hbvzASemHoO
	ZQFb3X5vsvxLhEoIz2Gb3DsBazSqYEccg9TJk37G0Gojx/u70nYlEsAp9eNw+lV/1LPzCBrzz90
	+IoYGmWehw6gOGDC0G8RNLovzelkMQ6z7WgzDco//KD5ndx5rQ5flQbc+dsfBPB7tcq0leTsIL7
	/p8enzKL6A8kOoGS2s=
X-Received: by 2002:a05:7300:fb96:b0:2bd:d157:6786 with SMTP id 5a478bee46e88-2be3108dacbmr114547eec.25.1772584740993;
        Tue, 03 Mar 2026 16:39:00 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0d7e0d40sm6942494eec.12.2026.03.03.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 16:39:00 -0800 (PST)
Message-ID: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
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
Date: Tue, 03 Mar 2026 16:38:57 -0800
In-Reply-To: <20260304002205.15728-1-slava.imameev@crowdstrike.com>
References: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
	 <20260304002205.15728-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 11:22 +1100, Slava Imameev wrote:
> On Tue, 03 Mar 2026 14:43:01, Eduard Zingerman wrote:
> > On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> > > On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
> > >=20
> > > > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enu=
m bpf_access_type type,
> > > > >               }
> > > > >       }
> > > > >=20
> > > > > -     /*
> > > > > -      * If it's a pointer to void, it's the same as scalar from =
the verifier
> > > > > -      * safety POV. Either way, no futher pointer walking is all=
owed.
> > > > > -      */
> > > > > -     if (is_void_or_int_ptr(btf, t))
> > > > > +     if (is_ptr_treated_as_scalar(btf, t))
> > > > >               return true;
> > > >=20
> > > > I'm probably missing a point here, but what's wrong with Alexei's
> > > > suggestion to do this instead:
> > > >=20
> > > >         if (is_ptr_treated_as_scalar(btf, t))
> > > >                  return true;
> > > > ?
> >=20
> > Uh-oh, I copy-pasted the wrong snippet, sorry.
> > The correct snippet is:
> >=20
> >          if (btf_type_is_struct_ptr(btf, t))
> >                   return true;
> >=20
> > With it the selftests pass (except for `float` tests noted earlier).
> > And regardless of selftests, the code below this point will
> > error out if `t` is not a pointer to struct.
>=20
> I think you tested with
>=20
> 	if (!btf_type_is_struct_ptr(btf, t))
> 		return true;
>=20
> I decided on a narrower condition, as
>=20
> - if (!btf_type_is_struct_ptr(btf, t)) -

Yes, sorry again.

> changes the existing selection condition from "treat only these types
> as scalar" to "treat as scalar any type that is not a pointer to
> structure". Technically both approaches cover the problem I'm trying
> to solve - multilevel pointer support for structures, but the latter is
> open-ended and changes the current approach, which checks for pointers
> to int and void. So I'm extending this to int, void, enum 32/64,
> function, and corresponding multilevel pointers to these types and
> multilevel pointers to structures.

BTF is defined for the following non-modifier types:
- void        [allowed already]
- int         [allowed already]
- ptr         [multi-level pointers allowed by your patch]
- array       [disallowed?]
- struct      [single level pointers allowed already,
- union		   multi-level allowed by your patch]
- enum/enum64 [allowed by your patch]
- func_proto  [allowed by your patch]
- float       [disallowed]

And a few not reachable from function fields (I think BTF validation
checks that these can't be met, but would be good to double-check.
If it doesn't, it should):
- func
- var
- datasec

So, effectively you disallow reading from tracing context fields of
type: struct (non-pointer), array, float and a few types that can't be
specified for struct fields.

Does not seem necessary, tbh.

> It seems - if (!btf_type_is_struct_ptr(btf, t)) - works, but it's
> challenging to strictly prove it's sufficiently future-proof.
>=20
> > > This reflects my belief in a cautious approach: adding support
> > > only for selected types with tests added for each new type. That said=
,
> > > I can add the suggested broader condition and make it pass the tests,
> > but I cannot be sure it will be future-proof against conflicts.
> > >=20
> > > I think the broader check like
> > >=20
> > >       /* skip modifiers */
> > >       tt =3D t;
> > >       while (btf_type_is_modifier(tt))
> > >               tt =3D btf_type_by_id(btf, tt->type);
> > >       if (!btf_type_is_struct(tt))
> > >               return true;
> >=20
> > btf_type_is_struct_ptr() is almost identical to the snippet above.
> >=20
> > > might have some incompatibility with future changes, compared to
> > > explicit type checks for selected types. This condition is
> > > open-ended, including anything instead of selecting specific types.
> >=20
> > What potential incompatibility do you expect?
> > Two things change:
> > - types other then `struct foo *` or `int` can be read:
> >   - do you expect we would want to deny reading some ctx
> >     fields in the future?
> > - the value read is marked as scalar:
> >   - not much can be done with a scalar, except for leaking it to
> >     e.g. some map or ring buffer. Do you expect this to problematic?
> >=20
> > Note that the above are selected based on type, not on the
> > function/parameter combination, which is already not a very effective
> > filter if some parameters need to be hidden.
>=20
> I do not think any of these represent a real problem. As I said,
> my approach is based mostly on narrowing the supported types to
> reduce potential conflicts.
>=20
> I do not have a good example of such conflicts.
> The added tests for pointer to float, which failed with -
> if (!btf_type_is_struct_ptr(btf, t)) - might be an example when adding
> a new type might silently pass this check because of missing tests.

Yes, but that does not really matter if verifier treats floats as
unbound scalars.

> I  was not able to convince myself a conflict will not  happen.
>=20
> That said, changing
>=20
> 	if (is_ptr_treated_as_scalar(btf, t))
> 		return true;
>=20
> 	to
>=20
> 	if (!btf_type_is_struct_ptr(btf, t))
> 		return true;
>=20
> just makes the scope of these changes wider. This was
> my initial approach to this problem, but I was worried
> by its wide scope.

Let's see what Alexei would say, but I'd say there is no need to
complicate things w/o clear necessity.
