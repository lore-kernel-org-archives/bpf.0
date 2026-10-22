Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632435;
	b=KYe1PWKMJ19Zoet0OVl2VaJ5TnqoT8U4SE1HLj/UofEgeWTYGJuWYAev6QUvVE+fT4Bf
	 qu7d3f2hX1OsPfpyl70UyYamKpIECGPqTPQysT9SCGSPyHddBE+3/IeXtT46Bm5cVyz31
	 JT8hsY2QEIRm5mhBbGAM6XdinGF9zbdb7We00HjPHjPcN7sKz2ugatQ3nxBU8EHpwWSbz
	 Hq0idjD/OrOP+CiYSMdVh8DjpBqlTEyD7FJwOriYIFZuzeAuHNmUrza5szuo+ld2kdmky
	 bCE9Qg8Sazh0ZAIVeJ+pkaGZduUc3nOEy6BZUCYa2/zzrgjORdEJGtpbU6QFgl4eVyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
	b=oxzBetPU0/TCqEdpPbDx9Q0o/3EnwxI/mLsm1IC9VeBekwQMbVpIfAcNwaHRpF0jTQos
	 9kwUh5HnTfp8EAXYv9b3KRxLItlMAMlgLIJAiBqwyLWav9Bi0vc8Q1q3hQUzhxYIoy7fq
	 1N3ezQiwBckHRgSIw2wUnEIFC/sR8tnxsdxuXTqABrrcXtKJgKBlnZGRtjiMPpi9Ej/yo
	 kQy/+/QTnlU9q7HT9Z6S5a1PPbAFgH5AaebbmkkMbqgUl4Y6s9SdGV9NGEIFtZBTf6YCk
	 fLN0vrlh6qVUvPFfb9tty2WgpEfsE3TSqa7g7E/V2L0jw6y1KAOJ+KgQ0bhijsu9W5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768F606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B768F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a01cac8733so768227b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632428; cv=none;
        d=google.com; s=arc-20260327;
        b=F1meX9o6lKvCLN9pN/HqoK2rLG4GbWiPK+l6kevBEiUJtZPPf27f8KD7l9T/Q0jgFM
         gzHxxdTK0TJ/SRGH4MMLXnOiApTf7Im1JBpT4Ps9/Xgho1cqyyKHLXmvkd0YhQMlrGdl
         FtJtgxj89ShukjsvFZ9cEgXHcfIh4MMoZyISiQi2o6Q7ybqSX6pwt1FaDHq9uN0NAk4W
         KcBLkjBCiBU19+epvM1k0lE7Rnb2YD7if22a7ykGiDrgZievG7ZLNzfy+hytQg0OfqRh
         +n8v+eNyAHKLHD7IPzN7hnixwcVy2ahB18/a46D7tl41pO8jQ5uJQayCpCFatDfqZ6MC
         F9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        fh=phkQ5Y1P9RIzL9pVZREGULj7ywmPldkmIQgCAdzEZ/E=;
        b=P2jn2nRSP+wI3llg/oB9iW1JpCOlYZsXXKxKwax6C2z1NSe6N/rVUqWwcrUXRfnvs9
         JuQ8LkrVViJqrXaYSjQQbKMOz4jZ1L0hiSXxpyAc4P7KJVLHxZzejvtyAjW35m7fvcmF
         0zkEj7oVrfY3SgCi6giVZ1WmztFQX/IaBIS02EV9jdir/HtyXKpUQLsta44yBkBoEyDp
         /ddBbS3boAtFMKg/ZXrFenPHk11EglXH7O5bXJILFeQX3syAbwhAuhbZqf85Yc6oRWAU
         3Ev1NamXJ4uYLi1D9KCI4PcF30j5wyFRVTUGzJpgrFlDIdoHK8Ivqovzv2StVvt7N9vm
         /J9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792632428; x=1793237228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        b=cgW0BiqesHjWNFuOJfEZwBvGqp5fc+2/z9c6DR8FRq7OW4NzwVtiUUqyLUlayp8DvD
         /Kg11ZSUPiNAfV2jt8+0HKIFXgk19RQt3AwATy9WdsTxSb1boweVq8pKDRT4fJmNLFFs
         R9mtHqMqzMPZf+wjfRSHaNQIqqA2iRrWgDUgYGmvZMGqM76De4yNE3Swfjj/VNUk3rMu
         Fr3X9TiFEndEBllfoCkC7ttuCnWr8JoeQQGumDhgG2DmVyfIOB9WL9mQrCztjtNm8Xgr
         v6THPxO64u2aJxxs5u4BkrVFbb/wu8bPg5ix389rp+2tZYYeayGFRb9guBydtFUa3d1V
         Iv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632428; x=1793237228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        b=AN4twB9XVFvWpP+jndjk7XerfbAchImng+vbnWVZ59fTlhyMabdjXIkhqQmECRExX9
         vbvAfVPa31xvOGZ1E7NnguGxlLWmZ6WlT6ToPNrXsSwKhoOCi2fljRSRBjBJJMSrqhM0
         5KMWxfvk6w6na8Spa+VkXbrcDLMgU56ryK6CapYAeUBLSzb2mDqNCcGFzsLmpoIXGpPZ
         b2LLEqm4Csku4CD7GLoukVNbxC70F8YSuWGdQJ2yk+Ytsyp/t1MBxQFdJlE4ohVoS4Q9
         9og5bveOYUiXx2BVdXL4x8dawodYgM7VwRRGb4mcLTsmVnGgzxISEGXBkPiA3PZmoiqW
         SGhA==
