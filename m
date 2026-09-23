Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC745A29E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196981; cv=pass; b=uFJbx/qP+xloXFBEt+Qq5oodHxpPv9iBbKgCnI51klYsVNilRf2RkhqyfZENsx3eT5psomjfqO/jUIXgG5XUV7Y2AXY6+9kH7WRFwKTcMjo120UWEnGt7Emct0+pD7AmxJ8+brP+49NfQxk6y+vU2iuBCVtPFqOV4rNl3TxxTaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196981; c=relaxed/simple;
	bh=AfsNOKliYq6zL1eqw3cqwWjdNoNKiv3VUp2n3SA8M3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeIst/BFFNoh8VcnXAwU7l/v3vd+gvSLRb2KuYTxRQ+tuMUfx0GXcjLyzDQ5FgKN/d8YDaVYnv6nYpIQtMMk4S5OTQC4hraH+ESbyOfF5AfblsrMBF46Vyzz08isanLLWS46eHNseAcNVsTVaQCAVgRcU2dqU8GABRVNHR4rK/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SCxH7Yqu; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SCxH7Yqu"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so638077a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790196979; cv=none;
        d=google.com; s=arc-20260327;
        b=J/XbCm7z9vVW3CVlJRfUp6ApzanYunJcEAMXc6HSq/lQC/ry3jGzaNR4dZNAv6VeEZ
         Rz7bo2spdAWCzsT0Tyuni26gyUe5iguhw+mcNoe7TvYCNq5zpcOYsNnCF1kdbQkWNVcw
         fJWPilJ216hvrnFfj6ZMMziNgMqh8jzVAQDD0dR3cy1ZJFN//tj9xMP2dLoM1foTg7KY
         1Mz645wJcvixRE8H/eWXB7GAyX4CChCq07oNbIMmX72fwksaCEq3piTnvjkiE4njBGKs
         Kouh9HBOJWRtt4CfrZDroVfMLZOxVHXXS5T9tRhSrikBtc0igRPC4O87LPIUgSyvQalH
         4B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        fh=MOqrZAcmRT3gOSkZn0pComQDahtRTO3FTtSDOguC9NA=;
        b=PBH0c4UJBRLRVvISoXJiPZwIw89viirI9iC/GMY6Qgc0nLTjW/cHKQ7T4Lh1Je1C50
         87y++pZkBDqaoqiZXN2FohZYdgC59PHVcXq5YzuPjw1S2lK3dCxbyNDW8tCbJweEeMWo
         qPw/JVEVJL3/SXzz6EY6gKV/MFcAXGpuWYpWpsrp9oKxsNVKunpZXsVBBx2vdE/5iaZv
         3fcB+IjFUKNtJ2D94BzD1/FN+6O7hw0fpHclfghQdQDF1xtRNcsZFvApwxopwAckKUxA
         k8CLiZchF2JFuNmDF5+lWjpZNKXxgoekaqYAUs5n/QG8O0M6UrPihhIa8O1mCPr8Z99J
         GfGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790196979; x=1790801779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        b=SCxH7YquEqV+DMQ7X1Pwfgpngy1rqsZTafwV3mLotiecr9XnNUqcX+RS8aIvbk2rZJ
         TrW5VOSZPCGF1FbUz+UxdHCtJnGzIsJhWdArB+Y1x53R1JAF5z9ZiWARgW7zmf0YtjXD
         gWxkaWdSTlG/RoeSErfU1k0wQOiUNPXkOeUC811Gopln/qQ+H5lMNd3jS0TUJ+sJSpWi
         ElVRopfx5aQFpVpg2UhgtFn7Z6D/wnKhPuGlqVbQ8GqBIaPj3WHWvUJvFamrtdGOOutJ
         LbqCKYGocOk5c+lLDP1zE03fhY2K64vAesqPmvutPKZFGCbADlFOM75BbbyNFG/AoMLq
         dTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196979; x=1790801779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        b=FweK8Hoq1E1bEXQ8l9yqdViY9BrbqaNLSItOOPQj/e6LZwpfVQo0JG4hztGp98dCXv
         hnl9UIcCeXERwB7nx+cvcxzBm6MFQSQXKGwPteKgIg7FcLCcvMrKmQZVnia8xxZSgbQB
         i79SAzFPjf4rQd9Lkoyys1m/3z7NuZfu6QFoS+HSPEK86310k4NHIYHEwpS7iNeQ7/05
         c0XlKHg31VWgj76M8SDfnOI9yHxUwt84zVJQjd+wqnT2CmayK0d4f33DxWpOiysDHmuK
         v0+mtEor29i2vGzZwIC5W6Wmlrp3JUn5xtLZeFvJkKORZoq1ET/XBEri0dyHk47ENeRh
         XFKA==
