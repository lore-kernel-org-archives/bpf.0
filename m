Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EE38DF1;
	Fri, 29 Mar 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730397; cv=none; b=bbGLjfA9vAc+q9VKrhs0MxysmgqSBYTQDJs0YamT1zNCmhNCJycJpavJVrAXneXM52L/c2Ler2zdQpuFtUGheNzQja5IhxseQRq3MboT0c0ED6+YTD3Sk2DupJoyRLLxthqpArciKRorKGDv3fM0mpkzSLAcd/mSgmKaNBp5N88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730397; c=relaxed/simple;
	bh=zrjKAG5A+X97LTcF2yevDZ9RRAsjwxnk84XiaJj9cjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw92UWinbIAONAiNLx3irPtg/PbKsb2OCAbi6QM9OFZC4ZjGeG1eoRthg0NHUQWqIFKKD0L7YNSgRd2BPhUOjSytVyXNWdk6P7SWHYtjh85+hDYynpBF1UwHD97Fp1i0ODE3oICK/vKPs/j07dL+o5SaNVwQ0D5sSW5D6Fo2OP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDiRH8Y3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDiRH8Y3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1257745a12.3;
        Fri, 29 Mar 2024 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711730395; x=1712335195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrjKAG5A+X97LTcF2yevDZ9RRAsjwxnk84XiaJj9cjU=;
        b=JDiRH8Y3H+AIC9hxyEyM/o60CALpDZbjdBbwI+NV4ukqvyvoBzVnuRUouewh66q6zX
         KwiwFJOISktm3bazokpqZgnToMbIgfrst9rxXGF4uVK63R9/0USSRfwop/0RDDluZj1B
         HgEb601oUn/TkPNSUFsMeaVknvpYejeFXkuUdkNNap4vFlhCt1pb+lPKxKsi7nkThGH0
         KkuW7R0K7lCDB2x+gUwstO9SGa6YEJ3nJybnuA957wr8fLF47WmFQ5wFDBHNyAs8y6qp
         JR5lSt/I35p5RqwrInvM6qSkC4FjcJY8t/BBSFb8D7xNMue9n2AkppJFzoHdOg5eVKlm
         wSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711730395; x=1712335195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrjKAG5A+X97LTcF2yevDZ9RRAsjwxnk84XiaJj9cjU=;
        b=ku7fO5pyCAcdJnxX1DoT520VqfA1GDRegBQaoifoS91VRAwjKjlmMID4QT1WNU3UAY
         D39Wk7Wuj2MBY3svQRT+rB5nj5Ph0OsgNXwwE5POljIfpIIAbzEXqhuVeWX31Xii3h4P
         bj2UlTgkSsMoEOVXgvKE34AgBOuO3DoeE7ECh3SnLT4905pYQRmps7HySPZKxKYeDfM/
         XYhr4kMoTabHi5XcVlyHJRYAGzbevIXoHKwUUmlD68nVCo9kR0iXrPc0SeqVqGnLmj9L
         RqFzzn5Hdkec5MfyC+A5bXMCJ8TLpeZb3xKCgJg6hyx2k0//VFwyitGgCwaWMdrZSCef
         mqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlDvukvBCW7UgGeo/EPfTzmNtTvm7Sc6vsr8xAAm2FCv0/fucdu9WYVUseH7a8jbUOrgCeRaurjRk1QATP2H/U/0zLEVgKQeQw7+/Zcji8Lf503eC/Ed/eyjl1QtzjhMIVRNiz5CfB
X-Gm-Message-State: AOJu0Ywa0CLSnkLZBzYcCzEU97CZb72RwFAJC9GRG30rz0JYtQ/jXwf1
	n+gycGzQW0E3tGPZBqUdgKpsfLDbLZFpVLkyBBrpofg0s70CioMViDRHMTw0w0wRlxi/Y7frOxc
	rcTXmLOVOZZaun9qQTkMqQV1RFNu9lAs4
X-Google-Smtp-Source: AGHT+IGImYzKETVAsQrXVy7mjtIU6GpAERQlTqewVY1myTrgmW//0YbWiXOoRNc3ENz/wOarEFRBMV+OIH8MzaLD6+0=
X-Received: by 2002:a17:90a:ba8b:b0:2a2:235e:3e6c with SMTP id
 t11-20020a17090aba8b00b002a2235e3e6cmr276014pjr.25.1711730395231; Fri, 29 Mar
 2024 09:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home> <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
 <20240326150121.68e9db8a@gandalf.local.home>
In-Reply-To: <20240326150121.68e9db8a@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 09:39:43 -0700
Message-ID: <CAEf4BzbMqO-mvyDNLn7iRq2muHWqcOVdGKSGvL3RdOdkJJOR8A@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:58=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 26 Mar 2024 09:16:33 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > It's no different than lockdep. Test boxes should have it enabled, bu=
t
> > > there's no reason to have this enabled in a production system.
> > >
> >
> > I tend to agree with Steven here (which is why I sent this patch as it
> > is), but I'm happy to do it as an opt-out, if Masami insists. Please
> > do let me know if I need to send v2 or this one is actually the one
> > we'll end up using. Thanks!
>
> Masami,
>
> Are you OK with just keeping it set to N.
>
> We could have other options like PROVE_LOCKING enable it.
>

So what's the conclusion, Masami? Should I send another version where
this config is opt-out, or are you ok with keeping it as opt-in as
proposed in this revision?

> -- Steve
