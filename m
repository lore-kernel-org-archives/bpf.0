Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683A511E72
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542212; cv=none; b=hIZtQvrmoXbaTNUGYIRXmzPPiMzOW2pFhZwoL8wy11zxFueskwdBQxiTS516z8PvgC8LYS02Z2crq1TMbkgKZUnnpUy/HFQ0gH4ZNPTxw2F/YqENC3bwjQVm/xlWpUVo4yjoJnqpRh9ZTLcBkQgiPBS/MPXtIjBO7Ek8Cus++yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542212; c=relaxed/simple;
	bh=wiaIP9TTDtG/WSiCbsCjIuJjGjR5RUOLPoZLVQEJvGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myWxMDnbW0YrJDQhvcKW7dIQNM0ONjwE9RYu6Yg37/ZKg61njAz8lNADxWaBKpSC6ZrM+ycMm3m2kGJClfI/9opO5FUhT5DtfP0xA6ClxoNLGZdwf0npQ11iOT963R5zByLSLmiyVVGGxovszTZHQp8cLNFv5Ws+K3cP2ZWGI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMu3p0W6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMu3p0W6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482e4998d28so956098f8f.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542208; x=1789147008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXMgamQiJ3XS87+vyDMMhRmFoTwg4dOgSBXjUApQgUQ=;
        b=bMu3p0W6+gqmRdCjErvDcYo9P1P2BaV9ssA+0NEJ8KqVPsD1aTUu8VAZ0uObn6Yen0
         dz70CXh1xRUS3/CTzNrW2wCCZie/jY8Z+Ijt0aSH4Hj0WHCim1V5A4fLkuI92CcrUbk/
         7Nvi0Sx712PFecGrUoG4+kHFIQrfTdCKIixPib76eFMDvl2SWh/OSyaWp1iP9CynwVgp
         Dc6YLNU5sYofA7RLCLRMOv+KYLcVqgKDR4NID9awKgpoSCbPuGP+RJ6TLyxoWGn7apoy
         KjzDJu15d/ER7pR1gW0tPUsb5s+UWMnFQwq6ai39c7bdOQ0TJd7ylJIIWyqdlK2a2Rpv
         16Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542208; x=1789147008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXMgamQiJ3XS87+vyDMMhRmFoTwg4dOgSBXjUApQgUQ=;
        b=qeqOzCzEFGhG6mnhcGM/i/hlCAsGLg7/mNCR/oIj3KYdgSE2tMoLu+TXyrDN3Mf2V6
         r4+8bEFylIz0oKfKuE8HqtxAYolYSf+zM4AynRFB8m38y35EvYFJNr0SzdRDAEru0qFf
         E6vVB3fk1n/JE5PzYCNgel07XHdDgHFTolK4QC0laXeIS329K7TFt5S2hte8CrZcVJJe
         F/pi33dJrZ8MjXblRPBclgJFaeL5uaiU/IzYDo0hvQ1UDsojKL8uaaf4qXzZkIZx1wbM
         vTpi3D8sVkw+ypHK/Z39ZKH87sgU647bYbgnXoAR51yZM2nL+r3bjVnAxFgF28Ghhmf6
         h33Q==
X-Gm-Message-State: AFuF++m1240r8GpCZ9MxjvzeIXvT2YSQgLEIU8ycyM1tivpFCZNhC68l
	EZte17j2np9T1YzR1ZWE/MrzFU/j0djYz93pV2r2/4ifwUuwZep3KNUu4YzIsg==
X-Gm-Gg: AYBFou2LtUiNXkEQ68Ba9wVasMVvMl1Bzy64isO3Cyp1SCYVq9vN7P5fmGHx5ox8+ML
	JMm7GZ7Xmzqr56e1DBTQllTS6/aMxscURyVlminxewRO2iffXH/Ylxwg6h4YY8t/8Xz6gc17pv4
	mVCLH+71riQoi5b7/ZpALhIDeURMXya3ov4XBlxExWACo8Fpzr9Nlf6zgfVb96rqiWmPH0CWkNW
	saum+OQdElx6iDTwC5mAjF5JA2DvFY6SjSCgL/wXNDFoVEsxs2o3Y84KIdcbqfcm0KvVDX5bvjN
	3a2E1WbCYwvxpn2gYaleZ5d+I3MYJDtbzcU18lrZ+ZJUXbL4LYR5AP3DFly6GcInb7twXqAU0nX
	V7fcciUCHuhrJtJXP8EdCI96uHraOS6HUZgwkbaL7N38X2ha/UtLIxxCtDSoi6eP06JxRqKLHYF
	QjicEL4Z5N8LmIfRlgjk78YMoWX+4NibuwQ+QOo4QPnvloj3lO4geuWao/yy2D3BaDB4XgDvapM
	0zYK6beNGf+aiSbEkG/AtLeONiAeKb2WQ==
X-Received: by 2002:a05:6000:65b:b0:485:8ee5:5ffa with SMTP id ffacd0b85a97d-4858ee560a6mr1665815f8f.38.1788542208096;
        Fri, 04 Sep 2026 10:16:48 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm4119785f8f.3.2026.09.04.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:16:47 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf] libbpf: fix log level propagation for light skeleton loaders
Date: Fri,  4 Sep 2026 17:16:01 +0000
Message-Id: <20260904171601.336613-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool's -d option is documented to enable bpf_trace_printk() messages
from the generated syscall loader when used with -L as specified in
commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
and "gen skeleton" command.")

However commit b59e4ce8bcaa ("bpftool: Switch bpf_object__load_xattr()
to bpf_object__load()") changed bpftool to use bpf_object__load() which
call the internal bpf_object_load with extra_log_level to 0 instead of
bpf_object__load_xattr with the user request log_level.

All the plumbing was still there to generate the bpf_trace_printk()
instructions from the generator but was now unreachable because
bpf_gen__init() was called with extra_log_level to 0, leaving
gen->log_level at 0.

This uses the obj->log_level field introduced in commit e0e3ea888c69
("libbpf: Allow passing user log setting through bpf_object_open_opts")
set from reading verifier_logs in do_skeleton(). This preserves both
object-level and explicit load-time logging settings.

Fixes: b59e4ce8bcaa ("bpftool: Switch bpf_object__load_xattr() to bpf_object__load()")
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..395c4dcb54de 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9144,7 +9144,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	 * permit cross-endian creation of "light skeleton".
 	 */
 	if (obj->gen_loader) {
-		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
+		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
+			      obj->nr_programs, obj->nr_maps);
 	} else if (!is_native_endianness(obj)) {
 		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
--
2.34.1

