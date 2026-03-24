Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BC1CFBA
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371390; cv=pass; b=Q031rANaQq5pFQ5J4JCgpij1WYaEOfo7APtkWWx/apK/Cjua4lnafIZMIOJWgWKhP8mAPaTrQ+LAIIlu4mAaedPkWmcKXa3HJkN/wgZnZuakKdWEMv7WL0P6unkpkDQgTPgx+wQe5E3PZY1SwcF/afFN/KKXJioQxB79NOi9gRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371390; c=relaxed/simple;
	bh=lpVQUL0/Ys2Snb2lUZpYei3X/OilG5aAbdL8aH6g78w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+uK9Nh+R6ofa0+jN1GvgUEuneumBfCpTIF43FmbOmnHpaTSoNpjo75o8SJ5+C/TDfoa+TPAr6ezJzGlei/ue9TRC9c45m0PZrdj7pTDJYghZ3ZNomAbFXji2p6CbzhyCNALnnIWW5rQEY5bo6gS2UE7TxmkpKOaLZwTF2IgQz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt6R5LdG; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt6R5LdG"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56ce15c6898so1317851e0c.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774371388; cv=none;
        d=google.com; s=arc-20240605;
        b=hznRDz39Tx1erPBeTOMIoY4pLCc3dZgpQVHghoSzj9XCB5IUpwR/1Qxgv6JzZr5Wzx
         LxJ/up4efcLS2yBKMGnWENPftrxl2t0jxWDhhVnF9Z/4nHg9w1PMjVFg2yjQ8Wh+4Sb8
         i+Yg+KlJFG85KIPWRaM6C1ucBVgZWiQRC/EZ0mSYgqBcvQNvMKlPcYqL24PlpSKWcLLQ
         v6VbQzeVywUhJfljXzDDxLsWhL4McsoBqqxT4lpOUSOXbib2/WtuNlDxza1xGzKeK1wM
         25u7L6voUsdXTqF5ROxUvJzVsQ0mELKxNNVlqho6L7JtQM5wTNbwlE1wA3c5RekLZlff
         FUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/DhfiRxauBgBOOoBKYxcJjqh6uaitskyE3UTNCnVsE=;
        fh=pm2k4uiqmUYL1/5/XIcUlftcnM2zyaumfTBtvc7PmC0=;
        b=PXNN8TAcDBppgikG4m4ZpraclPt+Q3USid9anYtLidNxBgVKnsFwDUhWWZcYNFXRX5
         K+S8nSHedbHcS3wCvrJNHcYuJqSh8lKRMZehEh+NdVQ8Wk4x/q3W+3vL6i4te/ar6La9
         TdgmfI8gy4yoZ1rmfX3WDFRnXJD1/dRmUu3+DjVN0gU/tmffR8JXqIktdAytNPvDYk/n
         mKCJxDBxEplFuKKlDqIz1eywGv2uq+QwJV9lYZyowlqutU/cAA8MoPo3hymujAhQZgjW
         0HBPBy1AyUvwmiTlBWYWAp+vhPKwa1bh8/HrdJNv67hxMgfG2Fd1axQn6ctO0uoKJmib
         eTJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774371388; x=1774976188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/DhfiRxauBgBOOoBKYxcJjqh6uaitskyE3UTNCnVsE=;
        b=Jt6R5LdGo6kiD11mlzwo8e7+SyEUfKvuETqC4pxafeyqIlmv7fvlote0bxKQgEffdP
         7yjaYxYN6ZLRrHm5F8oeMRCpbWO3lyKkVtLT3I3gwCCY0ocs6aHT5SLedvTm0qDKrCjC
         Bhye40UQajx74zt5CIfP5Shtt5aZTNl0c6XLbU1dxGc1Da81Y26ibNavLYyILtlyH7R8
         AXuGXqYWQK9YTO5hI5N/N5ChZXUf9vrh7E+e+Dul8XZlLdrW9TtW6FBJqzmYUE8xOHq5
         yzIfrcj/bSGC2PEo3O+Vr1fPgM7y6HTkTD0VJwMnaThP6dPS16giEWObrAmicFjC0SZU
         BOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371388; x=1774976188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/DhfiRxauBgBOOoBKYxcJjqh6uaitskyE3UTNCnVsE=;
        b=gBNfmJ1iLzYvDTXaKocZ2Sws3k1UHMdvuivYEcXRFDcKf2cJUO7JzQyo8qsno37cBz
         uQWtWGULOCnYzDtzbXEATG8q5UZsutJNKj53Kde5tFtxsWzLH7m2mJnVkPHjuQt3XxwT
         2r9v7LF2wIm+VGmJKazaA0zXnw856aamXvr+JYR4hJGtLcpAdt+ocFuOyWFAOPLQvAss
         SoGcRy5P+s+DyDPFRI8p2yZJ7m4iBE/kL9dColKXJCiLmMFkyFMHM3YeAId5juWEzLX6
         EGzom9nj5sd0+0qPI25dqWN/8+6/ZEzeAgxiHu0ThdVES/codIwAWDLeidrFKx5PFoBT
         UiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXMsydhSdOU3A7mJXGFHlwBDGIpRgGh1u173NVGlL/xhtaNwLxpBjb2uv1tcV+yuZqteZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ4kSZEPoAbGEGFbj28NxnMNVmqc4Wwcw4evqK6HKyaRduc6O
	lxt6CHU38dnI8JgiaJyPcHOLnh6Zh2Z79XWDU4TLoGBCRlqb5OME3MzOmLyjz1hhftg4Y0HYk24
	UZ9fv1T/Ll9LpYIDO4p/XnGgBPfMeZGI=
