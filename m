Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F8202C29
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054017; cv=pass; b=hgEGLTbS2lgRhLIfsJxKVCVn/+c3VDqQV17ECswVubHGDEVcA9K+1KBDRe3LWowSlruKWisOfRixbu1yAgTAZj8Zdr1Xad+9aMhnTX5Y8HasrIZgiCLpVzjG1qJ6CudpQfMynJuQM0SklktggqnEg8bebFdE77N66ALTuS/FY3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054017; c=relaxed/simple;
	bh=GKt4vcoKxRiDc5hKfgsDBKpS+h2PSAqQrw8wYfNmzEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oafa8Ks4g9ug0aqkkccV1l72awL9qzMqbHJ5NteoAMBJUNh141aRDJhp1O1KfBuw517JzMju2imjzAV3aXyEqN6/YxlxmIP0HXS7S3j3fXitVJrPdwMvbF+zUKwv5EmS5W9MNbGW6stOJJ+LgB97+mLfQdDPgIR6Me5al6YXfIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ7upMTW; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ7upMTW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so320927366b.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774054014; cv=none;
        d=google.com; s=arc-20240605;
        b=agO2+pchaBTo+Htd+7wVtI/CyTya91homLrAHyGvqJgpgwF3rpoPQZuYvgOp/UaPzw
         0YBQAvyEaWmAlFDMN9vgTz3c5WjpRYtmf/LdlZYrdW1JjKZptYa89/Q0v44qJLy1jmE3
         uCqXPjlGdBF6aqQDU8UVW/Ipy3/ii5MoSdGTtOW4FnKKVvYrfpF+LVqQlF+Xvua5NxEg
         Fbl32+LRj/d4g4yflJLVLcchUj4spvhUIg9A0nNByxN3AifJHTa9okNYLNTRPi2X8rtJ
         tFGpq1qKumFhgdRMHeNPZLl/zZt1VJl1gk60oqQQqLEQq4riQJ8C6ZGJ192yh4lCyPca
         zX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        fh=J6q5sEJwJ7HL6IdKqaL1eYxdeqzee5st7iHoAHaSA9I=;
        b=Ysq3nc5PpkfL7cOif9vUPfqPRRXyp9qqKYt5YIAgR4R+tbTW8FT5eBevRXbXj3M2kA
         8eyiwQCNLHQIOMZM1N0dqrJH68a9+0L8rBv6p/bRMVJWKE4gFVqJ28cTVSbqkdcwHvsF
         qLgqKwwhQ0o08t8y6iss5AghAbMw4I4G1+VcB+Az7N/kzndlYsqm5EtdrtGeDupjLpMR
         5M/GSDT2rtGaRKMZPQC/tBnjm1et1HI5c/wckmCHSIKWdVGbUZCsb4jQvyhni+z5AXC+
         Id9L2OtaSbCl6zf75cXBvHcllpJ5pg5lFmZvk8eI2cwldmCPUhYp9TedkAaRPLw45zA7
         aBwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774054014; x=1774658814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        b=bZ7upMTWpf4LPiX/qvbpHcHY0ltz70JGoVfzoO4kId9txbpXwFMj5T53rOE+xzgffe
         4J6wXd+50r3oJChMs0UlEOq7xHDqthSfck5P9k3rvPgz1lOn0Pla+fCLdWTuTTu3yKFr
         d3EA2VtToGrGF/xBiBd7T8yylM2Pw8VQGK3Dltx1eneYiDyzOTjkPohVR7xPdmzaMoME
         LjcQIy/9b+erb+56s+pP6BxaOzUn5ta6pkiVMdkrWdmzrlaKuJRAf8GLT8+sXYdvmzZ+
         QdCLw9zUpSAB8jg1wvPDC4jLYrBimfM4gjmcuG4xu2iB1k3S5g+q8q7hKbt6xrDbEAdv
         lp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774054014; x=1774658814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        b=Jv2LkJlfjeIMU3kPDd1dCkf3H1gJQWyDmkYAm8R9SrrlCHOeidBEZkTqnz9QuGl1UX
         /VzjFsvrxA2P2Vf1tTBcVeSwq0bPVA8FXk3qhJXitc7wUjKoXT9ZIpEVUBKimn6SCn+j
         h2mVODmbr1V1BpjmmRLlXn1JYJPD4LE6O5IL0CZ1u2MEP9+mGeSAMqsuveCIp5KUbXjg
         icltDMrJUfI34d3/QyJeW5DzN6VBjAJB+Me1yqIV9f1ztvdjC3kYAjbaTtqenVpPx/4h
         KttbUK0LshZ8ezoxa4QBXMKDTB8JonH1i8atgI4k14Km1+oWFsk3PwOz6bLWJbgcwcV9
         5pOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtcian5owkzZPeAVCY8XoT3n2pX7M8pugVLL7i08MQhP/50XMaP2HhgtF9jkwa+NxFvIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcfNPnv4EyNxxpy7DHS9EmJGWwmKua75cdJ1g0VXyZ3A1xdIm
	tP6B2XeznkwDzgrbNKEKf5fRjgfjhhoh4KtYmMkFU6iWSMQzfyZVpKI7rOzrNbT0/FVxEEvAEJh
	Oe3xUkPKDymuP0FmJvSOC73uCbbGZsbLD+C+oqh5M
