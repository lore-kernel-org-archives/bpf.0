Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C13659EE
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565383; cv=pass; b=fx+pBrLF3/6x0ecHvF/BcX9J0AvctJlxGYmZvIis75+/n1KyZZtCU7Q9SvZfP3tzVPBkI3cgAPehGWlDqu1ABuKXPm22jUHcPmjyY4SsTv1WdnxkKUHTATOK3q9qwZ7AxfFTyyo6ABXGQS4OYa06kL8xTzMdJvsqqkc0vTS4H58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565383; c=relaxed/simple;
	bh=Q+F6ZnbMmyxBOFD5itAiiyZCrJUukfh/u+OOWnGnTTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcxwJrNbhFAgKKWuupifcqp2TpLGhs/ypTzxWBuYgtNLg60pMXKPm0NlfNEYl1nZ8S/bvyGZq5frId1GNkVIGYzp2lkWHt5gpz1SHVC2A4nyhJcdQAL4uju2vmBXMfo6U4yTs6xI5tI4hjomFW3absZzPptEVX8OAL4dV+iSJTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsxbwyvw; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsxbwyvw"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8710c9cddbso255289866b.2
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 07:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770565381; cv=none;
        d=google.com; s=arc-20240605;
        b=jHbKUAFnBFi9eVG6t8s8n3hGcygQkokwf8YJYy/Zt9WFg7bjyQRDU/uWntN1t+NtMR
         bi2PeDA9enrwzbG1tJdolsB7fsIEA3MHDFeXGu+X7vC+oTKkvFYX+lXAJlqtvOFK3vJO
         55E+dLA6WtZJaU01hyT2tcfNGsmEgySVbYa/RAGnzy5MekTuXqFddn8MkcxDzfVCPy7u
         btEoap1Ku8UE+xEQ/SIqCBKW7Xn2RF4Tb6kRNf1iLd6wxP7ppKNGmXgErQH60U0g8Qc5
         Wndf9KSDpQBUB8qioMoOfsKPfXp3hNTWM5PwHqw8jV8Rn2k4R7bkfyJvpImIRvl4Rl6C
         DCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        fh=W5UT0SctlxSGCMfsdj5ateH7tEwdKkKclfsIgxO91pQ=;
        b=GjSxpsS975ne1l+EgSXaYZ+BE7Hm+p2ZFEu+D30h+2njoFjA6uPXaqhONrfbN5Ebto
         hoMSGKNe+sg8H8DVqzsqUsUil9WKBXQ2EAGvss9L2IhVT6kCCC2sDXJzRsQGD5TzINFN
         D8MDWD3/GwkNKi39Z1AlelsdH/hKMKRd7K7WXx3HJiXn0dd9/gnjVQb3wHKlvZyIz3AC
         8ATzHbEKfh2WnpqRbbPpiUx098ggwg4FSZ+XT9za2ZqrZ5nFUCiHFS3EoMFyP8k4GsFk
         Mz4AVD38KpTtQCzkbMIlnEGoE+WLuHfOLONaKNTnMIZejWsE4Bu2kmNpOzZrZNBWIWK4
         I8Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770565381; x=1771170181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        b=jsxbwyvw1rZv7Z+KWzMle6QnJgW+Y7TiHAAdU3vsEITGJMK2usWsMA7MsiriAXRyyK
         AbSa44oCD0p1yYS64iETL7xQ29Y4SW3x6a4iOPs/q2oT4qjw4LIUHzHbMfl15qthG4a0
         diiUYHE/q1bKxzSIGFKyixCczQ1rhUuy8lv8bgkSm4ttErC1qebxwoKuy0pdggws/uo0
         P8VBb/wZ6VwZ+pRw68vdSw8NBHMN5HaRzX5Sf6QjOsvUElgApanj7SSr25N6+wGPyyP7
         kS7TYTC2Cu3E8XqLJDicxD0mpIPKAAT9frko4eu+/7nOsc6+KsJbJdWJT0GJsz7wqW8+
         nzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770565381; x=1771170181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        b=YGorhNsgk8q/GXTk5CgG153UZ9d3N1XAQZ1SGQiRKkrYD+AZt+Pggeaq6gpV7jNE+p
         BHghqQPLxNM0rW1nXXZ8IXq7FKtk7WaVUxtIasu5s36zidBwXaZfoUbJzD/oS8G2uXNS
         8dsKfdMMIVAigs9X6HVCKehdqFy5wip25oj9ro6K5Sh1zQs5w0W1i9BjECoNX81AfAWA
         lncDNlvlZsKCg4XF0RZt5A9uvXj1w7JkH1MxmAWGCniDu2mKmmn0LBeDjoboVGh9MH0A
         Wd2g1SewTu6FSj8oFAqswoV1bZ7DQrCdt10mTq/nRmUIO2ToaCwVsxbCFyXGwfrDK7r2
         dcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN7i/eiHLWsHHVxUUc/hW1An2nLHQfTuJkecG2ZY8hhjgm/iAu/d+yZRkh2ybx03n+tPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XFfsOxuStUcPOYVU96Tg0Wc673o7EyvAvrXwBe4hOpcnftUJ
	9pT/PfarppQ5sAOlTrlTmQJeVEG0wDurIi88fTLQQJ5eB287dDrlRLAY9ebnbBXWeSAx9gjX79L
	B+4mueQczh7vzvhMLHjcTt6z6sqT9VLs=
