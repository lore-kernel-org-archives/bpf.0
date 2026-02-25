Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E533BBAA
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058955; cv=pass; b=it3iR9UgbFY3OVPBVGeiDdDXN4WVJ0XEBRoKH1KIdF66l+CpCIXSp3/MelBzv9Rhs27/0a2EJ2F0irL5vh+wxklE25M21FaUEy/Ol4u3kF19zocCk3oP7oU6zknu/EMfRBWOetG7DfnIRDWkVkmBV2nGYOY7D1pHozTYnE+HZWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058955; c=relaxed/simple;
	bh=rJ0im50NcDxt1NLpepA9U28G4sJ3XTUTBiq79IqFJqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EO0zVTpqgEsa2sWbVj+2qEbKHmPOeV5AUeYrCJ6pyLWGOYNnyzbjiVlFNlDat2EjVkXiGKlOM0Ee5qFcRlqBgAOi6byNmzU9MUTEFwjfhxxjnLRh0TnfIq8ixJlnaKBda7pqrhYGRtG9Uc7kTfQ47qikkjQS/Bpu8QpQJ4OnCJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0W7bLKh; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0W7bLKh"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f8d80faebso216341166b.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 14:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772058952; cv=none;
        d=google.com; s=arc-20240605;
        b=gAtFy0SEZ88hKi207K0TI9V9e4RZcTtscP4Cc0SwB7MzlRTysX75L+0mWfOBTONeID
         icSZCMmhN8R79894s3mc7rOSiaHrwEBS6GV1+nnSA0CU3rqEFVRmE0+Bb1nYdFwljWkP
         K2uOGCKEcaOylwJO/Jtp8rvv5CT/54cEgwAvhqVRHybGh97FPHXVOpn9FiPo2Emn3kME
         vTMKVM+e95Iqjxq7lQyf2Aib4h2IfdL1ritx8RQc2IxGCN/k+GP/1rZeSNlgjUWJEYn1
         SyjvjNW8xBeEPY/9bAlm3mR5FISJahlECHFXwwQFuJpNPbDEkYienjm8wfHXUwyu+eh7
         UbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KYN+EboMy+wJoEldSrgFbbvEm7MGstDFP5WO2DlG0s=;
        fh=0CBlHtzXsfVAfOM5SzOfs4NW+EdRl6DMC7eKpnYbPZg=;
        b=KBH5Hqy4mwh/sg06x0bNjhoIEn71RHrjkHYFUQxsQRH5TIwepAG5S/r/tJMgwP+Nps
         k7vd3T6d5L6EYuTQARiv/TIsaUbBfXGpiFfWh7FSv22Mle7Rq0Es/1K0YGsREeXT2PNk
         W4Sb3I4DQuIw99+AdW+oFJrgfBVupTOn5uFOhHxRsQHvPDG+T7i0Prg32zrlQyRsFP2D
         PhkkscL8jYNzrxeTgo/W7V7Q+u7mlCC4Pt/YWoEi7p7P54sEVd+F2NBbFEcKczUa0m0Y
         FA6J66UsRXbTdBL8Xj3KsyJXgRPGe/YAgZYEF9+NH2l+ek5SjRW/A/4Efr3zdTEzgNjK
         SyeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058952; x=1772663752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KYN+EboMy+wJoEldSrgFbbvEm7MGstDFP5WO2DlG0s=;
        b=a0W7bLKhMoK4F2GnTT6DEJoeoqTGdeBjVoLZbw74Xzj6UXKA1X2zO0U3cUGjGOW887
         VRDedLUBY9G6Evmx+5Spjg82gvzCiMnK+QiHFaL3vtIxfrFBgG9BwpMTf/TTLCDSM7gB
         HEWQoNUAfEPWZ35sVMspW6ee0M9qMeMMW1PoYmTns1i331dM9R6TJTkkYYhHNMgvpag3
         Wnp5rV4PcpqNC9Tcsrx61HdlbAAm43n2fOsVeBRUrpctBxv+zm3zpjxBjsWO2b0r534Z
         xgW0Nqcn7WymBZTZROrfbXo7aOrTMBq8mNpfnhAY5MexkYk+ympT94TRA0ZxzG9xhC2e
         Cqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058952; x=1772663752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KYN+EboMy+wJoEldSrgFbbvEm7MGstDFP5WO2DlG0s=;
        b=HmdTeORjDGoh/gMWsp8SAUYRAVq15PyOYuQP9WRaHR8YcULO7rp++6xXkn8R4cgxw9
         Xs7JlpJHSeur76JV9mZFMh0M411FJgSl2IVh9GDpWnDGVewyKUi1oJYL9Pt+l3J36MLG
         xUfoS+OTgwOMgSyh4Qe2qxE7KtEBB1khcehOBc37fI2Vf135SZOpQpZ2oewSXjruWyD2
         q6E5VWwX6LY8e3vL/iRjzFjAhA7CTaKi2Kyh+5vKkPC6QAzF385aSRQLmAkJ+hE1gfUD
         fWFEflB8QdEH8NWU4FZpvKVi51hDeOqWWm8T5Y4tShG2RaHhtCELp6vCGP9AdlMf1NiY
         DYKA==
