Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B305306B08
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289278; cv=pass; b=DIah/st35rMtgiU8Dm9Z4cYwDzhNyd/Qtv2ebr6PUQjbuCr0F4ad4fnbpdl4kDbL2Pr1CECpzRDXp8m0lqwKzMStRzWCpdLCVMKv0tzj4epR0IOlOh7awdJktTBEtxtOJURUSk3HELOtF7d51aTOlP8Ov+DgCWZcCAOxTC8oA9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289278; c=relaxed/simple;
	bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z33l7r4ZoeuUovTA7hNKojol77MsE6dC7YFUSXFysxOOaDhLda4mQ5DMTx0QaDyFPZH9oM83LWN+i3jlGjnVkWpxjCxNI8+WguX2T1Rkn+UMpxC7z0FcZWB5RTPhc/+8C94dBajOEB8o8u06Kqn2k3V/+l/D15FW0GDC77PHntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh0H9m6j; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh0H9m6j"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84231305a80so828463b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289276; cv=none;
        d=google.com; s=arc-20240605;
        b=WyjZU2rpOMFuNKrwUq+aPjKyRuEiFJczovgYW6bFK7qVzW0+A38VUyFg7QmbbtIyXc
         iILP5vMQVd6oEgxFYJ3j+Y6FHsBHqnKLleMXzb9HqS0/aTmm9iEv8tMj2hUlKKGmkzwT
         6BLlNciHfOewOj3Sge6A6zA3BziyTgAD8QwjG5W9Db5R1BequHuAMnfkqINpLh2QZaQt
         Qd2eMIh9dHBHZMfEW5rPgo8GEgK16sUg78NmveDrMVeCzVAWrYnOcH1T4Qmsw+CKn+U0
         CLdiXeueJP8mcG3xzQkFh6iPVLpKqx+JA12ToPX3jHfjP6d8SW9UT2/jWAPs+cAEYsPA
         N35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        fh=tS/ZvMhU86kIFhz27Cke+JzhBKD0AMtpe9brAhpSkzA=;
        b=DxrsIF9wtpEYcinX8dFmfArmpuAFOWfJfawnlMwVUi4yBj5JiWm6ZDZRcN1NGKWZmV
         BbFhk9MD+chKqXfKnNyenbz8DpnWDk3ft1Pos0iiOiu/JRr70nJ/Ic1iP5a55gASAO3a
         msR71A/4SjITURFg2tpSOdsVX0MZxrwu8zsPhPe/4XxdAhm/dDZ8eLr1rMm8KVHJBZAj
         bxem1z2P4BJL+nt5QW9ZXuYXRAEcJKIoVvjs5QjZ4EhbRWE53Gam552/amaOzV1HKrgO
         P/eH8fQXDCffk20SnAEkYN+On6xYyi7OebkFCx/amtkqRoV7QhxNhdK+V4rV1tPRL+Uy
         P/VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289276; x=1781894076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        b=Lh0H9m6jyIR+PD8Ye+qRHuYZziPwIayRolMFmDsEipZMJFiboDNgltZvPmjBGhzVLb
         O53UsGkl99pitYGgmh3dZ6TdEgFRe0bOq80bN7cMgQoeT+WLX28eP1AAkUlKaZkCez+6
         HPagc2wVq6GpaXzBF8FdxEy058tlVMkirYg9u46gyyPZpd8Tv7q70T8JfFuPAvPv6gI5
         fplynwQMOgSK6ONEiWAYGY5ygpLFu7GgHxRQCmtIGMcUfeRy8AKpwRRQfvnlrIyJbIP6
         /3mX3Jtwe1kUjSq6DmE5P3ymur0DQJUJbqSPed/W+osfLqDoxg1MBnhHRtnRuRPsuIbP
         LaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289276; x=1781894076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        b=JTJa4SQqdFLSoeu7VYYxa1kuGWGH6c+G0l0j5IpO6Sgc0M6nhtGpoRMQikkyJf0cmK
         +DNjQR/G1DZc9up3m5TopuSDP7eMRt0WJsTgDRsfpiQ3mffKOjydCq5z4Vu6uKuDA2rY
         FtcdWogkV3aosvjX3GpKqZMbiPabA3iEouLaFrSp50la/ZBh97Wja9B7jTVmULwCvfRA
         aGzRKxbig74PoQKHgmMRkkBkcwCHn8r9Iqkup6j7pGzVOeqS0LEVKA0xuoDqbu7TuYNF
         h7VxHLAnmKl1bSeUBYWkNSffW2emGymIK1ZmUBXtLN3RbYCHOn5tJjbPfsscqamaUQhg
         N6hw==
