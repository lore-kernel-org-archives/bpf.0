Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C5213E9C;
	Tue, 23 Jun 2026 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199377; cv=none; b=dEuGbeBJdP4BaMAFc6w2JOBu5l9KHTmMxk5uesw21sqWwlk1fzjApaBHRJB2EfEuk6iy/XUhwHsRrpmqgEGzeklHBpjDU5xhzDsRHydV6BbxK0eFNOEFkaeqZ6jCSqUbw3bugOFBMqzy3aXwWwbo7WYVSq7rP0Qe+074KtfHNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199377; c=relaxed/simple;
	bh=p+NsbUAPD2op0C2ZcSvMm6lwBEKf97pmHd5xW87Tr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tldjleM8/SqVNQZgf3Nd+jY5nPx7bLlRXvMThGbITDmbMnJiX0t9szots51GnTw8HRqgagANTd+HWnR1NYgjrh4MehPkgg7LHF99PPmLpBOmtpwyBk7kq+ywirYkvNIgAoqfKySwYaaTiFxQLo/MnZKpk4dRPt84gvpwe8SLPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PTnLfCq0; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PTnLfCq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782199364;
	bh=NV+zDKWM9S6vcFQ+Yiqgw5I/JzIZn6hnpXxRjrI1ci8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PTnLfCq0ByugH/auLUxD8AGdNb2ewvpWCG4mvrZ1LJ75LH4SmRk77R+9gnzX0y4PR
	 g6KpKyOfiI7tgYuey/ac8UKZ6ZKNjcpGDSRAjLFVE6W0/ME6LMQBKOVeR6yyVh9rVl
	 JMmQZfZuvRkgA9IdIxITrd1vT6063pIfU4mThIgc=
X-QQ-mid: esmtpgz10t1782199349tf5124a9c
X-QQ-Originating-IP: ZtBmyAAONfYqyYapjx2RgDS8T4DsNuxrlVfyQN6LM7k=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 15:22:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3623930930060417575
EX-QQ-RecipientCnt: 14
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v3 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map commands
Date: Tue, 23 Jun 2026 15:22:19 +0800
Message-ID: <E2D0E58A0333B7F3+20260623072220.1421837-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260623072220.1421837-1-chenyichong@uniontech.com>
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4kN3xMDJERSV0blF6H/DMa+JBWCua4b6olzME6aGbZAeFv9UURJ5rKr
	qk6oaKF2n086fJey2szsTfflJ8LGhUoJlWiCdwx+UTvQdu6KOjZwuMhUqskYnTnRdcywxyA
	bXCdzw5DNRtyOsd15XKoTrFIYzYv2pRlT2aA9NOcZm80zakcqMstYIPhyRyuio2lbavMdyo
	xXcgJ0sZTz9CHKFvnRiZnasKlCZzKJbnwzaZAD25fiyjYEQa8/sGfjh6cWht27Ceb45ghyZ
	nLKX2HpP3oZtEWkQ4/iKq/PUCTes1Ttm1QbyKoo2A0oTFhxcGrpWOpSWWT0ks0JpUshXHzB
	dU24P6GiI8EVhT5TANvjbjc4sf/j0k0xyjFOyGS367bZCTjhR/IL50ZOP5vYxhzRFzi9Tpn
	Mb9MqwGc0MUR75ukrcf4EDwHgU/rRCdqDvkS90MnHxSxcfcqQ8tZqzyj6eEg4PtV+bS4SvY
	p2HutKWKDFfd+Qe0d5yhKWr4/QnMdvYtOBwGs/gaK6FKYQ3X2219Kgh5WomQPTYPrgtRbWq
	5lVRgSMU2wUm53uK51IT8qcQtVDCApKwmWLEdecp/SWipBe+6R6WTRrkhBS24xuu5NKLMtz
	GJdBxsMIUqrIXR9hvKqPSmOi0LDd7hIBpfPJ/aNuJo4aGKquHL7E+EdGnPTo8K9GFAld2J9
	7fafSHybwo85tKfRC37p+s7XZ3YMoNMgPhEj/Cd16NWt0HX3CzpTR/UVEgeOZoNVBnDG3VR
	z3S68EzlMgSkxO+isyMQZ3dczTbUlmo6GNtckwM9o/+TqI0UdZqmx0392+cosA4X+4jf5Ra
	c7oxX7zxpUQVNbKjDrvfIGs0YYloclMHjt23xUyt+CX8xvYynP5qDp1WoX1+jKmKxWUYxO1
	6HCfGC3L/lSD2UTEQhqVVwhjMERsWna3Y+4mTKEivuzqfM2izZyY8ktRGiGNDtxtk347t6j
	1kH+QSR6/tcARKos85GuRUgis4yObfuls7Mb2kauAyjDUfVVXGrOnGr+Qu6V3PScoyNjWPT
	D/cAYIS0qgs31l3ZEbYEwN2yqUzRfZaoj48JCDobiiie0dLDq9Xf4Cw3g++Y0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

get_map_kv_btf() caches the vmlinux BTF object when a map uses
btf_vmlinux_value_type_id. map dump released that object when the
command completed, but left the global pointer stale.

The same cached object can also be returned to print_key_value(), which
freed it directly. That leaves btf_vmlinux dangling before the command
cleanup path runs.

Use free_map_kv_btf() for per-entry cleanup, and reset the cached
btf_vmlinux pointer when the map command releases the object. This keeps
batch mode from reusing a freed BTF object.

Fixes: 4e1ea33292ff ("bpftool: Support dumping a map with btf_vmlinux_value_type_id")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/map.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..a265ad3afbb0 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
 
 static struct btf *btf_vmlinux;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+}
+
 static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
 {
 	int err = 0;
@@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
 		close(fds[i]);
 exit_free:
 	free(fds);
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 	return err;
 }
 
@@ -1049,7 +1055,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 		btf_wtr = get_btf_writer();
 		if (!btf_wtr) {
 			p_info("failed to create json writer for btf. falling back to plain output");
-			btf__free(btf);
+			free_map_kv_btf(btf);
 			btf = NULL;
 			print_entry_plain(info, key, value);
 		} else {
@@ -1065,7 +1071,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	} else {
 		print_entry_plain(info, key, value);
 	}
-	btf__free(btf);
+	free_map_kv_btf(btf);
 }
 
 static int do_lookup(int argc, char **argv)
-- 
2.51.0

