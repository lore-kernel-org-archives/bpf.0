Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDD3B47F2
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215772; cv=pass; b=t2CuwYw/ongBlfBYxn8Zgnb5hInM/Bds2x58QtuP7Asd1LTiAXWmTG85ffxo6hcRW5XJASTsRticVdWaOVpTmZgx77aPABP85P3M8LTDu/5SFNRzbfP9BJ01FD5O2r6rcKC5eUDU6YMAHd2syFNTR6Deeduxo+92C/7VOu0asak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215772; c=relaxed/simple;
	bh=lAGj6nwkp++G9k/rSCeEKSrGzcAUEaSnQ17uO7koJgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJJ5+Ubp258rV6tIeWJVLEkNJWThaW04BYb8V6oo6y+Rg3Oxb4jym/18zkUqD/7ZPLWakmbLC5Qe4Ngq5fO34FNIgUDr4YlqoAACGVC5AktrMDLh0PjTbJpps31abn+J2g/g2qD4Il/LT5mybNwmEI8NmrJ3JoZ46gJrneAi/9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjpNT1Sl; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjpNT1Sl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-799001d73bdso21264547b3.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 00:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773215768; cv=none;
        d=google.com; s=arc-20240605;
        b=khyeyceG05DIBwgw5bIRGJz0XvAJJtzQKW15KlTRB8TCe8veIZIBy1O0Tn8i2DHIAa
         zP4g7Z0dqoCoB2rR/a8rS6LiEVbFYqZaN4OO1/psN5JEJ+/1DBC9g4ijL4EQ31RJLGKQ
         Mzz83xIwUqsZ5Ow+zGgBNPr1Nfo85E0r2IlnRCNrnfAK3NFrn02YlnaBMKL0NWFp4OkK
         ith38dSY7y6b8yejHpSd1prlxsA7n2h8hVCyki2vHFil5HRAmifG3ylZSOAv3ueqm9QB
         HKz5yFz1K6rSGSQ0Q3/Fq2i8u9qHlO8MudHg/bUGT0PpB7bnMRv3U3VpjlSDi48Zz27N
         yqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+EtDzf/2qX0/pcxNehTrmnkTztfsdGIQ04FR+hwnLr4=;
        fh=ypUiCrC46WBTFeGR5vqpkLeSJSTW7CjijvDTiDd+Hug=;
        b=D+5BRQILa7Yc1HC3+5xJSAGDJs3p3B5gziEx0qrL5KqrsmC4eDrQCVMfNEWMCTE/2u
         0S9j7bPA2fo0bR3oFOVEKtAJsUzIYH5eVtdKtP9gK0bVwcSlVHlVqbCdMKgMEJTcmXwd
         hA8qcbFUnNiPrVDpQXNcDl4Rvn6xgH4gpS/n+SaM6GI4vHu2EYna0CGAp/Qp91V2CNKX
         0a9Y2vVkvbfrxlEFgir3XM5UeXzDSE2kC9VN77qrkOqxSsE7+DS5SJTtK40XBHV7HMzI
         iFn0yL/2YYbYMXGGQASbjphfnsfPQJm7IEOFBehKluP3A03HupetIwjr8qugCi1i2oOw
         s4Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215768; x=1773820568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EtDzf/2qX0/pcxNehTrmnkTztfsdGIQ04FR+hwnLr4=;
        b=IjpNT1SlxlKtc9YXp5U0aFqnpqWyK0m+bOzVnDOkyI+zsMmbyytD6uiu0UiZDZ0KJt
         pp1www2jjQdTjkJ9NYwrP0sSWl0njQyDKN15odjgWfyNK5/4idOOKVFhLqGi6TKDpTpR
         AcxvHCeWjn6KfkD33/dOE3DNzeD1RapOYtDTkoAQ8VXiuMIqcU5zv81s/hRhxGUpHI/R
         gVldmfbldF5jQxCrtbC6iXx6/RZ53Pjtj5NxuPzGI9yTdX6IiBcvDkUZqP0mBOlPnVzM
         aEIikeSQibtBVzsMSeg2p0eKzUDOzptOvJSRa6f7o+zXRcnW2j3MitLfGovp3Yk+gd5U
         vJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215768; x=1773820568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EtDzf/2qX0/pcxNehTrmnkTztfsdGIQ04FR+hwnLr4=;
        b=s8cjGEoh5Ad9oIsSaDeXvgB15iq+dWyYKLDCmyTqSgT7v67mzyl2rklnMpWrDRr8kg
         vieKvz3SDN8gLaUTLboohRTkTdkAExXDBd7Vogf9yAYfyX4DCF2TwyoXSq9gZs1EeMy2
         CZuYPlDb5IX6Qfl/pv+oLBs0dzqY6FHkHwuWTmoIH55bhGKalD/0YRhzTnpz+JcOhQqQ
         s3sDjvr7x9q5uxYQgBrM8vNYQ3hUQdwIrcxBmv9MFXgof2Py4zw0kx9VvsMh/PZOaoBE
         +mRomPujXWEiMrDtaeuK1Sti8FiL8qjUFU09l1rHlG23HslWpEs2RJGZaz/gUvjw3Plf
         4e1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1vzHYC+UdN16PXsyD2PDwu5GUM90daitJ69p7jD3b1P6lEgBJ7Z148cIIPPTEJ4bdGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbqBVgvnG8HeT4oNa+q3xA/qsDHUuYgqLkIAUCxdpEqew+z8T
	grTEWlwvwUCEVkUqyuaKAcuEwWlK8qbY5p2Bmdx9Em/3H1REabpvr6xBDm1zmB5fVj86Eujq1vz
	42nUPr2emLG/2kWolIaxaz2FKw8LBa5c=
