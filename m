Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6E371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756742; cv=none; b=rhze94qXHIHEJ8AXQ0P0RZkqTmrx11e+UzZEQMyRA4eqq7wVozCKtGIAiiNHwTURdEvHXFttEKdgquIe91PyD90ta63by3iWiKrZomoGtB1uXz7WgNxHyc+7ERAeRzirTy/T3b0xDKaMAAKSCPD3ZtaqkXsBlRg5YFwhbBmaDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756742; c=relaxed/simple;
	bh=b8QwpXwKpqlGy4J/qnd27hacUm4HMPsBNRolM6UVwpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/2ytH1me3gmhDPsjrbbQiHal/V6bYLy4UoFVn+2G6RnwtfSXpl42AAB3Edv3o/SwQv4nQvKS8Ck544Ul8C7yx0eTB/szexV1+MKmWjsoTSLtd3FXqbYZ3U1USkWqoMwvIIAq9hMqpYJfbvHULwNFxyqHVcaQq8oHKDGoLs3IhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVVDHC1t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVVDHC1t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9201076b3so35351675ad.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756740; x=1789361540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dj5/gWxeDk47uSELqCVU9KzfoSY5+X/l8m45uFaTtlw=;
        b=XVVDHC1tq9a5zf3TUqTAtZ0WR08egxuW40W470oprYor8Cd+8dYtkeNzquH63zqWo2
         8/GslNBXIufdaAb5JtbAe+vFq98GbsHNyjlSgr/fLwxeI7tcDo+gHfp/MuK5HasU+lXT
         OyY9JGaKtDA//XBRcTpgH7SXu+6P8Vz+zmZR734dC9uMdD50As7MSrM35J17xV+I294H
         DfmmI+pDEcS+JJSn+dela7+7IhVMbM1qbu9GlKMeoy9EBBPjTddb0Kqrrq0qS7nljU91
         0/YRfutE4cIAEYaMrbkj5kvSQuiKwS24RmZIaaWanqMwE7CzJnutQkv4FJ2k/FIe+nsa
         oEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756740; x=1789361540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dj5/gWxeDk47uSELqCVU9KzfoSY5+X/l8m45uFaTtlw=;
        b=eL3co5+FI0zazMB6kYgMDuDnBBEObibyuVXJ/TRmTxz4x6iXNd37DEMfx8P20Riq2i
         mGDDraVFtSfSNf4HRw4PKxoCtJBWl4BMfzJt8y6JNzPHSCQGakGE93cMPhkfZRYVTZLp
         VKAoT8mdpqboetj/3rpjMlU6ZPcETrIJtiOp+Idcv8H9SUE9y5QSTzqWZdZFk77mgjVq
         dUp57QugqsfqwxvVA7/Qq+PYAEz8WQ3Ao77tczSoZDB5GmKerbS1mFQTNFE6R4SXUrrQ
         MP23rcRKfImsnE+i8GztRjwSYstyLAHFOLTaNqV/3K7pTHx4XPQXu5AR7vJKzkqgitoX
         HFew==
X-Gm-Message-State: AFuF++maEm8rP3WeJiG/9sAJ3GUcAsZra3hZY1D//bf0AIN58vy3odO8
	7Plqndv+Xq5WKW2xLghhDo7x0toYTT3Xnqy6HaphwTZ5pxFyKHY0OURp
X-Gm-Gg: AYBFou1SzVrNLL86apPlHzjhIH415V/2O5c+WvQI+Gg5bO5ULWY9x6E0D0w3WWMG0Uu
	5+1uNIsI5Vvn5VrHwHiBr+v3AE1KNieAp8jwbe8W/whZRcyjbSXZYhAywvvCPXBDybw1LEjtJ+/
	5zq/Q6Dj2/bnXy6NX9fliyJe67zd0VKigJC3zSu04PBRBAcF/Lg+x3Sc6AoXC7IG5syT+2Yo/E1
	/MdQhuHSG6t1JDcto/DFp9qNt6pfQqhxp5OnbokCDO9sf7NhWkrP3UHObxj0Ir8q04tVCmh4X0l
	QQfsFCCVuvV4e0ZQNj5f+G9oS+IMrDEoekgccIqXKryurnUEZy6IZ/qmUtQ94uxHwxHELF9vgv8
	mfvIv8gVZXfh1CdtnSKLWk6hcfUFnLH034Ow3FwbM2R/o4AjAJdq35BTSZp+SFouNt11Kg+PZol
	HPC3eBBK/KXkIjMNN7MEVP5rjUjhGsxZUtAKNjxZX36LMTSrp0icKpmZD5SsMi2Vg8tpPAhR1nm
	/ICV3T3ihnfBw==
X-Received: by 2002:a17:90b:1b44:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39b2613249fmr28234165a91.8.1788756740085;
        Sun, 06 Sep 2026 21:52:20 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:19 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 4/7] selftests/bpf: fix typos in comments
Date: Mon,  7 Sep 2026 10:21:32 +0530
Message-ID: <20260907045135.13317-5-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
index 1b25d5c5f8fb..8b96fb861368 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -13,7 +13,7 @@
  * IPv6 header with a Segment Routing Header, with segments :
  *	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
  *
- * 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
+ * 3 fd00::/16 IPv6 addresses are bound to seg6local End.BPF actions :
  * - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
  * - fd00::2 : remove the TLV, change the flags, add a tag
  * - fd00::3 : apply an End.T action to fd00::4, through routing table 117
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 8ae4fb2027f7..9f2971fc7cd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -243,7 +243,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		}
 
 		/*
-		 * TLD_DEFINE_KEY() is given memory upto a page while at most
+		 * TLD_DEFINE_KEY() is given memory up to a page while at most
 		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
 		 */
 		if (dyn_data) {
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
index 624078abf3de..d7e30ee576c9 100644
--- a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -7,7 +7,7 @@
 
 SEC("freplace/btf_unreliable_kprobe")
 /* context type is what BPF verifier expects for kprobe context, but target
- * program has `stuct whatever *ctx` argument, so freplace operation will be
+ * program has `struct whatever *ctx` argument, so freplace operation will be
  * rejected with the following message:
  *
  * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match btf_unreliable_kprobe(struct whatever *)
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index a63e33675091..227dea0da3a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -225,7 +225,7 @@ __naked void stack_write_priv_vs_unpriv(void)
 }
 
 /* Similar to the previous test, but this time also perform a read from the
- * address written to with a variable offet. The read is allowed, showing that,
+ * address written to with a variable offset. The read is allowed, showing that,
  * after a variable-offset write, a privileged program can read the slots that
  * were in the range of that write (even if the verifier doesn't actually know if
  * the slot being read was really written to or not.
