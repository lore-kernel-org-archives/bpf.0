Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F4338596
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301727; cv=pass; b=mt0MTkzMpAmewSxjsGLJPJwxutIeOP40nrhyuxO9Rqeiwdvw0UNO9EeiqR47lyT2yxNw21Nz52Sv2SxdX+EByXeong18TY7E+BwVqZCCOs6AuQti+JQpyofw+uu+Nk4JGtcCnKuqNLYCx/olx0G7fUAe4YGb9SamHo9I4Oh1sGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301727; c=relaxed/simple;
	bh=cDAkfdaLRfmCvVXnA0yRMRfwD8UYysD3SIVaRGrDclI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuGrByaooBov741udKvzMYgdB7vbz7/5LN/wU4fiKDpABaH0iruQsQt/8FflTvr8oLXp3mURvvQWxYqYmHmvUFhb0QO9IuG47S6rtzQyhaxEKrVyYXNu3g9cdm+XK38y3HQVSmF6HVrv7jPIT5ixGBWI5EEw76Su6P6oVSyueSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWAr/ZxI; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWAr/ZxI"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48611ccd5aeso886483b6e.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781301725; cv=none;
        d=google.com; s=arc-20240605;
        b=GtWliOY11wXDyMUBphJjz1+NCxEH6e4regTTIIOgqMcEaq3mT4qzjYB9l6J/EHD8uK
         xsfEmCarM0hd8fmUxIiUkSSplaDUcEH1yUnlUsffno6CxbR5fWk17Oexiu6SmcBkDerK
         7dvluSp0TBfJc6GiUH19GQYzlqcmL6NV/5RxkVVLhVregU3NrwT57m7mPipb42YX7Ymx
         jZ7ca5Mi5nlMGru+hhjgOQ7jbWcuSrn9b1LKI4OqbDMoMKIM8dtGxKtcOxxX3tYPmO8N
         LeJgzYAq4706mUGSXdQd4WYE/4v54VViSfR4NuluQKzRlPnq1AR9CnVsmorcwW807JuR
         08Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lr7PuuvzhjV3VzJLoKFC38vG+nAVtfp8SSMy3aUwQ6A=;
        fh=XoCrjX3odcVIMBNEXOLIUiIyFpf6GIQkwLIRk/PRcKk=;
        b=ZlP3MG0blNlJ5Ef2lqR/EDFvz6U1oVltuEPs1vHcc80DIqvSRovAIPyxDFrUucpdFN
         NBx6Gi6rHM0sXo4eBT9cxi3cCRfW9zyuf/BC0nFJWIwBlBGXry6EbGXIfNvrxo3ldovG
         HMZ3qDQCX4VJzV3194cZRWI7SqhtqzQfJKuzA805Bnr2ixrksc32dDtMg7pJCXSwkzHU
         LiNuG08pu8g94j8KzooYyQV0oXP4mdmk498W+/IB/aPZRgkFfTMC7IEEMNV4zFr2bQvS
         fAW7soHf/Ooi4sTbDr/6GI5j3uf4qvNtQ0whrtoKYDHX7er7VEvPgUxEJ5J87VArtWZn
         R8DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781301725; x=1781906525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr7PuuvzhjV3VzJLoKFC38vG+nAVtfp8SSMy3aUwQ6A=;
        b=JWAr/ZxIXuQbeJJwdoQicLIgIqXoXNXmRsaCQ3bAFRolJEyu7ecm6NrfBbs5BkkY9H
         bNFYsjZ1G/0Gbk3BW85ePrsLbGRQ1GxYkek0BUbGVhDKr50ody/kUXZqeUWgk0bLE5/i
         QRvoJhvtw93Dn0RfSBcQzj0m6xAnF7/N4cx/cO0Zj2Kn942WJYkDoKNGXf8GHRPJg5DP
         28UvJsseQwCRbTj9Pfht/RoUVlTteBRgcfJHi+PybAK/eBcePRvvF+L0OuVbknUjOLAO
         hwvV3sE8BixKGGep8FPlQJyVmvktGodpP25cFMhZNLI0efWY5fYmaQsm0rVmsMp/IAbQ
         /uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301725; x=1781906525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lr7PuuvzhjV3VzJLoKFC38vG+nAVtfp8SSMy3aUwQ6A=;
        b=dwHucwn/p0PKViJRGJYzrzvjKvYUXdMyUN6r1jqxbUCiNVVS7s5ru1wwo7Tc/i3UB7
         1J4XPa8q+jO8x1YU8Nq504aMMrxIGvnuLxjE0v7JdfjSWiCsWLeoZ4eubzM0cVr6faYR
         DbZhdK8Nk0WMRt9ABJXV98yA04R+qTJrrlG1ipwxBLYlTo5pvZl2z8GbE3PVkw1G25Rq
         GeEYOOdot9azth+fKJGec7Z/Rh5ucC72yF36yNSh+f5hoFV/Ltgc9WGPWeupnqK2N395
         DbnW4iLf+A6bM8zWOVWTWYgNucNmBgTJoEkft60dpd4MkmCyGgOidCi/Heauk4j4soKz
         DLHw==
