Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3849EC78
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049210; cv=pass; b=BjtYY9kFZSYTNvF4Fut6xq640ZG8y9gHS+cqdJEXu5JGiSZ+nkg/R0okeB8gBHZOph+3Q1GXnrN2ggRqYt4YwppOOT4ADH/KH2dIXWYFFKu9735uyG8Njyd1KUqrnrJVD8dD17P1hjIaLehvFc8WBIvWKCHutllEPLvvloWzBug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049210; c=relaxed/simple;
	bh=pzpFpl7Wx9jF9qqMRO8d1Wdx7/UsiQl1wjjaJS94DoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y6HCNERrK64Q/43mkfUPS2ChJJbWX7MQ1nt7BJjG7FuE+poAjUtEHmOiZ8SIh/r5+HujNm1HYJPNFO/jCFaLvYub6v8Tcu0uX0bpigwG/2OCYy2L/XWYrH1Liv5lZ9+35MhPDk0F8+iVZhlTN2qX3e72fvM4xWyK7O/aZ/UMzPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awKpGYfE; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awKpGYfE"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-782df51b4c1so5266705137.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049207; cv=none;
        d=google.com; s=arc-20260327;
        b=gbyBTZqVzId3DduUVPenJncDAGVoHNlx5jVjcRo13HrGN9LaaUao1Hh/GGZzcLDMpl
         syUFGo972ZNeKj731bmtwIP3bqyK1DrRVoSrMEEO/xVkrj0hWFCLAxsHwfgOsT48NlC4
         Ec1IQnmQ3X6lQbI6M0rRwu3OTUjYYgwOEb1XMFavhRmLNnzHSnReDRJWLkZNVo/EUG9Y
         QSEyI5C4W6G4JKwRcZg43jlDMP+pFlCs+dvZetvzBXkMrsUWVcS9MzW5dJ9NX5IsRBad
         ilSw5tt5z0WhBmiupiqL9ymeyQrLRaHxokjFuuEryzDIafEaZkiTS7c+4k07TOm14RfC
         Czbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pzpFpl7Wx9jF9qqMRO8d1Wdx7/UsiQl1wjjaJS94DoA=;
        fh=+qzP3FiGtlfJNkhyWIWIdn2K8IdJju8S4nUuEe52rjU=;
        b=XfGtNQtLVL8bO3l3rUgMatLU5XzdQcAFsfqmdwdh8ZqDxPsyhekZfjYGyp9mNsCiEo
         At15YhHxZoLivyJ+qPD3Gce21OlJqAOkZ1r3A9WN0zPUybDfQVuU9gw0QnID3/755Ha0
         p+7zq9L4dp9vGmLG55KIwHq3MAwX56Pdy2jx55+rxtoiAJU8fEQeyDNQISlzwYW5xhZi
         tfL5FBnzEJFgRcPg8bSConuMCmCU7WBDBYCKuU75oW/kJ9QPaXsGGG1mkWdRVmgnSd42
         CIepGRd4zKp9QmJiEBXZguvps9vkbDsjKlNG7fKVr450HZ+jWtsTdycl8alK7oKAu+KE
         ZZQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049207; x=1789654007; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzpFpl7Wx9jF9qqMRO8d1Wdx7/UsiQl1wjjaJS94DoA=;
        b=awKpGYfEEPrxFfSfXz4oObL369rPijR+bBsQDikjiKPce8WjZdls4hNs7ebADmdXuQ
         Pk5ohZ5CzmUzBYv35/PPTn3+K2O22dIPyfasEXjQJIvOgNDJetBblV34FpfTLNgEM+dY
         vNLW94Nteyh2S//fyemo35NiygnrtBHsPyX88rBBmzGvc4tLD/3cVHIsTmr5WyZj8A7g
         5EyvOiiIawN4Zv63fqxTZ9zIYROKMDgKHccFKfekdBPn1lgy5BzBlxo96slbqLzFjha2
         hZW8Q6zDq1tGR74lDyTGbnfSxjXcpWKy0wWccPTKXvHXITBq8S+MpIuBeHcfSuvNYNx8
         zJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049207; x=1789654007;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pzpFpl7Wx9jF9qqMRO8d1Wdx7/UsiQl1wjjaJS94DoA=;
        b=kSYXjNSmwldsZSomLKSM2wy8ZLIeLrpXwxhe6MXu4Jf5BooLpPq2P9TFwshZrNESUG
         tLp2sunlEM5fsctRcFgxh3j3rzkio3wn/y+cRVflDqBdQPc7/TkLI6yPWSm0dNYeDFjp
         odYmcPJMKtAeMGaWPoDjKFrXRZO38QRZilio7hjvr5EP5lL4gTzH8D1BOTCZ+RmKrC+I
         86MFNedEuFyYbr5gtAFj0Ul47CN5vP/ffx6zJ/420dK/5WV0BrXCNGfWL1zjzu3lQpqD
         MKQTHPstoIr7MY16zRBZ4mFG3UIQ/l9g2HwcdfShepGtKDIkQVV0WX9aqWeCFxHxmtZh
         xVgw==
