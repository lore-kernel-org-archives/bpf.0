Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237940;
	b=xKXc/u5RqlGi3LEj/OnzaQfqg5M3gG1wR0oMwARCmR0A1vZp+8vKT5RfKbE83idW7WEa
	 NBAUhwj8CsO2v3j5QbYnV5IuIFvQEl8kRKN3Ati+mxOz1DgJuZOoltprdHxPW7bybjOaa
	 hARPXGVyCdJiiFIgP15JMu6zS9KolxKUshPoF5yG/88g1tCd32IoLjrUDFsOor+KXc3EK
	 ul4zKXsCsb8i+9op5TOTKQn/RIUv8n+/PA6z14FzqSq9HZkb1KiYu4x8AdNN1A323OFJ/
	 Tyq2VeWajBazAnqqzqcZt3uQ+8IljnCBYjnf4KZR6aC5FSzwz8kWa2y000Yr7G99eHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Google-Original-Message-ID:From:X-Google-Original-From:To:Cc:
	 Subject:Date:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
	b=UBT6QtOGBprBKK/AJB49d+q4JgON1q1UrLVPiS4yF6XqTbC80jrpXBpb+GrCAiltrZc2
	 8Seb8HNmdRla/qyc/zOktV3H59FdsLZp9RoAfawsQGEnTwB3Hx6Ahgb9wtjRt7pKhsSms
	 3hrsORezmTU5/KLpCH2Apxkmmr3vmOkx+TGZo13AhJiBVulVgP70CJbO4tw0WLF86jwbM
	 HBaCTOba1DPFaJsH61/gDOnTZMBYwj3wmrZZsqmKj7qt9XTCupfgWqAPhzjjHcWeXc84s
	 hav40BQbBcgn1D0fGdH1EouQsDfJuvYqQLLNJC7bnIF0ScPC72K/oZCXynTUFKfYLrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAH5Td1V;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C31606A325
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 15:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C31606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAH5Td1V
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso467982a91.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237939; x=1794842739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:subject:cc
         :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
        b=QAH5Td1VVsnMLp74yBsh4npC78p5NNQ1yeYU7wlnu0FWjl/bPOeUPjHSKfgSElKUaY
         sL7qtgp1plN4TJ3twIW+lQcQWqMV52IR3AswYPfeaf3pHMgWa1T0Vo5v0HVn30K5LzJO
         AjM6aNGBh0xyNGbzIh8womUFdwHXj0Yu8W20njfgXPOxLfw/5XXyh8shBACc/Ny3dsRc
         0KUiBokdaY41XjPAnqRokYNmrA63vPfK9OspssxFsn+CpDg8tOFDfl8sfZDIhJhTz+gh
         jJvN/MglHjaK1X8YBA3Z89RzXSYmdRKI9yxNToQxDj6BnYbU2Mej2WjBdVGkxHAGfRyq
         tWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237939; x=1794842739;
        h=content-transfer-encoding:content-type:mime-version:date:subject:cc
         :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
        b=otVlB4egg7Y9QNwJbRKqEPzoyL633AGZOLC+Xm1j3XRKa9jCphqbi+piMUfF34/DJK
         XK8f5N33pRivo9VcPoWbRIXYUvNZMAG5s2l8Gk4LQSabBRvd8G32xOtZfep3RWjN8Mez
         NdP/YLpZDkrOFGNQTHWhrmTaLuc7Fz4H7/t2KntGxAOfGByoeCysH5QpLk7sPhp/lue5
         v4m5yK6vyjthGMNj3iSChKw61Qx4x4UG/DmsnTmll0TAQk9MvE0ohJ/tv/upIyZXSBaW
         hEbrWpyVZ8eQkNdbgLfdQmsUYOiL5YwlHGYft6rZizT1mYoIH61GQpewiJwElEWvoVdn
         aa/Q==
X-Gm-Message-State: APuU4Z8UyXnMBnTVk4QkvHyZEIMGRcENCJXSLXRwnTLW6EnK16jDEXok
	6kHEUXSC88Dl3pV/7fk+69ilgufCGNSVzsaVC+E8fbc89uMxMj7rLI1jDZf5vWj9YgI=
X-Gm-Gg: AYBFou3U2v6hwm5wS1YY1ZTzWKLPceuUh5rdvlPwlZ9e0tPag29cW8sjOI60GC5BarY
	WT6Wys8XXHQ+HJKb/lTreUpppfijbpgmnk3cSuLktFn/TN57iC306H3iT3VxnHHQ+bjQ4R1uKOB
	4toHVyJyl78dpvjyzgAppcPzc8HYk7CymLdNWJCGgRb5WchFK8tmR66/mNAG464ujGIlAtjyjgY
	PKxucOdoxV/4IjEXJVYPbbM3usfNhvGm7jaf1uR6QlYcEr7oecUM8NdrVPR5PDWyXA1B50CXq70
	KoM138dDFkSAt+4O66k61CviUkj09C998jFGo5gIxUSHqP/gfLZYS0sBQuPjrvS6Ud4bLf79YjV
	nQdDjiNc2RZZHGo3mxTQKhEVyUpXXBUCT4ZKGIujVF/vG2L/RUndT1nx7nmrnoOsFEqjBXHPfNI
	ULo/SlEzBvnk0Y1LOItACeQ4qZcqCYuTieYozqzsPdZrzDiJcaEh+N6byUcH6T+BeRfK4bG34No
	+D2JD7WxwrxcTQSd+DcyqTXQohQxt1dd4mpv0bA2DEwHrZHr5EKUowKb5QQ8Dz9Qngw7SdsFHJx
	h77e41njI6Q0DZ21Iy1t4HhV9+0WwCPXvHCGFLlMBIYqli5+org=
