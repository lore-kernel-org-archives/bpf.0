Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EE25A2A2
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299422; cv=pass; b=kdGM4X+AjDQEQamTKdJmYukaTXiytzqRqfRYuSrf5wMD/IRrSUuwy5hgOBQVGPz7mdo9zyDD7dOVsX/P2fq8YXn9QazppaZeMMxucgs4htBuHiyZgXEpmFWka1sSVhyGDlCEsZkP3muPikDFldRZ69KFnKaqaJtc7v5Z18ivX5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299422; c=relaxed/simple;
	bh=euP2tpJoKvzhWZziOSTmxbCrAVcOgTF5mlBMEaBDnuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoLce6O0HdD7RpIuD94xMVG3EbjfXZxA8h9mYpq8D7s7dML/McTCGPl8bEONqK9LVF4Ltki5MfuoL1/1l341SujhFsqXrjPuCqirAvd4Wfwqe1ETeCDf01megZ+olZ7g0eQdMkirEBX+vrOQ8OCbYh2ge0ovATHIinu88cBVbe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+UumsLh; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+UumsLh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so94548245e9.0
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 07:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299419; cv=none;
        d=google.com; s=arc-20240605;
        b=OqjfIK9x5zIvzu50Z6l6lRcFbiJmoiNbZbgCn92bKujulLLxWsVAiFjt4Q24GAdASd
         WRJewgYrcTAHg6uX2IexasHGHLJzDJs2GtAdtB5QVRCT9ydjq83O8pdYChcxGgD+a2Nl
         1r4QFkwke8ey5mvpuPMpZgOazoQClxVErkXx3mUNQ5hlACE08TCedvlSTeGxuJRaNPWR
         8BAEF/n0k8vSgRY/xCjz/3guAObJEKSzjQlfBPu/ikcK/rqDNJra91mAeil6kF2J6E3l
         2aGN/g0ngMFbLNteUnDnyw4tKF72xca/3gf2yrwxvrI5dOkAfoxA5L/jc3PGFM35xA9a
         2gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xq1YpJhezdngd8ZFI8iCUCPYbZN6mf4M+AleSebns/I=;
        fh=jQXxLkZnyTeLL1+FdX5gTw4PJlPAV0D/q4LbLyUPopU=;
        b=EMlbjcmmCSfQvV1H5OvoCnRlsLnJMdS9tPBNKbtJwf+gubc3ZQGhnbwOyPgv/7M9k0
         AGWTZvLmcYyk/rnBYJF+RnXjNoaTYjrgPQraOjsATo2Ez+N4r3TDreDgI+pp+0uo98aj
         t8DSa6zsktttJMjr3ryAEpwSJBs4SgWbWWAtAGJ7/u3o1bsJ4CLURk8gAqOwhXJxF+mL
         VugVQnwFFH0u2YIlPNhPKvGU6uAkWiFVI1wPmktxOzWg5SU+ddNSrGNH8KTCucaMnmmd
         QVkvG2qohVTyGGdZo1fMK8AIzxoBwUH7UmqLZ9gaMqNcp/2E6qEfzkRd4uimxsL+z5ag
         l4ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299419; x=1777904219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq1YpJhezdngd8ZFI8iCUCPYbZN6mf4M+AleSebns/I=;
        b=Y+UumsLhh4G8JUvjHs/c6aD6WQx39teTxYEdQ/8W3JtP+zFy4ZplH49PvE/GzfT/B0
         S2TWowsCVZDBkqNfGTHXX27pFoAWqUcWh7BIiUrJ7UTZB14TfJ7hRQu0fFPFmpHl+uUO
         qdfnR69Coetsk7IMcOza0lu627NNb9kGrD8v4E4cfZd+LZIrcVYL+A9ufJiBLr1Is5Us
         CwRArEcTcgD/HxFqIvb0pITBXYqIjTAMr07kEjt92lS98iPMSLw+6rY7cuB4yo3kbc3E
         oM9+/0iiJCRM11JQArsTCQTI+hEDxZGoMCXfZvZSiYZcfthpZfzu2glToGfx8WMPpnJC
         ZumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299419; x=1777904219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xq1YpJhezdngd8ZFI8iCUCPYbZN6mf4M+AleSebns/I=;
        b=lzFds6+bkZLgvUhrjAqx5Qp9jYoZgz/4Fj8yhfdYA/SVUHjSz8/SACD8uPGYKbjP/G
         yY0YkLT3OlpvRRie8a1U97AIM4DgJTKAWbEDi9RQrJobZm567NMD54u43RIXfGdawyfq
         LmUkAqS/vi2BYnDm36KbK/8LYZbW5uf88oPF2CCD5KziBHBEl4lr7hJv9tt7WTnDW6IF
         EK2ECmFPi7xp6GVBuQF+ctczFpqzTCjKpJz1/GBZbM9yHLoBUfUIjo+wBl0tYC0/kO7H
         5L02lEYIvQRu43d9BDclFBqVuAPyk/gmRjcCteNBGLLbL5XgW2S1LG+Ktn9uSvFpUhJt
         QoOA==
