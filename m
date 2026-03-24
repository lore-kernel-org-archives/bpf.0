Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47E405ABA
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364874; cv=pass; b=jq7DymEc+6T0xa2zGfElhyxO/IarSjNw7roecdAlJ8N0oCj1Mgc3M+4Z0nBX7yrXVOqzx43BY6IFMaBSaqtyGoPyzZv5KMjlNTkKH/Tjny99JG7suQ4PMZSRHVbBUwE3ngwFujJouMaUUqHVeSp1pHXqn2wnljTvUKSzaMtZz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364874; c=relaxed/simple;
	bh=1Z6JMNCHSGaxtIAix0aAtaZagu/pLyzUz7fEOf63FQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAETc51iRsAFet2AcXJMes2YcoXNEVPMvYimBQMfkhkFScf1TnJg85MpOhO7CNFldaAzPo4JvQphzu1fexbqKnDLpuFPEBwvxklWp8Q7t09MmVlgArRAaZrjNKbcjvuK2Y5L6lBr4TNLdYqsMdIh5sX8/0abNDIL8iSESho4m5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhE2htIX; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhE2htIX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so38727775e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364871; cv=none;
        d=google.com; s=arc-20240605;
        b=ZLq9xbRSX/l8TeTsDeIRWtl/0HkabbVdxYFR7e2mnEL6QU4+MoOI13mFtjos8r7ON9
         bSP/Rwuc0sMYXHa9JK/qMhGiA9VgooXVMGL9mbPgfa6JyopSp/0wEgDGF6abZUQaVKV2
         4BPShh8Wn96oxD+k6Q3K6y25x5Sb87JRbtUdLZ242vDCcdvXpwpFXGf7K6kbxBjBQGk8
         CdeQIlUf5By2LPw1U4lcuRPmWHyCwF4jgYyXVzOkqb5WSx4CLOvGR4XnFAouT1SujNyh
         To/Ug7ZoUemm0sJQ56it0qMdUs2vQnRPuYLUgge2QtmWOjxi51Ru85z3JxAIf+vCDK4T
         FGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        fh=oMZsB8czdofQUns5H4ouIF4S+7PPN2q52pK7rOywT3A=;
        b=DBwGVbZVrmkOp9mUuQA01+q2BFrKwYaajlI2f6a/JVdKNpaGQxukVppsM2xaIMS6oY
         dcF4guqnGe+jmCv0PQXf6TtzYlp6AmZvuRP7e7FC4Aax8FAruQDuRohdwzFbye+M/vR7
         cYzf4FHxk1WPswXJcfib+43W0eLSDYmHNriNMV/6TXeb6GE/xwYem1c5xBX0EIAc2rWj
         PGog7n9OivR3x1hQLjGzNcqrSSdukrLGtW936VYTtrJB4ESsNL5HKY+UcFcLQZymobHb
         OaBkESnc+k0/Ea+fk2sAQklLumzUn6X+TjpJc3SxiLq+f5s+N7VSw/qOsVHUDklppmhM
         uptg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364871; x=1774969671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        b=PhE2htIXEQo5bYFb7KluljetQMoLlA9n2RRoXwzblUDzswJ8bFRC6AM5DRa+GExEBN
         FZGpT0eVO+zwKmDBhjlBIH5iZc6Jbb4aGj+Rm40RMZ5qOlrDF+nEJ4+hkxlUhCT2xYZG
         67EJ4PzVn1dA/LNeZr73nxAkCCp4C1SiD5w29nFBlv8bZI2ZGHEUdjGdZzygTOR4Prpx
         09ESScw+O9kLOAdlDMApNQWbRFOXjzOBQQteLYK3DMmvaN1vEh7qejhC1P1QvjIGg8bf
         LO4zH2XZV/QtPOEBc0k+CTr3Te3THej35F3tYmzoP0O5O+sQbP9ywiMg+bCB8bJ4kEvi
         tpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364871; x=1774969671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        b=q5A3RrP+kpgJpM53TchjI9KzgadtchY8P6ZSAe0SCAHq7OecnJTi+wIOjyvBKxf4g3
         wIlih9rxJMYWYF5XGyCjUv1G63HJ0NEs8aajIwdfNbM9uNXtBGEr/KSVPaeNk7YX+ZjJ
         mYlnidz3OkKJBU7AnusLKHu9h3/aJtT2wM/Be8Fn/1WafoYYlXyIQGrVs38ARR6oHjRX
         b/3slM+RiMDBSOmO0Q1aEu4m9GVRwp+CKhOb1xeviaEUMBkweP5FOXAV6c/nWM3i/8Jb
         wcghrI15RqIiuKkxyOHkiF6k9Kp2u13pJi/EeomeT1fXUCAsG3ehMbw1pxKPwOY9ZHt0
         shSA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGSZN6kM1J/0CQew7T01xj5Mmw6TYDTqbpDj42/LCr/jSeSElMatdWxswUooQUb33/2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLN2DD2qMyuB8yCstPDOtDeeTS4Oev0ZmrxjeDuA7sKJMK0xbL
	yisjOELhArg0kvoALLlt6rq6dqwwrm6cbH0SZsrI6e9kNaFtj8efvJOCoDpHyYJBILFqYfFb6f7
	nHmwYB7zfAZz6IfBXbF7U9B1WwM8Gee0=
