Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A134165B
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278594; cv=pass; b=uJDwzk5LGjo3vSy9z+O0a3EZNl2SI3JKxeS14yYFvJauLa0ncRTS+y0gCv2HaQ63XMSUa1xSSjPK/W6nCUH5b4i6a83JJFcHtFuGFPT4e3mFYZRai+rIBuUsxP0exDjkoQ9BOyhtpmTpCigwMSYZGJPHBRo/jJaysAmDYhELtKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278594; c=relaxed/simple;
	bh=e+E5zuCyazZJmFaSY0AwU7cB5eQG/o6vL6H3Wforntk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9b3geuRb7vg93Klji2XJiitPKJHxh0SYXx494HpBthjH+8jIbNM4gzEs+jYDSWyJb8KW1eQxO6YxZT1uzvbWaVdh/883zuYCZN9eTignKGv3tzT2eMImn6iedEIEpq4/cQHpVANiRBuqdPCuWsQRkvMfGOhiJn/KgNIVtwW0ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alwsMLWQ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alwsMLWQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a044cb827so1893334f8f.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 15:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778278591; cv=none;
        d=google.com; s=arc-20240605;
        b=Lq/WEeXHI8RUJE6qCPcqgrGeWapgWrMnJ+MLSgHfn/P1rOFp9Q2bkp2K8mlEmTWlyd
         q3hLXvH+v8QT8/Pjm+trtGZxRRsFxle7KQmjEcKuAsHiqW0xpNi9QXIY6YD6yjeCOlI8
         4TjzxaG0bJAI9A6Bse/YTHLgp4Nq/AseYKkv8/YWt0RBVWUAU3qB4mEnHARwQIV8tnQb
         VSng5QIftUUgrztRRKaFkB5LSlBwGM6q7CNwy0PXhe5qyz+tKRaQ52lsLJmUvuj/5LMy
         uFop4t/XFHGY77JHH+OkoPBK5o+ERT5HRlmO64T26z2FieVBBQ+jn28E893Zqf3N2pI0
         +KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+E5zuCyazZJmFaSY0AwU7cB5eQG/o6vL6H3Wforntk=;
        fh=hazFc/Bz1CzLohsZLT3vRNyNk86l5dyQJtjmat3+SCs=;
        b=Wj0BGZJISFppeNJbIu/vQnmYNiNf4Y3Z8sS50WLX/WU55dQbbBQZNSR6ioMtxC5Jf1
         i9yj0I3eXHLvLTD8HdqC871ZnrqmhkmYSPjCJTpUilekd15PhciealRDAEK+RZfDCEFG
         tQ9tAYZlAssP+YSWWijjCyWXVPIkUdrEsgOjW5S2Rd9vywvE8F4QvwS5MMDwG1isDvBS
         FysaIgt9c0dsv83XEHvmX04pi06oe7lPn0c+Q9sZWbPgoAAh3u1IvyxXqlbqJJ4q8Sxs
         hbjAZPQ9HQjr0EnX14Voh2fi0bjUCTZXrENFbHHlpGX3fIAARzc2NjFsmIvoAF9HnbU6
         S6gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778278591; x=1778883391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+E5zuCyazZJmFaSY0AwU7cB5eQG/o6vL6H3Wforntk=;
        b=alwsMLWQszevwU4kxEtdgk0IITaUQRZ7eR//CeZ3wTRXnr0+XAd9HGzH6yC150bBIc
         z077KZXPbR+vHzssz4aQV9D1Y4hVGh6AJAiDV0VcvrTGJz9TbUypQChFr1jB979oMZgN
         XaRaECqtkxvkdmshB00rdF9Xvs0Yp4Sc8aTyQl0lwCryS61Q++vT7BST93/Ign/eNqmI
         yc0l1htdSYqnuI0BsaIaiR/QqDvNdOi1OdZMiAxcatbWecg6S+6yEXxCJN3bb4N4fstC
         td24sfbakHJ8u4+VcNiQ4ibJ9mXKAhjqGNCl4/qDPGHW1cJr4gtri7oioHlyOaLhOEbx
         OifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278591; x=1778883391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+E5zuCyazZJmFaSY0AwU7cB5eQG/o6vL6H3Wforntk=;
        b=c7h42zF01SSiWAbgYvHPDYZwGviDwTwmAVmbxI6Js9nAM59e+MQUPk+5QjYI/KIebr
         fwtHKJMZybIB1NY8jvytLFcObssdF1KvoTcDVhxhgKkZSSCX3ZTPILo11+y0nHugWEE2
         O1gIrTKe95dvIGlduTh5DdTEL0sNisgvDunvyBLxnWNwhfIPeax/VyD6bCUrW4iMPgGJ
         UZ8UYHFN/DgFVyVlHctZkXbEr+7qcm8BdAN4Oy8t1rs7qiFo42d9D0Hnm7STjTu04XEg
         9XEHr3U0Om96z1n5x6WgkTda9BBbV1cFnhgwWMKYtx8t26rDQHrod7ekYxeyjvesWDsx
         nk2g==
