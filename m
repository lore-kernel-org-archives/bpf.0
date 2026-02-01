Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86D47A6B
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769913984; cv=pass; b=Cx1m0S7tu2xAa8K6xHe1w+zt7mBX5ZEBVWbwHyOtY/5D3tQveF1cd+XR2Wa86G+ChPBdMJuQN02qknbe/ju10jmUU1GvoOzEWuoXaUm3B3LH+qNFdazh5B1MaCdC9evesF9d6XCkUuxvBpIBobCmjj0BazerdPxMt0av1MUKpio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769913984; c=relaxed/simple;
	bh=Yi/ht4QZpHVUDhBJopsLcXhxQLd+I/BvNfcIec/iN7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6nQXgaS/roOjVb3yijjoGaIuQbLmEiEphx5Op3UQPcZy4FYc0NKwNnbOipeJsUtbT8rT7pdw2fW0A3Mlm3vC3vglxqEv5+NEDSfonv0j3+w7kLFynVeGt5Og8k5Lo7jLNK4ozRzYP3DYJ3uuAyytyXIUG/DsT5NXxT0goIrmwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+ilBQrh; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+ilBQrh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480142406b3so24076315e9.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769913982; cv=none;
        d=google.com; s=arc-20240605;
        b=ejbWEs7AfJfpV0Cb2FwHhhL5d7X2YeObIKj5wbZlk2ID0ZVSFBeKziXOFROB7BN4EP
         QOMzdQ1qWA6n1zqgIowQmRBqWWewAEksAuyefkj6LZk6dFbfa311VfVewuAbZhlFltUf
         rASW8LWtt6sFBOxOCWyAgTH8vaugs5FMtaBEZC1ic1dtyIpM57Y4UowiT5ZOuwT6GlqC
         jQM1LVOUSuLojg6HMgm61fKfFyOApdw6kYqjJkog5qRHZz3zxROtiMmiQs5EeCx1Jv58
         2f4h8SxSxnakalsKwlTwyGpNzhmg2QH8LGqmu2iZ6SWIzv7+RIDDtP+guZX/gt4hyl9/
         +W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yi/ht4QZpHVUDhBJopsLcXhxQLd+I/BvNfcIec/iN7M=;
        fh=jujnbSQL1KMIIV16sUixvn1SETzwheBiFpSCSt9Ocyw=;
        b=KmOxIEDqM+KzF972ZUzcN4nrvYFJu7+CfRyUvVaI7Iun4IswTcYj089We8X3v82Vh1
         tHg5f7ZzgZOi9F5EIwZzAyLXH3U5fT2j2dNZVv+Ap+rrtTx82Vw59ZC1Q5mHULnVqDKd
         b//fx7+1xaVzRR5BcaOEyv5z19vnu/QWWil6Uc3K2YBHvCmLW+3ZkEqFcqUOC222ZXT4
         3Y6rJIqtsl+F9gXAQF7/UHoJliJYDfuC6x6JCI7xysNfuwBsdLOfk1ueOy7NLiUtPdS8
         Cd6Fzm6OQG6CPz8N+jqTtZjzj2/gVVsH2ArLg9Rd21Gt65MLHykaO8i3zJpF2DtuxuJE
         XlDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769913982; x=1770518782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi/ht4QZpHVUDhBJopsLcXhxQLd+I/BvNfcIec/iN7M=;
        b=D+ilBQrhccS1TzKi3uaXvwgKxUH9JlzK7Stcs5r6bsyQxAF9NHCd4zcTn8i5L0FH+r
         Luf+ONl8e55eoziJZ6gTxKbk4xgEaGQ8GBFfpTvoIqT6QUurjVqyy6PvlgQBMPfOdNr0
         P4amXObqBMXp5UHhUFxgzYFFxu7opifcAFUnJx6azV5zZLEJvBIYK7G9eyJB5PNcDFkx
         sbAvndM1kSoiloacALyxzh7+7jtNPVI6f5unnCqgtuOWQvFr7IgCr6+0sLfNfykKmOQ/
         jccd9yhIAY9ginCwPoU7QVTgT22TQiza7tou2V+B1sIPNAebVQOeUc966Fko2emMaFU6
         KHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769913982; x=1770518782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yi/ht4QZpHVUDhBJopsLcXhxQLd+I/BvNfcIec/iN7M=;
        b=ixFAtcaBlyTF0U40Cp1lmUx+kmojF+U0KTF3nUaeoxdNWalaiS2eVa/DY3Xmn8e/HY
         7j285G03hHyLHpVaMyFrt9+X44MkdK10nqb2nw4UBdppYQ5HJE4dMjoQo5QADk/oP+U3
         og+orWCmV1DpD30NJU6p0dPunopi6X+Iqd+cl8eNWkn9mKSTO6usBIQiIAo8RgLBYhws
         TzafW6ndlQlPXq8I5LamHcN3YrkPrR2E4rNThhubI0uYbEcjkDtp25EnaSZkDE6jWuw6
         TWkZPhbsWJaRTsq7dR15h7nPkqAJ+JPxGenzl4GgycF2OZzrynGSX+VO0nfK09AZ9FqS
         LDsA==
