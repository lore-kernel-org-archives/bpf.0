Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE3233954
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084192; cv=pass; b=fHaKtCWq70aSIS8P8etHFuyQeutI2fj2ourXQEfsrplw0Aqn35Yageo2P3Lzrz7chN5XYbe4LXxxrEVXDiUsMfDUWvxa8nYaUyr7eM1c7Y7zoiKx0k422zvppLUfKCHYMbfyC2Xdy0tsdYM87YM1ML4eP4k9j0KJJ8nMxI85Nfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084192; c=relaxed/simple;
	bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1p1htC+KqZNgS+FXxCZD1d6aun+o0+y1VpgIN0qXlw5x3kJbwL5FJZpUZefcRVRlN8GHn260hvl7EWZwr0htmEO8G7/BOEKK/FTBRQg1JbQQaW2YDcv918d4SMB0s2uWaahKpXTDfXoM6SugpXW7lV9p745u/nB3I+gOxdQXVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJo3C8G7; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJo3C8G7"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f032b47e3cso2951606d6.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787084189; cv=none;
        d=google.com; s=arc-20260327;
        b=gS9HkHNoqEhPGxkqA3m0fhhHj07ykEwsAnUtS5mM20Q8Gv1+RXRuCx4gi3eGU5bYTo
         PsqIlQIfHOQglNTvDZvN2UspPE1flhMzCq4AM5e2eY7Wd+Wg0SZ5MCh2BILIRMObAs+p
         hIwfj8kw1siCTDLQCy5mxI7DXxWd2k7iGF0uCLkmmhX68ZV464Fk/BL7i/7nJRKJURS0
         Q+f7uafVm/wyNTKuz18tJrh+nKamIBHuD92pumb0VegEAClupWwCf7K7cZx+SSoexKjc
         qB/DgGWg739MRzqzd/ghoEa1cMHG+7Y0rLrvruKhzVDAnN8rcpK2d7oBUDrs7V2kDtCU
         ijGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        fh=TRE/h+5ZDj6sDrjRErD3RIDG9CRT8mE/Z2gF7rNNMbE=;
        b=Z+FPpvx99XZc/CWP7aYIhDAYkWWBlRbL3IEB24+zNOv/XQX3MEQ0qUtC5+P+9agk8A
         +nvjjeHKHuigKdBFB+lumLSUtPc3wDEOpw2tqzSFdXuevCUVk+yJGQrKub1MEJtBGbCY
         DblwY+Ccc9eJasq1yv4O9KGgumHTxDnW28jgyiWCDOHTL+zCHqj3ObbH7/+lB7+JqSxz
         Rp08sfJTc1m9Hec+zuYRFNfF90IiVkSOSNBj79pQ9pCuKAUTCMG+UFh4oFcu3SRKM3Cw
         xCWCddRsGLnKguAs0KAXl9x6pb3Njs1dbtaO2WX/bwEsR8d2cc2nBLzB5sEAiSxJL22s
         fvwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787084189; x=1787688989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        b=QJo3C8G7+3Ax9M4jvi7dQqv8/P5t4tF97m88qWzhD0vTpInsOaI8CywoCZfJXDoj/i
         B40DpFKyeO6IMjbMAt8UkaGc2FjtMj5Re5NO+ceiXnb9QeZ6V+FbHQHJYspEZUH6W2HK
         1lyIb6wKe62zN+4YPUVGg9JABkxAyAkoDee737vSCpieMwnLHwoZ7VMsiBjcKWprmePp
         SlnITAsMs/dZdvLkI4nfPVKPN/k0L86nTc4eQA2kGY2khc/to/gKD7Y83KorTPuVLDB0
         y4mEmpx2js5QBQtUvK1Xz4ZO0v8x/T+Hs06eWrMD84J+qx9ZP9AmJAV4OggBcKb4lBjO
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084189; x=1787688989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+YF0JnFuLVVFd+EqIHRIxuAkoPBQK11aF1ZvDWyGFSw=;
        b=q6YYQCpQd87rMFpDwXmvP7uFeublnfH9I7GYIxksoaZJ0OlQt5wHvdfqOFZk4JWa2d
         uZtTla8GffKO6sQuysB4S3pwrCWeBnTUM+yEfkz56ngve33um307HDxFB7tZV2CqEk61
         I45dPB8Y8eaNBHseY8/th6dvPhWdVCNG7EDr+ne0/6T7q6ZWD28Iw7UUgjsaQLGBIfbX
         7z/SayFpU69HItK+zIxJZhKmWvp3RI48QEdGSwZY/kSnZZTtcJznnZsm3YPFYV+VW0de
         9ikG2dU4QL1idSrtDy6gh+J/VzR5fS0x5taQx7cKM/4Al90d1GqHay2KrG3dld8t0Lsq
         qV1w==
X-Forwarded-Encrypted: i=1; AHgh+Rq2m8GcHvlNpr4RfzC65E+5KLAKXLLwZB524Df8ildSA7YDby16jK0/iD7EkJQv3y4jQRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCCSBaSDE2Bq/Rdi/E68j1GBU2IBQNRuFYd2Sltt1YM1m1QyD
	dd6/opWMck0XqRtwqHb08gtPaZi+HbrC5jLEWGhlIJVYRCVqY5zisehaXB8jc49yxbJ5PzLzOX0
	vm32BHRMqc3mWqlSs/rXyw0tNCaoMDAc=
X-Gm-Gg: AR+sD125rnT1R6hAmG0uxvxc8ACqU7Rbqxghs5+nW/Ae2RKfTc0DddBf2mJ0gWJJJKd
	nvXgbuiID6o3LZoOv24zMWdnUFlNCsjtHjKatgDDTrNE+wiVhSdTVI15CiK0KNyK6RxF/3xQDvU
	G0e3E5asGFaL5njYNKKqLlhpqvygS9bnB+eR56I8XNc7sMF62uCocBETNwjKzxY000MHk6qloZM
	8JWg/7vQBbZS4qyzPBRuMikzBBYclKuT+/jYJNL6inQmOwC8GbcRfbbgjiHUdfMQ9Xapva9o9TL
	gC2u2RVbc6Lc+gksbGDAX6ojxXjnLp8WYKJ3yvX0anuTOXBhFuxxj5tLpTrwKAyGV4yBfWE9aFY
	=
X-Received: by 2002:a05:620a:890f:b0:936:883d:89c6 with SMTP id
 af79cd13be357-9371df950a2mr12671385a.28.1787084189450; Tue, 18 Aug 2026
 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
In-Reply-To: <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 16:16:17 -0400
X-Gm-Features: AcwNN1XmyoBwjLZW5dDGiUk6T0a33HIdvZ8D12DpgCUEXpkFqvB5_cWXzPjArcc
Message-ID: <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > >
> > > Lastly, given the difficulties we've faced from the LSM maintainers, =
I'm not
> > > inclined to waste more time in explaining again why this cannot go un=
der
> > > security/.
> > >
> >
> > I'm still going to send v7 of bpf_init_inode_xattr series, even though
> > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > inclined to leave it where it was (in fs/) since one side will NAK it
> > wherever it lives. We can record NAKs and take it from there.
>
> As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> in security/bpf_lsm_kfuncs.c.
>

Hmm, even if it lands in security/ you'd not ACK it? I thought what
we'd settled on as acceptable from your end was placing it in
security/, then having a broader discussion about the rest of the fs
kfuncs? Just trying to understand everyone's position.
