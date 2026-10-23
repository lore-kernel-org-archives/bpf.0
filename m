Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714659;
	b=p2Z4HvWFyvqwMoCcAjrGt0xmruacIcx3O6mXti6ypyvtPWVpqdpAiauK5zGPW0oOSl2Y
	 ax80i+zUaK8JNtRQFdQT9Ysli9VSg/0noi1qo6e9dB+MvUUdnm8kXHE1llWLosN+iIrIL
	 lpvPlBjJJBcQB1YzzqmArk9XjsI76iGn/CkUx11fpt/7DxbX1Dm/7Tll8SARsApIo65zL
	 EPnoGY2v3S/jrtbIDfvJGJal+ujGpT5CSp67YjIH3AjdpaKTASULX/UrlwiIknW50ObcU
	 ScMxuMqn9AJRI77kr/HGjgAIXVlF61JqKycqzNf+vB9AYjko6AM3RlyRLI68NfE7IUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FGFVdcUD4uteaXAQypaWTmH+/zCVpgMAi79JFzYNdNI=;
	b=4majn31KBQGjfWUp5Oej16X3A2kQhUAlhXfkG1gCI2mowkEuncakvJBkRaCd7ERiD65l
	 8aB9wDhRwgX3Ir4Ze//fodV9Pe6ohqw7dlRHYEd2x+mgzGrFbeqml9k+MAYImW+wwiOnl
	 5uYo8tny77Py9r+BWF93TCBJI0ly07Ad4w1lQOtGk0evNiDsqMU89zZZZQlYzIg+JcCv1
	 QQxMQ8HtGG4wbKQPLsRyFQ8ner77JPOUKj8hy5741iwN/UGcaETVhHPV8otP/sNVMkG/9
	 W1iA5SywfPNTdGNW1t6wF1SWePGelw6z4K3a96pyP77cVXLXpWqn1D6EQgE+QAX7kTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sqYqHqN8;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F675606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F675606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sqYqHqN8
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c3c370b17so592013eec.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714651; x=1793319451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGFVdcUD4uteaXAQypaWTmH+/zCVpgMAi79JFzYNdNI=;
        b=sqYqHqN8b2C9rJCdSIP5pixpXsTX2920yN1d7s2o/SmV4SPD2hmw6YaJEz3yDvYtKA
         iSPMoTZBdLnSRU20QVbyo97PcqwC3mfoFnT6y6ewBev7vqiAKdtisl9PYS3ylTJbV8Nd
         SF/3YFB7sPEcIuuiBBK6CPmB8u4BmtVrr/3ql6+jzgDSDSbJMsfS7KMwL2mHf/3+JFpR
         m/PeyE/0IrROwKBm7BMII7pz1si4KeVS0wby68xzfFfXqmcqa49Lcxe1UQPEw2GHzsfn
         b1Pnyv5Zi57Jh1uZqx5b8M+FhLwsFGdHA8X/oDvRvpdEuRU8NcdDjTxNVNGg8QkCjZD1
         b1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714651; x=1793319451;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FGFVdcUD4uteaXAQypaWTmH+/zCVpgMAi79JFzYNdNI=;
        b=FviHGRo4Yz+tBUX066FIC5OaWljl+vOEApb1ldcJXtnHOYRIJllFCzFg/IYZRCJBQJ
         +dxx2yj8Cni8dc0d4XX5JAdAwdP5dvIPtfWyx80mbFgv7wgoJY0fVCtuLH7+eFRoBA6c
         +2P8EZ0SmPMd1iayqmn1m4+YgXEEnO7P4mVGm4KM4ZcRKo7Q581ni1vKgyUMk9vwxYmV
         Ljb/gSVEgz/vzJSW/zlpMCN2fkyQKMPQh6wf5yjh/QEEJF0POLZqwgxwyq0VnSvIA6fv
         69HCw52T673cUsYkUIVh2fn0F1GYW8g05VVFVaVjLxRi+SK7q19mlDpGpa9H+BdEuSzs
         NwdA==
X-Forwarded-Encrypted: i=1; AKwUvBwVkCZiEvC/y0e33Lp878gutGRIZ1dKE3d5AagWSO0NbCqIUJ7qOFCstDGf109vq1S6KLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp8It2EEVNnALJdpN6yxqVFrtYzGiCPBQ99qr8sWaAcU4HagPv
	MkxBWzst8/HXX1p7eicGgeFugeaZTO5trd75yyOsRn8Dw4R4IFc//b81oksVEqZqrSn4qlyWI/e
	TCh7PFbBjvjy9yw==
X-Received: from dycuf12.prod.google.com ([2002:a05:7300:10c:b0:35a:6ed3:3ee9])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:83c3:10b0:367:185e:867a with SMTP id 5a478bee46e88-369d98e5b8cmr933601eec.38.1792714650260;
 Thu, 22 Oct 2026 17:17:30 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:04 -0700
In-Reply-To: <20261023001603.560210-8-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-11-wusamuel@google.com>
Subject: [PATCH bpf-next v2 3/6] docs/procfs: Document KALLSYMS_QUERY ioctl on /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Document the existence of the KALLSYMS_QUERY ioctl() in the section
describing the /proc/kallsyms file. Refer the user to the UAPI header
for low-level details of this programmatic interface. Add a "kallsyms"
row to the /proc file table.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/filesystems/proc.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c102b62023cd..a0e2fe14a01a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -761,6 +761,7 @@ files are there, and which are missing.
  ioports      I/O port usage
  irq 	      Masks for irq to cpu affinity			(2.4)(smp?)
  isapnp       ISA PnP (Plug&Play) Info				(2.4)
+ kallsyms     Kernel symbol table with dynamic queries (see text)
  kcore        Kernel core image (can be ELF or A.OUT(deprecated in 2.4))
  kmsg         Kernel messages
  ksyms        Kernel symbol table
@@ -1368,6 +1369,20 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
+
+kallsyms
+~~~~~~~~
+
+The /proc/kallsyms file lists all symbols in vmlinux and loaded modules.
+
+In addition to sequential text reading, /proc/kallsyms provides an ioctl()-based
+API (`KALLSYMS_QUERY`) for querying specific symbols and addresses. This
+interface is binary and is meant for efficient extraction of data without
+parsing the entire text file. `struct kallsyms_query`, defined in the
+linux/fs.h UAPI header, serves as the input/output argument to the
+`KALLSYMS_QUERY` ioctl() command. See comments in the linux/fs.h UAPI header
+for details on query semantics, supported flags, and return values.
+
 1.3 Networking info in /proc/net
 --------------------------------
 
-- 
2.56.0.257.gf7497c7d27-goog

