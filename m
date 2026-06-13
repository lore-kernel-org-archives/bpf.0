Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6038F63D
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781322205; cv=pass; b=ORBDMcv5X2eDKn961kFZb5QFpCaXHBPtC4BP0cIdq/Ma09oDhVby88LsUzXA0b+8dFc648d8klF+rnpM8KBDIWANnMO6LW6srFo+NAuKOG3pKmPBgMfXvvqqIn0oFMORQEIHsbNYSKqVslXJ53kaylmFIFiWs2yDfvB0X3yLQZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781322205; c=relaxed/simple;
	bh=6g1VC+dw6fAg19W4wJnrVzOTNCJQ03941hAWJbJIOys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePhTnUTldrFOpJ6EBG9zOSMFlLpY+m4THA7mjBPUe74SfASquC433X97NrtWXimn1QYEp3zCG1RduSPekY3gxXNZStGON3++YHV7ux1NX9pciFvY1WnpaJzyXRpzuOsQnpYzr1OVoGzLGdnKebWCYLoemUb6lByR+Ku0pjToJIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2EKWwZt; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2EKWwZt"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bef47b1ac01so223678266b.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 20:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781322202; cv=none;
        d=google.com; s=arc-20240605;
        b=VI+weK0sYSq8VjWY6IWdYbEPBbAQHqihRp4aOkj8xFU0VD3cbxCUuZdp5m25YBiTAy
         zmgT0cZYEsnuShvO0sspihO25OJXJY4KwyMLSeKTD1VTwYROJKAA8IrNiH8RV9r/aM4E
         F9dj9JJOmy4zk9BfDPKSXSf/COP7ZoBoICPsXaTSvEcBpNNtnTreAURhnN3YcmgZqY09
         M4rFGOv013BftT2qKSXoAzAjy5hWlqEQqxhNugQnawUFwJqoRhAraIUabMCdTfimqqbQ
         PKRs/voZ1692NaYeYmjSSq7eCAr0OQKJLsu8mEWdVjlt4/bOY+tc4CfwBk8VWvpByQhC
         czug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        fh=SyIGEUOhyFU41Gmf/oaS1x9aa68g5H7P8kDt8vfgofM=;
        b=if9dsM8R6BHQgz8w8gofGmCWuPuaBsDQ3+L0aI8Smf54T2zWy47bqrfsfxrrDnlCmA
         Dthpw/Uc+2QPsz2dxhPv9bxlttSxzv2O2apmeDb4A7pFFk+3C+CUuhpNNSCDcxtvd+VE
         7MMQ0sJt1S2oshkIQBC8eAYeRAAXDHmM22h16x4zUcUhHxrUuO2VyVOfSBAH0B9EZ9A8
         cNnu3XG8ETdi237jRqj2rN/h6zedw14k384bM9bPELQvm28pZLXNz7CClR5D5BRJ8GLU
         2e3b27CQe26NiC9fjteUqGKESIutm+3y9jAflW8iHb0qDwFEi6tnrGPXBDz1u74nvkzn
         FThw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781322202; x=1781927002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        b=h2EKWwZtioOtxU+BIz/baaueY/flSUeVcaBL8r4iVHIoSNOqc3pw9gFXNDE+iE2NyW
         i3+mHtE/FQU/UbJrkvKU99SirVqb7Ac0OcHnKeUWx1MyX348avrNP27xNS8JLwjvxC+R
         dYVWeJX4KHbVUY/V2oM4diw0a0pGXltYnkeBtwBHivneSiJQ6uHC+g+o6wRYD7z6bb4Q
         XNtL1DvoZ9W9mC6H/qLyaHi9CtYdUb3wCMR9TPLHObir/2kEb9YDPd3i6VsrIWyoqh9I
         IGg1uSIs8JxeUGSxWn0TsRl7d2V7vBf36EOOrlUyarQ/yb43cPVt97cOtVa6QGSx7ekU
         MXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781322202; x=1781927002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        b=Q/rJrvZJp6vbvpjTMUhDG2/Q2P6jd7/t9IqAOOQYj/+uInG+HmwselvVMuPWbBD1O7
         WHaqtJN1N3Y3goFjw9kgNAp0CwKN7XiuQYZGsCOEJtOcdmveAb3Rhws1o5mU9PnbhlKt
         Eryakxg/M6xKT3+roQq6fTGN6NuYv7kX5UKOLCj0DF3kQbA/0ObEnJad4v6TuPo+w8TD
         MFgcYfMYR1A1IKP/WjJTgpArRWX6TqOrR0hvkRnG+b4anSQKMVIsk9C5MJ77KwsgD+lD
         kSmfPYqtWePVImOdOy4//CDbN4fYheAcSDDEnFeFNmBW/QFnsT942FbBYtwqqdQct70J
         ++1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/wI3gAgNqoYxYIP8/WKA2sWmXZnOQr1eAM6sOPbRMAKnETO6+Nsg/kX8pQcu1k+g6qPCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmOxLJMCIRqVL4kcig+G3OEG7G2jo6H4ahjldd6jesHHqFFfa
	bdyPOhXAPccjukAQso2BLCrquMScqUXk3ftksw0Mtir4D4TBh9mUrvfMvp5vr3h6RMqz9/2eXaB
	o3xxKWgOBxZuq0SU9s81qNXubAZudT/meDIRxi+U4