X-Forwarded-Encrypted: i=1; AKwUvBzMOFD1FGRUi/XxlPYRWQ7R9H5xlEJaYWE8L0OkNEMvHON5XqVGhamL2x0uEPKsN+xQCkY=@vger.kernel.org
X-Gm-Message-State: AFuF++kx4wN+bPOv506aidDQUlGQY7H8QyaRO94jN/QDZrHclX6+YhGP
	WK2md/oQsnzFpgqGK34VSAns/RFBTAqyRy6oavD0g3lKPU+rfXhC+Wc7CHdpGFzxNXb6P1j+NIB
	Ln5ZyrzT5P8n/QssasU+4dHj6VBS0Lajy+3wDyZ8z
X-Gm-Gg: AYBFou07ETqkmc47zehrdb7uYicahMB7R5vNrwLIlXH+wWBvmGsITbeAe7tSA/Get6U
	jG5DBVnoWRCuv4bxMaV0o50aOlia9YX/cP2TtAe8sxfPnqhmjjvBS3Dz/iLZbvAuoT2Fb7h3ZXX
	oA0/64lbsWJW+TAipwFIL4LvVWIAzsJoh0shgSdddOkT9+0Oo6pOc9mdvd+Wa0d1gugWTU8gjLX
	LdA6qeF2fCtYxsjEThYoIJwcQMAmWmbSRJG1TKVi9f0lkQt/wJnvQkNbaKow8/NLLr87EzXERbm
	fNJQA4jIGW7gdZokY+Ab6azxsL9/95AJ2NpuH9Cy8hVMUvwO4DEcrKzbaJ2MSNAg0lS4EwjlAlx
	Oa1wdYfdVtw0=
X-Received: by 2002:a17:90b:5783:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-3a09860ee65mr161639a91.6.1790196978912; Wed, 23 Sep 2026
 13:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
In-Reply-To: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 16:56:07 -0400
X-Gm-Features: AclHuK90iLZutEt8vQpJHROuzrBD7oVO2vZ8qgmd-e8wc1UQ4r8BY_tG8pTzJSY
Message-ID: <CAHC9VhQCcbu9v5aNPBxd6sqwjn2bWZYKJcPMMd=kBQJUuSPPAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: David Windsor <dwindsor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:14=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > @David, simply for my own understanding, did you ask Daniel to do
> > this, or was Daniel operating on his own with this patchset?
> >
>
> Daniel and I work together and both have things written on top of this
> kfunc. He reached out to collaborate, I agreed. We're also going to
> send bpf_set_file_xattr shortly.
>
> This implementation was chosen due to its immediate mergeability (it
> only touches security/bpf), but was actually suggested by Kumar in v1
> or so of my original series.
>
> That said, sorry for any confusion about this appearing as a new
> series rather than as v7 of my previous one.

Thanks for your perspective.

To be perfectly honest with you, seeing this patchset land in
linux-next without it being posted to the LSM list, or at least CC'ing
me, after all the discussions on the previous iterations seemed a bit
suspect, especially considering the rather rocky relations between the
BPF and LSM communities at the moment.  Regardless, hopefully we can
get this sorted out.

--=20
paul-moore.com
