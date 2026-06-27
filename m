Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071D1862
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782523967; cv=pass; b=gQx5ss7c4m6IOgrAeE7h2ed6bGyzaWhacPT9REBiGVAjrauB+d//jMzOzFFTR+mYI40swPFzAtHSyT/fdXsxt6WIGbWD8XjcpFTEHEttVFWnDa+pxscb78JuM6dSHEAcKNDITS/rvORTFyAKyAHlkCfuwCNhOKnA4UCaVTHa62k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782523967; c=relaxed/simple;
	bh=bUMDHoIKujOnOaZazj3fPoB//ObbDdwwJzNxa7frPGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVfd9N+3xjnpGHioSq7WLiiAHke+jE0tkrfDQ+VbIREb3ABVja3B9VAUqnWWxh04e+yUB5AZ6Dx0uf4Rsorj3iPGwRd0lebdyZ6T01reqqPK0iWPrduyR58yYLCtfZExWe0ZFg5o16jlu//egz8ULsANSt7GqMUqtKnE7EUHOZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VgAcQEme; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VgAcQEme"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so980380a91.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782523966; cv=none;
        d=google.com; s=arc-20260327;
        b=V8y8Z3wjJiePCL8YDaJgpVLliEoj5XPKgiA9q0/IoL+7E3U/l2TYzNzVe+N9vUFZHp
         s0+LpLphuhVfv9yKKZc9QaezTyxN/DbslBBLfaUUGzdbDXH3idTTttzJ8PNEaRf14zsl
         5AuToeT4AKJygxCAupdAnLGQn40yqOq9C+/ZehgtFU3/gy436T4oFMdDsT+SNaIItF6I
         xRrIuvad9RL7vwxCRcPRt2C/AG44w2DhW5XDmDDnmJzsZR+dAJg2MYu3F6pKrX/SQagj
         B4NznHAucNMC2MRGjLactHDBryPURALI2lSk000BB2el1cJG+iAPnAYGLMI72frbXjN2
         SPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        fh=O0ylKxPF+d04Q44/F0JfBFmz6K55VPk0KxB+lLZHtsQ=;
        b=ZjuxWGOWc5Nrs/bv6qAfTedlIKwGQ0OqGkMDbKe7o8cBs2oJsCUiSEVNw6WD1Z3wy6
         LYKZ3t07/gtZPMglbtSZO/h2Tqh9MjN84AmKgviq046fpGez7QWvPp3AyCduc88N9mC1
         0T8+rWH18Dtt+MXCwXIJCaC9yiJ/aoLtQwaZZuScBdS58LL9RXhC2rTRpA27fUl2bLLM
         F9YAlvlbdmOKp4rR5xe+J8kzGkc2hlYTr2VAJojQDIVbGpO31hCvSE9t7bEiNNXTNDBe
         WH344cfVkJtiJdqwXtMB3QUsqy9c4OziD+YiCVD00EhB+7a68N1MvBZDKIndWPWxhyEC
         eB6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782523966; x=1783128766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        b=VgAcQEmeOjFH3EWHVrFyzhuzq4BVI6G1VrFA0CzMCffr8Uh/dbiwR/3iSFVRwUYcX8
         xTIsCLdPk+F5Z6Mncq30tgWAgkhXVOhATClIImAH4GEy5G8rB/RzsgKIhfiUoR/SyNBY
         R03AV5YZLIZK5WmZHwt7PCEGf9htzp+3ax4kWhwat9dmCi9/QqlofhFlmAtPuoHpGqeV
         uB3b+Ogp/2pfjzSxHTrrneheNn4HyqQt4kxewduJXdG+Oujf1ktCuqwxHN+pjJsRmuPK
         SC/XnNUjCkmWCLxeDR+UlXZT+FD+6MHwPsc8TXfGm3Rj1SCT0EJPW1shPr80ZzWGUI9A
         dtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782523966; x=1783128766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        b=MI/oqNNlyw3PEjZ5mXU00nyVQuieWwTFs+dA92820/mGX4TMvajm6Sdk4DN22j8NES
         XfN9ZcfnDJm9AsOKWZUrsGkRsvLdh3GZ+q9Qu7czsLMjDfVquIaicy/JPRUAdJl9e6Sm
         BH0V/+KLAV6WvttAjhQFyDboa57f+vO8ilV7jrgAyZhQiuSaX8hq46Tk7M0gG2c0U+KJ
         m4P2rGXsj4+e3WCfEkCxsiRJ/cZQ1T1unoYWZmn8qCrX++LOVQfXCTmOog6pguBmpjuJ
         XxgEaTgPUdCzHsiC0z0xYlGCURYSUuU201zIGE1/idFTInZRu0DQzWlKQMYRmFgYBnW5
         rlpA==
X-Forwarded-Encrypted: i=1; AHgh+RrSQAdwrbquu0cI7KYUK0kUoxFQDM0YTUgshcB/OJ8ma4C/p41YuuRleLcyZm63ayvgsp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPxYqCvoyCfDcw7QsO4O7tAMXjPYwB1scfa6xiR82pLBpiVtM
	OgAbgFCjzRKfl3bKbAdsg/GaXQwY68iRZcImDyKW0NWfLUde8KhkQLx3YsNKGIekD8XbgdAKXio
	TA2n8qL8CQCZtGcCKkKi+sQQJ82BwfrH/qojka1W8
