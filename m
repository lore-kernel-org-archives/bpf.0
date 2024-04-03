Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F91FA4
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112615; cv=none; b=QVOCM+evzF8IFlbSevl+l8rxLDFY70IwPr5Y+htRE8YLKOyQtOFGg/35ezOWcYENpjC+6nnHAD72tcELOR6lrRoghxddaUFFP5LF2W7wCKjlNEjzD+gedBZjMvpaqcU1WcdS5w2HLLpcpgfr1rFxMzpYm3SA62MkZsdi4fFLMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112615; c=relaxed/simple;
	bh=ThoALAZ+4b5NoYvDizMBhILluvfgE883/n07j/5mT2w=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=E9IpC2rRi0q7t00bdYDnRW2XJR8Csun0aL7mvsZp0dr/T0Hw4QCcCL5VEz52zwV+Sf+zkasEXKUkCm5dvReud1FdAAOC/ZhrWpu7Wyl8yxAws0/cRfTzPwusQTQlcXbAarZwonxntUKS3zg9rBup6W4D17dmEhNZq2mdLsZzLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md39xUri; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md39xUri"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6156483284fso1029087b3.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 19:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712112613; x=1712717413; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=esQujNotzpB4+xsRiLk5kIgcIfES7Y96ccLY2u3mHDU=;
        b=md39xUri/wrfp78vfgkkkAauY7/y8BXiPspZ82XsAKqbWkD2Lx7eUNqhTH349G7OL+
         6Q2rGI1liEeSTHSr3lsoQaAsk011FVN8WSgyjGeKnJoIYSCY5vsIxFfUYvMFazifkdqb
         U7l23msPt8eM6p2rj402fS6TAn/0BnV04rpeJIaRANxxwgIjjbWyCJ9FiSSjqobV2zKu
         1tBTUdfNcSoyCWXLHcejGETl2WLdS7w59Jogsmt0PCkzLJgTfpBfgNaA8MxRhCE6iabz
         UNy3VHULQTewoneh51cYc0364teOErnUC80Z6LkCEfqunbPpon1HqrmUDSD5LTBHo5Mt
         vkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712112613; x=1712717413;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esQujNotzpB4+xsRiLk5kIgcIfES7Y96ccLY2u3mHDU=;
        b=WKAHy+RLBWUOJakkUbxZ20Nk5gjH0j/Nlm4LGiPuHZECbcn6vFCJ4vAY53XhCl/fye
         GFdyiBoDU7gr7Rdtr48LnM9g8pU36TzlWfgMPN/CINC9m2cl9jqxdOD+vLHh+Tkjh7Xf
         q/DwXCbV/cVExv0DAubixSGoO7vikUnwnW3YdcoHz2/t4osIFgEbxLdIT4vb9/b/q0ji
         r5BisnPvidmYUnNxI+HkH9Ec8xLsaETL4emK5vaeObeELruSCS6OefQ2VA/sHekqt+NB
         XPDOMUX8Q4nwtjVukfKjXrooNuG59xRmqY60XjOKAoU4RcTEb2wh/8Kg5QArk8vvUR+p
         9M5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZWYXazOOWw4Ruca5kEA+4Z6W9QoITz2PGpfRfIEGVySxjIGiFoLBXp1h7RZYDba/WHvMn6DRXC5+MWmK3os2ED854
X-Gm-Message-State: AOJu0YwThGWf5+Wq1vI5WBzICRGAWS8Vpd8Rya8iZ5TX+NvGCg5lDNbE
	1AZs6oIga5R7iToWm1SnbWHc2pb4LF+D4Oc9LNjFF+foxYaZ7HP5OxbcCqfb
X-Google-Smtp-Source: AGHT+IHkGRhGvl7332WDpIeqltIN/HxtoWtFo1Q82rZOK5S8YBpWI1IyY83BfJqK+4eh5RL9eSTquw==
X-Received: by 2002:a0d:f9c5:0:b0:611:278d:fb80 with SMTP id j188-20020a0df9c5000000b00611278dfb80mr13731273ywf.8.1712112613171;
        Tue, 02 Apr 2024 19:50:13 -0700 (PDT)
Received: from smtpclient.apple (45-19-110-76.lightspeed.tukrga.sbcglobal.net. [45.19.110.76])
        by smtp.gmail.com with ESMTPSA id t8-20020a0dea08000000b006145009cce6sm693712ywe.8.2024.04.02.19.50.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2024 19:50:12 -0700 (PDT)
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Provisional registration procedure
Message-Id: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
Date: Tue, 2 Apr 2024 22:50:02 -0400
To: bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)

Hi all,
  At the recently concluded IETF119 bpf WG meeting, I had asked a =
question to Dave about the Provisional registrations for BPF instruction =
conformance groups. Section 5.1 of draft-ietf-bpf-isa-01 talks about =
Provisional registrations, but does not elaborate further. Specifically, =
I think it would be good to cover the following cases

* Do we allow conversions from Provisional to Permanent? If so how?
* Do Provisional registrations timeout after a while if they are not =
made Permanent?
* How do we remove Provisional registrations? Are the codepoints freed =
up?

I have opened an issue on the issue tracker for this at =
https://github.com/ietf-wg-bpf/ebpf-docs/issues/113 . Comments are =
welcome and greatly appreciated.

Thanks
Suresh=