X-Forwarded-Encrypted: i=1; AKwUvBzUqIU4TOL+42J4/CT0/ThuPwQSX6pnU6lMN79vXA6+9BfoIDfSGQGjUJC6v41qVi15VWo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp+r/Qu/hVHMcFNXSt3dqiN69KshIj4cDTEXQaDtgiP2HPRvu0
	8akEGe5eTG1+RDqKsptxlbLqDSceHlHy4m0s+AQUmXVCZJgyA4nc4x6Q9rZq0CVKfWqNG3HHB0C
	HNND7UIRgkydQ2S5wNFGe4++5aw+pazCTyM9WAN7m
X-Gm-Gg: AYBFou2P+IpHY2bcBfoPdZYwyeyYWooKdG9LCYdjP3TEy2SIOvXHsBoSBIskc15vZif
	gARcwGoH7J+beBiGVNH9xQJm3UGo5SZ3/dl6PHr5mjpzciEFfxF1BR+AF5ZjcCyYOAA+SLB+Jwr
	VWxqrNZWDl+MBjyETVVFyLaWmwnI7URul9/PExr+kzuR9XQpg0V7Tzrv8E0cKnx+C7fIiJWvKoN
	XGYm/WA7T7tmyzw4T1/CyA9a/jzQ3KzwYvX9VwAjzxQ7gf1QVlJayiPu/pO7/wcwsN/0FHGbslY
	p/C+b7y/tjxmygOJYN5QJiiGkAsX1zw/n6sBTYqSIdN/XsFGGx/8nFGWFZgqzsOWzsVgJL/r+T1
	NtXIBRAHpcervArjWaM3xWDfThgb7cco44SCSsdDQOe9hJtFQksBJIMy0iq/+DXK1OIbi
X-Received: by 2002:a05:6a00:428e:b0:870:c2db:da2c with SMTP id
 d2e1a72fcca58-8a089de70e8mr2794770b3a.25.1792632427984; Wed, 21 Oct 2026
 18:27:07 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
 <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com> <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
In-Reply-To: <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Oct 2026 21:26:56 -0400
X-Gm-Features: AclHuK-bAbwE_NBMaWg6hMgjd_8AiVgfixRTO-O8tlD4QGvoKSvNs8HFVoRlx-E
Message-ID: <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 7.4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	linux-security-module@vger.kernel.org, brauner@kernel.org, dwindsor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Oct 21, 2026 at 02:26 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The primary reason for my objection is that the bpf_inode_init_xattr()
> > kfunc, despite its name, is a LSM kfunc and should be located in
> > security/bpf_lsm_kfuncs.c.
>
> Linus,
>
> there is no such file. The ask is to create it

Exactly.  It's not a new ask and I'll be happy to create it and move
the kfunc if doing the work is your only objection ;)

> ... and to give it to LSM tree:
> "We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> the LSM framework"
> https://lore.kernel.org/all/CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=3D1q=
XK=3Du-x-Q@mail.gmail.com/

"... just as the maintenence of bpf_fs_funcs.c falls to the VFS." is
the rest of that sentence.  We're not asking for a type of
cross-subsystem relationship without precedent.

