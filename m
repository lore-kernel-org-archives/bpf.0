Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED873655DB
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421131; cv=pass; b=hBQBrShIqx6uyMGnHBdQnABt4dAdX21273CfPz+fEvrZi3hLWRCLM+tchjadYi3ZUH65oUqO94Cns9Ehzy+hntKSx98GyUVLnzk8TghKDzBN/8miHUtyr7f04qhkb7gkbvf2LVVldXqa3fPc6pIY7LesRv29VQyn/TltYc3T03o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421131; c=relaxed/simple;
	bh=iPgtSJPnn2WLSAhBj9utiFu+5JnduVtlglZ5qvPeod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnQvt8wpH9aUTNahSKzjOLVu+5Z/HnHN8ST8U9zjrFr7QxFIxOIic+rUqegZdhjK8q+jOWJNOCDqAhmXfp1dqVOV9RBUr/Ju3N4JDOyc/HWDmd06QKimyzl4VdAeB336lg6lRpEcqGlfwx5+sZFQoUK7fxCUXrt/9a0nKb9G5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm4nah5x; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm4nah5x"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso27938485e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780421129; cv=none;
        d=google.com; s=arc-20240605;
        b=CapDRvkDS1DOnmCA2q15rxP8YAi7WafXB/XdP/xb960w3Xp8kbBJcKhhrRWRFfzf8i
         +aBAPqGpNMiARuZhNFS/bq4N1CyE/3917oyClNdKvKq9IQVkh/b5PMB0D0YUZoAONkHy
         SZUzwEUEHOxr6V6oT9pG+o4GZRuY+Zbo1UjGGTf7dOmbhn72Sh8WfOODTnOeLCV0GE46
         PxANQAouS8PU77MRk7UGsY2M63SF+8BG5AEsMuuUe3rg+//yqCJIfouS1sDrStDwLITf
         lGvkAM+qiOCOIbNU/Yuoxw5AkOIv+13DwH9QrwXRpTTbGMPraismB7z3a9gnIjaGxfdb
         PncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        fh=A+THm71yFhfbheGc1OlxUBCS4hxoHhZp8wE/qCKhRac=;
        b=Lw/8D5SOoj+CSd0qfjFsYX4CREra7ZdwXIYeTlq4pecSKKwhlu4pRaY8mhJZvXdRSV
         aOUacdZznGwbkpgp9oj2npKqNg+wDuDcKw+OoPRG4esKX7MsNG3YZ7feUsk0YSIxQbjG
         iUIgji3tBTwfCVoznWi5hwvS4VVZCobqIi1y+YLtselWsdVt2p+OrSVqZoWNYP0Nbsyp
         N/MNzeA1Z726Pg/C/RHr+IFT0K6sbop5wwE0/5ByKVXJaa/nJ7VLldbOBX+IRTB+uZMd
         /s2h5PmQU9sEk8SVRM+4r1sBFdz4tUoX/Oq35X/Bol/R+hSD+qQ81cbazSUIzlUd20b2
         c98g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780421129; x=1781025929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=Pm4nah5xpa3wkF6ZJXN93iQqTajfLaLnk17Wng584ZfLw6yW2f6VU85r0ZzVvoybuZ
         2dJD4fh1H+b7lHO7w6te7uv3VKo+4FCfqg5bT8+82qF6qrUCEf8Ti4RZ+CMcghcbLJL5
         BILyClz6yTr+8oG5EEWCO4J43ISN3WJv/FTqYT2ojC0rQCmTStcvzSasC8s9GY41NRAG
         KqcIPjXkAmUvmMn1FP0v+FjoatKbdQld4fpVRy9AoIKgUqdFLBStTJXcEYU9wQtRK7sw
         bKztzsF7zm8dy2R9DOg0a8bDQDg2INgwRUiv5rB8zU/F0fXu2zoEL5H5WBcYOgZ05ylf
         HWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421129; x=1781025929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=QKw463JRxO+7Pv4UyBMjim6QrAOyJGNq0K8o9soCLrOhDqrppY5W+Gq2u7z4xAeJWB
         WrGR6sLRCE2JFJhoxY9/u6zRyBQdLzF4MJ/2UvXXD1DJ8ZLz97ou1ob39rVj7Dq4MCtN
         teSKoz04E0eu/OdDxcLzIpZ3sgE+1H6JiokvLHoAB1Hp7QD4Ca1IgT6+jGe0xtRr7vPa
         q+Pon8yF5MnqA3vhuAGttUWORKA7zuX2JeEZ/FhFEenj6/Au86bQ1Y0SrHM6/5jpQbes
         7e6DSEDhkUB71OVtiIArz60YGz7Y4vjoT0du9SOppSDXq6G9c+x5/vU4v+qZvr3FpZRF
         0vTw==
