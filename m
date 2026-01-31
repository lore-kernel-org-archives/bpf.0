Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43373366832
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884872; cv=pass; b=fkOPFnnlakO+Hjg/AKLA2IEeL12uYLyuUUvjRk52muQDmER2wGJ6yr1xjFXHq//3LcD93a4Y+b8RfVhqvcK5rB3CvD23/bBE2LhJhsUIqjajXYZZo1rpHVAaMe8GhAbdXj2qaDCEs4I56deT5t5OHjFuecH3Ax2fhKs7joZZ4GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884872; c=relaxed/simple;
	bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAiUffQlaXo0P4C3NhrE+Z8NnAT2sBZa2ImvSAdXjvqIt+ivCZkktsN0+C7hW57JXtU+Ybp5KbV6uu1uCAeQqFfiZ+lBThAKAG+YZ5uh4mJB3/XqKpYmhayskHvfunqOJps8oFvRW69l56HyeX9ADIg0PolDe/ICVsX2QijEzrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx0T8R3v; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx0T8R3v"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6495d592c45so3123332d50.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:41:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769884870; cv=none;
        d=google.com; s=arc-20240605;
        b=QZqpzXAoyo7oYN1pphH81U6xMWqV/fvIzIg5/z5dmjsHPSO76L5jGhfEx6E3nnVVUm
         i1gA4FzHF54XNLOBYmpxYWPFThzp8KRU4U0C10Ed1TlHZ4hmXluMATQ4WPz25+3XTrOq
         1JpDORjCw2o21R0UUsEnE3uq/N2SmLNoipMe1Mv2ASVUziBfVx0kYrJ0d1E7T0c51FDJ
         jZ5SB7LTAfm++2Nq6TUYNdPOl3814bT8Cr5vh5s/P03I/ev5w94sbQSbrQ2Ak5O4P4SU
         QwaK375m0fLATtAhX7vUNGimpEgmf8/XV++3kaF5gQP70NfLeVsFdt07QzrGC1qDCYaL
         BJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=E2jXveD+1/06VGmJBl2YK+djvxHmPmNeqYe0s78pXiiq7yGXMomZPoXSdG12HIOoFY
         rgzNqPD9bFms3uYabX+lOoWTvln0cc3XbGCR9A1PEPfp8WyGo1FIMJm+d1j/y+C6ZcR2
         vzSPeogeD25gFSYf4/ZJtU3MoXluMxhLN24QuP8wV9O+vBqUv8aTwN5HEMlpfRcKfKNj
         +FRRQIVPoc6Mwo0owFxjb+zQsxMhVCSaYpNz9+tT52ebKH4VLJ6lSLl02ZwXTiXi1pDI
         paFM0prhK8+IVoCGlldy4t2jzMaXnnlsZghrtOjs1AO50z6ic8VbzL+QO3zJI/3MD10s
         a49Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884870; x=1770489670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        b=Lx0T8R3v1DfO3WLX66agVJl+NIH61jpNdij4bjvo3nsDc7LcC97Yqz++9Uc7FaC7IY
         hOVOJW7ML4o2PXQ6ofpIypWNsaUMDSW+gQ0jX7SYXyDFysTNeY1LETDfND6yAjZ7iOuW
         Ad3c/aA5IBQLhrmkrJi6jNUNDyCxY//4z9haJL0ivJ1y05xPVzAqauHFYTEzWWeFsK9d
         akMoRuXn/ur9pnyxyM2lLYCRJx2M8uqLh+tDKU2s+7jxAeL9yxXDwOumW5097DMiQEK7
         QFnp21VPyOsv61Y65tBJYKPkMuyMfEbO/v5llJazUB4yadfvvaIp4D3C3jm7EipDL4FN
         jBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884870; x=1770489670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        b=Ey2Ne5h//cECQ+ZymnWaGn1zU0x2mNftPS0AKP/V0D6RsqJWbEsToQrQop9arYKOmu
         LjIv+/MCm9piNK/4OBTLpQuYPaiBafS4q0aNl3/0lpU7i9B07sQV6Hh5Q3vgpTkAHGJf
         C2VU2qyxMW3PcTqhckit2sm1EwcXLNZV1mk0H22aBvCBJnN10SW7nawQrmCgWW6gtUnW
         GDr1UlUm2dq7+AS18AgE++iEdAkzhqtp5620NF1CGII0Hw9Gx8f+KOIwKnMBhoHmF4vd
         EZyw9anL1NolmWepY9u6C9QAgZNOMVb+EoNO5N1FM71AiIQsZ7qaG91vwNo591NmADV0
         wmjg==
X-Gm-Message-State: AOJu0Ywrru8T5/Pboy34g6wadPCwAyJmX0Yubx43n6ujW4Q3i9stT7sv
	Njdz5XlZW3i1VbZDbtsdkWp35Y/cV9uWdvYKmpgYcZwgrxm07urMCBtcBjZ2HlgSg40I2YUx0hI
	791OcxDHWio/fVpY1b8e3QOX3kBI5wA0=
X-Gm-Gg: AZuq6aJkiQHXkRCCrUgM//6g9LwzhpPB9DDtHex3JumhmWew5XgdbUC6V231Sv9JQb3
	juyE6Omf6PXJp66BxA+Xz3MaJalHI/nJv9+EhucomcxOzLvy0o51MvBIAhtaXbXZvZeN7gEz+bq
	Rwrs52KE7dNaxa+jMAbSUYzzb5e6CzegW/RKyurN4XdpOoJqwwmow+ISEU8khEWI+28w1sv+bgy
	PxXZvri8f5eRpVOpk2CRayRS79LG4CvvUbOUAXh2doMxzFMCqrLw37nezWujoZIq0uv4rw=
X-Received: by 2002:a05:690e:400d:b0:644:444f:3bd1 with SMTP id
 956f58d0204a3-649a84cf80fmr5260688d50.68.1769884870164; Sat, 31 Jan 2026
 10:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-3-ameryhung@gmail.com> <978ac9073e0fadb08c40399bbff7d78cfa4a826ef98911fd654318a9ef9725b4@mail.kernel.org>
In-Reply-To: <978ac9073e0fadb08c40399bbff7d78cfa4a826ef98911fd654318a9ef9725b4@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:40:59 -0800
X-Gm-Features: AZwV_QiX0B343TusihQFChhKSjsbE837pUNA0oKthdptcAdSvgLvkRaiz1Igm2c
Message-ID: <CAMB2axOww9RzMFVefSmkPXCggDxE8Y_vJONz=X+5Xaw7099e5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/16] bpf: Convert bpf_selem_unlink_map to failable
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> commit 82de4fd08a55cc944c23c9ae889ed792870964d9
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Convert bpf_selem_unlink_map to failable
>
> This commit converts bpf_selem_unlink_map() to return an int (always 0 fo=
r
> now) in preparation for changing bpf_local_storage_map_bucket::lock to
> rqspinlock. It introduces _nolock helper variants and extends critical
> sections to ensure atomic link/unlink operations.
>
> > Remove the selem_linked_to_map_lockless() check as an selem in the
> > commom paths (not bpf_local_storage_map_free() or
>
> This isn't a bug, but there's a typo here: "commom" should be "common".
>

Will fix the typo

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep BPF subsystem kno=
wledge, contains a human-typical typo, and is part of a coherent patch seri=
es - all indicators of human authorship.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor typo in commit message (commom should b=
e common) - no functional impact.
