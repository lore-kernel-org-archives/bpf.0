Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66235AC2C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016203; cv=none; b=F0PwWGXVAV59Pp/HDkxkojM66YEF2JVqslflfdLasCD+3jcrY/Ve88Zzy0CQul9wT0ySb29GbiQFtXS14pFlq1s31FyEUKt6CwPQ4iQqya4M+nAbeNQOmsIQkBdRttbH5P0pDg521bUFiKcCsYjluKEdjqmjOvld6genka4TkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016203; c=relaxed/simple;
	bh=Y92YhwUPJv/2h7H2Q6e9DHow9kcLoMvdAckDZ2rlfCA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I4V1SGSkLzhtHEhrtZJmksgytBnqIXQ0PtQK/Zlkdlvf6jpDguJ0v8aLgTbMXf+yvJuu1m5L7asOmOZcB5WuL7BY3+Dw89eoLzuYNLU5RuVtKTQ7UEz6oEQw9z35X03JySgj4yKDGtx35YjQKiSlnthSqtw2EMzICD4/FtNraQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxFxf07w; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxFxf07w"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so49483915e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016200; x=1781621000; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5wPRNbXYNk+CemuXK96At7KwYoVbQHOG25Mipgi4x8=;
        b=CxFxf07wmaCxZEoyuTCK5RMGcNPwGEamu+G1CoY6KQuzzDmEl5u/4yuiMmbsR+OfBN
         dTr8fl3WVmRqfn+DzzV90CEvlsdO2VjF4Zd+nG2N6C8RARk6fTydMY+usPFsLFrWCBjA
         nStpY4XlgGvHcTVqWWLI2SZTl8XogzeROM3zm1hiroQe81qwHvg9HSg+8kF4kcOPQbM2
         AzD4vt8gzVLVCuRwYcxWU2hf8LCeu4yYLrQebnREUdr5xjUnV9a7/OcRjbDwuap8BmaY
         n3PUT5MkACwMy45KNlozJ2mXLAMHPES24qkMoZGYzV1gxU8X0BF95RUImGUBc08A7WWG
         Ftig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016200; x=1781621000;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5wPRNbXYNk+CemuXK96At7KwYoVbQHOG25Mipgi4x8=;
        b=VCPDmn5yzTxIh2Vmqe+BDT3Qct6fy7imYXvsCiupMUCNssMHrVqifceAr2OUM86rzC
         JvPS6wcAQsnGefZ1YCsBeEfhiOu3iTCw2dkfWwgJhjYFZzhzIaHE1pBCv72v+4tosvk+
         2ufC2BzRiguHtQUT5A8h4IIgOiTTTY46KLZucjRA+z+nSbotxyKXLcKvETCFZhbETdqQ
         QK+zsDEekhr3jbG4QLG0szieURlyvBTy/RG+iUAAEEWll/ssoEUMQ15E3vroUCERQh6C
         T1y94y9FPP+Bjc2psc3t6dnMctiJl//Z+TtcjA7lpSEuS1NFbJ5QbvplUyQ0SmybQSTu
         z+TQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pJoFlRpDvW0+u9qzGXt6kq4YXNixlXYEOv6ySgT/fv6YCQcbkEIeEwCsCqWNUvbJVBf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnfUOYuORe1xQ4JRBQk09h7e8STVBYYA0uNMkkDLk1MTjGs5M
	qsDpQbTPDNXm7Hp04IkHd0UcHxLPEoLxEzIVsktCEb8uF1dH5Rxvqu/z
X-Gm-Gg: Acq92OHKFSSNKKu5RisCXrii+T7iyjZDzG13NpZlsK8ox5yDIb0k47WVdjVVBsNmg5u
	mCK6FG1Jx7wzBhMnn6NMYYkiq1Nu6vHCDNyqV/IOiX/ckSR98p1+5sRn0AD86sxwfvHuEY59niX
	giMjuMYKeqZ5ir9SG0fjekKWMzLjOHaanqRXb2fmlE6XU6c1rrCnKJk1IsQduPH6JNtc/oGy4uI
	mFM6zdZSxIWnDdd5cNgHC9HmudF6prwfEjy3YJmsJI7uG21s2qMsqJP3JDWSfnH396zLPXJuMDc
	wC9LQKEXIWZHvMM7aRrn9YhnZr/9uLsDCswaVmEK25xYvXYydWdn+cS5ZTeYkIk2gZCdL6z0deh
	nJL/OybTsCpLKb/u2YblxE+K1SXOCHdAQar9XahH+z7EGZ3UCZDwiAv1d4mdsjHGEFgmr+43K4i
	pjcSTjoKmu/nzJ8sxFxFsZY+aksTPq+RzbTZ+E3kObs+40cI+D6alib4RM4IEsvi7YZMnxvoCrT
	CV4OWUUK9yJqmerLuZr2HiWSB+lxMw1zZkCsdYGN4bnRi5GWhOpViEagF/hGUQa7n0i53pBoPjL
X-Received: by 2002:a05:600c:3e0d:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-490c25afe6bmr330636105e9.6.1781016200339;
        Tue, 09 Jun 2026 07:43:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm473111435e9.7.2026.06.09.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 16:43:19 +0200
Message-Id: <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, "Martin KaFai
 Lau" <kafai@fb.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>, "Menglong Dong"
 <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Steven Rostedt" <rostedt@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260603110554.29590-1-jolsa@kernel.org>
 <20260603110554.29590-4-jolsa@kernel.org> <20260609102922.3c489f76@fedora>
In-Reply-To: <20260609102922.3c489f76@fedora>

On Tue Jun 9, 2026 at 4:29 PM CEST, Steven Rostedt wrote:
> On Wed,  3 Jun 2026 13:05:27 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
>> Renaming __add_hash_entry to add_ftrace_hash_entry and making it global,
>> it will be used in following changes outside ftrace.c object.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>  include/linux/ftrace.h | 1 +
>>  kernel/trace/ftrace.c  | 9 ++++-----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> It's getting late in the RC release and I'm guessing this series will
> likely not make the next merge window. The first three patches are
> rather trivial and since the rest of the series depends on them, I'm
> happy to take them and apply them for the next merge window. That way
> you can continue development in the next rotation without needing these
> ftrace patches.
>
> Would that work for you?

Hi Steven,
Version 8 of this set was already applied to bpf-next.

https://lore.kernel.org/bpf/178085644764.273544.8250000589480262551.git-pat=
chwork-notify@kernel.org

>
> -- Steve

