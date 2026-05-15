Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024323F9F4F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832793; cv=pass; b=NccWRF/qn+pZaa+Ie1SuJyVqGqlIwh6ehapyVBF8MxrjWDXknjv7ZsMyvWR04DRA4kch0kyl1HZaDbnWVvAOSh2lGHEWPE53pMspEsxRpegZxaG4G1zj19Tzy3jkLjdHYrC+NB9vB8cRjNDuyFy7Ug/sf+YSHc7lVNMFFtEcG0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832793; c=relaxed/simple;
	bh=WZojfUbXd3wS4TVRo6hSiQiW7Yxrt5hOcaPdrieI9Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Wwjf4qkh9+xKPAODJZvnCvYUaUp40rUauPGEODyU9hCzbe7oCPne6uWnqd0PLSUKMy3FZYHctrk4trJW/EpB35NfVW/xFT7jlK8olXfgLxnbjYgWlaUG3T3+Hu2f2cH4i4sJ3TOLzOP4VWW6nsloAmOSUPXte2pMIjultfv+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1usW8D6; arc=pass smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1usW8D6"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5a858881ad2so10409350e87.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832790; cv=none;
        d=google.com; s=arc-20240605;
        b=LjYiGVXIEZgyBNa9NmVf2sllW8amTdfn6F9IAuf+Hotb8nCnE3oq4M7K7tJ9e8VDR5
         17DggFZoQpKVvEvR9QsDVc65LMAdRmOYwqTR34N3fBCnnAJbsfg7cq/bHdJ8480tkD7s
         D0qkB2rAgFTxyhZQgbZtbWXBCb+iFWd6H8eJQyajSM7ZfIKdvxvIjaLPT8WTypHXsamF
         BCjr7WhboiApDAgzA/w6uvyELT017T/xHTu9YexTcNwHm2eXCXzXP3cp2uWwZvJFD9+t
         /osFXTo3wxtbh7seBu642CF35N6xbP/oZOcZi1H9kUhNsPG2pLONnuZLEh6/RECN1NNf
         R9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        fh=YlAmmP8EcYDc6EQXcP0jgcZtyVv1/ycdWuBfkHu1ZWA=;
        b=iRLcE+D0wx+57vE7+hbhFcKsXEedJFdFE6jiCx7rvSLsLaFjFwutQ8oG+AaGbMapNz
         MLDivg3snixYMmvi2fu2nLEMXh3zOxMnNYrG26aelkPoVbzUbWvTTFtZvQZvLOfdymWr
         zhMVvK1mJjkW57rQSYv4RxcO1o2YsZAsiViwYAMwj9hcHE/BVH7QDsAXuRLF9NjnC0Q2
         PLrcuIr1F2GvUPVdhmWrsWVOUuCPV49PIqZVQdcWE+FZvO0QKu2n76mjlEZcXtYsCZ/s
         bFca0DXaDT6VjGP3g4g1SkfBAT3AUWo57GspamPCWqvJo2FQ2Lzc4iJn2aJWGrAQ6ewF
         q9AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778832790; x=1779437590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        b=P1usW8D6DVVsjF+Bzq/VQjg3qsR4oAR6lAinDy08ATFV3PSqJAM0QZYy5ivG7mg0vD
         l7br1jZNzxnSdU2h7sFQS2n2OMODzKHOdq0yLIoEIYmrA57RDWOs5B61V7yeiY1x26HI
         b7oP5ufuomQ1RP2D8xjAZazZqtNt/xIU44Uhlxl2cBgM5WqsnKuCwptG60Sv8DWfeEVJ
         b9wb/qEF3gjG+R+wiLEEycDSj0GPn7gqdMfrHF8g0qUXcrCiJ+MzuEmH2cQ4pAygngqe
         5qWKUmst9wtA7L1DANLA7yrLOrLCBNiZrH089U4QAN1wcaJyBd1H/Pv7OShB3iunszAs
         48zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778832790; x=1779437590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        b=ADg1PCzmoNTaRQSSf6g99izcMIlx7T0tWxKdPh1Dq6pcEZAhh3UBnugaVnhY3YAvBa
         RqThIm2e3tG2SnZNhLuxTotFwJcBy5ND3MksnAONTZP9U3kxwCDYk0lTh1T4Z/Ylz5kC
         smyW35dJ3SLtPh6C9DHvf8JNinr/jVJ2tmBLQM+2YTvf86u7OUbMlSUU6vsKw9+UByuf
         Z/zpS+lVtqYh1m34D0bfDeN9Nae0KFz2I5qn8SP5bVB20As4Jei5x7YwpHEbCzuM8U3F
         EfTTkVQfjrOA94paeoB+Nc0Q3+XQz0s6fjyxAkJVJwF1sJ2+uhwIMGDGDvCN031EO0Qa
         U2fg==
X-Forwarded-Encrypted: i=1; AFNElJ9GTkFOU2h8qCqvbUFuW0fQhsJCJDh8C3sLP0aNp6cJrASz60d7BxrROUh5z13FTvDz/SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDxEFxZIqVxFvI3hvJ0vP7QxOjPXWVwdgIbVdT8ZcDR3Jg0+l
	hFXVuJUq+ZSLHCXs/70T+RRNDDt3PgLuUzfqvmQnyTblzQ15d85BsNkH8Y9P42R8SpjoNwNNLeL
	II6+mIS3QokiRhxAdDU4jdyzrBslub2o=
