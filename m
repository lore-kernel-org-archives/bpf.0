Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479150276
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851930; cv=pass; b=V8gVnCp/cANBLMAQR1qAoEW+BEpZJ4v0xuxTnAM6ORh7Dh5qeikIleJna8nekO/g+qwWzEmmAiumpxH06htjQEJn0pnNrhWiCguXAxQVPGHlbh8Ut7XS2+/u4gskotxzNX8m3Di2Gs60d4piR9AtMYwwBg5nRSWuFgmhjan1I/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851930; c=relaxed/simple;
	bh=4BJbbBpB+4Ao+97wbkRI8QtTUQJaPUNX5MXyBu9vgsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I731f46y9CQbXD0F6SBSAzkLpvnOWk8O0k+gDh30AYlx/rDADZMhtHZvGtZHm2y64HKhnq25Bz7YdI0oIgq2WmDgKEal+rV/tRh3bV9iJoAc5AibtO+AlE2qu02Sks7UEg/Plf7dlF1QJhF2s6bVKEqPICMQfjR+NIhXq9HGCFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKcO4mz2; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKcO4mz2"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1273349c56bso12127739c88.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 18:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772851928; cv=none;
        d=google.com; s=arc-20240605;
        b=f0YB6JvEv514/nhRZKrv4GGO3eEMPPQmqNiv1qUPxTEVDE5brzbpB3lXOBaonG+8Uu
         DHGGT3gkkKCtgSo7oOrZKwD8vJFbCKlJKU13CK5oZpDjxhG/zxaZYxETSRHM5LyKIAc2
         nXnWIVEphtpYF1wE8W0PD3D4ogah/knCxOGNW8XR7R+qidNtGlChTkahUCNpzXCxtdvr
         x0NtPBqh67Unk6qMZdyLxmOBPYaVGj0usGp5o3Sczoi6hdV98xZ4fUwQFYFpASK2OwbC
         57QVpcBcTJjNTwL2WzRqth+GG9IJOhofWoMyfxMu5lD5KoPH9uDKCUv4H8/SDCYBNV9M
         1QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        fh=KnVGc6WY3C72PWOFWgvkAQSA7s+cZ/mjXwkFV8/6f4c=;
        b=V6uDqTyBBmi5w5Y8+Q+mA40AE5tC8jOJH6wE03QJHoNB1sWpAhFeeVZqg73jiMkIjl
         mDARgPNMicuuXd8+y3p7Cn2dYs8faM2+KC7JOJBccFtWe2AY9XSNzMe90Z9Jo7uFTutb
         4Y+3hDoXhd4ksDmpFDIE/dQyoCLikyCSz73JHtZPRLM+5mW2CVNcnJNXiBUuAEBUV/RL
         TecDUstNPs/JQEpnNyy3e7ZKU/lqVaF5H5vf8UW5WOFez1d+00nPiyup5norhJQCBo4T
         BLvhKxVZJcEwrrblryLfN/MLtYGoDVmDUU/CHPGrNdmaBQEPF6W451GNbsMVEJD/LK+M
         eb8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772851928; x=1773456728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        b=yKcO4mz2rKAWz1li/4+6ObzSAEkH58tIOniR0n4RM+ywaiTtppNvN9yeTIshQ4Z8dx
         Oga1l9jhPplxZrP7/BH38vo6dAqWg3dpJL0l8PYzzWbSj2URCuYboG3bNz2QY61uj6V7
         fOGdTLXBkniwlldEwy9+tzr0p4f54nawUY26CR4joyJ7PciNCSTUQzs3p0THZkmjsRMS
         okvUrCjdVFMOKYtmhGNOQZyk4rEap+Bp2dXzhhM6Z4C8Z0gHTHhFgu2+FqHKYViL20nJ
         xqfXLgg2GdPKjbPw9crEuM5jN8sw/mNzJDsacuBoPqzujWESvWkNqYdEUiKHszfo60S9
         Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851928; x=1773456728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        b=YCEsNAnx+rMJq4/1fXjmPYsGpWKtPf7D1pih/HKaKLdJcy9RTNjD2cWy92rrurvnl3
         bX9MjM9ynj8yBlL30dNNVwy7lIg6l0lI6qjnlVZL6d8ZD6ivWSSjVzw9wtrVMBYn6yV0
         +2fYoshGbnYOtjfSW0HQYwsu5jWwab24ZSukYgKooMC0FFjLtYR1ctsOIXqoIVZaD51S
         7fLIxvveYAaQoBPz8PZ7ayCTt0maJ7KNdC9LY98rSOkHzmqw0xkV8CsK0De5/aoGvEJf
         +PuDQ41VGrj3e94amn0J0tPaTeAyjWsh2fUdseW+FtKLsHRYU09ztmbKOMQlW/ypEcNW
         pzgg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1bQZGJNH+mKWZAcjhcmwUqPrDR8ExezC+pbYFh4ObhyuD8ek7FKsTbhLJJDENOfOQog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6szladMLp+VOQOXjPUMxSlo8lo6nYB79F9i5HDrUyfOORk/hq
	kAzN61VEMSRdMZSwElQJJd1I+iCoutWv1xI5hud7mKcLQd+k0QKO1ADCTm37NMdKDGZCJUIRWY3
	ufpbiWTo9IlZqqb89qy+Nl33QBLO+ccDo7hToCT9MWKaea88b/a8kuIhq
