Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9D32824D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540347; cv=pass; b=C5JN9WtXa5nCdXGMM99ftnFqFdrfgeGTG9ZZW1m6PAJRStvNxy1h5MfRfU3o9UiX0vOeWX1o7e6Ru7uwHDEQ6vt/5Qi3rRvZbKyHQMQMGw0i3g0xUZ0JqU/dtB0UTXWE+M8xPeZtiio+R7eRQdOmy8CXnmjb5EgkGYx6WWgUB9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540347; c=relaxed/simple;
	bh=IIBGupSZWERssUHAZyAUJFNeeyb2xu/a6CxX9EN2hx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOh52lxbEzWlcNSuwDTFKPka3Yysxtto4uvYKaBpemzNbBhBkGC/+vdd7H0GC/C+ONHmm/KMyHN7BZxWg7xO23j94HxyMtNgqgbg/y6/0oRq45dbnivF/WcqyFt23XxUdC9p4iRk/ii9L9K136gieEmo0ljwRs5SBju75xthfYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2CIKXr+; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2CIKXr+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so45587395e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540342; cv=none;
        d=google.com; s=arc-20240605;
        b=SzFC2oYEGUEPJg8RHZrerGsI/D8Eh5RbNhi+OaaIaAUpP4GLk6U1ND/Pzg10mcNWdy
         xylHr2mjpyZo74xScJYhGDmsGxvchZA3rKYryg0bIiRjup9w3Z57Kc+wCgpQPlklHQ3u
         r7AJEQJbWEUDrpE5pkliBsLB5ofolxGp2PBlFePOpPq49kJz2j63E3AOrdI6JYpw7ztG
         9O7Ko0L3NvevMl1ggXyv0vz9FMlaGu9Ei+XQW8FNAR/ZYi3pgzr34RI7JcTyr4UkTQ5j
         1sPv0KWkNMf7YeSkVnWRgjkc/+fa5853JnE52WcdChjtjG5TwK6znVYBLcGmyMjPHQMQ
         rHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aaSznZP67F0WuirhSjihADlmmfi+xxar5nLBaqaHWcQ=;
        fh=eB+IjVu6igiJWxR6JnmnBvhlS9l7ihRsOwOIS8j+4AU=;
        b=Pab3k888KyentXJ0yeAFhtB02u3+2ycHu1fVyuA8t5wma3vCZs0fbV76q/XSicDmEN
         HI69GCOawAivjK4Q0wUvMFHekchuJ0+zKoKsTtET1umrzr5xlC1+ih8+91ylbkByGA1C
         inKfeD5/dNVyfOxffG9V6AndKLUgFipZXY8uBtY3Z4I3rIJUHxvMwJt2FQvXHgQXJmWJ
         nGyiXj4QUrJ8jYTqgeUmSHxBKugtzZ6jyHNIm8WbYXgrBwVapl0HlpkNKTCzPyi1bA/1
         gFf4UykO7c1Zkqq1zgYVC2YIQ+gQxdlzNx2P+78ZKopzSYrGQW0EIM1da4n2uSp0TXo/
         ZN4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540342; x=1770145142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaSznZP67F0WuirhSjihADlmmfi+xxar5nLBaqaHWcQ=;
        b=P2CIKXr+DhqD0FZDzfYoE5uTwQ7aNQFdLpJ3oZegOvdLk4ERVHdgl+m5CwVqaInd9n
         S7ACpMrKclFRP4CjIE3zE2eeCC7JRIuoZyRlx+NJfSVYb24Lq9d8oJAxK9oR5oL+dS0A
         ROvGV28YzXfvsVa4aHZYkAk9MQuhjT+6vJV1TK4BTmWN84BiOg5JTInNMWQ/UqqN0Nuy
         vQP+N8BCv7Nlptc//6d81GWCuGjSDQ2J91NhivjGupXj9kaWkREcEuGwz+kOUFTfn+LZ
         ywfWpgeTrC/oy2/hXxvaIpMIdDgenu4zEoZhbJDAndZVDe/DtaALtgH4TknHFXSUuLWt
         lWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540342; x=1770145142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaSznZP67F0WuirhSjihADlmmfi+xxar5nLBaqaHWcQ=;
        b=UASdAu85rEldU/o9I0pPNJlpA36ZtJLhu5rsXuSL2NxO7m9tBW7erj1y+xRbvsmPb6
         lnb1Tjjl2ku7gevBUmD65821ZvX1VwJkf78arU2xQ4KlLiFJ22bKsp2f33AMxZy8IMQL
         HX+s0+wjdrfC9Fp+AQ81BJcxJhDJsqsRECGJn6iNZCOV/FS+bFeVe+IJftTkNQlBVv3h
         U+/uoks3UYxu6qqkkW1oEpYJnG/5UgU+LcwGCwIMm85I8K85ay2kKEs/Ae36WOeKMCC2
         sM0cMGkurRq02eZHu/qCFkZ0Lgu4NK6qsug7FFodgR8Ri5ry7nPAF7u4gGdQOsDFZqvX
         /T8A==
