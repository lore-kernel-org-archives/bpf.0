Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608066;
	b=KI5FLFWu5okq497pkFWXM7HIIFioMPrbSeTs+DWnZEPYjMraD5aWGtOTeVOosR+crveb
	 FCwSeJJSVpS/4rS590UegtYTOjntTf2LQ0p21xH87bsc2FptR85aeD/nyX5Raxz1r6r1P
	 rGtWeoGGNIUFaJUHmlf7fZwAJG+oQakkD/WxRQysD/hcJzuieGIq6nbyM8Xilc7hmcSTv
	 92B/Ayk50fZKiUMflLjOh2DcgwZY1XbXabHRSUjY/yhXVebzH6uVs3vofWBFPSeIqdzdw
	 Oy7ArJiQCT0xucs2zA3Zzpa0VYXNsJscVd9bvzhw7Ahm5G60TnobWFjvV9UzQcf3+mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
	b=eNgHGdqRT7hgqOSbt+/pRQMrSSYv7tasnuyWJ1/K6b7kbmhPN7TFDTDFHql2pSqDggO6
	 W14VluWTol9RoVAiJx96XDN3PwimGNeP2XcFmS3KJuxfVCvlCFhMZdg/S+hDDB9F5tClE
	 BvVMI4asWO2ChSlVZ+CBpLf/mTXg/TT6bWC8eogffOYeGns+eSYEqhsnlmddsv+pvXeDN
	 nIN8MBEQo1K/eGfIsge8lCneb92PNak9pTuJsnoCfzAML/8Y4NkEQuocWMDagRAvwYKPg
	 jC8x5iwwTi8X1HAzIrOHvy287PBavEJQkP+i0iBqSK6OXLvGfHEOcXD7fqxOrkBhCMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fjMOIPEu;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80C606A8A2
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B80C606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fjMOIPEu
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c55ba309c2so2088958b6e.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608064; x=1795212864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
        b=fjMOIPEujQ80OPuCk/2PwfPYl4muqyhEYEkrnqU2gj6MiPamTimEwjYFMt/H/9w7Wi
         UTuuENUdduvK1Ox2OM9j6e9GAJEMPHdc53tzSSDAj1a6+ARSpQiJsqLxzv9iHK/mIhuf
         S7bDxajxb9GFPHBWxjr2+Cfgm9DIP4GdAUYAQ7eGXov/HX/WKBKO8Vtt/FaZMGUFO88G
         zMbzVQgLhL2PpkBGRoAQhEpGUZU/UEjt0UKMkpAYQ9N6m2bW/Wte6R88jCKB3aczvlkk
         m3wa2cFuDRz1ah8RH2GBQgPRgT6KSKqZSiMGkxEnsF2VUy7YKRxWdFGIaSzdaXSeadYS
         e9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608064; x=1795212864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
        b=hy6PoIIYpscAFRXlVz/y11x/wm2EjW3XzDE+pVavl64S3aLZbI0yiwEBLUrTLxlzuW
         x24zn/Az4O2NqY1Azi5iKL6HowzbY2yzpr0+ps0wYlJ5er14MC9kPubS4MyxGGgySIWJ
         DNyvs4TMX26ROAX+AAndm3OEczw0U8Hyo2szmukXhzMvwtkk08am3DH21RydrooOURYs
         ivGaveSli3JzkcTaljtTbbW1ip8sVV9BSW66UNrskpDfTvXjsVyzae+VbvyuSlMpURbm
         Rpe74Vw1AHw2nG7kJfPk/6j3Zr5+YNerE3SOkdHoJ8BalZUW/tuTuVk6uINArlWIBch7
         hL4g==
X-Forwarded-Encrypted: i=1; AL+hErHMz9gLSENrekaxNGg0VssrknVtDE5NUdiaSBDl8Rgt8JroGsOzn7x4w7p11XeFnWAn9V8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qqqNCiMR/4OIsLgVUKB8+Yw6UBOnkUP1WI6UHvmGa0z7KhDiw
	KM/cFBrqA94EZprrFg5qcLiSrVzu4FBNWC1CyJc+wt/pv+I2Qob6rgAKHYuQNC9yaCPSMhB+cIE
	StRAqpD4Nr78wsg==
X-Received: from ilbec7.prod.google.com ([2002:a05:6e02:4707:b0:53c:f2dd:1e17])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3505:b0:536:611a:7fd9 with SMTP id 5614622812f47-56e6015e8cfmr3125630b6e.7.1794608064235;
 Fri, 13 Nov 2026 14:14:24 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:50 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-16-wusamuel@google.com>
Subject: [PATCH bpf-next v3 5/9] docs/procfs: Document KALLSYMS_QUERY_* ioctls
 on /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add kallsyms to the /proc file table, and a short section that refers to
the KALLSYMS_QUERY_* definitions in include/uapi/linux/fs.h.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/filesystems/proc.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index fa7a468e8edf..442aae9ebd9e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -761,6 +761,7 @@ files are there, and which are missing.
  ioports      I/O port usage
  irq 	      Masks for irq to cpu affinity			(2.4)(smp?)
  isapnp       ISA PnP (Plug&Play) Info				(2.4)
+ kallsyms     All kernel symbols (see text)
  kcore        Kernel core image (can be ELF or A.OUT(deprecated in 2.4))
  kmsg         Kernel messages
  ksyms        Kernel symbol table
@@ -1368,6 +1369,14 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
+kallsyms
+~~~~~~~~
+
+Lists the kernel symbols of vmlinux, loaded modules, and dynamic sources such
+as BPF JIT images. The ``KALLSYMS_QUERY_BY_NAME`` and ``KALLSYMS_QUERY_BY_ADDR``
+ioctls find one symbol by name or by address without parsing the text. See
+``include/uapi/linux/fs.h`` for their structs and errors.
+
 1.3 Networking info in /proc/net
 --------------------------------
 
-- 
2.56.0.679.gc527c65306-goog

