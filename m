Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64479349CCC
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010353; cv=pass; b=ptSbFgzqVdP1g22+E9JCHa7DrxQNEEXqvQS/Rv4i0vPI2Pyx04qj4vXl4zhiilTRVi5y98g5ZqE/crMuZO6Ek8NsK8zvVTYULI7FHZ1AuMsyuQk/hkuTqLq2bvE+iMEhHDe0ft408Q2gY6/Dxb/qf/DAmeJtDlU2Aiz/Us8YxGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010353; c=relaxed/simple;
	bh=kOZ8synxEF/3k4EYSZuoWFK5xyfsCIntb32ef8ucf3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hMQC6ZyEoUjeTUEt4aww/FkVevXzqA88/fOdGtSQRrEvEYO/g4fnD/MI7RaeNQDcm6mYEGnRtxdsIK5CTfjPpvVuXUJpXRsiLcdwNlR5Be3H0GdUlRtg9OA8ut1Mfo/V2Mr+Kltym1TI/Yb8kIPPM0B8jOwW4AZ5X5jHdrY1f64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdqqvMX1; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdqqvMX1"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1036062a12.3
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 09:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010352; cv=none;
        d=google.com; s=arc-20260327;
        b=iuAC+WBEG3AHDnjZe2EcHakRZ9n/+/drC1Bha0ZYCBcbIeGfhkDuzLt0i/iFv19V7C
         s6vt5OMY+EDT+XMCRnGSegHtrp580WLvB8B+bNBogLFhxIssz2fsoDS1TvGVov6I/AhP
         w59z8KgwktVwEDE/jNjm3sQM5l81S9AEOQV1PakKSBhFo+FtFs94VAOGE9hhZyQDo8Z4
         npoqbAp4Y2tkLcU7lRgmswcVVnxGw70tGz63GVMDftzFys6ErNfIEZqvL8rAkZDM73Rk
         xzibc2EFuo4vvO+FfHlX9bUVQoT/UhAbvf6UjHl3rs9V+DauRg8//9eRfcKHebNTZftM
         BOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        fh=GWqGYRyc4Zk/I12y/N11k3xChOs2EJqY5zB40Njed9g=;
        b=C+9fJ/Fg6k6TEMN1W3JFQyEpXf0u+eKA2TvbnVhi1vwV8zh8UYwvu73x7+6fKQ5+Yy
         8yz6uErPRO0PZG7qebW7qLLHwxidYBjfOt3JFJns8teVxbAYknYnZ4XLXXdswDlkbgcB
         2+r7HluJI1iJo1NE5RYKuXI+0jxULtvAkPb+r91gVaWNJfGdkc5N01+dUK0JD9eqrGMK
         FvQD2C5sgfQcPU8+VXeGBD1Kc/06BvtsRB9T89CKNwYexunAD2HzEnB0FUoMi7KoLRjG
         B8uDmGzCDr8TANvdk7LMVpOwe2b4lfv7wL2ncK7rrIuWEy6GZshmjsTgu/G5Li+tYjeC
         ogYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010352; x=1783615152; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        b=ZdqqvMX1k7CcPYyRt2hWpU+h7WSDpkBEB4mhJ1OEJFG891v8wcrJe01IQOCwdrzRia
         FVGYOGeDArSn1ySn4uV6aN6HpyCdwnkf8JirlSTk3RlLwNxrMrKuv82T+/KWkaDm5kHm
         gKd9wP/l9cDtmHQBlutjoOdnwYLEDiqvQznFOu5Isrst3bquEl/EtoYdNzi7JAcrLsO2
         cRne0wXr4Su2TtxzMY/QFeNf1onfspTFhTNypdEQVB4W6nbCa242rXhBvq1uDAedmtAG
         JsbmZX1dPsQ3hKMrIwcKC7zqKpKuMTDUaUsEFmqHREiF7rSxiPanHLvLbqoQBjo7dHlZ
         I1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010352; x=1783615152;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        b=MRQ60iwERZyBW9DVJuBoR/i1Tb1WDpeTiStXJYiW+yV5xOU9NVmQUuwSG7OGnrPYAz
         X2S+zfO6HkI1cU4gFCOuoiPAJEwPIHX1XZ+BQD5Ui596sF67LJnKb9kNdSEUkQROrlF4
         rW6FflMkKumBimJ3v3qikkUhYzXgQXAHyWuxBobCwpb1OndEMWCPlwApAZr4yjmMxCeu
         0SLQS6LkhZnkOrHKEoQbCA9tONuwo4bPo8th0Ycp04n2/8Z4LKMNg8dtMFdp1Kxid6/S
         uvlPtQO6YLscX121bCvIQ4YECEgQiIXo8kiBcEn85mdLjMER8ne3xSn9kX6Exf/U3vZ5
         G//g==
