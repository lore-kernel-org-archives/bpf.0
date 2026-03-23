Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2463DEFFC
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295690; cv=none; b=iwqdkQ19MfX0Q6amG0vn6nwmDRBewPf7Awhj82Suh2UEwdc2Cj5kadRJHdW97j6E4sGCYDi7q9UiCo/eTFNVmrxhiFqhqZ+yIDgETthXoRY/O2PeEFr9KD+xNyvL0lAuJO6PVnL4kCJm0a+OXGulRaxWXP4RG2aqpCt7YoNFsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295690; c=relaxed/simple;
	bh=SfW0O2tC8WUioRc20Piub69BeEFR7zqbsDuyCT+69SA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxgNzoKNzDAq4hMDgljtgCWrLdrpWDHUvoa9Vxd6Urxs39k18BWyhXrL4rgTCDmDQgf00ZxC1Gh9y6bgnWjsZ0aJNvo+PWHX+xbtmF8qQV4/EoHpl2z3ODpFR0ieL3Pwl8Zha8e23T37VPEOT4UtnDGqwwoLfMhBX1VvoEV3vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO3lI1C8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO3lI1C8"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0d36f3888so3157239eec.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295688; x=1774900488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mc1Nw7owLDXyLNm+3hUXEvEDLeL/MOn1sMxUuUp/3fg=;
        b=gO3lI1C8UA0ugJwO5vuTXusl39ojp8lEt04thsk82RFyU42TB1WigRTndZvWtAvM7M
         YaYzGoJkkHpRxraB8DQSdyWGSOZLaZsvsBAdKgdZ1RBEfuBxlJT2cJUXbTAed1oddvV6
         ddIFWnNl6rnFwthGtdjSw11Tx/6OD7UU3iQ+FdhJzHAXEyqtgz34SNIw8OxN4uf/oSSj
         FLtC64JwlO9opfMr6eA3h2bqBGKkkV8frS5LKmcv/tGsh4mOjbf0rrhI/a0owBD5h+FO
         /OGSTSW5Vr9ohbwHTIGan/+q/NbFeveErv5J3a4lRkzL/D7dvKF0kBiQ3lS+8ntr6d7j
         tC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295688; x=1774900488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc1Nw7owLDXyLNm+3hUXEvEDLeL/MOn1sMxUuUp/3fg=;
        b=nG++4IRKHoo4kRFjKc8RUihwYNcsdEbIxMTI/zHRiaE+4thmn05RXbV6ZDNTZUZgge
         iDZh24iHUcPMwHJFIaI28mK9lzvDHrz36jIYIqlLm45MZjXj/f9Y5A0ZYoYd68tcxmmE
         z1ZHtITTRvtbSFKB2sNg2T0V+FCqfXsz/RNjYM9nWcUubawUqL6GjsSKL0NBsOMsRgCJ
         rwgNQoqfvw1zMyemJU274XaX8Ulgp/aG+PSl1d6oWvlMIM9KcMtF4EhqV0n32DVPfYDX
         SKqwZCc71Td+T+lA6TwTt5kr5C0Mqq5GKAm+YEhYBDySu377vRWJHX48yfsNA/Sa82kh
         6QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxJVJpHF4842uH+Q0Oqg3uPq+U4Y2LKZgpsoN6xYVPK6+RXuMo2HNjltLm9qi+R8/uYeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYJ5mbk3HoVpIWALEKBmrrDd5Yv/ys6seMpbGuLewQx8T9Fw0
	I45ojqgIjGBtrHnAs3E0D9xRNj7hTKoP8vx+6gcjCP5g9t1cdiHJV76k
X-Gm-Gg: ATEYQzw/ToniEb545Wy/R7U1b8UutAEa6Xfnqw3TZ0bXU+/eisGGTcJHFFUbsQLv1k1
	cNfwEFI9nSC+UsYWofJaPAIruYke1MuBS50Wg0CE/iXoav8GS03QnP8gnyn+7ovJe7r3bnRsyi0
	Hq1X2kEovDtslotQfy5/4YO6ttc5UJFOiVF0fj/fmpG51qE8aAOklWtsZ8uBKT5HV+oKVnDxinA
	b9qoZ1sQ0SySo/fhiRKCuUXB2PTYHXtGhGWZXsn9U2Z8GJhNmGrOtpYwf4xXHER1dMpBiDxwoQ6
	Cj3Jrex/OsYm/G5il1fQt0v7g33URzDdM5hg30DbiT7GeJsn5WAv2kPvebe7g+ovWQf/z207PyW
	AAoRKkc0wvi/w1/gg3UXioM4HRqjFXvkh9NNiyXnUic6/rRI5paD1bIH7QEb6Igyt3rzNyZx1fj
	4jk9L6Y31aDfg1EbnlXcEXGi6zsRghljljtwY6q2OcbrKNohm4m85QiwCuLWCNvjUpgZcZJpnBm
	/Roh5MWp0XsWHAtdA==
X-Received: by 2002:a05:7301:4198:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2c10961a7fcmr5814652eec.8.1774295687485;
        Mon, 23 Mar 2026 12:54:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29c74bsm13366988eec.17.2026.03.23.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:54:47 -0700 (PDT)
Message-ID: <c2782a066788a9dd0542391c4308d23854d2938f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support 32-bit scalar spills in
 stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Mon, 23 Mar 2026 12:54:45 -0700
In-Reply-To: <ada028bf2621bd489a09aa41cdd449cb160fbad6.camel@gmail.com>
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
	 <ada028bf2621bd489a09aa41cdd449cb160fbad6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-23 at 12:36 -0700, Eduard Zingerman wrote:
> On Sun, 2026-03-22 at 19:24 -0700, Alexei Starovoitov wrote:
>=20
> [...]
>=20
> > @@ -20020,12 +20020,12 @@ static bool is_stack_all_misc(struct bpf_veri=
fier_env *env,
> >  }
> > =20
> >  static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_=
env *env,
> > -						  struct bpf_stack_state *stack)
> > +						  struct bpf_stack_state *stack, int im)
> >  {
> > -	if (is_spilled_scalar_reg64(stack))
> > +	if (is_spilled_scalar_after(stack, im))
> >  		return &stack->spilled_ptr;
> > =20
> > -	if (is_stack_all_misc(env, stack))
> > +	if (is_stack_misc_after(env, stack, im))
> >  		return &unbound_reg;
>=20
> unbound_reg has 64-bit bounds set to corresponding 64-bit min/max values.
> For a 32-bit spill, suppose that old state has a SPILL and MISC in the sl=
ot,
> while new state has all MISC. This would lead to a
> regsafe(old_reg_with_32bit_bounds, &unbound_reg),
> which should return false. This is safe but conservative,
> maybe add a notion of unbound_reg32 to cover this case?
> Idk if this would have final veristat impact.

On the other hand, this would matter only if register is marked as
precise the old state, and to make a difference it will have to be
both precise and unbounded. Probably an unlikely situation.

Still curious about 8- and 16-bit cases.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
