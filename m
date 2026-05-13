Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCD4DA55D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685382; cv=pass; b=Sbv9fhgmvdN8u8TC5vfNJH/FzmOMQh+gdgaqqWDVn0mCFZK7sAk8z5QbAvrdAnC95zXBw4VukBMJKxEF4j+YN53JtGAI9yaxx6K16UgcVlJ7ZXUYahj5RYobd4lIwxiFbSUlx3pqDoJ/7OxVIWTSyBqyE5L9UMMPbpP8yDbT7iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685382; c=relaxed/simple;
	bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjX0rREoVF2jmEnMjL25lZNnngN8+5P/wCkCPIYvZtwTkzFbTYKfMEItWukTOdkJ3EJJXqQl2Ic/+ExFG7CNkKnDWC+7CdokDpz76U3Ea/eQgF/I5vbwoGZrV3qjTyRo8boCg00HnUde4FOkSuAu3AhIegnPpmLx8vun52n1K/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYf9ReZR; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYf9ReZR"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso4242039f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778685380; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8I+bM02OxceM46bZKJqPOMGlP4tW+PBzHuBa4Os7Zhe9Gzg/5uTDhwxTgL25hly9t
         zuJs1RC7NGklxcb14YCXGd2DLIzSI7CFGGeIkQuAuKGQl0RYVzb4m5fT/IBwtV3XaxMf
         rDWHq65FdyAcMws4eROG3DJZmNyQHi8g+4bk4UVa6ySvLTC6aYdE32wsAF6J2Rt6OUkv
         lVyYxzIBxn2u+vBWLZJPsmw6s4Z/JhmEq1vF3H0RtbZkTkHe9MCAEOnoQ2/3tKqFP0yM
         Zr2AvA9x0Ft7XtyHETPi6w17uG8cpeNcXuXU/XhMBq7AYzCcUpgP2rSiGOmipSGB3Y4V
         iuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        fh=eRjrAkNr0CYTUOKKhtMYseKOzu7zZ+8UDMYw634CztU=;
        b=MKvyvTMWOCQzXbRffh5fJRkt9lC+m1ip3SE44uKa+lbrq0lc6CGF29fL7yipTndCtH
         1p4uwQyjSX9uluHtwoCzbW8Wn+zFZRwq9ddWEdoPGVc57DAxJQVIOVRiF7b9CmmhwmlU
         FBBOGwqeCnXw0cyuOsFVZFNoKr7kCfTfeTxai63/2uT+jgakGkbTkY1QlRF4oePnPy+z
         bOxIi24fxAWWSDlrjkbcTGNDHLpqf+segGzMHTT3Fqi1u2jux/1qsL7XTFQ/JJST4cJk
         zZDVuQ5weaLu1FbODnAQLAW7+5ZCc5FT2v/4HO5lWkduxk9MOkuqbGq9A+cIqm3f1f9b
         gDDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778685380; x=1779290180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        b=RYf9ReZRO1TZr91D6SdFQhXfIE1FZMq7OYS4DO+Qz4bUwBiNTOANNBMCuNOHAqvfqp
         ystNKvsLnaFyhDhfeiBLnEVYQSuFLO/lBZ+kolsZI9bbyGdKA2HjzhgSkSIALcDTq95p
         TdE/Tjksk53u+JSxNgCdqU5S6QW3fkmraOv/5Slb3f5r4uzjhR9pZBxI1Ixfm+nxcHDQ
         DHWNoTxDhJCT1CC7C5KyLAWUAlIk1zTkQYgX00KToUj9QX47aVUq7F16gg+pBkbkn1Rn
         3TPrdMm3jsVs8RGtpMg5vPwnXP2GOPMpVdtM72onjYZUvCAFPs4FRuVqEWmjtjcFSgVF
         0Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685380; x=1779290180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        b=aCirZONxv8XZfWFVT5Ts2iprJ6tggjheQiCefwgMMvVGlQ5aVksWxk1uK3aIrdKW/X
         AVJgLTByfQsQMif8jI6SZsq4OV1TQz89QjL4hTP5pO/5uqVmTKeaCKIe/aVRB+nFsOdL
         pyOl2Wwu39WZG7zRZ2ra8N8hdXtuxoTo5JkddxxEI9wgxdFPyIa+IOBMiPoxcD7XOheN
         RCqDR9RDQYpI8x/ZkXu1BZTPeYxjmBSKgD0zHMT5AwX/VsKEdr3UUTpgMIluhOX+sNIt
         XmbG0471Bv4v3RWPP3tcL0y/Qn3bDTnM/72njvGr7pmvgrKVI27dlQpwOcwUZZ43113E
         O86Q==
X-Forwarded-Encrypted: i=1; AFNElJ/s5rQ8QriHcgkv+o8qyd+WRdP7VT9cNP79AY84bVJviX1IjBRvfaIoHHje8mCy9CN6tVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkB3kCfpHvJCrcdRwlPqhlwP8hXsd9qw+EO4xnJI7zs+yeukT
	m6fP4yDsv+/myQQVqdxRKNkonqP0nIaUuCqJyjq/phYbs68tYfLsqKaEShv64a4u9lWl/HodaBf
	ETYe07N5IVHLyRKImBG+Kl4pv+Af4TwY=
X-Gm-Gg: Acq92OE7tH/yiG8D5veovTftX7hUOsBtvVb7UxYRZk74NcXXwZ9i8mHf9NsxuxbVbzS
	PBDa/H3bPovD+AZWrwlWiY4qJ43KvZ9WESBAFUVBUe83Pfz2rTtRjOC1Ia+IKUPNtXuuyNWr5NI
	sYqxiJj2F1pJzy4W2CUNbHQG9GeM+MTLoI7XCQuWNEMz0xD7wnQzs6EJMn+3wu8YD+B4Kp5rQeT
	DAvaq6V6deijpJGbvr0nQXL3yxI8Yx7dCHby/nb6co6cJLJDBCPmUo17LnUTXQzndSyykCJBtdi
	ddT/SdqUWVdI2DcctDAkXfsTOMq6xfGAkiA3LK0wOJr7lxTTL8I7IztO0nzVlQRJsvbQOCym43j
	SLGFHmOsk7B67P891jn5fCx9YL7bXDHqpZiGm
X-Received: by 2002:a05:6000:230c:b0:45d:7fdc:2e99 with SMTP id
 ffacd0b85a97d-45d7fdc3157mr418669f8f.12.1778685379310; Wed, 13 May 2026
 08:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com> <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
 <20260513111331.7bede512@gandalf.local.home>
In-Reply-To: <20260513111331.7bede512@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 08:16:07 -0700
X-Gm-Features: AVHnY4LJfmK-dE4pIdLQKgR6OWhmqcSutGy2bdmOOCvWq48N6k373-5ZSYGW1q0
Message-ID: <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 3 May 2026 21:51:49 +0200
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Nack.
> >
> > Please stop this spam.
> > We're not doing it. These helpers have been around for a long time.
> > There was no need to taint then. There is no need to taint now.
>
> Hi Alexei,
>
> I'm wondering if there's a way to see what modifications BPF programs are
> doing to the kernel? I try to make it easy to see what modifications ftra=
ce
> has done (like the enabled_functions file), because I like to know how my
> kernel is modified since boot up.

It's impossible to track all modifications.
See what sched-ext is doing.
What does it modify? Everything.
