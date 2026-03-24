Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685137A498
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376183; cv=none; b=foJ2h/2/rC5Cfpi9n4dQSvQYN4rCWLXgCT3kj6kEai6mgmtOxmrg0kbwkOedygAIkbxgVBQh3O4KXv/auobhIsWEV88EGYW3/Ad4KpeNX+e7ySzC234bpHIfEZEpF4a5RaCsemkYdte4xEH3fCi+3e8hlHPsG4A/h1RlXsxQudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376183; c=relaxed/simple;
	bh=APv1waRMCMh0OBc588rgOeZwqzh+aZ3SZz/gN6lDafc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MVcXsVLjz6VSKUpRqGRV48OxuvLksWuHjUoKce2tFI9fjizE9rRKryT88kScspPGAbBSPuLO5xQuOzlKNSGlHLJHJevAnfw0Yhj2wKdmj3l/KaHMHiEca5hATlhA5gR2BZXwXQV8Bz2EsegcD6fqGWHC4oJsdqJ+cdMUUI+ePrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEM2ZtTl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEM2ZtTl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso109285f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376181; x=1774980981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw+JxHXyXN6AmetLjPmfh35JruEtpV9GDfC/A3UFRxg=;
        b=DEM2ZtTlmpq4FsWDren4oFXD2rH/1aSqXzQJTydEAem2u302kRcTFpNI0FazlgQga9
         rBqx0CKVpOTCSqDamkBMqvwrKE3UX0SH44ubG+e+GRXFjQew1EK7WkI3rHuW0qd7MTFF
         /bVq+aDKn3GSMsb1k0IYXP9ZMuI5baYXrzqZotCF8mi+fjVYdUCBM62yfY8+OPz8Z5f3
         GVjRiytzPJlUxgbKsl6dH0goqMt4KZrycFHWhMXF5CMDrnOa4SOMPCiHDEsS0dlCvgN9
         kHmJV0ooL34kyqNgf45FCKQeAZwCC3eFzcB8c1O//Uy0K/JbGOj9TLXKEhixq4cHnbBN
         G/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376181; x=1774980981;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yw+JxHXyXN6AmetLjPmfh35JruEtpV9GDfC/A3UFRxg=;
        b=hZmdbxXHS2O2BxJNsHB+iGJ8oJJYoFzmBLQPxCMISId5bqE9nAI8WshYF6Epjr4TDx
         1UTHtjoYh6Rp4q5aaKcZSFBj59MfYUueTloy/6yqT9vBybE3qhDcfhJrxgyMFTxpFUyq
         zJAVaRorsPm1GgLCmpnNHGohPiCgocRBX5csHIl0eA9G5F2ndzYVArWXPrWKGxtuQwF4
         U6HO7PSABU9MDfEMZVL6a+RkXzQGH4aqEZTn3tfYBwTz/sz69t9L5IDdc6DspElMxF4J
         in8OJagWuGqZ8zQ/Q17Q+F0zX13EdAVLZs5mxbAFHkokJytC8v0/h+tBmgdA/8WEO2In
         gDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXeVDlIFyDFYCPT51K+eFTh91NOEqajGN+ztlmlxhKFh/oPD3jLSSB6CFQKjhce9s6+RE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoWzCcdCR4pjdpgdt/JL2L8pEQleuqH6OxvkpNUuvgKsDN5+o
	960zLahkHnh54LiXaOD6hvqx+JJBTTeFW7Q7LSx4ezpsjt7jdMNyTIel
X-Gm-Gg: ATEYQzxr9EFn5BtuF4gnqjL+UTBOGsY3WRLP5WUf2s+yQEPDEpQt6YR7qGl8yMZxQQC
	BkZVL7Uz/ojavHrqn9BhbMSfjCLKJreZ9iIPdmYCn1Y/AlAmB5Jxq8O8U+rYH1j1LFWv5l2cw5j
	RIOy7vQ+zpI5n5a+cQEj/Rc1uhoR0jz72sSimCHw12A36ab8cVlwzKsQH1OUW8qQuaK9ThyPUuj
	ERlpJYXzHDB2OlO2PR7BHH4glkH2/gr8ZmRBpD3BhjwWGv0bgqyuyQxn7a9xsE8PMK3qhkQLsvO
	7PCZLKVEePLRJyMZGWt/HpvPPV0hmbn7O0aHS2TgNbX6Lt6efHZCT/NnPgtGWctmqZVDYGOlCEx
	bYyjFp4bcGe6Fv6/QdIBIB3ZP/EmlZisM6fNyVcGIZtgt1ENlmvnkyrTbEw9ICmsNbUA3AYS/t6
	UEW/QEFPYv9uIgg+8=
X-Received: by 2002:a05:6000:4a0b:b0:439:c560:bb78 with SMTP id ffacd0b85a97d-43b805a1738mr6643384f8f.22.1774376180489;
        Tue, 24 Mar 2026 11:16:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:8a8a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b87f80a0dsm1743096f8f.7.2026.03.24.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:16:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Refactor reg_bounds_sanity_check
In-Reply-To: <CAM=Ch07a=eO8y3-5btGcUUm3q_E=uGZVjbo__nx3zB_O3zYWDg@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
 <87qzpak4wc.fsf@gmail.com>
 <CAM=Ch07a=eO8y3-5btGcUUm3q_E=uGZVjbo__nx3zB_O3zYWDg@mail.gmail.com>
Date: Tue, 24 Mar 2026 18:16:16 +0000
Message-ID: <874im5jdov.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com> writes:

> On Mon, Mar 23, 2026 at 10:16=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Paul Chaignon <paul.chaignon@gmail.com> writes:
>>
>> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>> >
> [...]
>> nit: maybe it's going to look simpler if you rewrite it with early retur=
n?
>> static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_stat=
e *reg)
>> {
>>         u64 uval =3D reg->var_off.value;
>>         s64 sval =3D (s64)uval;
>>
>>         if (!tnum_is_const(reg->var_off))
>>                 return false;
>>
>>         return reg->umin_value !=3D uval || reg->umax_value !=3D uval ||
>>                reg->smin_value !=3D sval || reg->smax_value !=3D sval;
>> }
>
> Sounds good, this makes sense!
>
>> same principle can be applied to
>> const_subreg_tnum_out_of_sync_with_range_bounds(), which looks like a
>> very long function name, will something like
>> subreg_tnum_range_mismatch() capture the idea?
>
> It is specifically checking for a *const* tnum and range mismatch, not
> just any tnum,
> so I'd assume we want to capture that when naming.
> Perhaps we call these const_tnum_range_mismatch and
> const_tnum_range_mismatch_32?
Something like that should do, thanks!
>
> [...]
>> Other than those few nits, the change looks good.
>> >
>> >       return 0;
>> >  out:
>> > --
>> > 2.43.0
