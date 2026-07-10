Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E994071EF
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679277; cv=pass; b=nNXk7DyQLak6hZF7uDxmgDvZMP/TmuQXnZ1HP5T9xQytihB03vlF66PpLNSuLPsmnHKd9gEGz+naMQansxgRKuTfqcVmQQOzapRyehR9v9YtjdiX0BJTSQJ3lvfP4O43IOJ7GgJMJKtXStpmhvGrE0FQdNxQA87oZkUGYyljih4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679277; c=relaxed/simple;
	bh=YWOH2gdV2ggz9J8J5hR0LhUNueb0cLGyzdzHC2YMZV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFtp/Z1nZugE2HRnlCREzMlIBUXrcWkO9T9yLsqc3zfKbxbD403Rzh9tV+NzjIggaUTxU8+skzP5rrOwCpKnYcLgIc7vsCZjQUqtXuus5YntP3KLjz+sbhbybBxdYIDcNV+oi3bYYPodVtmEIEXrDSiWjJHxhYWQvkK1MnDWbzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E915r+Ww; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E915r+Ww"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c5cb9a888so8824177b3.3
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 03:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783679274; cv=none;
        d=google.com; s=arc-20260327;
        b=ReC4ifz1OOfuPEnO1mtRoATd76/qrQk+BQUomJvTbb7twuL1a782GjmCYDFbKiggRA
         3OWeYyC3arINX6nhfl6JMZn3td8L+V08oUilO2iS/ZL5vVizaJHpm67rjqO30tT1ONuI
         sM0UfF6d8HWL8WwYu6gEvFAqk7Q+I/EdNoZaou7SWetDtXWyINK4dLngldxOI5Cr4Dwz
         buhVOqBcQsd/3jcIUTYkK4UeGskhHQx2i58cfj7uz+h5tv5EtgIPc7ugNVUHihMe1S1w
         JJJ9/OqnF2KUNgk3hB19p7cDkYEOMu+FZZHdrn5qjiUJRE+KLhfj5W0J/5Tn1KlSmOJi
         fQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y+N2R5Z2OVq5oQm+VkZnqkt7jPTNI92i6oG4KqjbCgg=;
        fh=qYx9sIqvbXoDT+xoprZjw5ByhB4jXAWd9Djzq7tgvOI=;
        b=bz9Ts86ioiIn7MSbZh9J80qjF8z5hpGPnwc3WwhcxMIXCDt5YtikjxM/24swnUnzmF
         weW+LDPc9WG7WPzz1X8Ob4OFPNPCPye+DCKIW/T3cUCCaUDV3GtkxfHLWh9XRedkPHKm
         l8a6EAuD44BYD0picZvIPZFjdxH0PFrHE2WjhpAQMvFWHjl3vrX+3qvm5Crc+viaiXPq
         XxfooyixOwGRE6iIWzloHbpQroyH0V1Ft4qDKwaPek5HppAAoa/feqS+xicnLF/wXklX
         L5LQtosSW474wbY2gk0PmVwblS6oEjJ+Ms7clyHlvyJHNV+RZVaUJQNV8VIayhTU70q2
         /iig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679274; x=1784284074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y+N2R5Z2OVq5oQm+VkZnqkt7jPTNI92i6oG4KqjbCgg=;
        b=E915r+WwTHg+n9d5SoJEkRQIjJuDkqN9RTNKv65vXDyWHaZDeTholzjyzBBlaHJPw2
         vlwY5JE3p2TF6it+OSi7Wy7gso+a0rkUQfBagGJVg1/jXVDiX+fs/TldwA3Fty5I5FOb
         ro5QQAlCtIlq/f4Y40BSgzIeYc6t5DZcp3V+OKTCmXfrbh3w/ESrd+Zgqzubpu/xrR9D
         +DtLfM/t8GzKxnBELh4I6ykszcaM4hXknNSwgMHqCDNuuuMvYTKbo8gHGAKqzfRRpXPW
         maCK/K09rlrTKgFQQPISSXffTN5nfhlDbMUWc3OfwJupIDj2Uj1ROhfIRmRQ6tm4q5/B
         M8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679274; x=1784284074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y+N2R5Z2OVq5oQm+VkZnqkt7jPTNI92i6oG4KqjbCgg=;
        b=ngjXONlRwpC4FC7mCtNz3VaGk3+dLFex3zrAVJ+OxLCgrUxSOIU+UzIpIVeBbE5vJY
         pWBn6M1O/RYIGPOBXBnLBUStGLaWNGVjxP0yF925ldWOJRJW0+gM71T/1MAAi2sPxrf/
         qydubVA89YF3rOUwwn8R1CXzu7gw8ARu1Ay4WqA6xXGur5+WawLWxm0CBYL7S9yfZWGg
         S61oPqXMvLwZHneViBaEnaNnUBa7x5Kb+6VShWyIj0t62Acop+nLvrIKcz5/Ciw6xe5S
         /rC+adnO4J13TcgJ6aRaC6daWr9an7jLyImfX81N+dFAIEzhi73AZ0KCTsjNoJAEJKuu
         PkBg==