X-Gm-Gg: Acq92OFCPhDT8LdsS/SEQp16Cv+9L5iJcFCkaC5gyYM5w/jaVlp5iEVz29B/aIDLhH7
	BmmdeVAJSxspoXM63Mtp2SBXnR5H7SY7yhx8ueHHHJIpidOEAhnTy9QXj1urFN86JYQLY+M4RAY
	L9UtzNQT5RlsaV37CaX78Zu24/u+bYYNxDooJLJiP6KLYkdxCOIUWEK3fVd0sjtp6TsgvtZlNmJ
	uOmNJci9X1kDhRSnS2TNKWb2T9BjLR8PwVRnemNWcMRXZt8Pq7g2bs2KS4Trn4TuFTmqKiJGovd
	6jyLdx37H3gFCuM8iHzbl8xOzDqQiA==
X-Received: by 2002:ac2:4845:0:b0:5aa:123d:b755 with SMTP id
 2adb3069b0e04-5aa123db7f4mr324589e87.28.1778832789745; Fri, 15 May 2026
 01:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515050437.104716-1-rollkingzzc@gmail.com> <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
In-Reply-To: <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 15 May 2026 16:12:56 +0800
X-Gm-Features: AVHnY4LR9n2-Ae_qI7oLykis3AKXqA3FEb14WmP1plDNUNwyVA_AWuBsLTL_fJE
Message-ID: <CAB7XQsEJDoZHUznSYE3v1DadVXGWP7J21rS4Q=BuMr_jV9tX_w@mail.gmail.com>
Subject: Re: [PATCH] net: skmsg: pin the delayed-work psock in sk_psock_backlog
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jiayuan Chen

Jiayuan Chen <jiayuan.chen@linux.dev> =E4=BA=8E2026=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
> Where is the 'last_old_ref_before_put' symbol from? I can't find it
> anywhere in the tree.
>
> If you are using LLMs to dig into races like this, please also have them
> produce a reproducer, e.g. patch mdelay() into
>
> the relevant windows to widen them, then trigger it from userspace.
>
>

Hi Jiayuan,

Thanks for checking this. You are right: last_old_ref_before_put is
not an in-tree kernel symbol. It was a temporary validation probe
label which recorded the old psock refcount immediately before the
backlog worker's final put, and it should not have appeared in the
commit message as if it were kernel output.

The in-tree path I was trying to describe is:

  sk_psock_backlog() starts at net/core/skmsg.c:670.
  get path: sk_psock_get(psock->sk), net/core/skmsg.c:692.
  put path: sk_psock_put(psock->sk, psock), net/core/skmsg.c:746.
  detach clears sk_user_data at net/core/skmsg.c:892.
  reattach publishes a replacement psock at net/core/skmsg.c:793.
  warning path: REFCOUNT_SUB_UAF at lib/refcount.c:28.

The trigger was based on the in-tree sockmap_redir BPF selftest
under tools/testing/selftests/bpf/prog_tests/.
The one-shot test used AF_UNIX SOCK_STREAM socket pairs, attached
the sk_skb verdict program to the input map, inserted one socket
into the input map and one destination socket into the sockmap at
key 0, then sent one byte through the input peer so the destination
psock backlog worker was queued.
For validation I used a temporary local instrumentation patch in
net/core/skmsg.c. It added a debugfs-controlled gate in
sk_psock_backlog() after the TX-enabled check and before the
existing sk_psock_get(psock->sk) call, plus counters and pr_info()
snapshots in sk_psock_backlog(), sk_psock_init() and
sk_psock_drop(). It also stored the pointer returned by
sk_psock_get(psock->sk) for logging. The worker still used the
existing get path and the existing sk_psock_put(psock->sk, psock)
exit path.
With the worker parked before sk_psock_get(psock->sk), the test
forked: the child deleted the destination sockmap entry, and the
parent retried BPF_NOEXIST update of the same key with the same
destination socket fd until reattach succeeded.
After the delete completed, the test released the old worker. At
that point sk->sk_user_data referred to the replacement psock, while
the delayed work still belonged to the old psock. The recorded state
before the warning had the sk_user_data psock and the psock returned
by sk_psock_get(psock->sk) equal to each other, but different from
the delayed-work container. The instrumentation was only used to make
that interleaving deterministic and observable. The warning below is
the kernel's normal refcount warning path.

The native kernel report from that run was:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xbf/0xf0
  Workqueue: events sk_psock_backlog
  RIP: 0010:refcount_warn_saturate+0xbf/0xf0
  Call trace:
    sk_psock_backlog() (net/core/skmsg.c:670)
    process_one_work() (kernel/workqueue.c:3200)

So the reproducer is instrumentation-assisted, not an
unmodified upstream selftest. The instrumentation can widen the
race window and record the participating psock pointers, but it
does not publish a replacement psock, clear sk->sk_user_data, or
add an extra put on the old psock. The final warning is reached
through the existing sk_psock_put(psock->sk, psock) path after
the test has forced delete-plus-reattach to happen before the
parked worker resumes.

I will send v2 as a new thread after the netdev 24-hour
interval, with the lab probe label removed from the commit text.
If useful, I can also share the small instrumentation/selftest
diff separately to show the exact widened window.

Thanks,
Zhang Cen