X-Forwarded-Encrypted: i=1; AFNElJ/PovNzCyF1EprrkTH0IGWN+ZozrC6GyQjAbzhElc3F164E9vLZ35gb05f3d6D/KvUpaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQ9VdB1JchVZmexEXNNGGuqVCmXbF5JybBtSVPnjB46Y3ciaW
	F/8cBvZxqh8QiYr7vRJ3IWGI0OL47P7vkd6RCP0qJhl+Rq06KZEfPDesMcgnL+ljqDjxpeFaexe
	yzED3QLiBR+t9JPSLThCgrpOonMZddNCktxBVuCQ=
X-Gm-Gg: AeBDiesW0ZdX3tw4QWrdC0WFdxjQ0lUQY2tHs1vVHHaZyKJi89GX+ItU04ps4SEkf+J
	NcAKK/BrwIn3ytyddwPsaRGfU2Vx1yF6RgD46QBG9KaAb8MTIGYzkyo5LGtRzhVqo0WKUnAy/JF
	9rfQwYFeuH5h4ht7POZpegsB9of9SYIpuf8qc4LfZVs5jC/J1ov0OT3JNmf89VunwQ5hAk1uU8+
	wUaYVN2MvQKPA1V0J9/hPDS60Crp+/cbALTMDdBJ57u1jVFpe+1e2TMr4A4FAWQrgCHyOgQ57g3
	SuG7vxfWIlBdBkODKp5YaNHCWd32/WYSJjHvob4nb6/v7+AQQrxIo1xb75xDacXfXUkD7iILDul
	s7Hc=
X-Received: by 2002:a05:600c:8a08:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488ff369a1cmr484261625e9.30.1777299419169; Mon, 27 Apr 2026
 07:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
 <ae9uAHH32FDshyLk@krava>
In-Reply-To: <ae9uAHH32FDshyLk@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 15:16:47 +0100
X-Gm-Features: AVHnY4JkmtVl7_bf9zDCccvbYu7MfCg70diYedztRjDNmAfy1DXnTVGQYI6Gm5s
Message-ID: <CAADnVQJnKVONa1D=86kpV1xXq6My4E8QY84AchWwptcMvLNBsg@mail.gmail.com>
Subject: Re: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 3:11=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Apr 27, 2026 at 12:39:33PM +0000, Xavier Brouckaert (xabrouck) wr=
ote:
>
> SNIP
>
> > Suggested fix
> > -------------
> > Gate writable kprobe/uprobe context behind security_locked_down() at
> > the point the verifier permits the store. Two reasonable shapes:
> >
> > (a) In kprobe_prog_is_valid_access() (kernel/trace/bpf_trace.c),
> >     when type =3D=3D BPF_WRITE, call
> >     security_locked_down(LOCKDOWN_BPF_WRITE_USER) and return false
> >     if denied. This reuses the existing reason and matches the
> >     intent ("BPF writing to user state"). One line, adjacent to the
> >     kprobe_write_ctx flag set.
> >
> > (b) Introduce a dedicated LOCKDOWN_BPF_WRITE_REGS reason at
> >     LOCKDOWN_INTEGRITY_MAX scope, for clearer audit messages, and
> >     check it in the same place.
> >
> > Either way the check belongs at verify/load time rather than attach
> > time, so the program is refused outright rather than attaching as a
> > no-op.
> >
> > Orthogonally, a CONFIG_BPF_UPROBE_OVERRIDE knob (mirroring
> > CONFIG_BPF_KPROBE_OVERRIDE for bpf_override_return) would let
> > distributions opt out independent of lockdown.
>
> I guess I can feed this to claude and get the fix right away ;-)
>
> makes sense to me to fix this, since we already have LOCKDOWN_BPF_WRITE_U=
SER
> and changing user space registers is on the same level
>
> I can check and send the patch, if you don't plan to do it yourself

Do NOT. Please ignore all such "reports".
There is nothing to fix.