X-Forwarded-Encrypted: i=1; AJvYcCXUBY/od2HwpkQg0TyA0Qt5Mm0jo6QvD9FIl32t5vA6sxXLISIHQh7ode9/SB/nGYGDqrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygK5ryO+Q7d/tcHZJzwOu9hQVEbthVUEsfkdhk6PEWkI6DFElm
	Yl3krnz4IOaxEj+6afpv9Ob+6ylVHU+fnfsiwd8heSw58lF7H8A9IgJ2AkvvInyeaD4QpN6x6rC
	2mlbExLS8QctxEJ3EzG43/FTZDpVEIAA=
X-Gm-Gg: AZuq6aJO2uOfPEkY7L4HPY8DNIuY9yEEqUtwTnVkbbQ5fVFYjzN+HZyRL16NDgjq8fl
	tzdPcH1rUvePNB2CoVq/pBU5iF+gHye9W9A/Ng2SE001iX0kY+2xQ4ObZKYPuVn1P/3tbEtWC7S
	IC9oOSZlo0H1ZGvrv9eCbPg5L8ni6I+papc1nY3yCpn0wYzCe8nNJzDifq08ahi/SANjCDV/KtB
	jGjOrZ1zh1QrKCcvtpeKyvHhRrjnqnzx/0D8QQJ975E+Ebba/Z9xcytd4f1UEPU77bhifQb65Hc
	eNBnmleZXIkVF6b0VZfyLFQQm7xzBFqM+eMBdKYOkOuwqV8Om6yuVGHrUZmDMg0AYSG6QikpBFo
	H6TLw+7IofRPowA==
X-Received: by 2002:a05:6000:2dc2:b0:435:a815:dd8d with SMTP id
 ffacd0b85a97d-435f3aba09emr9653496f8f.55.1769913981687; Sat, 31 Jan 2026
 18:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <754601da.6db2d.19c1704f391.Coremail.kaiyanm@hust.edu.cn>
 <CAADnVQJZGUCVuG16ZmZMNa4B9QLRAsMBWCXu3nh7p8qQjcS_Eg@mail.gmail.com> <214c0933-efdc-44b2-97f1-de6f66b4698f@hust.edu.cn>
In-Reply-To: <214c0933-efdc-44b2-97f1-de6f66b4698f@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Jan 2026 18:46:10 -0800
X-Gm-Features: AZwV_QiTG-n5f86SDDJ-eIdftbwl9JITsxYJU0iQS352ugXBVVMCjyTmRsN2wpc
Message-ID: <CAADnVQ+wyHjrA+z3UE4G_F7BJ2O39y9bE2dgtr3UkGvEK9dTQw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in bpf_trace_run2
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, bpf <bpf@vger.kernel.org>, 
	Yinhao Hu <dddddd@hust.edu.cn>, hust-os-kernel-patches@googlegroups.com, 
	Matt Bobrowski <mattbobrowski@google.com>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 6:44=E2=80=AFPM Dongliang Mu <dzm91@hust.edu.cn> wr=
ote:
>
>
> On 2/1/26 10:29 AM, Alexei Starovoitov wrote:
> > On Sat, Jan 31, 2026 at 6:26=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <ka=
iyanm@hust.edu.cn> wrote:
> >> Our fuzzer discovered a vulnerability in the BPF subsystem. The crash =
can be trigger on bpf-next(93ce3bee311d6f885bffb4a83843bddbe6b126be).
> > ...
> >
> >> CPU: 0 UID: 0 PID: 5217 Comm: systemd-udevd Not tainted 6.17.0-g39e9d5=
f63075 #1 PREEMPT(full)
> > I don't believe it. The splat says 6.17.
> > Maybe stop trusting AI so much?
>
> Hi Alexei,
>
> This report is generated by our customized syzkaller, not generated from =
AI.
>
> Because syzkaller cannot stably reproduce this crash and generate a PoC,
> we share it with this public mailing list in case someone may understand
> this crash, or help us reproduce and fix it. BTW, if our fuzz can
> reproduce it stably and generate a PoC in the future, we will analyze it
> and send an email about its root cause like before.

Again... the crash is from 6.17. NOT from bpf-next.

So, NO, no one is going to look at the crash from 6.17 that could have
been fixed already.
