Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831AE23817E
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176811; cv=pass; b=p89zGGi74GfYHnoTJ33wSs9TCPhMbO4Ou6Edca+vla70TAUL0Yss1Rr1MD2HDW4jumI9W5BXp0ZBuWUhs7LrBQ0ZWc2VPesHVnORCDaMz1dSa9NrtylMge5KZbMiXSswr9K2/9r+1Gl6cH59CMS34oNzAKfsSeZHw+10IZTQCC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176811; c=relaxed/simple;
	bh=/w84oLty8p/81Rk4iB+DZc9tnQiU/i2ZF6s8sFFaK9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkEQExR8ogpGfK2LwmxmZd9u4F6iXh7BnYihe3OD570rH7Unah/IAqeQd73+g/0kyfXSKHSYGJ0uylEnOaR8xMQx+fE8mRbr5NZj3oz26A0gfB1VjWYC2QouKA1w+Yq/TNzRi4cGFV+h/fOn7f2Vsp06pX7vvIogWi0SlunGsN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdkzfQuR; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdkzfQuR"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9694so1027215c88.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 17:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775176810; cv=none;
        d=google.com; s=arc-20240605;
        b=ZyyFWJ+sQnT2Zf8CJqw24A58cA55D8aeSeYH0f4S2+RCx665bGufLWtH4bS6SrtVzc
         bHiQsvH8oiNtMei9hAjuyxVXIEGwsrmdsp1sJvKUufDitGcJ6UyHUeU7bHHF6xc+LR+h
         MLhQ1D+x4x8vbhuFKGGvcsXH1ksMULivPWJvKlCDlzqHFLT5xPvmHqITgPUqk21rnSZK
         ixx3KmNfEQ4Rh50nurB2AhGQR8VjvJT+3MzLNky2w/C65bedbMHfDuwfu5yLvI37c2o+
         EwqeRNE+dCKgj/wxKK6GTMyrSSUBRsVX+lVFsn5v4k90DcCvya4meUe/Nv+6YepVbCur
         z42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCdQQQIIvXE2+KXarP0M3agadIYQMXhGCfuVI+81ShM=;
        fh=Mli8ByWCj/2UIxSVVUaBmMqxdDk+ZT/Y66Z9oU87Tj0=;
        b=ZyzwvAeArK026G1lAwO0wt57uDdagKgO6ws/MA4h6u7glRAZkXWljCs5Bp5J1ygkc0
         ZXd2fa1DPnClfb8EhuscmwUFTCBr4qzWeLee10fke02WbN5Ed9G8RNLjL1vfVjw6H9li
         1F8k2V4KMT0h95NLI0v6cQLVTU0J5w2mWIKogqqEoC8zt5fPmWvBocCVb6MZ0w8NRLd5
         +oFvcLie7BWlLOQrw+GhMGjBCYQu+kM1j6oWDdR0Z/SR+QUcvKQstWZeBit7dS96ILfY
         bIdlamj/jb3B8oQvnSslXmZ1F/peB36QAsqBAvo+NPsu3x5J132a5z2BibYYyjuYEXWq
         JInw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775176810; x=1775781610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCdQQQIIvXE2+KXarP0M3agadIYQMXhGCfuVI+81ShM=;
        b=OdkzfQuReDCRCrrh0/4DqmM1BE7fYV+vZWoiNxFNnJtemy3sGC3serdtp/ZZvubifZ
         9JcMTTCWUa9ZK9xpuVHmNI+isspj1T0rFo3eVLlJCb2teCcYrbYDG69R+MxUWjK0xJjO
         dzux9iuSGPCUrDrFoL9UDq/OxzD6agGwbbkvqfhhxr2X2XmlDOpPmlDHWc/CvO/qa4qN
         mdYlLc/5ZNepa3oPicHkwdZH1b7x/Pv+/JfAKmMQUckM0Dt6ZoBQUuSGw2qSVlH1M7CU
         kbuu40SFu9zESVtvvfNd/3GHIQs+xDgB7mkcGKtXsYI5zvugRTQAbkk5yEFtu6dtmgfm
         8rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176810; x=1775781610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCdQQQIIvXE2+KXarP0M3agadIYQMXhGCfuVI+81ShM=;
        b=QYBCrxiaRDkqNs9PRKOtWZ8mMY3pT/27W0zN3oOKGGkVrwcui+3WHuFBqiIdD7iBnq
         zFcQuloiIpb7xV0QqH/NsgXZel5XcbzxYKuZDwGWdoDMSK0BXigg/7r9RLXazN0mXC19
         RSgf1DkExuPgXrDi+7bHdx+n+aIHQMg6jsDm3FD3KXZh2adLX+rVNqskSMS/NptfMChH
         83R8FQUA0KVNNu5NUeHe0tMIjZ13ss5lz+TQydz4winDX2E/qVtFFWgHlkFIp1DQEJxU
         MitAPmmOnd4apEUEP9tQCLXYOv54J6J8B9qLXpy9yQ3bC4KFQjucX1njWAI4rugsChjH
         XALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJstGK3XvHQ0YuKNPhjU4iG5zmUBGrpHaL0vOr0ijHCJBLGcZ9HbliUBiy/UDShb+tSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeloPjmWjB/k82zFMbNP6CEZ6IUVP9hZlMu++0L3MNfDYVgkw
	PcQGWpRF6Wj7egCBbUzWirGWdSSq4J3ryWl3mldPUXg2CHJo7eqXioLjBleve6cNgmjVBxMygWk
	5eNbaM7ynZ2iGUoSXhGYBi21yyTgW/m6X2qnY4cAQ
