Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563202;
	b=upybUFPjFJysF+bZ+kJ9i4YdJl2BAU/lfN/qoPRajuIrVDONE/PTu3TPhG6tmq/mmVCQ
	 MeDjVsTlT+D47aQhCXaLRlK84QKNyoAnh15Vu3BwmM3Y9oQPsJAOrFWcWbzOWoAmhdJxi
	 GIoj4lVnQVYLy3cRJwsXDLEzCrdb6i14lA/W/lxgWyJNJ0KaPkXcXN03AdwoqtXANmnmj
	 xegeVGCLbQqJ1ShZrng6sxHKI8ZwGMha+add2IWXOmKUs+VUjAPQQ8AKQMbeTaANadI21
	 0tXyxK29i47ulGJvoMITZJteg/6A/THc9t3mter7nIcaq/Vlv7S98Hx6nTYP1/FEqmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563202;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version;
	bh=znUf/Km11N8S85SRs50g3YtGUU6Vndbq9jw05cxqsJs=;
	b=L0YSJqS/q9Jhcl/VjFiJemgEGDH+ZE2lacolH1zZGBSO3j8kg4SSPSUai5EQQPGpAH13
	 o3uCvd5UV1w1BdCIRPQBXacHntvPliVenx04ks4nVnMBzluZH09iIwMUdss8+miwUTc96
	 QWXGJ0YJ0IvHMnJpGXdr5ed0+K3KIjKlF4MVtX2O81wQq8c0/ItgmLrCwLEOuuKBQ/pUo
	 6eIAAYodRjLLnDJn6Sfnll+5tuRBTCEFDpE0jGYOlj4FQi72v5fqRgmKqHEpQdRHRlrxb
	 bYT+qEhDp4+5x3rVVg1TlrebmN6IkynaRzl8bHC+uR+lrZqwkzEqhUaEQRVHAw2YWMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marliere.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=UHW72Qqv;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE2606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DCE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=UHW72Qqv
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4b0348a4c79so3622953fac.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563200; x=1796168000;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znUf/Km11N8S85SRs50g3YtGUU6Vndbq9jw05cxqsJs=;
        b=JkBVAYffMOqKrFdVypIeB2fc8bUHIpwLQ3yMB9HxXjGw5q684jY40n8PC95lbYDAdA
         sE7hTwT+yUaEeB5ZwCYbzp+WnGOmuw658zkEyUOki9+ZHBPjLSlaKVt67PjaOST35/dF
         h7+ygT556gcwJ5xXiqpEDwXoo9pzuF2gSYLqQn4hKiixX3+4EwCL/kc5JqudfCNW6sHD
         47+sTXN8MKUKv6Bf0s7RshB+rDHU1eeLS4SWrrzR/3l8Ss/vEgUvKVCG9JUMNSJJVJ6/
         jnjbP4TfLjDHq90tK211ickE7OPhjKgiDGUmtufQZ6lZA1rNq42ZUzn1aplzBLoRt350
         kSjA==
X-Gm-Message-State: APuU4Z8PPmrIYykxKf97pASRVyh0WU39scs5HF45AFGf7pyLABxe3u4y
	jTlqc46OzNNAJturAlsqyoCQT6BsQNBtmDc2B+BOBv4K1cwbATsWnxIS
X-Gm-Gg: AZFdTZdqy7dK6IW//l+aP0hSfGUOxbZ/n96VvBDu57nxfQIRPzBDB0HR9ZZFnuxdFBX
	Bov19gneMZJTZqBRTMEnCrMqlDwwebQ+HmPf1qNTG7oXaWE4Vzc1/EQgE3T819rnONSGtlu+uWQ
	peaJIG9MJOqGlRV00YtAY/0CDdD8TiY0TmgZPKcC526LaJ2Vq+s2Ur5z7xqN5BDO69iyw82tE2q
	HVEhjKfWEsnUsq5lV+cU7KkezOwXYGBxtOagWiQY/k/eqiqLuOVrI8k8QwOxJSN1LyCX6XoVH1F
	RKDyh4vC69RmLH90/xeH9duv6hIEJKQUVRcDDxyYVEfpsU1iMwFzcg086zb5CwmLKu4Fpft7+tw
	u1h0X5tBU68UK4+il8zAI2yJuwuD+0fT/XNI1RVRoCHKFc1jEfCCtLQfDSKNp4Qq6GwC1G1O4kq
	HZufzHY0FtkwWLnzS7yfNe7FFhuOXVgv6roRIMm1Y9Y1nef5k4N5Zq/1e3austxoUCUiImdHzKu
	4+QQ2JJnrkuATEUH7ohz7Oj230aMzCtngoFBsoR7fZ5SK7QoAN5IEnECrCR9eKtzGKdLH1ZlYjF
	RYGLRr6WLIs2uObgh1o0rVPcgY7M4hLh2LedPuelJCDZaonmW5GBri8ltMkxHalj6BfPexg+gTz
	yXUxnLz7IuJWNqtCiv31H99E+nG5wZgo=
