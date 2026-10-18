Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598038DC73;
	Sun, 18 Oct 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338820; cv=none; b=eAgLCeLuKoXkfhlExy+UX4LSUbb/m+rVsFeVPEOfhnE6GGlwqKt0Q8MWvskrs56XW8E8J+kDvcKXjBvGjk5xK8kQj3S8k4U3tiIbhPvjV1HP/xyfCh5uo0t5yciowRV7PUdk+jjuhSwTx3EuDH8akNmto+zPmKesjJr4X+9nhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338820; c=relaxed/simple;
	bh=A8XukIRCisIpytU8gFdVnF0OddI39Iuje5Bff1wxr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LknlRUSzjJ8CwtQ1mbvvlH8R7nJhL/kqpQUy5j/kh7hQIC3Vj4YqUu2v7r9SY33x4PNNZNWzbJk8oNMLujPgagQLz/bTFf9slE0Il4zyf2NJ7cue8VE78Qs46tvql5lUEme+SX3uL3RFc5oQY5r+UpFDEPND6NboV9Mv5ve38Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=MXTDsnjM; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="MXTDsnjM"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC4-000Id0-FS; Sun, 18 Oct 2026 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=ICcWY+pIwO2qQH7qZi0OK14NMeBzSaa/sjGTB8EYQ9s=; b=MXTDsnjMN/qs9+iCjjdUVRETAX
	UP8kQhvDdRxJKabD+CPq24y00/xz+wG6m+Q9/a57sQRDHmm0/u+L6/uFeVHlpjEYC4tzsUByYf9yq
	cMrodFFVylxlDfTHcNE7d+H0ObiCN7iAKTxCeEQYur7skPpZde479TJ2A2SwhuStFjLxvyGdrjJIN
	fQX5ttk7IZDVksrxWRgR07+OpyG/q3BxGVOD8r78vOgbV5tMrgPCzleJULhagMG6k+UpdSFP80423
	GrtrdNJvOL5dqgU25PHl2BSy5sg8UtDiVN3rwqBRJ/R17vFLdOj/yCwOfj6Rwd19zqBwGwBYGuq3r
	mC2wjQlw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBz-0001pe-5P; Sun, 18 Oct 2026 17:52:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBi-004q3U-8s;
	Sun, 18 Oct 2026 17:52:42 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 09/15] kallsyms: Add a kernel parameter for the marker shift
Date: Sun, 18 Oct 2026 16:52:00 +0100
Message-Id: <20261018155206.132411-10-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018155206.132411-1-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the default to 6 (one marker every 64 symbols).
Improves symbol lookup by name by about 35% (over an interval of 256).
Net improvement for the patch series is about 18 times.

Static data increases by a little less than 1 bit for every 2 symbols.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 init/Kconfig            | 19 +++++++++++++++++++
 scripts/link-vmlinux.sh |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..2d0716662c67 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2101,6 +2101,25 @@ config KALLSYMS
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.
 
+config KALLSYMS_MARKER_SHIFT
+	int "Interval between kallsyms markers (6 => 64, 8 => 256)"
+	depends on KALLSYMS
+	default 6
+	range 0 24
+	help
+	  Set the interval between the kallsyms marker entries as a power of 2.
+
+	  This bounds the linear search when locating the name of a symbol
+	  from its index in the array of values (and v.v.).
+
+	  Smaller values speed up the search but increase the memory footprint.
+	  Values below 5 (one 32 bit marker every 32 symbols) are unlikely to
+	  make a significant difference because other parts of the code
+	  dominate.
+
+	  The default of 6 is a reasonable compromise. It makes looking up a
+	  symbol by name around 35% faster than setting it to 8.
+
 config KALLSYMS_SELFTEST
 	bool "Test the basic functions and performance of kallsyms"
 	depends on KALLSYMS
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ab0b8125c8cb..12b119d024b4 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -37,6 +37,10 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
+value() {
+	sed -n "/^$1=/{s///;p;q}" include/config/auto.conf
+}
+
 # Nice output in kbuild format
 # Will be suppressed by "make -s"
 info()
@@ -131,6 +135,8 @@ kallsyms()
 		kallsymopt="${kallsymopt} --pc-relative"
 	fi
 
+	kallsymopt="${kallsymopt} --marker-shift=$(value CONFIG_KALLSYMS_MARKER_SHIFT)"
+
 	info KSYMS "${2}.S"
 	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
 
-- 
2.39.5

