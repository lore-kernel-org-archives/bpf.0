Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCE57ED88
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196688; cv=pass; b=Nk9xNw7xKAK4d7Zbp7fsbLRw8d15P4ScL76i4W2Mus93RBJNmo2sHgOXfVhIxwYCckxKj6QXTTSkLjrErLpjCtTYLv7gYr3i1CnbfAIxjfuZO2MqvWh0qpjQZDekYV0X94WzXSgGpcuOFHiXp3E6juzSXFpdtJeu8Bt6fmdkl1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196688; c=relaxed/simple;
	bh=5RYTLQDvsY6XpN1VQbrbqg1sz7KWIZfN0YLEprJU4uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W01ZChjXkq7DCgiRymaFgTC0EcyIGyNn54iwIYkemBZONyctKWygcR0bnOL49k3Igg0FCWphFOfrDCZhxNaHuIFsY+kf3mZR1WuTyAajyJeLNr+9IeBYaGfxes4lSOmqXv3CXQhzzb93tUmUG/AIohVyoSO3ZzZuRasEwetpg9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jy9s/CTR; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jy9s/CTR"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39d654f02baso764525a91.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790196684; cv=none;
        d=google.com; s=arc-20260327;
        b=FbuahDlpIporqg+O/9C9NH+JZtTJvKRAGa9Lmlobeg3F/+VHAcf/W5Nh/iOMtZ9roV
         jSojmAcXylW0J1XJD8hfjj/qmuUSRjjch7Fb+5Ua+SLnAPrC8uQ5WnuCPK2nwuz6rET7
         Try+gWtfVq65xYS33glWI7Uk/ecxKOrfWQEbnw4z09yfuJsuBc1xHoAKMY0UDWIcoV+B
         dWEVD6KfxL1Wj3LGiwV9AXx4n/fGg5bY25n8VeHpI51e882Dcbf8xErddfZaoEg6GQ/Q
         RFdcs3exY+ukF2JnLIIPE7l1ioWdWcs4fDS0dnQjPnVFA+V/1DHa/eYCbYpgk4Fph5FC
         tXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        fh=/9Ldalg4EsuHMdXWZ6vDGTJgJ6acqbM7CqgS7O7uioY=;
        b=TTRWNLoaiYhxCofEFAByfyAUxE2GCbiTJBooktLLEgrvRfDcNLiVrFR21o1a8zD3B6
         qmNcfBh0tPXQ4Gv6pRFy2UM69wDZuP5K08nnWC98fKpBSmaRM6ZdcuupsErPMGZvjM2j
         5dZ70L6I+Qrr9nsQljNYdqu3GEIvA+iy2YOiIYOU62oM8BJzaCHOUoPgMgWfrdgeOEoC
         beW9vLguVCYnlMHOybePlNrZqDV7yuBcJ5e0p5ewjK3VgJQGyB4OdxavrMhAp2saSaDY
         RDgGsfu5ybYgHwqTu73L56o+TrjK8XNbeAfxnfaSFW/4z/2V4ZFexNzzWPR736ndoS9J
         ZZSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790196684; x=1790801484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        b=Jy9s/CTRgYkWy45lZFpncBbKX8Sd/nTIvGyjYjanbW7ikSfVqw8ik5En4HWNPwurQE
         gZLY07EzDW41AOBEcY8zzByVGoS/0e1wuD67qoHF5Z0EmXtNyy5NDocRHSxszpBCNbl2
         I+mdYAr/Wb/9focNs3Uj4ppYm+TcJmP8qUXVRuvXvzjtyT0KTbXySBugKdeomMwnUc2Z
         N0JVZkJuF4whi4wThkpNHkeCukHWiffsvhpICjsCG3YPS06j1nqAsFhJyQlDo7Wvl0lx
         vmXqZfjO8UMXIxBehvuMT6kVaHG0Bvb+2JZRcxoDyqVcofLyfWtZKQDrySK+/5oAsLmx
         33Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196684; x=1790801484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        b=Fa6AogUg6lnda6SLpBIkDlyg3dLzdrXIg7xhwQyVlyqn3Nm+LFBadKdM0jc5s0Ecf+
         DE/e5PNQba/bPnYjaNbqGsA0tH72v7MFJqmh6BI3lLKWVe5KmJU2VWjeq6DQqIpsUegh
         CBlBzfpex6Qr2atkEwM7QakUr3xvY3WXwLVpmXb7vhbuKLAKecnvYJj3hTWTkv3e1vfJ
         iw5w9YCS5tFUO4SyGRYSLVLJWn6MyX2N3w2cVCVV/Q+DTC64UjLzJrgpO6Myjyl4EBVe
         CDvaLKSDMZQvs6lCHs6Xm4CLmylTghDmS0YAHFDlB4nTJPD3Omktj2sT9F9EJjS2papn
         NvxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaBGDhLpkUALDFeB/lk22p3vwYVUEDpP+VhHyqvSMK4VROkKmK+bgLWg1w5HrYbMJOgqg=@vger.kernel.org
X-Gm-Message-State: AFuF++nd8uKHBF3TVAtukBXqLYFsyumTXnmbgj7I0m2VTxQSjMO8HPyp
	IKKAFHvvuDmZCDYoM9P/H4H3/aLqm2jJwTN45+f9C6k6a4NnArBMr6ALcjuynVfDhioDS4AWLFY
	TcEOn3wDYJ/Tf+jLsKsLC2VIzMKTK5YjSGXo9Q6tB