X-Received: by 2002:a05:6871:79b:b0:4b7:154a:7ffc with SMTP id 586e51a60fabf-4bc8492de57mr14027156fac.41.1795563200544;
        Tue, 24 Nov 2026 15:33:20 -0800 (PST)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc6108104esm14656627fac.14.2026.11.24.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:33:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C475560CD8;
	Tue, 24 Nov 2026 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1795563198;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=znUf/Km11N8S85SRs50g3YtGUU6Vndbq9jw05cxqsJs=;
	b=UHW72Qqv89i8lC360ZN9iNrzTXonh2+lxeevC0cbc4653xses/jwf42EMkijqoJUXFXaGo
	epuIay11vxpdKjAkOvHdYRbB+GCHR9jCSGAaFX2V4ZYhhQFRic+MPY6a7d/MTWjoyHcr6I
	HTbW5PzUzIytwODHrVs6mHKCpnB4h5Sr5ysu90Tg6oToHJAIHB94zrBvgpFuYGiIvPusAY
	odC/WWjYfcNybukoBTiJtdOVOJTBYq42YGJboYAXXxy7ddMHVRB0UEmSOSFFCDHgaf+0w3
	vIA+6a6fmAB9EXU2xRLxV/SIod98JRBkr1V+m6n6e3f4wmvmDyThBfoNEGm22A==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Tue, 24 Nov 2026 20:33:13 -0300
Subject: [PATCH] selftests/bpf: Fix kallsyms parsing with long Rust symbols
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-selftests-bpf-rust_sym-v1-1-32c450d0c4ee@marliere.net>
X-B4-Tracking: v=1; b=H4sIALgeBmsC/yWM2wrCMBAFf6Xss8EmXqD+ihTZjRsbsbHspqKU/
 ruJPs7hzCygLJEVTs0Cwq+o8ZkK2E0DfsB0YxOvhcG17mit2xvlR8isWQ1Nwcis+aKf0XBHh5b
 I4a5DKPIkHOL7Fz73f9aZ7uxzrdUHobIhweSHOpXadkTNLLCuXzrXnMSXAAAA
X-Change-ID: 20261124-selftests-bpf-rust_sym-e9b50bb2a39a
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1795563193; l=2089;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=x9GNYVTZscbVIoTr/PE54BDCgTYQJAECt+c+vWQhJWY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOBR1bPe7VWeGHtB6UzYG4XwRM8se6MCKGusMP55IX8GGt+Ah/kTWG5p2j9KUwJP3B7evtcQ/X2
 SZk1JfjltRwk=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

load_kallsyms_local_common() reads /proc/kallsyms with a 256-byte line
buffer and stops parsing at the first line sscanf() cannot handle. Since
commit b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to
512"), symbols may be up to 511 characters, and on CONFIG_RUST=y kernels
some mangled Rust symbols (e.g. drm_panic_qr helpers) overflow the buffer.
fgets() splits such a line, the remainder fails to parse and every symbol
after it is silently dropped.

As a result ksym_get_addr() returns 0 for symbols like bpf_fentry_test1 and
bpf_testmod_*, address lookups resolve to the last loaded symbol, and
bpf_get_ksyms() fails with -EINVAL. This breaks bpf_cookie, fill_link_info,
kprobe_multi_test, kprobe_multi_testmod_test, kprobe_multi_bench_attach,
tracing_multi_bench_attach and stacktrace_ips.

Size the buffers to fit KSYM_NAME_LEN symbols and bound the %s conversion
accordingly.

Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 6d7a4b8c4ab8..f8ad63c5e76f 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -64,7 +64,7 @@ void free_kallsyms_local(struct ksyms *ksyms)
 static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 {
 	FILE *f;
-	char func[256], buf[256];
+	char func[512], buf[1024];
 	char symbol;
 	void *addr;
 	int ret;
@@ -81,7 +81,7 @@ static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 	}
 
 	while (fgets(buf, sizeof(buf), f)) {
-		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
+		if (sscanf(buf, "%p %c %511s", &addr, &symbol, func) != 3)
 			break;
 		if (!addr)
 			continue;

---
base-commit: 475a0cfd02f14d764023e926ac01fc7597134229
change-id: 20261124-selftests-bpf-rust_sym-e9b50bb2a39a

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

