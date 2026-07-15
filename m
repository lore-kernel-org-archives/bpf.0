Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02883351C2D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093212; cv=pass; b=phkMzPZHDil+iO+7haJo2sb/ME+Km5OLXjOjh8FPsPia+6y8rqQDHyz3p7H3P+ooGYsYL/5gHh2YBKgwe4OSsCCw9KkjgbP5YxO1GuHLi28vix4VUHMyZerbFQaatHGttN9LxSXVvl+mbd8xVsMgTaR04uwKRzhnvVHUpmbdazI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093212; c=relaxed/simple;
	bh=FwwkLKfnhmi7lzE3+e+YTgEDjUkHForo8+On5/8/8vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IH19CHtxp6JZHKnkZ2SqWQpmGl8mz/QImZhvBIBUdatw57qNQLfG24xE9ksBSRwU1Z45g0g62VuQG9ve4vmQbIK9eD+QrlAMma7KJMYag2RM3iKfMDYwTmuIiosNGljrsXvcYeF6i4N5ytVcpbL7xNZg2CzqQQ/2LOX2GSBdFLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1YE+nYm; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1YE+nYm"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667b76205f1so1753207d50.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 22:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784093210; cv=none;
        d=google.com; s=arc-20260327;
        b=CENK9c9NVVKNXWDiRqz6bA0q6XwG/ScuAuor3gzMt8WY9BOjphsBgIFo8Vx3wTVYe0
         8nfvG9T/Nc5Gl6sTJxz1wFy3pdARSPGBOPKjLLESaR45NHU7t0o06xkEdROFrVHTxH5S
         7dkg83Cm4SEiUiJ69E/YU2+k7r5aljW6IMuEEZryE/kQrK1Utm2fuhYH592d3gmFmVam
         iFLrnT6VHYBWmJ+L1lTp0bdTLLqC3qccAVr7gxvOFDJlNJPn3zkZ7YuA0LDp0KaQ/9Ca
         W2U4s6AZVlwf9zKk0rbQkciLohjPKve/OWSnU73Qs4YKahYnvOywSc+wMweyuwnt9ZZN
         JkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wVxu7nCIPOZt/Ixky+j+5nh18mEYf8CszwHnP1+JvR8=;
        fh=C9SVkTDw9o0+CHnckeZiZMaeW20RH7Igr2nh+mn2Mzo=;
        b=GUEZYjqfIl34XQkHqzsa2eeXJNIKjOuaZ9/3NypfNH6bhs87IDiFYKWOVaI/0Trx5K
         EAA8JrbcNAxTYSikwU2A1Wrq7fEbUm1s7SrXINugGJp36L+g39rbs+nIyxFnm5ttSRcr
         bheVURKp3bHdk3VjC/mIUZk97WVjO0/znjHLXI3EUDP/3xcAhZa0Xtgo/bj60Z5emIUx
         8zjuxpIyvpOc9QCh9KMTOR5u/mHOBlF0taZrfdPHopkkyTH5+xI7TwaiFF5vAW+/mhrN
         5/3ptzR680XGogJwiwTfEigVJhKdlwG+fKiigmKoyamworsen+qMG64ErrtL+Jn7Zkhg
         AleA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784093210; x=1784698010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wVxu7nCIPOZt/Ixky+j+5nh18mEYf8CszwHnP1+JvR8=;
        b=O1YE+nYmnpxNaaThc9P8EcHvkGfWA4TnTlU8nU7tVPIXsJsvgNrJ2ocE1VEuNQ0CqX
         xD3YxDEeaq9zMs93MyEe3RC5FkdM9E05juOTTy5ySv8k+kg4soWclZa3W8ApgNwXxUrm
         GnU/xjkQNFdJl/6NrP143/dR3Z+CRmWepUrAmqrG0JjFi4LLOJt8o5AYjo3Eb/s1UwNw
         htuaipbdRVWP2KxlAMjiLXJeNqLzvhHUY2Gl9sgqMT9aXhQYZ6HdMUqmHf4zNcQVVaxP
         bieSQzNwOSc4Fudw9PHOfYN1oWTbJ7QGai5Val9C1YP/Vt4LnrO3ylcL2DwOzdSkdzpb
         iuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784093210; x=1784698010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVxu7nCIPOZt/Ixky+j+5nh18mEYf8CszwHnP1+JvR8=;
        b=YSElFZRL16sFEyQGT10oC3xZJiQSd1zZ3iqMxl0zvfzydeMreq4yFBdWKm6kfyuPIz
         5qMS1zc51xOBQ0NGDaRAZQPeUvWMQqN+sJBXvLjeSbQWF7MAzvnaLlYY4wmQoBAfO8o6
         SnydvYKKqmZIJP13gYu+nxWSq5ftjGYK0oia0RByoQkSRR7rtQLHK2paJloH2ESky4Ml
         i6iG6g/x7dQwmdkZgPAgxmgJy3ekdVVxhw4f7xkOYVCEgOak+PS3HU5qy1+vZbyYyQlc
         szTSrF3twtoTimWU7SI7TzyPwuWpH27gu8wbnTcQKJDB43RbkJflsz/udpVpYg9QVqjB
         22Jg==
