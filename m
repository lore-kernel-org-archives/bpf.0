Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7F347C6
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670583; cv=pass; b=ExiWq6/BiQ8qX+5BihcpJjRxRJs+8F+EzwQkZxGKl5C7CRzgIZzqE1zDn/bwXhqnu05xQ1+0Yho3vvnO+TZxCEkbzu7eiSy3oy3OVQbfM8M5yksLGJ3eUoUq9ltLVI6lGF+cBST828Guy5gMW8CZ9eU3OCe5xVNyFHsIqgvvFoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670583; c=relaxed/simple;
	bh=47Xs0q0zKFuLpxzFZlmUfWNeYrh90WLJCmlkXjPRSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceQ7uEOnJ+k2B7kpiwIoi3+tXa7pDV8vWlfJ0kfd+xkdQXc2cfmOhw8B+gk5YOTSdPXcA7XCydkU8XIzq0wiz0aJQM8RPiIq28dEHZGlbdsMO/jykf6jFv9fczi5eS8YmBeLtHw5erh5/9n6yoaXrcrkzgfCeNnC0I647a8gYnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7HvvQGM; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7HvvQGM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176d4c14f5so41181471cf.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 21:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781670581; cv=none;
        d=google.com; s=arc-20240605;
        b=bOICEx/bCC25OBaEnVR1L5iZf7DU+i1o6FdL+bMZsJ7riP/IVOP3E00lslYokg+LH5
         qXV1fAwQPRcK9wW1cc7X84NVdxVuIr8aH8KF24hawnG4Hb3kNq+/gD9aUyohSBhRwoRz
         0GGFUYUCJC40nZt6fnzbx6yD6R2T3BuiQzBxdJOg7CsqyRKGyCEjJidZthoW+VHiSAQj
         dIxEcn4NSexkukVbDF29T7aL/Y9k58ur7BfUIQckIvtE2KA/c54z9+9OsIKNfTRNgL3a
         IZDrZl3e/90j3JyzwvSRxIb6nXQCYmmHOTA+mPIYNCSs4Skr5helgqQEgiZOvh7hggzK
         BGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47Xs0q0zKFuLpxzFZlmUfWNeYrh90WLJCmlkXjPRSRk=;
        fh=/ZlKb8AExKtg2EhmFovieSxcIZt7u9JbER7KVyTPvP8=;
        b=YZTdTRy9a1p1ZM3peedMFM0vRNfLHux7P7upvDkNF9XMLSpi9cDa1McT0J4vu44D++
         lXWkz2BiM7GFuZ8UxbFk7V4UX9v12hOf9JIBc7NqK40bLSnn4vAFwfoT2eUAINRFLRcq
         emUgxp5HSY4kYcTUL2KxrEoBwGqIxurqJ4n7a0y1cy0PqcpylOOx7VYnfOzP/KdMot0z
         xDUvhuz7N/WhRxSwQu11SIoX9TP5s97eB+0vURPnEkX5iEDVcgVSIl9P3JyBFaYI+y9X
         9gIJent1GRMkJvVD9h62zhmLlV3LtReeT85sVTsRpwJmU6YpA/RQiPFPKh7DtMQfoTxT
         28jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781670581; x=1782275381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47Xs0q0zKFuLpxzFZlmUfWNeYrh90WLJCmlkXjPRSRk=;
        b=l7HvvQGMWHbNOvr+/pv/qbWlX+0YsPf/qxb9EJmkeXmuf/+i8kGs8sgeooaMTxBs23
         rKka2NLbcZe2ZMwN2ruDLC1uWEk2fsQgDqbOAGsOqmb/07vAj2swdC7MlCVnrOoKnMFg
         6LRPWPU/OqOdYkUgfBbEMRLrbnrNYsXwhzgAkbxO9EmuUtzjYzOd/eh2xpsWKphzkJTC
         zPg7AafOLwXX1sNXKXQ6Nw2NLy53WtDE/M8V+O6I0SlWMdOGa+b+8pi2G4BNTNv0Y4RT
         /MQuhAS9vfoBperVt9o1+xgKGtF3lipiorIojuge+neSGEAbkUGvX97QQnuznqLw3iX+
         6HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781670581; x=1782275381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47Xs0q0zKFuLpxzFZlmUfWNeYrh90WLJCmlkXjPRSRk=;
        b=kJ3psu0P/aciplmM1E2y41DuJOCAbc1uuuaScrvlb24G/Xo9YrHTo3n4YCy1DRk4FF
         UfGvRmmPqoFviE8BBxWQyjh4ELi2I8fUYJyAgxwtdUq7D73LfIEWBRugsm5oNUNMtc9x
         GNDgUp+xyQkAgIeTzc2eErtUcsNciwp5lX/1W0OmlicPG6cO52MW8BsLnM7kkDPRz+/D
         N2ZFP5Q0GOmrJ5tPecY0vNhKJbU3R6wEPD0OzXCHxG7asCrcTrJhrwwJHupRvXMH4q+R
         Ys+JCr2UQ2ZY4Mc4+l2CG1GujYH9dy9fnPEe37LXfouFQv40a5hmoQxHYCWzpS4/iRQh
         KItg==
