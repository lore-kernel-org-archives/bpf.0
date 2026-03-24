Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C3391E55
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374394; cv=pass; b=rbv8CRH+27aFwYeojkYHtiwAXbBOvms/Hs12UT3rk/ZgxuXMlePqZL10I8Y68xaoBNUUmP3PYnYSGqltZrnxuxaxrpdwpD/RAy9CaOvINxVUNWCqL7UCZrNByiAxWeHGdj8CMHFwyWYPHmq4GKmUr+nDXKE5BplJ8gs04KtGwVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374394; c=relaxed/simple;
	bh=VL99yIlObkm/F6ZQ2daFiddD6ZnfVPryNtS8kH6wlkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex1V/Q1PboO8MaZBZe4nI820XJiezxiEulom7LvuvznsGgQ3OWqotJm4tEz9ffs6INQmPJc7tuB1zKdC/b6JB0OvSEhALIgMoM2HLBYb+g//7QgLvgFZG+eRWYmUBGfvkKaBaXlJYF5z+KmsED2iekwVqk1Tq4+oSozX5WYv4B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEPi1/wp; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEPi1/wp"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94ec56c6f05so770106241.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 10:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774374392; cv=none;
        d=google.com; s=arc-20240605;
        b=WrJ7m7iarm0ptLCdCyTBY+pyX3Mbo+LSs30ZgrHdJOlOHXRFGL3IjTPWEFDg8DHiM8
         AX4Lt2/b4i6jLabiXgnil22+Bn8KG5+noRIdToI0WW49xRXCLze6rg9NvYr8EE/8FAQM
         PYinYBXt7HAyiMA8g5bCJYjRRj0M+T6xt9+V7Ph+vr/0PqjfcqNN5oFP6UI4de6X4Lus
         QbbyiHXdHtxhkbo85zLfEHE0XveTBXLpZljydL/4qq9M9BePFSgbRa+rIDc4IO4LEnJ9
         pxK1m0audHSPzH9DR0foCAQlX/Sp7L3ex+mXRb3ZBSWPOwnksyktyfUx976XJqIlcrUe
         ttxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=icuB+P4pLFsS5xV3yyRCAcHDDOVtvcJcGh9E5iVsFUw=;
        fh=zIkQOOwDFXID/x/r6+t8sK7B4eLtyasGaWfua2Z3NYk=;
        b=EHmswzCwRcllM15o+hjKs5ojLJjJu8duGgV155CACIU0V5r9Wmrbe5AeJzvQ0AAEpI
         1ipXxC4lxEqE0FSDDI9TAevocSGYeNE/feMOhkQFiNVumXrdi5GF0dx2RjG8/Ufw1Byi
         FFn2scg2FEtqF2g4/NUSdkJ/dgmWr5NvPW20KFYnYnXTdegEgVy2Bj8LeLqmBpRjhmTH
         K+3gf0bSr/v+ijYZJbALAj3v1KOz/w2bW4WSALfemPxhxsq7jNEKEz7Al8Cyaomn89Nc
         5aAon+OdbfAHm7C9oqHr9h/Bwmmhazd9a38omgLg14/slm91/w6Gjf5DfC2ujYkBxwKg
         9jyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774374392; x=1774979192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icuB+P4pLFsS5xV3yyRCAcHDDOVtvcJcGh9E5iVsFUw=;
        b=rEPi1/wpljBnuePZfe+niz2Z45QcduGBH+r4kuXQ76tfyEm48L81+woRIMIUQQrMUv
         znoPSJIrerv+3BtQ14gtyChHQvSF4E8TbAPBT7hpbwK6/AqFeBm4AF8eP+L7o+FOEzJx
         mFxvSvhE5y6ZfChzJsqA100Od5qq6J8BNwRSKKhI3mqvXgc1zELt3LcX5uyAbqLrwQws
         4KTlPP75BhfGsKyImGw68ncqPUUnkmDhk6cGddv6oWYQ5br2fRTiAMtN0rRdn0tvDx55
         P1xUYTP9p+TKatNU3D5VuOeN2JG+nnZ17YRLm7yv8yncHzpzPjjib5zu2IBjdcs9xdNd
         9Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774374392; x=1774979192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icuB+P4pLFsS5xV3yyRCAcHDDOVtvcJcGh9E5iVsFUw=;
        b=oBxyIgySOcFpVrMgDtg8J1CwQiYhJFY1/QPhArydtHUquFEjNSgtWmvWaTjwYUVz51
         WuEZBlBBCmGIIDOa+uvEquQWVV1dcmmEgpgPB/facaOwt0FvVylED/Okp5dmeyaBqd7d
         GtiCHinA1Q+NevudiflErRaFyZk8EnqaQz0KuGPtVHSS4HyIcp7tXMfWOETfDCT3dGac
         fB/8yFDNsKfPhuqmQ+r+yBsQyGCHv6aLnR59de8tBGaanebocD2vABVkoT9bEb/nhhcX
         niWqsNl+PW0PMqNWKpD8JT2QuCfA3IHJfzCejQ+vtab9hECYdMW63Gq6KlxkI360lTKm
         MqBw==
