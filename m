Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587372;
	b=tiLRvqetf5ffkidyV18LlzFN2hdGjxag32haf1suq3Dp0W81WBNxuTQRWbqVbWkFAdQn
	 w+sJ6xslrp+DcwFpGKV18xsqmQQn2Lw5ax6HRn2yW26YMMDcffxzL4aOlY26GxrDIv5eB
	 0rnF4D/NO6IdS6x6JvV4D9NKgMm7HnXmcvZCl+GNPgNWxSDoZogSEtizr8eYPi53vqtxz
	 SRSP5aveF9KKXXxn6gQqIP+PO3vlrGhwE7DCZeLH5BU7RMOD6lxn3cc00erwsRrUD6OCS
	 QHlT+pryauhShiKTjvsqb7ksUpraltOHZxfNMTvP8bswx6eFd01UFPpuDciiz2s7ACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
	b=Hq75wxJ5lBYXyuXXwXuyavu7vA870ASmC237gpo4W9fDst+SS6doD0yj9zGiHeXd7fLz
	 1WMtTJF9Bme5JDvuQEpKdSCddvgcILRszYbChhp1j4mwjKsBNabn9DfyjlDemhep/0Xvf
	 dF/CmeDbuwj23SlzGpNMNpXhmVb41ckEebPntdKSpuxPpFa7d8uD+Ot4rJu87IJU79vGh
	 R0DEEDAaMvzjeCOvADZEb9fSFilUkx2t9a3YHIJcp5/AcVBBmUe885me0TmkVER+Hgged
	 TaxdP8NvKd/Jd0oQXPASO7+gUlSX9sommmqwNU/oOFiSXJsTnIMICnbLGQ4nN5f3YVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Db/cRPFL";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF860A2614
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAF860A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Db/cRPFL
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386b8624cf7so555040eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587371; x=1796192171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
        b=Db/cRPFLfYVCp+2GdQfozLgX7xQ22/ZFmmU+8ONn0ztqKNHD5GQP6wLynJKPPmdp9v
         CjY4/zp3pIGiflimiES3q8iGcr0M9XMEu9XRaXQY1lXYRJ14v0lU/NxPyl3FNsagDWsm
         meKiuP4xhYuX5egFh4+zDmRCql+CDY3MNDoZ2Vjuom3u46bjoTR/E4w4/qkQ6ljAvVBC
         hvgS0Ll/7G0ispHlE9t1ZSd3RQtHvUMXRWroFpGoP5AjRsRc6A+psnQojtxX+CIgFxNl
         d7rElfx3LYYsCEoXoomSKrJg9l0SUi1X9vw9lifNDMMI6qq86Rpbqhqk3PDRLQoncrjp
         BmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587371; x=1796192171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
        b=0IX3nMfiH6l0eUJKejB2PntGQab2yFU9drL8AYAgkNEPvzzIib3l2LrJnR6+Hofp/7
         tQlgRX6SnyYIUXJY0M8suYqQhw5+9UcyjLRXhE6bsCxtpg7xDSx/t2QpKjnC0psJvqAw
         0/BYU+CDXUwllPVOzlfDBG4q032OiKimukgd2XSrd02Otuu1ZNy7RzIO8kK0sgfGeYoK
         KczGR2rSLo4r8xLlXPfVYoWFlChq1EUKoEKSZu1QjGKhvIIG7WZ4cSuC1o7uGFx4s/5z
         MY7EEwkIGXAZna5KcvpYaAqgO5fAm2kPkv9LjMzIJZnkMfhuahaFs6dxl+FTdbcktI/n
         Vhrg==
X-Forwarded-Encrypted: i=1; AL+hErGl7/V9bxnI83hRw3LgOyjJcXrUPVCxoeuQdRSK09qVxFgs4RVZASXT8tuvJxNR/ot+3Es=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2hLq1Tqg9TDvGehvjf01fH9Otsjgd8vcUCe7QfetaDnl5LPV7
	YZhdB4aWFHneeQe6C/TbWrHoKQFZyAEjGIssaAjxLlaG6aeOF1SxyQzOV3IS1MaZXrMu9D+z46p
	BTlVI90f6kw==
X-Received: from dybou2.prod.google.com ([2002:a05:7300:e5c2:b0:384:c70c:3c65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:269e:b0:376:5b99:a816
 with SMTP id 5a478bee46e88-3856c2c3fb4mr17120337eec.3.1795587370674; Tue, 24
 Nov 2026 22:16:10 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:00 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-8-irogers@google.com>
Subject: [RFC PATCH v2 07/30] objtool/ibt: Ignore .eh_frame relocations during
 ENDBR validation
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When vmlinux.o is built with -fasynchronous-unwind-tables and
CONFIG_X86_KERNEL_IBT=y, .eh_frame FDE headers contain PC-relative
relocations referencing function start addresses across .text. Because
.eh_frame is read-only unwind metadata rather than executable code or
indirect branch targets, skip .eh_frame* sections during objtool's IBT
relocation validation alongside .orc_unwind_ip and DWARF .debug_*
sections.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 931c5c412f15..e631b0da9bad 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4644,6 +4644,7 @@ static int validate_ibt(struct objtool_file *file)
 		if ((!strncmp(sec->name, ".discard", 8) &&
 		     strcmp(sec->name, ".discard.ibt_endbr_noseal"))	||
 		    !strncmp(sec->name, ".debug", 6)			||
+		    !strncmp(sec->name, ".eh_frame", 9)			||
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
 		    !strcmp(sec->name, ".kcfi_traps")			||
-- 
2.56.1.831.g720f3f5937-goog

