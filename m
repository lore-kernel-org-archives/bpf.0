Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210F2EC55C
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313207; cv=pass; b=b9DG/mbv9benHykRQVjfNfhK+EbR/0u5/CK8QT7U1IHXOOQxJJKCD4zIw4M9L4513abGWYoaOLiCqOMYN0kW34BE7rj/uvYSBIJiUWgAbir79SAvQKQsaHvxocfmyXOIi1/TVJxWr5v5p26GMcKqXV6/K5apOqTgrWOUPqEjYSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313207; c=relaxed/simple;
	bh=zVdpqwYG7PaWa4bf5lLIQyx/ODHwgnQIuFEz6lmmX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVnUUqyUHzqbujYq4fFYObdMb0v48owedH3RZ1sABcoWtLZT3oIrpHXqBgQAYKwjGMZvA8DhfrPfoVflHLI2qtPpOHYwaCxgCtQ99YukcJGWYGmngDTmbvpk4kxdCs/g2xMdT9yyDbGti6A5tb0BV2KJtXsGlbgS4+NahvZllU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjkKGPEw; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjkKGPEw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29efd139227so9572015ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 09:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770313206; cv=none;
        d=google.com; s=arc-20240605;
        b=GJLvovqOUnUdJh0kxvNLMPFaY+oj7rgDo3aYQ8NjHJSYxkbiaszZGTfTTd3hGMbh6Z
         v94gWU8n+IfCheerf/+BCjOtCOItCHbuf12daaXchf+2f0ElH4IBAxabrlXYWWC+9YoZ
         tLmNeFoAfbguMUJjLvxIWn1sSqKsuuan71pc+uDG2bE+I1UPmPalUovjaaM5OKa42sUs
         TbWJLlQgXqe3vBRu9wE6O4htPEReBjrjxYGCPJOFU6KD5YmEYOZAy2w6FGT9ssDUxHxe
         clWoTRhFnnj5KaF3yxa5keN3TLy/Q3wdCoszHn19fP/Lc07RLD66n7nhECo9yM83/MFF
         YvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVdpqwYG7PaWa4bf5lLIQyx/ODHwgnQIuFEz6lmmX2I=;
        fh=/y+bwH9IQgpfgvKMwCbRdBKFjGilnt1VTlnU4VJFXms=;
        b=NG0iFXKwIZs5tf/tHQP9dgFyeJYgz7jvhFI9Qy+Kzcf9XGuvaCh0J0phfGgLD9XgMl
         dls1+/eV57M+IV/q3YX9KrYGZMe7KPADLo05NrWIwDgb33a/J1rdENLVnT9Uzsa0ICkB
         L5igk85VcOkM0yQU08KcEoeG+D+Jm7z+ABAoAoQgGmYs9pJHVPr3KOPVEexAzcSyzKtX
         Vp3NVak8w/vZNIokwj4a9TCBI93Tmg3C7GT4UDqi5e58rGUtEaeSw4KeKgIwrv3AG37D
         c/xaqkhbi93GN9ruK0Dd5oAO4TyA30IN8Dc6IajMUtnY/kpa92AqgC8uPO+D72rR8bWM
         iWog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313206; x=1770918006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVdpqwYG7PaWa4bf5lLIQyx/ODHwgnQIuFEz6lmmX2I=;
        b=YjkKGPEw7VZ/omN9NQpgylRuCzrQ5YVnuJ/nXqQWulAyDaxakZq0Y6+rjXTMr0kKvT
         Dhvap0fAJOKa7f1emShykvsNK3w+sg9NFBTOMwftrJ9E3+O6EQcUC0P1Boa2UNkaKKNW
         N9JiIYi03jw0+0rOeYrP1JCjrzXLyevE1GWOj+C3A5v/onCJUWttiSJdn+ZhXwmi2/jW
         LINrIPyzNLHEsH8dRqSRB2jIvZkaRR7wTJGOy2spnkpowWyQShOgNo5PdAWPCcIZI16J
         66oPFD8CDXDUnJhuBPrVK3SUKE83gZoKrQETdwKxQkIWBzjm9siJLQabrMLHDXeVs3Je
         OvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313206; x=1770918006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVdpqwYG7PaWa4bf5lLIQyx/ODHwgnQIuFEz6lmmX2I=;
        b=Xk4i0PFl+GQ5YLvhnRTqMwAYA803OToSkr7BiIxVoco4Ror/L02Zj4xw6cG0vrXZxj
         BS76SiFzMdoGmzikR92QQIdG8bdpnva5ZsdIntX1ZM0CzFqIu2BBIsCVpiNVu8P5+eW4
         M8lt0SOkARookLJdPyNe7mmgZ3JghglF3xHf/ouEwgvPmvSdMvwHpViTCj5dPIebsJ48
         pZWsFrAUU4SX0jVWJ3V7mTnRomRqTJqMrpAgussmZaR95ayV9hYiVBv+wSzOIrQrs/f9
         KEZnWJ0bhiQhAM3Pur8aV8xbL50LHKdT8Boo4gz9pW5zo6Jpyi/YeWwhTGrqgxG42jyp
         Cz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc7dubWr+F+EJ/8qpzvfoJYgaryDStdPHwBypILONbHJnzyPk0j+UTnwfuq8QRyLal+pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc8iD+2d38EIKX8sQ3r7Heu5gb4cTbCByZwJXEbxC7GeIU0+f
	9KcurtAcQDHQ/H/vwOdveiZs3r3nivBpMLvYVVClTYI/WCgg1aKhqUmKUdIc8gZoj+WyCarfqHm
	RrBY1WV0s4ZLaqPeUSPU3Sb3LKCVk+b0=
