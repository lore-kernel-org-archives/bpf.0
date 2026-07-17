Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F163E5A34;
	Fri, 17 Jul 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283281; cv=none; b=MWQYDc+wpz0ryMR8zdUoOQfElyEG6+Zn4NPGcJqnX2OnoYxB2t6Jj3maKQVFkXBxJzcC9KEK5Xyej+urg3z8xIjFz3SMcRuNd0q/eRYyrydQzYqECg4UsD46FYtwv18EdLa1lZoIsUQPzotIUC63h1/cMZ/EQwgotg1IQOvNex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283281; c=relaxed/simple;
	bh=MbnU5nsfcR/D37bn1oyo20h6OIACSDYRlpSPuSj9ibk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNhogzHO2KWZkj1npUulhaEUjCRXR9lgqXFcSQi5khT8LUpPaDXr7WFBg4S3pkZaRToaCmk76nQ4vUo3KnMyQDaYxYLYX11zKz8gvmQI6YpSYP5Uxv3vDI8gq0DuAik0vATLSrcYDU/lsfrZ79FsCxsn6oJuuxOmAOt+W65gJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4bf85b6e81c811f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c156f080-ca78-445a-8285-65dbbe15d2ff,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:31745d72666f8a3a3a10b6e628440402,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850|865|898,TC:nil,Content:
	0|15|50,EDM:-3,IP:nil,URL:11|99|85|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4bf85b6e81c811f1aa26b74ffac11d73-20260717
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 569924405; Fri, 17 Jul 2026 18:14:29 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: ihor.solodrai@linux.dev
Cc: 13667453960@163.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	paul.chaignon@gmail.com,
	song@kernel.org,
	yijiangshan@kylinos.cn,
	yonghong.song@linux.dev
Subject: Re: Re: [PATCH] tools/resolve_btfids: fix OUTPUT leakage from kselftest causing corrupted build paths
Date: Fri, 17 Jul 2026 18:14:26 +0800
Message-Id: <20260717101426.2106635-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0ffd26d2-a5f1-4c4c-9f4a-13809f9eb94e@linux.dev>
References: <0ffd26d2-a5f1-4c4c-9f4a-13809f9eb94e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ihor Solodrai,

Thanks for the review -- you are right on both counts, and v1 is dropped.

On the nested sub-make: the `override OUTPUT :=` only changes the
variable inside the outer resolve_btfids make; it does not touch
MAKEOVERRIDES, so the nested `$(MAKE) $(build)=resolve_btfids`
(resolve_btfids/Makefile:90) still inherits the original command-line
OUTPUT through MAKEFLAGS. The pattern rules that produce the corrupted
`$(OUTPUT)%.o` paths run in that nested sub-make, so they still see the
un-slashed value. Your parent.mk/child.mk repro captures this exactly.

On bpf/hid: selftests/bpf/Makefile:440 and selftests/hid/Makefile:159
build resolve_btfids directly with
`OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/` on the command line. An
origin check cannot tell those deliberate command-line assignments apart
from a leaked one, so v1 clobbered them -- exactly the breakage you
showed. The origin is simply the wrong place to make this decision.

v2 takes the approach you suggested: drop the generic kselftest OUTPUT
at the gen_mods_dir descent in selftests/lib.mk, so it never reaches the
kernel module build (and thus resolve_btfids) as a command-line
variable:

      gen_mods_dir: MAKEOVERRIDES := $(filter-out OUTPUT=%,$(MAKEOVERRIDES))
      gen_mods_dir:
      	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)

      clean_mods_dir: MAKEOVERRIDES := $(filter-out OUTPUT=%,$(MAKEOVERRIDES))
      clean_mods_dir:
      	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean

gen_mods_dir is the only path through which kselftest's per-test OUTPUT
leaks into a kernel build (the TEST_GEN_MODS_DIR module build, which can
the other selftest sub-makes -- and the test programs that rely on
OUTPUT -- are unaffected.

With the leaked command-line OUTPUT gone, resolve_btfids is reached with
only the O= that the kernel build passes on its tools/% descent, so the
`OUTPUT := $(ABSOLUTE_O)/...` assignment in scripts/Makefile.include (a
simple assignment) wins at every make level, including the nested
`$(build)=resolve_btfids` sub-make where the pattern rules run. bpf and
hid invoke resolve_btfids directly with their own OUTPUT= and do not go
through gen_mods_dir, so they are untouched.

Tested from a clean tree:
    * kselftest build of a TEST_GEN_MODS_DIR test (mm/page_frag) with
      CONFIG_DEBUG_INFO_BTF: resolve_btfids now builds into its
      O=-derived directory; no more "mmmain.o" / missing
      resolve_btfids-in.o.
    * make -C tools/bpf/resolve_btfids
      make -C tools/bpf/resolve_btfids OUTPUT=/tmp/o/resolve_btfids/
      both still build (bpf/hid-style explicit OUTPUT= preserved).
    * make OUTPUT=/tmp/build/kcmp -C tools/testing/selftests/kcmp still
      honours OUTPUT for its own programs.

v2 posted as a separate thread.

Thanks,
Jiangshan
