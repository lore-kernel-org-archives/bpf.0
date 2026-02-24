Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4F23EAAF
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897802; cv=pass; b=tcd4+lFrEP4tRxvIU01goaHrdaTUqCT37EGMCg+F+Ht9JegG2zikfIs7lGdgPV1B4fj5s1DA4RpQIfSdqIfsct/mo1+yQMtJLyHZDpEQZvuV4+V516/0vWH+NUzlOZe8TkJMUuuJ4cSUF77PN8lPIlYoBvzyRFWvmkeQkm3Kt1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897802; c=relaxed/simple;
	bh=8zn8LaipGM9efhpYJ3qQN1XJ4O9q3w47hUmwPQaY5KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iigjZTzsjHLCKwnOCH4RiFcYf6rDfqMjbS/+VYuAGx1hzOHH8Tspw2ryXhxRDnDXUDXQCsRItQbLvzDjq2XGnRX6aS+TmLm1tFnHR/kpT+tdVuu/C8kcCge2UQOfWV9lNr7k4dTTQiAxaOA/sA5aGZArVk4+SsE6dXATM4wFtX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1l9x5vr; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1l9x5vr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483abed83b6so16596685e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771897799; cv=none;
        d=google.com; s=arc-20240605;
        b=k+5a/MAQLy749O62fEkRRmEaeRWehUtIO1cpTt/w3yiQvErK3JIvSTikIcCxS4pfYf
         quVVy8yOdJss9ls5D+1fExIAl+mWz3gLc45hrznR0UOsq1yv5b1JCQiiKEP28/mX9C2T
         FD7YWsS1pjQ5NgV8cmkX2C7yhljiZqDrtNia66uEqbU4A9AG9PZluFnnfngUeBDd7co+
         HaDyePuICaXU2S6m0euatWR65Yl3EU04qAOODD4IMbQ5qOvCYPCjojVj2F5E86/SMspH
         +2KDH2JoK3NArawHrBsMgxNP5ijnG1O/qbHoEC0aNuahq74S+rRTC/2e6C9KEzpdwdi3
         X/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zn8LaipGM9efhpYJ3qQN1XJ4O9q3w47hUmwPQaY5KM=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=JLXa8cPzfjIpHdkrqXXWeavuTgThAJNd/8Lm2KHla5HH+3lljzYxkDn2kwYRbaSG2a
         wJ+0oxt4IuLL4vGEbAGtGED2egjrpTrx3G2VGhx0Cu1kE3PNZWwCxr5CAYuHtSfW6Lqb
         R32T4oA0tEhoGTS6d/56dYkdDASZi+1WzMnqn8O7J/j2r3lsFMNervUyUP2bWTcdlSwc
         7BS1mJQjuc5u+2c9uZQyHgjsauoG4O1nv6ezdVOomKkfm9V4cHEEUDtolnRSGEVmjLNx
         ib4cHazTVwk32nzWtG3/tr1hZiH2uZ9hbFCIOndxbEXNo6ikePIXTElA+65v3Tos6zKv
         c6gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897799; x=1772502599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zn8LaipGM9efhpYJ3qQN1XJ4O9q3w47hUmwPQaY5KM=;
        b=S1l9x5vrGyFUM+aQXKUA/GwBMldhwoITtNxuhOLLOBteq+BufcTNQRUVOd61IuqzKA
         /g/b9lm837QEZWzlDJBcLrJlEf1iNFo9Rb7sf2swGSft3867SU6EpL5AchKDRuHarEJR
         jyKmEmbJC2yY2vIxC3udRWLuvvNS07nbEQWsBnQTuhPxfGnWDptPEbFjV5xQS6LxYdca
         5AD+G+WW4WYvFfYxJOk688Hy4AxxNMEo3eu4JNdc/WAjppi2yOS9/CdswcnWjPKKgMuz
         ZpAPPbUCgwtIVLvJonjzVrUm7V8mdVs5tzR/BeQOgY1aSGXuxGXJRdDX3evqCtRTdvSo
         QWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897799; x=1772502599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zn8LaipGM9efhpYJ3qQN1XJ4O9q3w47hUmwPQaY5KM=;
        b=GSJ2FTnMMu9tVuLBC4FblQWCc5hzdFRVamSTQ/DVMcT+OfN5y4dEaxvNoTtZXzzvu6
         Kx6TXHAgMX++k5+VmE1ofyHWNtEbXWnHeo9jasTcWtUrrzjUbClpKymLljmfydEgKKY8
         u/2t637Pl5w6ztoRbvKC8By0qaEqdCXWfNgofKInTqq+htif2gHt5vMm+GpVxxA+7j0w
         CEYGGABiUEwGAWSYWYYyBPtUvYMD5kypwangIEtJ/iocn2QooUUViVJgBRvOLlppQ8MH
         mBSwN5MFAsf5lK8xUjEs3sZKhm05bpIZRTMtCx9sPpHhjDZHh2Yq9McwRx5LWbtqQtRj
         tg+w==
