Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C636AB56
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417887; cv=pass; b=PizgWP0YgsoFfmQynVIicb2Jc3i1iJv2a7+de0TQGCf9+MHqEtr/jbeTxGR24c9l9cDJyJORrwqBmaymjkOOZnMayMOmU1OF/gy32beufI/3JbgfBunt7Pl3YjVt00MoBlhvwLxNAlc/x71fCwGXKqepgw/+6Gv4Gga69OrMy1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417887; c=relaxed/simple;
	bh=Ow0EB3J7+I7AGIfOsEF2tfgPQ9JCehdz3H6Y23trGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3rv12n3cVPH/bn1Hg09ADWv8BeqgowUf4Ezf9VW+J5+YyNEy1kqHRiiCMNRJdvdV3gYjynwF1hUqSXjZNzlffjly89zwCapxjWDpSuTTabvTl8bdAXD9/tYu/0LrPuk5zgimFT8bbBZRdw0pfFGcX/7B08WYgH+klH/+AdAxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cceUl1y0; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cceUl1y0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf114b0cf9so31989405ad.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 09:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780417885; cv=none;
        d=google.com; s=arc-20240605;
        b=KfpvppC1mwwZ02KrXjDZB3Uv9k9xjXINcCjwTrBgPne3u7gB9z64UYh+9WTUpT29hA
         wfrJTMXgsF6EDz+VWVLpUkc5evg4u214sqp4AW3Wwtm8uqFs0h/5cR2RJOHzE6MV/Yam
         0bVBW7sllGQjSfErqp9QDb7ErJp1mNhULhdDhtHjzhvF76j/tDfbvhtO+PtN3SreCQYi
         OsXWSrmfvmp3xAGoiIUguDlPAxbUORkCZewAcR0cuDDx0nO/dQcO/57R0cvjd9jA4RDc
         0w+ZEhr0mxSv7mwKQJ8N4rfBi1ttJmvDzKULNSmPrkYtfyGiOzl3sjbhD2mYvx0wJFvZ
         Gl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        fh=az/7woPsVWR/UUYyG8B7fZO60EJAZ/+tpdcp/9GsjtU=;
        b=DhsI17cAqYAoufnYlVuh2hllKm3dfQMvZDku4GphPyYp1ALe5rN2TBVda1ymh5dP86
         /OXFYnT0fsO/MJaR7AfMWUlzVnw3VabaVG8DrFmhYCF/4ld/oBiWTK0omjaPSkfRfwFr
         py84QPLXYfy84CcmXKzHcGWmKjqEYIUOlE4NMum29ixEi7LbfeMhOl5r4n/6ecvPPOko
         l/ZYSCe1eoHQrpDMhwmwYFhdqkFQ53QF8oh7dQVWQY00t4M4QhDcvKazYAf0eHZ2Qr3h
         dOuwRVg72mSSpyxX+Jv9flO1rcEs6TWUEQ0CjBBy07ojPNFSy/yEVfPDS1+smkqTl/aN
         1Dyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780417885; x=1781022685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        b=cceUl1y0mYkHv+w4JiO/kkYE2NJvjvN6RKdO1Mix2W60CY9ZdeOc0+OB1VUY2EgHUo
         ysSpjtTIW9XVA0kQVoguOH6RqL3j7C+PYHnEwG03KkhWVLCvWJBmnB8AVBzNsjM2ehOf
         HI/ZO30m4IFiZe3x9v4JIg86BMvXxGM/cMTs79qE2pdXwvdjo3fu/cWRB44YIS1m9h1E
         kQGeC2f+3C18UsjDoGn3LZnLzOyEpZLWlqmBdmHiDf1rVetbH7anana3HsWy+NSMfGF8
         v/R8yGYloSM4BYRssgO4icoM4+oTrFMZM8oTd3y4X+OHfCn1laooeRYmN0IV03nAdqS2
         o/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417885; x=1781022685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        b=Pdp1W2q1ncNzGsGtBiXLZYe/bnCLDH1yBgZagsAzzVcIr+7XYcDYAhA19oZSUWqynB
         0EvjtUpow5s08JKXFoJfgL1laReKiGVi33M8LLy0fGQkXQacQ7wCj+W33ud/IOE926tg
         rfzm87SASqud+Tx64Zm1k0bp23IqfOIvwlTM/yG5B4XtvlsCPFrHLlWoiKcpupma1XGu
         uKC6Pknb7lyWV8zf5vsu2makYHQPXJDQZgn7gpQwVA1teSL/oYLGIJ/R5Dag+UiNyp0J
         fkVk5mYoAsUGbt8vEC1l2ePUL7+O8ce/04YEntmD5+RW69YuyobRG6UJFDgO//jriFd2
         hshw==
X-Forwarded-Encrypted: i=1; AFNElJ/pLqPE/adXN3pmINxVVIbIlqXPNZjn5n50xtscsZpWmzC1XfEW5hoTO/bexSf0BQFu2co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnOTAgbWZT43PquV64QDhIrKazTiAPr1tnWgkSAZK6mx2F6Ry
	nOwfXby5meJY460D022K3Fn1PRgTi2mQuuXTtqpS3f2sLeNpSGCAzptsn9GInQCWZVAvRNZidpx
	ozjtZdXV/acZ2Dfp9oiPzMpvzOOfrHKfHvocxJbi+
X-Gm-Gg: Acq92OGvMS/bu/Ntm2JyRl6jYRRaQ0DIBXNjkJ2v7mJzPDgv4k58cwfi7YDsCTm+K9G
	3i/hbWlJOn1535vZuq1D5/F2vSM7qOpS/bAmjP/VYcLXtsu5tVkeJKnOfnN4sSWLSbms6syFh8i
	c+uSrUVf3MMger2sBNHQex/AgxseBylCMGEjPubQRiDEcDBm2QxPkoJxdGOQOFZK6IsOY7LUWU9
	9uJNMoWs756ux+ObUKgYaqcmwMXmgSpBQy6mp7va1Ac+5W6dsbXwfUhGsonnaxiBUZfAxncYegF
	RGe1b4VZ0YZ4VDnAaQ==
X-Received: by 2002:a17:902:e5ce:b0:2c0:ab82:6ba9 with SMTP id
 d9443c01a7336-2c0ab826cfbmr164171135ad.33.1780417885398; Tue, 02 Jun 2026
 09:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk>
In-Reply-To: <ah8BzqSmZO40xYhS@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 12:31:13 -0400
X-Gm-Features: AVHnY4IjB4rzIJ_BZRsLHOWTBgQXVWkilvI4MqI_CH17d78U1aoUDdF7OL0mWL8
Message-ID: <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the security tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many argu=
ments to function call, expected 1, have 3
>   212 |                         if (map->ops->map_get_hash(map, SHA256_DI=
GEST_SIZE, hash))
>       |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~=
~~~~~~~~~~~~~~~
> /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro 'S=
HA256_DIGEST_SIZE'
>    14 | #define SHA256_DIGEST_SIZE      32
>       |                                 ^
>
>
> Caused by commit
>
>   c62310df81899 (lsm: introduce the Hornet LSM)
>
> interacting with
>
>   c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operation=
)
>
> from the bpf-next tree.  I have reverted the latter commit, the new LSM
> means that the assumption in the changelog that there is only one caller
> isn't true and it seems like the most straightforward approach.

Thanks Mark, we're taking a look at it now and should have a
fix/answer later today.

--=20
paul-moore.com