X-Gm-Message-State: AFuF++m6OhbugNozMwNfm58JDJFgrIWnvC1HHWJ0HSDtmGzI1WJVmtLD
	Y9QpG9oNDZx7Cg2YPrPvaSxXCTSSQMM888CCsFTegmvAIT26zlYy/5wPhTo5IV6aNfFa153dlUn
	JRbsJkUmmXPx2GNGG0iWyN0Mgnu0Pb09DqQeZ4U0=
X-Gm-Gg: AYBFou1ui+X0yGy6FE106Ru56ClS2pvsXXJXSTCowZAg2/HMC8NeJfLuhm/+p/ggnF7
	rfBAwRBdjJg+Z7o6KHigcpfY+LkOxRVEke6w2Ql8t7JaOMSk73Rv/URVM7xprHJEJA2LZeE0cms
	CCZdJsS2jrNG+TYIrUR3eqQiWBD+saB045ZoipxrLqp4DbiHhFhAEPvvlDlHspc7m68fiBPp1Hq
	dTeKuJqFZKSYjO5t977wIDPdOMrmjdC9iOXl316c+nW0oooB7tl9ud8ztMHztJnjStoU+MpGUNj
	H/g8eE/W5bw/e95Jn79QXiRK4ElMj2O4fV7qgdrxdSs=
X-Received: by 2002:a05:6102:50a1:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-78a4aafe94dmr18450564137.13.1789049206974; Thu, 10 Sep 2026
 07:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daksh Vohra <vohradaksh4@gmail.com>
Date: Thu, 10 Sep 2026 19:36:36 +0530
X-Gm-Features: AcwNN1VC85FZch0Kd-xBsPUt3HPV4oZDdo0HBKpbmJ72Jy_3S9MiH28pU6LLNqk
Message-ID: <CAOgkP-w9MqFwZs-rgVPAky4r8oih_=Q6rzf=kwpwhi=jr0wUPw@mail.gmail.com>
Subject: [SECURITY REPORT] Logic bug in eBPF verifier (reg_bounds_sanity_check)
To: security@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

 Dear Linux Kernel Security Team,
 I am writing to report a logic vulnerability that I found in the eBPF
Verifier subsystem within the latest code in kernel/bpf/verifier.c.
Summary: The function "reg_bounds_sanity_check" has a flawed error
recovery path. When the verifier detects a math or range error (an
invariant violation), it jumps to the "out:" label. To prevent an
immediate crash, it calls "__mark_reg_unbounded(reg)" to reset the
register's boundaries, and then allows the verification process to
continue. The Problem: While "__mark_reg_unbounded" resets the min/max
range boundaries of the register, it completely forgets to clear
"reg->id" and "reg->delta". This means the register still keeps its
relationship link to other registers. The Risk: An attacker can easily
exploit this missing step: 1. They link two registers together (for
example, executing R1 = R2, so they both share the same tracking ID).
2. They intentionally perform a complex math operation on R2 that
breaks the verifier's invariants. 3. The function
"reg_bounds_sanity_check" catches the error on R2 and resets its
ranges, but leaves the "reg->id" alive. 4. Later, when a conditional
jump handles R2, the function "sync_linked_regs" fires. Because R2
still has the matching ID, the verifier will copy the corrupted or
completely wiped bounds of R2 directly over the safe bounds of R1.
This creates a serious type confusion / state mismatch, allowing a
program to completely bypass the verifier and perform out-of-bounds
memory operations inside the kernel. Suggested Fix: The register's ID
and delta relationship tracking must be safely cleared whenever an
internal invariant violation recovery happens: ---
a/kernel/bpf/verifier.c +++ b/kernel/bpf/verifier.c @@ -... @@ static
int reg_bounds_sanity_check(struct bpf_verifier_env *env, out:
verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s
r64={.base=%#llx... if (env->test_reg_invariants) return -EFAULT; +
clear_scalar_id(reg); + reg->delta = 0; __mark_reg_unbounded(reg);
return 0; } Please look into this issue and let me know if you need
any additional information regarding the tracking mismatch.
 Best regards,
 Daksh Vohra
