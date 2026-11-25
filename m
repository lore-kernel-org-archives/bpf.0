Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604617;
	b=d9nm6RdmQhSkdZE/W4jb+ICVbdXBu/GxXvoewy959srpb5jRNdvbzwOkSSOwRJ25310N
	 TGbRBvJrKygmy5e7BaJy91N0XmnhtN3slcUBZDzOYa3+qOkIoJcz+HQ5C1Jpt6uFHiN2k
	 f3pqTvgZXtpt/kueNVYmf/47jW7YhsM2ppBe/bpXgdLi3Yx/XsO38puNLhu5xR39zDcoO
	 M9R0zj8QdzxtyPFigb/BRqYV87QPxi7cEzqIuxupyqWcpX7gtWqDWSuQkfj1ncROgUuT8
	 q9O2f705Z1Hp5ZaFeR7URORnvOt+AAtthAW+/ObXCSBiCAoTAdjPjbLf7BP8BBA3wSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604617;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version;
	bh=01q8TemiEbPQScbgUzDguyMv2m06hdvW9i45NWYmZMY=;
	b=Souzux+lSJH3UJrbRi3akA9bK+G2BosHVIXWmH5iTxFXscdiI+1hcce/6nSQPkpwOVuJ
	 f2olJ+zi46+wvGu6+9H4C+SauHrdGj/qncILkuzV2ooKh28P/4RVhkjtMCyeMB3h0aOAA
	 3soRZuMKXjDouf3/IAONyugbKmGN0Hy+UdxEOXzN6QNW27J0F84mpnbEnrJ3qh4UDpnj9
	 5X1ikNgKAAniptzlXN0x8P3h7pYBWXSm2yP6HiaVpuBpfoRUMChCT+q4/HBZcpK21gznH
	 2mttiINqCcJb1QkfKbG+wBcdXVygDILuQRtftk5uaHEHa7wZ5GZ6nRcwPhHCvSiLytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marliere.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b="XQMJ/SGD";
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C61606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 11:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C61606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=XQMJ/SGD
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-499f20c7054so2982501fac.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604615; x=1796209415;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01q8TemiEbPQScbgUzDguyMv2m06hdvW9i45NWYmZMY=;
        b=vYH61pckH0sv1FOVqVL53zc+su7105Od31Vgei7rWyvbnGX9inr1dZD2ekpcBmq3ni
         L00vW3gzCj5GKjHc0M98HhmfYiW29QYluDnu4UjYn/XiSx3pMjvWo8E4vb0nwpbtrBY1
         8MfDWI4lQ5qrbWqwCTztf5Tu32YnfaRqhQyN6bN4GpED7vp1CZQV8u6SgSDKI9CsdI6r
         oO5aFaPZghvUb4CmYBwhJwmq1MmPIVaeFHxKWaOv//+xZ7mZ9iJk6jd/k+Sv9NcOcsGy
         nvsvi7dfMT/LIc8Gsyp74lDyfC7a2dGzjNaQeFcQ3YwnWnD0d4URra4sqz3VvpLEQqzg
         pTBw==
X-Gm-Message-State: APuU4Z826A+X1u2beGi8/PTvPvpWhG5ZNYONiKWoVCAd1wupEG7F4TAF
	2pkp0YBah6ROIXyo1gI8YYDU3/m0k18/DAp9QtLg984Y4BJZnvf1wAtW
X-Gm-Gg: AZFdTZfpZm3VDAPLGQVES602+Gx1mq8gAxcMs7I4ZiodowJESE7RkSty6gh4WYRUm/D
	jHsC6VXfsfqfL0Oeu228o0yx7pLi/Ju5gcoou5RSx9QknRyDJej+E1AsWHqBxktdl557D7oqiWr
	OXANMyAMQI5RtPirEqKmWG4jdonTHGUHCHXmUOYN7gBzrx7SAJNGm5DOIOIqRUKliKV1UEqTro7
	I5iX6o+SwfDrdyAJEVY1k+01Xklu0Xpf6yNVFmEzMPhe11sRObXUYUSXawKlwB4aAbXs3c+Om0D
	9f3a3gnL8n9Yie6t4QgfcdFIico0jN/uaTcHqgANrMIVpzZe8T2RY6pqspDmbfJLBxKWj71ApC8
	a6mNPGYw9QOJqFkk+zOyzwcmWOwsw8cd+HHIzpIbZEBRL8uQ9YcilWRJ0wRYQ9gW3xuzWo4gAQN
	mUG/3RrYY6CptSZut1c4LD+MkESlzEbeC8ruOQDudRX1GJz9B4CR09obo0tgZghMKu8oOt1+btv
	rrDufJIt4cScN9ha9qQx2MFxwFcovaBNwn1LFTn6lMwwdVbaPnKXuhVqHXCUKoeoPuSbO5Nbbk9
	3SHAhm/SsOa56yChI3+QyGZhX49WhknseVnryQ4xoDpjYnU7MwlA9wNrjjz8o6RCKj0WY2LRlPI
	lxn+SILatR2S0vnSwz8S5ofFtXiG7ajY=
