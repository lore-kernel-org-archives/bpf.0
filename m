Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE03148B5
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470734; cv=pass; b=kunaO5j0ct49FLNpMflC2aKDz8G8nArg6rkC8Do2iVe6W5Br18ZVk7e/pfq0k+B4rlUGSGKhQZxSWjh4brTcyRVGPQKgH8vRmBcX/es2UOPa3hOA7SpT1IaqZYmuRDFL38ps+NYNbClaRlHimcvUXwVh7I9OYKcJbjM5z0pjPKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470734; c=relaxed/simple;
	bh=Vcj/jlizRJmi2EXdt/aWTfJdSBrV6aLiC1QJnc1gyc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH9w5JJWlCWTIzVmzQNntm2tmL/Nm5FKDCjDoSPXVrkXRBjbA641waQheADJifHp79gOjt4/G6kWJ0VeFm520FkhIaT/3rUWGTnyUvW4XRRdr+Mb89RwzIG8gvhoz0j6QIhHMXW5kow1Eu24J5epKhP7niYz6fUWq/FcBHSPXLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Tqgax0rh; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Tqgax0rh"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12db2e415a7so5152025c88.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 06:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777470729; cv=none;
        d=google.com; s=arc-20240605;
        b=TcTpcFjepCN6bSC9Kh+GY4atbiG7vCzNePjoqIUsG5aF0x6w0PfC2Z/yjDOtIdGEMO
         8Pu9EEl396BA9FeyxbN8t197iqowQ+SMH8HuCNS0KAVyJqlLmOl0BxR2vQdYVF1FpYuC
         HhM6+aOLyqTgPqswF7W6XdhnhLqJpcxbJA9x4+ytWIT/UCROIGMeTWz379u8SNbIIPPO
         oqXnRak4u520/+6tcap3DH64MvSQxN+4eklDx3Qlz94ImoPjytaAAItlqqYyMKxATYCk
         Omr/qxje7Tr77GPIXVsxmprjHgejGZZg0v3FShXYopsQqXgujsg3alXojWw2O+6G+Ws0
         u+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vcj/jlizRJmi2EXdt/aWTfJdSBrV6aLiC1QJnc1gyc0=;
        fh=1nXatgaNKvrw0NcHxbHZsN5qAUXSQvVmWJBcw9ZpZhc=;
        b=VAzDq43nAXxOzQYwfOrlj2KGT1RX34+KAhAqDrB0zWoNNVPk5USHI6cw0ETg7Gp6QF
         ng/k9GvTSQEoolDfvV/i70GIo1C53L+BEmks3SaNByBQ4SOC1AcaO/k91mTHQHd/GVnW
         Bs5gLh2zwqK3F5HE6jaIEM/eLdUVJI3aHHlckIZ32znTr7fxTUdn230pgcu6MjOYp91e
         d4I1MSwc/3epi512glJ4DHL5rrzisPCZxiBCne4vhvv/5NqwV19Vyy1shQPbpeacIVF6
         B/9y/2Rbs3TPWVS82tMfGGZ1Qq+b7j40fVgzZ3fr6FSbdH7O6aHlGjCN1iZcFH3NiiTE
         gwpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1777470729; x=1778075529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcj/jlizRJmi2EXdt/aWTfJdSBrV6aLiC1QJnc1gyc0=;
        b=Tqgax0rhVN4z4dkfCgOaPw70NMrOaoW+PCCEgJWZrAH7EI11PB0wFd4xH63V1Qs2sF
         Tz2/GaLlM4+dvRn+kfuFf/dNMFcmHDlDlE6hIV7OkeB5awkclcymbh4UyObeAlVizG4F
         uYvltIwyl9VpsVluhKQXFLMMj3tGSx5gZASn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470729; x=1778075529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcj/jlizRJmi2EXdt/aWTfJdSBrV6aLiC1QJnc1gyc0=;
        b=XNUAil/O8BagqV0NiThv5WBnMvpOCYLoKopPo9v4WgPDPZ64y9DnyCgkwu7rsuy75F
         rgaPfpsjbPIBwuS8cVtwmyvfadcvnFTR34C3jqSKgoehBu4giiehktbO8m3YeQRgPi4W
         RGIRnu8OX6x4qyXXLvPzfK7oLunDytRkYWgXzcbmFHDsZsfHb4niGmfPQD3Y1AEeudQ+
         7qr7Zb9A12xiDdVMe8SyKO7iLF/kCFTKIgwKhtHnrbSEqByT49Y1vwa9BJdwSNI2JAv4
         zBN4FCDfOC0qRU233t0eQzmrMSDjqEnSpaETV7bxiu30JSGoviGXtNwJkd1xXj2H8dj4
         ZhKg==
X-Forwarded-Encrypted: i=1; AFNElJ8MEQOmSYO94FZGxTy0ltlxtIdMG+U73qNxQbZqYubLKd6YtPvMxWkf0RHJC6GNIHmiWKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZIjUSD2bnZge9SfjB5MeJDDrhbvoUP8I/FGFBHTwdbWy8yMm
	+yAOegjh+4LH/N9BCpGFA4UMNVPhIWCks8LKhsSMiqlRHmQAMDotlc/Lu/ZbdfJns2wytYosxdE
	SxCrvy8+CC6/KpVZZPbCJA875OJKod5QApscegHT0rg==
X-Gm-Gg: AeBDievUcVG87c/8TEV9xC4Oe6UF/bg+JiExXpzkTsbEWIoSHazraDXRryOqoJPap/p
	IxbP1U76ZYzqqILUQpv+B6a+c9w0GBpvvL+yQPFGYdxnobI9NYQsa673O8k50e7dbEKd/etrl59
	8Ai5IEaKSlzIlMv6GQPVBZ9XF7CvMThyoUGkSMHVL+a34tVoF9GfGashsMslSFSH3MuA4aH+UPM
	MNETlmjyWDC0jUK7hYQZQWmubouInswXdYP54+7oy7zjTvdLc3oNU7Ii/pxlXH5nwS7vu6nHAit
	IuvMTPMk7qe5zWsIhEpj
X-Received: by 2002:a05:7022:f216:b0:12d:de3f:f3e4 with SMTP id
 a92af1059eb24-12de2a59d9dmr1339377c88.36.1777470729259; Wed, 29 Apr 2026
 06:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429124046.3480827-1-visitorckw@gmail.com>
In-Reply-To: <20260429124046.3480827-1-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 29 Apr 2026 22:51:58 +0900
X-Gm-Features: AVHnY4LZkGH0GYT9Uy0ZRDPAVwacyW0kO68S2UYtW7_ZVjCKOsFUrrOGP3b2h40
Message-ID: <CAFr9PXm0qxeSYq42MEOARKsmOT-hRLbT4UpchkwuSOMYKYzfOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Wed, 29 Apr 2026 at 21:41, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add a BPF JIT compiler for the m68k architecture.
>
> The JIT generates m68k machine code targeting m68020+ processors. It
> currently excludes 68000/68010 and coldfire processors, as it relies on
> 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
>
> Tested with the test_bpf.ko:
> test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Cool! Which CPUs did you test on? I guess 040 that is in QEMU?
I'll check on real 030, 040 and 060 machines a bit later.
Since you are doing code generation for m68k now maybe you could help
me when I resend my patches for runtime consts support? [0]

Thanks,

Daniel

0 - https://lore.kernel.org/linux-m68k/20251127000505.2117956-1-daniel@thingy.jp/
