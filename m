Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8011BF33
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785730030; cv=pass; b=BtBYLpeCSGO3ZJLK9SQsnt8YT37oT12EyZMFBTT6gRmO/6pYSPyLD6aER09Tl8obvYSzSVB0NO/2d4/h/GI/8tDEmnvnmjJ0x+zCM7npJ0/kPbRsLzHlsIkqq44l4/2UQHIY67Wihe+YFkX9P8hfCKL4yyZrZuoy9aDlSchFfiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785730030; c=relaxed/simple;
	bh=1iOnBbTKxIxEgOnGkXUG2N73Qgaf1OlOeZ5koNqXAGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL7uIbIM8aI8t03Xu3y2uN6FAIu0Xc3yCVAhP3u8QR63y99RVWFDcDIIH7Hrefov+/krpyBmLgmViv3OllcZtL3gjfrvUXNobXYEDRFpmJmkxI/aMWSqRg5VNC5I/yqcKBkFXUywdXKrwMyZ63i3+1oFIDRUhGwz0ADyWTMPfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnbE4/AL; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnbE4/AL"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3318319e87.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 21:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785730027; cv=none;
        d=google.com; s=arc-20260327;
        b=fFCBxhWevSEX+JHid/UDhOlHeicUdfwWSJdHqeMOb+CnTH/55aag4TaW7YLlCJ1ydT
         BfLN88dcUxHtg39JHz7dmswx+UdxQu/K+Xc+JnBQ9FrJwip+YsSgmr0slERagXXJcVYG
         Afp1lRXJCAtbTeycTL3RFGcuoKakgtDjOlP/bXxaXgmWt5RWai0Xfy2JCYJewP1wMGBi
         JSn9GCxFY8WzJUdkj5hnBfsJY6HixmuB9y11HhOYuSyoMeOh197AdE7dooBB1Wd3+3Ip
         Q012s2Z5DuW2mhzaYzixkds6gYKghcXatWUbjs6DN1KEjHjs2sHoIWqx43SZLX0eGlyZ
         cJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1iOnBbTKxIxEgOnGkXUG2N73Qgaf1OlOeZ5koNqXAGM=;
        fh=6kUPJ+GxVgkMUEPRCVk9068npD6yStNJr5jsFlmn7Fg=;
        b=Aw+CS7E+hAYwf1f5EwHNUSln5Tq9wsqLAE5/h5BFwni1rph4hE02egrziKqXgEgh7Z
         p2ALIEZHjqt9MRndocL71pb/0CKBoHHac5kZ+dcxdVgL9joFM8KUaMAA37BTzu0WsLNa
         bKcPuqurIfZzoZiBUIxIDer7VhVEavq8qxf6Gdxhdo0u+zaWtH/sfJ1fizpXjTgMDMUe
         aTYeGF94EQE/xu0ZgU4qR3TX1LDFiSb9vl/pRieFhdQwNAN4iKanKRRK91m3HWLlrpnG
         GmChGxGLaixtwzt+2HUkFnv/dwoAbWbHeZ20tYNMkiNKsZHt4HyTrtgGhH99FtUS9qml
         GAIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785730027; x=1786334827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1iOnBbTKxIxEgOnGkXUG2N73Qgaf1OlOeZ5koNqXAGM=;
        b=fnbE4/ALckfADf2sLtiZkYW/xVOmIiO9qyvyKjxaviNfF+obJ4+/NvwMoXm40rv6Y9
         28OqHF+shUtoxEBQUanbH0uHVadNVcNs2yDX1GF/ZB5j+h1oG8wedqY5eMwRePqkoOSI
         3R+fVSL0GkDdGlYkCsmOeo5o/VPNhRaMTInDVWuxUP6S6yfZNMLIzgEMbGqIwQwUbFKD
         PtcOt2oiALhMXu0SryI84tvNAIdWYubnDXGYu5za9sTTFIf0J1wUA1/xsiajm2yfrXF7
         Zcb1Q0JJfRfBomSYGMwBboaG75/WmLZabgXWDFE3ctyz38lafiubnpaAmveyq2cEdlBR
         /p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785730027; x=1786334827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iOnBbTKxIxEgOnGkXUG2N73Qgaf1OlOeZ5koNqXAGM=;
        b=oxznQUDouBMRk0NFed3oOZRO7+wsItILX+HaqrGob6vNE2INR2cVZI3sUl6ALjvYbI
         2CI6V+zKSOoVXRQwrKqx+lmV0WPt38QlEZuTg7F9gI0sVDv5IZDRSOKvTkm9NF4pdIj8
         8CGrqXfpsChrE2qWnxL4rxu2EEr6EdIhmOQyec1+LwCVJFCGe1W6K+6AmrVNLXB5qVsv
         ihAOWkzID97AxbdhQnxZXyI+XSyG3QpYhbYPQNhJ72msPwFEcJNdgrfFGCebkL9LY6fI
         6Nc8DMnbD7Y6lmttbZB+55qO7d56xE8t7d0XoilYYw+vVra/xPA6DL7t/7b1bhYH+FNH
         ppUA==