X-Forwarded-Encrypted: i=1; AFNElJ/v1v71Ym7DenMkVS8s5Oj3De/6KgZBKwfiV6Lvci4K/xQpaDKodTCMhS2Z7haDbpsvh+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBe+ZfEA4CarFm7mlNkNpoYLsQ3WVQkWsW13jRb8cvRmsmUIg
	5mLfJRDin81gWBDRd4F3veNxZuponlRR/XyyHpivaSOgqVY6DDXcNUHq821GQR3Ni7fbDKNKRvq
	TGRxhCYKxBOrpRaT5iCNfTlK+VVvXiVbR8lfwK1lT
X-Gm-Gg: Acq92OEShzEv4uxeYOziRiOjjxZUUxjs+7SkAh7GaO32UJzPoeYgbijdoptLXeEyCrS
	lib95UY5MQl0eX4JCPq73C3qz4ooW9JG1hZYsein51w7Y8/5F5GswF9FqMN4LUF1PfUnOZhlhw4
	9ySGfN29pc5q6uHRrJ9BHFZ22UwD6XdsRWlEYv3zdOb6hoQKWSaLT6Bt2/PM6P76bNGPYCo6o/5
	oFQMYiFBOHz/6eoBRWyhXgnixq+5e02JgZnHMp3gBKf/wyfKUxnzp1lWBaBuCdPcsnsdOTk4/Ds
	IdXoxVzimlVaydl18eTNdYxnxD4e2nFqB8e34oeHMGPN1USUqnFIBvZw6EfI/uYHoOtHFvA+2xw
	KH35fknPx
X-Received: by 2002:ac8:5ac9:0:b0:516:d4b1:48cd with SMTP id
 d75a77b69052e-519a8c6ad22mr37477331cf.2.1781670580489; Tue, 16 Jun 2026
 21:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
 <20260615185102.5e8de52d@kernel.org> <20260615191704.31be22da@kernel.org>
 <PAXPR07MB7984585F9348BB3F000EB330A3E52@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260616082302.3618bd90@kernel.org>
In-Reply-To: <20260616082302.3618bd90@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 21:29:29 -0700
X-Gm-Features: AVVi8CcPpCqwMc0RCNrYPHiIGgcG9rWXHumUyWiuW_YFsydzCpRf7A9XWj4rIrU
Message-ID: <CANn89i+Qw8JecdpbEf0tC6RgvEi2aMxA=680xY2XZt-TXXvJrw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	"ncardwell@google.com" <ncardwell@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "memxor@gmail.com" <memxor@gmail.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 8:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 16 Jun 2026 12:23:11 +0000 Chia-Yu Chang (Nokia) wrote:
> > > On Mon, 15 Jun 2026 18:51:02 -0700 Jakub Kicinski wrote:
> > > > On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.co=
m
> > > > Eric, Neal, looks good?
> > > >
> > > > The min rtt thing in tcp_tso_autosize() helps a bit but if the send=
er
> > > > gets congested for a longer stretch min_rtts on new connections are
> > > > high and we're back to sending small TSO, keeping the sender overlo=
aded.
> > > > Which is to say - I _hope_ this also solves some of Meta's problems=
 :)
> > >
> > > Ugh, I didn't see the Sashiko report, it's only CCed to the author an=
d bpf@, not to netdev :/
> > >
> > > The zero-check sounds legit. Let's revisit this after the merge windo=
w.
> >
> > Thanks for the comment, I will take action after the merge window.
> >
> > And, please correct me if I am wrong, the next eligible submission is e=
xpected from 30-June, right?
>
> It usually opens Monday morning (PST) so Jun 29th

I missed this thread, I can not keep up with emails sent during
weekends in May/June/July

Please Chia-Yu, consider sending patches during weekdays; I would have
a better chance to look at them.