X-Gm-Gg: AZuq6aJGNo/6VaULQLcf8mpGJmMDqPcZzfPIiZ3kn5tBCY4JgfWpkiRchpI+aMNi6UD
	iACLIhSnNzL1nqLQqZ6OMYaky/cnVtxmctAhZtUpPyDscBdrpZR+xXP8TabgUTft+/ojIXk+0h5
	NoL6hfg/Xfu1yq4MmZIpD8XOVRXa/z7/uolpZL/2MyGzne7cY84FjTEAl519pZ3jfm7HGELXx3u
	eesyXz6gcRCDLv7DlC1CXZM2Ej2x2F8A/wAp/HwvuZikN2gOTXBmDHW2M9W88aBvQOTtbxU2Pss
	zP1rMqbcvgA=
X-Received: by 2002:a17:902:e54a:b0:2a7:952f:97c3 with SMTP id
 d9443c01a7336-2a951646166mr735095ad.21.1770313206319; Thu, 05 Feb 2026
 09:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
 <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
 <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
 <20260130152400.6a71abb8@gandalf.local.home> <CAP_z_CjZWFqyKAti_NLtq7QhiJfwVXhohakQh2yEFS_vLsb4zw@mail.gmail.com>
 <CAEf4BzYq117=EbJ1ovpr0YBQr=myvxwF4uetO5umL4P27yAcDw@mail.gmail.com> <CAP_z_Cj9Z0q-UrJUKgrb4vQ_sTQbyN-aN2GM-ZvPLNsvcS9k-w@mail.gmail.com>
In-Reply-To: <CAP_z_Cj9Z0q-UrJUKgrb4vQ_sTQbyN-aN2GM-ZvPLNsvcS9k-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 09:39:54 -0800
X-Gm-Features: AZwV_QhHx7UarewTKsOadJzQl3Ep9pOsdRH42oyfWawBLkibYYXX9AVjpiBK3M8
Message-ID: <CAEf4BzZ=oawwbEtTOOEsVsoUkJsuAqLietyQHf8QVa5D7U5P-A@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Blake Jones <blakejones@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 5:51=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> Hi Andrii,
>
> On Fri, Jan 30, 2026 at 2:03=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > Yep Steve, your explanation sounds correct to me. If there was a way
> > > of storing a non-constant amount of metadata in something like
> > > task-local storage, I would have a solution.
> >
> > There isn't (AFAIA), but you can approximate that with a global
> > hashmap keyed by task's pid + whatever the original per-task key you
> > needed.
>
> My original per-task key did include the kernel stack trace ID, as
> stored in a global hash map by bpf_get_stackid(); if I understood you
> right, that's what you suggested in your reply to Steve as well. But I
> don't see how the task_work handler that gets the user stack trace
> would be able to find any hash map entries stored under that key,
> since it would be operating from a different location (and thus also
> from different stack traces) than the profiler. Could you help me
> understand this, please?

Ok, I think I see the confusion. You need to look up how task_work
(and, similarly, timer and wq callbacks) work from BPF usage
perspective. You basically get your custom context data passed to you
in the same map value, so in this case you can have that entire
hashmap value as your context by just embedding task_work field into
your hashmap value. You will be given that same exact key and value,
so you don't even need to look up anything.

Just look at the BPF selftest for examples (grep for
bpf_task_work_schedule_resume), note what the callback gets passed in
(map+key+value).

>
> Regarding the rest of the discussion - what I'm hearing is that the
> need to handle asynchronous user stack traces is just part and parcel
> of any decision to switch to SFrames, and it's up to each user to
> decide how that cost/benefit tradeoff works for them. That makes sense
> to me.

yep, pretty much

>
> Blake
