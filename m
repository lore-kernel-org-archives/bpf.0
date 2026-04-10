Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8A33F58E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826843; cv=none; b=YuJva1RXimDm0giK58r19htZ25ME8mXnVwIfbgsHcjPwcmm+HvWE73JlhW3jma8PEK2l8bMuukMIKeocRtvIrSI+AMogrQvQ9S7nu4RQza98bdhNoKQP/T5AwS1eGVpSdP6FUxXdL84i/GOwWRmhc/OQAOBacsf84p608PUvWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826843; c=relaxed/simple;
	bh=976uIWqM+FAARkVCOlYC9MMYiaR61LoNWXMDyjXKX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QM+qwLPygFCsUN2/VjYwIyo0SwUpoB1na6JqmDteNO3f6EqyK0HgKRyedGPTcUqpu52TjmzNvbQXx6znt9jAbRuW4rQNc5DNuOjS4lSD3it/y9zrOhhdMo/1rv0IVruJLBN0KnQyJD1kZ52sa/j1z/FEtZCa1euZOXmm+0d7Km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SOssgENC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SOssgENC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1204587f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775826840; x=1776431640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj9MH/EknDN0OlocU9ytBdhpwEb+nE5xbjRi72XOo6g=;
        b=SOssgENCYtFE8mMVtaMPc4Eoanim850Xwgv5AIOXTwp8WqM+VRz/jO9HfLl3Zpo62r
         keKflhQXPsZFzzpxLmfd/0lQok7w8NW96ijMqf3HNKlXKxjv2LDkbEh3F5Jmb3kxTbfC
         6wHGd/VZqMs1325dwNf8x0z4PXwL9Qre8fDXPHNye5r7Vd1t40lgy3xbhUh6ei0SVKZ4
         l1ajlWnjdjIP+YRAOwI5SKUkJBxGjNnCaht2VjryD4yaBkoF4ZwuHMLlEvWPBKJskfTI
         2538yxL1Oi+CNNXWjXNmPW+ozXC6LuZRpJy7ldrWcvGskS5pubm2t5yc8/dMKn+Zrc3x
         Tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826840; x=1776431640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj9MH/EknDN0OlocU9ytBdhpwEb+nE5xbjRi72XOo6g=;
        b=oworn7VLvw6Sc9TAQyCAbdEd7fkIVCf4kbrvVHj1FDNGXFB3EomcVyuhi9Ncybo8Dt
         czdU75L2flWsx9Do1KoxH15tYHi8Z4OeHLaWHA8hgaewpmjBvWDLrnLlXkxnRajA5lGY
         IvFctZS7lzVMC2D0fvo7drXqkTGWgIUV8E7S6BUOGZscTVccXp0MWhG+/GvBHsQOrGBo
         xA/KWZ5LgTZ/rNfZdR65/A8TpAbnfiHFv9UTVl769DueHFqkp9eW1cESK7wxqs/YnS+q
         A5ZDBUuMrPCTnOoJoI3ngtrLC8TDUVENbzBOmoV+porUoCDnj+meogWLdq2ibPjyW4eq
         PHSw==
X-Forwarded-Encrypted: i=1; AJvYcCUA2WMfO0Rsz1HOyqLvyf8IM17CCfjg/l6/JAJmiWqo5VbfzEC4pnDSUirl2PeMb1wRTYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7TrpZF3ZzlhpMbyJ0Egsc/wm1ln+pvx1QxHcwpObu1QG3IoQ
	SGXy2GWZUgoCnznthyXIZtw3LRAhk3gqk8hTUxt63wVb9DIeXc02TZuI0IlKgpIe7cs=
