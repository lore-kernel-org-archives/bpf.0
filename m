Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8519309C
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203900; cv=pass; b=bm6FUZ4qB4J4YXaPL8dZqR0tK9FabwXueAju9OruNMmWXXRqjKFmNDaVkM5EfevYGllxIvS4BmjZPCrUaG1SGgHi59J/KeB+S5l2AjWUi1+Us+hhpM5j8CIvKRK4VBsR5EQKqfkJp2/dXOLqEtj4TtI2veIu4/L0QqGc0x0Qi68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203900; c=relaxed/simple;
	bh=nJojw4RAHs7l7r+Fo9vlFDzzUIL3e/8udM1ParGdhXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu7i6aYPqIiYSlYN+1qK1v8t0VJde/jDdolgKTq4j2SsMD6db6D6gySBL6jYy9PojjI3TWbjInJEZDZBupIP8XNnMK6y3cgKO1u/Xl7MgAi9f66WlbuehEjEp5DIQsJ5+jtO/yWDeb4pDg4xD/uIGZNLQfDYNkjk7IM8GjINe2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJaES4Yt; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJaES4Yt"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127380532eeso7105338c88.1
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 17:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203899; cv=none;
        d=google.com; s=arc-20240605;
        b=RFlmAFIbGEjISiOyYtDw2mlv1dtFdpQEIo0s8lraeXUofFwWyH0N51imQA0ClNT0TB
         aD2e/RFSuDk7a9EEDKyhTerICoSrSNVJsp1fgiCXlk0sYf5r+jf1SfNfv00snkawtGE2
         lvYXkzq5/Bq8Fz9hbHX4zf1OV+KOcFCxq32nuWnHYwx5gz+nVIegNa7aP9ziAzg2h6Wq
         D7RuaRVL3qxqdcIqve5E+BsCvM+XxRJCwGvGLw4nwO4ROpLSU0XkLybDY3i/0ZL+bOlW
         zYJCx3vMl9KFzuj9r6hUPu7YA3PIq10MP+0oaX614RzwfYlFb7R8uNHdJcENy8APn3cN
         2owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        fh=n+FsRptCx3Xo6Hn23S8o8I60Fx7RRD3VZC/xB+jfsrs=;
        b=fV6LSKFpiO5Yhrn6Lvsg+XKitGBM8c+lVw96wxHtJHcgS4TE8qNTKzPzSOQK9sufCV
         rrhah5k1K+vSYIsOGBoUkW7VPJof49U1T2FK+L89BcvB7itq1f7x67V6LmBp70/AFYh1
         HiEnxX1dOpQC5uaY8LPrPx/gcyAh8Ff4G8Ddes3GGNBB8NseiIFGdIabpwkyrbdC6bKK
         yHJNPafJLf2eQPW2xExqH1oOoxv/51W0y0G/CHF+8X+IMr7C8i/EbyW+SQCI5qhlsr14
         cUuUKOb2m9LmmHIY7VejdJ0fQpDm1xgOMnK8QUB3n5vO1XFDKzznrhW3MxLXCEL4gjBo
         hHMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203899; x=1771808699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        b=JJaES4YtDOZUn9pliNOH+c7IU6HtB/2Xbr3cmnMCk2YEZ+VX9MtM8orr3u6ewUFx4s
         skmtPs8kKtyyE9/u/KyxIiH8FVUs/1zkOTAxJkDiwp8q1fsM604ej7Ou8fUWm53QqcfA
         nlGvFaN0joxJWckEWIEECAP4YpWYeA+S36t1alllHxlRf3c1h59hXEyJibbmuJFZdGoF
         5HknOlvyrBNHUmtvKYMUPNG80UpsuSoSYJ9fKo1q9NJYprsBMFac5s2+hTZRYr1vTi0N
         wGt6OZFwqvHxq9sBFI+cOXfOqx0LKtA5ot2Q6ZmCEkh+bBIWsVlD9B4+iGCrUDuHv9X9
         EHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203899; x=1771808699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        b=c/q8fojJGMvztZwGr7UZSz70u0BP/aAvsxqqRf3BYyc8acRqhhu8Gfj6EBY3N+MWM8
         US6N1fKtOZbeKFP05bGOVM/xZxYndxtMcsQIMXiQNEDp8GxkeePlIMJdG1cNZ6dg3V68
         KJafIh4kV7kRshawi4l5tOc0mMKn+t+FDRxU/GF5pA7kluKP3ehrD0B/oYwaTDE8ig/l
         56aykGcN03STnFi0g3e2noaTuF+GFULjddoklPSZhnrXUcLVReIgEO525TVS7qDSkPi2
         9y3lRJUNzsgbFC0OYTNoJ/2xFRDNkp2zshNsxON+Kx5XDLQfeHHvDJ4lBl2a5GeV3qJd
         hgoA==