X-Forwarded-Encrypted: i=1; AJvYcCWNQmdte8JZryTjTycAhRAJ0uR6v+i5K27Ugg1psEaMVScwcdwT4SDsJrgbcqoNM5/InT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKEjlizQzGCBc54DRyKAzykz5I7IZIMBJJxWdJYJDFGwyzAX2
	oPv0wuL0QYr068mTGe/C6SqpHEEC8o9hJtgdk1MCNOisbmTN9cswek6R++hXXjFkbsLu53kyS77
	q5KzvWT+WxXckAnUH/Lqmgjal8DvFXeI=
X-Gm-Gg: ATEYQzwwrFFKzR1lwulm9bsH0vmHwAiHyvt7zIpMperKORAK+QAAVMtm2A8oq8dDWaF
	3BYJGkaBjFN8GoIlsRcKNgkbGR1JsncRYpmKiozXpePyTTmAjuTbdJlRfe0T3untb8VPPUTCShu
	c52sVn/FElMBxOJxT/EEsodc2rZX8cOcQSPle3lbmeb2fLmyvmVD+q07VhLw6q4oqtUjwB+m6oe
	SBStSPai3QkNx7A+PTXn50cu8r1dA8IMxHOIyebkjEnEAKIUs32qwGmyVsOgSrK70Edw0FUQDvA
	PyIu9cjWIP5xz8ZRrhzfYLLVnQObaKuCLAAHW02N+Zl8izd29K8R
X-Received: by 2002:a05:6102:1588:b0:602:ac40:96ac with SMTP id
 ada2fe7eead31-6038731687amr485231137.26.1774374391635; Tue, 24 Mar 2026
 10:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
 <tg73xy4pml4rvriysppziwm6nxzgmfih2mqkvla5wl2coqbqut@ioj7ltsfrslm>
In-Reply-To: <tg73xy4pml4rvriysppziwm6nxzgmfih2mqkvla5wl2coqbqut@ioj7ltsfrslm>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 13:46:15 -0400
X-Gm-Features: AQROBzDOKkIYTWtmNbiTIC046DHYbjq7gv6ABc_mEtqzBqwQF0DHofinEhNxXiI
Message-ID: <CAM=Ch04z+ZMyqSTLdoq6np96uyi1Q77-aF09VRiwjJs88vFsHw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 8:12=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Fri, Mar 20, 2026 at 05:49:30PM +0100, Paul Chaignon wrote:
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
[...]
> Thought given reg_bounds_sync() is used if various different places, I
> wonder how this will affect current syzbot reporting. In comparison the
> rest of the patchset seems to try to preserve current behavior.
>
> Being nosey, I also look at the Sashiko review[1], which gave the
> following review:
>
>   Does returning early here expose invalid bounds to
>   reg_bounds_sanity_check()?
>   When regs_refine_cond_op() produces overlapping bounds for logically de=
ad
>   branches (e.g., umin > umax), reg_bounds_sync() previously repaired the=
m.
>   With this early exit, the invalid bounds remain.
>   Will the subsequent call to reg_bounds_sanity_check() detect this viola=
tion
>   and trigger a kernel warning via verifier_bug() and BPF_WARN_ONCE?
>   Additionally, since reg_bounds_sanity_check() handles failures by marki=
ng
>   the register as unbounded, could this cause the verifier to explore dea=
d
>   branches with unconstrained registers and falsely reject valid programs=
?
>   While this is resolved in the subsequent commit "bpf: Simulate branches=
 to
>   prune based on range violations", could this intermediate state break
>   git bisectability?
>
> Given if we get invalid bounds in reg_bounds_sync() to begin with, then
> there is no guarantee that what the BPF verifier ended up with can be
> trusted at all, so returning early shouldn't introduce new safety issue,
> and the rest about falsely rejecting valid program doesn't seem like a
> concern, too, for similar reason.

Thanks for taking a look at the review!

As you know, the main reason for this commit is to allow the next
commit to identify dead branches
with a single call to range_bounds_violation(), instead of two calls
(one after regs_refine_cond_op(),
and one after sync()).

You are right, if the inputs to sync() itself are invalid, then
whatever "fixes" sync()
can come up with don't make sense anyway. So it should be okay to exit earl=
y.

One argument to keep sync() unchanged is, as you say, to "preserve
existing behavior".

I'm okay either way. If it makes sense to keep sync() unchanged + use
two calls to range_bounds_violation(), please advise.
Otherwise will continue with this commit.

> 1: https://sashiko.dev/#/patchset/cover.1774025082.git.paul.chaignon%40gm=
ail.com
>
> ...
