Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20131E4AF
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831427; cv=pass; b=NAd87NgzhERoZVF0slOYrVgi3fwYAXFZQyi8fEE0oohksxnqr8lkc3JTDSaWXwH7861RXrukJs28Naabi88OXwzN9emYcmIZieKyzlXPhzaiUjZxgJVmIlIPFRmVcayqZXH4sp5gqgmDcqQHVCtpGZ5myWiiV9hmgXR9vUW5mm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831427; c=relaxed/simple;
	bh=GEjX598YQ0Jshc3lAsqTO33l9TqTfZXecxAFTq/JHsI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AGoJWlmXkGu0fsWfZnY9TK0FxbaGi7IGod4Jb2Sr2/4By5arXJoMnDOYOdEscVpaszziMlLLHkn3D01KFsYi9K1z1tM9yH+XNtek3ethGx2dXm7K6qnTbkV39ElsJeXo8QKnN81ZnbdcEbGRQQIydqSSaAFA0UQl9ckXcivyzRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwkLIlXL; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwkLIlXL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee0291921so25037005e9.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 19:50:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769831424; cv=none;
        d=google.com; s=arc-20240605;
        b=HVIPhYMFVPK3oyrL2Aq4bla6HFfu5snnp8GWsk0b2EVPMhOs60MVMn2QbW7s4eRDKD
         ER7XC3NRAQqF32+aVbBlfaDf024bs54dUlRO4dve+OT75aQXHe3U5SNOmyitoD45r7vC
         9FDXoQabPICdyaxFyj4xbNi5eWavnJGIqsEDaEml5zBku1acY9+IpKU7WQ0t7NkgeIXd
         pJwybf4H4qm1Lo0QJZMgjxjkVoeIMrZpfB8ayt/l3b2Z7faQfRgyKbbZVaROV1iAW2jB
         Vt0lMOmGtrGVn2qs5NoZYt7Ha9gdOa9XNfIy2IhXUvBKMBYL9RNz00xTHyBbKlX4L0kE
         PCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Kkp+uETdrhcbFMiTUc8JbTeymAgUzvmlW/xQGSZGqT8=;
        fh=+x00N3kvszWjC90OPDogV25yeWnjD+3vQP0Osi6Lkn8=;
        b=Hc/XMBzR8I/UsHT1gfyvISF4sKifLaiyTpv/pNdLFAVQv/cAx6t97xIavQD6TUXfrV
         oMwgfarynG/CTFiH2TVkd5RZZD3J7Ph5qtx+jCtMTOYE37pfDwZqdjly70inmPxe9Xlw
         2KnHUhQmNQnEz4MhOayjociDJyw5YwEwo4APrFf7jDvODDR0MxIwnYWEsKTzuo+SSZR8
         q4aDGiVo2gjXrf0jpQgnzVUALYfOXlx1C3orldBE6ik9x11ZuNAl9eMsvgW00bTxh9Vy
         9KK/thE29N/vI4FWj7RChSK3M+veVqSmyX4urvtUhD7XQt0DbtyCxUF+3zzVD7jy+Rhj
         ydwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769831424; x=1770436224; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kkp+uETdrhcbFMiTUc8JbTeymAgUzvmlW/xQGSZGqT8=;
        b=XwkLIlXL1zTRWmQkeBFGqLquZvtbrjdH0NTjp02KfuUyxJAdIMnZhZBCFsjElIMSLv
         hqTm+cOF/sy1oquovZrdJbtNJ/viOhjT1TLkIeegR2UJHDvqK43TeuOdM3jOt6XXDSfC
         DQACgzgasxOGLd3zJxr9J6xlqhb3oIDjSTVzBVsQ5VTngKpf/LG3sSo22X7r31iSjGQd
         qsmY7xbgKrWURubMWBWUdPCfLvky0dOjdqj+IOOdPFFwLPN0b95B2uJW3v6P4D3D0+XP
         Uyp91gjSuv7uhkpep5yCiLI2Q17ER5b4VSTJF+Ls7VuyE1AB0/UI+xmT4Vt5GzNUvOnU
         yTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769831424; x=1770436224;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkp+uETdrhcbFMiTUc8JbTeymAgUzvmlW/xQGSZGqT8=;
        b=soiPDrfHywFxs4wkVoozxBC7nugq/QIfH53jczI8YM/QY+oqFkigoRLUQsuCam0Xng
         o9kH0RvBkITR1TYotSgbC3imJpNwa7B8pYFkas7s8U9CxUvzys/oklAREv7e2kuXS+c4
         NGthiRt+wazPGkrrmGptTtafQpf2tbvv7hjpHgkIYuBmVb9uJCJuyYGsDn/91iz43woW
         8jja/YlLSxoDz713lfZGjt885s9ZTmeQJr7caknoYvZxyShemnJTSCV2rHVLhTcJiA9+
         N2CxFtDg7zMrga8JOB68znJKL8RyrP1/noQjcnDS0ZG6/BoixCzBu+BqiQCHlyPLAggO
         7wRA==