X-Forwarded-Encrypted: i=1; AFNElJ8zqxBDQirtVHQ66Df8/C9aE3ED4IiaL3wfPkqdYB8Pmxps2ke8jR5pH89AObqklFvWM+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGW6Y6jkbCdJfdIn8wXiPJSBAtFX+jOjajC0RHCeMMqYsJIbo
	M3Tt6O5FD9aOh3l5RMTXL/CPCWk1/eZ/XJcBJAcUi2fT0emoBy8GHpQx0DwOtK62zuRvDalT//Z
	Z27qpn5eoGIIuj+eDjZziIpe4PlpfVAk=
X-Gm-Gg: Acq92OGlxx859StJDQg7Fz3ZDApOF6hfaskyXLcdkfi/1BOxGLGdNQsiufNhTsxAvdq
	x1ti3zehBjfD/oEcGNdwuKjiCNcGK8hj4bfDrmZNFNtiGVaydvWvRTIHFGHKagprkiy433f1HLt
	xIXxP+6c7ZGanaf5HTaQQeqS9uedLOEQ1kO23h7bJdGAc/XAwwO59dVfsOmSLojfTbUplXI4HVR
	Xn1rrpMep6w3vYYyWZvOvuuj5lBw8SqiqlBSfzMuPajVW2ww28W4j71XxPr14VQDZaCgEuLqcOv
	m9amSxej69AQJ3KfwzS0SSHxRHK/WmCmejLSRC7T2I7jSfQp4gNJQCcEz/2W7kVFbdsiWB2Qemw
	ifILigUG26I/XU/Sfejy4JHsp
X-Received: by 2002:a05:6a00:94c8:b0:842:614e:cc8a with SMTP id
 d2e1a72fcca58-844e1a2ffa7mr845553b3a.28.1781289276251; Fri, 12 Jun 2026
 11:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com> <aixMETjhANSYBZP_@pop-os.localdomain>
In-Reply-To: <aixMETjhANSYBZP_@pop-os.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 11:34:25 -0700
X-Gm-Features: AVVi8CfQKniRQEMr5OnUvtD3CO2bD1CLLbu29ZZ1l2MB6fCjeNzhT_TTtepnwQw
Message-ID: <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
To: Cong Wang <cwang@multikernel.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>, 
	zijianzhang@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 11:12=E2=80=AFAM Cong Wang <cwang@multikernel.io> w=
rote:
>
> On Fri, Jun 12, 2026 at 09:01:43AM -0700, Alexei Starovoitov wrote:
> > Just saying that the code is free nowadays, so whether it's 1k lines
> > or 10 lines is irrelevant for the discussion.
> >
> > As far as the idea goes, I think, it would be interesting in pre-AI era=
,
> > but today splice and friends are a prime target for bugs and more bugs.
> > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > so my take is that we should not add any new features to skmsg
> > and instead deprecate what is already there.
>
> I guess maybe the name misleads you, it has nothing related to splice()
> syscall. Its ring buffer was developed on top of include/linux/circ_buf.h
> which again has nothing related to splice()/vmsplice()/pipe().
>
> In case it is not obvious, this patchset does not add any new user-space
> interface, only a kfunc which is visible to only sockmap eBPF programs
> which already require CAP_BPF privilege.

Not the name, but the concept. Taking from one socket and feeding
into another already caused a ton of issues for the networking stack.
If you can convince Kuba we can entertain it.
