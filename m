Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C419D092
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628860; cv=pass; b=GYuZ4cAOX0tFEplOj03qGX3XxSgIfuXb1Ev0IJngM88BFREki88DKfiTKDnOtVWBWKVZyOTHXHXuFPFx1xmph7+dTZVg2BubvlTMCtS9PXrpXetKsTLtNJ+e8h9fj20EKWbhb3QNkj1M/pItWTZ5x1GBIzX3sBYAmo/OZeeJ/h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628860; c=relaxed/simple;
	bh=l8f98VYpmJJa6wT9VBWM9nPIpJ4oRx+gqC/ZRfD0vJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3qfiKZsksfhkYoQVo0UaYoCKsgG/CWH0sn3MAh1GqrQ1qcKTMp19hQs1rKjg/ZX1gQFx6PIZdng4O1nJX2De2CW9ucyBW56h74ws9veUUUG+d2U8WJu0GP9+UtJXTIPbFgtW2Rz4AUtWeDT1JbUGHCInTNcpQyJTifTsJFebq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI4FSiaF; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI4FSiaF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362c635319so2334033f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 15:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771628857; cv=none;
        d=google.com; s=arc-20240605;
        b=em+jdKo+vna0CoPTktWWQYqrgcQViAccNSAo/sfmPCSXNU8A9qd6lXbVkp73SG8hIG
         7TFk8UxhMNmEipOXugdkuJsccsBa99WZ+WTMTUhgKJJKjFrvXbm5FOKNNBC50zeAXeXw
         xoGK/6tLuXIhjSdKqA+jVLTYw3lY8QIgf79Fh0ovNT2Pk0txMVymg79fVPt6ZU+JQkk1
         Rfu2CrAPUnKuTmXAcMlJSGAqLGY8PhaY4E9cpy/7/RWPNOAwwAcxU34D/xb65kZPXdWY
         LFsHi0NEejeTxO8HiVDp9vG6wjITFJdqeL4vWtd1Lx7SoLzcso8h4umUqAy7Sp2TfVCx
         KXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l8f98VYpmJJa6wT9VBWM9nPIpJ4oRx+gqC/ZRfD0vJ4=;
        fh=qJCppzjQQA5UevqmIUyfulDAr5UuFNtm4ivrYNuqSEg=;
        b=A5c4+CdH4P4dx28XXIG1bcyzREWrEyyu+C/cHo+htE9s48abtS0P+HmcNflZlDri+F
         ZYt4d7Z7t1zUvHMZAE6KW200JLqrdxJSl3IXDjPEdwYtuZ31TilQKStd6+rIhOEx28Ko
         X5u6bD40HPscOLaXuzF0Zl6Kc1xZrEaGQyEuoph021jw10Ey1G7IXqYucXrhRuFN7fDH
         3Z/d2eDM15BU5k4aR+g9rl8Hme4h88dQOrURVkkpW0j02b4jFcHLu3GrvBS4eIQoX+SI
         v7I6jEOAU1MdHa/L/hFOV+tMo7/mnUiaq+gJPKmRKQv619WibGsRaehcJ1ttk5WJAruT
         1t1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771628857; x=1772233657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8f98VYpmJJa6wT9VBWM9nPIpJ4oRx+gqC/ZRfD0vJ4=;
        b=MI4FSiaFNvKQdbzr8DSy9lCp4ROjoYomYXrf5Rk6eZQnJTbvbkLfXBl8VMz/sv6ArX
         6qeu2NFrs8APqoJJSjM4oehQLgK2UG+T83iF8L5rhVfMdLN4cLm4ijK7OWXwOukB+cDL
         IkI5DGPehM8HYaa/KWi8m97Am5fE+yIkTUWemHdbx46qP+14F9fbxRZk7d5ZQUN1l56z
         pnfNbXYNUJ4Mfi3GfDVNS4SHcSlmG5/Ey/Sz2ChlOcAEjrgZ20d/GbpEQgTOk9tAR2kl
         wA0Fiy1JQX7Xw7SuWlDQqZhBkYFeWMu885chst9nKFaV0M4gYSltP9C0LrUnOPg0K0NL
         tTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771628857; x=1772233657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l8f98VYpmJJa6wT9VBWM9nPIpJ4oRx+gqC/ZRfD0vJ4=;
        b=h6MQeYmvM4PJlGq65QXqdjxF9kjd7wuDRoVmVoy/KdPnyYgKj+ZvZ9jbiRGOXgg8Gz
         AoWdjZLiwsaKgTDOxOMHKAnmkSFkqaGnC8fBSMdKgWm1z++FS44I42CE5VIhPEOFuY3R
         /YwX70LNxqRnT4OrBKQgYOdBxlg0SshjeoDKNPj8MObTtfIa8vKQpBOAjsFq6sIGH9q0
         CIdEywOr8lvL1/kopXteSQgbBj8PhcJXG0bEJ3uc4nih1hrEu6WHiZX323Tuk+2WRE5H
         Tr6vyh/Yob/Pcfu8Wwve9g86ZQHvP5Hr2KscJmwplktio3Pqs46qSZDbYj3vfU5hy80n
         t4WQ==
