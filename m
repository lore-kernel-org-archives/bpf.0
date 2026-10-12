Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9F3ACA5C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802126; cv=pass; b=EbNZB0kBSy6Cs4QmcXv6iE63wpurhzKKUI8pYZUmi1sxItL/EahqHSmXppzEQXvwEKxD2TjR8FL8kNH2N/Q5nEfnSLwmfR28Y0psiHGkRAGM9kw4lISd/T83rMXyaSgoJ2yfXKEihdJw2Zt5wTxTTlFYaVZpdHqcK45eHv7/MwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802126; c=relaxed/simple;
	bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTCJW79yQSonv++/NsYflZbs9MBZXDOvI9EkL/NhMMSropqtjCXxCqcV8ODT0cH2I6qPIb4tMFcjU9rUavLhrT6n6Bb8Bgor4haZznrUbUhLB+9BAEcX5eam+wdEXrBWKQLMPonmVx4Ml0YbULpVvIDTCJKSguX16Onghdkzd+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvBFtxeK; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvBFtxeK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c262f1186f0so226875266b.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 03:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791802124; cv=none;
        d=google.com; s=arc-20260327;
        b=cZFFA39gvB8TXlrJotE7pB80e4F/xJ0IsYt3ULZOXE+7wLOupBTboU+k7pcmP3B21H
         4YMmwwcLLL0CVp2x/ib+7dAVS7X5sOcheMnBUF+51XID8Hpn6uxOBfzJX3Sz0eHH0SNg
         glRB/VaLiR/KvknfkvqAfGohWoQEWM7EVULlqnvykFwM0x968CRy7gMmh6NRd0yOFEDf
         jYJpkXHMwpnFc0xkTYz9xfIWQZNTGtP7gEwhXxm5V0nNULbOnI9su8T5f7pHML2IV1HS
         WK6ze1uZ8ds3VoeH2kBn0nJ1CRZQIIQSTleWKOEkUw110NfVgkhLNDfRYBrnSKzcoMuJ
         pAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        fh=I+4cCTQ87hSbrhAkL0dgSloxPIK6E7o+Pua4iFGYjy8=;
        b=bS63dA9J6sThs4f4UZJ4JnC13kk4xHqZiQztLohbV/HQTNFAVUkR4E0YWtgGHTwwvK
         5BpeTAySgTc50lWeMvBF4WvjqHSE50ctuFILtOSysziOVPDaDm5B9K5DJh6PxWjuWqdf
         lw+ZVkZlrxxanLxOMk1SUt4v+WiWenF5KeG6O68Kp48UZ7kvWcDitygqvMGlymh0niWm
         qfdRb7c9gMb1l2TtNOo8HIswaRiwOFwzFafRDRv2O+LkicVTRPEvpdKWK473b1qrsgS5
         8vfGQIoas2dJHqk3r1Hrl3mu0YrRFBXgM48mPQYk0ICz6kCOElnqbZG9dhYdReh+oc1z
         B8qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802124; x=1792406924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=MvBFtxeKDOS0EdVSG2Bp43g81Bi6onlFsI6m7PX2arlBI/Lf9WVTJGY55yT1SPwWG7
         VQ9mZ5HJ4UgNpK7bxJWf1x7s9S6wA/KvlBGmonjzZE0fJ+jry407rP27T3xYbvwCsOHP
         o3yNZ5XMViZQnksQUsNwVOMznDRU3qDUgMNTsvA8OSeSDB5+CRVFIT8V/zvlKtDuOsgI
         DtS+tr21PELCB22XorPSM34sJzvuUotH2ZB9R/AZYEJJ/y0x5xbrznN4VjKuurYOf84t
         bpPbol/Ss626BRA2J7WIvbpHqdUwbZO9UUCyWC2xj80XpNtCofoQTI/9WOknG9ytT9xL
         88zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802124; x=1792406924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=Ev0WRRw8VX5zDnai10Du020tciBEsF0tsiNyCn7xj3psCGvemeXRmfDm3iXQB79czu
         0YN/peTeR1Fg7/WlxmehHlfkWzhBFEo+ZaO4NH4rCLlCVWHVtD6LvSeLWGYINevGf1al
         369NepmwGS3zLCXbJDXHIKQXC1kzuMy2oa+hBO0VzIvmU3z7dNA9KwxV+2eOnCkygnWL
         0qNDLFQdOlQpe3W+nENRLmhaLeNWVcIxZ7+6mY2DtnYCZCMjmvzm/HCSRTNmHzKEYWH3
         06zdPhkyrWJX8xrz5sHIksxGQXcbZ6akleIor+Mis1jHb1CoBbSte4nKaPuT5Qm8WNHv
         66xQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8SwXvfPvhXCHoWA/71a1845ApoCc4fjVAE8dvzGhIrpqG/uRcF+gdyw/cRQcds4l1lz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTLiivrRmarxEMOfx0EPkq0ctUnFT3d6U87BJocNBSMGspUtal
	2uKRUhwW5bI8kFRHD0ggeZB/WGw+xW7Eo40Paw25J4NmW1RsXHCt2wfGsh2ukZt1jcV9vJ0Lh6s
	D7Pu3g6WQhjPz/dWi4ObrWA+11uAvJck=
X-Gm-Gg: AYBFou1ms/83/1L4pKiYq7OqOBU8hVUWTFG93FiwXjqzl9zzuKBKLf9yyJpYi3fflj7
	EQQoWVJuzMFlO/qOUFK4CA2J98L4fGXIPKEIGbTKMKx+vT84N9T7fwAUOZc3ejn7Z785SzIMW6z
	Q+5U3C9K779gda/zpKwp9cnv4V5TOfe4PTcrmSbYHyclRAkGwTg4AB1uGgG+hxQQxbdWna+7SWZ
	R6rAOalc9cO8N9QhXeL1V96lVDGMmPmTgYcq3yh3Hj65WrQawcEiNKUkoeQqazsJJwSR/6+3Kpq
	UDSd0CXx3JdAa1dAimOnzIQ5kofW4trBkM9lkFxUwl+ZXog4mpjLj+q85/LmulLoMl0=
X-Received: by 2002:a17:907:97d6:b0:c2e:2944:d6c7 with SMTP id
 a640c23a62f3a-c31aa036549mr927162766b.29.1791802123504; Mon, 12 Oct 2026
 03:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
 <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
 <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com> <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
In-Reply-To: <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 12:48:30 +0200
X-Gm-Features: AclHuK9M9jsbz9zheu8tLl_AdY6hC66_jaZlchTl42QorNNsWlRmIkLJwfQ6nNk
Message-ID: <CAOQ4uxgXLcV3tmFp-gfF4Fm8ivvqGJzZXf3hmSeqo5dkzPv-=Q@mail.gmail.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Isn't the inotify problem described in the commit message already solve=
d by
> > 669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once =
when
> > inode is dead=E2=80=9D) on vfs-7.4.misc?
>
> Indeed, I forgot this patch existed. Good, then we can drop this.

Alas, not quite.

Kyle Zeng was able to provide a reproducer for the race off-list,
which is not solved by 669bb5af15d41.

He provided a tested fix patch following the same idea as I mentioned with
FSNOTIFY_CONN_FLAG_OBJ_DEAD, which he called
FSNOTIFY_CONN_FLAG_DESTROYING.
I provided RVB for his patch and I think we should go with it.

Regarding 669bb5af15d41 in your tree. I think it needs a new revision.
I will send it with explanations on the email thread that lead up to
669bb5af15d41 [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxj4sYikVUEhV1pdUdzoq2U4pBa6=
RheZa7a0WanBmXkEow@mail.gmail.com/
