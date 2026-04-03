Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753AC3BED24
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226388; cv=pass; b=q3h0kBtK/O9Y14l2Fdo9UzwQNLKmT/m6QwzK3LM6Yh1NqczEgQOjZGwYpVt2BXxJd2PwB94H5+RbbPHWxZ6kmMuWjlVPkpbh9//DEyBTL71LeKSpKyNWED5uvhDZHLS8UYleIQof9yYsqezSIaXPQXZyyZk+PkdAxPsBkLvq3xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226388; c=relaxed/simple;
	bh=aTlV4pdjF0A3x3G2ruVJgTbo99ALv2Bdf7K5KuSGaA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjlqSPAeS+OGDbA2Vu4A/PMFjxSWEE+mZ3biuFfBN92Mxt1Fy22iLhJjlVBLOI40usPVvYwIcH+d9eZ9rrwWj0pV7016tm1UlHUG2ePbIfrnMPaBLLGB5qZJrOJTZdag0KMnGwDJY+XNmQgqd1tmJBgQCoFBA9T2DDtK5vHrYrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyWNstTk; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyWNstTk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2095312f8f.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775226386; cv=none;
        d=google.com; s=arc-20240605;
        b=d/Fe01ERgAk13R7kAOB8fgvgl8k1sHfPNA1uKp8fGyG/WqhMxdSSeYkLkXN5EmIeeK
         GYkljHJzZ4Kiv36QfwzIhILHnf8I88/eEW8JRg+I0LwpDvn3qoG2bU+RXzEFjchuSZAd
         Uf6R2YppFySfKDDqP9IItPLprWWUiUHthfgFa42U/fNn07Y03IsaqjTaC6Aqt5/+7/nM
         aQkGEYjwJYa6A/k2FpIZ4MB9Is6iZXYjVZa3k1Q9UqU6HSedOXlzMEd00EJhHldyMjOB
         ROGE0CQ/vPDDprOo2kJzR8T6D9uVk0xRX2lVWp7rX5BVcxy4H+gW3FI8VCxxI8/V9cyp
         29Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        fh=f110VBG+LovWrrSxe6HZUUcQghyf9mdEjHR76tz8YJk=;
        b=bX7jeMRElg04ZHvxbusRayilhxAT1LuUBlcQB2RjlT/rcCnjWb2uIawR7OdVOkhYZu
         VClklK0pVKQEdWeu65+uIGBjwmKj+N53KuUMpJaTg7qqkBsvIdB7oo/Vju7P6lvo1jv9
         MTs63gBFZ4sqeHJZ4A1f4vBDkT3yN9ryNoAinOD7w5o5jPBMP3IGM67YO2uRKPLQQRDC
         JIdXxatb5F7xpWZ/5D827VVyR7xMc0TX0vDUKbevchxGUEd0cktrFd/O04eZxA3jo3ED
         b4husqC53VZMAuJ/b3pulLkrkczD5cfxAV22dZZ8FmADOmHqq4QEBgkbIXV8Vaj8p69E
         zRIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226386; x=1775831186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        b=TyWNstTket7k93kf2CSUZNM3DacCpy86gyKAGSleu8FB3WkuZ8QpXceC3hGg+tZOv/
         pTMNrv2ld/xq6G9W7jDoLNvc/e5DHI2eZj+8wtFXF9o+49AdYy9TdHxHamlvUhtMT5dg
         K3F96DNamKnOjz7Jqpydy7AZtQJc6x7BdyL0JbFpY01mnNfSN10Ron3HEr6rVVr/c1lk
         G1jGdKOMByI2giCQUaVPrNw1s8KvwTdNWhgUK/puHhk8QpIgbWKI39LXTpfFtT1L3ucv
         CE0lGHMbkb5TS6fdnkmyUZecsP+lwS6qb0otlp4T4t4c5bXtGtJ+QsVYLnxd1hduiaLR
         K2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226386; x=1775831186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        b=pvBn5FS+3HgqHNRtfWeLzEywIn0oa2NfifI3pMaMSYg8OB7nIkAoX6stirhMjZmXIT
         b4RRXmwhOKA/5J6ma5vZLHjZubNxmv8WsAfQn0hynX+xDpbvj+7xST4Bc4SJFxrvJdxN
         Gcb7ix7TmXR7h6LXoSnYwzUQXR7WujSf/U+ySe6tau/Gsa4r+nYLGs4VC89iq9cq+XTS
         g060Cs5svvqRZb4tMcziOyZG+jgEfdgt2Ghiu99ZxoMXv0nnCC5Q9+q0JO7rsXntlYVw
         xA2R2Ux93FbBDbgISKmwr8yzMKYGyFj/GVJ3INnPNVeCGW3rrix5mozgo7hmzjwTAm6o
         mTUA==
X-Forwarded-Encrypted: i=1; AJvYcCXuvGHyGyif1ZoqMn7fIql4toURC9KnBd3QEUC8pDXj8ue6DoXDJ/ciZWS1E/qg9hlI5pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTs6io+69V5c6CtP5UpFkgImBi/KVQZ62ZCYiGNe1B7hU9n/Fu
	9Wc9ZdqtLdt3Gxk7ZCPTwMOeSJX7qavsOaqly9BTASqwE/29QBKSzT6DdLYagVdL99Apf1xMjLC
	Dxrzhw36zDrAP+qqZJPbLkbY9rB7lgJQ=
X-Gm-Gg: AeBDieu5AthOziSflIAldrz2IrdQdAAS1q+8BSR1B40LZfAK3U4weZEmzRBvoGVeO/2
	/ADjgw8H/T7ZyFA+G/Wrw2LPl2PaS0JnZiCLbuATWKODu+DaLfn/OShBBZ32E0a/WbMJ0ivNwU6
	EDvs+Tzvb8LdycsgPlmvge55DaKJDkG4SNbzv5rqVmUn8t5AwXJDFElm+z5kbo8OlSs94lhLOAb
	/1M+Fj+gGrnmkRMBIYzwEte+bo0QGn5/agBmPMKKMd4yFk+P5sS6tllaJXyrmLKeV5iwcWx0tEN
	/fGmY5dk9fqoII1vVjcabAHrJvuAbZ81WSzdhfOFadhA00qBt3SjjnVznO7Gvir67oa78cfeZTT
	dT01V0z4LWX+84cKO7FGQeL+1ug==
X-Received: by 2002:a05:6000:25c1:b0:43c:ffd8:e25a with SMTP id
 ffacd0b85a97d-43d2115ae92mr12434422f8f.5.1775226385615; Fri, 03 Apr 2026
 07:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
 <3036842.e9J7NaK4W3@7940hx> <20260403073055.031275d9@gandalf.local.home> <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com>
In-Reply-To: <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 07:26:14 -0700
X-Gm-Features: AQROBzDV9yg9kswgmI7b9-0JLFkgfn3BK6Co2WBzJ6xPcvBEERBNPVdO--RgW8g
Message-ID: <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 6:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> >
> > If this were to go in, I say it would require both a kernel config, wit=
h
> > a big warning about this being a security hole, and a kernel command li=
ne
> > option to enable it, so that people don't accidentally have it enabled =
in
> > their config.
> >
> > The command line should be something like:
> >
> >   allow_bpf_to_rootkit_functions
>
> The feature is currently gated by CONFIG_KPROBE_OVERRIDE_KLP_FUNC. In
> the next revision, I will rename this to
> CONFIG_ALLOW_BPF_TO_ROOTKIT_FUNCS and introduce a corresponding kernel
> command-line parameter, allow_bpf_to_rootkit_functions, to control
> it.

No. Even with extra config this is not ok.
