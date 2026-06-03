Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C43C768B
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502201; cv=pass; b=BbPLP212n36dWwy8veKJaTXUHfBSouAkuP1nSeYXypDE/qIdDV8BgENYAyQYfcnrGyHX1V3cr+5BTVZ2yVidGEVUDst6rPHt9Ar218XbJQ8uj9w5uufivTTaw7WKlAo5yu5sqEFTowtMJd1syISsgLuN6IItQiw/b4dyEPFcq3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502201; c=relaxed/simple;
	bh=7EfvxTVKse8eEtU9HXuF/yBZZr1p9gMDtcjZCaBPLmA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DFNQ5oujShe6Z+DBsHPCFw5aKpPkChpyiIQz2SkBD9ZkOpOzQylKw5TKWxQJvvww/dusUqOHFDCJTUGylK5EhM1Y6R5Bx7RoKy09LC0Ysz9NoC1KUBDi/l2NOcDGFM5CsA+XiBkPTYivWVpEbJTZ6p97HdlspeGdWCRi0iWxCwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6YPkd7O; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6YPkd7O"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f590dd91so5608856eec.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 08:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780502199; cv=none;
        d=google.com; s=arc-20240605;
        b=Fs3KCSsyBTlyz4mmLYKGqGor0VGUg2XDpCVv4TQcCRGkLBZIm6WVDnd13HdGzf9M9c
         FL8ZNzXUq3Q8hjq/GZX0Ddlz4v5Ad/jq40QVtN4HBJ1lzvJpfLZ0I5LuNYxnOHlSbzF3
         QrDRrquWvt1Mi/QNk6fzJYPTUFSK5ijaX2+lucAD/x+2QGkbKdB/As9U5nd21q+bEDhH
         wwoDeZGxkt+70L9oo0uAfanms+NGsjvS9H7o0EaUS9mNrqlS1LyBUOAG71TsL2sSV6+R
         5/4C15IfF9EmZc8rcFMOtFU9zn0n78bUHKjB6k3EPpgIbInUN0lr1cvua+uGF10+2SN/
         3eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w8TP7PFZq9XQLBcdxGcNgwOGhxiOCXgOZcm1W2vpSLs=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=Yny7qL62i1pWqXMil9R2R9prxnWcuU+woINMddqx6CBHgj+7/RquWQKf5ZmEM0HwnI
         IwRfGq1fj4/3e6BmC0l8GJo6B/TSOZULCWvf7cTA/EHYg6AbIWe3FRwNUCDWDDHAsgm3
         FtHSullQBoOuyWSUHwAQdndNwSgGCCaSElhwu/LdpMlu0JO5+S8lxzaQqeogjg8QtiPu
         phJcSL+nEbf28eIXpuXtG7wEVxgnhf4z4KLgELMPtGotsKd9uiWHvAidN3ZLzSsNqmHp
         EhdxHkm0tzJ1x4CqOktYgdbPoI6TUUMaPyC6MSG7AB3HW3g/cWkxFks6elHMQtut2Kfp
         ohhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780502199; x=1781106999; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w8TP7PFZq9XQLBcdxGcNgwOGhxiOCXgOZcm1W2vpSLs=;
        b=e6YPkd7OBM9NQqvUgnw7I+DxUaV9XkGFcUx53hlf8pMGIw8pLeUP84k1aUXVbplpSB
         nMhg+C7YYPK4QP2nAmvlqNViSI6DC/sCJMc1awFleM6nXPv1ZJgqtGT7ulGsGCDqwHWJ
         5PpczCaVEKfP/vRr8/RoGPz8sF2xL0h3+UYZQE2sdIBpQ2sD7ai5sygomFyq1aqfrM9F
         kK3pgIMTDqrUEdy1gWl9yfUAxhZxcFE91YONw1NNgQx3cahybf3tZIa1y+YWDmWuN61l
         RX69ly/wIZyroi1SgHYnaHASlYDyNfGWQj9iEQZ/iShPo2UFoeARMvHKep3/RQzvKxDA
         RPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502199; x=1781106999;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8TP7PFZq9XQLBcdxGcNgwOGhxiOCXgOZcm1W2vpSLs=;
        b=m5en9ms4TXoeOcAG0CVE6fqF5duV1hwv1KEADB7MHs4F1J7YyxE0nehsGfxWgrTqDs
         oKtpEWIrpH2REW3E0E8zwgJlEHgzFOXGUXCX3ZBxxk4qKyEfRg1ge4u7GG3Ro5jsTEvt
         qId+Xtbhrq6COgWhpOo7yUVtR+PtXQuztYAARXEL83fKNUERTzXLVxVYAdU8CZslp+Fy
         CJtCUMx48mZqysR45/gBAJuArNEcb5LOuLHJfgiJ8ovbvqTmmDxGog0hD4HuqRcWUDKH
         MjHyqQL+EbrXGu0mdLP1vquNVTmMo/2mQPML0abHHaJ8kQ+z2fop8zn75CV7AR/lwiKJ
         ezqw==