X-Gm-Gg: ATEYQzxgThAdfabcLbw0x8HJeY8q4hVwGXSFlKgtIjXvzKV/kR3C0n1XrMWSs72F5Gy
	PZ49+C2JM5SSQ5CiplcSM3TbIoxXjxBmjhzNEvjnMtJbPf6uImFmtaqlewmIR9NSafRW8tA6//B
	3v9qXeOndiCcDjKU0al1YL7EaUF+4N0SUeNpbqB1BBobyON7cYw/+EYN3U9CYpITCqrpis+e+Fh
	femss8OtenNQaPB1+ClqNPy3L2hUZaYzMLkRs9W7ozWKbaJ69oFGFw72jgadLeBqx28ao6d105f
	hlMmdlHWJXLwQJ2pkmsqggR3G2hF4g==
X-Received: by 2002:a05:690c:2704:b0:797:f13a:c571 with SMTP id
 00721157ae682-79917fa5df5mr12806597b3.58.1773215768327; Wed, 11 Mar 2026
 00:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <20260310102145.857810-2-sun.jian.kdev@gmail.com> <f0d1eb34-2d6a-487a-b486-3dc64c25df6c@redhat.com>
In-Reply-To: <f0d1eb34-2d6a-487a-b486-3dc64c25df6c@redhat.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 11 Mar 2026 15:55:58 +0800
X-Gm-Features: AaiRm53EkzwZReT_wk7QVC-Ygi0J86_yaQ2oUG5Ism0on_mG6PZTKx-yHNgXT0M
Message-ID: <CABFUUZFQfoVRJ6HJqadHhWNj4FVOk=snuSmuEepMD6jZfyrpJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when
 unavailable in test_bpffs
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:32=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> I don't think this is a good approach as it will mask genuine bugs that
> would cause the files to be missing/inaccessible with one of the above
> error codes.
>
Hi Viktor=EF=BC=8C

I don't think this change masks bugs in a silent way. It prints an explicit
INFO line when maps.debug/progs.debug are unavailable due to
EPERM/EACCES/ENOENT, and it still fails on other errors or unexpected
iterator output.

> If you really need to execute the rest of the test cases in the file,
> how about you split the test into subtests and then just add the failing
> subtest to your DENYLIST?

Proper subtests  would require reworking the current fork-based flow to
report SKIP/FAIL to the harness, which would be a larger refactor than
intended here.

My goal is to keep this as a minimal change while still achieving the main
purpose of this test: exercising the core bpffs operations (pinning and
renameat2 semantics), which are independent of the debug iterator files,
and clearly reporting when the iterator checks couldn't be performed.

Regards,
Sun Jian