X-Gm-Gg: AZuq6aL09CWL0eDpCl0FLr4mNjxgI5aYNG5jz3mOXJocHjZz5wAUytlQu6WMlKTIGoW
	fm16L9HYOZEKqrZo7L6We+FEr1BWV5gxwGp5fDlNNOBvdRPMfMx6sJ+s4SXuaZ1xd8/Z8DTd+n9
	sAlmhyIVHFeuA1Hp1NWWriWcJgOcoknMU6pbiBDhn3V27VdY2B/FAS7EHM7DMCJBwIokZjBIR18
	okw75bwnotGTS92iaCNZvtbZD5fYqEg2wcTAlKPSBUhUa0tZkLb2V3itlmcmYvgs7QlvpEQ
X-Received: by 2002:a17:906:2099:b0:b8f:ad6:db92 with SMTP id
 a640c23a62f3a-b8f0ad71129mr167531866b.3.1770565381035; Sun, 08 Feb 2026
 07:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
 <20260205130459.0ff532f3@robin> <CAErzpmsajhJ45TkPx_TPwAPwN1fxO0cNYFTKFgLaosiPMo9wew@mail.gmail.com>
 <20260208102742.2169de7a@robin>
In-Reply-To: <20260208102742.2169de7a@robin>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 8 Feb 2026 23:42:50 +0800
X-Gm-Features: AZwV_Qii4imxiiZs7X2NlajFjW5GfNHC0Ibaxr6tql3hlmmhExTi6pc6g9KtnNg
Message-ID: <CAErzpmu3XGE=LKQjGgb_538BV=hytkv4rsE_M2r6ADEkB_Ckkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 11:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 8 Feb 2026 21:07:37 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> > Hi Steve,
> >
> > I noticed that trace-cmd 3.4 introduced a new feature:
> >
> > - Add support for showing parent functions in function graph
> >
> >   If the "funcgraph-retaddr" option is set during function graph tracin=
g,
> >   the parent functions will now be displayed:
> >
> >   preempt_count_add(val=3D65536); /* <-irq_enter_rcu */ (ret=3D0x10001)
> >
> > However, it currently only prints the caller's entry point. I suggest
> > enhancing this to include the **offset within the caller** as well. Thi=
s
> > would allow tools like `faddr2line` to locate the exact call site accur=
ately.
>
> Yeah, it makes sense to always show the offset of where it was called.
> We can add that for 3.4.1.

Thanks, I can send a patch to implement it.

>
> >
> > I implemented a tool named FuncGraph[1] to convert function_graph
> > ftrace output into an interactive HTML file. It leverages fastfaddr2lin=
e
> > to map return addresses (e.g., __sys_bpf+0x51/0x500) to their
> > corresponding call sites, such as: __sys_bpfat kernel/bpf/syscall.c:611=
5.
> >
> > What do you think?
>
> Sounds cool. Is this the vibe coding thing you talked about on Linked-In?

Yes. The project repository includes a sample HTML file (`sample.html`)
demonstrating the functionality =E2=80=94 feel free to try it out.

I hope future versions of `trace-cmd` or `Kernelshark` could incorporate
similar features to enhance trace analysis workflows.

>
> -- Steve
>
> >
> > Thanks,
> > Donglin
> >
> > [1] https://github.com/pengdonglin137/FuncGraph
> >
> > >
> > > -- Steve
> > >
> > >
> > >
> > > [1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/=
?h=3Dtrace-cmd-v3.4
>
