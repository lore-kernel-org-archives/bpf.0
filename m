Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361256;
	b=Ok7vg5OlsrbW6qedXaeHj0sJCREH/d21XvzysUTdHNwo+8/KfeNtZwpeaFL5CisXw0GU
	 yE1km0JUIqvzuMFj6MIEGI/lUXQYRNc1edM1vg1vq8ojgxPMoA+ZJ55FqvB+fSgXFXFfe
	 /XZ7cPfBXzNNBxLN2SEcHnlfQKqGgrTmfvof6DY2xv/DOgsgesDTXEPcQSdVj8OIpBhhn
	 ALe6J325FBimXlDTR6WTDXEz9n0xVic8rllZumw8PkdDdA8QpVl6RpZg6BttUZCVIscsX
	 1Wo9EH1ThXe6PyZFaGa9Opv42uWgkplk2SHLnKFNGugbAuqYR1Hzwz+YOZoA6FbTlWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=U7T4/LBkZ2aLLguzrEpLCCec6wWvaqt4jUv6X0yRJyg=;
	b=4w7HKUNis/r1fvYVcQXjZhCsaGU1hs1td/jgJ78uHqjoerklrTXmJjzm8vvHm3P68E8h
	 cFv2WJ5Qfc15iSrzyV0xdA26277PL8A5ONXWCtCjf97ozz3a1Nsgv6TVUNES5Lghkp9/n
	 dDeW3bmDvVlqnjtDgtrcLf+duws2Y6eKSqyi16maVjxvApnNa/hpDf0O2bVJKMIFlxf06
	 QxXdeYmWQRua6ix9Wbvvjw9ug1vGDvDdzYWPtef9ZUOB8ss33ZKY3sfT4ZUz8+j/pLCNt
	 wGMbtvXMS0Lf1jl17/5Z1IoxlpGo9UTytBxWxZpm+jCd/F8qFeCTp8JVQH7D6PBkk3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dV6pIqMz;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC68606A336
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC68606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dV6pIqMz
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so720337c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361255; x=1793966055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7T4/LBkZ2aLLguzrEpLCCec6wWvaqt4jUv6X0yRJyg=;
        b=dV6pIqMz6qcj5WU78ZHzj/KF4aKibYvrs8/6ji6nXDDNh5PDxdyvZSyJvYni9ymT1r
         rNBf1xYhAG/jXaKaFzktQpG2ZK9zdhVyN+y95XF127auwbS8LhI8r0OYqS0XolIPwWOW
         dzxadP/bMd8Vo8VmB2dYjuIMwpZ41MKi4hAOcuDJvY93EbmF+afT1IXyACyZlAW79pT8
         posjpZxdFgNsC0zIb6JimPVaNaLxI6Fqvryx+FhEZTBU+5IIxX0mQrHvFA0khE5DcsMT
         fRBicev11S9ZrLyo5ptfT703aUlKAzBvjIf58F4+8XG+XIcudN/+gRF0zygAR/5rE9vM
         McOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361255; x=1793966055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7T4/LBkZ2aLLguzrEpLCCec6wWvaqt4jUv6X0yRJyg=;
        b=nOvNgEcPJWyHAoG3jSVenXrNCQeXZ+7iPeOag0Fl1T/ep2nUazuUaWwIOJskRQj3LY
         XxZ7Q631WC6uU3pbWmeKRYCg3G6IyWhbWZhssBv22EYb8GmaLrwrtBCGGO3yt26K6DM6
         Ljb3tqb24MwbIp5iTbG86rGl8lD1SgLyQq+y5kG+lKHh9IAt0LFKetTohGoiH8qQ+8fw
         Q9lsiPqbmgIposuMnhwA+qM3MO/K8s4RZjgiSP99sjUbkiPYZsWRb33XMv//zVRzfhHi
         WC/UdDJkGH4fhKSSTvQ4gVYuAYqRasNMuopnOzOZwSYwjF3ZVanxuMEtj6P5w10Jylm1
         Qpgw==
X-Gm-Message-State: AFq9FYK+MOboBZwiEJfnqWWvnG/JchN2ky56hqyOC3WT8iaC7hkzl+uO
	fTX/qD5c/uzkI5rENqSUWI7A7YYXR4guKOshr3v4+UYYfXewZyPbuZLI
X-Gm-Gg: AYBFou2HsZ+UVFWnbAvPIFi6aaMd25g+lfHvxINWA80zzqoj6NRSV1FfpTgevYvNzjT
	NdyF4XY6HU4dFRZilG/y6pKgpLdd5rDes8jLJtulpBBVsE6JkMoYTCMkDc/4C0RlM5dAlm6wXrH
	v2w5HCm6P0qodMb8wtOFTIllJy2x+O57N6lluc8qtwcHivYiOrfKYp2+k9wG9AhU4E+kvauLty1
	Whmaz+a5WR5SQT/SFfLhVmSqSAt3g185pNRe2nwxDzE1TVEXHcn40xIHZzW8B24t/0Fn3BEbkYO
	2ThnhugSfD+5aE/Qj8JDdfn5WuAX/U7cngS+XDROlvOznR3yAGu7cBUc3aj1aWSXzWwFGeCsOmq
	1+6x5F3g2JZVXWRx96vHwhqARpNM3Eno66Ao2+a7Ss2ZXMhrmBfJW7BNhkwIh/eB05+B0LWP2bQ
	5A6vrWjtSEiZbLJcngSmKPIaLbH9+bbOoMA8xhgOf/FJ+1UwvSroatr1NlpPnG/LiK6JKHaJiS5
	MjZKAD4gAVWCZLU1uKmrPK7mSi5DUjQZgYFdpZ31CgO1bE5f6UgB+2dBPVP0K5UnhUcycIn2XxX
	ypEyUPJs9zDBceL1rzkH2IOD
X-Received: by 2002:a05:7022:b053:10b0:190:da74:2c89 with SMTP id a92af1059eb24-1ac5bda4447mr3052864c88.21.1793361255352;
        Fri, 30 Oct 2026 04:54:15 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:54:13 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:52:07 -0400
Subject: [PATCH bpf-next v2 22/22] selftests/bpf: Cover a backward may_goto
 pushed out of range by patches
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-22-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_do_misc_fixups() expands a backward may_goto to gotol when the
patches queued between it and its target push its offset out of the
16-bit range.

No test covers a backward may_goto whose expanded jump only goes out
of the 16-bit range through the patches in between.

Check that a may_goto jumping back over 8191 guarded divisions loads
and is expanded to gotol.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../selftests/bpf/progs/verifier_patch_list.c      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index 1370cdd5e5836..302e739caf83c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -172,4 +172,39 @@ l0_%=:							\
 }
 #endif
 
+/*
+ * may_goto jumps back by 8195 insns, by 32768 once each of the 8191
+ * divisions is guarded by a patch of 4 insns. That still fits the 16 bits of
+ * may_goto, but not the jump it expands to, which has to become gotol. Once
+ * the budget runs out, may_goto jumps back with r6 set and the program exits.
+ */
+SEC("raw_tp")
+__description("patch list: backward may_goto expanded to gotol")
+__arch_x86_64
+__success
+__xlated("...")
+__xlated("{{[0-9]+}}: gotol pc-{{[0-9]+}}")
+__naked void patch_list_may_goto_gotol(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r6 = 0;						\
+	goto 0f;					\
+1:	r0 = 0;						\
+	exit;						\
+0:	if r6 != 0 goto 1b;				\
+	.rept 8191;					\
+	r0 /= r1;					\
+	.endr;						\
+	r2 = 0;						\
+	r6 = 1;						\
+	may_goto 0b;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