X-Gm-Message-State: AOJu0Ywzq+RfjxPUT4LmhCVxmM+ACNRx4/gDrcQpO1d4ZOfgntxoZbgm
	8p7+kbfGeGSviB/4y/KScjYAvVujG/tCgqeoHDfwyjcmOZ3KiQdVpRRISMpwuUckSuxFTrvH1D+
	DOXIbqLmkJMrKLFikDqu7/7Fmw5/f8rfQYBOz
X-Gm-Gg: AfdE7cl6LL8YLFzGnmfoD+ZalhOTI5j6pgpJvJSqFHzAcLJh0lYr5+gfaE+eGAu5rRq
	NiVp44KfpAc31l+xPCH6+rd0wb1V/qqWgvc1MfR0y5XmqJkRoZKB7HeyPim+6QxFDZKVLHvHKz0
	QJj8Ulf1loor/XXDFBkWdoHUIrW4+qHZkLB9If0EAQscuv5B5OXo49+acyo890WERpxa0mtNbRp
	3wYT6GS6f/IBJ3UISAyLnNa9mJgKNMna8ZMMXfJ12AmIRpD1ZMaIXBCAwOnMGpSToCFmQmjIhQ6
	7dZAJ36p+QFkYAZN544A8qGX7xtJPjr+PKhMVAaXyg7TTbvW2adILCJKf6Hd6bk4BCk40Qb651e
	jVAh2Gy/zo+FC4kPQw48I1UOn
X-Received: by 2002:a05:6a20:549d:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3bff4222b55mr7906831637.39.1783010351482; Thu, 02 Jul 2026
 09:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Jul 2026 09:39:00 -0700
X-Gm-Features: AVVi8CeLgejTui-Kppz8NKnSDw3ifQGD3gc9ZGh2g-tg_Ec2Wak7dGPaK2nnMCY
Message-ID: <CAADnVQKsM8iOGO3ZL3LgbWigOBBMrGbTYZ_k_Ktz=+cVkvRLXg@mail.gmail.com>
Subject: [ANN] Summer vacations and "Won't Fix" bugs
To: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

The summer is upon us and many BPF maintainers are going to take very
long vacations "surprisingly" at the same time during July and August.

As signs on freeways say: "Expect delays" in patch processing and
please don't spam few overloaded maintainers and reviewers.

We see a lot of AI generated patches where human took AI generated bug
finding, AI produced a patch and human sent it to the list without
much thinking since AI "bug" sounded real and AI "patch" looked legit.
This is not cool. It doesn't move the BPF project forward. It's a
wheel spin and a noise in the long run. 3 out of 4 such patches are
wrong. They consume maintainer's time and distract from real bugs and
features. Don't be the one who spreads AI slop. Submitters must
review such patches first. Use another LLM to review it and ask "Does
this need to be fixed?" If it's a race condition and the reproducer
requires adding mdelay() to the kernel the chances of hitting such a
bug are the same as HW crashing due to cosmic rays. Typical solar
flares cause more kernel crashes in the datacenter than these bugs.
These are "Won't Fix" bugs.

Similarly a patch to fix a "bug" without a reproducer is going to be
ignored, because it's a sign that AI couldn't craft a reproducer and
description of the "bug" is a hallucination. No matter how plausible
it sounds.

We see newcomers sending such AI slop to multiple subsystems at the
same time (netdev, bpf, etc). It's a red flag and a sign that the
submitter has no depth in either area. They are merely forwarding AI
to the list. Such patches are the lowest priority and might be
ignored.

Landing 100 patches to fix 100 never-in-real-life bugs is not a
success story. Lines-of-code and number-of-patches-landed is not a
metric that businesses evaluate employees over. Expect more "Won't Fix".
Maintainers are not going to help you increase these pointless metrics.

Also developers who sent 10+ patches are no longer occasional
contributors they _must_ review other patches.  See
https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com/
"As a prerequisite for merging a patch, the submitting developer is
expected to complete a comprehensive review of another developer's
patch of comparable scope and complexity."

If you don't review other patches and merely forward AI to the list
expect that your patches will be ignored.

Have a great summer.
