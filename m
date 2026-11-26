Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702668;
	b=SgltpkUVc0QZW9Ky9dAqmFUId7vzQdXc8uJAZl/eTHecEljZ7z9tkWzLr73BgeFxKqjM
	 04g5jcEg3S1yuAxAhWaXYEBQjScDPum5AX8IMo46Nt0ztijpvLCdd3qoQVTYhmuUB7lgH
	 7Bt2AMdVRHEO2tDTQ8+Retm7CO2dwLGw07XYutj/670Ke4HRdwuURhyxWnIhGjHHYaWzw
	 66oQsY7cVg2qgpD6AATVmnDSG7U9lCbuyAipb+fI6aT4dM9johWHlZMQXBJC+5oD66d+1
	 +hxo+IyAnoAI5x3NI247OwMpnMIb2RyfSC/itYwFhsJW7/TdVJxWsWgzCV9oRtNC9tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JgROlLMntE0pz6CKDRd4DaMUi7oPhZ5DWcoyTq1OzdM=;
	b=ts+KmlhKYXAeZBPug7sbPBuPyWK07/9vvgP3AdpNKyajvRs3U7cOHGxD+hybu8YSAARg
	 VqMaiE1GzXlR2FdjK5pyriddq5tn2b8qcxXoV/YWalQ0ogBlNimY6Z9vuVTNHQEusl+kG
	 ij8/IeWhDei9ebzNkJIIklbsAoTbxdWHZGu77ZN1mJyjBMtJA8K3TE554DyAqyoJTj3yB
	 bZmCQJeTCKEWaAd+oT5V3GTTCWYrUa8bIcnD8kt/hI3QHDjaBUmIsrPhQrTXF6jFROYyq
	 ioAzYMMDaMl5Dm7YNmb9J3xdz5VkFJIGGSylSJnRTdZxoSG2lbZEosHDDaiSVOm+1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTkmCi4Q;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78359606A32D
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78359606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTkmCi4Q
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so64037215e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702667; x=1796307467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgROlLMntE0pz6CKDRd4DaMUi7oPhZ5DWcoyTq1OzdM=;
        b=kTkmCi4QEwbpXHgTWuj0ILcQBfAwFZtmpFmJK6NSsYWU/CXq5lPv1IG5TV6ZZzF4NS
         e+aFQcfbaJJ3Zn9AFNZuCI20pAjdUY1vg+xOmA7LKGwyuKHAMa+PkCL43mOPV4tvNQij
         nvURwKRd2H5C73aFX0DuZo5b9HY7bCm17tX7dd4H30jZBRYQZqNruYOxedcK90/Cq1AV
         36XCWUyopZxyHur1Q8bovRg0Ijp2Zi+bcIqt13S+XlLrHlQwsQUPkb232k9ytXa1Owgb
         wvGgJ31Uw/E/jqgiIanzZkIMEk16Sql2kFHVVBWRhPjIp7Tj2xEsITOp6Idx6bOkivTM
         wolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702667; x=1796307467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgROlLMntE0pz6CKDRd4DaMUi7oPhZ5DWcoyTq1OzdM=;
        b=FqBJDfg7wxc+VcBJaH6A3AID52k4FfkjIlWuESFeTH5al04SFacXGxUPBvTFnIg7AP
         qwsLASsokl4IJsungu1QBj8ZfGiTWxC6E7i6bKuNBO0xfMkeAMFxAXKOMCnkcJw0/rOO
         ZDPEwAYbmDF6YXEHN/KmwylMFYcUaRt3U7qIwqyZyIweiGxKmap5nKDPuKIkIg+D7lgt
         ILmTYls0stLous21KrzRPMJ6odbQmXV7lqBLg3tqxlQzqaNJtB6j47ch+FYv9B57nx//
         reDEkzG8RfLhvUh8ubxIDp1D2T/DUtFVnfo47Wen3iikHuNepFEZJ64u1Clwjb42qfU/
         6i7A==
X-Forwarded-Encrypted: i=1; AL+hErHkdSjVnb8dP3acpTK4AS7tHpWVKNI1Ik5ibLSDTlDJmGy/SDZSGXdJVNxPvIVhiNU1uo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PdmHEKzEeX1dBQVpqpy8qZ6tRARruN1MQvmKvZHPVUOqc5MeR
	+HAGJUjf3RH33EVC4s5O7kSA2LiFp/lZwaC8o854gbdXhwgJb0EV40p7