X-Forwarded-Encrypted: i=1; AHgh+RrmiGvOtm3L24c5nO0wDdTbBGJmqGUhPyZ32MVvBqPvyWOx1ASA5stOEQVTstRJyxae+Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKazImWgEOxdPm0d7wBzfNVyjnxYmNr5ajhMnuXpkIzSNmbhT
	krSbOZnj8kc20jfoscjkot1z8UnxRCembImxm863RiVjtqYmNptEYbfgSW45xdHHAwz8wGG+hdf
	LR7BrUo//UrZzVzVoHtenw9R3ifBAED8=
X-Gm-Gg: AfdE7cmy3MaAuqHDkz6cdSMBY0Kn8yXWy23BDKJ59v3QeYD2e/6lnP6qgVwUzEkzilF
	gh6/xMwrERkwdFB+XyP6q6sQtrJRVnvtYOl1B6ABiyDCALxeRwBQu5Q0/562y7/uelgNIiFaElT
	AcEB8emZeYVUEtT9CUOfTW6CvuDHmV7DiKrhD9nxvndkEFGvq37sVq5MJqnNZqwStknIekzJ3AJ
	Kk6FGbVljBKd0DTtnlxQJo/3udl4r9OvC+/ImrFclGr8lMVgZRiBQMNtGrP0ODxshPYm4kZIwAC
	KkobRgp5g+/pho8glGw5KXPIRQqdP0ufuBGtxLG8
X-Received: by 2002:a05:690c:111:b0:80c:85b6:75b1 with SMTP id
 00721157ae682-81dbef6be4fmr87972367b3.58.1783679274561; Fri, 10 Jul 2026
 03:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
 <ak8XSRiLKx5WcIQw@u94a> <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
 <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com> <alCgmxFh9q-vjE0O@u94a>
