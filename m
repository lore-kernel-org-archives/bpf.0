Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403302;
	b=OlcuFtclwDvamMmjDbm4Mfo1KHZgfzq4VlW6VYzL7Uo5WI2IHo22eLShs9gxx/WNJLHF
	 aVX0eA45rnEIQObZH0AkiS3ApKLGGcP8aiVn1wJN0wSFRhKzdTF5KE1uJ+WNlb5QHLcDp
	 y5hs/PAmwCbYxqNF6C7SqFyTJgyfN4HpiAUCo7PqcU5ubCKtQqaRmoG1kBpBOng2sbD54
	 7ch/zDWbD5A47h534tXeQ2FbRj4mMapYNDZ7r8QHJuacKee23AoJQ6lHdTPMzj+T9/Auk
	 QR85qO3hhXqQJG2/X6YONinP+AzogusGzU5Ab/P9aphb62hZGsUPLiDOEr8OcbQiiuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403302;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PW75fuYRTck7inYQSwvPjwVqfjnHi/lsVFB1vgmA5s8=;
	b=4dUs7I89daWDbEXNi/SehJsPG/gnWG20xCMFKd73QGkD5zi44cGvbEs2TMRxgnkcsZ0H
	 GGFI5uMiayGZdhCcauHHUe+kIdNfsvjT55yjaOsr1yKH/5YavWjEaYdAU2xbjI2uEkgaa
	 h4BnMKUnVKmXi5ANpkmGwg1XLVxGL3BHiOWEq/eCEOqg5sOuP+23jfZglkiN6Psam3nmJ
	 1HGtSCjc8PDSIr1fMRzsZmTqHSzI0T45AvlEvUMqiMHwvKF6Fdr+CqkDMSC0JGFYCHpgF
	 YboapGBbDYS0oWSYMjiWs1UTI5Q+rWmx24btzhOFReVOV/z/NMJzzt2sz5Eg+LzLD/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HwDxi7rK;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCF606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FCF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HwDxi7rK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8lSXJzMU9zvQ9DgtNFshofjCGIcMM+m6oMEhuu/zLHs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403300; v=1; x=1794008100;
 b=HwDxi7rKvYzI270ySsHcTYmJNkSB0y7q9x0cGl3G5MVOZsU93UsboWu1wJNqyinIe9uYSONV
 EwfEheSlNwBkYQGG1aGwiKNU/VZ0FUj10eoRdZzjXsOvBWIPFahEAxJkI4tWFFjaBxmuIjqvF78
 hcE5RcPuW5i+2a7XMdYOOUq0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1b5a8022bc45df32;
	Fri, 30 Oct 2026 23:35:00 +0000
X-Mizu-Trace-ID: 1b5a8022bc45df32
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 13/13] bpftool: Document __bpf_relocatable and __bpf_static_offset
Date: Fri, 30 Oct 2026 16:33:55 -0700
Message-ID: <20261030233355.1836749-14-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C dump annotates record definitions with the __bpf_relocatable and
__bpf_static_offset macros. Programs control the attributes through
these macros and BPF_NO_PRESERVE_ACCESS_INDEX, which disables only
__bpf_relocatable.

Both macros expand to complete attribute specifiers and can be
pre-defined by the user.

Update bpftool documentation to explain both macros, and how to avoid
the Clang crash on CO-RE field-info builtins over __bpf_static_offset
types.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index c6dc445cd4a1..6840d5d3c39d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -70,6 +70,32 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     formatting, the output is sorted by default. Use the **unsorted** option
     to avoid sorting the output.
 
+    C output annotates struct and union definitions individually, with or
+    without **unsorted**. Most records carry ``__bpf_relocatable``. The
+    generated header defines it as
+    ``__attribute__((preserve_access_index))`` where supported, or as empty
+    when **BPF_NO_PRESERVE_ACCESS_INDEX** is defined or the compiler lacks
+    the attribute. GCC-BPF can apply CO-RE through these attributes.
+
+    Context and socket types whose field accesses the verifier rewrites
+    carry ``__bpf_static_offset`` instead, and their nested anonymous
+    records carry no attribute. Where supported (Clang 18 and later),
+    ``__bpf_static_offset`` expands to
+    ``__attribute__((preserve_static_offset))``. It is empty otherwise.
+    The attribute keeps static field offsets in load and store instruction
+    immediates. **BPF_NO_PRESERVE_ACCESS_INDEX** does not affect
+    ``__bpf_static_offset``.
+
+    Either macro may be pre-defined as a complete annotation, such as
+    ``__attribute__((preserve_access_index))``, or as empty to override
+    the policy.
+
+    Clang 18 through 23 crash when ``__builtin_preserve_field_info`` is used
+    on a type marked ``__bpf_static_offset``, including through
+    ``bpf_core_field_*`` and the CO-RE bitfield helpers. Compile with
+    ``-D__bpf_static_offset=`` to use these helpers with an affected
+    compiler.
+
     **root_id** option can be used to filter a dump to a single type and all
     its dependent types. It cannot be used with any other types of filtering
     (such as the "key", "value", or "kv" arguments when dumping BTF for a map).
-- 
2.56.0