X-Forwarded-Encrypted: i=1; AJvYcCVoP0NHU+k99/ko0TncRBQBU4uQDrOlUR+iqllkPqYKyKSqz4F7EU922x85kpfLowKhOfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRk3HkEyvGXnpQJZtVW5541yQittUgL/QJ8k9deoB1msoSzxmq
	KNrSco6qw80QNdI+chfQ92uTeUzL+Z9PguQ1+X62YwI+QwOaaS7y+S54XQL8m2AqnN6urhtH80+
	Kw16Xy3wP2bqSUFXLKnSoImhurPKVF+Y=
X-Gm-Gg: AZuq6aIWsZ/ayL/1CLIrpl8ycZnSoU7pV9LOwzfLVByJwDIma6kz5QCU8z4PBzZQs76
	yJTucItc0UiK82FqympUAs9cVjFyZ/DIbyze0BKA2QZ+YuesuduOHg+bxi7e91MfzMn2iv0yJ+5
	nwM15iG6NZoKWcUpBNx6M33OX6BDaS0+5D1HT8DO1njo51QeHblZgVroFB5yAvtPK21gmVojaxV
	KQMrgL7+Pw+YFu7k63m7jG7cPUVDs8zQ5jqzz4ZOr2dbzibRg42LjNtOdXyO/UccEA82ioswxL1
	kCaKhLGm1l6JdcfUV0Rf1mNdWUuIFG+nk4FdXb0IF8S8ebMtWoHQKDPBWOQUcfkB5d89R7hakXX
	ioIOXPW54w1vQYwuNs0vP3GX+
X-Received: by 2002:a05:600c:8b30:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-482db493e04mr63435635e9.7.1769831423913; Fri, 30 Jan 2026
 19:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 19:50:13 -0800
X-Gm-Features: AZwV_QjwAavtBskXAOI8dsQuGcChZtbxcXv4TZ81hJfIrUIblkAGMWzsxbqVO7Q
Message-ID: <CAADnVQLVYsosBeGEhB2uxyOKNB9aS94vmR9bQb7RY3jVR2iFxA@mail.gmail.com>
Subject: memory leaks of ftrace_hash
To: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

I see a lot of:
unreferenced object 0xff1100012c967540 (size 32):
  comm "test_progs", pid 2052, jiffies 4294681345
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b8 be 65 06 01 00 11 ff  ..........e.....
    74 3f 5b 83 ff ff ff ff 80 0d 01 a0 ff ff ff ff  t?[.............
  backtrace (crc 8dddf0a9):
    __kmalloc_cache_noprof+0x3a5/0x520
    add_ftrace_hash_entry_direct+0x4a/0x2e0
    alloc_and_copy_ftrace_hash+0x15a/0x280
    hash_sub+0x3a/0x470
    update_ftrace_direct_del+0x349/0x7d0
    bpf_trampoline_update+0xa9c/0x1070
    bpf_trampoline_unlink_prog+0x287/0x600
    bpf_tracing_link_release+0x5f/0x100
    bpf_link_free+0xca/0x300
    bpf_link_release+0x48/0x60
    __fput+0x2fc/0x9d0
    fput_close_sync+0xcd/0x170
    __x64_sys_close+0x7d/0xd0
    do_syscall_64+0x46/0xfc0
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

just running the latest bpf-next.

I suspect it's due to your recent changes in the area.

Pls take a look.
