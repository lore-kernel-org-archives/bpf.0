Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD434582CC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289420; cv=none; b=mgF0gp8Ch5MaGDEN3QPbfRpnBElec7v6BMK0pPQQ+cUB9nYXF7KEFGItTic9BgQPLc7MvF9judMRyuJYeaQDIg/BoaXQiW2Hfi4FGqbRmbyCUXvt1ZyuVxWwx35Ba15hQCJnFBtKE7fdhuX86D1YVPuGAyvOPVPQ7Yh/BBwq0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289420; c=relaxed/simple;
	bh=FS6X8NELcqU5nbWh3I09msuFV9zg7bXT/RgrskATLK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDAzlWdtoR8yFibsoj/TxtN0NuD/IK1Q85i7sq1zly8bWFf46QIyGXenICgt8wGsPcQX1DsXs89BybkwoKL3zurRtNQ4TPUYcUtLgH7LhDx4EI4bcRSxuR5g7NYjkMqqv+FUE6pQvgzWjyM4PDrHTkxw5YcY2wWEI6YQzrn/7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tq49keNs; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tq49keNs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FS6X8NELcqU5nbWh3I09msuFV9zg7bXT/RgrskATLK0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790289416; v=1; x=1790894216;
 b=tq49keNsE+123XT28v2f2UV3PKOu4ord8lkIG34pedn6sVgkJD0dPMyljFlaiJHVx+WBNlaL
 m36Gg66ttYBBTdKrRFKvsOli34C6ljhXj36U99NgR3dUvq4cCMofmy7VuYu7oDvIm/DbLRWtvGk
 /jqmPxmsrjLlqkeGs/aHuPLM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b68d55e8478d9d6;
	Thu, 24 Sep 2026 22:36:56 +0000
X-Mizu-Trace-ID: 8b68d55e8478d9d6
X-Migadu-Flow: FLOW_OUT
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Thu, 24 Sep 2026 22:35:48 +0000
Subject: [PATCH v2 4/9] compiler_types: Let notrace keep the function
 prefix NOPs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-b4-arm64-callops-kcfi-v2-4-587865b6d991@linux.dev>
References: <20260924-b4-arm64-callops-kcfi-v2-0-587865b6d991@linux.dev>
In-Reply-To: <20260924-b4-arm64-callops-kcfi-v2-0-587865b6d991@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Ben Cressey <ben@cressey.dev>, 
 "Florent Revest (Anthropic)" <florent.revest@linux.dev>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Mailer: b4 0.15.2

Let notrace keep the prefix NOPs when the architecture defines
CC_USING_PATCHABLE_FUNCTION_PREFIX. kCFI callers check the type hash
at a fixed offset before the entry point, so a notrace function needs
the same prefix NOPs as any other. Record the entry in a section the
linker drops, so ftrace never sees it. Clang 21 takes a section name
as a third argument of the attribute. Nothing defines the macro yet,
so no functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 include/linux/compiler_types.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f1390079..43dafaa061942 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -211,6 +211,15 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FUNCTION_PREFIX) && !defined(__BINDGEN__)
+/*
+ * Not for bindgen: its libclang may not support the section argument
+ * (Clang >= 21), and leaving the attribute out does not change the ABI.
+ */
+#define notrace								\
+	__attribute__((patchable_function_entry(CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 ".discard.patchable_function_entries")))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
 #define notrace			__attribute__((patchable_function_entry(0, 0)))
 #else

-- 
2.52.0

