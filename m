Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9532ED38
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135970; cv=pass; b=io1aCFHpyTs9Yud8R2hbhHDSaRv+S/yZSdfthvbg/SGAJx1gjPnga9D6lsFY5wjRkNhheiDDxHyRvnwirTZlNcYB6GI4XObhc5pdo7LtUxQkvGNaZsEVhYQhM56vzjoTkyxsfmALvJEPCYPRRbE/t60dlgNr20T2shmexEW/JXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135970; c=relaxed/simple;
	bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZSBLe3bts3XpN4eMUc637CEcGs+RPv8uJhufK6ABJdyPAEBXLMMEnKSMno9qC9zGIXh3IuY5dis1XPrN3VRsAXSPzTx2ZrRZz2JB8EyjOV1lErlh65Vp9O6K4L9YKw033GGXmRL0QnjhsZolfkjTxNfD+lFXgNjiww4orDBYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8v2Zedg; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8v2Zedg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3530715386cso1687153a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769135959; cv=none;
        d=google.com; s=arc-20240605;
        b=hNjyK1njS+Uy3PLpJ5RT/sH89vw66CqDldhTt5MpfohOQnIN6DU9gibMp5L5TEyj6O
         vC5CHwLnYxy8uxVd42u88bp1M5IIEdTVb6y4HKARZ8tTRkaqgo3DjmkR3OVRSZSulV5V
         ncv6D22C2u3PU2SEe7uxp9q71OnGfYVD18L54RjzNLS1aHYyM56PWj4PyeLb6OQ4KjBb
         UOPEAf5CQbGbLV1bZpfFQzhHE+EE69sOknO1kfx3K6qbYUlMLhpATo8xi46tgebc0YG3
         5bi+Kznqv4zAOgF7Dk+cBVuRE9KnY/eiJZ6R3O3s8C8N0dYhaqNlZzp4GMdX1XmgkoFM
         OXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        fh=sWGVTpHPFXbGErV7ZfNAtvFh1dXpQsoSImcPyhBgjC0=;
        b=kasCSIVhxGHuh2hvNit5LBLFNPT7IcxHlWZpfvlmCwqneZF1zfZLtdwLVmQQNx0Qbx
         gqt8shZsMJgU47xs/7Lq7aFeKHbaJ9TmU8artaB+tQJrc2sH3JXiD2cR85d94mRaxhDk
         5gXyTHaNtJ1kSmheZ9gL0Ei+IX5C7wq/ZVrV4RkGCLvgQf+jiusFJxXHmFOJRrMvpGDI
         WwWkhjOVjlC4ofoRpRRkrHO3oxEQJ2H0BuzkF/ZVUEwJyvcSPHsHTNWlyeDcJldUmN32
         XH01wKq8GK4Eh/Dacr2fxxRdtgd2bYpGdO774fB27+xfAnseL15Fc1PwBpKP2Qve89h1
         L6ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769135959; x=1769740759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=I8v2Zedgw4jpN7rWa/wxZ5lSKgncvp/c2tGHB5oayIw2Jir2n6HijDzUeaZatg3dry
         74zKOxDEger65D9PfEvo8WVzvHS5qITyxcYM7zbifKxEBqKKIsHwN/FH0FhGeMtSxqT+
         EYCtaX+bNCDzml4wckFzmtu+WvhF008yFXP4skx5IgI11JrulmYqTeCT61CRq/QBOt1Z
         KbgWeogB4Uy2Z/rOSq2ugxRqxtgB4LRumVtQfZjWJTwGRiGgwLKWK4ybhx+vNOvzu7bO
         +xKGZnzOCRKt7Oq3GFIC0u81b2ooU9JwBZc86cxmJNNX0910naWlT7xsUHWha8yzEKt3
         HQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135959; x=1769740759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=xLhzVEo8Kr/0aoGVpXN6nAw191U8Z5771nzTZvcGfpKwJX5+A82s+SnmdVyyDQMvvq
         wXpJODDdjXyrevGfo4r7vVYrMxJOsSaAH1ZvQ6J560TIbRlr1oTq04XErq+GD4JymNm9
         oucXFYXRwrUgF5u51DuRyNGdnj+9gE+m38yuDNarDtBemmTJsgjIrfn431V+5W4uMzOM
         +NTUVusKqlSkJp7vsUL68jpxttmcUrSJSE2ONuxzcVrt6h1iAxqgukVkJVdOxy3sNs7o
         s4o6yVTTeA5tQBIrpKpDcmcZNI/ZvfWvT0BDyUVenkOB1od61OT7jAcwZFnn5+9DQBEt
         WDcw==
X-Gm-Message-State: AOJu0YyT+xcILAne3m0jO929FDs8ysxWREcd24DGnNLKVb7zwHtk1ri1
	5tImW/CtARsnqiTh1AIgGnnOAcrrZ35ncwFxDNx6ehT/y1h9P1hRCIEyawg/WNVfetQkBxw0P+v
	KqJiN2nnzZjHs25k6UfqJDQx1lUFKbTfI34vA9vgASEdEkdcPCU6how==
X-Gm-Gg: AZuq6aISqu0ENNQebq41qrJj1AQNq2emQ4flPdmCH6d0t4hQFMqkCvN5Cp/gXjYX1T7
	s2ebEcebl8Vz1YfNzoJRWL1MF6O6zsYU8rpAwa+Kbw3lWriZDN1vFPy9AwMfnsgjM8bf8N1d+p6
	c3NLRFHsQX9qXWWZJyTOSdn4189PBVvnwff8JolBRqogef5nRhWeGaFnU8nP9DEU5c7199S4Ed1
	9r+MRPna+eytCbZAhb6wzHZsBHxKo4O2Gh04zP7ZPIWIxuiSU0fijN3rtUS8d3bvh1Mm0Q=
X-Received: by 2002:a17:90a:d403:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-35367024a1bmr1261929a91.16.1769135959102; Thu, 22 Jan 2026
 18:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com> <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
In-Reply-To: <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 21:39:07 -0500
X-Gm-Features: AZwV_Qiuw-WOvpplG3_3YRv6P3Gqf8NRc7bLKC5WTsb9MkYny2ZAcVsltSt3mLs
Message-ID: <CAHC9VhR0F7rp=ne3BWPtuu_KjUao03iYoHuNsQdYgWygg0DBkg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 6:15=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Thu, Jan 22, 2026 at 9:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:

...

> This issue has been bothering us for quite some time. Therefore, I
> don't mind spending more than necessary effort to get it fixed
> sooner.

Help on identifying and correcting any deficiencies in the LSM mount
hooks is definitely welcome.

--=20
paul-moore.com
