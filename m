Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79291F4CA9
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830670; cv=pass; b=tKlRg6pMQquLfmndGdzSE28BwuD4aMsRco1aZkY7oDyyTeX9DEyoHbS1jT1pLhKaFiit6s8YMBjyu40aUHr0XhHgjqyVzSwsObw2KhhvUGqo9ZFusx/fEMK35GpC/oPO0KxuMgZgPyNO+6/eMtjabwT2SILoHNfg9pSDI1wG4tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830670; c=relaxed/simple;
	bh=HNT7r1+w4vEgE3lTcdmxLKz/yt4Vcq1i3k7B3LnDcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFB4uoR3ad2lYiZGC9oMPh9LRPDDsSHQGLbKBQdHRrOPfliGfrHQpmh70bIQ0PiZgFKflcRMtKETZpaIwvI/nM26pj5UFkYK5E/8Z7/GitALgbO3+sSKB85VP6iOTAJ6PgpVwtRnm/hg/ys+q7lEYwpbdMuBQUeHLbQ+qVr0qNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9IQqnIJ; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9IQqnIJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c868b197eso5563164a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 09:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770830668; cv=none;
        d=google.com; s=arc-20240605;
        b=bHSbxwt/8QDml6FGF1XMopzsbJ9Qe/RSp3mDeETH3JqjUS9+lXeewjJ6UkO2LZd9yo
         tobbD4Wr+eCHZHvaCwKseGYrNRQc69NvBZcPoHFpIxnMYCZx2JiiibhOqx3iE7/V2gjF
         4Sv0BWevrM/f0ncEwAimg/1Wz9mzhh6xTQHMXx7UVJ3lIBtxB/HqmjbFMJEkpy1Wq8O3
         FWTi/etsOstspGQgdsRwtjqwXMb3YAGlcbg5MS8+2sKQmi9xfAuKjK9mgfC0wvzPxU9h
         0Jh+Mfv98vma6ltD5fSDh3kBx1IPalmcjj4m3eQhQwq8FWwseItSdzYFZc3t8ygEtpPO
         Wzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        fh=zTZ6Dn0q5hIdo88ilw7w+fgZW0OkABSCYZVYsVjMqG0=;
        b=a6DTXXuDIsWwFCSFysWdwDukQ08wMFoTh/tx63fHGlGrZnzG4ymb5cm8z7iDZrXcrU
         6U4qpcqk6J9eJyTpMlA0RU19UfdXaohLxHdz2kNpkuqkEPxZyC912njeO8/gLV+jAlkx
         6w1Mv5avQproph7lREam0nD4g/HWAr/DFwuNFsnLCb2xIh8E2hHtSeHeqbLAQ72Or+3A
         C0MWWTBCCuFODh/fCZWneIb2GQWCDb88lk/mLFjb9C+TMcMuah9ejeVeW8zUnC3umCWO
         /AtRbpmMzzsfaXhOGo18x/J4897vKYNEedhR9vvCcgQ5EZrthhazNVtgshVS/mpaocZG
         AWfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770830668; x=1771435468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        b=P9IQqnIJPdXrixT3QE92yW9wRn70N4h+ikEurPKnhUBZfDTlimJNBz2YPYQakS8WQO
         kzlQT1dT4/yxcjmDG+4C6rp2oOABImv17FQmWWWqjG7+dUkvLJoAG9RCrG6zypGSOJJY
         JOBMppUX52Bbyy0BLRA/qHXPiMr7k0vvr6BZo+cg7JhE7jIjjCAJntaR9KS+9PUd+qWd
         VT0AO5cRcBWIkM+9NmD1kQDO8qga3Qtf6fzZB89XtA/JA7SOfxzKz41uaJzmafGree13
         rDRq+87vyYDqhMrpF2NfeRLdJR2LnHtUnCq89YrA/8k8JE6azsB1ol3O51q/SgBn8Uaa
         7Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770830668; x=1771435468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        b=SSAh1vIg/NHrKbQPTocgjZHs0VvgEeHnn3Pyc87Zp3QNoMExH84jBTC6Jg331m6NHf
         PzSaOLo6SLXTM+6k/FWQaOJ9SBU3q4cyWYKVecSyccZ0DByIKNKNGoHTkP1uwJPw8fjX
         zf1qcfrT3y65bG9n1+sBt7Rrn3PfEuYqJX9aMViRlrjmtBHzetRZ23+TR8VuoxUfYBV+
         7eFe5TzkvxbAsgduHQmzahaQs9CsIKEv5KeP2QUknW4X2T1350EiSh9RS7AtMDyuGHI9
         LAd2rZSjQ8WBjKPXdWRDyn+xSFrod7KtLSJd2vfNPL9j+XlLEEtY0mZy6wE5VqVx2fky
         7nBA==
