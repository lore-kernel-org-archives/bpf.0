Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DA442FDA;
	Wed,  2 Sep 2026 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788389976; cv=none; b=N4kdLhYUZ49SqfYnj5tkEzvl+9cL2UoMP/SMR+OtvDiidtOUm/F6eodu5ziZlLHtK562ta9UvbbssCEqXPZLt3BUjQYJp8BIex9UyJJOnSN3afUncgC5TINJG6sJ62qaFo4h1+YJ8qXxUSDVjDLgfxcNCDw68n/ZDn/xv2xdLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788389976; c=relaxed/simple;
	bh=zq4LwRn8mJ8lUvn3GMAuVXxvTafQZH2ut49yUSLd9qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+/93BbcXyduJUmSsE5temKE1Hin70N9IPGLxxzQYF9mUUpj1GZM+neJ69BMzBWxAjMWErB2+h0ShYqXCVPg7KCVyOBvt6aoMgVW/7v/UqfxXHkBH2iMHGPRqlqVww3v48uwj2506mBRXooO4xL6Cv5k2c9n2CyoJxwHtu/R/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu (ip5f5af1f9.dynamic.kabel-deutschland.de [95.90.241.249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D61F04C2C37D69;
	Thu, 03 Sep 2026 00:58:43 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: say why a module BTF mismatch keeps the module from loading
Date: Thu,  3 Sep 2026 00:58:26 +0200
Message-ID: <20260902225829.131674-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_MODULE_ALLOW_BTF_MISMATCH=n – the default, and what Debian
ships – btf_module_notify() turns a split BTF mismatch into a fatal
-EINVAL at MODULE_STATE_COMING, so the module does not load at all.
All the user is told is:

    typec_displayport: module verification failed: signature and/or required key missing - tainting kernel
    BPF: [124962] TYPEDEF
    BPF: type_id=124988
    BPF:
    BPF: Invalid name
    BPF:
    failed to validate module [typec_displayport] BTF: -22
    BPF: [124944] ENUM (anon)
    BPF: size=4 vlen=32
    BPF:
    BPF: Invalid name
    BPF:
    failed to validate module [usb_storage] BTF: -22
    BPF: [125157] TYPEDEF
    BPF: type_id=125185
    BPF:
    BPF: Invalid name
    BPF:
    failed to validate module [usbhid] BTF: -22

That message names neither the consequence nor the cause. The report this
comes from is a Dell XPS 13 9370 on Debian experimental where an apt run
replaced /lib/modules/7.2-amd64/ underneath the running 7.2~rc7 kernel;
experimental carries no ABI number, so the new build overwrites the tree
of the running one. usbhid then refused to load and the keyboard and
mouse behind a USB-C hub stayed dead, which reads as a USB regression
rather than as stale modules. mii failing takes r8152 with it, and
usb_storage takes USB mass storage, widening the confusion.

Note, the debug info is all that is stale here: nothing about the module
code is wrong, and dropping the BTF would have let the machine carry on.
Say so, and point at the escape hatch.

State the consequence on the per-module line, and add a once-only
explanation naming the likely cause and CONFIG_MODULE_ALLOW_BTF_MISMATCH.
Restrict the explanation to -EINVAL so that an -ENOMEM from
btf_parse_module() is not blamed on stale modules. Keep it a
pr_warn_once() because a single hotplug event produced 28 of these lines.

Assisted-by: claude-opus-5 (Claude Code)
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/bpf/btf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da36d4b9d31ab..720c56e8ae498 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8525,9 +8525,11 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
-				pr_warn("failed to validate module [%s] BTF: %ld\n",
-					mod->name, PTR_ERR(btf));
 				err = PTR_ERR(btf);
+				pr_warn("failed to validate module [%s] BTF: %d; refusing to load it\n",
+					mod->name, err);
+				if (err == -EINVAL)
+					pr_warn_once("module BTF does not match this kernel build; the modules on disk are most likely from a different build than the running kernel (kernel package upgraded without rebooting?). Build with CONFIG_MODULE_ALLOW_BTF_MISMATCH=y to load such modules without their BTF.\n");
 			} else {
 				pr_warn_once("Kernel module BTF mismatch detected, BTF debug info may be unavailable for some modules\n");
 			}
-- 
2.54.0

