Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51240866
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704856; cv=none; b=Pz14oBV95aWQiRyyfTIeh93MvHq/osEZG7ohFbEjkuXDRqf5hH67Z/wYjBp4CqJVaczUC+bC6e1+942NXa0ysHSaOf+llVqjWOE4MHcjrQZjcvAMFgIFmZEzlVR17zkfALRfpSe94WKgYhw6nDSY4BRllYbdmYWK9TMctGOdEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704856; c=relaxed/simple;
	bh=7xZ8SeIpLR8unxHGJ2waGwWOo71Rkq91p6J16D7wil4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3weQUjodEQEFFbRHbWttrgoNjFwFGUY+RE8S3K2tONNnmTItCxeK0FGUC0c4rhzPybE/8oA2/6JNSE6l3Se81C3RkL9uhAX1W2OrccmAlH/2g+QB7zPLKuk42ThsJPwhEfYAZ/7x+yYBauqOKAtDITJmPCy5xp8e4/siHfwOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdBIRzPx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdBIRzPx"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so3022672276.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711704852; x=1712309652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcRm/bqwNQMHH+e8ox8c6p1gyU6LuJWVGjxyAVGlxGQ=;
        b=xdBIRzPxASDpXxfQyffaW9n09aLkGXLW6RIh/qJzQ0Sr9yzGG+MWT88y3ag2R3Uj40
         A55TBeliLa2Em4urkNfUs7XdFsdeiddLRzaekgovUe+9JqLUNo5OTnQ757LfWLJG8QyF
         1WEmLsRLzLflywU7/RJbqijp0wnTfYE2PiLO1HIRGJcLy8jargxaCRCnV9Yd8U3PTm/c
         1EFmeOT8YB5SzhwurfDK/LiYokZESvPGyiND7QJ/TmUo/qJ/eYkLARDU4aDCqNkn6Ur5
         KCqi0w0hY7drGSM6tc12ar/eeBkefUkbAZfsxZceBFwESKtX3Fl36feybDuQF5V37IBl
         YdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704852; x=1712309652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcRm/bqwNQMHH+e8ox8c6p1gyU6LuJWVGjxyAVGlxGQ=;
        b=C9uPZE0k1eXsU7JnAwuq34B71fVFPjxJMHZ33KfcygTe7BmKwqfbVvShwOUMOpxpDo
         mcb1Onwucp8AfDIBC5I2UgmEjeGk6aJFa6xeR8RmIhS8x2lHmYuVgioYasGVstUWzUJh
         tTbw8UqCzFE4/wvZ723XfuLb3i6De7Jug/Pdg8XQQkJmDoLQC/20rnB2biGh9hs9HZTk
         zANPyEjZSGy8ENkTwd+1C35UXJ1eHv+RDLCO1PkQt+R0suOcU9DRXMhulPNoP1O/a4u6
         hCzHXAP0DmQOm9o1TAVnFrGP+f2p9yiwMpKvStM38nS7FBeqOghofR9m7nP31DWl7Oiq
         X2RA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7lho1299AVVopkuy9lGG8EQ8BTJO8f86LEhP7bhMJ5jm+G6FaIWRXR3WyoXYP0EXwZO+nNrMKVtJ+FdJQg+H/cwV
X-Gm-Message-State: AOJu0Yyn/qu8KZzKjY6vVtmyX+eQ6tVZbzRKgmuS8TgdPYjNprsGHpTn
	U1caEQwLhGvwH0iUTm5L1V/Aeg9krnmvQh0l4JB+PfYvvfaN0Hmwh8a9fbZr0M62Jc+oQw==
X-Google-Smtp-Source: AGHT+IFEwfUbLHTvkc8MJMJvLtHR8bnLhlr/Akn25B9EgNmxsaSATpfpG0uSKrZVv8v1js7hDQE3EGer
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1888:b0:dda:c57c:b69b with SMTP id
 cj8-20020a056902188800b00ddac57cb69bmr570656ybb.0.1711704852336; Fri, 29 Mar
 2024 02:34:12 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:33:58 +0100