X-Gm-Gg: Acq92OGCsbRwiDOtdjj+iTw+s+uya2vw21QUb0RjAY9KCiCFyuEsqQdR4y4oNZ+7QQC
	HpNN8wgeipSa8UawDjaWLh65Ouh1SzD66uCF5iunktggvK4jOTeKx7D5rq+UMvnv3IDKmexEjFz
	Df38DEsm1FXai2OIUKZMaGI5ZKgZ8lXNPBfgelcQdP8q5r+WvYoPY/cpeq4fvCXK8B++2ew3E6m
	q6CpQNQv0tFqwh/sDtp8CTyB0wiEJGX88C2wrKWeENL9wh2MEWj4deSzLO4i494PV8Mjr74lUCu
	539gxjEYWme4hiUu+9xcGezXdPnqgezlo/1A8gu4xr/q0RflKNmsrm0HmLNo0bAtdbBktNvVqI+
	hE4OOkosCgTQagnD0oqGttFFAFOTqWuEUcDmWdXQWHeTV37b0RA1kgcMqBaQC/Ik=
X-Received: by 2002:a17:907:8b92:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bfe2a217e07mr217607466b.24.1781322201586; Fri, 12 Jun 2026
 20:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613010039.1362312-2-kuniyu@google.com>
 <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
In-Reply-To: <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 20:43:07 -0700
X-Gm-Features: AVVi8CdubgUn6NuoVme7O0oFJFs08u5cj-F7wrSgd6J27XwpuOhByoTjw26cSpY
Message-ID: <CAAVpQUAP+d6yCmPSdYyQ9UYB1ZcNkQCCHLDqNp+0Rh3bGXdRTg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 1/5] ethtool: Introduce
 ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 7:30=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 06/13, Kuniyuki Iwashima wrote:
> > Before enabling SO_TIMESTAMPING, applications typically try to
> > enable hardware timestamping on network interfaces via SIOCSHWTSTAMP
> > (or ETHTOOL_MSG_TSCONFIG_SET).
> >
> > The timestamping capability on an interface can be checked via
> > ETHTOOL_MSG_TSINFO_GET:
> >
> >   # ethtool -T eth0
> >   Time stamping parameters for eth0:
> >   Capabilities:
> >       hardware-transmit
> >       software-transmit
> >       hardware-receive
> >       software-receive
> >       software-system-clock
> >       hardware-raw-clock
> >   PTP Hardware Clock: none
> >   Hardware Transmit Timestamp Modes:
> >       off
> >       on
> >   Hardware Receive Filter Modes:
> >       none
> >       all
> >
> > These operations rely on the driver implementing two callbacks,
> > dev->netdev_ops->ndo_hwtstamp_{get,set}().
> >
> > However, among all virtual network interfaces, only bond and
> > macvlan currently implement them.
> >
> > As a result, most virtual interfaces cannot advertise the
> > capabilities of their underlying devices:
> >
> >   # ip link add ipvl0 link eth0 type ipvlan mode l2 bridge
> >   # ethtool -T ipvl0
> >   Time stamping parameters for ipvl0:
> >   Capabilities:
> >       software-receive
> >       software-system-clock
> >   PTP Hardware Clock: none
> >   Hardware Transmit Timestamp Modes: none
> >   Hardware Receive Filter Modes: none
> >
> > While these callbacks could be implemented in each virtual
> > interface, this approach is limited to those directly linked
> > to a physical device.
> >
> > Not all virtual interfaces are tied to real hardware; for
> > instance, packets from UDP tunnel devices eventually pass
> > through physical devices and can be hardware-timestamped there.
> >
> > Let's allow configuring the hardware timestamping capability on
> > virtual interfaces via ETHTOOL_MSG_TSINFO_SET.
>
> I don't have a lot of state on this, but when adding xdp hw timestamping
> I remember fighting a lot with those apis. Now we are adding another
> one, but (seemingly?) for sw devices. Can you explain a bit more about
> why can't existing SIOCGHWTSTAMP (or ETHTOOL_MSG_TSCONFIG_SET) fallback
> to your new dev->tsinfo.enabled codepaths for the devices that
> don't implement the ops?

Simply because we mainly need this for ipvlan and geneve
so limited the condition to cover such sw devices only.

If needed, we can loosen the limitation and support sw devices
 w/ ops (bonding/macvlan) and even hw devices too.