X-Gm-Message-State: AOJu0YzvaDB+D0GhN+wHQV97pXCgvWakLO+2Xt1TM6uIFkzwWKYBgvNW
	p/lE0PkAKDC2q5jT8ErUF7BteW/mZmdsOYWtX9dDWwOheCI8hL7c1hwGU8fAXwmVwLNVrCjyd72
	ge+cBWS2CoF2ydGKgF2ly5m5P1HpsY44=
X-Gm-Gg: AfdE7ck9WTNQParPIgPQcBSnXTk1He7OPJROtHd0KYkWGAf8lObEbxmVO3MBd3kp/5r
	2iYKkFOffcvO15HBWYc6CaiLTlSzY1AO7rLYv/F/TY38+FIfMg81asEJyjVM1j711+JAX94qXlL
	YNXjT/PQQ4qYUzVrPYz4EYa6kdiVbqBFDwIzpBirvpSP3AhJ/sjFRFhSmfr8exdijlozQcHzba0
	38T638nyQ/0hK4Su7XLTN8nFAgK0YomjNcEu+BG9tLgBEI6ilHpguA37HEHwTegznca+sScB0ih
	7VjfVg3C0YHLg6rxRXCo7upOlwLgrrRYF7aNpUS1
X-Received: by 2002:a05:690e:454e:20b0:664:ae69:230b with SMTP id
 956f58d0204a3-667d7cb74a6mr8345277d50.72.1784093209973; Tue, 14 Jul 2026
 22:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com> <alcGgfNM94zgydlK@u94a> <alcKV2MXI_5dsaez@u94a>
In-Reply-To: <alcKV2MXI_5dsaez@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 15 Jul 2026 13:26:40 +0800
X-Gm-Features: AUfX_mwhT8NaoM0E4vlnZLxpbriX3wdXCL0zkk7Q3sx-cyB_tomgavh0BoCs6Fo
Message-ID: <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer offsets
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:23=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Wed, Jul 15, 2026 at 12:15:07PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> > > Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFF=
ER
> > > and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -=
8
> > > and access it at offset zero, so the negative effective start must be
> > > rejected at load time.
> > [...]
> > > +   const struct bpf_insn negative_var_off_program[] =3D {
> > > +           BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
> > > +           /* make var_off negative, but keep the effective access o=
ffset non-negative */
> > > +           BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
> > > +           /* one byte beyond the end of the writable context */
> > > +           BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6,
> > > +                       sizeof(struct bpf_testmod_test_writable_ctx) =
+ 8),
> > > +           BPF_EXIT_INSN(),
> > > +   };
> >
> > Come to think of it, perhaps we can add another one that test one byte
> > *before* the start of the writable context?
> >
> > I understand that it won't even reach the attachment phase because afte=
r
> > your 1st patch is applied, access to effective negative offset of will
> > be rejected at load time, but the one that tried to access one byte
> > before the start of writable context was what that triggered KASAN, and
> > would be useful to have it as a regression test.
>
> I really should proof-read more before I send...
>
> Since the "effective access offset non-negative" should be rejected, it
> would not make refactoring harder, sorry. What I said below in the last
> email is wrong.
>
> Anyway, still recommend adding a regression test that test access to one
> byte before the start of writable context.
>

The new tracepoint_writable_reject_negative_const_offset verifier case
already covers an access before the start of the writable context:

    r6 =3D *(u64 *)(r1 + 0);
    r6 +=3D -8;
    r0 =3D *(u64 *)(r6 + 0);

Its effective access range is [-8, 0), so it is rejected at load time.
This is the direct regression test for the negative-start case.

> > Or alternatively simply change negative_var_off_program[] to be the one
> > that test access *before* the start of context. I am not even sure if
> > the compiler generate such pattern; if it doesn't, then this test would
> > make future refactoring harder without much benefit.
> >
> > [...]