In-Reply-To: <20240329093356.276289-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=ardb@kernel.org;
 h=from:subject; bh=bi9e/PWpqNvBy6Iv3Xzt+OhmpfAYnnfD/65oU75l2lY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2tm00x2uq7Idudy4Er3V7GfTVv3fhVhfl+pYyr8bq5W
 pza3qkdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKGLxl+s31SeLyG/9XPMqFv
 fiJi1exiV39eiVXKW6lf2sfdpMtVxMjwtiuhyFi/YVq8kULm6uyOFvOWV5/mLosszbCbJ/pM350 PAA==
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329093356.276289-6-ardb+git@google.com>
Subject: [PATCH 1/3] kallsyms: Avoid weak references for kallsyms symbols
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

kallsyms is a directory of all the symbols in the vmlinux binary, and so
creating it is somewhat of a chicken-and-egg problem, as its non-zero
size affects the layout of the binary, and therefore the values of the
symbols.

For this reason, the kernel is linked more than once, and the first pass
does not include any kallsyms data at all. For the linker to accept
this, the symbol declarations describing the kallsyms metadata are
emitted as having weak linkage, so they can remain unsatisfied. During
the subsequent passes, the weak references are satisfied by the kallsyms
metadata that was constructed based on information gathered from the
preceding passes.

Weak references lead to somewhat worse codegen, because taking their
address may need to produce NULL (if the reference was unsatisfied), and
this is not usually supported by RIP or PC relative symbol references.

Given that these references are ultimately always satisfied in the final
link, let's drop the weak annotation, and instead, provide fallback
definitions in the linker script that are only emitted if an unsatisfied
reference exists.

While at it, drop the FRV specific annotation that these symbols reside
in .rodata - FRV is long gone.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..e8449be62058 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -448,11 +448,30 @@
 #endif
 #endif
 
+/*
+ * Some symbol definitions will not exist yet during the first pass of the
+ * link, but are guaranteed to exist in the final link. Provide preliminary
+ * definitions that will be superseded in the final link to avoid having to
+ * rely on weak external linkage, which requires a GOT when used in position
+ * independent code.
+ */
+#define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(kallsyms_addresses = .);				\
+	PROVIDE(kallsyms_offsets = .);					\
+	PROVIDE(kallsyms_names = .);					\
+	PROVIDE(kallsyms_num_syms = .);					\
+	PROVIDE(kallsyms_relative_base = .);				\
+	PROVIDE(kallsyms_token_table = .);				\
+	PROVIDE(kallsyms_token_index = .);				\
+	PROVIDE(kallsyms_markers = .);					\
+	PROVIDE(kallsyms_seqs_of_names = .);
+
 /*
  * Read only Data
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
+	PRELIMINARY_SYMBOL_DEFINITIONS					\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..22ea19a36e6e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -325,12 +325,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long symbol_start = 0, symbol_end = 0;
 	unsigned long i, low, high, mid;
 
-	/* This kernel should never had been booted. */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		BUG_ON(!kallsyms_addresses);
-	else
-		BUG_ON(!kallsyms_offsets);
-
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
 	high = kallsyms_num_syms;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..85480274fc8f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -5,27 +5,21 @@
 #include <linux/types.h>
 
 /*
- * These will be re-linked against their real values
- * during the second link stage.
+ * These will be re-linked against their real values during the second link
+ * stage. Preliminary values must be provided in the linker script using the
+ * PROVIDE() directive so that the first link stage can complete successfully.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[];
+extern const int kallsyms_offsets[];
+extern const u8 kallsyms_names[];
 
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
+extern const unsigned int kallsyms_num_syms;
+extern const unsigned long kallsyms_relative_base;
 
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const char kallsyms_token_table[];
+extern const u16 kallsyms_token_index[];
 
-extern const unsigned int kallsyms_markers[] __weak;
-extern const u8 kallsyms_seqs_of_names[] __weak;
+extern const unsigned int kallsyms_markers[];
+extern const u8 kallsyms_seqs_of_names[];
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.44.0.478.gd926399ef9-goog

