Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F3419315
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653496; cv=none; b=KQtU8byrl2G4murObkd0G78OIlKWHQNWpMoUoApHn3TjDKkx+z/W8rFzUYzMUHWaGx+5Nc2Z8cqZrAnh9w0aSqilejaIrScBPAjQ+8M9ScIzGMiKqBuPfm8e75ETwmtKreMZ2TK+YvlyAYwNIzGQo1NTDQGMRuna3EeEwmeN0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653496; c=relaxed/simple;
	bh=TYQL9ZWigYa7ugFO2d2wtuLrOq/WagVdisGmzw0/kbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLK2ardvUtqZmaY5CcLdlw9aOUZqhBd/IQCUieZwVbuhUKbrSz/GARS9m6RDgSSlVepG/F8f1NTWMvpGRR3GTuaNcYBwBGE/b12NjhZpZ0CmMnjYADx4T3B6nMmpGwvLu/2umXk3XEcUh4vh2amOx0sWQEUAwOuOMfN8XpkCUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9s6uyJn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9s6uyJn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e347638adso351806a91.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786653494; x=1787258294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TYQL9ZWigYa7ugFO2d2wtuLrOq/WagVdisGmzw0/kbE=;
        b=Y9s6uyJn2ro0MjNwNhdFWcarQrnaQqgnlj3W+eckm6wmIkQhda7sfdgURTpGE1c1/y
         HJk130QFG3+ZdhEM4kaWMLw8736nyLzT3tgNq++Un1AFl8rLZrHKmYbRAk3+4V7oO5Oa
         k+GVQXht5d+T5GRaeAHBKpawjo7XldxL1UQe1FWOiZybxcQr2kwNIg5+fx073B02vjXr
         ekqu61fqQmzjR8oofHAib+o9YkksZJBhUSNu76VXyrfC07tDFhwMEneDfTFLbz8fdzOn
         tN9aNmsYb4juijOYIM03j95BD9Fgjaro86fP64+g8VPYv+ONPdVH/1nuKE4T/Jicakje
         siHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653494; x=1787258294;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYQL9ZWigYa7ugFO2d2wtuLrOq/WagVdisGmzw0/kbE=;
        b=iVf4kvyVIZ7/vFDn1CYtzeDz0O1F2DoQQhj9LMKMrEaM+fQkeSDqgHcxb6q+Y+DXoS
         SM6YiIAtkkFt4q0uD2VXvoeE2EwjYlvaemDoZFwbgSYp3klg5mUa7pmVRZ4RZASphrM4
         ZYTfzfKcxxANsyWQ247+9JBsAILUIiLgndykRNxNEyWF1VyX6sFI1/knFRR/dPkHTzDu
         JNaT8rfS52NSPmiZ3d+JEnFh6UthmJmONdNy1/rjUiSihnzWg1V95HHLkWFliWtojw7L
         3wybcp2x7jPGREbLDIUHNdhpulgZkrRn1fcLA9hak8llWfo9tL1i/N6Y2DkLsMD/+FUO
         bMcg==
X-Forwarded-Encrypted: i=1; AHgh+RqBFZsmfOkFKBwrzrgjqgA1a8Ksr7lUuAYzcOqySWPlGUF7NW9x0kzR/FdubBFikwsh7d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoi29jmi0ThdIzc6YVR5BKbSvIO5M+pBaSQXwQkPvxlAVLB969
	cgRsvYxi/SoGWdz9TDBz8pEJYBFsMM4TQnKR1W+2vMZMCV9reftX4Gk+
X-Gm-Gg: AR+sD11fu1f7Sm4wQWHG122Bk/12wjQZ5IISRwCjs2iSeUQXMcfqh6yms4XtGlhLnld
	rFKOnvUF0+utghv6LRMZ5sj1OU53BvGVS0FI3+nPxo1odL5yW3NgdxTBbJBwXr3dMVcCjcrhAJJ
	Tz80Ca2lLPx45GzsFoergfUNzLAVthvt8dgqVlWHg5d1Qu1yAwORUhJtj0MQ3MLfV5xbFKnfLdo
	gJLO6JKy5CX2LdcLoY8oWHResaYJh/1lqPy2I48RRq/cwPYNBQJW/KEFzHWf5/doR+L+CD4RYBk
	bcIFTggM0E9Xg987rvxk0OvjxFjWItLN38Ra+EUGi24EHMO0F7/RQYl65SQTDbGtBenVKcotV41
	3Q2R9s5/1SISX9YquWKmhOJKT0eskeB9uAHbGmnX9XHk84l/EZkPY64F+EodwNAqwBAhdMt5Kzd
	IFV4kj9bLUoU2CV2rk7F/1RSkHGtGQVyTh5eKR81W/PnsubHqITdGqrFwzGmhXSHbXAPXm6SO/M
	o0dxJ6fyVcY+tS1uCNMuxtc8MkBdtfWdHM7tMGx0wBQEg==
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3933b6e9788mr861347a91.2.1786653493823;
        Thu, 13 Aug 2026 13:38:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf732526sm9686863eec.19.2026.08.13.13.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:38:13 -0700 (PDT)
Message-ID: <39738fd6bc844199250f4c9e0dd16f6a5100384c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 16/16] bpf: Gate verifier diagnostics on log
 level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 13:38:11 -0700
In-Reply-To: <20260812233326.3575958-17-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-17-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:
> Verifier diagnostics collect active-path history and render richer report=
s for
> selected verifier failures. That work is useful only when the caller requ=
ests
> normal verifier log output.
>=20
> Do not enable diagnostic collection or report rendering for BPF_LOG_STATS=
-only
> loads. Stats-only loads still need the verifier's summary counters, but n=
ot
> the extra path history used by diagnostic reports.
>=20
> Keep enablement in the verifier environment and requested log mode so asy=
nc
> callback verification uses the same diagnostic policy as the main verifie=
r
> pass.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Oh, I see why you needed the "current call chain".
Nope, let's keep the report useful on any log level, please figure out how.
The "current call chain" is completely useless.
Also, this whole business with check_max_stack_depth_subprog()
modification and limits reporting can be a follow-up.

...