X-Gm-Gg: ATEYQzyh6wKZ8nfcRTlXq0LrzzKbKGYjQOJt1RqlcdLqwqDv/Br1XYJbAOlhsdxxBSN
	jp6bPTj9cTNxy5swBBDJkarIxZmUflzjRdAE8TjILS75/6WKr33zZkm7QP7NpaugXU2g+QSNmYr
	/OrdSiXkXEgLHodr9VPhbKsSltz2e0eGd8d+qttuvWUCM9UQRKU4mz1QmrYdqs3UDbrbrtiYa+a
	h+01pCJfnbjnsdyr9bZ8Zm8zsh/RC3U/1kTbNPh4IVvVEBAwg6nfYZqx/YJ/C2eOS03aWMNe7Ra
	7CGUEeh9bLcsy45Vz+HW1jpMdpLkn8yA9al5kCTe6NhvOsuoT+Ff
X-Received: by 2002:a05:6123:4c:b0:566:357b:ef25 with SMTP id
 71dfb90a1353d-56d220ba657mr332085e0c.15.1774371388394; Tue, 24 Mar 2026
 09:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
 <87qzpak4wc.fsf@gmail.com>
In-Reply-To: <87qzpak4wc.fsf@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 12:56:11 -0400
X-Gm-Features: AQROBzDcskYsZTAsPBXYgHOkZoaMfm0Lamc7OAmnQ1eFV_q-YDcct7Rn5JrHXZc
Message-ID: <CAM=Ch07a=eO8y3-5btGcUUm3q_E=uGZVjbo__nx3zB_O3zYWDg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Refactor reg_bounds_sanity_check
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:16=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Paul Chaignon <paul.chaignon@gmail.com> writes:
>
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> >
[...]
> nit: maybe it's going to look simpler if you rewrite it with early return=
?
> static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state=
 *reg)
> {
>         u64 uval =3D reg->var_off.value;
>         s64 sval =3D (s64)uval;
>
>         if (!tnum_is_const(reg->var_off))
>                 return false;
>
>         return reg->umin_value !=3D uval || reg->umax_value !=3D uval ||
>                reg->smin_value !=3D sval || reg->smax_value !=3D sval;
> }

Sounds good, this makes sense!

> same principle can be applied to
> const_subreg_tnum_out_of_sync_with_range_bounds(), which looks like a
> very long function name, will something like
> subreg_tnum_range_mismatch() capture the idea?

It is specifically checking for a *const* tnum and range mismatch, not
just any tnum,
so I'd assume we want to capture that when naming.
Perhaps we call these const_tnum_range_mismatch and
const_tnum_range_mismatch_32?

[...]
> Other than those few nits, the change looks good.
> >
> >       return 0;
> >  out:
> > --
> > 2.43.0