X-Forwarded-Encrypted: i=1; AFNElJ+FSnbfjZcXTGDnVG/huqG0AQ0Ly+wxF+MnMdnC8M5E9NRw5kGavm46QhgvRMZdcpc8PdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln792645/uyg87bitfrcHTuGYiqHMf//QSho6nAWIBmPaxEuC
	nNJBx+dENFK2WMto02YqaBluBRTguIXzlrHnXi3Y58ItnfocWCndPky7FzVYJYhHnXI4CiWXNuZ
	X1GOvz6DWCrtZIcBe1TEtj7FWZbmg8b0=
X-Gm-Gg: Acq92OG7fx/liJqMmWUfu0DUsxkBwdxUSTLBuRuZf33HPsulQTWjR92227nCTBoqUy2
	ST89gvvqvMJzFsySU88NMPJlG+m6HwKg5R8+5pT4rWU4KPeUICBKgVJoQL9gGvjOmrdGhTyluZ4
	oP8euhUKEmcDOqeKJ1VGNdfYRy583eIChWU8f5iJXnvX206VM7vSovZBHyJPm7ml6T5V4YP4SQ3
	8DKTpaJgnCn1PWeFr4ZfYjczCU7PCdgbUgyANA93jpKZdoMCovUxE8phM0A5WhAcgvh6XRGbj7S
	+lfOuTGT4N6bpJDBukMblh30Htc0ESiUccbloeY0D4VE+ZAAVWirj9WTxyij8II6ErgCHwhyxg=
	=
X-Received: by 2002:a05:6808:3a0f:b0:463:efb4:f9a2 with SMTP id
 5614622812f47-4872f493555mr3330241b6e.28.1781301724761; Fri, 12 Jun 2026
 15:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
 <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com> <CALCETrUArQBzUS2mAhYxDS-unze_gnQ7efv1qeBke-ux=2KdkQ@mail.gmail.com>
In-Reply-To: <CALCETrUArQBzUS2mAhYxDS-unze_gnQ7efv1qeBke-ux=2KdkQ@mail.gmail.com>
From: clubby789 <clubby789@gmail.com>
Date: Fri, 12 Jun 2026 23:01:53 +0100
X-Gm-Features: AVVi8CcPCqPkDoueJ__frRsNImZP3mTgK4w2ichmgt6_4IvZ-L4SX1qks8EWNvI
Message-ID: <CAO1UbGcJEhwtHcxy5zcc8cH=YjfSDiDa2o-o8o+LMbkmL7WFcQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 10:24=E2=80=AFPM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>
> I wonder if It would be reasonable to have the kernel do this on
> behalf of the user program that's asking for STRICT.  The
> implementation would probably be trivial.

I experimented with this approach after the initial AI review, but it
turned out surprisingly complex,
requiring a decent amount of refactoring to allow installing
kernel-resident programs. The filter
itself is also rather complex (mostly due to needing to account for
BPF jump sizes, which differ
as different configs (uprobe, uretprobe, SECCOMP_ARCH_COMPAT) have
different logic., and I'd worry about
keeping logic synced.
If that approach is worth pursuing though, I can submit that version
of this patch.

- Jamie
