Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E37FF4E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812914; cv=pass; b=g53g75KfbJIK4hTMmGhK27RcAXXrkx/BzUSRjREKgj9671X3rHBVeVoGLXlEGLIMIP+RNBlQMk1glzCXiWOn0AA7Q9EsNEzYPBiMBxG6jdz1poXkAUyvmGYw6IyP7310XnoPMVEninqA0PXt2qP7qPI5xgb+uExP2MjpxjnS4xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812914; c=relaxed/simple;
	bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9gaGZMZUowD9ckpjfCG8TSfrR1R4KzAJqF+Fa2Lbrb2uOC5YWeuZy3OYc4LBWzyZTzD6kJ55SdMZ7IOaJY0Y+PtRl3pQG0U5MDkpkFvRAPIu9wDl2u5Zq+tnGaxrxf7X29zk/7dVLhvpc83I8YgBOibAyApVUFpxMgoKLPFFcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ISN6my; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ISN6my"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so12206645e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812911; cv=none;
        d=google.com; s=arc-20240605;
        b=ftNatrJ7Xfnt4aD0KOpB22wEocJlP5kb1+IwNUZ/cVEzanEhC3u7IJIv7/JmiLN5vT
         gkLwFunZOpjMsZ+kx2/gejh8iqBUGwTEiMQMVO8VRL+WqSQ3nfkutrbf6/a35iIZOhkW
         RRfkxcV65TSnjnnUfnNxEt1pLAxAEqOKggwezCwBzZPm/rNJBj2cH7js40U5Av9vIxpO
         I1fdeob4WluPpb4N2ehwYTaKwocKayb1WoHsYqSEZmhkAKXoH0Hsl9qYmLGuvQTD+RzY
         /ymn/yh4K9lxelFX9a9wVAIl0st++LVMPQbvxyzV8+V1XYH1lbv05GnWYSjX4m2aaa3N
         RYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        fh=yTZ567WWOgynFfflmURMiJq/EpK7wy1ThGG3LMLqU58=;
        b=G7shhNnKIWuCmhr7DfmsDQZ28CAHdWdOuEphLSN9U1l+OESn6divh+t7KTpG//G19L
         Psl3WAaFDE6bUKfEmsp1u3hBJY5P8TnOxZXNHcORY9y4ipbVbX79P3780FpediQmcKZS
         d5Re/eey5UDpi3o/MObdxuo0Wv1UlqRaH9D08Ze0JWiqmSSVO/xXlGC/RHmT2FDOnWOJ
         +5px0Z4ap707alR5x+SLTGxEzUkL4lU7LpawCna5cyFBpIhCrfTVyvvwx+af+vgmto0T
         ZEnyBpWx6If/S6JiNovpRGOjQ1vnpljDQ52tZ7JKE+mqOLpsUpfKH+1gRd3rShkejTJv
         Yhvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812911; x=1777417711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=f8ISN6myN0HouaGClnTTEmtYdTHVXREC81ZsCdvw8OzsjdvhMDCIl/pHWuaWRc6yj7
         s8+QDhNUEOIRUrGGJPo4iXX+fXbI8ejZuYp6PAdrgZ8SCp/e8VyTkRt3kOChA0T7Ri3n
         JaJ4ay+KYNopVNKSHQxonn+n1eNDEjkSMxuvfy1eaDoWgO0tOwIegQO5Hs+UTIznTXMZ
         28iTByKLIpXNg/sfsHODU1wmZbBgJUfNVtH2u3+nU9aFevpzW1MEO6M+O1pJCAv7BqUh
         gkn4OBsbu30PqRPufkTbVSc5qXpWAkm6E3cZU6Gc3LcpcNS2EwMJHtnllscyw9Uwe4GL
         kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812911; x=1777417711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=ndUm3lEnF7INrQwzW0xyavc/H+suuUjeTJGkXh274mu65/04hkRccPH3rtuiwb6xvg
         SgAOJGECbiqY4Wrm2G28MlZmXY84T7QK53/LkBdbSRDUWkvscKXFdVcTaYdttrKS/1BR
         dv8t3jHTKVBLf2wgn5RZJOiZcM89KRm6JzHknDUBTGv2blPInQcb594DrlkomYBov4py
         3HqNVlpW4HvAzkI1FX29LUTy7mIwdEI1PoLooR8ktoG/KxFMRDtFWfz5RcnWyq3VQsQE
         i75byG38bgrqTAJcDvPj5kLqTM+F51XNbcFG8UkhfPq6EY1+yXcQHK8NLw2sLciXWR63
         p7tg==
