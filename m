Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B2342CA7;
	Thu, 30 Apr 2026 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528117; cv=none; b=auoDRlZ33AB/mBZCAUUgg1SfUHviKIkaBQzS3cHd+22rChAvw9ZgAYhIZqpysPxG+RFBs7yCaxLnQ17q/EEWyLp1sb+XKEZ36CugiCyuSrti8A6y3k9KiZ2xmRQOZAOUpzPGseuEPiI4zqfLnQQ0aQxwwaBDx8/3+NYFFrXj5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528117; c=relaxed/simple;
	bh=HP1pSMM9V2ArS02zWR8uH4xFmoyqTB/Yxh6lYmMea5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZAZQSARt6XBS0WHn8t/K6gBOMZttGYNpXGsofXq0GbxQdaq9WrA8IhZAxcaBdaLeH1f2C2Yaz0MmCohgnMvlGJRwC/Rzuvcwc6XhTEGWkdG4YqKelhJ8tMXQaxxwN6lS5Uu6x5pe5TXbf1ycI0zBzaIMXsM4UmmT6w14X+qjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=b5lLOSZv; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="b5lLOSZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0m
	8TYbetduYdxNm+Um1dv88oPni/RqlOcUYxgZMk5KI=; b=b5lLOSZvuYiIdsV2M1
	rtkvo/HsxQZp6yZjtW/rHyPeYdeOOeUmbD9z9qnrZ6maXiCoOcQUghhOHncuzmbo
	U7IgSPt5wajj9RCahr9kPPyHz6CeRrI0Kcf/7JR2JuhwheR5l/b7b42fwf76xLN7
	8BmsoQf3dL+G7waKmSzeULFyE=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDHN2Pk7PJpXA58AA--.25521S2;
	Thu, 30 Apr 2026 13:47:17 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH 2/2] kernel/bpf/verifier: Support module kfunc resolution via instruction offset
Date: Thu, 30 Apr 2026 13:47:14 +0800
Message-ID: <20260430054714.38980-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDHN2Pk7PJpXA58AA--.25521S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDuFyrXF43uF13WF17KFg_yoW8GryDpF
	4rGFZ09r40vw13Cw1kAF4IvFyUGan8Kw47Kan8J3yayr10qw4IyF4jkr1av3sIyw48A3WS
	yFW09Fyjva4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIhFxUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpAWLC2ny7OWP3QAA3h

Use the instruction's 'off' field to indicate the source of a kfunc.
When libbpf resolves a kfunc, it sets insn->off to 0 for vmlinux
kfuncs or a non-zero module ID for module kfuncs.

The verifier now checks insn->off to determine where to look up the
kfunc address: off == 0 searches in vmlinux, while off > 0 searches
in the corresponding module BTF. This enables proper resolution of
module kfuncs that may override vmlinux kfuncs with the same name.

This works in conjunction with the libbpf change that prioritizes
module kfuncs during BTF resolution.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Song Chen <chensong_2000@126.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 159b25f8269d..93f275e3c1e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3498,7 +3498,10 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	if (err)
 		return err;
 
-	addr = kallsyms_lookup_name(kfunc.name);
+	if (offset)
+		addr = module_kallsyms_lookup_name(kfunc.name);
+	else
+		addr = kallsyms_lookup_name(kfunc.name);
 	if (!addr) {
 		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
 		return -EINVAL;
-- 
2.43.0