X-Forwarded-Encrypted: i=1; AFNElJ88g0SC8rjq5bdqjfIoCTH4mlv8AHMII40LR88aHOzpIoqxukeK3RJPTCaR+Bu0zcjPnso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VFIWjovUW8rv0OBjObPJgdksJ/sQzPLuzuE6oeMlb1ijbYmo
	3HVUeYYT1jXN3wgIThl3dWmv0i1vVvOjTVeFmchWrJYVtJjAhDl8gViCko74lif9E7OkE63qSJW
	7DnUpQCNs+CyDxtBt3VACUN+LHed1hF0=
X-Gm-Gg: Acq92OEQLHn+bKTMyStwthDfTGJsel9DCB4D3RcCoZbcsTpAKoRl/9SqMpFrIpK1JH1
	G2FoWMhRfpfcDzkaScc/9bf2KV/S9ciC3UFbcyBkv5AJSs08D4UascwyZmclAy1sez1sSBU29sG
	kZqr3meA59uZJJPPVsrwrNrsq48sdApJzSC8GhKaoeekAX0roQ3CubucWHXocY9Mc9rtITBIKZX
	GZdvDv36bhlyHbk9XLldVVA8ry9bZ+rizx37uP+u9BO4Hxuvp8RM2ismlEq80IbdW4KF0XZd3Ac
	08fnod06KKC6F1D3E8g=
X-Received: by 2002:a05:600c:5394:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490b50b524cmr11269395e9.24.1780421128348; Tue, 02 Jun 2026
 10:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601180400.1381736-1-jt26wzz@gmail.com> <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a> <ah6dLESn8tHAtxS9@u94a>
In-Reply-To: <ah6dLESn8tHAtxS9@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 3 Jun 2026 01:25:15 +0800
X-Gm-Features: AVHnY4Jp20ELFLjNCl5evWNbTrIsnG4ugFKakTtRdkdRYG8va887rnwbiwM2mx4
Message-ID: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, tamird@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shung-Hsi,

Thanks, that makes sense.

I was mixing up two different things here: the BPF docs say not to add
"Cc: stable@vger.kernel.org" to the patch description as a stable tag, and
instead ask BPF maintainers to queue stable fixes. Cc'ing stable@ in the
email headers for awareness is separate. Thanks for pointing this out.

Thanks also for pointing out the 6.6.y requirement. I'll make sure v2 takes
the stable ordering requirement into account before targeting 6.1.y.

I ran the suggested checks with the same reproducer, where BAD means the
program ran and observed the unexpected error, and GOOD means no error was
observed:

- latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
- bpf-next at b93c55b4932d: GOOD
- bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD

So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
does not explain why bpf-next passes. I'll do more narrowing and update the
candidate backport set accordingly.

I'm also happy to add a BPF selftest for this. I plan to send a v2 series
later this week.

BR,
Zhenzhong

Shung-Hsi Yu <shung-hsi.yu@suse.com>=E4=BA=8E2026=E5=B9=B46=E6=9C=882=E6=97=
=A5 =E5=91=A8=E4=BA=8C17:18=E5=86=99=E9=81=93=EF=BC=9A


On Tue, Jun 2, 2026 at 5:18=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> > ...
> > > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > > Hi BPF maintainers,
> > > >
> > > > This RFC backports two BPF verifier scalar range-tracking fixes to =
6.1.y.
> > > > The series is intended to fix a verifier state-pruning issue where =
an
> > > > impossible scalar path can be kept while the real success path is p=
runed.
> > > >
> > > > This is a verifier scalar range-tracking issue, not a helper-specif=
ic
> > > > issue.
> > > > The visible failure is that the verifier can prune the real success
> > > > continuation, which should not be skipped, and keep only an impossi=
ble one.
> > > ...
> > >
> > > This sounds somewhat similar to the issue fixed in "backport of itera=
tor
> > > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you =
try
> > > to test on the latest stable 6.6.y as well at see if you can reproduc=
e
> > > the issue there?
> > ...
> >
> > My mistake, the reproducer you had doesn't use iterator or callback, so
> > probably not fixed in stable 6.6. I'll take a better look at this later
> > this week.
>
> Two more ideas beside testing on latest stable 6.6.
>
> 1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
>    make the verifier tracks the "not equal" for regs' reverted? My
>    concern is that it is possible that commit d028f87517d6 does not
>    address the root cause of incorrect state pruning here.
>
>    If the reproducer _fails_ to reproduce the issue even with commit
>    d028f87517d6 reverted, then it is possible that the root cause was
>    fixed by another commit further down the line.
>
> 2. Have you consider adding your reproducer into BPF selftests? Would be
>    very useful to have in stable (though it needs to first land in
>    bpf-next first).
>
> > > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmai=
l.com/
> > > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules=
.html