X-Forwarded-Encrypted: i=1; AFNElJ/amyI+AjxUOV4p057hKdBjjfeDOTyv2VvJqeOzJ+V6BrBr7gx7K7U0TgPXQ/vppvZjdTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEgdwyEo6lKhApLyfwCAbgmuVswDQ5xIEIWQR/4xbBwhkRSBm
	Cu9sJ5urdoPT/e4wyGHqNYYkRIPbLuqyIcYT3ZGbHz1JH+kGb0JceQTd6Y1a1ncA3omRm/a/6HU
	TUfr1oy932aiWcZxvt9mPamY6wAiAtVw=
X-Gm-Gg: AeBDievm42DXZr3VxjVsHohNHuk1F9t6KA3pxxW3yRjbZAXx+XeGV71wvMnC9Y3akFD
	PDF//9VVDQ8aZGSAQHCoV2xeXaAObRi+qKpgQLNR4Nce1BKCZ1NfY8KYo343pOiOWlxxq4crjPX
	F++uxEWLJjmRh140NZ6r7I98bj+VPcwI63SWzU2ypIRW1i/pAmKUAD1ePp6Le+e6FgXeLdXRXDf
	smKzjXh35/51UffaKwttT8EO/nGq8+8fXA6zZAcoFI7qqNV5TmGN8AZcGFaWVvElh5zEAROp7lJ
	pCvh+d2qne/5PcxfRO2e9um+41B8tQcrWeAaGXWocmwS5InRw7O8cwBk0k/qLcSiuDRafau9REc
	JgE3jJk+JVOWqdEPEtpAJbI4i9sSUoQwVjJaX
X-Received: by 2002:a05:600c:a314:b0:48a:58aa:523 with SMTP id
 5b1f17b1804b1-48a58aa059emr27059935e9.31.1776812911066; Tue, 21 Apr 2026
 16:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
 <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com> <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 16:08:19 -0700
X-Gm-Features: AQROBzCAY_2lHhQ1prWwPyLIfmaKNZadZdFGYpecw-J2REDrg4GAqC8BWUzx63I
Message-ID: <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > > It's still Nack.
> > >
> > > Based solely on the diffstat and a quick look, this appears to be an
> > > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > > but they are LSM/audit kfuncs and not core BPF functionality.
> > > Regardless, I want to see how the LSS presentation is received before
> > > worrying about this too much, but your NACK has been noted.
> >
> > Paul,
> >
> > told you countless times LSM cannot touch BPF bits without
> > explicit Ack.
>
> Based on a quick glance it doesn't appear that Fred's patches touch
> BPF bits, they simply supply kfuncs for users to use in their BPF
> programs.
>
> > So, no, you cannot add bpf kfuncs in random places in the kernel
>
> I see plenty of places outside of kernel/bpf that define kfuncs.

We discussed this already.
All those places were explicitly acked by BPF maintainers.

Every time somebody adds a kfunc it breaks safety, because
people don't read or don't understand Documentation/bpf/kfuncs.rst.
kfuncs are not export_symbol.
Object ownership model needs to be thought through.
Calling context needs to be analyzed and so on.
Just because something "works for me" it doesn't mean
that it's safe.