X-Forwarded-Encrypted: i=1; AJvYcCWNiw73WYmiM6ssmD9Aj3OMf71u3cbFe/SvXzfrtPQF4VZ+mOR1PQk6LmfBghcgfgt34Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3h39FW/FUs4ghpKcogRsUXkizBYknLiorw4Crpigwt5WsLlBN
	YXcXlBLG5ujhmxWt8x5arMl1Yh7yK3RajrstX4F2jlAvVvBqsE1pJN+jmzUnPOFbsaHMBBmPvmQ
	nc96OSh/0QqHSAgy3lYTjiWF/y1sNy8r08YWThhao
X-Gm-Gg: AZuq6aIXfqFVNXRfMTp8i37dYdyvqtYOJSSH59ETNfC/FWfcXjc1YwqKFhQEPQ08DXC
	cVv4pWGh8kzpOGrGjmatUrcCzVop1EUHmUDM8nhIAwmjdvE1CCVbpUffyTEK6Ff4SjuUHzH9tHl
	tkE8aWzYVJYwbMgAznrAx3uqruhlGgq9LvcSnGgrOavfzajnXvlDB5lIavOEwu/KbOBcRkT94Xb
	AAhQ9VdLMMib2JhcANiiuuwWiwZcLoa9/OUZ/h/VRp2+dyb9Slo8m+G2DORTMURko/WXJz8ckK4
	Fn+aWOIKymqREo0dKVsnV9Asnt3E2mgk3hzk6Q4cadP9kKaBGm5jtpXu6DIMoIyjbDMV2w==
X-Received: by 2002:a05:7022:41aa:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-1273ae20572mr5187717c88.18.1771203898170; Sun, 15 Feb 2026
 17:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-3-kuniyu@google.com> <4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org>
In-Reply-To: <4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:04:47 -0800
X-Gm-Features: AaiRm51Pk6ofpK3ViL4G0QabdziltaHDnIs8gp385wI50EN3aieDUAmdV2XUR0k
Message-ID: <CAAVpQUCHahesdjJ_nKa1SETJpafO_B5hxEYWKWyfv3TdnB3gWQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 1:21=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2690,7 +2690,7 @@ void sock_wfree(struct sk_buff *skb)
> >                * after sk_write_space() call
> >                */
> >               WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc=
));
> > -             sk->sk_write_space(sk);
> > +             READ_ONCE(sk->sk_write_space)(sk);
> >               len =3D 1;
> >       }
>
> This annotates the invocation of sk->sk_write_space, but earlier
> in the same function there is another plain read used for the
> fast-path comparison:
>
> net/core/sock.c:sock_wfree() {
>     ...
>     if (sock_flag(sk, SOCK_RCU_FREE) &&
>         sk->sk_write_space =3D=3D sock_def_write_space) {

Will cover this part in v2.


>     ...
> }
>
> Should this comparison also use READ_ONCE()?  It reads the same
> field that this commit identifies as locklessly accessed, and a
> plain read here would still be flagged by KCSAN when racing with
> the WRITE_ONCE() added to sk_psock_start_verdict().
>
> Additionally, udp_bpf_update_proto() restores sk->sk_write_space
> on the teardown path without WRITE_ONCE():
>
> net/ipv4/udp_bpf.c:udp_bpf_update_proto() {
>     if (restore) {
>         sk->sk_write_space =3D psock->saved_write_space;
>         ...
>     }
> }
>
> This write can race with sock_wfree() reading sk->sk_write_space
> for a UDP socket, since sock_wfree() does not hold
> sk->sk_callback_lock.  Should this also use WRITE_ONCE() to
> pair with the READ_ONCE() added here?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/220428=
99757
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit is a small, focused data race annot=
ation fix consistent with the author's established kernel networking contri=
butions and standard kernel style.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Incomplete data race annotations leave additi=
onal plain accesses to sk->sk_write_space unannotated, which can still trig=
ger KCSAN warnings but are unlikely to cause user-visible failures.