In-Reply-To: <alCgmxFh9q-vjE0O@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 10 Jul 2026 18:27:41 +0800
X-Gm-Features: AUfX_mz630YoM6lbLRCoORghuPKQ28m1yv1PsM-GnBec52yS3qAsNIG6LbRoaiA
Message-ID: <CABFUUZEnd9f7tV-+jT+cgL7sFVp7pL5-tjdwMvxcR9ist1s-xg@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer pointers
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 4:00=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Fri, Jul 10, 2026 at 01:52:26PM +0800, sun jian wrote:
> > On Fri, Jul 10, 2026 at 2:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > > On Thu, 2026-07-09 at 14:47 +0800, Shung-Hsi Yu wrote:
> > > > On Wed, Jul 08, 2026 at 10:11:01PM +0800, sun jian wrote:
> [...]
> > > > Actually looking again at 022ac0750883, moving the `off < 0` after
> > > > tnum_is_const() and bringing back the `off +=3D reg->off` removed f=
rom
> > > > check_mem_access() is perhaps the more faithful restoration of the
> > > > original behavior.
> > > >
> > > > Though reg->off no longer exists, we have to use reg->var_off.value
> > > > instead. IIUC any register of pointer type should already have its
> > > > var_off bounded to +-BPF_MAX_VAR_OFF by adjust_ptr_min_max_vals() i=
n
> > > > theory, and thus shouldn't overflow `int off`.
> > > >
> > > > See the diff below.
> [...]
> > >
> > > I don't understand what this patch is attempting to fix.
> > > If you run the selftests from patch #2 against current bpf-next both
> > > would be rejected. If you extend these test cases to exercise a truly
> > > negative offset, that would be rejected as well.
>
> I tried to exercise a truly negative offset, and it was indeed rejected
> on bpf-next. I had thought it would pass.
>
> But more below.
>
> > Thanks for pushing on this. I rechecked the issue more carefully.
> >
> > This series targets the bpf tree, with base 12091470c6b4. On that base,
> > with only the selftest change applied, the negative-offset verifier cas=
e
> > is not rejected at load time. The test fails with an unexpected load
> > success:
> >
> > #664/2 verifier_raw_tp_writable/raw_tracepoint_writable: reject
> > negative const offset:FAIL
> > run_subtest:FAIL:unexpected_load_success unexpected success: 0
> >
> > It is possible that current bpf-next rejects this earlier through anoth=
er
> > path, but on the target bpf base it does not.
>
> So I think I now have a better picture of what's going on. Before
> 022ac0750883, negative const offset is rejected at *load* time because
> the const offset is accumulated into `off` before the negative check:
>
>     // check_mem_access()
>     off +=3D reg->off
>         // __check_buffer_access()
>         if (off < 0) return return -EACCES;
>         if (!tnum_is_const(reg->var_off) || reg->var_off.value) return -E=
ACCES;
>
> After 022ac0750883 the const offset accumulation does not happen, and
> thus now negative const offset is no longer rejected at load time.
>
>         // __check_buffer_access()
>         if (off < 0) return return -EACCES;
>         if (!tnum_is_const(reg->var_off)) return -EACCES;
>
> > > And this does not rely on UB.
> > > Consider the current code:
> > >
> > >         env->prog->aux->max_tp_access =3D max(reg->var_off.value + of=
f + size,
> > >                                             env->prog->aux->max_tp_ac=
cess);
> > >
> > >
> > > The types of the expressions involved:
> > >
> > >   reg->var_off.value + off + size
> > >   u64                  int   int
> > >
> > > The promotion/conversion rules:
> > >
> > >   u64 + (u64)(s64)int -> u64
> > >
> > > In other words, 'off' and 'size' would be sign extended to s64 and
> > > then treated as u64. Hence any negative offset would be represented
> > > as a large unsigned value in max_tp_access.
>

Thanks for checking this and for the verifier logs.
The before/after logs match what I see as well. Before 022ac0750883, the
constant pointer offset was folded into off, so this case was rejected at
load time with:
    R6 invalid tracepoint buffer access: off=3D-8, size=3D8

After 022ac0750883, the same constant offset remains in reg->var_off.value,
and the program is accepted at load time with:
    R6=3Dtp_buffer(imm=3D-8)
    processed 4 insns

So I agree that the behavior change comes from 022ac0750883, and that the
right direction is to restore the load-time rejection of negative effective
buffer offsets.

> I entirely missed that, yes, the attached-time check does prevented the
> negative offset going through. So there isn't a bug, but the behavior
> has changed, and it seems better to restore to the one where we
> straightout reject negative offset during load time.
>

One detail about the attach-time check: I agree that some negative-offset
constructions can still be rejected later if the max_tp_access accounting
produces a large value. But the runtime reproducer I used exercises this
specific access:

    r6 =3D *(u64 *)(r1 + 0)
    r6 +=3D -8
    *(u64 *)(r6 + 0) =3D 0

Here reg->var_off.value is (u64)-8, off is 0, and size is 8. With the curre=
nt
accounting,
    reg->var_off.value + off + size
wraps to 0. So max_tp_access records 0 and the attach-time writable_size ch=
eck
does not reject it, even though the effective access starts at -8.

On the bpf base without the verifier fix, the temporary reproducer did load
and attach successfully:
    negative_bpf_load: PASS
    negative_raw_tp_open: PASS
    negative_test_run: PASS
and KASAN reported the stack-out-of-bounds write in ___bpf_prog_run.

So for this particular range, this looks like more than a load-time policy
difference: the missing lower-bound check leaves the access executable on t=
he
bpf tree.

In any case, I agree that v5 should restore the previous load-time rejectio=
n
semantics. For v5, I'm inclined to follow the direction you suggested: fold=
 the
constant reg->var_off.value into off before the negative check, similar to =
the
022ac0750883 handling in check_ptr_to_btf_access(), rather than keeping the=
 v4
explicit access_end form. I'll hold off on respinning until you and Eduard =
are
settled on the approach.

> That can be done by reordering `off < 0` check after tnum_is_const(),
> similar to how check_ptr_to_btf_access() was update in commit
> 022ac0750883.
>
> [...]
