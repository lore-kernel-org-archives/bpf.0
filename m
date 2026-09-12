Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BE37EFE2
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241837; cv=pass; b=D0bGncyd3mF+JlmNqQdUjFEjhZK9kpX/ZgR1ccbB67tiWmIjxlUL+fSnH1fjT+7z+Ytyc3ZbkmvV5lvz8DgAhu3YogM3k65GnMWWfPgNUgG8+vuDeTDIBdoJXD/myK7nl5yDQuYeWxSQQVN25Du3p3iFnfyCqDwNKUEhfDKl078=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241837; c=relaxed/simple;
	bh=rTTsBHK4um1yjRGf2YHu9S8y6qTmA6zHLJxC9T3Jyao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhRK1mWwQmlRcNiKOZKH0xREudDI+nD7WD+JNNRCxQhdhx9uazbwjAALMnce/+/U27VzVIAsvQAHgdCLoNgnkD7vB9vVRN58caIISb844mUon1tP3fLxzr/knUPKpUf/6IFkHMmJ/C3fJjE5UlfjzNbrTI1aUERwCyeAROqKB2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5BPX/27; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5BPX/27"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c1so126589966b.0
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 12:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789241834; cv=none;
        d=google.com; s=arc-20260327;
        b=j3xZMz4ReRTpHSZuJei5oBS3E+j9yUZlOKmZdpZtqx4u+Z12oQWZdvec/Hiz1UwiEW
         goUkj0cj1yNbGNUkB5LXve6Jaid5abWgYMAhNidKAZMnsvzR3+S0ihC1WadEMjE5rjU2
         Cwg4oIoNxarjnR3Ig2bLZfC30th8AW8VWFUiuTFgFqUqvKx2U+f6FKGKrquR7saOnkdz
         lJIyjFdnddn9zIpk5flpiNb05stOITY/4IoX6VuOuPssVZoDRiviS3c4Lf3sfWAo/tvT
         SFyvHGlVMpZwWdNLnOWPNpgsijzNR92Va0BHJG8LwegO6caG+aKl7BiBTnL/yCgvjSDL
         nFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rTTsBHK4um1yjRGf2YHu9S8y6qTmA6zHLJxC9T3Jyao=;
        fh=G2E2WjagNqimDkTDz9hNe7buVw0kp90fMN8CyQU2WB4=;
        b=gO9OOUCOyQbpoPsis8MyhVxxqE/AVPfBMQlgod32/zkj7wZuOc0CCVxExNLuKhVvUu
         5bCVEoQ7wC5tMjzkoKhhbks/0vS32M0tCCAMjSJLD0P5neyAbnpE70QYWkIuq/iWatmi
         m0/EyYV7RemL0GOsOPgxQHv2zwFfmGfq5HfxLBtBZIg6DtT5frhPSgoU5kiaHw+CkpwH
         de6zA6Q2ZShFvB2vi+oFr9tz2d3qOt8CL3jH1XbahMjE6E7vezpIyEbXgVUPF7fJ822W
         pYo+3VSGsueQZcZtKLm4AHT2Oe6aVwURSS9zbhiJRTkx80rRX3an860q6P6YiovihNye
         rpBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789241834; x=1789846634; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTTsBHK4um1yjRGf2YHu9S8y6qTmA6zHLJxC9T3Jyao=;
        b=S5BPX/273smdf5hGu1RZqsnKIeG9jaEAApfwcb3c3vcOS+iRFwsRGpQq+7OjUMoi15
         kX4sHxeOONT3uDDQ4eEUuo0CMxSDaCepgYZ5nYxFTdvkhG//sGuoHXn1sgIx/Q+BjQ/Q
         1CIAkvlwwjlZSYUmNtYzxdBkwVQjHKbVu1FundhKsNpUft/gKcPtSAFTTzcX86GRp7hY
         oeHg208vN7VnE4fv1maRPx4P22lBp2Y4+ORQ46jrk5NsCPr8G4hSWKl42/gjuuq6EsT5
         QxrV0CZhcE9wGY5BuOhG1gScvJPw6TKmltQfZNIGOnTrE4sti4I4em7Y9vO2yo2a0CAL
         tWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789241834; x=1789846634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rTTsBHK4um1yjRGf2YHu9S8y6qTmA6zHLJxC9T3Jyao=;
        b=rks+S7Fm9TpLfrQ232/HHMUGn0JdfrHWyvN1t80En4yyv2Pq9+Dk6TkSHMLeQ7aHTl
         YRYAYyfNj4rBqaAraLXUcWaQGnk0sfxXveMVNnXEeqT8lbBW2rtao63pDCXtYQyDHlCV
         BWtlNj+EpW/Ts26Xc5yYRCmB17uQzc0MJCknRXW42oJohlmkNt+kPwrE035k4eJo0HVl
         /+uhuzmZnKWP4R6yXRc3v5gk4NdIXhdZ53lScFY81yArBkVnO/jihROwXijc+6IEkmCG
         865MHG+1JUOV524lDALdj94KMoyQShMqWInIVKN+/O2C6mzphb4qIIQzzFDbFomQoQa1
         M+pg==