X-Gm-Message-State: AOJu0YzAKtJTw2ct+ktph9Lf+3q/vu7qgx0vjfwIo6OELxpgj7VKDZSO
	D2ilasvInVhyZN42LPuFMIYTluxmIyT8+HKe9cZJ7zq0kugvg/58K0XirAo6Rs8xXiiY4MN0459
	wxUxyDa2iYu3VFJSLNL7/W+y7oYUjHco=
X-Gm-Gg: AZuq6aJCQ+MtQY3/Y7SgAC8h5a7sKR73l1xAaoY3Qm4ziyc5cenNxedxMTvnx+aMgDg
	GJBuxorKuZYkcNsKxFDfRiSm9kYVdtFMqFfH2bFpLnADsq6H4q+4MFFl1AO+YoEIEVQzfpqswUS
	YNUtg2DtQa8/48224pO0nJ632IGYUAjFYcqvWuYVGbvAE+Fx+bTC8551JwokRhOTG7ahi1iGvyR
	QRyR9+3v/qSqqYv/BD829o39OHhdxa0hQpj4UYvJi6WZbTFA4L1pBs4DaHMoptxOWvjn5Fuh6OI
	7mwDo4uarMugR/pEO/fuXz3cMMQF81GALjOhNqs4OmyQFx610lmMplSHBUQh0m0n1VSXQB1YrzL
	QvLjRT/iKx4EkV7HWVVIboRtImg==
X-Received: by 2002:a05:6000:2890:b0:436:37e4:594d with SMTP id
 ffacd0b85a97d-4396f14cb64mr2813280f8f.6.1771628856921; Fri, 20 Feb 2026
 15:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771625484.git.josef@toxicpanda.com> <e582d9289c7b7c2682808db22da6bc3ba907d884.1771625484.git.josef@toxicpanda.com>
In-Reply-To: <e582d9289c7b7c2682808db22da6bc3ba907d884.1771625484.git.josef@toxicpanda.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 15:07:26 -0800
X-Gm-Features: AaiRm51MEpBQw2fGc6XhQVU07A87qjZ7YTvUv9qAX4TTLRK7FQChlvwuGhN_T84
Message-ID: <CAADnVQJuyryVdvS7wKHGoC4nePxrtg45441fDyKTFUwRDxk65g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests/bpf: add test for btf__add_btf() with
 split BTF sources
To: Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@meta.com>
Cc: bpf <bpf@vger.kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 2:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Add a test that verifies btf__add_btf() correctly handles merging
> multiple split BTF objects that share the same base BTF. The test
> creates two sibling split BTFs on a common base, merges them into
> a combined split BTF, and validates that base type references are
> preserved while split type references are properly remapped.
>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

v4 and it is still missing your SOB.

Chris,
would be great if AI catch this.
