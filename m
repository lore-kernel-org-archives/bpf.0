Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4271EF09B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155388; cv=pass; b=eHRD5CLBv0asEDoveAiz5bWvq9tdfw9JNMPQYFF3rta9T8Wxj4qDzbfunPbkQXai/OS3iRmOqeNgfrMfD/nhkB6SgweB6Z3KR51v7hfZHrfigv9y+bGV9xzQDb42b6nXQFeXnGXGsEO4h+D+G9lKWcsf+9tHilGrI9H5v+tnOcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155388; c=relaxed/simple;
	bh=kmmwTFF2Z8rbdsKf2eDdFDME9TetlTgdqjB36TnGYzk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lgrnEIfLJNu76u/s8DuHosYxAAlF/N+FkhEmD6Rcss2iP8kUv5qHB3m1PBt+KJyzcdsaZ5fv5GkG2Z1L5BGcBX5Yzi/kgM3/AYh5W81l/ueoPDKOW5tqladOteuki71m/xoushHfe01AfIYr/Gxa7PRuOgtwm1GuB95xC1eC20U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=readyjob.org; spf=fail smtp.mailfrom=readyjob.org; dkim=pass (2048-bit key) header.d=readyjob-org.20230601.gappssmtp.com header.i=@readyjob-org.20230601.gappssmtp.com header.b=xX0gLuZj; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=readyjob.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=readyjob.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readyjob-org.20230601.gappssmtp.com header.i=@readyjob-org.20230601.gappssmtp.com header.b="xX0gLuZj"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1512227e87.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775155383; cv=none;
        d=google.com; s=arc-20240605;
        b=C4P8+IWTGRB3eU9JMCODhrR1Y9kP7/sy8LsyfowatEzq417a2s1g+RL1u5hnUfQdJN
         4l3reFJpQLmci6flYK1hrulLnGshqEkfwNHw5JdHuz/vpS3WyYseDsfgFaLSSi3xFG//
         BrGB2FTXxRv9Mi4PzNvMZk4JGe4oaOjxQMNrKW3a7r6SB6oI4HHXAIed4CXnQMnC7vTE
         sbXz8rvLxP97UkMgNqH6cQme2jfjJB1rp9rjlEblgQWYXs9zCcjkt5uK7XcvTNQ29lHE
         285ZzQbklEYz3PX7kBxDVD9okjlTrxePpceiv+EYF55OG1hrya4tUipbWGMfYAQfmRaD
         eE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=kmmwTFF2Z8rbdsKf2eDdFDME9TetlTgdqjB36TnGYzk=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=fi7Kcs1niZFUBuwWRDH5UF4QkkF30uAna8w1jiRjVb2iBW8LsoNuz/phi+HK3zMb5s
         1WRpKd+su9rwUmTpgAJ2K8RWjVsw0SKafLRDC2dtdL6HmD29iDOsxrsbREfPxXWJFHwc
         EQk6iNm16MqXwPtal9Oj3YCDlVRChM4v647fOdUlpiWbOhwveUrQ05g97HEXEmXI9scj
         R41WNuluCrrDeSAQlndL8RXNIC7GCuRxQtQP0Tq6xap/De3JG9sRDmpcA13KLdn/hTn7
         zyOlTyrbJ6q6lTD/HcxVVRW0/+m6VnnS0Dr/ECXSKTq2tbhpJYBvhM3bTn+UkwfPkj7s
         iiDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readyjob-org.20230601.gappssmtp.com; s=20230601; t=1775155383; x=1775760183; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmmwTFF2Z8rbdsKf2eDdFDME9TetlTgdqjB36TnGYzk=;
        b=xX0gLuZjr3FkITNM8fArkNG3tL8qgRP0tavs4O/yDuG5fFNr1Gy0pxTihKJicLYpBw
         76utOqcLAiS+Yyep85yokibxY6zH7q5p438WSaX5lhtq7ct2wqlPjvjg/1N8Jd3y7JWP
         d4pG2iry+ceG/7P46W0xpqh7BpB4lFzbdvkwt6Ur6lJfZAgbaF+l7f60EMM9JlhJr0Y8
         +grgf5qKRS6X6tS2r1TsrFnJZBegW8hoqi7cPLlO/Wo6tKuKOwzX/JIsMm8Rb+3BAaZC
         Y6RUvklDg3ToTK7lYguZmLYA8SpkA8wFLx9SBAba+z8UgWB1SN9igCjcvyBZJK48VC0T
         ofHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155383; x=1775760183;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmmwTFF2Z8rbdsKf2eDdFDME9TetlTgdqjB36TnGYzk=;
        b=XDxT9KxN2r9OLWZEd1gEkmh4qzP3Iuu9N8Wr0c1Ac712+uFMiLVcvIU8pUmJbtwkin
         7u0vEmaV0tC9gpf0YqXR+waIqlwcqZwHh0ctDVFcuFaHaWOlPcf360anb7FgqiL2cUvH
         0anz2myxpTlRqzV3+ls86+8i/syzrKk8+99txa1jBWcl59vPGU5oqYIecM0yzbuRUz5L
         DawHGgRkUIg7Abm2msZghsRCemU8h1lay+IWC5mHiR6JJK3cWsMqXNyroqCj3CGUKeTx
         i3MyWxvzZ516ig+oA876yEw3c+3zIpaRcT79AgHOsu+AyrdXX0+mv9tOG0r+/ASGgIVw
         /wBg==