X-Forwarded-Encrypted: i=1; AJvYcCW37VeRC4Ch6nA/S6nCioDDfP2z4ncK/vewN7bSkYY0U5IND0OxN/JMWEGEvxyDx74H2+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qJ3La/tuPw1Au5kJ0MYKWXW0TXp12KtaEMzK8Rctp74ZTg/3
	MutPg7DGHccsxLSJ0vSqDhLiborv6QMCmiXCdRKZ4HPnAkuXdTQ5WWIrzjUB/0iiBiyLrzCp+X2
	gAN6pohFYlIAyLRheGSmkf9uwqf6ZG7Q=
X-Gm-Gg: AZuq6aI3Z9DW6fuoASci1NYSwfzAfSiLM+CYcOisAgeEVmyVy5rsK9LXbjfwQ8CB4UD
	Ko8++Nz15ATk/4Pjxc/Abjl7Sb+gCuakbVCJ5EGYCSc3gIBSihgnpHtPN69Sxr2uXznWb5e23BO
	6xbBRJu0p2vfaAxznUpUP2Xmn1oHlpyPvfufP0hIG5c5oBKUB5fQ7nTJGjyLSgVcNGXv+nQ2kUw
	b/2i+I4bgZj0BDXhlPcn0/Ly4oLgEqcgqlDhzI3dpyY0vidkSfPqRJLjADz07fhXDAsNdbgPB23
	ze7L58hUFN5hZwY8465slRtbfatSFMp9WA==
X-Received: by 2002:a17:90b:2d8c:b0:354:a05d:9dc2 with SMTP id
 98e67ed59e1d1-3568f300d31mr166515a91.9.1770830668125; Wed, 11 Feb 2026
 09:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <87qzqsa1br.ffs@tglx>
 <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
 <87ikc49unc.ffs@tglx> <20260211115825.MLF4L4Jq@linutronix.de>
In-Reply-To: <20260211115825.MLF4L4Jq@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 09:24:15 -0800
X-Gm-Features: AZwV_QgFyUjXcS1gGGgxoc2k8MO_QzouXEXMD7Ys2j6dTV10vd1FV26Sc5dH1cA
Message-ID: <CAEf4BzZ__PYqiYEBxJQhAaV8fyNYSmDB5rKDGsvmpXG-Vu4eMQ@mail.gmail.com>
Subject: Re: [PATCH] procfs: Prevent double mmput() in do_procmap_query()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:58=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-10 22:05:27 [+0100], Thomas Gleixner wrote:
> > A recent fix moved the build ID evaluation past the mmput() of the succ=
ess
> > path but kept the error goto unchanged, which ends up in doing another
> > quert_vma_teardown() and another mmput().
> >
> > Change the goto so it jumps past the mmput() and only puts the file and
> > the buffer.
> >
> > Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA=
 lock")
> > Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > Closes: https://lore.kernel.org/698aaf3c.050a0220.3b3015.0088.GAE@googl=
e.com/T/#u
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>

We raced with Thomas sending the same fix, I see that my patch was
staged by Andrew already in [0], just FYI

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patches/procfs-fix-possible-double-mmput-in-do_procmap_query.patch

> Sebastian
