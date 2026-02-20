Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E22727EB
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618065; cv=pass; b=hE+WxORoaHPrP3MII4bRa8dOko8nNifR29YC9zzvfI8vEW1s/Z7i5McVJqELlv435gjXFa/MAmaZ7uuWzrS27n6YEytQXFGeANjumjmLeiVGIhpV7bWGXhFdc5GZ0hMzVKMfcrO606IG5/RnCSP7r0BIDskZ1JSpOXFGR4fwxt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618065; c=relaxed/simple;
	bh=J3EcQu4ynmGoN9y5O6DgZ+lVdcaUpe+y5zI3qy/wZaQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KYC4xtdLJzR1ctc2zlYGdtp0MeCJ9XpT1S6aWeQo+GTj5u4tcIMJc2hOOUuB6L18x3ZqBJRKzivbbAl/jo3/2y+rwALzNMV1AgOFmYBEteN5lvi8kcIIKbwDsh1MBxAaE13mG6emjL8EhR0gx2vg7ZuVeEb1TBf3s2SQ1FerCok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smartanalyticspro.com; spf=pass smtp.mailfrom=smartanalyticspro.com; dkim=pass (2048-bit key) header.d=smartanalyticspro-com.20230601.gappssmtp.com header.i=@smartanalyticspro-com.20230601.gappssmtp.com header.b=xx1j6DPa; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smartanalyticspro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartanalyticspro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartanalyticspro-com.20230601.gappssmtp.com header.i=@smartanalyticspro-com.20230601.gappssmtp.com header.b="xx1j6DPa"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38709888abbso19760951fa.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 12:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771618061; cv=none;
        d=google.com; s=arc-20240605;
        b=jUIct0YqHNs5mZznt6ITvm7B2HPaR/PzHdnz7FcNfyjxCnVcDEk4p3ke3GULSoaIyw
         SHiRX7Bo/8RA7SOevH7KcEGf5IDQtjEAN0DdPvcXdQMljT8uWBSnUspuJhX/KEROtSb7
         Dt9YUlV56dZiafh8uEKKdGDxUTFoPQU7uKcILWhTR9+oV1yAdtTtnA6UGqQx2evJi4Vw
         JwwAWIBQAjYd+icwBuOFIchVr9hHrSpc7An32MToqLgiN3LtO0XVVt6LjZU3WGlZ8ePr
         GFW+DV31oJkDZLHyC8EW5eKq8289Ju7B3n0KBStSu5kqNbIWpGbMPwc4syS1WwmULbpW
         2kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=J3EcQu4ynmGoN9y5O6DgZ+lVdcaUpe+y5zI3qy/wZaQ=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=AMaDDdQMC8vO9ou8iCaJxSsCdF5pWjm98lfyZ+xc6yhzYuWMmz2b2EKLwLuHEWfMUK
         2LTTwSe5jbQ4h+rkQ8FzGXwYeU9wykClCtW6nkHjMzmgENsHowxlwr9yXC2ESSBFkcAt
         2Tb15xh5G4ftwk04Vby4YeXlR7Rb+knN+wqVYWOgHoPw9So4whLrauw1w9s80bUOg7Ew
         umqT6AuxmkgfzeSZVee7YdWJ09COY8Tgwgg4mE8YFgRNRtfByQLRp2wWdq61mtEGHToq
         BU20RQl+ODf1B9sd0iUctzhdNqDUcAaVZ3UkETxdfO2RpBvrghAOwI4YOaooHc7J9TQW
         3Ffg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartanalyticspro-com.20230601.gappssmtp.com; s=20230601; t=1771618061; x=1772222861; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3EcQu4ynmGoN9y5O6DgZ+lVdcaUpe+y5zI3qy/wZaQ=;
        b=xx1j6DPaUgi+AhfEn5gFgHzwY6m5M2dkFuHd+7w9qAsU++swf3zYislG1YiCMjFoE1
         9FlII37Zi3C8kI5FjUjmZ3APab4m/Ew9tzJWZGiA4gJZF90x04EUMurI2IoBjKnzKaSr
         k/SJn7vPt8l7SYojczV8luD8mhbox+iI+ZlFbVkJi+LBWZT6X6SmWp7NPksLNN3lsKe4
         aVCpQGCLWrfSG0cYTRpzVjbNWM5raY12rI8rwZzfl4UBj8nmHddhUjFeb5zo0gW4O5nN
         ww7qLPEavNh+yBkOzipRFLksn4jy66TohBarQIsJ7Io3QJqn1nn+mWWjF/3/uasrVaTb
         SMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771618061; x=1772222861;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3EcQu4ynmGoN9y5O6DgZ+lVdcaUpe+y5zI3qy/wZaQ=;
        b=aBeEb52b2GvOoYWnbudcKubktHXyYLKSVT8Int2R0ALm49BZDAoraqpCOoiTaUUlAQ
         DLNIehzsoufH+PGjXHJPSnYS9jxEKl92utVMm50Eq+Dm+ycUDaLRX4DR6MqL+FqCMfPw
         VYrfwyyR8Upp5bNgXHKh/XorqKkb85s8fVcw426yAzIOaeb7H3KweQKryg0e0W85mHgI
         ODCwghC0Xy9CQYmddJ9rBYv3KELizaHp+6p9o+nzxIttmwHdlhwkgoNR6AMzWFdVASz6
         Kv76Ye7lxi0N6g3ZpgKURhlj+D+b6K5lxGXLM2FJybxHoY1Obg+dMewRTO/ge0v6GuOD
         gYuw==