X-Gm-Gg: ATEYQzyPM70Yo/li+3bvm75v3DOIdCXw6TCrcnDnvhyLojuE0e/uDrfn8TYsw364cfx
	Wbu3D91NIMY/5yM0EiuySqLNdlkleWQXHeAWtEhLoj8ahhy5kjfcBTitEdjlFO1oV1i3H9IeNeE
	tjqepXwJ9fu7le8okH+P1n1BA0ZMk1QqI+uo9Yzc+7IRwCfz9lSzWhWK63exZOSdWJw6OVLXX97
	bjFXZ+L86cALh3u2AMVnk59a+uxpU3cusDq8OvpqY4A0nU46RBs/nvHcuLTCSR4OmNWNZNGxMTO
	rqjluzzpz7S7Bhu+CE0AfHtdjW/JDjOP8UpJWrrA
X-Received: by 2002:a17:907:a807:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b982f4faea3mr346138266b.53.1774054013710; Fri, 20 Mar 2026
 17:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com> <20260320160055.4114055-3-wusamuel@google.com>
 <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 20 Mar 2026 17:46:41 -0700
X-Gm-Features: AaiRm52uidG_JN_iNt0QjtWA1eFaeRgUfs2_72YgoC__7LmSq2GydHxOq1wRUZM
Message-ID: <CAG2Kctqw-11W3fDudVdxmf9G8k2TSFq-iidZUGKPDmCp0Sq=vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: Add config flag to gate sysfs wakeup_sources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	memxor@gmail.com, bpf@vger.kernel.org, kernel-team@android.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 9:09=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>

[ ... ]

> >
> > +config PM_WAKEUP_STATS_SYSFS
> > +       bool "Sysfs wakeup statistics"
> > +       depends on PM_SLEEP
> > +       default y
> > +       help
> > +         Enable this for wakeup statistics in sysfs under /sys/class/w=
akeup/
> > +
> > +         Disabling this option eliminates the work of creating the wak=
eup
> > +         sources and each of their attributes in sysfs. Depending on t=
he
> > +         number of wakeup sources, this can also have a non-negligible=
 memory
> > +         impact. Regardless of this config option's value, wakeup stat=
istics
> > +         are still available via debugfs and BPF.
>
> Well, except that otherwise it may be hard to figure out which device
> the given wakeup source belongs to, so I'd rather not do that.
>

Since the config flag defaults to yes, this wouldn't affect current
users right? And then the idea is that other users who don't need this
sysfs node can turn the flag off to save some cycles and memory.

[ ... ]