X-Forwarded-Encrypted: i=1; AFNElJ+9jPw8Cp14VuvNB1xTBCAIkGn5Y5aeGwgyJqq9oFvcWHXXgw3oIWHQObH+pawgYs6ZZUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/G+bgx9W9/xf3+B9ByWQyo204BqThdx3SVfWtGtkOyXyuFHI
	7IFsRnNk9WPOFV3TqcSJEKj3t2rH79LLouO2vX78G7AcZ9dgNdNYpK2JTTyV1TxVhK0D0+VOvj8
	XcWq42DiliK2KexHvFzSvG1SfHt0q+dk=
X-Gm-Gg: Acq92OFmPH+z2I8dn3mfHczZ79bJLxmYBYVNcoElEBZBTfSasSdljO517EqwFF036fX
	WNz7w+kDrsKX8X5FYy81aNXDGMuOFl9ai+vfht/fzaTd0aHpP+J3g59ZYiN/E6MXdDMB0zaduw9
	ozNb1wVkgSdgrtw6ch/6oR8ONboN7yHkcM3RVQZzlYFCk6ZgiF+dKA+PY70AAdpgZlUlDs5M1v3
	V3xM3hs/ozPfRo1tIL8oe2s2i+dInD9+JbgWSNSttcQUNqCVC2XsYb1klNZ7zvDMlgvznzbbc0V
	6ZbqcfYnWxtq+QIHAcM30krTqDdz00ElyY60h2S9PuoGgxxUUk5B8LG/V2/xRzfTkjlNV0CdAkS
	LrAQlMboUCRWL897D7bT0+kXkLBbkMm8YNYI9
X-Received: by 2002:a05:6000:2c05:b0:43d:7868:21f0 with SMTP id
 ffacd0b85a97d-4515b056a7dmr23961689f8f.9.1778278590502; Fri, 08 May 2026
 15:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506150547.767315-2-paulhoussel2@gmail.com>
 <20260506210856.C6C29C2BCB0@smtp.kernel.org> <CA+aJb_1vFaSvBjsZbi_EYhGfiefCruaEaLqgagX6HAGfLFxqGw@mail.gmail.com>
In-Reply-To: <CA+aJb_1vFaSvBjsZbi_EYhGfiefCruaEaLqgagX6HAGfLFxqGw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 May 2026 15:16:19 -0700
X-Gm-Features: AVHnY4LmEprSW8fEF3PF0JuH8iIdLeksir3-oE-WnUPnoXE1yPhAwdPpSbusQm0
Message-ID: <CAADnVQJyT3fLLv8hnBQHhpc7AQhsAyLiiECm6APqyrt10kzCsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:40=E2=80=AFAM Paul Houssel <paulhoussel2@gmail.com=
> wrote:
>
> I would therefore propose to set the maximum value to 50 or 100 (where
> cgroup_bpf is 2024 bytes long), what do you think Paul C?

Sorry we cannot grow it with documentation only.
The whole thing needs to be refactored.
effective[MAX_CGROUP_BPF_ATTACH_TYPE]
is problematic as it is. Plenty of memory waste already.
It needs to be replaced with scalable approach.
Yes, it will be a big change to __cgroup_bpf_attach()