X-Received: by 2002:a17:90b:33ca:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b12d418819mr4176458a91.17.1794237938727;
        Mon, 09 Nov 2026 07:25:38 -0800 (PST)
Received: from hanzj-mi.. ([157.185.136.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864bffsm11462095a91.3.2026.11.09.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:25:38 -0800 (PST)
Message-ID: <6af1e5f2.a438010f.130489.ab94@mx.google.com>
X-Google-Original-Message-ID: <<179423792787.1832964.14629633117175086624@gmail.com>>
From: Zhijian Han <hanzhijian1991@gmail.com>
X-Google-Original-From: Zhijian Han <hanzhijian@zepp.com>
To: bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: daniel@iogearbox.net,
	tj@kernel.org,
	ast@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	linux-kernel@vger.kernel.org,
	Zhijian Han <hanzhijian1991@gmail.com>
Subject: sched_ext selftest enable_cmask fails to load on 7.4-rc2: verifier rejects arena pointer cast from scx_enable_args.cmask_arena_addr
Date: Mon,  9 Nov 2026 23:25:32 +0800
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhijian Han <hanzhijian1991@gmail.com>

Hello,

The enable_cmask selftest (tools/testing/selftests/sched_ext/, added in
the recent merge window via d781d1b78acf "selftests/sched_ext: Check the
cmask cid-form ops.enable() receives") fails to load on v7.4-rc2 and
linux-next-20261105. The BPF program enable_cmask_enable is rejected by
the verifier at load time:

  libbpf: prog 'enable_cmask_enable': BPF program load failed: -EACCES
  94: (61) r1 = *(u32 *)(r8 +0)
  R8 invalid mem access 'scalar'
  Verification failed: Register Type Safety: Invalid dereference

The test follows the usage documented in kernel/sched/ext/internal.h:

  struct scx_enable_args {
          u64     cmask_arena_addr;
  };

  /*
   * ... The address is a plain value rather than a typed pointer ...
   * Cast it to struct scx_cmask __arena * before use.
   */

i.e. enable_cmask.bpf.c:101:

  struct scx_cmask __arena *m =
          (struct scx_cmask __arena *)args->cmask_arena_addr;

The C cast does not emit an addr_space_cast insn: in the generated
bytecode the member load (insn 1: r7 = *(u64 *)(r2 + 0)) produces
R7=scalar(), which stays scalar across the cast and the inlined
check_mask() prologue, so the first dereference m->base (insn 94) is
rejected.

The same selftest was verified by Tejun on the for-7.3-fixes branch
(per the v3 cover letter, 20260919002838.1960071-1-tj, 16-CPU VM, three
standalone runs plus the full suite); the verifier-side arena handling
that changed during the 7.4 merge window appears to no longer accept
this pattern. The struct_ops argument path (direct __arena args, e.g.
ops.set_cmask) still works — only the u64-carried address form is
affected.

Reproducer (deterministic, two consecutive runs identical):

  # kernel: defconfig + SCHED_CLASS_EXT, DEBUG_INFO_BTF, FUNCTION_TRACER
  make O=build -j$(nproc)
  cd tools/testing/selftests/sched_ext
  make LLVM=1 O=$PWD/../../../../../build OUTPUT=out/ TEST_GEN_MODS_DIR=

  # initrd with out/runner + out/build + libs + busybox + kernel .config
  # at /boot/config-$(uname -r); then:
  qemu-system-x86_64 -enable-kvm -smp 4 -m 2G -nographic \
    -kernel build/arch/x86/boot/bzImage -initrd initrd.cpio.gz \
    -append "console=ttyS0"

  /root # ./runner -t enable_cmask
  not ok 1 enable_cmask #

Tested on:
  v7.4-rc2 (7475ea8b5):          FAIL  (verifier rejects at load)
  next-20261105 (gddfe51b0a0f5): FAIL  (same rejection)
  v7.3:                          SKIP  (struct scx_enable_args not present)

Compiler versions tried: clang 18 and clang 19 — identical bytecode
around the failing insn, identical rejection, so this does not look
compiler-dependent.

The other 40 tests in the suite pass on both 7.4-rc2 and next (after
enabling CONFIG_FUNCTION_TRACER, without which the fentry-based tests
maximal/kick_immediate/reload_loop fail with -EBUSY — worth a note in
the selftest docs, but that part is config, not a bug).

Possible directions (not investigated in depth):
  - a kfunc or verifier-supported way to convert the u64 carried in
    scx_enable_args into a PTR_TO_ARENA,
  - or an __arena-typed member/alias in scx_enable_args once BTF can
    express arena pointer members (the internal.h comment already
    anticipates this),
  - or adjusting the test to obtain the cmask through a path the
    verifier accepts.

Full verifier log and QEMU boot log available on request.

Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
