Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834408;
	b=gujPSg/AgQhOFniyhD0VqCSgwvhuHmBOQ8Ar6kFB70QOVaot0drsoiR2wOQjN0oJiK6F
	 aD/46T41hTQ5XamKqRxVBPZF0Rz1K5WgxSChTNOMrjwAU7Lmp4JocVF7yKNxViEM7Lk2f
	 ux8DE0y/rm0CrWbfr9DoDn104tTRlpjvc5mmD1xm7KJtQf1q4swwGqQBikRZQ5GkBp/8x
	 FcPUe21EWwoybIvu+DXfHsBwi0iAHLov465Z7/oVNzRquu+c23mCQInZjwd2xa/BzxDDe
	 4l/fOWoIH28ye7C3TqRBoZEwuk6slGgdc7zEEZmyZedOQ5G27ukAqpIvuKKJHxVSoqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=o/yA7udvOXyy4uaWhVZUf8NM3Y57Zr7Wl3fusqPbyG4=;
	b=iwcCb+QxMoQnDe2kJnlbJoqfOVHhz4bYfKjLFxBV7DjeVAZmOD5lC5Qm39FjZUz5xYxb
	 MWUeIRXTnYbYEleSOzFhZaTPHeG7lwPln4h7vjI7/dBkaRi44Tjs9fokWlP0ij6EtH0eO
	 Y5WssQBxPjNKVO442x2S2vqaYPrUmqeZQPk3h2SxKEBxky993AWwlMRXQ1QG0pC1OobO/
	 9ZyP/dYLge7nNLNQ2d5PSw2irGVgolVur06bGRDDUV35lRcztlC9eb2QNfO8Qh27H0KyW
	 PihWGc9gpwsPZ1y7aygpXBM+hL5LcSNvOGqo49Lp3qi01G2U4LFGBO9jHUuuegkov2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+q4mTXy;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56E606A329
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF56E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+q4mTXy
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8629eb92bebso2998652a34.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795834407; x=1796439207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/yA7udvOXyy4uaWhVZUf8NM3Y57Zr7Wl3fusqPbyG4=;
        b=y+q4mTXy5ZlrWB2wUUxP5TEJaTaMK15HC8OGThrmvFuUXOEA7bmIXJWpeEIfBlOZ1C
         cVaaoHO+8VFcW7BXkV+0KDhuEEfJInWIpU015X9kcf2+xavryXh/bnyxgA2IAZRRbPkP
         3h+pjnKZmuoCnJT74nI4KftDRiaSxjn4CdQYxhVxt28WEB8H03nrcWVJJo9mYd1Z7RlA
         AOGXFZRU6CL5VPWlN7AXbw/nMxS2DSKF9s69CgIpg60YPolWykIVYcy40Ge6mWOcVbH7
         04HpuhHf5ALQLxALyYumIWb49hBxw5+8T8+DjhXOOhRgOOJBmmWJAlUYKhotM0SYqQYy
         jv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834407; x=1796439207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/yA7udvOXyy4uaWhVZUf8NM3Y57Zr7Wl3fusqPbyG4=;
        b=2Vz1Ky+XlUa/UJB8JUvojNm43jCEikal30yVIMvBHM7i6fUBw/itEEKdJE/QyLxoYe
         Irjoh5D6nuBpX7wcGS0D1l5Ml6Ye4QJAfzquY8QKD/gqZJd8e2zf4UL+/uR/rsDbyStm
         rAYfcf3109VcNKCpSwbgnW4a/Snit1o1jxBpHLrxyPr/5K6l5OU5KKtLa5MQlOWAq5Fj
         tJy2B53XKnjcGwh8nPppFKIHRlxA/o3UhSteGHEmKBiIxEbInxSSS2dmJCjaSFFLMrtY
         oDyQwW0ckkOQ/t9Q0j4REUJ4vx+dOlPQWc7UhiIm5rJbV5poBLzd9hWMFSmqVvOr+80V
         qs8g==
X-Gm-Message-State: APuU4Z8PMb7F33nyCxOdk4y3CDlq62GkDHA12SsuOwqxnpaQZae0CW0l
	rAIQOQTvJ2ANy0N6OQkkLfeZAHBv7ZYjSfMmB4xrJG6BwZpgtjpLo7eOyt5hX3QUNQk=