X-Gm-Gg: AYBFou2vBPdyh3Uhv7OLkNEY9emtkt5BKHGs0cWNn34CqYC0KUl2nISYhasXVkLKQBO
	UZBDQ0axJ7y8b12v5pHPzKpfmVss+jSlhdtGi0sjnj3dIiH5tJ4YVvxd6byO6vRI1oFaMel+4ph
	qxvLQmU6nE8RLo/PmyI2zlM842LGxx8cNAJkchfpvauugiCpLusG+XVNnfR6Xmf5A1j3UX7l4eB
	UjwJhd5NWOnZS7T2xgRSOD/fJRJf8vMGlwkgUNANHvaDssEq5K5sq24z9XKDy04DM89gOkT/ltJ
	Yi2U8F6th1DqShMmTJJ6jRN2ySWYk7O19wz5sbi+nMiWZabUt/wbifmamzb02AlrRZnp3HgL0+q
	3MaMSsx3ws3I=
X-Received: by 2002:a17:90b:1c8a:b0:39e:6c69:34d5 with SMTP id
 98e67ed59e1d1-3a098e900e7mr270237a91.57.1790196684349; Wed, 23 Sep 2026
 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net>
In-Reply-To: <04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 16:51:12 -0400
X-Gm-Features: AclHuK-ar601PMbFiiED6HOc4D8YTbyv-_xOHtq1GJMVDRpo26gCnJ7sdFUEhlo
Message-ID: <CAHC9VhQ9NvAn=+58weX8to-AaxsOQn9gck9Ztmrw86aemhWWsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: dwindsor@gmail.com, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 9/23/26 6:57 PM, Paul Moore wrote:
> > On Tue, Sep 15, 2026 at 11:07=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> From: David Windsor <dwindsor@gmail.com>
> >>
> >> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in ext=
ended
> >> attributes. For these LSMs, atomic labeling during inode creation is
> >> critical: if the inode becomes accessible before its xattr is set, it =
is
> >> briefly unlabeled, which can disrupt LSMs making policy decisions base=
d
> >> on file labels. Existing LSMs solve this by setting xattrs in the
> >> inode_init_security hook, which runs before the inode becomes accessib=
le.
> >> BPF LSM programs currently lack this capability because the hook uses =
an
> >> output parameter (xattr_count) that BPF programs cannot write to, and
> >> existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn'=
t
> >> available until after the inode is accessible.
> >>
> >> Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs an=
d
> >> xattr_count arguments, passed through from the program's context, and
> >> claims a slot via lsm_get_xattr_slot() on the program's behalf. The
> >> xattr_count output argument is exposed to inode_init_security programs
> >> as trusted read-only memory, so programs can pass it to the kfunc but
> >> cannot modify the count themselves.
> >>
> >> Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
> >> every other xattr-providing LSM does, for the life of the kernel. The
> >> framework keys the collection off the reserved slot count, so a kernel
> >> built with CONFIG_BPF_LSM=3Dy now allocates the xattr array on every i=
node
> >> creation, whether or not a program sits on the hook.
> >>
> >> Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr a=
nd
> >> xattrs arguments are marked __nullable. Both can be NULL for some call=
ers.
> >> Without the annotation the verifier otherwise hands the program a trus=
ted
> >> non-NULL pointer which it dereferences. Also, keep the hook out of the
> >> sleepable set. inode_init_security runs inside the transaction creatin=
g
> >> the inode, with a journal handle held on ext4 and btrfs and the parent=
's
> >> i_rwsem down, which is why everything on the path allocates GFP_NOFS.
> >>
> >> Signed-off-by: David Windsor <dwindsor@gmail.com>
> >> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++=
++
> >>   include/linux/bpf_lsm.h    | 11 ++++-
> >>   kernel/bpf/bpf_lsm.c       | 22 ++++++++-
> >>   kernel/bpf/bpf_lsm_proto.c | 15 ++++++
> >>   security/bpf/hooks.c       |  1 +
> >>   5 files changed, 145 insertions(+), 3 deletions(-)
> >
> > @Daniel, you were CC'd on David's previous patches, so I'm guessing
> > you saw my objection[1], but just in case you hadn't please look at my
> > comments where I requested that David's proposed LSM kfunc be located
> > in security/bpf_lsm_kfuncs.c as opposed to fs/bpf_fs_kfuncs.c.  It
> > would be really nice if we could sort this out now and avoid having
> > this drag out or escalate.
>
> Paul, I reached out to David recently asking whether I could offer some
> help with the BPF bits, added some bug fixes and a lot more BPF selftests
> as I think the inode xattr init is valuable work and something we need as
> well. I just reread this whole thread below given its quite a while back
> and didn't follow in too much detail back then.. the location as it is is
> perfectly fine, I see no reason to change it, and I guess that makes thre=
e
> of us then including the VFS folks [0].

I didn't think there were any doubts that the BPF and VFS folks wanted
the kfunc in fs/bpf_fs_kfuncs.c, but I thought I made my objections
clear in the previous revisions.  While you've changed things slightly
from David's last patchset, essentially folding the proposed
security_lsmxattr_add() helper into the bpf_inode_init_xattr(), it
does appear that the basic purpose and context around the kfunc
remains the same: the proposed kfunc is called from a LSM
inode_init_security callback, it populates a LSM framework managed
buffer, and then when the LSM callback returns the LSM framework code
in security_inode_init_security() does the xattr init based on the
buffers populated by all of the configured LSMs (the BPF LSM as well
as others).  As there are no direct calls to the VFS layer in the
kfunc, but there are direct calls into LSM internal APIs (e.g.
lsm_get_xattr_slot(), as well as the LSM state and calling context
mentioned above, from my perspective this really does need to be
located in a LSM framework BPF kfunc file (e.g.
security/bpf_lsm_kfuncs.c).  I've mentioned several times in David's
previous postings that I'm happy to work with you and the BPF devs to
set that up.  If you are open to that let's sort it out now so we can
get everything in place before the merge window.  If that isn't
something you are able to do, that would also be good to know.

--=20
paul-moore.com