X-Gm-Message-State: AOJu0Yz34f40xWJbbuJcZCy5sa2ylmRBlf8QNmb4R2IebPgtUpOmZShN
	6DC+qn6NdiudduIW1sXscauPFs6UI9OxUV1AYbb9K22vF4gTN0Kzj/bBvwqLW7eBvUwSOluAX9e
	OyrRJXjD70ZKUBUz1g3Rom4PoTeo9CQ3cpjSCtslyxg==
X-Gm-Gg: Acq92OEO8to/2En7hbQ/3rBA+eZ8z3wV33FcpJlZ4gFSwkXCyl4lmTYCqcp1xwOVEsx
	j4ouUUoNN3CnMoF1oqXtaHZEBozegVd5pyOySpoQYm8SGLOzAxu0Sx9hnUUME4J/qw3esfsHpzk
	GbtYr+y10bqXVNxs2LdI4WzSmnkXFUYKRDRQay8VW1LCRqeHHhRU4Fn7OlGNZsbCdqj2cwB2XZr
	ZO2nIUjERpKUOxuWRE7WC9zBX24GKJBY56Zy2ne+/fviz69QVIuaws8r5NSDOAyySWnNHTfyNY2
	2OePMc/3Ya1DRBA=
X-Received: by 2002:a05:7300:f190:b0:304:dbcc:5809 with SMTP id
 5a478bee46e88-3074fbf03acmr2032780eec.31.1780502198961; Wed, 03 Jun 2026
 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Date: Wed, 3 Jun 2026 20:56:28 +0500
X-Gm-Features: AVHnY4IDKHOolEWeogE88Ys6fQ8rTswMtOX7RHw3wThyK_-sp5101sRhHNIaHXI
Message-ID: <CAEmTpZHLNZWkDTrWwSSvbqcSY93T_mD+DzawOuSnBA6d8VdrsA@mail.gmail.com>
Subject: bpftool - splitting llvm disassembler to a separate plugin
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

On Fedora 43, installing `bpftool` pulls in `llvm20-libs` (~140 MiB) as a hard
dependency, even though the bpftool binary itself is ~730 KiB:

    # dnf install bpftool
    Installing:
     bpftool            x86_64   7.6.0-1.fc43    fedora   731.4 KiB
    Installing dependencies:
     llvm20-filesystem  x86_64   20.1.8-2.fc43   fedora   0.0   B
     llvm20-libs        x86_64   20.1.8-2.fc43   fedora   139.7 MiB

The LLVM library is only used to disassemble JIT-compiled (native) programs,
i.e. `bpftool prog dump jited`. Every other use case  works
without LLVM. For scripting, automation, and CI, dragging in ~140 MB of LLVM
just to have a single optional command available is a heavy cost.

So, what I propose?

Load the LLVM disassembler lazily at runtime via `dlopen`/`dlsym` instead of
linking against it at build time. When `prog dump jited` is invoked and the
library is unavailable, fall back gracefully (libbfd, or an
informative message).
This would remove the automatic ELF dependency on `libLLVM.so`,
allowing distributions to make
LLVM a weak/optional dependency (e.g. RPM `Recommends`) rather than a hard one.

I've done everything here:

Issue: https://github.com/libbpf/bpftool/issues/262 (has additional information)
PR: https://github.com/libbpf/bpftool/pull/264

I would like community to review changes there (at github), and once it's done -
send patches to mailing list or ask to apply changes right from
github. If it's not appropriate -
I can send patches in the next message. Please tell me the best way to
interoperate.

Thanx,

-- 
Segmentation fault
