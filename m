Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795848712;
	b=RAVMfqI0FlJXuPs4fUfT33CfupBs5H17+taUQup2euxlbCZzT9xK6KzUTTDa1DWWXI1U
	 49xsqaUtU4JCbS19oSezuJxagOajfT2XBlhnZaBie0osh5oZUfb14N5+0GGdPbEDNnRio
	 9bI5KszwjVkGYq+FqwS6DdD1+GM8w2X8AVEH//fUTy/qr35y7UcWtxr+2/V+UEyhT8i2W
	 Lby3B6IL+SuOZpMbv9eoKivcbgSWSY3oGV93/KNgYofiXkD/qeypAAuFrXHXY0EednSxX
	 cPTgU6xbpNCVom0WO9eCMl1UkXuSVzPeqOa04yhrJ2ilBUElYjaT+yOJaDdMpHadsdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795848712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
	b=Vaqny+G73Ja9yYVu23tPflM3tPxYhx/NUQpbRLRtsEczVn8fi76HHlaJ53FWyzmJ5DNv
	 Bl1swyCJIY8uX3C1TfQRUe0IgvGxOv1M0GVZ1djhRvpWRBFfwCf9XDzAwM8NwRO3pt9Q5
	 DW44rOeHTjvMrpcKM7bNC8dsm6cRGO8Uyqbvh+8T/W0UIn2T4r3VSLeBZM2fpGNc2z0KM
	 W2mh6eeD1WG4IkrH5OmjN5cm47uWDs9Ne8K/Nns2aXpahEzLVwDW+4VR5teu89KWxD/um
	 TwkzcKltzGmFZcnthROxhZnSn9HggK9OFPUJBhmLveLWrCYbTAoVy/dDso9PZnizugQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stkmnyeX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D7606A332
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 06:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8D7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stkmnyeX
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so5177528b3a.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 22:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795848712; cv=none;
        d=google.com; s=arc-20260327;
        b=Arpi9NLsIkCi0MDHq9Ky7DWNffpZm8D28+eweYGbWi/PZN6l5SI4MHaYCDsoXK0qtG
         /iuND8QNx4J+WEcEbtpSvrN7NRARwZ/Ue+1onV0QeAgETbVCCEctDXgx4Ki0cIs8np0O
         BYjTGDIwKISjPJdvZ/spc6My4EagJ7uTkpOEt5frJwGokt6KUu6OQHh42g/cLPMConGq
         xfqb0+pf5dCHug7ZYnnZNWwj7OmXtNY35hTmBcYRNxvYCq/7E+FQnJJIIrZYUkgh4Vfw
         BkRiEy8YUzZA2TpgGrxcRlEF5S4IUXaMqoPDZU2OafwzgDk9QD8u9lp0nXRRvCpBCdKW
         kmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        fh=Tnamzv19bwT2wge85uQsLDY40PKPSXM59ROzq7fzRi0=;
        b=chSAxrjjmuBH8Cwv0QQ4HuNg2WWeoffYEC63xP6wWgLL7TUXIwgNNh/KjARoVXqad5
         4tAGtGVFVGfGnPC2PgQ0lnl36sEMhkVH6+bz+KQs8kHSWY7oa/8GJL1RuGPgcmVmxWO9
         XVVbDboctgxnJG98kmkfHTw2Cqqt3jUVQaTpr547jxbiSSAKBFsD76/KP6bBT5MotBvp
         DipXtJKfUgRQjuEE2Dyr0IQN/oDt34j85t8dxqzsBKUBYe61RXtfve+1HBP8oJqCpVnO
         Jlb8veLycs0UXc2+H69cdIr1yAkUjSli08XQE1GkkXOJu0hkzOMZdJSNvxe4xSR6LYj5
         P+EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795848712; x=1796453512; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        b=stkmnyeXjXrGO8ucfQh5p3r2ucwellPf1M8PDcbW5zkWf2pVteUPNRDWiVLkWb1zcb
         XpQki5J1T71HXR8TgxpWzBkSMvbsf+7RRpfg3iPuOYsVDQKoNQiJiqeJxpcPQHV6V6pJ
         euR/x1DYOzLSyUlsz4HtEnnqNMofisZmhVrJu/n/1LKzXUrpz0pNXh8zZWRHfESvQ8Zl
         Jq6v8fCKpCKYBOndAWvtIca1h0BMZ5IB2BJfyJzIqsJCBGT2b6BJJtblUIC/bOjTocIk
         PLOhgfuNlQHxmiOC/Ef+vgaxlcT8gVeid0VPgobExn9zilYuZbdQVa7IxtOLitWe0eRd
         ad7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795848712; x=1796453512;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        b=sXaC6lhm+fTAedPRr3cV44twfh/6K2OMMhp+fQllOwFSVReQFMsSdgHI8AvwvhTm6a
         rUbLyAlPkwpf4VI9wlUnpseBNhnZv8DBOVwjG4VhIXz+SYBMMjvn9ErxYbbk4UpKWAmK
         Cqmih2LviPm8FmuCeCI79+snedRVrsLApiePHy49nE8ulvZplhhvP3uYUcfuIsFn3mPs
         UgCC49GOnhDroV6k7URDg0shImdnmgHs60t8bPd2fdmSgsebALam58BG01/GKBpovYzO
         5LBU5AzKDkSbREfmMiG2TQscC0+C1va2Wd7kfXqwhc3M7UDeXVaJH52z5ZLwvXfsK4Zp
         5d7Q==