X-Gm-Gg: AZFdTZezgBYa5iFDJBRwGhfmrEbw9cXpV9RwUE++OWwSTSzJeYZcV+SJ/BdiDRwux9E
	1rX15urxVtDbwYo3vstDh8Xz9IEFKmsoGzDAaCI6z+uErh/0h2t3x1kNBVfFFAyhlo3vFZgdqeb
	JdC6tzn0EnWhYPmG/CYMv78nH6OZj7cVA1fWUz64UmBdt2BxRzijr86C8sSKjHaarKJnd5DTxjW
	7WJWQQm8g5rJApCPH0N2hYmgFHjKTQAJTzhwxR0CGjMYLWqdqkL2yH9I3JgD1TFTcMQCWQ3i1HL
	bWugI8/ojN8UsGnIyyYPtf6ilHy/Ji66RxtoU5uHmiwT9MpZb9lpXdv8u4BtXlCFWSb4ZdesD9B
	fhF3N2aiZQlIEAZ0ZOA9RPSIVy690dJZQ/73TLUofbH5ANTkuedQOtvrH4/bMh+Jn34CJWLicOA
	loPnnIRDjnM84p+x1E8SwlrxS8pst7mxYPS9DbyDGdjMqLlYFZfmDpUG41fgScZYqCdUxuRXK8j
	TKmkRNZ9tEHmS+TDx0Dt2m50B6hltTN2o9H+wWlBcJgMGmM/4AHudkensc8E2e4pnc0PYxJ728r
	N7LPZcAjlMNhensnCvDUSJ1AaucbJR2JFdx+HmQlJV+TQc7ZgejFw/J+vDBRTftzM1Tu
X-Received: by 2002:a05:600c:840d:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb88820cedmr443639905e9.22.1795702666776;
        Thu, 26 Nov 2026 06:17:46 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:46 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 4/7] resolve_btfids: Exclude a set of functions by name
Date: Thu, 26 Nov 2026 14:29:10 +0000
Message-ID: <20261126142915.1106330-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
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

ftrace reads the code it patches with copy_from_kernel_nofault(). A
program which makes it fail breaks the detach of fentry on x86:

  unregister_fentry()
    update_ftrace_direct_del()    returns 0
      ftrace_replace_code()       ftrace_bug(), no text poke
        ftrace_verify_code()      -EFAULT
    bpf_tramp_image_put()         the function still calls the freed image

On arm64 ftrace reads and writes the code with aarch64_insn_read()
and aarch64_insn_patch_text_nosync(), which calls
aarch64_insn_write(). They are traceable without KPROBES. The same
holds for them. Two more functions break BPF after a skip:

  target                         error    after the skip
  -----------------------------  -------  ---------------------------------
  copy_to_kernel_nofault()       -EFAULT  arm64, with KPROBES too:
                                          __aarch64_insn_write() fails.
                                          ftrace_bug(), no text poke.
                                          text_poke_memcpy() ignores it.
                                          bpf_arch_text_copy() returns dst.
                                          The new prog is all BRK insns
  tracepoint_probe_unregister()  -ENOENT  bpf_raw_tp_link_release() ignores
                                          it. __bpf_trace_run() reads the
                                          freed link

Do not tag these six.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 7d26a5c9b028..b425208702b4 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -87,6 +87,24 @@ static bool has_bpf_types(const struct btf *btf, const struct btf_type *func)
 	return false;
 }
 
+static bool excluded_by_name(const char *name)
+{
+	static const char *const names[] = {
+		"copy_from_kernel_nofault",
+		"copy_to_kernel_nofault",
+		"aarch64_insn_read",
+		"aarch64_insn_write",
+		"aarch64_insn_patch_text_nosync",
+		"tracepoint_probe_unregister",
+	};
+	unsigned int i;
+
+	for (i = 0; i < sizeof(names) / sizeof(names[0]); i++)
+		if (!strcmp(name, names[i]))
+			return true;
+	return false;
+}
+
 /* Find kfuncs and helpers */
 static bool *find_bpf_funcs(const struct btf *btf)
 {
@@ -290,6 +308,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		func = image_func(&img, name);
 		if (!func || !strcmp(func->section, ".init.text"))
 			continue;
+		if (excluded_by_name(name))
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
-- 
2.43.0