X-Gm-Message-State: AOJu0YyIju5gpWUVTGghSHLISFq58AyEnkwPRTpERAkgmgMO2HjrePRF
	KxBmK2FTvjDreAMeud2+omhowi5Etl9lzAkyZ40WdFV7o+bnxgKkJGNDAQzeJN65mAO2EErXhOj
	caJ9hBO6grEQ3/AuDvvYWKs2y2YH1q41YCsRZQHNPopthPHZqnkg8
X-Gm-Gg: AeBDiesezaFzS/QCBxU59nj/op+Qr5yRBjSYd0Cg2Lx75swIexao6fRtHdS2F/1HZtS
	ucv0doHeeGWWF8GfmF4rteD+G8WinRSBw4Mlho3ZLwJnbJPIuhQlVKurfUBWqAkA2SiMmZoKHop
	CL4wmbx/IMZne8c05iNb2B53UAfN/H9aD+9FiXaf7eZ4n0rM0aUHWSCkhfW4fiYYbW889hVyG9e
	l2Ze5AR4xIevd4DKoA8qJ3vTs8N7wH3wMykh99yXjsmIytjzAobuja25hniEadkgHLw0g5kHwmP
	YwIalLI8A2NZMrzhVEQccfJAZbIEcp1YzIA+SdvovnjfGgmjNA==
X-Received: by 2002:a05:6512:12d6:b0:5a2:78f8:60aa with SMTP id
 2adb3069b0e04-5a33758f27bmr29491e87.37.1775155383371; Thu, 02 Apr 2026
 11:43:03 -0700 (PDT)
Received: from 78192629662 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 2 Apr 2026 14:43:02 -0400
Received: from 78192629662 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 2 Apr 2026 14:43:02 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lexie Dy <information@readyjob.org>
Date: Thu, 2 Apr 2026 14:43:02 -0400
X-Gm-Features: AQROBzDo0upobdnELvNptnFQRhU9-G0XjGIe4BP3IvYmXQNk-LiWW06M-noO9pU
Message-ID: <CAMBFw2gTYbhhv+FCGie4=B_-49Si2Jo=sbWBN41-xUCjUh_xmw@mail.gmail.com>
Subject: Re: Article Proposal for Your Audience
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to circle back and see if you had a chance to review the
article I proposed. I=E2=80=99m excited about the potential value it could
bring to your readers.

If you already responded, thanks for that and sorry for the repeat.

Thank you,
Lexie of ReadyJob.org