X-Gm-Message-State: AOJu0Yzq4TkZ9kYWPl7NgiFFH3tkZOTJAgA5UkCruHi8TBJvyAs3PL89
	btDqj0GERZgcIJJpGZH9fh8c+BdR+S2CpqBdW9clas9H0uUFY1ohRCXfN4EjPK7luumXrGJPccq
	SZ1g5E8VB7Va5Gu03e2bPgKszcmtHBbkanWIM
X-Gm-Gg: AZuq6aJOXP4+UCairfhE60ntQCw0t9h1u08KUpSIYx6USeqSchhJ7DlytkUzlrA3dcc
	kJy4qnaxMG54OCPDSOrFAMxMaVQpUUgzJVCbCj6hLxQ+LzBvn7iPEiDCwxYUV/72qP58XtY2XBU
	IStjfYFqfZpe76D2GtAMnn8UqxmdnYE6nVTtOz7G1m5AnvGQ8zcWjHbzEiYnDxtyNtZiiqHODt6
	xtHDtdHxL8fE8t+cLSACYiT0GbWwtX29ZnZo/waFlQvLYw5tvZ+O9W6jXYHPylaT2mgaH9LaeQa
	KqofctQARWgJZ2h/sucxrF2O/8KuxUKY1+/Hx6dFfrNyN6QcCoW3MKJJuj8V9y2VfBNl0o/Osxr
	GNsXi43bVyc9PwHnY4Bcw8DkliQ==
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id
 5b1f17b1804b1-483a95622f5mr180896455e9.0.1771897798960; Mon, 23 Feb 2026
 17:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org>
In-Reply-To: <20260223174659.2749964-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 17:49:47 -0800
X-Gm-Features: AaiRm50rwUFNhyO8Q6nr2AyuK9eINVaezdWRhh_fFphGXOTgHjdL9E8TFD4kJrE
Message-ID: <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> Iterator KF_ACQUIRE support is not useful on its own right now, but it
> becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next is
> annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holding this
> pointer forbids sleeping; calling _release invalidates the pointer and
> re-enables sleeping."
>

The name of the flag and semantics bothers me a bit.
How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_ACQUIRE.
And document it like:
KF_ACQUIRE -> acquires a resource via reference counting
KF_ACQUIRE_LOCK -> acquires a resource by locking it

and to match it I would do:
KF_RELEASE -> releases a resource by decrementing refcount
KF_RELEASE_LOCK -> releases a resource by unlocking it.

When lock is taken it's typically prohibited to sleep and do
other things. So I feel such flags would describe what's
going on underneath more accurately.

Thoughts?

btw do we need a selftest that 2nd task_iter cannot call iter_next()?
Like:
iter_new(it1);
iter_new(it2);
iter_next(it1);
iter_next(it2); // this one has nothing to do with sleeping
but once we think of iter_next as KF_ACQUIRE_LOCK
it becomes obvious that it's not ok to re-acquire the same lock.
