Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44825513542
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800753; cv=none; b=tLPKmIVU65Lo6xwydhTPcPH5Ka7sNOzgdsgtOd4JkNR32cbk9uBqjiWxiDtnONCPM8yPNbT5Z/Xy831C+rkPlscuVWxtdpq8psqyuwabAA87hVsQdIhod9ROsxw/x94eC6ojSVbVdJWMiAgozB8ybaTa2O3RsOpHMIiuIUcZI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800753; c=relaxed/simple;
	bh=kry/VOnp8gGARe/TVRNABFMapq00adZ+CMOlxgjK1+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cb1uoCLM/lsg/wisO8UkkZSUf8Y79YDJxiaxYx3SHlVHc+8QnQ2sTBZofbQ4VAhwt1abar3NxdnnOAoZMPzc9CcL/ZDZ8niXxBCAwCL+lyhY5e2GqHD1WM8XLqKMQBsleWcCeRncujQTBKbG5QuHndw2fnTXGopZ8KSAmUlE8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFi4zxzQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFi4zxzQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so2302653f8f.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788800750; x=1789405550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pg361us6OadAIFXLa1WJ6PQ/ub48H2GT5TA/zN1TKOs=;
        b=WFi4zxzQ+kCkKHuWHZ1WTUfgw/N/9L4fqVbnDyp3yGNksFaXitMuFVYZ6MdWrl/JX7
         mR7rkGQ2BGq54SZADfb3fdpRUltc++D35WYxpSQnykGgUUBsUg1+rZdwimRJMeZ13Rbm
         K/b8ow60Pfh0Of9h8Y2ud6kwGqR8woCS+K5+DyKHUQ9Vt3OZkNTAFjJoTQyEF2URzD27
         ibAgikpJBFe8vKNwY9jLrNOyv5alQxtWo5mJj6JPHgbAxHZU3lZs+L6x4mQlGdP70lU9
         4Krmvqp3pfvAykSGWxHTMiPkJYo0rGR2Q6lzvuPcvcfuZR7GTawjljNejEzSMcdDpGSm
         Qqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800750; x=1789405550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg361us6OadAIFXLa1WJ6PQ/ub48H2GT5TA/zN1TKOs=;
        b=Een1OC9jtENgNOFDDvDmnhuOmsNaSLjqeiCooSf3qAq/xPDofi0wv647Um0/DnTsZL
         gmhb4uVAknmS4r8C2T1lSW4xj8uudbho9QQv1bHMwl5Q5POzNw5EX/anMMWlhvZh8ODV
         WyMy8NGrgu2c63q/2fnHv0Id8ZE2mFoOxWHtkfsqi6O1XdfNG5DEJ4Rsf5vIKv4y0coP
         FOIgVQJv+kZzgLdJ1mKKLqv0nVptXh9LUXKmyRfhwGNsdCZLUxFp0yHPE7I1UQGwox4q
         BETU8bkjK876H4Qn0ADZlt9bj+hZsPnTNRb5c2NTZJsN4QAzIvApFjErRptgAVy4tUWb
         cd8w==
X-Gm-Message-State: AFuF++kEyzrZVxcFTZEOeGX6zu2vPcaY3+Sr9LAkSvbxYgOoO4nOYqjG
	sb7VSCXfrAdQeKufosBjDNfTTGNddyR6HE1wJJW60xcV/e7OqTgfAv5Dj+vfTFlE
X-Gm-Gg: AYBFou0YzTAWi4JjQ0V2kzGR97FaOwZ9buyxtKXbF67UUSkQP+FRkivnaXyCbu/WQJW
	egBNTYtJ3c8zz/jiwHTFeDZOnLRyjonAuHFJem8432fhmojiDdEYBZ9V+7AW3WeAjeriJj0nbmI
	DrHBJJfudlD+4v3PWi+08i1TEEg9a000OvslfqdKg0vTawPBkpQAMQ/Y/gzGiUyv5sNBsnyzKf8
	v7iGMzOqYKxC0hQLnQ8biyQsi2MVONkb2UMChm/vvKqfb158eoVagPBXj62dDfs3JKcMdba6QUK
	fiBckUqaqt6Cr0cKhdKdqUwvbxUrtiYdQXmOvYQReNrNhr4Mz0hC07wy/yy8Kn55FMn0PQ+5Ksc
	YT9LCSlu9+rSQyNMpEHOUU75sh9Fjn6i25VRvRl5yDMDcr4kN0cPF7hA0QzBKReCldU6b990yb1
	lPZKJ+kLcxqJUC/OpQPwXs6HMxFkQ25MNGLkSlkHsTUWsO28RGxUGr8n354cuglpX4pKHCMH66l
	woHBgig9aljcrkc6/b6T3oWr1Gs6Bz3AQ==
X-Received: by 2002:a05:6000:26d3:b0:484:3310:710d with SMTP id ffacd0b85a97d-48587291448mr42015337f8f.25.1788800750208;
        Mon, 07 Sep 2026 10:05:50 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-485885be01bsm29195446f8f.31.2026.09.07.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:05:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] libbpf: fix log level propagation for light skeleton loaders
Date: Mon,  7 Sep 2026 17:05:36 +0000
Message-Id: <20260907170536.9996-1-mahe.tardy@gmail.com>
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
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
This v2 is just a rebase on bpf-next as there was a conflict after the
bpf tree was synched. Daniel suggested to push this to bpf-next as the
libbpf GH repo syncs only from there and added his ack.

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