X-Forwarded-Encrypted: i=1; AL+hErFJISefhavqajMU6Ui0W1O93pPiHFEa2ilDJWtOBdQ20CVNXIQaCXS3QFgWEvImnZ+lDQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KKXiRF5BB3IwF1Ax4G+GMq5NP5xKFIwz55UUka61zlcoDCf+0
	ljrSKTDGfq2dq+SRTgEDrztPpTD1RMcmIiCwWytR1UKhAivh8/bMyQIaX9SYHHli4QN6XcnPoEx
	usoGvgOBQWSL18re2Gtuocnr4yZjmcL4=
X-Gm-Gg: AZFdTZfyLV++y03uEgpGtf5KT4Btrp3qwpUCY1Rw6V/gzWGu7rq3Qtui5DPs1WbfvZm
	5SgaSgr3T4s4Mwh29GTZlIxF7nxPZ6qd+qyPZ9FeovugTf15QWGFxErqOssWTndJ8AYC7INLn5R
	+X5MkllDUjfT3EAnBz/eKEqe8qhIdm1tOxxDLzFnXVqxGVc8rlIc5WB9mx/DL7gHn8u2dzIG9kM
	IiaA6UFYU5bwRIAcYalpj8cGz3UwPmbrMA5i+Nl1KrrZQ7g6gq5S+hKW2iSMbZA/E2xMDJ9W8Qs
	8hQeU7pZ7RLi/8kGPSm8UxVEuiJmRRlF7EgqOZtzzSzWA5K5//FwViN+HDLmuTJU1Q1uFAV2yr+
	ntULhRRvuGcWzFfH/I0lnYk2JZ8CX50wqDFE6wB3YgbzgES2z7BCnzO/blPHGUvyOt5aUjB4Fy2
	uz/Xo4Iy+xIvxmN9NHQVDQiWeFvTA50xc82A+Of5LvBlGProaoEpM=
X-Received: by 2002:a05:6a00:10d0:b0:8a0:1c79:b442 with SMTP id
 d2e1a72fcca58-8c876736f60mr28100627b3a.0.1795848711653; Fri, 27 Nov 2026
 22:51:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Seke Kazuru <kazuruuni@gmail.com>
Date: Sat, 28 Nov 2026 08:51:14 +0200
X-Gm-Features: Aa3M54pZRibgmL1LzEnhMVNXmlmV3PoNLAziDiqM8EwF269XopiVH8PkrMvy8O8
Message-ID: <CAJATrkz6CgsaAFjeGT_1TuUTxrpVYEo=9rGuobnhpU-LPxv_dA@mail.gmail.com>
Subject: objtool/klp: ___bpf_prog_run jumptable is correlated to the original,
 fix never runs
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org, mbenes@suse.cz, "pmladek@suse.com" <pmladek@suse.com>, 
	"joe.lawrence@redhat.com" <joe.lawrence@redhat.com>, "song@kernel.org" <song@kernel.org>, peterz@infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

A livepatch module built by klp-build for a fix to ___bpf_prog_run()
loads, reports "patching complete", and lists ___bpf_prog_run as
patched, but the fixed instruction handlers never run. The replaced
function dispatches through vmlinux's copy of its static jumptable,
whose entries point into the original function body.

Setup: Linux 6.19, x86_64, gcc 13, a config without BPF JIT (so every
program runs in the interpreter), klp-build from the same tree:

  ./scripts/livepatch/klp-build -T --no-replace -o lp.ko fix.patch

The fix is c77b30bd1dcb ("bpf: Fix undefined behavior in interpreter
sdiv/smod for INT_MIN"), which changes the signed DIV and MOD handlers
inside ___bpf_prog_run(). Those handlers are reached only through the
computed-goto table:

  static const void * const jumptable[256] = { ... &&label ... };

klp diff refers every static local of a changed function to the
original kernel's copy unless is_uncorrelated_static_local() exempts its
name. "jumptable" is not on that list (6.19, and still not in
7.4-rc4). The module's ___bpf_prog_run therefore carries a relocation
to .klp.sym.vmlinux.jumptable.12 (R_X86_64_32S at +0x40), and every
dispatch lands in the original handlers.

Test, under KVM: a small helper module runs a three-instruction
program through the interpreter (r0 = S32_MIN; r0 s/= 2 as ALU32 DIV K
with off 1; exit) and prints r0. Unfixed code returns 0x40000000,
fixed code 0xc0000000.

  boot 1, klp-build module as built:
    before load:              0x40000000 (6 of 6 runs)
    after load, enabled=1, transition=0, "patching complete",
    /sys/kernel/livepatch/<mod>/vmlinux/___bpf_prog_run,1 present:
                              0x40000000 (6 of 6 runs)

  boot 2, same command and same fix, with "jumptable." added to the
  list in is_uncorrelated_static_local():
    before load:              0x40000000 (6 of 6)
    after load:               0xc0000000 (6 of 6)

The build prints no warning, and every kernel signal reports success.
Any klp-build fix to ___bpf_prog_run has this effect on kernels that run
the interpreter, that is without CONFIG_BPF_JIT_ALWAYS_ON when the JIT
is off or unavailable.

Two possible fixes:

1. Add "jumptable" to is_uncorrelated_static_local(). This is the change
   tested in boot 2. It covers this function only.

2. More generally, do not correlate a static local whose relocations
   point into the changed function's own text (label addresses). Such a
   table describes the code, not shared state, so it has to follow the
   new function. This would also cover any other computed-goto table.

I can send the helper module, the program, the kernel config and the
two klp-build logs. I am glad to test a patch on the same setup.

This came up in a study of live-patch module fidelity. Of 70 klp-build
modules built from real stable fixes on 6.19, this is the only one in
which a changed function's new code does not run.

Thank you for your time.

Regards,
Seke Kazuru
Independent researcher
