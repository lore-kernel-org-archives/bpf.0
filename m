Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05390369D5E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484771; cv=none; b=M0aFSXCHE7QmAA5d2PyodkhuXLgWw6F/BVl+JLSWRjMkVPLG/BJwVayV1hyvxlhd0+XtaROdAGprhA6ILzQcW8+Q2ZbBzllhCUBcvLvOdZ2OMI+BuNZDPhYmTPUy6QY98oMyLVdlmXvSBWBEMKcH8O1iFdd5sSMsDftH3NqdAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484771; c=relaxed/simple;
	bh=kOjB9EUx2W1v/7kxzVeOxthVHt+Dm43TqpI5/i1TiXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9hDCa7av1s9iwqjWHcwOETFJiHgndJkwwbwdlM5lPYNrQ8ShQB8ilbxYhz9CgghRxiK3INx/l8UacBCGyLUWpS3M2I6qfClYVJE45p575DwJPXmOc0m3qBQRExxFhFlMe0CoPPJaOK8pQIY4EoPHQGecJGnjYqst57PK4Xxhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXTnKNi+; arc=none smtp.client-ip=95.215.58.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXTnKNi+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kOjB9EUx2W1v/7kxzVeOxthVHt+Dm43TqpI5/i1TiXQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788484767; v=1; x=1789089567;
 b=VXTnKNi+SJNeRM/1eXpdudn9h7lHvuvxQ6t1woolDsx+8GF64lAvFKVJ5ob9/LFf0fbK/6pz
 WrB/Dlm9EZjwJKjOnnLhIGBme6GX8ibQbjZFySO97ec69sIQ7s82lrQrtnw7cQEYI66PYQrCbzK
 ygHlL1FNolqdz148DEm5GysY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9674486ccf1fcb7f;
	Fri, 04 Sep 2026 01:19:26 +0000
X-Mizu-Trace-ID: 9674486ccf1fcb7f
X-Migadu-Flow: FLOW_OUT
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Fri, 04 Sep 2026 01:18:35 +0000
Subject: [PATCH RFC 3/8] compiler_types: Let notrace keep the function
 prefix NOPs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-arm64-callops-kcfi-v1-3-ce6687739b0c@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
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
 include/linux/compiler_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f1390079..87e10920acba7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -211,6 +211,12 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FUNCTION_PREFIX) && !defined(__BINDGEN__)
+/* bindgen generates no code and its libclang may not take the section argument. */
+#define notrace								\
+	__attribute__((patchable_function_entry(CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 ".discard.patchable_function_entries")))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
 #define notrace			__attribute__((patchable_function_entry(0, 0)))
 #else

-- 
2.52.0

