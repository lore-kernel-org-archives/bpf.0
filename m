Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DC1E4A2
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595440; cv=none; b=DjJi6EJETAef+CeKKAd6r7xgb79Dy7Ns1pAkAZM3wSHYKSQb7gJZcsBEhcjiQpN75HZZpLP+LEYQ+MTuK6mwGC2MutlGQjukc+INPnxoamVUEqh78bpz+Dheizx1kzQrkXa4mdPwWF4gGFcutSfDBiX83ByhrQHeq6VzqQou8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595440; c=relaxed/simple;
	bh=gMKz88dKP3BuhSltEA4TyRL1IYRiHIW6WsMh0ihkW9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1Z6htXLH0FfNaNkmTd4ovj0RU1FBi88GlBC3IeTn5V9ZGTNi2vCpLDUyqWo38kwMD8QWFwwN1WmvflmyexoFevTM5zLOa25BMcF1Im4VNUtTYrSh3Kt/2CBHro84QNSgoy4zvD5n3CpEPsquw/UKt/dX1/NfSlD+EllnB3vAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJWQBQa+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJWQBQa+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so3562640b3a.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 15:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709595439; x=1710200239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMKz88dKP3BuhSltEA4TyRL1IYRiHIW6WsMh0ihkW9g=;
        b=gJWQBQa+5dnjei1ZLX1RaDHrpMaVBW1gYhbWEs6JmI/aNzAkk1mw63U7hPjxmZh+Bf
         dMV1QRp4BIVE3l3VSVANGsBYVs08wMdjeh2r1x/6dQNQSOJ1GJ3kUlPxgZd2AJ+Kro6v
         2Feus9vw2qUPtSyDqS8VvkXC1G67ExZNTMpJjWVYb+GmYIjQDGUhu/E1Vd/tSsZETFXC
         DE94uAj71Di31OFd6QaYROFrLHn3SNo8aGBBXuuIqxn04hemW11asyiVcTHmKgBCAHXe
         vY1/za516361jtU0VwN2Tm9HGdQqsuxpiMNBPYiKLZ0ZQQ5ZoqU5Vaae1zwyNEdjKYrx
         5GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709595439; x=1710200239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMKz88dKP3BuhSltEA4TyRL1IYRiHIW6WsMh0ihkW9g=;
        b=ewOHO8i64tTNu9THsK8xHWspSco9opSJ2+aMAVaoL4j7CpfgiTcSWMD8Gp960s47Pt
         bEOMQw7B1nzVt9WHKar8B1bni9Blz4Y9T7pKSRsUr7DIQWtujQpMVQ75l9RLls1cie3U
         TvSkvLqCG18TZEfhrCVDXwgqaTGEUc+QT6SapB6lLDHrOYMW1ot+UPgmr9dpErhdomcF
         Un0h541DP/HkZ4ILEF9AJCBr4XWUiSvC2BRzWxrbp+GrKyQHSQPG4s/gUWGV8cTSeVi4
         KA2sCAO4D8GQz2BjcE59n1h1Ou10v8vNdZLWyUTiQ0RQbacIuuzVsZFYpTQrtZ0n0phK
         24pw==
X-Gm-Message-State: AOJu0YxlPpwekSFrZZdGaJyMaCStmKiCuzpEY4NC+ePLHwayUEi+rrRE
	J27bnC/iBvN54vZZYHCN9eldy36udxkWv8iflyxAyXWAlH3OQ0oVNMmeaChh/2FsEhB6RWT19pw
	Xib2ZpUKOlPlQaWeJE+efrJSUFuhZvE7i
X-Google-Smtp-Source: AGHT+IE1COPCDzd27PCLJWVCTyLf2HFTFDMlR+pRqr/iD+8t/MkDjYSuvsWcJiRhkn1Ijv5CJ3XqYZ1exmC00/S9NLw=
X-Received: by 2002:a05:6a20:394a:b0:1a1:41a3:9b54 with SMTP id
 r10-20020a056a20394a00b001a141a39b54mr215611pzg.32.1709595438701; Mon, 04 Mar
 2024 15:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
 <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com>
 <b1b259639635e9328bbbbc8e0683b14242f177e2.camel@gmail.com>
 <CAEf4BzZjps4+teYzWw8=8Jg0M59bCVRaB_0zLNTmfveBQ63C3Q@mail.gmail.com> <7d48c3fe1e4ccc4622a082ea3f3c25ca79be4086.camel@gmail.com>
In-Reply-To: <7d48c3fe1e4ccc4622a082ea3f3c25ca79be4086.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Mar 2024 15:37:06 -0800
Message-ID: <CAEf4BzYzJ68mQ=x_Y6TM-a71fUvPHZrZFKbzh90YqUZmXsU=Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-03-01 at 09:34 -0800, Andrii Nakryiko wrote:
> [...]
>
> > As I mentioned in offline conversation, I wonder if it's better and
> > less error-prone to do linked register processing in backtrack_insn()
> > not just for conditional jumps, for all instructions? Whenever we
> > currently do bpf_set_reg(), we can first check if there are linked
> > registers and they contain a register we are about to set precise. If
> > that's the case, set all of them precise.
> >
> > That would make it unnecessary to have this "before BPF_X|BPF_K"
> > checks, I think.
>
> It should not be a problem to do bt_set_equal_scalars() at the
> beginning of backtrack_insn().
> Same way, I can put the after call at the end of backtrack_insn().
> Is this what you have in mind?

Not exactly. It was more a proposal to change the current use of
bt_set_reg() with bt_set_linked_regs(), which would take into account
linked registers. And do it throughout the entire backtrack_insn(),
regardless of specific instruction being backtracked. I think that
would eliminate the need to have bt_set_equal_scalars() before
instruction as well.

>
> > It might be sufficient to process just conditional jumps given today's
> > use of linked registers, but is there any downside to doing it across
> > all instructions? Are you worried about regression in number of states
> > due to precision? Or performance?
>
> Changing position for bt_set_equal_scalars() calls should not affect
> anything semantically at the moment. Changes to backtracking state
> would be done only if some linked registers are present in 'hist' and
> that would be true only for conditional jumps.
> Maybe some more CPU cycles but I don't think that would be noticeable.