X-Gm-Gg: AeBDiet615nF6846F2mm5bm/erisklPn0cdX+JkycDEAsG9qH6GX8rR2oX5O0Su9Ioe
	+kXpPxs+CZqXYMAwco0y8J7Ukwh7eUWAbL8Fx9c269JAxoDU1L0tGUpheVnIHODOLQ3ZB396C5o
	6MbYHmZRLgPhpJzfIo5EAKjQBt9QotKHFZFI7p76tylh9qsfqzP5/NuNKLOU6oAZurv9yIhjPNI
	QeXmDx3VpMOM3IJapZoYB2skJ6GY7QCFlmC+z4fDGHHqf7AOjccvAcVtvMuYg/Wfd8yog2iwmaH
	mHXyBB7u//N3oYEezhIhsqn28y3KtSLATR69fiUDSz/4noLSoWBEpbrLqW9PQ/w33ZhwCKv2XN/
	q5qM0IenQUWbcY+PaqjbE80VUcn7teWY8mc2f/DZZtrC/4tnkBSY8YDuY85WZjCSPtkuRJXR58b
	Fpf4tQRasv+u8y6IutO/zFUYCUz21qISerINUJwSPamd55vWv51HU=
X-Received: by 2002:a05:6000:200f:b0:43b:8806:be32 with SMTP id ffacd0b85a97d-43d642552f3mr5071820f8f.7.1775826840140;
        Fri, 10 Apr 2026 06:14:00 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de3499sm6993731f8f.1.2026.04.10.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:13:59 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] kbuild/btf: Remove broken module relinking exclusion
Date: Fri, 10 Apr 2026 15:13:29 +0200
Message-ID: <20260410131343.2519532-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
to enable generation of split BTF for kernel modules. This change required
the %.ko Makefile rule to additionally depend on vmlinux, which is used as
a base for deduplication. The regular ld_ko_o command executed by the rule
was then modified to be skipped if only vmlinux changes. This was done by
introducing a new if_changed_except command and updating the original call
to '+$(call if_changed_except,ld_ko_o,vmlinux)'.

Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
previous logic to skip relinking modules if only vmlinux changes. The issue
is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
retains the raw './vmlinux'. As a result, if_changed_except doesn't
correctly filter out vmlinux. Consequently, with
CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
changes.

It is possible to fix this Makefile issue. However, having the %.ko rule
update the resulting file in place without starting from the original
inputs is rather fragile. The logic is harder to debug if something breaks
during a subsequent .ko update because the old input is lost due to the
overwrite. Additionally, it requires that the BTF processing is idempotent.
For example, sorting id+flags BTF_SET8 pairs in .BTF_ids by resolve_btfids
currently doesn't have this property.

One option is to split the %.ko target into two rules: the first for
partial linking and the second one for generating the BTF data. However,
this approach runs into an issue with requiring additional intermediate
files, which increases the size of the build directory. On my system, when
using a large distribution config with ~5500 modules, the size of the build
directory with debuginfo enabled is already ~25 GB, with .ko files
occupying ~8 GB. Duplicating these .ko files doesn't seem practical.

Measuring the speed of the %.ko processing shows that the link step is
actually relatively fast. It takes about 20% of the overall rule time,
while the BTF processing accounts for 80%. Moreover, skipping the link part
becomes relevant only during local development. In such cases, developers
typically use configs that enable a limited number of modules, so having
the %.ko rule slightly slower doesn't significantly impact the total
rebuild time. This is supported by the fact that no one has complained
about this optimization being broken for the past two years.

Therefore, remove the logic that prevents module relinking when only
vmlinux changes and simplify Makefile.modfinal.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
My previous attempt to fix this logic can be found at
https://lore.kernel.org/linux-modules/20260402141911.1577711-1-petr.pavlu@suse.com/
---
 scripts/Makefile.modfinal | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index adcbcde16a07..01a37ec872b9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -46,17 +46,9 @@ quiet_cmd_btf_ko = BTF [M] $@
 		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
 	fi;
 
-# Same as newer-prereqs, but allows to exclude specified extra dependencies
-newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
-
-# Same as if_changed, but allows to exclude specified extra dependencies
-if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
-	$(cmd);                                                              \
-	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
-
 # Re-generate module BTFs if either module's .ko or vmlinux changed
 %.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
+	+$(call if_changed,ld_ko_o)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif

base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
-- 
2.53.0