X-Gm-Gg: ATEYQzwPGFkblySajM9+XNdbVoOqGtsdPPRwPvhpVIMI39XEI+wUo5rwZurVdge4NyM
	L/t0FTcctLUCRR1AHGxG4QRRqSCnDKUekIPKmEI3fSNihH6U4zZlJtIOQqA6k0zEtwLx0VlKy54
	WCcR38TaHK+A4XkjU5AZyD3j5Ko4+y46hGrGjcPGFgDVNMj7bbMUfh9d1IChNeutGQNbP5vdqZt
	7nblawneUCuwsAQQ6IKLRPuTSHgOOxZcruNMXNEH9RG8BzPGM3+8u5oSx7vt9xhT93n/Jj1auA1
	Ss9pdqnT59koqkJ+ELK7y5KYgHSHBbRcyuXcPVKRMHeC0E3Sm/6gfq6RLzxVyJf82fMFEaEq
X-Received: by 2002:a05:7022:b97:b0:119:e569:f611 with SMTP id
 a92af1059eb24-128c2dbf473mr1823517c88.10.1772851927152; Fri, 06 Mar 2026
 18:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-3-kuniyu@google.com>
 <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
 <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com> <dc3a8b4c-32f3-4905-8cca-078f220abfef@linux.dev>
In-Reply-To: <dc3a8b4c-32f3-4905-8cca-078f220abfef@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 6 Mar 2026 18:51:55 -0800
X-Gm-Features: AaiRm53SH2xBuZiQ1NmUKZNE7yQ2FpyC_SMw6TEOzf7sARE4BLWXj9MismNDHqE
Message-ID: <CAAVpQUCSZY9qErcJfHR0S_D1=4mwhTDqZgRfECUaPg37D6xrOA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:03=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 3/4/26 7:43 PM, Kuniyuki Iwashima wrote:
> > On Wed, Mar 4, 2026 at 5:48=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >>
> >> On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> >>> UDP TX skb->destructor() is sock_wfree(), and UDP only
> >>> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> >>>
> >>> Otherwise, sk->sk_write_space() is read locklessly.
> >>>
> >>> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> >>>
> >>> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> >>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >>> ---
> >>> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> >>> v2: Cache sk->sk_write_space in sock_wfree()
> >>> ---
> >>>   net/core/skmsg.c   | 2 +-
> >>>   net/core/sock.c    | 8 ++++++--
> >>>   net/ipv4/udp_bpf.c | 2 +-
> >>>   3 files changed, 8 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >>> index 75fa94217e1e..3d7eb2f4ac98 100644
> >>> --- a/net/core/skmsg.c
> >>> +++ b/net/core/skmsg.c
> >>> @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, st=
ruct sk_psock *psock)
> >>>
> >>>        psock->saved_data_ready =3D sk->sk_data_ready;
> >>>        WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
> >>> -     sk->sk_write_space =3D sk_psock_write_space;
> >>> +     WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
> >>>   }
> >>
> >> I noticed that Patch 1 and 2 were submitted earlier and are on bpf tre=
e.
> >> Given that Eric's commit (which you reviewed) is now in net.git, these=
 two patches
> >> should probably be dropped in the next version, right? Just confirming=
.
> >
> > I was thinking git can just handle them well, and even the
> > patch 2 has a delta in sock_wfree().
>
> At least for patch 1, I am not sure git can handle it well without human
> intervention because the sk_write_space is backward from Eric.
>
> For the missing change in sock_wfree (?), it probably makes sense to
> create a separate patch on top of Eric's change and target net. My
> understanding is patch 3-6 can be on its own without patch 1+2.

Sure, I posted 1&2 in the same series as I thought they
are sockmap stuff, but I will post 3~6 separately.