X-Forwarded-Encrypted: i=1; AJvYcCW/bvP+ZSMf09SFc9CLcPIT0p/i32A4JrRHxANa9hE4t/KmIh37pKJb6sfYoK82j6jWfaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7whFrfE2crjqasv7ATdbAER5L/dqA9w294rbV+8bULMU1Iw5
	FUIoIVKC9qRHIoDyfVycklp2yXNnkzDF9AJPz7kDpaE4rjiHYQzfDDhxx+M19ccN7lYonYcs/Ym
	kwSWcaThEgnwa+cYYgDREbPRVTXOKJmP8QkSJep69
X-Gm-Gg: ATEYQzzX+7UgFeIn4WfUj/PLjrh7kx3aTRJQU6GVE8cd8GKdQFjPTMjmmYGPEQyQlsb
	zMaQFb5Mc46R5Gd7VVjH/5k8lWP+usnBhhLnDOSCwE7qdk8LdllGr+agDV4AGg6FZ8ZS3LCASyo
	KypdUXfG5tVyPcQEKELPjpm/nPeFzgNPAIVK4oxnJWlty1rcJ3Wb1ImAgqtFBOA+ZxzHv8mqXF4
	xVWgCswAI850crBslg/fbJcUiOVIS481Vjehz3Ts+hfh+Dzw6rKf+Bjjuyn02icKhLvdHYCFtOQ
	r6NiWIwUckfKC089lHkvY+wRrFu5KVtuqjJXwA==
X-Received: by 2002:a17:907:d94:b0:b83:3295:15d2 with SMTP id
 a640c23a62f3a-b93572a6e6amr39884166b.30.1772058951635; Wed, 25 Feb 2026
 14:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210820.177674-2-wusamuel@google.com> <757bc1b31d0a6aa67c687c05fea88d97a7568fad0a3c2a880c28b931906fe315@mail.kernel.org>
In-Reply-To: <757bc1b31d0a6aa67c687c05fea88d97a7568fad0a3c2a880c28b931906fe315@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Feb 2026 14:35:40 -0800
X-Gm-Features: AaiRm53NmwvDCUKvRrbz-nVnwFT5sg5XR_DZ95o1vOa09ctUZKnFFOaIhSv3yZc
Message-ID: <CAG2KctpvHaw-pZzvL=q0oRqwyiVXOs9iebBe6QEDr4bpzbUoMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add wakeup_source iterator
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 2:03=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source=
_iter.c
> > --- /dev/null
> > +++ b/kernel/bpf/wakeup_source_iter.c
>
> [ ... ]
>
> > +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     int *srcuidx =3D seq->private;
> > +
> > +     if (*srcuidx >=3D 0)
> > +             wakeup_sources_read_unlock(*srcuidx);
> > +     *srcuidx =3D -1;
> > +}
>
> Should wakeup_source_iter_seq_stop() call
> __wakeup_source_seq_show(seq, v, true) when v is NULL, before
> releasing the SRCU lock?

This is the same response as in v3 and v4, but I don't think it's
necessary here since we don't need any additional output after
finalization, such as printing a footer.

I understand it that bpf-next is now open for processing since the
merge window is closed, so unless a human reviewer has a different
opinion on this I'll ignore this AI feedback for now.

> [ ... ]