X-Forwarded-Encrypted: i=1; AJvYcCXsz6gkhIVNd/p+tQzrw8NFJAXvM+BBY7BKbtqUKx5WFcUVfxNeJYzww2HvEkY8d4x1SVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxeteamg4pgIJF1smR+KcrYwcD9N+ZKHdbiFsHDKSsgqkG33sL
	6tk+VPNEfVlNVoXzhvH7sND+b3gaNu7YyoC+qkkvVd1IQFZ0t+gCmVcC1zjddxrA6+dMrkNOIfd
	Q0petveJxsSVh6mDUZ6oeOvO2oAgG4x8=
X-Gm-Gg: AZuq6aKYDLTA27Q8N20sHd71gyHzqhnXsJcP3Zo9LQ9iR0p1wGllEPHcJiy8q1PJWN2
	mCXI3AZLc0QwfuLiSGi5XSUJSv20fVS/QdkCimrEA/QCyUt2J3BT7RU+EFWDAt2dV0nz90qDuMi
	u31DysghFTrabcwQ0qTzh36V/jHbYyckhBx8+NdxHkwJvH97vHLwaQOSwFQ2dgjIs6upsaMBsrU
	noMrrINRprB5hmV2tUNSvEDNCQHp/+l0lcPTpnMbrnuot3iXer83pkhJiP5/vM9OVzQc5IMtAVw
	Ot0UEbUCHCzPZq2puBQk2pO0j5v8qo1PaVwtGuL4XgmTxs6FC/0HjDrLwepTkyPjzjTdUyZOyLE
	vSlQxe6qy4eqgNA==
X-Received: by 2002:a5d:5d10:0:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-435dd1c1d6bmr4100001f8f.29.1769540342429; Tue, 27 Jan 2026
 10:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co> <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
In-Reply-To: <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 10:58:51 -0800
X-Gm-Features: AZwV_Qgzk7qCM0zvtA5MeIGgCCUqqQ7cMiI-0ZvBSVb44FcPjsYIcO86olVTO6c
Message-ID: <CAADnVQL8wV1iPeMZ-ZvN-34o0gJF1xGYu5ZtLuD7GBgtj-ZNuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for connect() racing
 sockmap update and signal
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 8:16=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Attempt to trigger warnings/crashes by racing connect() against sockmap
> updates and signals.
>
> Follow-up to the discussion regarding af_vsock connect():
> https://lore.kernel.org/netdev/20250311155601.eui5j2lta3q46i6u@gmail.com/
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../bpf/prog_tests/sockmap_interrupted_connect.c   | 200 +++++++++++++++=
++++++
>  1 file changed, 200 insertions(+)

Not sure why, but it seems to be causing reliable failures
in what should have been an unrelated test. See bpf CI.
I suspect there is a cleanup issue with this new test.
Pls investigate.

pw-bot: cr