X-Forwarded-Encrypted: i=1; AKwUvBzbPSoQ4Qm5BUe8qJCWQ66YE7YEX5x9NgupF3IkaEJQBIY+AQvXgXlc4I09qEyZl/6BzIA=@vger.kernel.org
X-Gm-Message-State: AFuF++lu8JJhDaMvsZxpCGpwnz+VAEKTyBShPxPiXexJrZ53qivMbMHV
	L2kTyALUkWuPXM0S18nVLCL1yXYmpAQRuhwX65woezc6Hh5pn+Ohvnresl3fR11x5mivZ5DQq1l
	ADTZ8oPCYKLu2i8I67mVvi97pv5yQ9ik=
X-Gm-Gg: AYBFou1525jtCdmHV7RBRkfVN+ZvWvn2gSXN5iOMYGKLLQficsIGNu7V5sEHcm25sAM
	pfIHU00vizegkzNnUwekmXmIw8P9HUK7NlYsYzRaHEQBOIWQjxxqbTRRKjcD5T/3AIbTAGjjvv4
	3db8NO6Qr02DqdljlC8S8TOMtzf+NisODTI1ISdtYnG407b+dqbptAzqYT1QkUUX4XlMKIPw0i8
	36nRYcKEa1bDqvifs9SgEqD+gAuU5bm/hD2tBARrwE+axaGM9yM59aRTZlc8JSzp4lBuFZKC0do
	8YweEonmFVjfhDFFzYbIMoCSk+Wvop5EEzj9+ljre1RTbhrDdzjipQ==
X-Received: by 2002:a17:907:7245:b0:c26:2a5:819 with SMTP id
 a640c23a62f3a-c29666f6d30mr953226066b.18.1789241834024; Sat, 12 Sep 2026
 12:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912041220.444715-3-main.kalliope@gmail.com> <1b4cc37b0ee6e1aa473c372e07c89f8fd60ac5f89bad550275edd3f7dc8f8e24@mail.kernel.org>
In-Reply-To: <1b4cc37b0ee6e1aa473c372e07c89f8fd60ac5f89bad550275edd3f7dc8f8e24@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Sat, 12 Sep 2026 15:37:02 -0400
X-Gm-Features: AcwNN1WgyD2ePwBCZDxRvueIh3zWMk4fdTmPoVsiLcsmEMMRdq6RUEG1P4mLE08
Message-ID: <CAJZwKkiwTqeVrB=KRYOVrN3h1CD-K60FbYPg7aH-NaqiLecwxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, mips: Add support for BPF_MOVSX in
 the JITs
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, johan.almbladh@anyfinetworks.com, paulburton@kernel.org, 
	tsbogend@alpha.franken.de, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

> The changelog describes a silent miscompilation of already-loadable BPF
> programs, which indicates this is a bug fix. Should this include a Fixes:
> tag pointing to the commit that introduced BPF_MOVSX to the instruction
> set?

This adds MOVSX support that the MIPS JITs have not previously
implemented. I classified it as architecture enablement and targeted
bpf-next on that basis. The incorrect ordinary-MOV lowering described
in the changelog is real.

This distinction was discussed during the RV32 MOVSX review. Pu Lehui
explicitly requested an "Add support" title and removal of the same
Fixes: 8100928c8814 tag, treating the change as added JIT support:

https://lore.kernel.org/bpf/2ca2a85a-d4a9-4459-a534-6159de6e5890@huawei.com/

> Does this compile? The MIPS uasm assembler appears to have no seb/seh
> emitter.

Yes, with the prerequisite declared in the cover letter. Patch 2/3 of
SDIV/SMOD v4 adds the uasm declarations, encodings and emitters for
seb/seh:

https://lore.kernel.org/bpf/20260911213340.3767930-3-main.kalliope@gmail.com/

The MOVSX cover letter links that series and includes its prerequisite
patch IDs. Applying MOVSX without it leaves those emitters undefined.

I built the combined stack and ran test_bpf under QEMU Malta on
little-endian MIPS32 R1/R2/R6 and MIPS64 R2/R6. All five MOVSX cases
passed with the JIT on each profile and all 16 signed DIV/MOD cases also
passed.

Nicholas