X-Gm-Message-State: AOJu0Yyfu7LWVVKsTU3FqwMA9TLPw2Ihj+exfHi/H5twMjBZnHjD+tER
	cLfkVRFtCNkGehrxNsZuuMpNYOMAIOviXFQ76ciwpQ94eswakuAy4JIpsYrg9ChqdqFvSsTlak7
	kCavhULwM+e4JVWiOPgcJXTATQ/84zGuhIm45PgxLOGUhhRnP+U8/
X-Gm-Gg: AZuq6aK4J2JJqwbc34XnKVJ5UjTcvKYoFZXao5edMFvCTpuFck5KBn2CJoN6kDu+nap
	LXDulPB3F9znOUPFmoi2fuj8Wp9D0T0XpH+anpkqym85/Upsva5XiLN/pdNQvym9m2j+N3HAGYo
	PnUPpFEObETise40jrkla1XC+07cXLZrcdrSwF8BsxARFO4XBgXbJqwGZWN6q2k+D5L950BYOnh
	/xQUQA9JdjqYUKh4h5sC+g48Y8phVG3FSpFtIfRrbSMNa46R2HVCkFfc1hygWZM7Yj9P278tSEU
	/W1E9XQ=
X-Received: by 2002:a05:651c:b09:b0:383:f7:1064 with SMTP id
 38308e7fff4ca-389a5d6096fmr2065311fa.18.1771618061163; Fri, 20 Feb 2026
 12:07:41 -0800 (PST)
Received: from 346534542174 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 12:07:40 -0800
Received: from 346534542174 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 12:07:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amelia Mendoza <amendoza@smartanalyticspro.com>
Date: Fri, 20 Feb 2026 12:07:40 -0800
X-Gm-Features: AaiRm52o8VO5QNMMOfM97b6_2Pl3nC6Dvl2d4YQC2YYaUeMKlBzZK700x611Fi4
Message-ID: <CAKpurm0j0X5ROb1WsHZj-YLiAqOHexHpbe-OUQepVCa3CH9acQ@mail.gmail.com>
Subject: Exciting stuff for your site
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Have you ever observed how the crucial work of IT professionals can
sometimes get lost in translation when presented to non-technical
stakeholders? This communication gap is a common hurdle, but with the
right techniques, it=E2=80=99s entirely possible to bridge it.

I=E2=80=99m putting together an article that explores methods for IT expert=
s
to simplify technical jargon, clearly demonstrate their value, and
build stronger relationships with non-technical teams. The goal is to
help ensure that IT contributions are fully understood and
appreciated.

I=E2=80=99d love to share this piece for your site. Let me know if you=E2=
=80=99re
interested, and I can send it over immediately!

Looking forward to your thoughts,
Amelia Mendoza
Smartanalyticspro.com


P.S. I don=E2=80=99t mean to trouble you. If you don=E2=80=99t want to hear=
 from me
again, just let me know. Or if, instead, you=E2=80=99d like for me to write=
 on
a topic of your choice, please send your idea my way! I craft articles
that speak to readers today and remain accessible to the AI platforms
of tomorrow.