X-Gm-Message-State: AOJu0Yw4gMIds5WKn05Hk09bUastC8lxnXTl6R6+3fO2sI217NAqJC9X
	OEv+g3qv6M4rnwYyqmOHxRqgLqwz+IhN3LRoH63VaSzyXmuzIdRgg1Nl0Xj+7wL5yymuKhP7pnZ
	0L5mgTmaksrMZDzdv7RnX3BOe9DZVu24=
X-Gm-Gg: AR+sD11q7i6XqqTVhvLVF1rNlVbwTQUiVSVUMy8ZNgFWuM7JXFy/NNaW40LJ/qMCS70
	+RKVoqZfQtFedw36XHiS2EGoBINKNe3LxZCm5VOsCYynZrTEA1y1IwrX3rK6O0egiz5jvvjuRid
	FI4iDx1G0AlmCk8OCGmq86eXbN5yCE8qTjmFIloy66G4sDJu1gejRSucNUr2rCmMg+9zCQaBVx/
	Ilw0C+olQgQmaKO1rNwC/P6Vy+U0t66qy0BaUxMCwI/jKRrNL+tmZxNRSClFNhwc9wqURoCD77t
	jWlz5Shi0rUuCYLm94rE5wKw5Ph95tnN6iCuNzFp7QcAscM=
X-Received: by 2002:a05:6512:10cf:b0:5b2:9358:b854 with SMTP id
 2adb3069b0e04-5b2e4f76d9fmr1341444e87.42.1785730027321; Sun, 02 Aug 2026
 21:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726021304.97ED91F000E9@smtp.kernel.org> <20260728033837.1466123-1-dingning04@gmail.com>
 <DKEUME1DRKOR.2R2XVNQDZKVSR@gmail.com> <CAJP4iuumoLdD62rXf=3HexiKVoKbXHJka7tm9+Cw-LaKmuvC+A@mail.gmail.com>
 <DKEYIUKP4IPQ.M7KVG0KIIU1E@gmail.com> <CAJP4iusjn58Uo7uE8NzicZQmKoips9fu8+bV0jEJFUNmXz8K_g@mail.gmail.com>
 <DKEZLMC43IZL.3IE6NNLQWJI0V@gmail.com>
In-Reply-To: <DKEZLMC43IZL.3IE6NNLQWJI0V@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 2 Aug 2026 21:06:55 -0700
X-Gm-Features: AUfX_mzaQB7TAxaY71wot5WebNPa-yhVeaNtebXeREzVCmEWg-QZmD8gKDnpXto
Message-ID: <CAJP4iusveRqaScJhLJhdkA7fLXZu74_W0MJN0YuHo=3Et5e0NQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject writes through untrusted allocated pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, 
	danieltimlee@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Why is this not enough? 'key' is scalar, but 'res' which is being written=
 to is
> still a PTR_TO_BTF_ID with PTR_UNTRUSTED.

Ah, right. I was testing against Linus=E2=80=99 master, where that
PTR_UNTRUSTED write check is not present, and I missed that it had
already been added in bpf-next. That patch is not necessary.