X-Received: by 2002:a05:6870:be92:b0:49e:4895:2366 with SMTP id 586e51a60fabf-4bc8208f78dmr16261363fac.36.1795604614931;
        Wed, 25 Nov 2026 03:03:34 -0800 (PST)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm15946324fac.2.2026.11.25.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:03:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B25F605F4;
	Wed, 25 Nov 2026 11:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1795604610;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=01q8TemiEbPQScbgUzDguyMv2m06hdvW9i45NWYmZMY=;
	b=XQMJ/SGDl7Kg0X/2qnCdY3LpM1KMcJbFQ0pxQypPzVhm8COHEUxisIbsIrBUB90w/W7C6l
	FiBNXIOvemLL7PGLJVDh3yMuTAj/lkfMZgpOElbRUHkvtK18Z4KkiAksbjtqBZXBkX3bnl
	mOTh6XYG7PnBSeAaKBb5eolC7iYERs3DcwClqhAkrqbZEqO3kyX9rPGZAxmJcuERDotPgU
	QiRWiWezc2dDmfpEMG9UMCgo/Gh+D7fF9RK3boj2/WhejBFcMPCfluXH6ebsw8UXjlggSz
	lHH+Lat1Ni9B2+Jtpp3ogCZ6W/pLwFgDVD9wog+yicNu06IqZxSUoryofd6iHw==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Wed, 25 Nov 2026 08:03:18 -0300
Subject: [PATCH v2] selftests/bpf: Fix kallsyms parsing with long Rust
 symbols
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
Message-Id: <20261125-selftests-bpf-rust_sym-v2-1-6cf5cff663e6@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHXABmsC/4WOQQ6CMBBFr0K6ttoWMMGV9zDEtGWQGihkphAJ4
 e62eACX7/+Zl78xAnRA7JZtDGFx5EYfQZ0yZjvtX8BdE5kpoa5SqoIT9G0ACsTN1HKcKTxpHTh
 UphTGKJ1XmsXnCaF1n0P8qH9Ms3mDDcmWLowm4Aa1t12Kou0yaAqAqewchRHXY9Yik+TvgkVyy
 XNli1I0whYA90Fj7wDh7CGwet/3LxkB9r/uAAAA
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
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1795604604; l=2430;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=v1+J5AyYE1mm1bqUO9cvlJ/WDdBXeTNjZKb0Tx2U1oQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJv0PKQKIyXStomhGvoJ0TsvTJMYIsGcFuJ7wxLe8AAzeOf5WIoX9JVkQRmWrWDvJCSavAZ19If
 MyhLG1oF5KQg=
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

Parse the file with fscanf() instead, bounding the symbol name to
KSYM_NAME_LEN and discarding the rest of the line, as kallsyms_find()
already does.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Changes in v2:
- Took Alexei's suggestion to drop buf and use fscanf() directly
- Link to v1: https://patch.msgid.link/20261124-selftests-bpf-rust_sym-v1-1-32c450d0c4ee@marliere.net
---
 tools/testing/selftests/bpf/trace_helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 6d7a4b8c4ab8..5f558280856f 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -64,7 +64,7 @@ void free_kallsyms_local(struct ksyms *ksyms)
 static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 {
 	FILE *f;
-	char func[256], buf[256];
+	char func[512];
 	char symbol;
 	void *addr;
 	int ret;
@@ -80,9 +80,7 @@ static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 		return NULL;
 	}
 
-	while (fgets(buf, sizeof(buf), f)) {
-		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
-			break;
+	while (fscanf(f, "%p %c %511s%*[^\n]\n", &addr, &symbol, func) == 3) {
 		if (!addr)
 			continue;
 

---
base-commit: 81c6c8c608b6075846d3bd5b6f57958300a56eda
change-id: 20261124-selftests-bpf-rust_sym-e9b50bb2a39a

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