X-Gm-Gg: ATEYQzzXpLWh16kxQGru3RWN9nLIVg8OMdsPY7Cq/KLqcki9uTLC2y3ExS1gkDdHLBU
	7hDf/lsRRx7gGMzRo9XCImqQXygMwrn9a8sm0GXARgez5F0Qf0bIAWJegNvT28mBdeRJi0uPRSg
	belMT8gvJCa5kpMY3kOiUr/4KbLQnJZMVYxR2QsRjnvho6zLSJoHfAEm4BJJf2VlfnLznuNYr1y
	lReKPDCc7SLZgfzAb/o4vh938WTVVp70q9wvlNCcrdULvlBaz2Fu5THsbYgBaAONPZDZv2PmSMX
	U/v4ifa1UEmMPj9TMaEdbdZ0bj1RJgQ01kaqouEd/nD+4W/TNiOHPiVev/ZoCHeD4j3HIz3KR+y
	KQLOcRFgmoLGWH5TqoAD52GY52A==
X-Received: by 2002:a05:600c:8489:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48715fc384dmr1835815e9.4.1774364871041; Tue, 24 Mar 2026
 08:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-3-sashal@kernel.org>
In-Reply-To: <20260323164858.1939248-3-sashal@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:07:39 -0700
X-Gm-Features: AQROBzBqtCVnV-aokcS_jfx2Rq64gl7691VsnwgJMvcALBoTl8K4Z3ivzRJzHjM
Message-ID: <CAADnVQ+oBm7Gj3KScFujGwVKc5d2sqcK3MWX5K6dTAjekYitSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: add BTF-based deep parameter rendering in
 oops dumps
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Juergen Gross <jgross@suse.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> +static const char *extract_struct_name(const char *type_str, bool *is_un=
ion,
> +                                      char *name_buf, size_t bufsz)
> +{
> +       const char *p, *end;
> +
> +       *is_union =3D false;
> +
> +       /* Must end with " *" to be a pointer */
> +       end =3D type_str + strlen(type_str);
> +       if (end - type_str < 3 || end[-1] !=3D '*' || end[-2] !=3D ' ')
> +               return NULL;
> +
> +       if (!strncmp(type_str, "struct ", 7)) {
> +               p =3D type_str + 7;
> +       } else if (!strncmp(type_str, "union ", 6)) {
> +               p =3D type_str + 6;
> +               *is_union =3D true;
> +       } else {
> +               return NULL;
> +       }
> +
> +       /* Copy name up to the " *" */
> +       {
> +               size_t len =3D (end - 2) - p;
> +
> +               if (len =3D=3D 0 || len >=3D bufsz)
> +                       return NULL;
> +               memcpy(name_buf, p, len);
> +               name_buf[len] =3D '\0';
> +       }
> +
> +       return name_buf;


Nack. This is just awful.
You didn't even bother to reformat what claude spat out.
Which means you didn't think it through.
It prints something that looks plausible
which is the opposite of what kernel crash dump should be.
crash output should be accurate and not a guess work.