X-Gm-Gg: AZFdTZd3c+VXsUivdPmNZFb3nfLTIUTTtvNrlWHA4353P9AhO73/3Nb/lSOYpQCgjYr
	w9TWzyljcXWtB3Nx9++qR45MVCO8iRka9shf/vmOv0QpX/VnAFxJYKQE+sSassOtELcGEdR3xiz
	bYMhPlsx5aELhvXx4vqtm68q83ZbqrHNZw1KTUtVvJvG3tQ4wXMmNjSAh+mwg+TgEOu2s7aEJFL
	mwunB2akVNVPKwC33ypKitucgUWb+or6DDA/kOnqoQTPe/bP5GIFwCCKvy8WSjYmFJrVdlPFOoQ
	epM+GLGEKgprSOHXvaNHBCyu/doEIVT7ogrovz+xWVGO+GsB6/kpxP3Hi0rxJu8/vVcesq4FiB+
	VVXVSLUP5KaZ3ZqSlYRS/apyhz2pPsYuzEfSHV6oZw0S0e9KJqFCq/lq85myaPVRdTw5iV9fiaF
	J7AuN1WrqIMQkq82ZWpszbZ8KeXWdMgiRb39O0iRbtFNCAXrEcrAXr0Pv32X6Adb3idyLUZvrXq
	7UfpjbJetfjnYVsY6BI/wlV5wPuxoCWfSGWOa4cQWnpAjdNu33vLhcJevcWaXCNSwtoDW6cQC+G
	4Qd4LunN2C8FXXlgnkmpkO4JEWUiDYv2mdr+JRktu05kvQCfWii06gXIsm6Nie1pBHI/lF/KbcT
	DMfeylfJ4APJkU8klTvbJZdmG4AiIQlPQ9d38
X-Received: by 2002:a05:6830:a257:10b0:863:9f9:4eac with SMTP id 46e09a7af769-8631593a1dbmr18727324a34.9.1795834406810;
        Fri, 27 Nov 2026 18:53:26 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168c1bc5sm17698611a34.6.2026.11.27.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:53:25 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/3] bpf: Treat __iomem pointers as scalars
Date: Sat, 28 Nov 2026 03:53:16 +0100
Message-ID: <52249df7401e63679e1ec5c416ef9b12d3ad318c.1795834380.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795834380.git.memxor@gmail.com>
References: <cover.1795834380.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; h=from:subject:message-id; bh=N/0L7RU1DZg49E/9V+NTDUu73bODlWpWWMAIjmhlL5I=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZvLieeb9pkjpRNvceVYaP07wJidcEM/TtbDKr16/8nSCeGe y+52lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJOQgx/+HuenZgbO09DL19vWsO2Vu kPn+bcv5k7/eEc67Kc428fBjP8L7uqsf/PgUnmKTPT/u8KFt7yIWtPxrHLR79wN80VPCwVwQ8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF program can read a device register with a plain field walk. Given

  struct virtio_pci_modern_device {
          struct virtio_pci_common_cfg __iomem *common;
          void __iomem *device;
          ...
          u8 __iomem *isr;

all of mdev->common->device_status, *mdev->isr and
*(u8 *)(mdev->device + 4) load today. The verifier turns the first pointer
into a pointer to the struct and the other two into untrusted memory, and
each load becomes a PROBE_MEM load. The address is mapped, so the load does
not fault and reads the register. Such a read can have side effects: the
virtio ISR above is cleared by reading it.

These pointers now have the "iomem" BTF type tag. When a struct member, a
function argument or a return value has it, give the program a scalar. A
scalar cannot be followed, so the three loads above are rejected with
"R1 invalid mem access 'scalar'". The value of the pointer can still be
read.

Programs that load through such a pointer today stop loading.

bpf_probe_read_kernel() is not changed. It calls copy_from_kernel_nofault()
and should inherit any check that gets for I/O memory.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4386a9a1ad4..c78b37b813e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7632,6 +7632,13 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (!btf_type_is_struct_ptr(btf, t))
 		return true;
 
+	/*
+	 * An __iomem pointer holds the address of a device register. A load
+	 * through it would read the device, so treat it as a scalar too.
+	 */
+	if (btf_ptr_has_type_tag(btf, t, "iomem"))
+		return true;
+
 	/* this is a pointer to another type */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
@@ -8018,6 +8025,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 				return -EACCES;
 			}
 
+			/*
+			 * An __iomem pointer holds the address of a device
+			 * register. A load through it would read the device, so
+			 * hand out a scalar, which cannot be followed.
+			 */
+			if (btf_ptr_has_type_tag(btf, mtype, "iomem"))
+				return WALK_SCALAR;
+
 			err = btf_type_tag_walk(btf, &ctx, walk_type_tags,
 						ARRAY_SIZE(walk_type_tags));
 			if (err) {
-- 
2.53.1-Meta