> fs/bpf_fs_kfuncs.c has six xattr kfuncs already:
> bpf_{get,set,remove}_dentry_xattr(), bpf_get_file_xattr(),
> bpf_cgroup_read_xattr(), bpf_sock_read_xattr().
> bpf_inode_init_xattr() is the 7th. Same "security.bpf." names,
> same check of the name.
> Christian's answer to the same ask in June:
> "For xattrs we have it all centralized in the VFS and in general all VFS
> related bpf kfuncs should continue living there and be registered there."
> https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-bcb35=
2c3cf59@brauner/

As discussed previously, the kfunc in question isn't really a VFS
kfunc it's a LSM kfunc populating LSM managed buffers and calling into
LSM private APIs.

One might question the placement of some of the other BPF kfuncs
located in bpf_fs_kfuncs.c as the file is conditionally built based on
CONFIG_BPF_LSM as opposed to CONFIG_BPF_SYSCALL or some other generic
BPF Kconfig knob, but there is no sense in worrying about that until
we settle this.

> > The bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but i=
t
> > does call into an LSM internal API.
>
> That API is lsm_get_xattr_slot(), a static inline in
> include/linux/lsm_hooks.h:
>
>         if (unlikely(!xattrs))
>                 return NULL;
>         return &xattrs[(*xattr_count)++];
>
> The kdoc of security_inode_init_security() tells LSMs to call it.
> selinux, smack and evm do. BPF LSM is one more LSM.

Yes, that is what I meant when I said it was calling an internal LSM
API.  The lsm_get_xattr_slot() function is intended for use by LSMs
(it's not an external LSM "hook") and the fact that the kfunc in
question calls into it (and not a single VFS function) is one of the
reasons why I'm arguing strongly that this is purely a LSM kfunc and
should be located in security/bpf_lsm_funcs.c.

> > it weould appear the decision to locate bpf_inode_init_xattr()
> > in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
> > never allow a kfunc in the security/ space:
>
> The kfunc is in fs/bpf_fs_kfuncs.c since David's v1 in April.
> That email is from September.
>
> On Jul 1 Paul was ok with the kfunc there as long as LSM bits move into
> security_lsmxattr_add():
> https://lore.kernel.org/all/CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_e=
GX428g@mail.gmail.com/
> David did that in v5 and v6. On Jul 31:
> "I saw the v5 patchset and the nature of the kfunc became painfully
> obvious to me so I changed my opinion."
> https://lore.kernel.org/all/CAHC9VhQ24fp7_sy1=3DNiWkfzPLSM35ugSCOKDKxnm6H=
9W-pDa6Q@mail.gmail.com/
> "this puts us at a stalemate and David will need to find another
> approach for his work."

It's worth reading the discussions from all of David's patches, but
for those who don't have the time, I would at least read how I ended
the email Alexei references:

"I've been working with David and providing feedback for a while now
(perhaps before you started commenting? not sure on that), and I'm
continuing to engage with David, you, and anyone else who wants to
comment on this thread."

> > I can't support the BPF maintainers actively circumventing
> > review/oversight from LSM developers.
>
> v3-v6 were on LSM list.
> The last series is that other approach. Christian, KP and Matt were in cc=
.
> LSM list was not. It should have been. Fair point. Will cc next time.

It isn't just about CC'ing the proper lists, although that is an
important first step.  It's about actually being open to feedback and
working with other subsystems to arrive at a solution that everyone
can accept, even if they do so begrudgingly.  Forcing something
through like this against the wishes of other subsystems is a last
resort and needs to be called out in the pull request so Linus is made
aware of it and can arbitrate as he deems necessary.  You can draw
parallels to the Hornet LSM debacle, and while we never got to the
point of sending a pull request to Linus, we definitely made you aware
of the work and believe it or not, we did incorporate your feedback
and tried to work with you as much as was humanly possible.

(As an aside, for those who only casually followed the BPF signing
developments of the past several years, it is worth noting that
shortly after Hornet was rejected, Daniel proposed a solution eerily
similar to something that Blase had previously proposed and which the
BPF devs had rejected.  Despite the odd about-face after all the
mudslinging, we did continue to work with Daniel on his new/old
patchset because we genuinely do want to see the right things happen
in the kernel.)

https://lore.kernel.org/bpf/CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=3D=
B2smEw@mail.gmail.com

--=20
paul-moore.com