X-Gm-Gg: AfdE7cmbPtaRatMMRqxeosXs+HRENjz0CYjPwxdjnEglNei89UGVuL6Q3auEPikdjri
	Rsb4BFntHbm9LfvQXk6gP2ohx4lIPQlFO8DIaBY4OnEPfzvcZoxurtXaw+k0uzPQf8KthCDuP4y
	aACeEF7UpMWDurtOft6NKXglIInLw6A2EjvKzeSqiC50yOnngdszN6e4uRbsE2T6XMojUs33gEW
	RkSIPQqV0glkULVIB3eEq6WfXkL1w/bgiCLC4rc6qnl9jmC93R0+FANbnkI9gy7Wn4q5OIt
X-Received: by 2002:a17:90a:e18d:b0:37d:a52a:ff12 with SMTP id
 98e67ed59e1d1-37df9142ba0mr6424100a91.10.1782523965668; Fri, 26 Jun 2026
 18:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com> <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
In-Reply-To: <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jun 2026 21:32:33 -0400
X-Gm-Features: AVVi8CcSVFSQ9mVhPKRt5MUncLCLrJFUmMsLLB4PoeK8rOFzqfv4rkQMO_i5arI
Message-ID: <CAHC9VhTtaT_8AXSfNKiq4cGq7T=6Dh=huM8niBCwOP8kj+ugjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: KP Singh <kpsingh@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 6:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, Jun 26, 2026 at 3:16=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> > >
> > > For all the reasons I gave previously, I can't support moving the
> > > existing security_bpf_prog_load() hook at this point in time.
> >
> > Paul,
> > it's not up to you to approve or deny where security_bpf_prog_load()
> > is called within bpf subsystem as long as it doesn't affect behavior.
> > Daniel's patch doesn't change observable state from LSMs pov.
> > It merely moves the call from syscall.c to verifier.c.
> > So we're going to proceed.
> >
> > > I'm guessing you still haven't looked at Blaise's patchset from last
> > > September.
> >
> > Blaise approach was Nacked because you guys ignored TOCTOU issue.
> > I pointed it a year ago before AI was a thing. Then sashiko
> > pointed it again and the bot explained it in detail. It was again
> > ignored.
>
> Agreed, with Alexei: I like Daniel's solution because it avoids the
> complexity of machine independent BTF for loader programs and still
> addresses the signing goal, without the TOCTOU. I am okay with the
> current implementation as well. I think having kfuncs in loader
> programs would be useful, but we don't need to rush it or tie it to
> the signing effort.

As I've said a couple of times now in Daniel's approach, I like the
basic idea in Daniel's approach; it aligns with the same scheme we
have been advocating for all along: run the PKCS7 signature over both
the lskel loader and the maps.  I know you keep mentioning a TOCTOU
bug in that September patchset, but the main objection to all the
different variants of Blaise's patches was always the same basic idea:
you and Alexei wanted to verify the maps in the lskel loader BPF code,
while we wanted to directly verify the maps as part of the PKCS7
signature.  Any TOCTOU issues were implementation details; the
difference in the signature scheme was the sticking point in many of
the arguments.  For whatever it is worth, you and Alexei were not
immune to TOCTOU issues either.  The frozen map problem was mentioned
on-list and ignored.  We had to submit a PoC/report to security@kernel
to get it taken seriously and patched.

Regardless, of how we got here and whether or not you recognize
Daniel's signature scheme as a retread of Blaise's scheme, the point
is that you've come around to a concept we have advocated for over a
year.  If you plan to merge it, good (although I do wonder what Linus
will think of the userspace breakage caused by abandoning the
signature scheme that shipped in v6.18, maybe it's not a big deal, who
knows).  However, and this is important, we can't move the
security_bpf_prog_load() function to where Daniel proposed in his v2
patchset.  The issue is that non-trivial work happens, e.g. the
potential allocation of a buffer to hold up to one million eBPF
instructions, and we want to ensure we have an LSM access control
point before that happens.  If you, Daniel, and Alexei want to move
the bpf_prog_verify_signature() call into the verifier that's fine.
However, the security_bpf_prog_load() call needs to stay where it is.
It served an important purpose well before signed BPF programs were
supported, and adding BPF signatures doesn't invalidate that original
purpose.  If you want an LSM hook *after* the
bpf_prog_verify_signature() call and you oppose adding a new hook for
this new functionality, use the security_bpf_prog() hook.  It isn't
quite as conceptually clean of a solution as adding a new hook, but it
should work to allow you to control access to a BPF program based on
the signature verification result.

I'll support Daniel's patchset as long as you don't tamper with the
security_bpf_prog_load() hook.  If you move the hook to where it is
currently proposed in Daniel's v2 patchset I will have to object.  Do
we really want to keep going around on this stupid, petty carousel of
bickering and constant NACKs?

--=20
paul-moore.com