X-Gm-Gg: ATEYQzzcqbQXKarA4XyrNJfjph6bFOZ7J+Kg+pgKvv0hHAJCT6PIOri19bDKMXvpA5W
	02j1ZqnKPh3kTC3RQXqbnGjcsYLNGF33NvDSqTQGocwsuKRnr1FwCZEkVaSx9waKJ8YEtQHZIWO
	iEv8bcekBLaD+Ivpd/qjTjsq9r6QhW2kTP7Cs3ckQs/h0aBFf1Y6X8btVi3QODtaW/bnPS1GmJl
	WtZJgtHAdUcZgeQXIwtbXA0vjw28Blwd/hUnIh3EYMwEj7s6Q7eiaF0ijt8GkCD8zkDfEDhJIv3
	xBxq5zZblSmxlclDrPkjadnGjPmHcaz84y9w/20srnr64PL2pTEzd1t8bY5Fq1g/lfZg3ygnGw=
	=
X-Received: by 2002:a05:7022:41a3:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12bfb6fb088mr617815c88.10.1775176809005; Thu, 02 Apr 2026
 17:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402203754.280844-1-kuniyu@google.com>
In-Reply-To: <20260402203754.280844-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 17:39:58 -0700
X-Gm-Features: AQROBzCUbsqUMZVlPVwHX7XDocpK0nqdiJrfFLJB7S6UDmzKjAMAMqFW1nMKfmc
Message-ID: <CAAVpQUBMhqMFN93dhphgXVsgn-6TmFqKmJ4hWNiCjLS_D3JHCw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Wang Yufen <wangyufen@huawei.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> syzbot reported a splat in sock_map_destroy() [0], where psock was
> NULL even though sk->sk_prot still pointed to tcp_bpf_prots[][].
>
> The root cause is a lack of synchronisation.
>
> Even if sk_psock_get() fails to bump psock->refcnt, it does not
> guarantee that sk_psock_drop() has finished, and thus sk->sk_prot
> might not have been restored to the original one.
>
> Commit 4b4647add7d3 ("sock_map: avoid race between sock_map_close
> and sk_psock_put") attempted to address this, but it was insufficient
> for two reasons.
>
> It did not cover sock_map_unhash() and sock_map_destroy(), and
> it missed the corner case where sk_psock() is NULL.
>
> On non-x86 platforms, sk_psock_restore_proto(sk, psock) and
> rcu_assign_sk_user_data(sk, NULL) can be reordered because there
> is no address dependency between sk->sk_prot and sk->sk_user_data.
>
> sk_psock_get() returning NULL implies nothing about sk->sk_prot,
> and we need a synchronisation.
>
> The possible options would be:
>
>   1) Put smp_wmb() and smp_rmb() properly
>   2) Put sk_callback_lock locking dance in the unlikely case
>   3) Retry sk_psock_get() in the unlikely case
>
> 1) sounds straightforward but at the expense of the normal
> path for the super unlikely race.  The stack trace shows how badly
> the path was excercised, see inet_release() calls tcp_close(),
> not sock_map_close() yet, but finally reaching sock_map_destroy().
>
> 3) could be lightweight but risk an unbounded loop in case the
> psock could hit WARN_ON_ONCE() below, so 2) seems preferable.

Oh well, Sashiko pointed out 2) is still racy.
https://sashiko.dev/#/patchset/20260402203754.280844-1-kuniyu%40google.com

pw-bot: cr
