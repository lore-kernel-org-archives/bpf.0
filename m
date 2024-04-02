Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58892F9EC;
	Tue,  2 Apr 2024 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025000; cv=none; b=IFVWrm9W0yWfkqjneVqYCEdChyWOwDIO1qOWZTjONhE+M52joDYZlfP4AUYM49pLQ0Bwt0hCKvneW2XgFuDDRXgrSjNuayLjco8pFXLWVXZqhsSqAIfT0qGe71e8IIJpNE5+EMJUEKQ1hYV5bYirEGDmhT/bfldJhd18uW51dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025000; c=relaxed/simple;
	bh=fgkXjfKDKawDtzfCflGKaza5wBE9VBU5BnB0vo44pJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tz+uaCVmMit9VJDKSujXuKD6qXqAWQ5mx3yBL4w3yGrg2QqOW3yG7OMnyysniMDPIDyGyasfppA/Du60x6zOWQf5+qijgKJBClURlCPf2VJbU9LVAk4EY2uoVTjxUr6pkG8p/XhXU/ZXlayhpCE4Hi6qwIgq1iGrtbQmQ99bRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR4W9BgY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR4W9BgY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so3846938a91.3;
        Mon, 01 Apr 2024 19:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712024999; x=1712629799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgkXjfKDKawDtzfCflGKaza5wBE9VBU5BnB0vo44pJk=;
        b=NR4W9BgYlj+21fdJHp8LMHxkCb8MHd+73b+w3FQ5Kexw1Pe2kO/RpSrKInT5Mldw0h
         06orbqmHSfKpGeKCwiDeA0A3lY2J6t8RMSrdAtrSL1xJERpU3c6KDBfOniWwaD8zoNhO
         rFqK4hnxYR+kM0Spt46x8P7Mxr3m8kZfw1xTwJ+HioWv0OYNxFpTQX4GG2Q87B89Q0nk
         q1FBVnBaO3rvd7l3bitJH2NtDXVDQ2rDd6O7nMf2qAIRKnxG3Z5XgTQqBHF1BbepTndf
         +z05yOEtCZZn7IhdI7IBAJB5EUbq/CmSJs/XBfUO4Cd6oJbATOLZYT4rI0mklCSiRfKX
         Hdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712024999; x=1712629799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgkXjfKDKawDtzfCflGKaza5wBE9VBU5BnB0vo44pJk=;
        b=NtMY4OR1IywFUZjJzMgOK8IgjSZDHmy0vQgFKeA40W34wiGl/UQWqSTQYaUX8RPMfD
         oVQD8Cg/ITI343dTttbQN9dtNNrUba3m0MI2SO9U2ARd0DfUe/no299r8PkJ3UI2Ez5R
         Puh7NAj0nE2y2jB6D6peNerKerbsS0M1I9W0gtcrCAnscbun11X9uUWdPKF2QKeOds7Y
         Yf/VkWYr3cL3E5S1Yq1by5YwzeliodoktnA4gfNLLWYVg8bwlpB/EKIawUDC0aJkfPeq
         Tr8nubTNsMbxY7UT6P9fJG6+nsnqcvqzo4L/ZXX8/texr5/GJJal0kVEYCBnONlReg35
         aCcA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2Vb/qhvtp7MdOmQve7NNG25+PMwbJ8kZnNq0z80oj8XZS3lhZMATZV9mbrG7XEI3e83fyxWx8xGXHTvSifuMZvLNEjU2HP2qKguMMG4GErw0MkgrkhB5vyzrXi3OurrLmie77sC9
X-Gm-Message-State: AOJu0Yzbo4JvBbKdnBfUX4b88cYAEuCKmkAF2yw4xuReNKHiybC/3Ng6
	ZiuRqVFX8dZIKGv9JwLhinB9N+kDOzdalcGE/dni3D6DoQTQBKwbSLwE5vfkxAM2KKG8QGfJ1fv
	DLH2qM/LO06v6rt09v900zwkcYyo5YBXV
X-Google-Smtp-Source: AGHT+IFyp4Gz0xSXbBwlfUC42lKSqqut7l4XNUYN+0BFV2BebxV1g4sLi+yyJma64W5V8b4Jls2fVdvrpqPAnfqI/Ks=
X-Received: by 2002:a17:90b:1c12:b0:2a2:49b7:8e15 with SMTP id
 oc18-20020a17090b1c1200b002a249b78e15mr1832208pjb.16.1712024998687; Mon, 01
 Apr 2024 19:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home> <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
 <20240326150121.68e9db8a@gandalf.local.home> <20240401202552.470d845bd79c841b9158fb56@kernel.org>
 <20240401120918.67cc3191@gandalf.local.home> <20240402093839.7de89341138748f743ae896d@kernel.org>
In-Reply-To: <20240402093839.7de89341138748f743ae896d@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 19:29:46 -0700
Message-ID: <CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 5:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon, 1 Apr 2024 12:09:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 1 Apr 2024 20:25:52 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > Masami,
> > > >
> > > > Are you OK with just keeping it set to N.
> > >
> > > OK, if it is only for the debugging, I'm OK to set N this.
> > >
> > > >
> > > > We could have other options like PROVE_LOCKING enable it.
> > >
> > > Agreed (but it should say this is a debug option)
> >
> > It does say "Validate" which to me is a debug option. What would you
> > suggest?
>
> I think the help message should have "This is for debugging ftrace."
>

Sent v2 with adjusted wording, thanks!

> Thank you,
>
> >
> > -- Steve
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
